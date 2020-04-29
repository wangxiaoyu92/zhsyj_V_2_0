package com.askj.zdhd.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zdhd.dto.ZdhddjDTO;
import com.askj.zdhd.service.ZdhdService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * NewsModule的中文名称：新闻管理
 * 
 * NewsModule的描述：
 * 
 * Written by : gjf
 */
@At("/zdhd")
@IocBean
public class ZdhdModule {
	protected final Logger logger = Logger.getLogger(ZdhdModule.class);
	
	@Inject
	protected ZdhdService zdhdService;
	/**
	 * 
	 * zdhddjMainIndex的中文名称：重大活动登记页面初始化
	 * 
	 * zdhddjMainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zdhd/zdhddjMain")
	public void zdhddjMainIndex(HttpServletRequest request) {
		// 页面初始化
	}


	/**
	 * 
	 * queryZdhddj的中文名称：查询案件登记记录
	 * 
	 * queryZdhddj的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryZdhddj(@Param("..") ZdhddjDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return zdhdService.queryZdhddj(dto, pd);
	}
	
	/**
	 * 
	 * zdhddjForm的中文名称：重大活动登记新增
	 * 
	 * zdhddjForm的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zdhd/zdhddjForm")
	public void zdhddjFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * saveZdhddj的中文名称：保存重大活动登记
	 * 
	 * saveZdhddj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveZdhddj(HttpServletRequest request,
			@Param("..") ZdhddjDTO dto)throws Exception {
		return SysmanageUtil.execAjaxResult(zdhdService.saveZdhddj(request,
				dto));
	}	
	
	/**
	 * 
	 * queryZdhddjDTO的中文名称：查询案件登记DTO
	 * 
	 * queryZdhddjDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryZdhddjDTO(HttpServletRequest request,
			@Param("..") ZdhddjDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = zdhdService.queryZdhddj(dto, pd);
			List ls = (List) map.get("rows");
			ZdhddjDTO v_zdhddjDTO = null;
			if (ls != null && ls.size() > 0) {
				v_zdhddjDTO = (ZdhddjDTO) ls.get(0);
			}
			map.put("data", v_zdhddjDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * delZdhddj的中文名称：删除重大活动登记信息
	 * 
	 * delZdhddj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delZdhddj(HttpServletRequest request,
			@Param("..") ZdhddjDTO dto) {
		return SysmanageUtil.execAjaxResult(zdhdService.delZdhddj(request,
				dto));
	}	
	
	/**
	 * 
	 * zdhdjgjcMainIndex的中文名称：重大活动监管监察页面初始化
	 * 
	 * zdhdjgjcMainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zdhd/zdhdjgjcMain")
	public void zdhdjgjcMainIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
}
