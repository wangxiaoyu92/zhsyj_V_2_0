package com.askj.spsy.module;

import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.service.SpsyApiService;
import com.zzhdsoft.siweb.dto.FjDTO;
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
 * SpsyApiModule的中文名称：食品溯源对外接口Moudle
 * 
 * SpsyApiModule的描述：
 * 
 * Written by : zy
 */
@At("/api/spsy")
@IocBean
public class SpsyApiModule {
	protected final Logger logger = Logger.getLogger(SpsyApiModule.class);
	
	@Inject
	protected SpsyApiService spsyApiService;
	
	/**
	 * 
	 * getComProductList的中文名称：获取企业产品列表
	 * 
	 * getComProductList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getComProductList(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = spsyApiService.getComProductList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}	
	
	/**
	 * 
	 * getComProductDetailList的中文名称：获取企业单个产品的明细信息
	 * 
	 * getComProductDetailList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getComProductDetailList(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = spsyApiService.getComProductDetailList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * getComProductPicList的中文名称：获取企业产品图片列表
	 * 
	 * getComProductPicList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getComProductPicList(HttpServletRequest request, @Param("..") FjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = spsyApiService.getComProductPicList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}	
	
}
