package com.zzhdsoft.utils.db;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Vector;

import com.zzhdsoft.utils.StringHelper;
import org.apache.log4j.Logger;
import org.nutz.dao.ConnCallback;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.utils.Base64;

@IocBean
public class ProcedureUtil {
	private static final Logger log = Logger.getLogger(ProcedureUtil.class);
	@Inject
	protected Dao dao;

	protected LinkedHashMap parameters; // 传入传出的参数值,方式1,按哈希表(参数名),存入时转为小写
	protected LinkedHashMap resultHash; // 返回出参结果
	protected int code; // 存储过程执行后返回的,-1=失败，1=成功 HashMap 2=成功 结果集
	protected String msg;// 返回执行后消息，和code相配合使用
	protected String name;// 存储过程名
	protected Vector resultSets; // 返回的结果集

	public ProcedureUtil() {
	}

	public ProcedureUtil(String procedurename, LinkedHashMap paraValues) {
		init(procedurename, paraValues);
	}

	/**
	 * 
	 * init的中文名称：存储过程参数初始化
	 * 
	 * init的概要说明：
	 * 
	 * @param procedurename
	 * @param paraValues
	 *            Written by : zjf
	 * 
	 */
	public void init(String procedurename, LinkedHashMap paraValues) {
		setName(procedurename);
		setParameters(paraValues);
	}

	/**
	 * 
	 * getProcedureParams的中文名称：取存储过程中的所有参数列表
	 * 
	 * getProcedureParams的概要说明：
	 * 
	 * @param procedure_name
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	private Vector getProcedureParams(final String procedure_name)
			throws Exception {
		final Map err = new HashMap();
		final Vector vec = new Vector();

		dao.run(new ConnCallback() {
			public void invoke(Connection conn) throws Exception {
				try {
					if (conn == null) {
						return;
					}
					// 用户名
					String TABLE_SCHEM = conn.getMetaData().getUserName();
					String pname = procedure_name;
					int pos = pname.indexOf("."); // 带包的
					if (pos > 0) {
						pname = pname.substring(pos + 1);// 带包的
					}
					ResultSet rs = conn.getMetaData().getProcedureColumns(null,
							TABLE_SCHEM, pname.toUpperCase(), "%");

					while (rs.next()) {
						/*
						 * ResultSet 中的每个行都是带以下字段的参数描述或列描述：
						 * 
						 * PROCEDURE_CAT String => 过程类别（可为 null） PROCEDURE_SCHEM
						 * String => 过程模式（可为 null） PROCEDURE_NAME String => 过程名称
						 * COLUMN_NAME String => 列/参数名称 COLUMN_TYPE Short =>
						 * 列/参数的种类： procedureColumnUnknown - 没人知道
						 * procedureColumnIn - IN 参数 procedureColumnInOut -
						 * INOUT 参数 procedureColumnOut - OUT 参数
						 * procedureColumnReturn - 过程返回值 procedureColumnResult -
						 * ResultSet 中的结果列 DATA_TYPE int => 来自 java.sql.Types 的
						 * SQL 类型 TYPE_NAME String => SQL 类型名称，对于 UDT
						 * 类型，类型名称是完全限定的 NULLABLE short => 是否可以包含 NULL。
						 * procedureNoNulls - 不允许使用 NULL 值 procedureNullable -
						 * 允许使用 NULL 值 procedureNullableUnknown - 不知道是否可使用 null
						 * REMARKS String => 描述参数/列的注释
						 */

