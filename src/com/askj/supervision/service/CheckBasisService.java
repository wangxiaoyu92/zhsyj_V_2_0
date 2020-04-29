package com.askj.supervision.service;

import com.askj.baseinfo.entity.OmLawContent;
import com.askj.supervision.dto.OmcheckbasisDTO;
import com.askj.supervision.entity.*;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 *  CheckBasisService的中文名称：检查依据管理service
 *
 *  CheckBasisService的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
public class CheckBasisService {
	
	protected final Logger logger = Logger.getLogger(CheckBasisService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryBasisZTreeAsync的中文名称：查询检查依据树
	 * 
	 * queryBasisZTreeAsync的概要说明：异步加载
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	public List queryBasisZTreeAsync(HttpServletRequest request) throws Exception {
		
		String contentid = StringHelper.showNull2Empty(request.getParameter("contentid")); 
		
		StringBuffer sb = new StringBuffer();
	    sb.append("  select a.contentid itemid, a.content itemname, a.itemid itempid ");
        sb.append("  from omcheckcontent a ");
        sb.append("  where 1 = 1 ");
        sb.append("  and a.itemid = '").append(contentid).append("' ");
        sb.append("  order by a.contentsortid asc ");
        String sql = sb.toString();

		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * queryCheckBasis的中文名称：查询检查依据
	 * 
	 * queryCheckBasis的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCheckBasis(HttpServletRequest request, 
			OmcheckbasisDTO dto, PagesDTO pd) throws Exception {
	    // 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
	    sb.append("  select a.* ");
        sb.append("  from omcheckbasis a, omcheckcontentbasisrt b ");
        sb.append("  where 1 = 1   ");
        sb.append("  and a.basisid = b.basisid ");
        sb.append("  and b.contentid = :contentid ");
        sb.append("  and a.type = :type ");
        sb.append("  and a.basisdesc like :basisdesc ");
        sb.append("  order by a.operatedate desc ");
        String sql = sb.toString();
        String[] paramName = new String[] { "contentid", "type", "basisdesc" };
        int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OmcheckbasisDTO.class, pd.getPage(), pd.getRows());
		List<OmcheckbasisDTO> list = (List<OmcheckbasisDTO>) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
	
	/**
	 * 
	 * queryCheckBasisObj的中文名称：获取检查依据信息
	 * 
	 * queryCheckBasisObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCheckBasisObj(HttpServletRequest request, OmcheckbasisDTO dto) throws Exception {
		// 检查依据信息
		Omcheckbasis basisInfo = dao.fetch(Omcheckbasis.class, dto.getBasisid());
		// 检查依据法律法规问题
		String flfgSql = "select a.contentid, a.content, a.contentcode, a.contentsortid from omlawcontent a, "
				+ " omcheckbasislegalrt b where a.contentid = b.legalitemid and b.basisid = '"
				+ dto.getBasisid() + "' order by a.contentsortid desc";
		Map flfgMap = DbUtils.DataQuery("sql", flfgSql, null, OmLawContent.class);
		List flfgInfo = (List) flfgMap.get(GlobalNames.SI_RESULTSET);
		// 检查常见问题
		String proSql = "select a.problemid, a.problemdesc from omcheckproblem a, omcheckbasisproblemrt b "
				+ "where a.problemid = b.problemid and b.basisid = '" 
				+ dto.getBasisid() + "' order by a.operatedate desc";
		Map proMap = DbUtils.DataQuery("sql", proSql, null, Omcheckproblem.class);
		List problemInfo = (List) proMap.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("basisInfo", basisInfo);
		map.put("flfgInfo", flfgInfo);
		map.put("problemInfo", problemInfo);
        return map;
    }
	
	/**
	 * 
	 * saveCheckBasis的中文名称：保存检查依据
	 * 
	 * saveCheckBasis的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveCheckBasis(HttpServletRequest request, OmcheckbasisDTO dto) {
		try {
			saveCheckBasisImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveCheckBasisImp的中文名称：保存检查依据实现
	 * 
	 * saveCheckBasisImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveCheckBasisImp(HttpServletRequest request, OmcheckbasisDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String basisid = "";
		// 判断id是否为空
		if ((null != dto.getBasisid()) && (!"".equals(dto.getBasisid()))) {
			basisid = dto.getBasisid();
			Omcheckbasis basis = dao.fetch(Omcheckbasis.class, dto.getBasisid());
			basis.setBasisdesc(dto.getBasisdesc()); // 检查依据描述
			basis.setGuide(dto.getGuide()); // 检查指南
			basis.setPunishmeasures(dto.getPunishmeasures()); // 处罚措施
			basis.setType(dto.getType()); // 检查方式
			basis.setTypedesc(dto.getTypedesc()); // 检查方式描述
			basis.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			basis.setOperator(vSysUser.getUserid()); // 经办人id
			basis.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.update(basis);
		} else { 
			basisid = DbUtils.getSequenceStr();
			Omcheckbasis basis = new Omcheckbasis();
			basis.setBasisid(basisid); // 主键id
			basis.setBasisdesc(dto.getBasisdesc()); // 检查依据描述
			basis.setGuide(dto.getGuide()); // 检查指南
			basis.setPunishmeasures(dto.getPunishmeasures()); // 处罚措施
			basis.setType(dto.getType()); // 检查方式
			basis.setTypedesc(dto.getTypedesc()); // 检查方式描述
			basis.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			basis.setOperator(vSysUser.getUserid()); // 经办人id
			basis.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.insert(basis);
			// 添加依据关系
			Omcheckcontentbasisrt conrt = new Omcheckcontentbasisrt();
			conrt.setBasisid(basisid); // 依据id
			conrt.setCbid(DbUtils.getSequenceStr()); // 主键id
			conrt.setContentid(dto.getContentid()); // 检查内容id
			conrt.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			conrt.setOperator(vSysUser.getUserid()); // 经办人id
			conrt.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.insert(conrt);
		}
		
		// 依据法律法规信息
		// 删除依据法律法规关系信息
		dao.clear(Omcheckbasislegalrt.class, Cnd.where("basisid", "=", basisid));
		JSONArray v_flfgArray = null;
		Object[] v_flfgObjArray = null;
		v_flfgArray = JSONArray.fromObject(dto.getFlfgInfo());
		v_flfgObjArray = v_flfgArray.toArray();
		for (int i = 0; i <= v_flfgObjArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_flfgObjArray[i]);

			OmLawContent v_flfg = (OmLawContent) JSONObject.toBean(v_obj, OmLawContent.class);
			// 检查依据-法律条款关系表
			Omcheckbasislegalrt flfgrt = new Omcheckbasislegalrt();
			flfgrt.setBasisid(basisid); // 依据id
			flfgrt.setBlid(DbUtils.getSequenceStr()); // 主键id
			flfgrt.setLegalitemid(v_flfg.getContentid()); // 法律条款表主键
			flfgrt.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			flfgrt.setOperator(vSysUser.getUserid()); // 经办人id
			flfgrt.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.insert(flfgrt); 
		}
		
		// 依据常见问题
		JSONArray v_proArray = null;
		Object[] v_proObjArray = null;
		v_proArray = JSONArray.fromObject(dto.getProblemInfo());
		v_proObjArray = v_proArray.toArray();
		// 删除常见问题关系
		dao.clear(Omcheckbasisproblemrt.class, Cnd.where("basisid", "=", basisid));
		for (int i = 0; i <= v_proObjArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_proObjArray[i]);
			// 依据问题
			Omcheckproblem v_pro = (Omcheckproblem) JSONObject.toBean(v_obj, Omcheckproblem.class);
			String v_proid = DbUtils.getSequenceStr();
			v_pro.setProblemid(v_proid); // id
			v_pro.setProblemdesc(v_pro.getProblemdesc()); // 问题描述
			v_pro.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			v_pro.setOperator(vSysUser.getUserid()); // 经办人id
			v_pro.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.insert(v_pro);
			
			// 检查依据-问题关系表
			Omcheckbasisproblemrt prort = new Omcheckbasisproblemrt();
			prort.setBasisid(basisid); // 依据id
			prort.setBpid(DbUtils.getSequenceStr()); // 主键id
			prort.setProblemid(v_proid); // 法律依据问题表主键
			prort.setOperatedate(SysmanageUtil.currentTime()); // 经办时间
			prort.setOperator(vSysUser.getUserid()); // 经办人id
			prort.setOperatorname(vSysUser.getDescription()); // 经办人名称
			dao.insert(prort); 
		}
	}
	
	/**
	 * 
	 * delCheckBasis的中文名称：删除检查依据
	 * 
	 * delCheckBasis的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delCheckBasis(HttpServletRequest request, OmcheckbasisDTO dto) {
		try {
			delCheckBasisImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * delCheckBasisImp的中文名称：删除检查依据实现
	 * 
	 * delCheckBasisImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void delCheckBasisImp(HttpServletRequest request, OmcheckbasisDTO dto) throws Exception {
		// 删除检查依据信息
		dao.clear(Omcheckbasis.class, Cnd.where("basisid", "=", dto.getBasisid()));
		// 删除检查依据关系
		dao.clear(Omcheckcontentbasisrt.class, Cnd.where("basisid", "=", dto.getBasisid()));
		// 删除依据法律法规关系信息
		dao.clear(Omcheckbasislegalrt.class, Cnd.where("basisid", "=", dto.getBasisid()));
		// 删除常见问题关系
		dao.clear(Omcheckbasisproblemrt.class, Cnd.where("basisid", "=", dto.getBasisid()));
	}

}
