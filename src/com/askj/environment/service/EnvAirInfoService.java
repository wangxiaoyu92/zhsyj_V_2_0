package com.askj.environment.service;

import com.askj.environment.dto.EnvAirInfoDTO;
import com.askj.environment.entity.EnvAirInfo;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * EnvAirInfoService的中文名称：大气信息管理service
 * 
 * EnvAirInfoService的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 17:39:25
 */
public class EnvAirInfoService {
	protected final Logger logger = Logger.getLogger(EnvAirInfoService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryEnvAirInfo的中文名称：查询大气信息
	 * 
	 * queryEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * @throws Exception
	 * 
	 */
	public Map queryEnvAirInfo(EnvAirInfoDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select * ");
		sb.append("  from EnvAirInfo ");
		sb.append("  where 1 = 1 ");
		sb.append("  and airid = :airid ");
		sb.append("  and airtsp = :airtsp ");
		sb.append("  and airthc = :airthc ");
		sb.append("  and airto = :airto ");
		sb.append("  and airoxynitride = :airoxynitride ");
		sb.append("  and airso2 = :airso2 ");
		sb.append("  and airco = :airco ");
		sb.append("  and airdustfall = :airdustfall ");
		sb.append("  and proid = :proid ");
		sb.append("  and cppcpch = :cppcpch ");
		String sql = sb.toString();
		String[] ParaName = new String[] {
					"airid",
					"airtsp",
					"airthc",
					"airto",
					"airoxynitride",
					"airso2",
					"airco",
					"airdustfall",
					"proid",
					"cppcpch"
				};
		int[] ParaType = new int[] {
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR
				};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EnvAirInfo.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addEnvAirInfo的中文名称：新增大气信息
	 * 
	 * addEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	public String addEnvAirInfo(HttpServletRequest request, final EnvAirInfoDTO dto) {
		try {
			addEnvAirInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addEnvAirInfoImp(HttpServletRequest request, EnvAirInfoDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvAirInfo envAirInfo = new EnvAirInfo();
		String sequence = DbUtils.getSequenceStr();
		dto.setAirid(sequence);
		BeanHelper.copyProperties(dto, envAirInfo);
		envAirInfo.setOperatoruserid(user.getUserid());
		envAirInfo.setOperatorusername(user.getDescription());
		envAirInfo.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		dao.insert(envAirInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateEnvAirInfo的中文名称：修改大气信息
	 * 
	 * updateEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */

	public String updateEnvAirInfo(HttpServletRequest request, final EnvAirInfoDTO dto) {
		try {
			updateEnvAirInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateEnvAirInfoImp(HttpServletRequest request, EnvAirInfoDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvAirInfo envAirInfo = dao.fetch(EnvAirInfo.class, dto.getAirid());
		BeanHelper.copyProperties(dto, envAirInfo);
		envAirInfo.setOperatoruserid(user.getUserid());
		envAirInfo.setOperatorusername(user.getDescription());
		envAirInfo.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		dao.update(envAirInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delEnvAirInfo的中文名称：删除大气信息
	 * 
	 * delEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	public String delEnvAirInfo(HttpServletRequest request, EnvAirInfoDTO dto) {
		try {
			delEnvAirInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delEnvAirInfoImp(HttpServletRequest request, EnvAirInfoDTO dto)  throws Exception {
		// 删除大气信息
		//TODO1 根据ID删除需要指定主键
		dao.clear(EnvAirInfo.class, Cnd.where("airid", "=", dto.getAirid()));
	}
	
}