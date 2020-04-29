package com.askj.supervision.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.supervision.dto.OmcheckbasisDTO;
import com.askj.supervision.service.CheckBasisService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  CheckBasisModule的中文名称：检查依据管理module
 *
 *  CheckBasisModule的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
@IocBean
@At("/supervision/checkbasis/")
public class CheckBasisModule {
	
	protected final Logger logger = Logger.getLogger(CheckBasisModule.class);
	
	@Inject
	private CheckBasisService checkBasisService;

	/**
	 * 
	 * checkBasisManagerIndex的中文名称：检查依据管理页面初始化
	 * 
	 * checkBasisManagerIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/supervision/basis/checkBasisManager")
	public void checkBasisManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * checkBasisFormIndex的中文名称：检查依据信息页面初始化
	 * 
	 * checkBasisFormIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/supervision/basis/checkBasisForm")
	public void checkBasisFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryBasisZTreeAsync的中文名称：查询检查依据树
	 * 
	 * queryBasisZTreeAsync的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryBasisZTreeAsync(HttpServletRequest request)
			throws Exception {
		try {
			List basisTreeList = (List) checkBasisService.queryBasisZTreeAsync(request);
			String treeData = Json.toJson(basisTreeList, JsonFormat.compact());
			Map m = new HashMap();
			m.put("orgData", treeData);
			m.put("isLastNode", true); // 最后一级节点
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
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
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCheckBasis(HttpServletRequest request, 
			@Param("..") OmcheckbasisDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = checkBasisService.queryCheckBasis(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); 
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); 
		}
	}
	
	/**
	 * 
	 * queryCheckBasisObj的中文名称：查询检查依据信息
	 * 
	 * queryCheckBasisObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCheckBasisObj(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		Map map = new HashMap();
		try {
			map = checkBasisService.queryCheckBasisObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null); 
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); 
		}
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
	@At
	@Ok("json")
	public Object saveCheckBasis(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		return SysmanageUtil.execAjaxResult(checkBasisService.saveCheckBasis(request, dto));
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
	@At
	@Ok("json")
	public Object delCheckBasis(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
		return SysmanageUtil.execAjaxResult(checkBasisService.delCheckBasis(request, dto));
	}

}
