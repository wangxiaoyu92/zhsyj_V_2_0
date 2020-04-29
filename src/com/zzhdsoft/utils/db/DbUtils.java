package com.zzhdsoft.utils.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.lbs.util.StringUtils;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.StringHelper;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mapl.Mapl;
import org.nutz.mvc.Mvcs;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.zzhdsoft.siweb.service.DataServiceImpl;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * DbUtils的中文名称：扩展nutz框架尚未实现的部分数据库功能
 * 
 * DbUtils的描述：
 * 
 * Written by : zjf
 */
@IocBean
public class DbUtils {
	/**
	 * 
	 * getOneValue的中文名称：取查询的首行第一个值
	 * 
	 * getOneValue的概要说明：
	 * 
	 * @param dao
	 * @param str_sql
	 * @return Written by : zjf
	 * 
	 */
	public static String getOneValue(Dao dao, String str_sql) {
		Sql sql = Sqls.create(str_sql);
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql)
					throws SQLException {
				List list = new LinkedList<String>();
				while (rs.next()) {
					list.add(rs.getString(1));
				}
				if (list != null && list.size() > 0) {
					return String.valueOf(list.get(0));
				}
				return null;
			}
		});
		dao.execute(sql);
		return sql.getString();
	}

	/**
	 * 
	 * getSeqValue的中文名称：取序列值
	 * 
	 * getSeqValue的概要说明：
	 * 
	 * @param dao
	 * @param sequenceName
	 * @return Written by : zjf
	 * 
	 */
	public static Long getSeqValue(Dao dao, String sequenceName) {
		StringBuffer sb = new StringBuffer();
		String db_type = GlobalNameS.DATABASE;
		if ("oracle".equalsIgnoreCase(db_type)) {
			sb.append("select to_char(").append(sequenceName).append(
					".nextval) as id from dual");
		} else if ("mysql".equalsIgnoreCase(db_type)) {
			sb.append("select nextval('").append(sequenceName).append(
					"') as id");
		}

		String sqlString = sb.toString();
		String rtn = getOneValue(dao, sqlString);
		return Long.valueOf(rtn);
	}

	/**
	 * 
	 * getSequenceL的中文名称：获取序列值(long序列用这个)
	 * 
	 * getSequenceL的概要说明:
	 * 
	 * @param sequenceName
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static Long getSequenceL(final String sequenceName) throws Exception {
		StringBuffer sb = new StringBuffer();
		String db_type = GlobalNameS.DATABASE;
		if ("oracle".equalsIgnoreCase(db_type)) {
			sb.append("select to_char(").append(sequenceName).append(
					".nextval) as id from dual");
		} else if ("mysql".equalsIgnoreCase(db_type)) {
			sb.append("select nextval('").append(sequenceName).append(
					"') as id");
		}

		String sql = sb.toString();
		Map m = DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		Long sqLong = Long.valueOf((String) p.get("id"));
		return sqLong;
	}

	/**
	 * 
	 * getSequenceStr的中文名称：获取序列值(varchar序列用这个)
	 * 
	 * getSequenceStr的概要说明:
	 * 
	 * @param
	 * @return Written by : zjf
	 * 
	 */
	public static String getSequenceStr() {
		String v_ymd = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		v_ymd = sdf.format(System.currentTimeMillis());
		Random ra = new Random();
		String v_random = String.valueOf(ra.nextInt(100000000));
		v_random = v_random + "00000000";
		v_random = v_random.substring(0, 8);
		v_ymd = v_ymd + v_random;
		return v_ymd;
	}

	/**
	 * 
	 * getDataList的中文名称：获取数据列表（不分页）
	 * 
	 * getDataList的概要说明：
	 * 
	 * @param sql
	 *            SQL语句
	 * @param clazz
	 *            类对象
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static List getDataList(final String sql, Class clazz)
			throws Exception {
		Map m = DataQuery(GlobalNames.sql, sql, null, clazz);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * getDataList的中文名称：获取数据列表(支持分页)
	 * 
	 * getDataList的概要说明：
	 * 
	 * @param sql
	 *            SQL语句
	 * @param clazz
	 *            类对象
	 * @param pageNum
	 *            第几页
	 * @param pageSize
	 *            每页记录数
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static List getDataList(final String sql, Class clazz, int pageNum,
			int pageSize) throws Exception {
		Map m = null;
		if (pageNum > 0 && pageSize > 0) {// 有分页需求
			m = DataQuery(GlobalNames.sql, sql, null, clazz, pageNum, pageSize);
		} else {
			m = DataQuery(GlobalNames.sql, sql, null, clazz);
		}
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public static String prepareSql(String sql){
		/**
		 *
		 输入 "@@" 表示一个 '@'
		 输入 "$$$$" 表示一个 '$'
		 */
		if(StringUtils.isNotEmpty(sql)){
			sql = PubFunc.replace(sql,"@","@@");
			sql = PubFunc.replace(sql,"$","$$");
		}
		return sql;
	}

	/**
	 * 
	 * DataQuery的中文名称：内网数据库查询接口（不分页）
	 * 
	 * DataQuery的概要说明:
	 * 
	 * @param t
	 *            查询类型：SQL/PROC
	 * @param sql
	 *            查询语句&存储过程名称
	 * @param param
	 *            存储过程的入参map(查询语句此参数为空)
	 * @param clazz
	 *            返回数据集的类型(如果返回结果不是list，此参数为空即可。)
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	@SuppressWarnings("unchecked")
	public static Map DataQuery(final String t, final String sql,
			final Map param, Class clazz) throws Exception {
		try {
			String sp;
			if (null == param) {
				sp = "{}";
			} else {
				sp = Json.toJson(param);
			}

			// 核心查询功能
			DataServiceImpl ps = Mvcs.ctx().getDefaultIoc().get(
					DataServiceImpl.class);
			String tempSql = sql;
			tempSql = prepareSql(tempSql);
			String res = ps.execSQL(t, tempSql, sp);

			// 组装返回对象
			ResultDTO dto = Json.fromJson(ResultDTO.class, res);
			List trueObjList = new Vector();
			List list = dto.getResult();

			LinkedHashMap map = (LinkedHashMap) list.get(0);
			if (null != map.get(GlobalNames.SI_RESULTSET) && clazz != null) {
				List al = (List) map.get(GlobalNames.SI_RESULTSET);
				int size = al.size();
				for (int i = 0; i < size; i++) {
					trueObjList.add(Mapl.maplistToObj(al.get(i), clazz));// 注意类型转换
					// zjf
				}
				map.put(GlobalNames.SI_RESULTSET, trueObjList);
			}
			map.put(GlobalNames.SI_MSG, dto.getMsg());
			map.put(GlobalNames.SI_CODE, dto.getCode());
			map.put(GlobalNames.SI_TOTALROWNUM, dto.getRecnum());			
			
			map.put(GlobalNames.SI_ROWS, map.get(GlobalNames.SI_RESULTSET));
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("查询数据异常!" + e.getMessage());
		}
	}

	/**
	 * 
	 * DataQuery的中文名称：内网数据库查询接口（支持分页）
	 * 
	 * DataQuery的概要说明:
	 * 
	 * @param t
	 *            查询类型：SQL/PROC
	 * @param sql
	 *            查询语句&存储过程名称
	 * @param param
	 *            存储过程的入参map(查询语句此参数为空)
	 * @param clazz
	 *            返回数据集的类型(如果返回结果不是list，此参数为空即可。)
	 * @param pageNum
	 *            分页：页码
	 * @param pageSize
	 *            分页：页记录数
	 * @return 返回Map类型出参
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	public static Map DataQuery(final String t, final String sql,
			final Map param, Class clazz, int pageNum, int pageSize)
			throws Exception {
		Map res = null;
		if (pageNum > 0 && pageSize > 0) {// 有分页需求
			// 构造分页语句
			String ls_sql = packageSql(pageNum, pageSize, sql);

			res = DataQuery(t, ls_sql, param, clazz);

			// 再计算总记录数
			String sqlrn = "SELECT count(*) as rn FROM(" + sql + ") h";
			Map p = DataQuery(t, sqlrn, null, null);
			List ls = (List) p.get(GlobalNames.SI_RESULTSET);
			Map p2 = (Map) ls.get(0);

			res.put(GlobalNames.SI_TOTALROWNUM, p2.get("rn"));
			
			//兼容网站新闻分页需求
			res.put(GlobalNames.SI_CURRPAGE, pageNum);
			res.put(GlobalNames.SI_PAGESIZE, pageSize);
			int total = PubFunc.parseInt(res.get(GlobalNames.SI_TOTALROWNUM));
			int totalPage = total % pageSize == 0 ? total / pageSize
					: total / pageSize + 1;
			res.put(GlobalNames.SI_TOTALPAGE, totalPage);
			
		} else {
			res = DataQuery(t, sql, param, clazz);			
		}
		return res;
	}
	
	/**
	 * 
	 * DataQueryGrant的中文名称：内网数据库查询接口（支持分页）
	 * 
	 * DataQueryGrant的概要说明：权限过滤查询（手机接口无法从后台获取sysuser,所以userid不能为空；） 
	 * 
	 * @param t
	 *            查询类型：SQL/PROC
	 * @param sql
	 *            查询语句&存储过程名称
	 * @param param
	 *            存储过程的入参map(查询语句此参数为空)
	 * @param clazz
	 *            返回数据集的类型(如果返回结果不是list，此参数为空即可。)
	 * @param pageNum
	 *            分页：页码
	 * @param pageSize
	 *            分页：页记录数
	 * @return 返回Map类型出参
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static Map DataQueryGrant(final String t, final String sql,
			final Map param, Class clazz, int pageNum, int pageSize,String userid,String grantStr)
			throws Exception {
		String v_userkind="all";//gu20170503add userkind=6的企业虚拟用户 不走权限过滤
		String v_selfcomflag="0";//是否只能查看自己监管的企业0否1是
		//zjf注释：手机接口无法从后台获取sysuser,所以参数userid不能去掉； 
		Sysuser userCurrent=null;
		if("".equals(StringHelper.showNull2Empty(userid))){
			userCurrent= SysmanageUtil.getSysuser();			
			if (userCurrent!=null){
				userid = userCurrent.getUserid();
			}else{
				throw new BusinessException("根据权限查询时用户ID不能为空！");
			}
		}else{
			userCurrent=SysmanageUtil.g_getGlobalSysUser(userid);
		};
		
		v_userkind=userCurrent.getUserkind();
		v_selfcomflag=userCurrent.getSelfcomflag();
		
		String v_sql="select ttt.* from ("+sql+") ttt where 1=1 ";
		if(PubFunc.inStr(grantStr, "aaa027") && !"6".equals(v_userkind)){
			if ("1".equals(SysmanageUtil.g_UseAaa027Grant)){
				v_sql+=" and exists (select 1 from sysuserarea bbb where bbb.aaa027=ttt.aaa027 and bbb.userid='"+userid+"') ";
			};
		}
		if(PubFunc.inStr(grantStr, "aae140") && !"6".equals(v_userkind)){
//			if ("1".equals(SysmanageUtil.g_UseAae140Grant)){
//				v_sql+=" and exists (select 1 from sysuseraae aaa where aaa.aae140 =ttt.comdalei and aaa.userid='"+userid+"') ";
//			};
			if ("1".equals(SysmanageUtil.g_UseAae140Grant)){
			    v_sql+=" and exists (select 1 from sysuseraae aaa where aaa.aae140 in (select pp.comdalei from pcompanycomdalei pp where pp.comid=ttt.comid) and aaa.userid='"+userid+"') ";
		    };			
		}
		if(PubFunc.inStr(grantStr, "comdalei") && !"6".equals(v_userkind)){
			if ("1".equals(SysmanageUtil.g_UseAae140Grant)){
				v_sql+=" and exists (select 1 from sysuseraae aaa where aaa.aae140 =ttt.comdalei and aaa.userid='"+userid+"') ";
			};		
		}		
		if(PubFunc.inStr(grantStr, "orgid") && !"6".equals(v_userkind)){
			if ("1".equals(SysmanageUtil.g_UseUserOrgGrant)){
				v_sql+=" and exists (select 1 from sysuserorg ccc where ccc.orgid=ttt.orgid and ccc.userid='"+userid+"') ";
			};
		}; 
		//gu20170914 add  根据企业基本信息增加的日常监督管理员 和 用户基本信息表selfcomflag 判断该操作员可以
		//操作的企业
		if(PubFunc.inStr(grantStr, "usercom") && "1".equals(v_selfcomflag)){//是否只能查看自己监管的企业0否1是
		   v_sql+=" and exists (select 1 from pcomrcjdglry eee where eee.comid=ttt.comid and eee.userid='"+userid+"') ";
		}; 		
		
		System.out.println("grantSql---------- "+v_sql);
		Map res = null;
		if (pageNum > 0 && pageSize > 0) {// 有分页需求
			// 构造分页语句
			String ls_sql = packageSql(pageNum, pageSize, v_sql);
			System.out.println("grantgrantgrantgrant "+ls_sql);
			res = DataQuery(t, ls_sql, param, clazz);

			// 再计算总记录数
			String sqlrn = "SELECT count(*) as rn FROM(" + v_sql + ") h";
			Map p = DataQuery(t, sqlrn, null, null);
			List ls = (List) p.get(GlobalNames.SI_RESULTSET);
			Map p2 = (Map) ls.get(0);

			res.put(GlobalNames.SI_TOTALROWNUM, p2.get("rn"));

		} else {
			res = DataQuery(t, v_sql, param, clazz);
		}
		return res;
	}	

	/**
	 * 
	 * convertOracleSql2Mysql的中文名称：把oracle的查询语句转换成mysql的查询语句
	 * 
	 * convertOracleSql2Mysql的概要说明：去掉ORACLE语句中的to_char(news_tjsj,'yyyy-mm-dd')
	 * 
	 * @param ls_sql
	 * @return Written by : zjf
	 * 
	 */
	public static String convertOracleSql2Mysql(String ls_sql) {
		Pattern wp = null;
		if (ls_sql.indexOf(" as ") > 0) {
			wp = Pattern.compile("to_char.*?'\\).*?as ",
					Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
		} else {
			wp = Pattern.compile("to_char.*?'\\)", Pattern.CASE_INSENSITIVE
					| Pattern.DOTALL);
		}
		Matcher m = wp.matcher(ls_sql);
		String result = m.replaceAll("");
		return result;
	}

	/**
	 * 
	 * packageSql的中文名称：构造分页查询语句
	 * 
	 * packageSql的概要说明：
	 * 
	 * @param pageNum
	 * @param pageSize
	 * @param sql
	 * @return Written by : zjf
	 * 
	 */
	public static String packageSql(int pageNum, int pageSize, String sql) {
		int begin = pageSize * (pageNum - 1);
		int end = 0;
		String ls_sql = "";

		String db_type = GlobalNameS.DATABASE;
		if ("oracle".equalsIgnoreCase(db_type)) {
			end = begin + pageSize;
			ls_sql = packageSqlForOracle(begin, end, sql);
		}
		if ("mysql".equalsIgnoreCase(db_type)) {
			end = pageSize;
			// sql = convertOracleSql2Mysql(sql);
			ls_sql = packageSqlForMysql(begin, end, sql);
		}
		if ("sqlserver".equalsIgnoreCase(db_type)) {
			// 此处暂时未实现，有此数据库时完善
		}
		return ls_sql;
	}

	/**
	 * 
	 * packageSqlForOracle的中文名称：构造分页查询语句【oracle】
	 * 
	 * packageSqlForOracle的概要说明：
	 * 
	 * @param begin
	 * @param end
	 * @param sql
	 * @return Written by : zjf
	 * 
	 */
	public static String packageSqlForOracle(int begin, int end, String sql) {
		String pre = "SELECT * FROM (SELECT T.*, ROWNUM RN FROM (";
		String last = String.format(") T WHERE ROWNUM <= %d) WHERE RN > %d",
				end, begin);
		return pre + sql + last;
	}

	/**
	 * 
	 * packageSqlForMysql的中文名称：构造分页查询语句【mysql】
	 * 
	 * packageSqlForMysql的概要说明：
	 * 
	 * @param begin
	 * @param end
	 * @param sql
	 * @return Written by : zjf
	 * 
	 */
	public static String packageSqlForMysql(int begin, int end, String sql) {
		String last = String.format(" limit  %d, %d ", begin, end);
		return sql + last;
	}

	/**
	 * 
	 * packageSqlForAccess的中文名称：构造分页查询语句【access】
	 * 
	 * packageSqlForAccess的概要说明：
	 * 
	 * @param pageSize
	 * @param currentPage
	 * @param tabName
	 * @param conditionSql
	 * @param orderCol
	 * @return Written by : zjf
	 * 
	 */
	public static String packageSqlForAccess(int pageSize, int currentPage,
			String tabName, String conditionSql, String orderCol) {
		String sql = "";
		int pages = pageSize * (currentPage - 1) + 1;
		if (!"".equals(conditionSql))
			sql = "select top " + pageSize + " * from " + tabName + " where "
					+ orderCol + ">=(select max(" + orderCol
					+ ") from (select top " + pages + " " + orderCol + " from "
					+ tabName + " where 1=1 " + conditionSql + " order by "
					+ orderCol + " asc) t)";
		else
			sql = "select top " + pageSize + " * from " + tabName + " where "
					+ orderCol + ">=(select max(" + orderCol
					+ ") from (select top " + pages + " " + orderCol + " from "
					+ tabName + " order by " + orderCol + " asc) t)";
		return sql;
	}		
}
