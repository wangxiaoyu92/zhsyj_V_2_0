package com.askj.emergency.module;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.emergency.dto.EmeventcheckinDTO;
import com.askj.emergency.service.EmergencyService;
import com.askj.zx.service.ZxpdjgService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.utils.SysmanageUtil;

@At("api/emergency")
@IocBean
public class EmergencyApiModule extends BaseModule {
	@Inject
	protected EmergencyService emergencyService;
	
	/**
	 * 
	 * delEmergency的中文名称：删除应急登记信息
	 * 
	 * delEmergency的概要说明：
	 * 
	 */
	@At
	@Ok("json")
	public Object delEmergency(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.delEmergency(request, dto));
	}
	
}
