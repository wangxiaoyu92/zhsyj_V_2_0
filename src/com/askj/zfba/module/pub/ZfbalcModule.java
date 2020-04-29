package com.askj.zfba.module.pub;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.zfba.dto.ZfbalcDTO;
import com.askj.zfba.service.pub.ZfbalcService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * ZfbalcModule的中文名称：执法办案流程
 * 
 * ZfbalcModule的描述：
 * 
 * Written by : gjf
 */
@At("/pub/zfbalc")
@IocBean
public class ZfbalcModule {
	protected final Logger logger = Logger.getLogger(ZfbalcModule.class);
	
	@Inject
	protected ZfbalcService zfbalcService;	
	
	
	/**
	 * 
	 * ajslMainIndex的中文名称：初始化案件受理页面
	 * 
	 * ajslMainIndex的概要说明：
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbalc/ajslMain")
	public void ajslMainIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}
	
	/**
	 * 
	 * ajjsIndex的中文名称：案件结束受理页面
	 * 
	 * ajjsIndex的概要说明：
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbalc/ajjs")
	public void ajjsIndex(HttpServletRequest request)
			throws Exception {
		// 初始化页面
	}	
	
	/**
	 * 
	 * saveAjjs的中文名称：案件结束保存
	 * 
	 * saveAjjs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveAjjs(HttpServletRequest request,
			@Param("..") ZfbalcDTO dto) {
		return SysmanageUtil.execAjaxResult(zfbalcService.saveAjjs(request,
				dto));
	}	
	
	/**
	 * 
	 *  lianIndex的中文名称：立案
	 *  lianIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbalc/lian") 
	public void lianIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
}
