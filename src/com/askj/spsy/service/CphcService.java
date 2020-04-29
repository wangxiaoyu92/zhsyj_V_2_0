package com.askj.spsy.service;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.spsy.dto.QproductclsyjlbDTO;
import com.askj.spsy.dto.QproductpcDTO;
import com.askj.spsy.entity.Qledgerstock;
import com.askj.spsy.entity.Qproduct;
import com.askj.spsy.entity.Qproductclsyjlb;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

public class CphcService extends BaseService {
	protected final Logger logger = Logger.getLogger(CphcService.class);
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryCppc的中文名称：查询产品批次
	 * 
	 * queryCppc的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryCppc(QproductpcDTO dto, PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,b.proname,b.procomid ");
        sb.append(" from qproductpc a,qproduct b "); 
        sb.append(" where a.proid=b.proid ");
        sb.append(" and b.procomid=:procomid ");
        sb.append(" and a.proid=:proid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsql "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductpcDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryCphc的中文名称：查询产品耗材
	 * 
	 * queryCphc的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryCphc(QproductclsyjlbDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
        sb.append(" from qproductclsyjlb a "); 
        sb.append(" where 1=1 ");
        sb.append(" and a.procomid=:procomid ");
        sb.append(" and a.proid=:proid ");
        sb.append(" and a.cppcid=:cppcid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid","cppcid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsql "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductclsyjlbDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryCphcSycl的中文名称：查询剩余材料
	 * 
	 * queryCphcSycl的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryCphcSycl(QproductclsyjlbDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.lgfromcomid,c.commc,a.lgproid,d.proname as lgproname,");
		sb.append(" a.lgprojysl,a.lgprosysl,a.lgprojydwmc,a.qledgerstockid ");
		sb.append(" from qledgerstock a,qcphcldygx b,pcompany c,qproduct d "); 
        sb.append(" where a.sphyclid=b.cpclid ");
        sb.append(" and a.lgfromcomid=c.comid ");
        sb.append(" and a.lgproid=d.proid ");
        sb.append(" and a.lgtocomid=:procomid ");
        sb.append(" and b.proid=:proid ");
        sb.append(" and a.lgprosysl>0 ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsql "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgerstockDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * cphcAddSave的中文名称：保存产品耗材
	 * 
	 * cphcAddSave的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 */
	public String cphcAddSave(HttpServletRequest request, QledgerstockDTO dto) {
		try {
			 cphcAddSaveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * @Description: 保存产品耗材实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void cphcAddSaveImp(HttpServletRequest request, QledgerstockDTO dto)
			throws Exception {
		JSONArray v_array = null;
		Object[] v_objArray = null;
		// 物品明细情况
		v_array = JSONArray.fromObject(dto.getProbcxhlGridStr());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			QledgerstockDTO v_QledgerstockDTO = (QledgerstockDTO) JSONObject.toBean(
					v_obj, QledgerstockDTO.class);
			BigDecimal aa=new BigDecimal(0);
			if (v_QledgerstockDTO.getProbcxhl().compareTo(aa)==1){
				// 获取物品明细id
				Qproductclsyjlb v_Qproductclsyjlb=new Qproductclsyjlb();
				String v_qproductclsyjlbid = DbUtils.getSequenceStr();
				
				Qledgerstock v_Qledgerstock=dao.fetch(Qledgerstock.class, v_QledgerstockDTO.getQledgerstockid());
				Qproduct v_qproduct=dao.fetch(Qproduct.class, v_Qledgerstock.getSphyclid());
								
				v_Qproductclsyjlb.setQproductclsyjlbid(v_qproductclsyjlbid);
				v_Qproductclsyjlb.setProcomid(dto.getProcomid());
				v_Qproductclsyjlb.setProid(dto.getProid());
				v_Qproductclsyjlb.setCppcid(dto.getCppcid());
				v_Qproductclsyjlb.setCpclid(dto.getSphyclid());
				v_Qproductclsyjlb.setCpclname(v_qproduct.getProname());
				v_Qproductclsyjlb.setQledgerstockid(v_QledgerstockDTO.getQledgerstockid());
				v_Qproductclsyjlb.setCpclsysl(v_QledgerstockDTO.getProbcxhl());
				v_Qproductclsyjlb.setCpcldw(v_QledgerstockDTO.getLgprojydwmc());
				
				dao.insert(v_Qproductclsyjlb);
				
				
				v_Qledgerstock.setLgprosysl(v_Qledgerstock.getLgprosysl().subtract(v_QledgerstockDTO.getProbcxhl()));
				dao.update(v_Qledgerstock);				
			}
		}
	}
	
	/**
	 * 
	 * delCphc的中文名称：删除产品耗材
	 * 
	 * delCphc的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delCphc(HttpServletRequest request, 
			final QproductclsyjlbDTO dto) {
		try {
			delCphcImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	@Aop( { "trans" })
	public void delCphcImp(HttpServletRequest request, 
			final QproductclsyjlbDTO dto) {
		Qproductclsyjlb v_Qproductclsyjlb=dao.fetch(Qproductclsyjlb.class, dto.getQproductclsyjlbid());
		Qledgerstock v_Qledgerstock=dao.fetch(Qledgerstock.class, v_Qproductclsyjlb.getQledgerstockid());
		
		v_Qledgerstock.setLgprosysl(v_Qledgerstock.getLgprosysl().add(v_Qproductclsyjlb.getCpclsysl()));
		dao.update(v_Qledgerstock);
		
		dao.clear(Qproductclsyjlb.class,Cnd.where("qproductclsyjlbid","=",dto.getQproductclsyjlbid()));
	}
	
}
