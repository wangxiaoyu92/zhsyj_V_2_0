package com.zzhdsoft.siweb.service.sysmanager;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa09;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * SysparamService的中文名称：系统参数管理service
 * 
 * SysparamService的描述：
 * 
 * Written by : zjf
 */
public class SysparamService extends BaseService {
	protected final Logger logger = Logger.getLogger(SysparamService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryAa01的中文名称：查询系统参数Aa01
	 * 
	 * queryAa01的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	public Map queryAa01(Aa01 dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select aaa001,aaa002,aaa005,aaa104,aaa105,aaz499,aaa027");
		sb.append("  from Aa01 a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.aaa104 = '1' ");
		sb.append("  and  a.aaz499 = :aaz499 ");
		sb.append("  and  a.aaa001 = :aaa001");
		sb.append("  and  a.aaa002 like :aaa002 ");

		String[] ParaName = new String[] { "aaz499", "aaa001" ,"aaa002"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, Aa01.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addAa01的中文名称：新增系统参数Aa01
	 * 
	 * addAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addAa01(HttpServletRequest request, Aa01 dto) {
		try {
			addAa01Imp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addAa01Imp(HttpServletRequest request, Aa01 dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Aa01 aa01 = new Aa01();
		BeanHelper.copyProperties(dto, aa01);
		String aaz499 = DbUtils.getSequenceStr();
		aa01.setAaz499(aaz499);
		dao.insert(aa01);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateAa01的中文名称：修改系统参数Aa01
	 * 
	 * updateAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateAa01(HttpServletRequest request, Aa01 dto) {
		try {
			updateAa01Imp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateAa01Imp(HttpServletRequest request, Aa01 dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Aa01 aa01 = dao.fetch(Aa01.class, dto.getAaz499());
		BeanHelper.copyProperties(dto, aa01);
		dao.update(aa01);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delAa01的中文名称：删除系统参数Aa01
	 * 
	 * delAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delAa01(HttpServletRequest request, final Aa01 dto) {
		try {
			if (Strings.isNotBlank(dto.getAaz499())) {
				// 检查是否可删除
				delAa01Imp(request, dto);
			} else {
				return "没有接收到要删除的系统参数表ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delAa01Imp(HttpServletRequest request, final Aa01 dto) {
		dao.clear(Aa01.class, Cnd.where("aaz499", "=", dto.getAaz499()));
	}

	/**
	 * 
	 * queryAa10的中文名称：查询参数代码aa10
	 * 
	 * queryAa10的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * 
	 */
	public Map queryAa10(Aa10DTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.* ");
		sb.append("  from Aa10 a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.aaa100 = :aaa100 ORDER BY (aae036) DESC");

		String[] ParaName = new String[] { "aaa100"};
		int[] ParaType = new int[] { Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, Aa10DTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * delAa10的中文名称：删除系统参数Aa10
	 * 
	 * delAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String delAa10(HttpServletRequest request, final Aa10DTO dto) {
		try {
			if (Strings.isNotBlank(dto.getAaz093())) {
				// 检查是否可删除
				delAa10Imp(request, dto);
			} else {
				return "没有接收到要删除的代码参数表ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delAa10Imp(HttpServletRequest request, final Aa10DTO dto) {
		dao.clear(Aa10.class, Cnd.where("aaz093", "=", dto.getAaz093()));
	}
	/**
	 * 
	 * addAa10的中文名称：新增系统参数Aa10
	 * 
	 * addAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String addAa10(HttpServletRequest request, Aa10DTO dto) {
		try {
			addAa10Imp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addAa10Imp(HttpServletRequest request, Aa10DTO dto)
			throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
		Timestamp startTime = SysmanageUtil.currentTime();
		Aa10 aa10 = new Aa10();
		BeanHelper.copyProperties(dto, aa10);
		String aaz093 = DbUtils.getSequenceStr();
		aa10.setAaz093(aaz093);
		//根据aaa100获取aaz094
		Aa09 v_aa09=dao.fetch(Aa09.class, Cnd.where("aaa100", "=", dto.getAaa100()));
		aa10.setAaz094(v_aa09.getAaz094());
		aa10.setAae030(199405);
		aa10.setAae011(vSysUser.getUserid());
		aa10.setAae036(v_dbtime);
		dao.insert(aa10);
		//刷新参数
		//SysmanageUtil.initAa10Map();		
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}
	
	/**
	 * 
	 * updateAa10的中文名称：修改系统参数Aa10
	 * 
	 * updateAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateAa10(HttpServletRequest request, Aa10DTO dto) {
		try {
			updateAa10Imp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateAa10Imp(HttpServletRequest request, Aa10DTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Aa10 aa10 = dao.fetch(Aa10.class, dto.getAaz093());
		BeanHelper.copyProperties(dto, aa10);
		dao.update(aa10);
		//刷新参数
		//SysmanageUtil.initAa10Map();		
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}
	
}
