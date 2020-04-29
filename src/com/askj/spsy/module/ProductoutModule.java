package com.askj.spsy.module;

import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.service.ComoutService;
import com.askj.spsy.service.ProductoutService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * ProductoutModule的中文名称：范围外产品管理
 * 
 * ProductoutModule的描述：
 * 
 * Written by : zjf
 */
@At("/spsy/productout")
@IocBean
public class ProductoutModule {
	protected final Logger logger = Logger.getLogger(ProductoutModule.class);
	
	@Inject
	protected ProductoutService productoutService;
	@Inject
	protected ComoutService comoutService;	
	
	/**
	 * 
	 * productOutAdminIndex的中文名称：范围外企业产品管理
	 * productOutAdminIndex的概要描述：范围外企业产品管理
	 * @param request
	 * written  by ： gjf
	 * @throws Exception 
	 */
	@At
	@Ok("jsp:/jsp/spsy/productout/productOutAdmin")
	public void productOutAdminIndex(HttpServletRequest request) throws Exception {
       String v_comtree = productoutService.queryComoutListAsync(request);
       request.setAttribute("comtree", v_comtree);
	}	
	
	/**
	 * 
	 * queryQproductout的中文名称：查询范围外企业产品信息
	 * 
	 * queryQproductout的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryQproductout(@Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = productoutService.queryQproductout(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * productoutAddSave的中文名称：范围外公司产品新增保存
	 * 
	 * productoutAddSave的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object productoutAddSave(HttpServletRequest request, @Param("..") QproductDTO dto) {
		return SysmanageUtil.execAjaxResult(productoutService.productoutAddSave(request, dto));
	}
	
	/**
	 * 
	 * queryQproductoutDTO的中文名称：查询范围外企业产品dto
	 * 
	 * queryQproductoutDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryQproductoutDTO(HttpServletRequest request,
			@Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = productoutService.queryQproductout(dto, pd);
			List ls = (List) map.get("rows");
			QproductDTO v_QproductDTO = null;
			if (ls != null && ls.size() > 0) {
				v_QproductDTO = (QproductDTO) ls.get(0);
			}
			map.put("data", v_QproductDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
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
	@At
	@Ok("json")
	public Object delProductout(HttpServletRequest request, @Param("..") QproductDTO dto) {
		return SysmanageUtil.execAjaxResult(productoutService.delProductout(request, dto));
	}	
		
}
