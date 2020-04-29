package com.askj.zfba.module;

import javax.servlet.http.HttpServletRequest;

import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zfba.dto.ZfajzfwsmbDTO;
import com.askj.zfba.service.WsmbglService;

import java.util.HashMap;
import java.util.Map;


/**
 * 
 * WsmbglModule的中文名称：文书模板管理
 *
 * WsmbglModule的描述
 *
 * Written by CatchU 2016年5月18日下午6:01:55
 */
@At("/zfba/wsmbgl")
@IocBean
public class WsmbglModule {
	protected final Logger logger = Logger.getLogger(WsmbglModule.class);
	
	@Inject
	protected WsmbglService wsmbglService;
	
	/*******************文书模板管理start***************************/
	
	/**
	 * 
	 * wsmbglIndex的中文名称:文书模板管理页面初始化
	 *
	 * wsmbglIndex的概要说明:
	 *
	 * @param request
	 * Written by CatchU 2016年5月18日下午5:39:39
	 */
	@At
	@Ok("jsp:/jsp/zfba/wsmbgl")
	public void wsmbglIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryWsmb的中文名称:查询文书模板
	 *
	 * queryWsmb的概要说明:
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by CatchU 2016年5月18日下午5:42:54
	 */
	@At
	@Ok("json")
	public Object queryWsmb(@Param("..") ZfajzfwsmbDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = wsmbglService.queryWsmb(dto, pd);
			return SysmanageUtil.execAjaxResult(mapc, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
//		return wsmbglService.queryWsmb(dto, pd);
	}	
	/*******************文书模板管理end***************************/


}
