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

import com.askj.train.dto.OtsCourseAppraiseDTO;
import com.askj.train.dto.OtsCourseDTO;
import com.askj.train.dto.OtsCourseHomeworkDTO;
import com.askj.train.dto.OtsCourseUserDTO;
import com.askj.train.dto.OtsHomeworkDTO;
import com.askj.train.service.CourseService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CourseModule的中文名称：培训子系统-课程管理
 * 
 * CourseModule的描述：
 * 
 * @author : zy
 */
@At("/train/course")
@IocBean
public class CourseModule {
	
	protected final Logger logger = Logger.getLogger(CourseModule.class);
	
	@Inject
	protected CourseService courseService;

	/**
	 * 
	 * courseManagerIndex的中文名称：课程管理页面
	 * 
	 * courseManagerIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/courseManager")
	public void courseManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryCourseInfos的中文名称：查询课程列表信息
	 * 
	 * queryCourseInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCourseInfos(HttpServletRequest request, 
			@Param("..") OtsCourseDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = courseService.queryCourseInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * courseFormIndex的中文名称：课程信息页面
	 * 
	 * courseFormIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/courseForm")
	public void courseFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryCourseObj的中文名称：查询课程信息
	 * 
	 * queryCourseObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
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
	 * saveAppraise的中文名称：保存打分信息
	 * 
	 * saveAppraise的概要说明：
	 *
	 * @param request
	 * @param dto 
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveAppraise(HttpServletRequest request, @Param("..") OtsCourseAppraiseDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.saveAppraise(request, dto));
	}
	
	/**
	 * 
	 * saveCourse的中文名称：保存课程信息
	 * 
	 * saveCourse的概要说明：
	 *
	 * @param request
	 * @param dto 
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.saveCourse(request, dto));
	}
	
	/**
	 * 
	 * delCourse的中文名称：删除课程信息
	 * 
	 * delCourse的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.delCourse(request, dto));
	}
	
	/**
	 * 
	 * myCourseManagerIndex的中文名称：我的课程管理页面
	 * 
	 * myCourseManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/train/course/myCourseManager")
	public void myCourseManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * courseStatistics的中文名称：课程评价统计页面
	 * 
	 * courseStatistics的概要说明：
	 * @param request
	 * @author : wcl
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/train/course/courseStatisticsForm")
	public void courseStatistics(HttpServletRequest request, @Param("..") OtsCourseDTO dto) throws Exception {
		// 页面初始化
		Map map = courseService.queryCourseObj(request, dto);
		request.setAttribute("courseInfo", map.get("courseInfo"));
	}
	
	/**
	 * 
	 * queryCourseStatistics的中文名称：查询课程统计评价
	 * 
	 * queryCourseStatistics的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCourseStatistics(HttpServletRequest request, @Param("..") OtsCourseAppraiseDTO dto){
		Map map = new HashMap();
		try {		
			map = courseService.queryStatistics(request, dto);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * showMyCourse的中文名称：我的课程信息页面
	 * 
	 * showMyCourse的概要说明：
	 * @param request
	 * @author : zy
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/train/course/showMyCourse")
	public void showMyCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto) throws Exception {
		// 页面初始化
		Map map = courseService.queryCourseObj(request, dto);
		request.setAttribute("courseInfo", map.get("courseInfo"));
	}
	
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
	 * @author : wcl
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
	 * teacherOfCourseIndex的中文名称：课程讲师管理页面
	 * 
	 * teacherOfCourseIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/teacherOfCourse")
	public void teacherOfCourseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryTeacherOfCourse的中文名称：查询课程所包含讲师
	 * 
	 * queryTeacherOfCourse的概要说明：
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
	public Object queryTeacherOfCourse(HttpServletRequest request, 
			@Param("..") OtsCourseDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = courseService.queryTeacherOfCourse(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * addTeacherToCourse的中文名称：将讲师添加进课程
	 * 
	 * addTeacherToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addTeacherToCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.addTeacherToCourse(request, dto));
	}
	
	/**
	 * 
	 * delTeacherOutOfCourse的中文名称：将讲师从课程中删除
	 * 
	 * delTeacherOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delTeacherOutOfCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.delTeacherOutOfCourse(request, dto));
	}

	/**
	 * 
	 * wareOfCourseIndex的中文名称：课程课件管理页面
	 * 
	 * wareOfCourseIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/wareOfCourse")
	public void wareOfCourseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryCourseWareOfCourse的中文名称：查询课程所包含课件
	 * 
	 * queryCourseWareOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryCourseWareOfCourse(HttpServletRequest request, 
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
	 * addWareToCourse的中文名称：添加课件到课程
	 * 
	 * addWareToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addWareToCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.addWareToCourse(request, dto));
	}
	
	/**
	 * 
	 * delWareOutOfCourse的中文名称：将课件从课程中删除
	 * 
	 * delWareOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delWareOutOfCourse(HttpServletRequest request, @Param("..") OtsCourseDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.delWareOutOfCourse(request, dto));
	}

	/**
	 * 
	 * homeworkOfCourseIndex的中文名称：课程作业管理页面
	 * 
	 * homeworkOfCourseIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/homeworkOfCourse")
	public void homeworkOfCourseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryHomeworks的中文名称：查询作业列表
	 * 
	 * queryHomeworks的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryHomeworks(HttpServletRequest request, 
			@Param("..") OtsHomeworkDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = courseService.queryHomeworks(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryHomeOfCourse的中文名称：查询课程所包含课后作业
	 * 
	 * queryHomeOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryHomeOfCourse(HttpServletRequest request, 
			@Param("..") OtsCourseDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = courseService.queryHomeOfCourse(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * homeworkFormIndex的中文名称：作业信息页面
	 * 
	 * homeworkFormIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/homeworkForm")
	public void homeworkFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryHomeworkObj的中文名称：查询作业信息
	 * 
	 * queryHomeworkObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryHomeworkObj(HttpServletRequest request, @Param("..") OtsHomeworkDTO dto) {
		Map map = new HashMap();
		try {
			map = courseService.queryHomeworkObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveHomework的中文名称：保存作业
	 * 
	 * saveHomework的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveHomework(HttpServletRequest request, @Param("..") OtsHomeworkDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.saveHomework(request, dto));
	}
	
	/**
	 * 
	 * delHomework的中文名称：删除作业
	 * 
	 * delHomework的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delHomework(HttpServletRequest request, @Param("..") OtsHomeworkDTO dto) {
		return SysmanageUtil.execAjaxResult(courseService.delHomework(request, dto));
	}
	
	/**
	 * 
	 * addHomeworkToCourse的中文名称：将作业添加进课程
	 * 
	 * addHomeworkToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addHomeworkToCourse(HttpServletRequest request, @Param("..") OtsCourseHomeworkDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.addHomeworkToCourse(request, dto));
	}

	/**
	 * 
	 * delHomeworkOutOfCourse的中文名称：将作业从课程中删除
	 * 
	 * delHomeworkOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delHomeworkOutOfCourse(HttpServletRequest request, @Param("..") OtsCourseHomeworkDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.delHomeworkOutOfCourse(request, dto));
	}
	
	/**
	 * 
	 * courseUsersIndex的中文名称：课程用户管理页面
	 * 
	 * courseUsersIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/train/course/courseUsers")
	public void courseUsersIndex(HttpServletRequest request){
		//初始化页面
	}
	
	/**
	 * 
	 * queryCourseUsers的中文名称：查询当前课程包含人员
	 * 
	 * queryCourseUsers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object queryCourseUsers(HttpServletRequest request,
			@Param("..") OtsCourseUserDTO dto,@Param("..") PagesDTO pd)throws Exception{
		return courseService.queryCourseUsers(dto, pd);
		
	}
	
	/**
	 * 
	 * addUserToCourse的中文名称：添加课程人员
	 * 
	 * addUserToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addUserToCourse(HttpServletRequest request, @Param("..") OtsCourseUserDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.addUserToCourse(request, dto));
	}

	/**
	 * 
	 * delUserOutOfCourse的中文名称：将用户从课程用户关系表中删除
	 * 
	 * delUserOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delUserOutOfCourse(HttpServletRequest request, @Param("..") OtsCourseUserDTO dto){
		return SysmanageUtil.execAjaxResult(courseService.delUserOutOfCourse(request, dto));
	}
}
