package com.askj.tmsyj.tmzf.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.askj.tmsyj.tmzf.service.TmzfApiService;
import com.askj.zfba.dto.ZfajdjDTO;
import com.askj.zfba.dto.ZfajzfwsDTO;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PzfryDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * TmzfApiModule的中文名称：【透明执法】api接口module
 * 
 * TmzfApiModule的描述：
 * 
 * @author ：zjf
 * @version ：V1.0
 */
@At("api/tmzf/")
@IocBean
public class TmzfApiModule extends BaseModule {
	@Inject
	protected TmzfApiService tmzfApiService;

	/**
	 * 
	 * getPzfryList的中文名称：获取执法人员列表
	 *
	 * getPzfryList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@At
	@Ok("json")
	public Object getPzfryList(HttpServletRequest request,
			@Param("..") PzfryDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = tmzfApiService.getPzfryList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getZfajList的中文名称：获取执法案件列表
	 *
	 * getZfajList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@At
	@Ok("json")
	public Object getZfajList(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = tmzfApiService.getZfajList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * getZfajPfjList的中文名称：获取执法案件附件列表
	 *
	 * getZfajPfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@At
	@Ok("json")
	public Object getZfajPfjList(HttpServletRequest request,
			@Param("..") ZfajzfwsDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = tmzfApiService.getZfajPfjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

}
