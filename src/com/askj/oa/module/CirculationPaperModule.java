package com.askj.oa.module;

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
import com.askj.oa.dto.CirculationpaperDTO;
import com.askj.oa.entity.Circulationpaper;
import com.askj.oa.service.CirculationPaperService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CirculationPaperModule的中文名称：传阅信息管理
 * 
 * CirculationPaperModule的描述：
 * 
 * Written by : sunyifeng at 2016-06-30 18:11:34 
 */
@IocBean
@At("/egovernment/circulationPaper")
public class CirculationPaperModule {
	protected final Logger logger = Logger.getLogger(CirculationPaperModule.class);
	@Inject
	private CirculationPaperService circulationPaperService;

	/**
	 * 
	 * circulationPaperIndex的中文名称：传阅信息管理页面
	 * 
	 * circulationPaperIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	@At
	@Ok("jsp:/jsp/oa/CirculationPaperMainIndex")
	public void circulationPaperIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryCirculationPaper的中文名称：查询传阅信息
	 * 
	 * queryCirculationPaper的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryCirculationpaper(@Param("..") CirculationpaperDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = circulationPaperService.queryCirculationpaper(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * editCirculationPaperFormIndex的中文名称：传阅信息编辑页面
	 * 
	 * editCirculationPaperFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	@At
	@Ok("jsp:/jsp/oa/CirculationPaperForm")
	public void editCirculationPaperFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryCirculationpaperDTO的中文名称：查询传阅信息DTO
	 * 
	 * queryCirculationpaperDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryCirculationpaperDTO(HttpServletRequest request, @Param("..") CirculationpaperDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = circulationPaperService.queryCirculationpaper(dto, pd);
			List ls = (List) map.get("rows");
			Circulationpaper circulationPaper = null;
			if (ls != null && ls.size() > 0) {
				circulationPaper = (Circulationpaper) ls.get(0);
			}
			map.put("data", circulationPaper);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addCirculationPaper的中文名称：新增传阅信息
	 * 
	 * addCirculationPaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	@At
	@Ok("json")
	public Object addCirculationpaper(HttpServletRequest request, @Param("..") CirculationpaperDTO dto) {
		return SysmanageUtil.execAjaxResult(circulationPaperService.addCirculationpaper(request, dto));
	}

	/**
	 * 
	 * updateCirculationPaper的中文名称：修改传阅信息
	 * 
	 * updateCirculationPaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	@At
	@Ok("json")
	public Object updateCirculationpaper(HttpServletRequest request, @Param("..") CirculationpaperDTO dto) {
		return SysmanageUtil.execAjaxResult(circulationPaperService.updateCirculationpaper(request, dto));
	}

	/**
	 * 
	 * delCirculationPaper的中文名称：删除传阅信息
	 * 
	 * delCirculationPaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	@At
	@Ok("json")
	public Object delCirculationpaper(HttpServletRequest request, @Param("..") CirculationpaperDTO dto) {
		return SysmanageUtil.execAjaxResult(circulationPaperService.delCirculationpaper(request, dto));
	}

}
