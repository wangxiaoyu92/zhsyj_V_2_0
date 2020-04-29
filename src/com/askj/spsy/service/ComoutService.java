package com.askj.spsy.service;

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

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pcompany;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * ComoutService的中文名称：范围外企业管理service
 * 
 * ComoutService的描述：
 * 
 * Written by : gjf
 */
public class ComoutService extends BaseService {
	
	protected final Logger logger = Logger.getLogger(ComoutService.class);
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryComout的中文名称：查询范围外企业集合
	 * 
	 * queryComout的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryComout(PcompanyDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		dto.setComlrcomid(vSysUser.getAaz001());

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.comid,a.commc,a.comdalei,a.comfrhyz,a.comyddh,a.comdz,a.comghsorxhs,a.comxkzbh,");
		sb.append(" to_char(a.comdzcsj,'%Y-%m-%d %H:%i:%s') as comdzcsj, ");
		sb.append(" (select t.commc from pcompany t where t.comid=a.comlrcomid) as comlrcommc ");
        sb.append(" from pcompany a "); 
        sb.append(" where 1=1 "); 
        sb.append(" and a.comlrcomid=:comlrcomid ");
        sb.append(" and a.comfwnfww='1' ");
        sb.append(" order by comid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] { "comlrcomid"};
		int[] ParaType = new int[] { Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sql "+sql);
		
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * queryComoutEdit的中文名称：查询范围外企业
	 * 
	 * queryComoutEdit的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryComoutEdit(PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		
		sb.append(" select a.comid,a.commc,a.comdalei,a.comfrhyz,a.comyddh,a.comdz,a.comghsorxhs,a.comxkzbh,");
		sb.append(" to_char(a.comdzcsj,'%Y-%m-%d %H:%i:%s') as comdzcsj, ");
		sb.append(" (select t.commc from pcompany t where t.comid=a.comlrcomid) as comlrcommc ");
        sb.append(" from pcompany a "); 
        sb.append(" where 1=1 "); 
        sb.append(" and a.comid=:comid ");
        sb.append(" order by comid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] { "comid"};
		int[] ParaType = new int[] { Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * comoutAddSave的中文名称：范围外公司新增保存
	 * 
	 * comoutAddSave的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */

	public String comoutAddSave(HttpServletRequest request, PcompanyDTO dto) {
		try {
			comoutAddSaveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void comoutAddSaveImp(HttpServletRequest request, PcompanyDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		
		if (null != dto.getComid()&&!"".equals(dto.getComid())) {
			Pcompany v_Pcompany=dao.fetch(Pcompany.class,dto.getComid());
			v_Pcompany.setComxkzbh(dto.getComxkzbh());
			v_Pcompany.setCommc(dto.getCommc());
			v_Pcompany.setComfrhyz(dto.getComfrhyz());
			v_Pcompany.setComfrsfzh(dto.getComfrsfzh()); 
			v_Pcompany.setComfzr(dto.getComfzr());
			v_Pcompany.setComyddh(dto.getComyddh());
			v_Pcompany.setComdz(dto.getComdz());
			v_Pcompany.setComdalei(dto.getComdalei());
			v_Pcompany.setComghsorxhs(dto.getComghsorxhs());

			dao.update(v_Pcompany);
			
		}else{
			String v_comlrcomid=vSysUser.getAaz001();
			String v_comid = DbUtils.getSequenceStr();
			Timestamp v_dbDatetime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			String v_comdm=SysmanageUtil.getComdm();
			
			Pcompany v_Pcompany =new Pcompany();
			BeanHelper.copyProperties(dto, v_Pcompany);
			
			v_Pcompany.setComid(v_comid);
			v_Pcompany.setComdm(v_comdm);			
			v_Pcompany.setComshbz("1");  // 先默认为已审核
			v_Pcompany.setComdzcczymc(vSysUser.getDescription());
			v_Pcompany.setComdzcsj(v_dbDatetime);
			v_Pcompany.setComfwnfww("1"); // 0范围内 1范围外
			v_Pcompany.setComlrcomid(v_comlrcomid);
			v_Pcompany.setAaa027(vSysUser.getAaa027());
			dao.insert(v_Pcompany);	
		}
	}
	
	/**
	 * 
	 * delCompanyout的中文名称：删除范围外企业
	 * 
	 * delCompanyout的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String delCompanyout(HttpServletRequest request, PcompanyDTO dto) {
		try {
			if (null != dto.getComid()) {
				delCompanyoutImp(request, dto);
			} else {
				return "没有接收到要删除的comID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delCompanyoutImp(HttpServletRequest request, PcompanyDTO dto) {
		// 删除案件登记
		dao.clear(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));
	}	
}
