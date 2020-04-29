package com.askj.train.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.train.dto.OtsCourseDTO;
import com.askj.train.dto.OtsCoursewareDTO;
import com.askj.train.service.CourseService;
import com.askj.train.service.CoursewareService;
import com.askj.train.service.TrainApiService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  TrainApiModule的中文名称：【培训系统】api接口module
 *
 *  TrainApiModule的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
@At("api/train/")
@IocBean
public class TrainApiModule extends BaseModule {
	@Inject
	protected TrainApiService trainApiService;
	@Inject
	protected CourseService courseService;
	@Inject
	protected CoursewareService coursewareService;

	/**
	 * 
	 * queryMyCourses的中文名称：查询我的课程
	 * 
	 * queryMyCourses的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryMyCourses(HttpServletRequest request, 
			@Param("..") OtsCourseDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = courseService.queryMyCourse(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryCourseObj的中文名称：查看课程信息
	 * 
	 * queryCourseObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCourseObj(HttpServletRequest request, @Param("..") OtsCourseDTO dto) {
		Map map = new HashMap();
		try {
			map = courseService.queryCourseObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryCourseWares的中文名称：查询课程包含的课件
	 * 
	 * queryCourseWares的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCourseWares(HttpServletRequest request, 
			@Param("..") OtsCourseDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = courseService.queryCourseWareOfCourse(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryCoursewareObj的中文名称：查询课件详细信息
	 * 
	 * queryCoursewareObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCoursewareObj(HttpServletRequest request, 
			@Param("..") OtsCoursewareDTO dto) {
		Map map = new HashMap();
		try {
			map = coursewareService.queryCoursewareObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * checkWareIsExit的中文名称：检查文件是否存在
	 * 
	 * checkWareIsExit的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object checkWareIsExit(HttpServletRequest request, 
			@Param("..") OtsCoursewareDTO dto) {
		Map map = new HashMap();
		try {
			map = coursewareService.checkWareIsExit(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * showCourseWareIndex的中文名称：查看图文课件
	 * 
	 * showCourseWareIndex的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/train/courseware/picwordWareShow")
	public void showPicwordIndex(HttpServletRequest request, @Param("..") OtsCoursewareDTO dto){
		Map map = coursewareService.queryCoursewareObj(request, dto);
		request.setAttribute("courseware", map.get("courseware"));
	}	
	
}
