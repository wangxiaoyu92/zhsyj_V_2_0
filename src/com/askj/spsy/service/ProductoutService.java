package com.askj.spsy.service;

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
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.spsy.entity.Qcompanygx;
import com.askj.spsy.entity.Qproduct;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * ProductoutService的中文名称：范围外企业产品管理service
 * 
 * ProductoutService的描述：
 * 
 * Written by : gjf
 */
public class ProductoutService extends BaseService {
	protected final Logger logger = Logger.getLogger(ProductoutService.class);
	@Inject
	private Dao dao;
	
	
	/**
	 * 
	 * queryComoutListAsync的中文名称：根据Ztree插件的树格式，组装范围外公司树。
	 * 
	 * queryComoutListAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public String queryComoutListAsync(HttpServletRequest request) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		String v_sql=
		" select -1 as comid,0 as parentid,'范围外企业列表' as commc,'true' as isopen"+		
	    " union all "+			
		" select a.comid,-1 as parentid,a.commc,'false' as isopen "+
        " from pcompany a "+ 
        " where a.comlrcomid='"+vSysUser.getAaz001()+"'";
        
		Map m = DbUtils.DataQuery("sql", v_sql, null, PcompanyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		
		String ComoutData = Json.toJson(ls, JsonFormat.compact());
		ComoutData = ComoutData.replace("isparent", "isParent");
		ComoutData = ComoutData.replace("isopen", "open");
		
		return ComoutData;
	}
	
	/**
	 * 
	 * queryQproductout的中文名称：查询范围外企业包含产品信息
	 * 
	 * queryQproductout的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQproductout(QproductDTO dto, PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
        sb.append(" from qproduct a "); 
        sb.append(" where 1=1 ");
        sb.append(" and a.procomid=:procomid ");
        sb.append(" and a.proid=:proid ");
        sb.append(" and a.cphyclbz = '1' "); // 默认选择产品
        sb.append(" order by proid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	
	/**
	 * 
	 * productoutAddSave的中文名称：范围外公司新增产品保存
	 * 
	 * productoutAddSave的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */

	public String productoutAddSave(HttpServletRequest request, QproductDTO dto) {
		try {
			productoutAddSaveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void productoutAddSaveImp(HttpServletRequest request, QproductDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
			
		if (null != dto.getProid()&&!"".equals(dto.getProid()) &&!"null".equalsIgnoreCase(dto.getProid())) {
			Qproduct v_Qproductout=dao.fetch(Qproduct.class,
					dto.getProid());
			v_Qproductout.setProname(dto.getProname());
			v_Qproductout.setProsptm(dto.getProsptm());
			v_Qproductout.setProgg(dto.getProgg());
			v_Qproductout.setProsccj(dto.getProsccj());
			v_Qproductout.setPropm(dto.getPropm());
			v_Qproductout.setProbzq(dto.getProbzq());
			v_Qproductout.setProcdjd(dto.getProcdjd());
			v_Qproductout.setProplxx(dto.getProplxx());
			v_Qproductout.setProbzgg(dto.getProbzgg());
			v_Qproductout.setProcjdz(dto.getProcjdz());
			v_Qproductout.setProcjdh(dto.getProcjdh());
			v_Qproductout.setProcomid(dto.getProcomid());
			v_Qproductout.setProbzqdwcode(dto.getProbzqdwcode());
			v_Qproductout.setProbzqdwmc(dto.getProbzqdwmc());

			dao.update(v_Qproductout);
			
		} else {
			String v_proid = DbUtils.getSequenceStr();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
			
			Qproduct v_Qrpoductout =new Qproduct();
			BeanHelper.copyProperties(dto, v_Qrpoductout);
			v_Qrpoductout.setProid(v_proid);
			v_Qrpoductout.setCphyclbz("1"); // 产品或原材料标志（默认为产品）

			dao.insert(v_Qrpoductout);	
			
			//往客户关系表插入记录
//			Pcompany v_Pcompany = dao.fetch(Pcompany.class, dto.getProcomid());
//
//			String v_gxid = DbUtils.getSequenceStr();
//			Qcompanygx v_Qcompanygx = new Qcompanygx();
//			v_Qcompanygx.setGxid(v_gxid);
//			v_Qcompanygx.setComid(vSysUser.getUserid());
//			v_Qcompanygx.setCsid(dto.getProcomid());
//			v_Qcompanygx.setCsproid(v_proid); // 客户商品id
//			v_Qcompanygx.setCominoutlx("2"); // 范围外企业类型
//			v_Qcompanygx.setComgxlx(v_Pcompany.getComghsorxhs());
//			v_Qcompanygx.setComgxtime(v_dbDatetime);
//			
//			dao.insert(v_Qcompanygx);	
			
		}
	}	
	
	/**
	 * 
	 * delProductout的中文名称：删除范围外企业产品信息
	 * 
	 * delProductout的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String delProductout(HttpServletRequest request, QproductDTO dto) {
		try {
			if (null != dto.getProid()) {
				delProductoutImp(request, dto);
			} else {
				return "没有接收到要删除的proID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delProductoutImp(HttpServletRequest request, QproductDTO dto) {
		// 删除产品表
		dao.clear(Qproduct.class, Cnd.where("proid", "=", dto.getProid()));
		// 删除客户关系表
		dao.clear(Qcompanygx.class, Cnd.where("csid", "=", dto.getProcomid()).and("csproid", "=", dto.getProid()));		
	}
	
	
}
