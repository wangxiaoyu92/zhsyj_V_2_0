package com.askj.exam.module;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.askj.exam.dto.OtsExamUserDTO;
import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.exam.dto.OtsExamsMateDTO;
import com.askj.exam.dto.OtsResultMateDTO;
import com.askj.exam.service.ExamsService;
import com.askj.exam.service.ResultService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * ExamsModule的中文名称：考试子系统-考试管理
 * 
 * ExamsModule的描述：
 * 
 * @author : zy
 */
@At("/exam/exam")
@IocBean
public class ExamsModule {
	
	protected final Logger logger = Logger.getLogger(ExamsModule.class);
	
	@Inject
	protected ExamsService examsService;
	@Inject
	protected ResultService resultService;
	/**
	 * 
	 * examsManagerIndex的中文名称：考试管理页面
	 * 
	 * examsManagerIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examsManager")
	public void examsManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	
	/**
	 * 
	 * queryExamMonDIndex的中文名称：考试监控详细
	 * 
	 * queryExamMonDIndex的概要说明：
	 * @param request
	 *        Written by : wcl
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examMonDetails")
	public void queryExamMonDIndex(HttpServletRequest request) {
		// 页面初始化
		
	}
	
	
	/**
	 * 
	 * examsMonUsers的中文名称：应考人员页面
	 * 
	 * examsMonUsers的概要说明：
	 * @param request
	 *        Written by : wcl
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examsMonUsers")
	public void examsMonUsers(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * examMonInfosIndex的中文名称：考试监控页面
	 * 
	 * coursewareManagerIndex的概要说明：
	 *
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examMonManager")
	public void examMonInfosIndex(HttpServletRequest request){
		//初始化考试监控页面
	}
	
	/**
	 * 
	 * examInfoFormIndex的中文名称：考试信息页面
	 * 
	 * examInfoFormIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examInfoForm")
	public void examInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryExamInfos的中文名称：查询考试信息
	 * 
	 * queryExamInfos的概要说明：
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
	public Object queryExamInfos(HttpServletRequest request, 
			@Param("..") OtsExamsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = examsService.queryExamInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	
	
	/**
	 * 
	 * queryExamInfos的中文名称：查询考试信息
	 * 
	 * queryExamInfos的概要说明：
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
	public Object queryExamMonInfos(HttpServletRequest request, 
			@Param("..") OtsExamsMateDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = examsService.queryExamMonInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	
	
	/**
	 * 
	 * saveExamInfo的中文名称：保存考试信息
	 * 
	 * saveExamInfo的概要说明：考试信息与考试功能信息
	 *
	 * @param request
	 * @param dto 试卷功能信息表
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveExamInfo(HttpServletRequest request, @Param("..") OtsExamsMateDTO dto) {
		return SysmanageUtil.execAjaxResult(examsService.saveExamInfo(request, dto));
	}
	
	/**
	 * 
	 * queryExamInfoObj的中文名称：查询考试信息
	 * 
	 * queryExamInfoObj的概要说明：
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
	public Object queryExamInfoObj(HttpServletRequest request, 
			@Param("..") OtsExamsInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = examsService.queryExamInfoObj(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * delExamInfos的中文名称：删除考试信息
	 * 
	 * delExamInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delExamInfos(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(examsService.delExamInfos(request));
	}
	
	/**
	 * 
	 * queryExamPapers的中文名称：查询考试所包含试卷
	 * 
	 * queryExamPapers的概要说明：
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
	public Object queryExamPapers(HttpServletRequest request, 
			@Param("..") OtsExamsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = examsService.queryExamPapers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * examUsersIndex的中文名称：为考试添加人员页面
	 * 
	 * examUsersIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/examUsers")
	public void examUsersIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryExamUsers的中文名称：查询当前考试包含人员
	 * 
	 * queryExamUsers的概要说明：
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
	public Object queryExamUsers(HttpServletRequest request,
			@Param("..") OtsExamUserDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return examsService.queryExamUsers(dto, pd);
	}
	
	/**
	 * 
	 * addUserToExam的中文名称：添加考试人员
	 * 
	 * addUserToExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addUserToExam(HttpServletRequest request, @Param("..") OtsExamUserDTO dto){
		return SysmanageUtil.execAjaxResult(examsService.addUserToExam(request, dto));
	}
	
	/**
	 * 
	 * delUserOutOfExam的中文名称：将用户从考试用户关系表中删除
	 * 
	 * delUserOutOfExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delUserOutOfExam(HttpServletRequest request, @Param("..") OtsExamUserDTO dto) {
		return SysmanageUtil.execAjaxResult(examsService.delUserOutOfExam(request, dto));
	}
	
	/**
	 * 
	 * queryExamMonUsers的中文名称：考试监控
	 * 
	 * queryExamMonUsers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryExamMonUsers(HttpServletRequest request, 
			@Param("..") OtsExamUserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = examsService.queryExamMonUsers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	
	/**
	 * 
	 * queryExamMonDetails的中文名称：考试监控详细 
	 * 
	 * queryExamMonDetails的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryExamMonDetails(HttpServletRequest request, 
			@Param("..") OtsResultMateDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = examsService.queryExamMonDetails(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
}
