package com.askj.environment.service;

import com.askj.environment.dto.EnvWalterInfoDTO;
import com.askj.environment.entity.EnvWalterInfo;
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
 * EnvWalterInfoService的中文名称：水信息管理service
 * 
 * EnvWalterInfoService的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 18:42:43
 */
public class EnvWalterInfoService {
	protected final Logger logger = Logger.getLogger(EnvWalterInfoService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryEnvWalterInfo的中文名称：查询水信息
	 * 
	 * queryEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * @throws Exception
	 * 
	 */
	public Map queryEnvWalterInfo(EnvWalterInfoDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select * ");
		sb.append("  from EnvWalterInfo ");
		sb.append("  where 1 = 1 ");
		sb.append("  and walterid = :walterid ");
		sb.append("  and walterph = :walterph ");
		sb.append("  and waltero2 = :waltero2 ");
		sb.append("  and waltertemp = :waltertemp ");
		sb.append("  and walterele = :walterele ");
		sb.append("  and walterturbidity = :walterturbidity ");
		sb.append("  and proid = :proid ");
		sb.append("  and cppcpch = :cppcpch ");
		String sql = sb.toString();
		String[] ParaName = new String[] {
					"walterid",
					"walterph",
					"waltero2",
					"waltertemp",
					"walterele",
					"walterturbidity",
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
				Types.VARCHAR
				};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EnvWalterInfo.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addEnvWalterInfo的中文名称：新增水信息
	 * 
	 * addEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	public String addEnvWalterInfo(HttpServletRequest request, final EnvWalterInfoDTO dto) {
		try {
			addEnvWalterInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addEnvWalterInfoImp(HttpServletRequest request, EnvWalterInfoDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvWalterInfo envWalterInfo = new EnvWalterInfo();
		String sequence = DbUtils.getSequenceStr();
		dto.setWalterid(sequence);
		BeanHelper.copyProperties(dto, envWalterInfo);
		envWalterInfo.setOperatoruserid(user.getUserid());
		envWalterInfo.setOperatorusername(user.getDescription());
		envWalterInfo.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		dao.insert(envWalterInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateEnvWalterInfo的中文名称：修改水信息
	 * 
	 * updateEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */

	public String updateEnvWalterInfo(HttpServletRequest request, final EnvWalterInfoDTO dto) {
		try {
			updateEnvWalterInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateEnvWalterInfoImp(HttpServletRequest request, EnvWalterInfoDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		Timestamp startTime = SysmanageUtil.currentTime();
		EnvWalterInfo envWalterInfo = dao.fetch(EnvWalterInfo.class, dto.getWalterid());
		BeanHelper.copyProperties(dto, envWalterInfo);
		envWalterInfo.setOperatoruserid(user.getUserid());
		envWalterInfo.setOperatorusername(user.getDescription());
		envWalterInfo.setOperatordate(SysmanageUtil.getDbtimeYmdHns());
		dao.update(envWalterInfo);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delEnvWalterInfo的中文名称：删除水信息
	 * 
	 * delEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	public String delEnvWalterInfo(HttpServletRequest request, EnvWalterInfoDTO dto) {
		try {
			delEnvWalterInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delEnvWalterInfoImp(HttpServletRequest request, EnvWalterInfoDTO dto)  throws Exception {
		// 删除水信息
		dao.clear(EnvWalterInfo.class, Cnd.where("walterid", "=", dto.getWalterid()));
	}
	
}