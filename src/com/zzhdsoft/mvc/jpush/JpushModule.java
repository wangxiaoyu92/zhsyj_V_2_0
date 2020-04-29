package com.zzhdsoft.mvc.jpush;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger; 
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushInfoDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushlogDTO;
import com.zzhdsoft.siweb.service.jpush.JpushService;
import com.zzhdsoft.utils.SysmanageUtil;
 
/**
 * 
 * JpushModule的中文名称：极光推送管理
 * 
 * JpushModule的概要说明：
 *
 * Written by : zy
 */
@IocBean
@At("/jpush")
@Fail("jsp:/jsp/error/error")
public class JpushModule {
	
	protected final Logger logger = Logger.getLogger(JpushModule.class);
	
	@Inject
	protected JpushService jpushService;
	
	/**
	 * jpushMainIndex : 极光推送主页面
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jpush/jpushMain")
	public void jpushMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * sendMessage的中文名称：极光推送消息
	 * 
	 * sendMessage的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object sendMessage(HttpServletRequest request, @Param("..") JpushInfoDTO dto ){
		return SysmanageUtil.execAjaxResult(jpushService.sendMessage(request, dto));
	}
	
	/**
	 * 
	 * jpushLogIndex的中文名称：极光推送日志页面
	 * 
	 * jpushLogIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/jpush/jpushLog")
	public void jpushLogIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryJpushLog的中文名称：查询极光推送记录
	 * 
	 * queryJpushLog的概要说明：
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object queryJpushLog(HttpServletRequest request, @Param("..") JpushlogDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return jpushService.queryJpushLog(request, dto, pd);
	}
	 
}
