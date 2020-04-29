package com.askj.zx.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param; 

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpdcjxxDTO;
import com.askj.zx.service.ZxpdcjxxService;
import com.zzhdsoft.utils.SysmanageUtil;
/**
 * 信息采集
 * @author Administrator
 *
 */
@IocBean
@At("/zx/zxpdcjxx")
@Fail("jsp:/jsp/error/error")
public class ZxpdcjxxModule {
	protected final Logger logger = Logger.getLogger(ZxpdcjxxModule.class);
	@Inject
	protected ZxpdcjxxService zxpdcjxxService;
	 /**
	  * 打开保存 查看 编辑 页面
	  * @param request
	  */
	@At
	@Ok("jsp:/jsp/zx/zxpdcjxx/cjxx")
	public void cjxxIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 保存编辑 新增的信息
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object cjxx(   HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO  dto) throws Exception {
		return SysmanageUtil.execAjaxResult( zxpdcjxxService.saveZxpdcjxx (
				request, dto));
	}
	/** 
	 * 打开查询页面
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdcjxx/querycjxx")
	public void querycjxxIndex(HttpServletRequest request) {
		// 页面初始化
	}
      /**
       * 查询采集到的 数据
       * @param request
       * @param dto
       * @param pd
       * @return
       * @throws Exception
       */
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryDTO(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = zxpdcjxxService.queryZxpdcjxx(dto, pd);
			List ls = (List) map.get("rows");
			ZxpdcjxxDTO zxpdcjxxDTO = null;
			if (ls != null && ls.size() > 0) {
				zxpdcjxxDTO = (ZxpdcjxxDTO) ls.get(0);
			}
			map.put("data", zxpdcjxxDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 删除
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object delcjxx(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO dto) {
		return SysmanageUtil.execAjaxResult(zxpdcjxxService.cjxxdel (request,
				dto));
	}
	
 
	/*
	 * *****************************************
	 * 项目参数管理
	 */
	/**
	 * 
	 *  xmcsupdate的中文名称：更新项目参数
	 *  xmcsupdate的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json") 
	public Object xmcsupdate(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO  dto) throws Exception{
		return  SysmanageUtil.execAjaxResult(zxpdcjxxService.xmcsupdate(request, dto));
	}
	
	
	
	/**
	 * 
	 *  addxmcs的中文名称：保存 更新项目参数
	 *  addxmcs的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object addxmcs(   HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO  dto) throws Exception {
		return SysmanageUtil.execAjaxResult( zxpdcjxxService.addZxpdxmcs (
				request, dto));
}
	
	//初始化参数页面
	@At
	@Ok("jsp:/jsp/zx/zxpdcjxx/xmcs")
	public void xmcsIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 *  xmcs的中文名称：查看项目参数
	 *  xmcs的概要说明：
	 *  @param request
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object xmcs(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = zxpdcjxxService.Zxpdxmcs(dto, pd);
			List ls = (List) map.get("rows");
			ZxpdcjxxDTO zxpdcjxxDTO = null;
			if (ls != null && ls.size() > 0) {
				zxpdcjxxDTO = (ZxpdcjxxDTO) ls.get(0);
			}
			
			map.put("data", zxpdcjxxDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  xmcsFormIndex的中文名称：指向xmcsForm页面
	 *  xmcsFormIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdcjxx/xmcsForm")
	public void xmcsFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *
	 *  xmcsFormaddIndex的中文名称： 指向xmcsFormadd页面
	 *  xmcsFormaddIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdcjxx/xmcsFormadd")
	public void xmcsFormaddIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 *  delxmcs的中文名称：删除项目参数
	 *  delxmcs的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object delxmcs(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO dto) {
		return SysmanageUtil.execAjaxResult(zxpdcjxxService.xmcsdel (request,
				dto));
	}

/**
 * 
 *  xmcsbox的中文名称：项目参数下拉框
 *  xmcsbox的概要说明：
 *  @param request
 *  @param dto
 *  @param pd
 *  @return
 *  Written by:ly
 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@At
	@Ok("json")
  public Object xmcsbox(HttpServletRequest request,
			@Param("..") ZxpdcjxxDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = zxpdcjxxService.xmcsbox(dto, pd);
			List ls = (List) map.get("rows");
			ZxpdcjxxDTO zxpdcjxxDTO = null;
			if (ls != null && ls.size() > 0) {
				zxpdcjxxDTO = (ZxpdcjxxDTO) ls.get(0);
			}
			map.put("data", zxpdcjxxDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
   }
}