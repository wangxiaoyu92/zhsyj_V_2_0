package com.askj.exam.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.exam.dto.OtsPapersInfoDTO;
import com.askj.exam.dto.OtsResultInfoDTO;
import com.askj.exam.entity.OtsExamsMate;
import com.askj.exam.entity.OtsResultInfo;
import com.askj.exam.service.ResultService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * ResultModule的中文名称：考试子系统-考试结果管理
 * 
 * ResultModule的描述：
 * 
 * Written by : zy
 */
@At("/exam/result")
@IocBean
public class ResultModule {
	
	protected final Logger logger = Logger.getLogger(ResultModule.class);
	
	@Inject
	protected ResultService resultService;
	
	/**
	 * 
	 * userExamIndex的中文名称：用户考试界面
	 * 
	 * userExamIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/userExam")
	public void userExamIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * resultManagerIndex的中文名称：成绩管理页面
	 * 
	 * resultManagerIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/resultManager")
	public void resultManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryUserExams的中文名称：查询用户所能参加的考试
	 * 
	 * queryUserExams的概要说明：
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
	public Object queryUserExams(HttpServletRequest request, 
			@Param("..") OtsExamsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = resultService.queryUserExams(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		} 
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
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryExamPapers(HttpServletRequest request, 
			@Param("..") OtsExamsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = resultService.queryExamPapers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * userStartExamIndex的中文名称：用户开始考试页面
	 * 
	 * userStartExamIndex的概要说明：
	 *
	 * @param request
	 * @param dto
	 *        Written by : zy
	 */
	@At
	@Ok("re:jsp:/jsp/error/500.jsp")
	@SuppressWarnings({ "rawtypes" })
	public String userStartExamIndex(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = resultService.startExam(request, dto);
			// 试卷对象
			JSONObject paperInfo = (JSONObject) map.get("paperInfo");
			request.setAttribute("paperInfo", paperInfo);
			// 考试功能信息
			OtsExamsMate oem = (OtsExamsMate) map.get("examMate");
			request.setAttribute("examMate", oem);
			// 用户考试信息表id
			String resultMateId = (String) map.get("resultMateId");
			request.setAttribute("resultMateId", resultMateId);
			// 考试方式,1=整卷,2=逐题
			if ("2".equals(oem.getExamMode())) {
				return "jsp:/jsp/exam/exam/userStartExamByOne";
			} else {
				return "jsp:/jsp/exam/exam/userStartExam";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
	}
	
	/**
	 * 
	 * submitExam的中文名称：提交试卷
	 * 
	 * submitExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object submitExam(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = resultService.submitExam(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryExamResults的中文名称：查询用户考试成绩
	 * 
	 * queryExamResults的概要说明：
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
	public Object queryExamResults(HttpServletRequest request, 
			@Param("..") OtsResultInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = resultService.queryExamResults(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		} 
	}
	
	/**
	 * 
	 * resultFormIndex的中文名称：考试成绩编辑页面
	 * 
	 * resultFormIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/exam/resultForm")
	public void resultFormIndex(HttpServletRequest request, @Param("..") OtsResultInfoDTO dto) {
		// 页面初始化
		try {
			OtsResultInfo info = resultService.queryResultInfo(dto);
			request.setAttribute("resultInfo", info);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * queryResultInfo的中文名称：查询考试结果信息
	 * 
	 * queryResultInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryResultInfo(HttpServletRequest request, @Param("..") OtsResultInfoDTO dto) {
		Map map = new HashMap();
		try {		
			map.put("resultInfo", resultService.queryResultInfo(dto));
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		} 
	}
	
	/**
	 * 
	 * delResult的中文名称：删除考试结果
	 * 
	 * delResult的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delResult(HttpServletRequest request, @Param("..") OtsResultInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(resultService.delResult(request, dto));
	}
}
