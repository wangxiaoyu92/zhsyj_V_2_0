package com.askj.environment.service;

import com.askj.environment.dto.EnvSoilInfoDTO;
import com.askj.environment.entity.EnvSoilInfo;
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
 * EnvSoilInfoService的中文名称：土壤信息管理service
 * 
 * EnvSoilInfoService的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 14:04:04
 */
public class EnvSoilInfoService {
	protected final Logger logger = Logger.getLogger(EnvSoilInfoService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryEnvSoilInfo的中文名称：查询土壤信息
	 * 
	 * queryEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * @throws Exception
	 * 
	 */
	public Map queryEnvSoilInfo(EnvSoilInfoDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select * ");
		sb.append("  from EnvSoilInfo ");
		sb.append("  where 1 = 1 ");
		sb.append("  and soilid = :soilid ");
		sb.append("  and soiltemperature = :soiltemperature ");
		sb.append("  and soilsalinity = :soilsalinity ");
		sb.append("  and soilmoisture = :soilmoisture ");
		sb.append("  and proid = :proid ");
		sb.append("  and cppcpch = :cppcpch ");
		String sql = sb.toString();
		String[] ParaName = new String[] {
					"soilid",
					"soiltemperature",
					"soilsalinity",
					"soilmoisture",
				"proid",
				"cppcpch"
				};
		int[] ParaType = new int[] {
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
				Types.VARCHAR,
				Types.VARCHAR
				};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EnvSoilInfo.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addEnvSoilInfo的中文名称：新增土壤信息
	 * 
	 * addEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	public String addEnvSoilInfo(HttpServletRequest request, final EnvSoilInfoDTO dto) {
		try {
			addEnvSoilInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addEnvSoilInfoImp(HttpServletRequest request, EnvSoilInfoDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvSoilInfo envSoilInfo = new EnvSoilInfo();
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		dto.setOperatoruserid(vSysUser.getUserid());
		dto.setOperatorusername(vSysUser.getUsername());
		dto.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		String sequence = DbUtils.getSequenceStr();
		BeanHelper.copyProperties(dto, envSoilInfo);
		envSoilInfo.setSoilid(sequence);
		dao.insert(envSoilInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateEnvSoilInfo的中文名称：修改土壤信息
	 * 
	 * updateEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */

	public String updateEnvSoilInfo(HttpServletRequest request, final EnvSoilInfoDTO dto) {
		try {
			updateEnvSoilInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateEnvSoilInfoImp(HttpServletRequest request, EnvSoilInfoDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvSoilInfo envSoilInfo = dao.fetch(EnvSoilInfo.class, dto.getSoilid());
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		dto.setOperatoruserid(vSysUser.getUserid());
		dto.setOperatorusername(vSysUser.getUsername());
		dto.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		BeanHelper.copyProperties(dto, envSoilInfo);
		dao.update(envSoilInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delEnvSoilInfo的中文名称：删除土壤信息
	 * 
	 * delEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	public String delEnvSoilInfo(HttpServletRequest request, EnvSoilInfoDTO dto) {
		try {
			delEnvSoilInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delEnvSoilInfoImp(HttpServletRequest request, EnvSoilInfoDTO dto)  throws Exception {
		// 删除土壤信息
		dao.clear(EnvSoilInfo.class, Cnd.where("soilid", "=", dto.getSoilid()));
	}
	
}