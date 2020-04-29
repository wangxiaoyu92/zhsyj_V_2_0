package com.askj.environment.module;

import com.askj.environment.dto.EnvWalterInfoDTO;
import com.askj.environment.entity.EnvWalterInfo;
import com.askj.environment.service.EnvWalterInfoService;
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
 * EnvWalterInfoModule的中文名称：水信息管理
 * 
 * EnvWalterInfoModule的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 18:42:43 
 */
@IocBean
@At("/environment/envWalterInfo")
public class EnvWalterInfoModule {
	protected final Logger logger = Logger.getLogger(EnvWalterInfoModule.class);
	@Inject
	private EnvWalterInfoService envWalterInfoService;

	/**
	 * 
	 * envWalterInfoIndex的中文名称：水信息管理页面
	 * 
	 * envWalterInfoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvWalterInfoMainIndex")
	public void envWalterInfoIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvWalterInfo的中文名称：查询水信息
	 * 
	 * queryEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvWalterInfo(@Param("..") EnvWalterInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envWalterInfoService.queryEnvWalterInfo(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * editEnvWalterInfoFormIndex的中文名称：水信息编辑页面
	 * 
	 * editEnvWalterInfoFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	@At
	@Ok("jsp:/jsp/environment/EnvWalterInfoForm")
	public void editEnvWalterInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEnvWalterInfoDTO的中文名称：查询水信息DTO
	 * 
	 * queryEnvWalterInfoDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEnvWalterInfoDTO(HttpServletRequest request, @Param("..") EnvWalterInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = envWalterInfoService.queryEnvWalterInfo(dto, pd);
			List ls = (List) map.get("rows");
			EnvWalterInfo envWalterInfo = null;
			if (ls != null && ls.size() > 0) {
				envWalterInfo = (EnvWalterInfo) ls.get(0);
			}
			map.put("data", envWalterInfo);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addEnvWalterInfo的中文名称：新增水信息
	 * 
	 * addEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	@At
	@Ok("json")
	public Object addEnvWalterInfo(HttpServletRequest request, @Param("..") EnvWalterInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envWalterInfoService.addEnvWalterInfo(request, dto));
	}

	/**
	 * 
	 * updateEnvWalterInfo的中文名称：修改水信息
	 * 
	 * updateEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	@At
	@Ok("json")
	public Object updateEnvWalterInfo(HttpServletRequest request, @Param("..") EnvWalterInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envWalterInfoService.updateEnvWalterInfo(request, dto));
	}

	/**
	 * 
	 * delEnvWalterInfo的中文名称：删除水信息
	 * 
	 * delEnvWalterInfo的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-29 18:42:43
	 * 
	 */
	@At
	@Ok("json")
	public Object delEnvWalterInfo(HttpServletRequest request, @Param("..") EnvWalterInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(envWalterInfoService.delEnvWalterInfo(request, dto));
	}

}