						String column_name = rs.getString("column_name");
						LinkedHashMap paraminfo = new LinkedHashMap();
						paraminfo.put("column_name", column_name.toLowerCase());
						int column_type = rs.getInt("column_type");
						if (column_type == java.sql.DatabaseMetaData.procedureColumnIn)
							paraminfo.put("column_type", "IN");
						else if (column_type == java.sql.DatabaseMetaData.procedureColumnOut)
							paraminfo.put("column_type", "OUT");
						else if (column_type == java.sql.DatabaseMetaData.procedureColumnInOut)
							paraminfo.put("column_type", "INOUT");
						else
							paraminfo.put("column_type", "UNKNOWN");
						int data_type = rs.getInt("data_type"); // java.sql.Types的
						// SQL 类型
						paraminfo.put("data_type", String.valueOf(data_type));
						String data_type_name = rs.getString("type_name"); // SQL类型名称
						paraminfo.put("type_name", data_type_name);
						if (column_name != null) {
							vec.add(paraminfo);
						}
					}

					try {
						rs.close();// 关闭数据集,无需处理异常
					} catch (Exception eers) {
						//
					}
				} catch (Exception e) {
					err.put(GlobalNames.EXCEPTION_KEY, e.getMessage());
				}
			}
		});

		// 把异常的真实原因抛出
		if (err.get(GlobalNames.EXCEPTION_KEY) != null) {
			throw new Exception(err.get(GlobalNames.EXCEPTION_KEY).toString());
		}
		return vec;

	}

	/**
	 * 
	 * makeCallSQL的中文名称：生成JDBC调用存储过程的语句
	 * 
	 * makeCallSQL的概要说明：
	 * 
	 * @param paramsize
	 * @return Written by : zjf
	 * 
	 */
	private String makeCallSQL(int paramsize) {
		if (!this.isValidString(getName())) {
			log.error("存储过程名称不能为空!");
		}
		StringBuffer sCmd = new StringBuffer();
		sCmd.append("{ ");
		sCmd.append("call ");
		sCmd.append(getFullName().toUpperCase()); // 采用参数索引号的方式传入参数
		if (paramsize > 0) {
			sCmd.append("(");
			for (int i = 0; i < paramsize; i++) {
				sCmd.append("?" + (i >= paramsize - 1 ? ")" : ","));
			}
		}

		sCmd.append(" }");
		return sCmd.toString();
	}

	/**
	 * 
	 * getFullName的中文名称：取存储过程含包名的全称
	 * 
	 * getFullName的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public String getFullName() {
		return name;
	}

	/**
	 * 
	 * isValidString的中文名称：判断字符串是否为空为为空格
	 * 
	 * isValidString的概要说明：
	 * 
	 * @param s
	 * @return Written by : zjf
	 * 
	 */
	private boolean isValidString(String s) {
		return s != null && s.trim().length() != 0;
	}

	public String getName() {
		if (name != null && name.lastIndexOf(".") > -1)
			return name.substring(name.lastIndexOf(".") + 1);
		else
			return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LinkedHashMap getParameters() {
		return parameters;
	}

	public void setParameters(LinkedHashMap parameters) {
		this.parameters = parameters;
	}

	/**
	 * 取存储过程输出返回参数
	 */
	public LinkedHashMap getOutParameters() {
		return this.resultHash;
	}

	/**
	 * 
	 * execute的中文名称：执行存储过程（1=成功 HashMap；2=成功 结果集）
	 * 
	 * execute的概要说明：
	 * 
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public void execute() throws Exception {
		final Map err = new HashMap();
		dao.run(new ConnCallback() {
			public void invoke(Connection conn) throws Exception {
				try {
					resultHash = new LinkedHashMap(); // 返回结果信息
					if (conn == null) {
						throw new Exception("数据库未连接!");
					}

					Vector paramsDefine = getProcedureParams(getFullName());
					if (paramsDefine.size() < 1) {
						throw new Exception("错误：没有取到存储过程的信息!");
					}
					String sql = makeCallSQL(paramsDefine.size());
					log.info("myProcedure :" + sql);

					CallableStatement callStmt = conn.prepareCall(sql);

					// 对输入参数进行处理
					for (int i = 0; i < paramsDefine.size(); i++) {
						LinkedHashMap pi = (LinkedHashMap) paramsDefine
								.elementAt(i);
						String column_name = pi.get("column_name").toString()
								.toLowerCase(); // 参数名
						String paramName = column_name;
						String column_type = pi.get("column_type").toString(); // 参数类型：输入、输出
						int data_type = Integer.parseInt((String) pi
								.get("data_type"));// 参数的数据类型
						if ("IN".equals(column_type)
								|| "INOUT".equals(column_type)
								|| "UNKNOWN".equals(column_type)) { // 输入

							if (parameters.get(paramName) == null) {
								callStmt.setNull(i + 1, data_type);
							} else if (data_type == Types.TIMESTAMP
									|| data_type == Types.DATE
									|| data_type == Types.TIME) { // 日期特殊处理
								callStmt.setDate(i + 1, PubFunc
										.getSqlDate((String) parameters
												.get(paramName)));
							} else {
								// 默认按字符串处理
								callStmt.setString(i + 1, (String) parameters
										.get(paramName));
							}
						}

						if ("OUT".equals(column_type)
								|| "INOUT".equals(column_type)) { // 输出
							if (1111 == data_type) {// 游标
								callStmt.registerOutParameter(i + 1,
										oracle.jdbc.OracleTypes.CURSOR);
							} else {
								callStmt.registerOutParameter(i + 1, data_type); // 数据类型
							}
						}
					}

					callStmt.execute(); // 正常执行

					// 对输出参数进行处理
					for (int i = 0; i < paramsDefine.size(); i++) {
						LinkedHashMap pi = (LinkedHashMap) paramsDefine
								.elementAt(i);
						String column_name = PubFunc.toString(pi
								.get("column_name")); // 参数名
						String column_type = (String) pi.get("column_type"); // 参数类型：输入、输出
						int data_type = Integer.parseInt((String) pi
								.get("data_type"));// 参数的数据类型
						if ("OUT".equals(column_type)
								|| "INOUT".equals(column_type)) { // 输出
							try {
								Object retParam = null;
								if (data_type == 1111) { // oracle.jdbc.OracleTypes.CURSOR
									ResultSet rs_ret = (ResultSet) callStmt
											.getObject(i + 1);
									if (rs_ret != null) {
										retParam = openResultSet(rs_ret);
										resultHash.put("ResultSet", retParam); // 当为结果集时,只支持同时有一个结果集
									}
									try {
										rs_ret.close();// 关闭数据集,无需处理异常
									} catch (Exception e) {
										//
									}
								} else { // 默认按字符串处理
									retParam = callStmt.getString(i + 1);
									if (retParam != null)
										resultHash.put(column_name, retParam);
									else
										resultHash.put(column_name, "");
								}
							} catch (Exception e) {
								throw new Exception("存储过程输出参数转换出错!"
										+ e.getMessage());
							}
						}
					}
				} catch (Exception e) {
					err.put(GlobalNames.EXCEPTION_KEY, e.getMessage());
				}
			}

		});

		// 把异常的真实原因抛出
		if (err.get(GlobalNames.EXCEPTION_KEY) != null) {
			throw new Exception(err.get(GlobalNames.EXCEPTION_KEY).toString());
		}
	}

	/**
	 * 
	 * openResultSet的中文名称：把执行过的ResultSet转到Vector中并释放数据库连接
	 * 
	 * openResultSet的概要说明：返回LinkedHashMap记录
	 * 
	 * @param rs
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Vector openResultSet(ResultSet rs) throws Exception {
		int rowcount = 0;
		Vector vec = new Vector();

		try {
			ResultSetMetaData rsmt = rs.getMetaData();

			int ColumnCount = rsmt.getColumnCount();
			// CLOB类型特殊处理,DATE特殊处理。
			int[] curFieldType = new int[ColumnCount];
			String[] curFieldName = new String[ColumnCount];
			for (int i = 0; i < ColumnCount; i++) {
				String ctype = rsmt.getColumnTypeName(i + 1).toLowerCase();
				// curFieldName[i] = rsmt.getColumnName(i +
				// 1).toLowerCase();//字段名
				curFieldName[i] = StringHelper.replaceUnderlineAndfirstToUpper(rsmt.getColumnLabel(i + 1).toLowerCase(),"_");// 字段别名
				// 重复字段名加"_1"
				if (PubFunc.inStr(curFieldName, curFieldName[i], i))
					curFieldName[i] = curFieldName[i] + "_1";
				if (ctype.equalsIgnoreCase("clob"))
					curFieldType[i] = 3;
				else if (ctype.equalsIgnoreCase("date"))
					curFieldType[i] = 1;
				else if (ctype.equalsIgnoreCase("datetime"))
					curFieldType[i] = 2;
				else if (ctype.equalsIgnoreCase("IMAGE"))
					curFieldType[i] = -1;
				else if (ctype.equalsIgnoreCase("BLOB")
						|| ctype.equalsIgnoreCase("LONGBLOB"))// zjf
					// add[longblob兼容mysql]
					curFieldType[i] = -2;
				else
					curFieldType[i] = 0;
			}

			while (rs.next()) {
				rowcount++;
				LinkedHashMap arr = new LinkedHashMap();
				for (int i = 0; i < ColumnCount; i++) {
					if (curFieldType[i] == -2) { // blob
						Blob blob = rs.getBlob(i + 1);
						if (blob == null || blob.length() <= 0) {
							arr.put(curFieldName[i], "");
						} else {
							// 处理blob字段的数据zjf----begin
							InputStream inStream = blob.getBinaryStream();
							byte b[] = new byte[(int) blob.length()];
							inStream.read(b);
							inStream.close();
							String blobStr = Base64.byteArrayToBase64(b);
							arr.put(curFieldName[i], blobStr);
							// 处理blob字段的数据zjf----end
							// arr.put(curFieldName[i], "BLOB");
						}
					} else if (curFieldType[i] == -1) { // image
						arr.put(curFieldName[i], "");
						if (rs.getBinaryStream(i + 1) == null) {
							arr.put(curFieldName[i], "");
						} else {
							arr.put(curFieldName[i], "[IMAGE]");
						}
					} else if (curFieldType[i] == 3) { // CLOB
						Clob clob = rs.getClob(i + 1);
						if (clob == null || clob.length() == 0) {
							arr.put(curFieldName[i], "");
						} else {
							arr.put(curFieldName[i], clob.getSubString(1,
									(int) clob.length()));
						}
					} else if (curFieldType[i] == 1) { // DATE
						arr.put(curFieldName[i], PubFunc.nullToStr(PubFunc
								.getDateStr(rs.getDate(i + 1))));// yyyy-mm-dd
					} else if (curFieldType[i] == 2) { // DATETIME
						arr.put(curFieldName[i], PubFunc.nullToStr(PubFunc
								.getDate(rs.getTimestamp(i + 1))));// yyyy-mm-ddhh:mm:ss
					} else {
						arr.put(curFieldName[i], rs.getString(i + 1));
					}
				}
				vec.addElement(arr);
			}

		} catch (Exception e) {
			msg = "读取数据出错:" + e.getMessage();
			log.error(msg);
			throw e;
		}
		return vec;
	}

	public LinkedHashMap getResultHash() {
		return resultHash;
	}

	public Vector getResultSets() {
		return resultSets;
	}

	/*
	 * 对照表
	 * 
	 * SQL类型 JDBC型 標準Java型 Oracle拡張機能Java型 -------------- 標準JDBC 1.0型:
	 * -------------- -------------- CHAR java.sql.Types.CHAR java.lang.String
	 * oracle.sql.CHAR VARCHAR2 java.sql.Types.VARCHAR java.lang.String
	 * oracle.sql.CHAR LONG java.sql.Types.LONGVARCHAR java.lang.String
	 * oracle.sql.CHAR NUMBER java.sql.Types.NUMERIC java.math.BigDecimal
	 * oracle.sql.NUMBER NUMBER java.sql.Types.DECIMAL java.math.BigDecimal
	 * oracle.sql.NUMBER NUMBER java.sql.Types.BIT boolean oracle.sql.NUMBER
	 * NUMBER java.sql.Types.TINYINT byte oracle.sql.NUMBER NUMBER
	 * java.sql.Types.SMALLINT short oracle.sql.NUMBER NUMBER
	 * java.sql.Types.INTEGER int oracle.sql.NUMBER NUMBER java.sql.Types.BIGINT
	 * long oracle.sql.NUMBER NUMBER java.sql.Types.REAL float oracle.sql.NUMBER
	 * NUMBER java.sql.Types.FLOAT double oracle.sql.NUMBER NUMBER
	 * java.sql.Types.DOUBLE double oracle.sql.NUMBER RAW java.sql.Types.BINARY
	 * byte[] oracle.sql.RAW RAW java.sql.Types.VARBINARY byte[] oracle.sql.RAW
	 * LONGRAW java.sql.Types.LONGVARBINARY byte[] oracle.sql.RAW DATE
	 * java.sql.Types.DATE java.sql.Date oracle.sql.DATE DATE
	 * java.sql.Types.TIME java.sql.Time oracle.sql.DATE TIMESTAMP
	 * java.sql.Types.TIMESTAMP javal.sql.Timestamp oracle.sql.TIMESTAMP
	 * -------------- 標準JDBC 2.0型: -------------- -------------- BLOB
	 * java.sql.Types.BLOB java.sql.Blob oracle.sql.BLOB CLOB
	 * java.sql.Types.CLOB java.sql.Clob oracle.sql.CLOB java.sql.Types.STRUCT
	 * java.sql.Struct oracle.sql.STRUCT java.sql.Types.REF java.sql.Ref
	 * oracle.sql.REF java.sql.Types.ARRAY java.sql.Array oracle.sql.ARRAY
	 * -------------- Oracle拡張機能: -------------- -------------- BFILE
	 * oracle.jdbc.OracleTypes.BFILE N/A oracle.sql.BFILE ROWID
	 * oracle.jdbc.OracleTypes.ROWID N/A oracle.sql.ROWID REF CURSOR
	 * oracle.jdbc.OracleTypes.CURSOR java.sql.ResultSet
	 * oracle.jdbc.OracleResultSet TIMESTAMP oracle.jdbc.OracleTypes.TIMESTAMP
	 * java.sql.Timestamp oracle.sql.TIMESTAMP TIMESTAMP WITH TIME ZONE
	 * oracle.jdbc.OracleTypes.TIMESTAMPTZ java.sql.Timestamp
	 * oracle.sql.TIMESTAMPTZ TIMESTAMP WITH LOCAL TIME ZONE
	 * oracle.jdbc.OracleTypes.TIMESTAMPLTZ java.sql.Timestamp
	 * oracle.sql.TIMESTAMPLTZ
	 */
}
