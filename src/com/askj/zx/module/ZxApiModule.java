package com.askj.zx.module;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.zx.dto.ZxpdjgDTO;
import com.askj.zx.service.ZxpdjgService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

@At("api/zx")
@IocBean
public class ZxApiModule extends BaseModule{

	@Inject
	private ZxpdjgService zxpdjgService; 
	/**
	 * 
	 * queryZxpdjg的中文名称：征信评定结果列表
	 * 
	 * queryZxpdjg的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object queryZxpdjg(@Param("..") ZxpdjgDTO dto,@Param("..") PagesDTO pd) throws Exception{
		return SysmanageUtil.execAjaxResult(zxpdjgService.queryZxpdjg(dto,pd),null);
	}
	
	/**
	 * 
	 * 添加企业诚信评定信息
	 */
	@At
	@Ok("json")
	public Object saveZxpdjg(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.saveZxpdjg(request,dto));
	}
	
	/**
	 * 
	 * 删除诚信评定
	 * 
	 */
	@At
	@Ok("json")
	public Object delZxpdjg(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.delZxpdjg(request, dto));
	}
}
