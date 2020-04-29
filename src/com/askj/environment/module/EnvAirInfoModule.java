package com.askj.environment.module;

import com.askj.environment.dto.EnvAirInfoDTO;
import com.askj.environment.entity.EnvAirInfo;
import com.askj.environment.service.EnvAirInfoService;
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
 * EnvAirInfoModule的中文名称：大气信息管理
 * 
 * EnvAirInfoModule的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 17:39:25 
 */
@IocBean
@At("/environment/envAirInfo")
public class EnvAirInfoModule {
	protected final Logger logger = Logger.getLogger(EnvAirInfoModule.class);
	@Inject
	private EnvAirInfoService envAirInfoService;

	/**
	 * 
	 * envAirInfoIndex的中文名称：大气信息管理页面
	 * 
	 * envAirInfoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvAirInfoMainIndex")
	public void envAirInfoIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvAirInfo的中文名称：查询大气信息
	 * 
	 * queryEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvAirInfo(@Param("..") EnvAirInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envAirInfoService.queryEnvAirInfo(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * editEnvAirInfoFormIndex的中文名称：大气信息编辑页面
	 * 
	 * editEnvAirInfoFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvAirInfoForm")
	public void editEnvAirInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvAirInfoDTO的中文名称：查询大气信息DTO
	 * 
	 * queryEnvAirInfoDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvAirInfoDTO(HttpServletRequest request, @Param("..") EnvAirInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envAirInfoService.queryEnvAirInfo(dto, pd);
			List ls = (List) map.get("rows");
			EnvAirInfo envAirInfo = null;
			if (ls != null && ls.size() > 0) {
				envAirInfo = (EnvAirInfo) ls.get(0);
			}
			map.put("data", envAirInfo);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addEnvAirInfo的中文名称：新增大气信息
	 * 
	 * addEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	@At
	@Ok("json")
	public Object addEnvAirInfo(HttpServletRequest request, @Param("..") EnvAirInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envAirInfoService.addEnvAirInfo(request, dto));
	}

	/**
	 * 
	 * updateEnvAirInfo的中文名称：修改大气信息
	 * 
	 * updateEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	@At
	@Ok("json")
	public Object updateEnvAirInfo(HttpServletRequest request, @Param("..") EnvAirInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envAirInfoService.updateEnvAirInfo(request, dto));
	}

	/**
	 * 
	 * delEnvAirInfo的中文名称：删除大气信息
	 * 
	 * delEnvAirInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 17:39:25
	 * 
	 */
	@At
	@Ok("json")
	public Object delEnvAirInfo(HttpServletRequest request, @Param("..") EnvAirInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envAirInfoService.delEnvAirInfo(request, dto));
	}

}
