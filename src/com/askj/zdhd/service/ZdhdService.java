package com.askj.zdhd.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zdhd.dto.ZdhddjDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.zdhd.entity.Zdhddj;
import com.askj.zdhd.entity.Zdhdjcry;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * NewsService的中文名称：新闻管理service
 * 
 * NewsService的描述：
 * 
 * Written by : gjf
 */
public class ZdhdService extends BaseService {
	protected final Logger logger = Logger.getLogger(ZdhdService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryZdhddj的中文名称：查询重大活动登记
	 * 
	 * queryZdhddj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Map queryZdhddj(ZdhddjDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		dto.setAaa027(vSysUser.getAaa027());

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,b.commc,");
		sb.append("(select t.aaa129 from aa13 t where t.aaa027=a.aaa027) as aaa027name, ");
		sb.append("(select fun_getZdhdjcry(a.zdhddjid,'1') from dual) as zdhdjcryidlist, ");
		sb.append("(select fun_getZdhdjcry(a.zdhddjid,'2') from dual) as  zdhdjcryidliststr, ");
		sb.append("(select t.plantitle from bscheckplan t where t.planid=a.planid ) as  plantitle ");
		sb.append(" from zdhddj a,pcompany b ");
		sb.append(" where a.comid=b.comid ");
		sb.append("  and a.zdhddjid = :zdhddjid");
		sb.append("  and a.comid = :comid");
		sb.append("  and a.aae036 >= :aae036start");
		sb.append("  and a.aae036 <= :aae036end");
		sb.append("  and b.commc like :commc");
		sb.append(" order by a.zdhddjid desc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "zdhddjid", "comid", "aae036start","aae036end","commc" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, ZdhddjDTO.class,
				pd.getPage(), pd.getRows(),null,"aaa027,aae140,orgid");
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	
	/**
	 * 
	 * saveAjdj的中文名称：保存案件登记
	 * 
	 * saveAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */

	public String saveZdhddj(HttpServletRequest request, ZdhddjDTO dto) {
		try {
			saveZdhddjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void saveZdhddjImp(HttpServletRequest request, ZdhddjDTO dto)
			throws Exception {
		if (null != dto.getZdhddjid()&&!"".equals(dto.getZdhddjid())) {
			Zdhddj se = dao.fetch(Zdhddj.class, dto.getZdhddjid());
			se.setComid(dto.getComid());
			se.setZdhdlxr(dto.getZdhdlxr());
			se.setZdhdlxdh(dto.getZdhdlxdh());
			se.setZdhdmc(dto.getZdhdmc());
			se.setZdhdkssj(dto.getZdhdkssj());
			se.setZdhdjssj(dto.getZdhdjssj());
			se.setZdhdjckssj(dto.getZdhdjckssj());
			se.setZdhddd(dto.getZdhddd());
			se.setZdhdjdzb(dto.getZdhdjdzb());
			se.setZdhdwdzb(dto.getZdhdwdzb());
			se.setZdhdbeizhu(dto.getZdhdbeizhu());
			se.setAaa027(dto.getAaa027());
			se.setPlanid(dto.getPlanid());

			dao.update(se);
			
			//
			String v_sql="delete a from zdhdjcry a where a.zdhddjid='"+dto.getZdhddjid()+"' ";
			Sql sql = Sqls.create(v_sql);
			dao.execute(sql);			
			
			String v_zdhdjcryid = "";
			String[] v_useridlist=dto.getZdhdjcryidlist().split(",");
			String v_userid="";
			for (int k=0;k<v_useridlist.length;k++){
				v_zdhdjcryid = DbUtils.getSequenceStr();
				v_userid=v_useridlist[k];
				Zdhdjcry v_newZdhdjcry=new Zdhdjcry();
				v_newZdhdjcry.setZdhdjcryid(v_zdhdjcryid);
				v_newZdhdjcry.setZdhddjid(dto.getZdhddjid());
				v_newZdhdjcry.setUserid(v_userid);
				dao.insert(v_newZdhdjcry);
			}			
		} else {
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
			String v_zdhddjid = DbUtils.getSequenceStr();
			
			Zdhddj v_Zdhddj = new Zdhddj();
			BeanHelper.copyProperties(dto, v_Zdhddj);
			v_Zdhddj.setZdhddjid(v_zdhddjid);
			v_Zdhddj.setAae011(vSysUser.getDescription());
			v_Zdhddj.setAae036(v_dbDatetime);
			v_Zdhddj.setOrgid(vSysUser.getOrgid());
			dao.insert(v_Zdhddj);
			
			String v_zdhdjcryid = "";
			String[] v_useridlist=dto.getZdhdjcryidlist().split(",");
			String v_userid="";
			for (int k=0;k<v_useridlist.length;k++){
				v_zdhdjcryid = DbUtils.getSequenceStr();
				v_userid=v_useridlist[k];
				Zdhdjcry v_newZdhdjcry=new Zdhdjcry();
				v_newZdhdjcry.setZdhdjcryid(v_zdhdjcryid);
				v_newZdhdjcry.setZdhddjid(v_zdhddjid);
				v_newZdhdjcry.setUserid(v_userid);
				dao.insert(v_newZdhdjcry);
			}
			
		}
	}
	
	/**
	 * 
	 * delZdhddj的中文名称：删除重大活动登记
	 * 
	 * delZdhddj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String delZdhddj(HttpServletRequest request, ZdhddjDTO dto) {
		try {
			if (null != dto.getZdhddjid()) {
				delZdhddjImp(request, dto);
			} else {
				return "没有接收到要删除的重大活动登记ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delZdhddjImp(HttpServletRequest request, ZdhddjDTO dto) {
		// 删除重大活动登记信息
		dao.clear(Zdhddj.class, Cnd.where("zdhddjid", "=", dto.getZdhddjid()));
		// 删除重大活动登记检查人员信息
		dao.clear(Zdhdjcry.class, Cnd.where("zdhddjid", "=", dto.getZdhddjid()));		
	}	

}
