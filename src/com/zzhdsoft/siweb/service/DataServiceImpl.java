package com.zzhdsoft.siweb.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.mvc.Mvcs;
import org.nutz.trans.Atom;
import org.nutz.trans.Trans;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.ParamDTO;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.zzhdsoft.utils.db.ProcedureUtil;

/**
 * 
 * DataServiceImpl的中文名称：内网数据查询接口实现类
 * 
 * DataServiceImpl的描述：
 * 
 * Written by : zjf
 */
@IocBean
public class DataServiceImpl implements IDataService {
	private static final Logger log = Logger.getLogger(DataServiceImpl.class);
	@Inject
	protected Dao dao;

	/**
	 * 
	 * validCheck的中文名称：检查SQL语句安全性
	 * 
	 * validCheck的概要说明: 不能包含update|insert|delete|drop|create关键字
	 * 
	 * @param dto
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	private void validCheck(ParamDTO dto) throws Exception {
		// 1、检查操作类型
		if (!("SQL".equalsIgnoreCase(dto.getT()) || "PROC".equalsIgnoreCase(dto
				.getT()))) {
			throw new Exception("传入参数错误(HD-101)：传入的操作类型无效!");
		}
		// 2、检查SQL是否为空
		if ("".equals(dto.getSql()) || null == dto.getSql()) {
			throw new Exception("传入参数错误(HD-102)：传入的SQL语句不能为空!");
		}
		// 3、不能包含update|insert|delete|drop|create关键字
		String sql = dto.getSql().toLowerCase();
		if (sql.indexOf("update ") >= 0 || sql.indexOf("insert ") >= 0
				|| sql.indexOf("delete ") >= 0 || sql.indexOf("drop ") >= 0
				|| sql.indexOf("create ") >= 0) {
			throw new Exception("传入参数错误(HD-103)：警告，不可执行非查询类语句!");
		}
	}

	public Object query(ParamDTO dto) {
		ResultDTO rd = new ResultDTO();
		try {
			validCheck(dto);

			if ("SQL".equalsIgnoreCase(dto.getT())) {
				rd.setResult(querySQL(dto.getSql()));
			}
			if ("PROC".equalsIgnoreCase(dto.getT())) {
				rd.setResult(execProc(dto.getSql(), dto.getParam()));
			}

			// 总记录数
			Map m = (Map) rd.getResult().get(0);
			List rsList = (List) m.get("ResultSet");
			if (rsList != null && rsList.size() > 0) {
				rd.setRecnum(rsList.size());
			} else {
				//remove by sunyifeng at 201606011706
				// reason:不管查询是否有结果在rd.getResult()执行后size都为1
				// 有值时rd.getResult()是list 没有值时rd.getResult()是个map
				//rd.setRecnum(rd.getResult().size());
				rd.setRecnum(0);
			}
			rd.setCode("0");
			rd.setMsg("");
		} catch (Exception e) {
			rd.setCode("-1");
			rd.setMsg(Lang.unwrapThrow(e).getMessage());
			rd.setRecnum(0);
			rd.setResult(new ArrayList());
		}

		return rd;
	}

	/**
	 * 
	 * querySQL的中文名称：执行SQL查询
	 * 
	 * querySQL的概要说明:
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	private List querySQL(String sql) throws Exception {
		Sql s = Sqls.create(sql);
		final List list = new Vector();
		final Map err = new HashMap();
		s.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql)
					throws SQLException {
				try {
					if (rs != null) {
						ProcedureUtil pu = Mvcs.ctx().getDefaultIoc().get(
								ProcedureUtil.class);
						Map res = new HashMap();
						res.put("ResultSet", pu.openResultSet(rs));
						list.add(res);
					}
				} catch (Exception e) {
					err.put(GlobalNames.EXCEPTION_KEY, e.getMessage());
				}

				return null;
			}
		});
		dao.execute(s);

		// 把异常的真实原因抛出
		if (err.get(GlobalNames.EXCEPTION_KEY) != null) {
			throw new Exception(err.get(GlobalNames.EXCEPTION_KEY).toString());
		}
		return list;
	}

	/**
	 * 
	 * execProc的中文名称：执行存储过程
	 * 
	 * execProc的概要说明:
	 * 
	 * @param proc
	 * @param param
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	private List execProc(final String proc, final String param)
			throws Exception {
		final List list = new Vector();
		final Map err = new HashMap();
		// 启用事务
		Trans.exec(new Atom() {
			public void run() {
				try {
					ProcedureUtil pu = Mvcs.ctx().getDefaultIoc().get(
							ProcedureUtil.class);
					// 取参数
					LinkedHashMap lhmap = (LinkedHashMap) Json.fromJson(param);
					pu.init(proc, lhmap);
					pu.execute();
					list.add(pu.getResultHash());
				} catch (Exception e) {
					err.put(GlobalNames.EXCEPTION_KEY, e.getMessage());
				}
			}
		});

		// 把异常的真实原因抛出
		if (err.get(GlobalNames.EXCEPTION_KEY) != null) {
			throw new Exception(err.get(GlobalNames.EXCEPTION_KEY).toString());
		}
		return list;
	}

	/**
	 * 
	 * execSQL的中文名称：执行查询、存储过程
	 * 
	 * execSQL的概要说明：
	 * 
	 * @param t
	 * @param sql
	 * @param param
	 * @return Written by : zjf
	 * 
	 */
	public String execSQL(String t, String sql, String param) {
		log.info("TYPE:" + t);
		log.info("SQL:" + sql);
		log.info("PARAM:" + param);

		ParamDTO p = new ParamDTO();
		p.setT(t);
		p.setSql(sql);
		p.setParam(param);
		ResultDTO r = (ResultDTO) query(p);

		return Json.toJson(r);
	}
}
