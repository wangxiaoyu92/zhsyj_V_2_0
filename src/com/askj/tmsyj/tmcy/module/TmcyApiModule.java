package com.askj.tmsyj.tmcy.module;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.tmsyj.tmcy.dto.HcycdDTO;
import com.askj.tmsyj.tmcy.dto.HcyjxxjlDTO;
import com.askj.tmsyj.tmcy.dto.HsplyDTO;
import com.askj.tmsyj.tmcy.dto.HyzcpDTO;
import com.askj.tmsyj.tmcy.service.HcycdService;
import com.askj.tmsyj.tmcy.service.TmcyApiService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * TmcyApiModule的中文名称：【透明餐饮子系统】api接口module
 * 
 * TmcyApiModule的描述：
 * 
 * @author ：zjf
 * @version ：V1.0
 */
@At("api/tmcy/")
@IocBean
public class TmcyApiModule extends BaseModule {
	@Inject
	protected TmcyApiService tmcyApiService;

	@Inject
	private HcycdService hcycdService; // 用于透明餐饮管理
	/**
	 * 
	 * getSplyList的中文名称：获取食品留样列表
	 * 
	 * getSplyList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSplyList(HttpServletRequest request, @Param("..") HsplyDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = tmcyApiService.getSplyList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * getYzcpList的中文名称：获取一周菜谱列表
	 * 
	 * getYzcpList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getYzcpList(HttpServletRequest request, @Param("..") HyzcpDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = tmcyApiService.getYzcpList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 * 
	 * getCyjxxjlList的中文名称：获取餐饮具消毒记录列表
	 * 
	 * getCyjxxjlList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCyjxxjlList(HttpServletRequest request, @Param("..") HcyjxxjlDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = tmcyApiService.getCyjxxjlList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * getCompanyMenu的中文名称：查询企业菜谱
	 * getCompanyMenu的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCompanyMenu(HttpServletRequest request, 
			@Param("..")HcycdDTO dto,  @Param("..")PagesDTO pd){
		Map map = new HashMap();
		try {
			map = hcycdService.QueryCd(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveCompanyMenu保存企业菜单
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object saveCompanyMenu(HttpServletRequest request, @Param("..")HcycdDTO dto){
		return  SysmanageUtil.execAjaxResult(hcycdService.Savecd(request, dto));
	}
	
	/**
	 * 
	 * deleteCompanyMenu : 删除企业菜单
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object deleteCompanyMenu(HttpServletRequest request, @Param("..")HcycdDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelCd(request, dto));
	}
	
	/**
	 * 
	 * getFoodRetentionList : 查询食品留样
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getFoodRetentionList(HttpServletRequest request,
			@Param("..") HsplyDTO dto, @Param("..")PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = hcycdService.QuerySply(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveFoodRetention ： 保存食品留样
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object saveFoodRetention(HttpServletRequest request, @Param("..") HsplyDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveSply(request, dto));
	}
	
	/**
	 * 
	 * deleteFoodRetention : 删除食品留样
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object deleteFoodRetention(HttpServletRequest request, @Param("..") HsplyDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelSply(request, dto));
	}
	
	/**
	 * 
	 * getWeekMenu : 查询一周菜谱
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getWeekMenu(HttpServletRequest request, 
			@Param("..") HyzcpDTO dto,@Param("..")PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = hcycdService.QueryYzcp(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		} 
	}
	
	/**
	 * 
	 * saveWeekMenu ： 保存一周菜谱
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object saveWeekMenu(HttpServletRequest request, @Param("..") HyzcpDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveYzcp(request, dto));
	}
	
	/**
	 * 
	 * deleteWeekMenu : 删除一周菜谱
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object deleteWeekMenu(HttpServletRequest request, @Param("..") HyzcpDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelYzcp(request, dto));
	}
	
	/**
	 * getTablewareXxjl : 查询餐具洗消记录
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getTablewareXxjl(HttpServletRequest request, 
			@Param("..") HcyjxxjlDTO dto,@Param("..")PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = hcycdService.QueryXxjl(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		} 
	}
	
	/**
	 * 
	 * saveTablewareXxjl的中文名称：保存或更新一条洗消记录
	 * 
	 * saveTablewareXxjl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveTablewareXxjl(HttpServletRequest request, @Param("..")HcyjxxjlDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveXxjl(request, dto));
	}
	
	/**
	 * 
	 * delTablewareXxjl的中文名称：删除一条洗消记录
	 * 
	 * delTablewareXxjl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delTablewareXxjl(@Param("..")HcyjxxjlDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelXxjl(dto));
	}
	
	
	
}
