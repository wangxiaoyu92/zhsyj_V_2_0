package com.askj.supervision.module;

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
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.askj.supervision.service.CheckTbodyService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CheckInfoModule的中文名称：检查基本信息管理
 * 
 * CheckInfoModule的描述：
 * 
 * Written by : tmm
 */
@IocBean
@At("/supervision/checkTbodyinfo")
public class CheckTbodyInfoModule {
	protected final Logger logger = Logger.getLogger(CheckTbodyInfoModule.class);
	@Inject
	private CheckTbodyService checkTbodyService;
	/**
	 * 跳转到列表页
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/supervision/tbody/tbodyList")
	public void toTbodyindex(HttpServletRequest request){
		
	}
	
	/**
	 *
	 * getTbodyinfoList的中文名称：得到表格列表
	 *
	 * getTbodyinfoList的概要说明：
	 *
	 * @param request
	 *            Written by :tmm
	 *
	 */
	@At
	@Ok("json")
	public Object getTbodyinfoList(HttpServletRequest request,@Param("..")BsTbodyInfoDTo dto,@Param("..")PagesDTO pd) {
		// 页面初始化
		Map map = new HashMap();
		try {
			map = checkTbodyService.queryTbodyInfoList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
//			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(map, e);
		}
		
	}	
	/**
	 *
	 * saveTbodyInfo的中文名称：跳转保存页面
	 *
	 * saveTbodyInfo的概要说明：
	 *
	 * @param request
	 *            Written by :tmm
	 * @throws Exception 
	 *
	 */
	@At
	@Ok("jsp:/jsp/supervision/tbody/tbodyInfo.jsp")
	public Object toTbodyInfo(HttpServletRequest request , @Param("..") BsTbodyInfoDTo dto ) throws Exception{
			Map map = new HashMap();
			try {
				  List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) checkTbodyService.queryTbodyInfoList(request, dto,null).get("rows");
					if(list.size()>0){
						BsTbodyInfoDTo bsTbodyInfo = list.get(0);
						 map.put("data", bsTbodyInfo);
					}
				return SysmanageUtil.execAjaxResult(map, null);
			} catch (Exception e) {
				return SysmanageUtil.execAjaxResult(map, e);
			}
	}
	
	/**
	 *
	 * saveTbodyInfo的中文名称：跳转保存页面
	 *
	 * saveTbodyInfo的概要说明：
	 *
	 * @param request
	 *            Written by :tmm
	 *
	 */
	@At
	@Ok("jsp:/jsp/supervision/tbody/tbodyForm.jsp")
	public void tosaveTbodyInfo(HttpServletRequest request , @Param("..") BsTbodyInfoDTo dto ){
		
	}
	/**
	 *
	 * saveTbodyInfo的中文名称：保存表格数据
	 *
	 * saveTbodyInfo的概要说明：
	 *
	 * @param request
	 *            Written by :tmm
	 *
	 */
	@At
	@Ok("json")
	public Object saveTbodyInfo(HttpServletRequest request , @Param("..") BsTbodyInfoDTo dto ){
		return SysmanageUtil.execAjaxResult(checkTbodyService.saveTbodyInfo(request, dto));
	}
	
	/**
	 *
	 * getTbodyinfo的中文名称：得到表格对象
	 *
	 * getTbodyinfo的概要说明：
	 *
	 * @param request
	 *            Written by :tmm
	 *
	 */
	@At
	@Ok("json")
	public Object getTbodyinfo(HttpServletRequest request,@Param("..")BsTbodyInfoDTo dto,@Param("..")PagesDTO pd) {
		// 页面初始化
		Map map = new HashMap();
		try {
			  List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) checkTbodyService.queryTbodyInfoList(request, dto,pd).get("rows");
			if(list.size()>0){
				BsTbodyInfoDTo bsTbodyInfo = list.get(0);
				 map.put("data", bsTbodyInfo);
			}
			  return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
//			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(map, e);
		}
		
	}	
}
