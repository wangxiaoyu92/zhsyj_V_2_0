package com.askj.train.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.train.dto.OtsCoursewareDTO;
import com.askj.train.service.CoursewareService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CoursewareModule的中文名称：培训子系统-课件管理
 * 
 * CoursewareModule的描述：
 * 
 * @author : wcl
 */
@At("/train/courseware")
@IocBean
public class CoursewareModule {

	protected final Logger logger = Logger.getLogger(CoursewareModule.class);
	
	@Inject
	private CoursewareService coursewareService;
	
	/**
	 * 
	 * coursewareManagerIndex的中文名称：课件管理页面
	 * 
	 * coursewareManagerIndex的概要说明：
	 *
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/train/courseware/CoursewareManager")
	public void coursewareManagerIndex(HttpServletRequest request){
		//初始化页面
	}
	
	/**
	 * 
	 * coursewareInfoFormIndex的中文名称：课件信息页面初始化
	 * 
	 * coursewareInfoFormIndex的概要说明：
	 *
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/train/courseware/CoursewareInfoForm")
	public void coursewareInfoFormIndex(HttpServletRequest request){
		
	}
	
	/**
	 * 
	 * showCourseWareIndex的中文名称：查看课件
	 * 
	 * showCourseWareIndex的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/train/courseware/showCourseWare")
	public void showCourseWareIndex(HttpServletRequest request, @Param("..") OtsCoursewareDTO dto){
		Map map = coursewareService.queryCoursewareObj(request, dto);
		request.setAttribute("courseware", map.get("courseware"));
	}
	
	/**
	 * 
	 * queryCourseInfos的中文名称：查询课件列表
	 * 
	 * queryCourseInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCoursewareInfos(HttpServletRequest request, 
			@Param("..") OtsCoursewareDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = coursewareService.queryCoursewareInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * saveCoursewareInfo的中文名称：保存课件信息
	 * 
	 * saveCoursewareInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object saveCoursewareInfo(HttpServletRequest request, @Param("..") OtsCoursewareDTO dto) {
		return SysmanageUtil.execAjaxResult(coursewareService.saveCoursewareInfos(request, dto));
	}

	/**
	 * 
	 * dellCoursewareInfo的中文名称：删除课件信息
	 * 
	 * dellCoursewareInfo的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object dellCoursewareInfo(HttpServletRequest request){
		return SysmanageUtil.execAjaxResult(coursewareService.delCoursewareInfos(request));
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
	 * @author : wcl
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
	 * converFile的中文名称：转换文件
	 * 
	 * converFile的概要说明：转换上传的视频格式课件为flv格式
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object converFile(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(coursewareService.converFile(request));
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
