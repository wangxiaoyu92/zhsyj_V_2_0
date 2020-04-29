package com.askj.spsy.module;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.spsy.service.ComoutService;
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
 * ComoutModule的中文名称：范围外企业管理
 * 
 * ComoutModule的描述：
 * 
 * Written by : zjf
 */
@At("/spsy/comout")
@IocBean
public class ComoutModule {
	protected final Logger logger = Logger.getLogger(ComoutModule.class);
	
	@Inject
	protected ComoutService comoutService;
	
	/**
	 * 
	 * companyOutAdminIndex的中文名称：范围外企业信息管理
	 * companyOutAdminIndex的概要描述：范围外企业信息管理
	 * @param request
	 * written  by ： gjf
	 */
	@At
	@Ok("jsp:/jsp/spsy/comout/companyOutAdmin")
	public void companyOutAdminIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * queryComout的中文名称：查询范围外公司
	 * 
	 * queryComout的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryComout(@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = comoutService.queryComout(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
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
	@At
	@Ok("json")
	public Object comoutAddSave(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		return SysmanageUtil.execAjaxResult(comoutService.comoutAddSave(request, dto));
	}	
	
	/**
	 * 
	 * queryQcompanyoutDTO的中文名称：查询范围外企业DTO
	 * 
	 * queryQcompanyoutDTO的概要说明：
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
	public Object queryQcompanyoutDTO(HttpServletRequest request,
			@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = comoutService.queryComoutEdit(dto, pd);
			List ls = (List) map.get("rows");
			PcompanyDTO v_QcompanyoutDTO = null;
			if (ls != null && ls.size() > 0) {
				v_QcompanyoutDTO = (PcompanyDTO) ls.get(0);
			}
			map.put("data", v_QcompanyoutDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * delCompanyout的中文名称：删除范围外企业信息
	 * 
	 * delCompanyout的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delCompanyout(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		return SysmanageUtil.execAjaxResult(comoutService.delCompanyout(request, dto));
	}	
	
}
