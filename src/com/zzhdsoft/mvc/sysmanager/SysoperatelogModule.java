package com.zzhdsoft.mvc.sysmanager;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog;
import com.zzhdsoft.siweb.service.sysmanager.SysoperatelogService;
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
 * SysoperatelogModule的中文名称：系统操作日志module
 * 
 * SysoperatelogModule的描述：
 * 
 * Written by : zjf
 */
@IocBean
@At("/sysmanager/sysoperatelog")
public class SysoperatelogModule {
	protected final Logger logger = Logger.getLogger(SysoperatelogModule.class);
	@Inject
	private SysoperatelogService sysoperatelogService;

	/**
	 * 
	 *  sysoperatelogIndex的中文名称：操作日志管理页面
	 *
	 *  sysoperatelogIndex的概要说明：
	 *
	 *  @param request
	 *  Written  by  : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysoperatelog")
	public void sysoperatelogIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysoperatelog的中文名称：查询系统操作日志
	 * 
	 * querySysoperatelog的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysoperatelog(@Param("..") Sysoperatelog dto,
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysoperatelogService.querySysoperatelog(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * querySysoperatelogPrint的中文名称：查询系统操作日志打印
	 * 
	 * querySysoperatelogPrint的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysoperatelogPrint(@Param("..") Sysoperatelog dto,
			@Param("..") PagesDTO pd) throws Exception {
		Object v_obj = sysoperatelogService.querySysoperatelogPrint(dto, pd);
		return v_obj;
	}
	
}
