package com.askj.environment.module;

import com.askj.environment.dto.EnvSoilInfoDTO;
import com.askj.environment.entity.EnvSoilInfo;
import com.askj.environment.service.EnvSoilInfoService;
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
 * EnvSoilInfoModule的中文名称：土壤信息管理
 * 
 * EnvSoilInfoModule的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 14:04:04 
 */
@IocBean
@At("/environment/envSoilInfo")
public class EnvSoilInfoModule {
	protected final Logger logger = Logger.getLogger(EnvSoilInfoModule.class);
	@Inject
	private EnvSoilInfoService envSoilInfoService;

	/**
	 * 
	 * envSoilInfoIndex的中文名称：土壤信息管理页面
	 * 
	 * envSoilInfoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvSoilInfoMainIndex")
	public void envSoilInfoIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvSoilInfo的中文名称：查询土壤信息
	 * 
	 * queryEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvSoilInfo(@Param("..") EnvSoilInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envSoilInfoService.queryEnvSoilInfo(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * editEnvSoilInfoFormIndex的中文名称：土壤信息编辑页面
	 * 
	 * editEnvSoilInfoFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvSoilInfoForm")
	public void editEnvSoilInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvSoilInfoDTO的中文名称：查询土壤信息DTO
	 * 
	 * queryEnvSoilInfoDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvSoilInfoDTO(HttpServletRequest request, @Param("..") EnvSoilInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envSoilInfoService.queryEnvSoilInfo(dto, pd);
			List ls = (List) map.get("rows");
			EnvSoilInfo envSoilInfo = null;
			if (ls != null && ls.size() > 0) {
				envSoilInfo = (EnvSoilInfo) ls.get(0);
			}
			map.put("data", envSoilInfo);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addEnvSoilInfo的中文名称：新增土壤信息
	 * 
	 * addEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	@At
	@Ok("json")
	public Object addEnvSoilInfo(HttpServletRequest request, @Param("..") EnvSoilInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envSoilInfoService.addEnvSoilInfo(request, dto));
	}

	/**
	 * 
	 * updateEnvSoilInfo的中文名称：修改土壤信息
	 * 
	 * updateEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	@At
	@Ok("json")
	public Object updateEnvSoilInfo(HttpServletRequest request, @Param("..") EnvSoilInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envSoilInfoService.updateEnvSoilInfo(request, dto));
	}

	/**
	 * 
	 * delEnvSoilInfo的中文名称：删除土壤信息
	 * 
	 * delEnvSoilInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 14:04:04
	 * 
	 */
	@At
	@Ok("json")
	public Object delEnvSoilInfo(HttpServletRequest request, @Param("..") EnvSoilInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envSoilInfoService.delEnvSoilInfo(request, dto));
	}

}
