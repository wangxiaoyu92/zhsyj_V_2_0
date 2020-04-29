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

import com.askj.train.dto.OtsTeacherDTO;
import com.askj.train.service.TeacherService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * TeacherModule的中文名称：培训子系统-教师管理
 * 
 * TeacherModule的描述：
 * 
 * Written by : zy
 */
@At("/train/teacher")
@IocBean
public class TeacherModule {
	
	protected final Logger logger = Logger.getLogger(TeacherModule.class);
	
	@Inject
	protected TeacherService teacherService;

	/**
	 * 
	 * teacherManagerIndex的中文名称：教师管理页面
	 * 
	 * teacherManagerIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/train/teacher/teacherManager")
	public void teacherManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * teacherFormIndex的中文名称：教师信息页面
	 * 
	 * teacherFormIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/train/teacher/teacherForm")
	public void teacherFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryTeachers的中文名称：查询教师列表信息
	 * 
	 * queryTeachers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryTeachers(HttpServletRequest request, 
			@Param("..") OtsTeacherDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = teacherService.queryTeachers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * saveTeacher的中文名称：保存教师信息
	 * 
	 * saveTeacher的概要说明：
	 *
	 * @param request
	 * @param dto 
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveTeacher(HttpServletRequest request, @Param("..") OtsTeacherDTO dto) {
		return SysmanageUtil.execAjaxResult(teacherService.saveTeacher(request, dto));
	}
	
	/**
	 * 
	 * queryTeacherObj的中文名称：查询教师信息
	 * 
	 * queryTeacherObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryTeacherObj(HttpServletRequest request, @Param("..") OtsTeacherDTO dto) {
		Map map = new HashMap();
		try {
			map = teacherService.queryTeacherObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * delTeacher的中文名称：删除教师信息
	 * 
	 * delTeacher的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object delTeacher(HttpServletRequest request, @Param("..") OtsTeacherDTO dto) {
		return SysmanageUtil.execAjaxResult(teacherService.delTeacher(request, dto));
	}
	
}
