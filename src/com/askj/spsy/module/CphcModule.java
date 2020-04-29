package com.askj.spsy.module;

import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.spsy.dto.QproductclsyjlbDTO;
import com.askj.spsy.dto.QproductpcDTO;
import com.askj.spsy.service.CphcService;
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
import java.util.Map;

/**
 * 
 * cphcModule的中文名称：产品耗材管理
 * 
 * cphcModule的描述：
 * 
 * Written by : gjf
 */
@At("/spsy/cphc")
@IocBean
public class CphcModule {
	protected final Logger logger = Logger.getLogger(CphcModule.class);
	
	@Inject
	protected CphcService cphcService;

	/**
	 * 
	 * cphcAdminIndex的中文名称：产品耗材管理
	 * cphcAdminIndex的概要描述：产品耗材管理
	 * @param request
	 * written  by ： gjf
	 * @throws Exception 
	 */
	@At
	@Ok("jsp:/jsp/spsy/cphc/cphcAdmin")
	public void cphcAdminIndex(HttpServletRequest request) throws Exception {
	}	
	
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
	@SuppressWarnings("unchecked")
	@At
	@Ok("json")
	public Object queryCppc(@Param("..") QproductpcDTO dto, @Param("..") PagesDTO pd) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			result = cphcService.queryCppc(dto, pd);
			return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
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
	@SuppressWarnings("unchecked")
	@At
	@Ok("json")
	public Object queryCphc(@Param("..") QproductclsyjlbDTO dto, @Param("..") PagesDTO pd) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			result = cphcService.queryCphc(dto, pd);
			return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryCphcSycl的中文名称：查询产品剩余材料
	 * 
	 * queryCphcSycl的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("unchecked")
	@At
	@Ok("json")
	public Object queryCphcSycl(@Param("..") QproductclsyjlbDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			result = cphcService.queryCphcSycl(dto, pd);
			return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
	}	
	
	/**
	 * 
	 * cphcAddIndex的中文名称：产品耗材管理
	 * cphcAddIndex的概要描述：产品耗材管理
	 * @param request
	 * written  by ： gjf
	 * @throws Exception 
	 */
	@At
	@Ok("jsp:/jsp/spsy/cphc/cphcAdd")
	public void cphcAddIndex(HttpServletRequest request) throws Exception {
	}	
	
    /**
     * cphcAddSave的中文名称：添加产品耗材
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object cphcAddSave(HttpServletRequest request, @Param("..") QledgerstockDTO dto) {
    	return SysmanageUtil.execAjaxResult(cphcService.cphcAddSave(request, dto));
    }	
	
	/**
	 * 
	 * delCphc的中文名称：删除产品耗材
	 * 
	 * delCphc的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object delCphc(HttpServletRequest request, @Param("..") QproductclsyjlbDTO dto) {
		return SysmanageUtil.execAjaxResult(cphcService.delCphc(request, dto));
	}    
		
}
