package com.askj.exam.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.exam.dto.OtsPapersInfoDTO;
import com.askj.exam.dto.OtsQuestionsAnsweredDTO;
import com.askj.exam.dto.OtsQuestionsCollectDTO;
import com.askj.exam.dto.OtsQuestionsErrorDTO;
import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.dto.OtsResultInfoDTO;
import com.askj.exam.service.ExamApiService;
import com.askj.exam.service.ExamsService;
import com.askj.exam.service.PractiseService;
import com.askj.exam.service.QuestionService;
import com.askj.exam.service.ResultService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  ExamApiModule的中文名称：【考试系统】api接口module
 *
 *  ExamApiModule的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
@At("api/exam/")
@IocBean
public class ExamApiModule extends BaseModule {
	@Inject
	protected ExamApiService examApiService;
	@Inject
	protected QuestionService questionService;
	@Inject
	protected ExamsService examsService;
	@Inject
	protected ResultService resultService;
	@Inject
	protected PractiseService practiseService;

	/**
	 * 
	 * queryQuestionInfos的中文名称：查看试题列表
	 * 
	 * queryQuestionInfos的概要说明：
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
	public Object queryQuestionInfos(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = questionService.queryQuestionInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * queryQuestionInfoObj的中文名称：查看试题详细信息
	 * 
	 * queryQuestionInfoObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryQuestionInfoObj(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = questionService.queryQuestionInfoObj(dto);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * queryUserExams的中文名称：查询用户可以参加的考试
	 * 
	 * queryUserExams的概要说明：
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
	 * queryExamPapers的中文名称：考试所包含的试卷
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
			map = resultService.queryExamPapers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	/**
	 * 
	 * querPaperInfo的中文名称：查询试卷信息
	 * 
	 * querPaperInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryPaperInfo(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = resultService.startExam(request, dto);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
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
	 * queryQsnNumOfSpecial的中文名称：查询试题考点数量
	 * 
	 * queryQsnNumOfSpecial的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryQsnNumOfSpecial(HttpServletRequest request, @Param("..") OtsQuestionsInfoDTO dto) {
		Map map = new HashMap();
		try {		
			map = practiseService.queryQsnNumOfSpecial(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		} 
	}
	
	/**
	 * 
	 * queryPractiseQuestions的中文名称：查询试题
	 * 
	 * queryPractiseQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryPractiseQuestions(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = practiseService.queryPractiseQuestions(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常信息返回
		}
	}
	
	/**
	 * 
	 * queryErrorQuestions的中文名称：查询错题集合
	 * 
	 * queryErrorQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryErrorQuestions(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = practiseService.queryErrorQuestions(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常信息返回
		}
	}
	
	/**
	 * 
	 * saveErrorQuestion的中文名称：保存错题
	 * 
	 * saveErrorQuestion的概要说明：错题只包括选择与判断
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveErrorQuestion(HttpServletRequest request, @Param("..") OtsQuestionsErrorDTO dto) {
		return SysmanageUtil.execAjaxResult(practiseService.saveErrorQuestion(request, dto));
	}
	
	/**
	 * 
	 * deleteOutOfError的中文名称：将错题删除
	 * 
	 * deleteOutOfError的概要说明：从错题库中删除试题
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteOutOfError(HttpServletRequest request, @Param("..") OtsQuestionsErrorDTO dto) {
		return SysmanageUtil.execAjaxResult(practiseService.deleteOutOfError(request, dto));
	}
	
	/**
	 * 
	 * uploadFj的中文名称：附件上传
	 * 
	 * uploadFj的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
		Map map = new HashMap();
		try {
			map = examApiService.uploadFj(request,dto);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * getFjList的中文名称：获取附件列表
	 * 
	 * getFjList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getFjList(HttpServletRequest request, @Param("..") FjDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = examApiService.getFjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
	
	/**
	 * 
	 * saveAnsweredQuestion的中文名称：保存已回答问题
	 * 
	 * saveAnsweredQuestion的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveAnsweredQuestion(HttpServletRequest request, @Param("..") OtsQuestionsAnsweredDTO dto) {
		return SysmanageUtil.execAjaxResult(practiseService.saveAnsweredQuestion(request, dto));
	}
	
	/**
	 * 
	 * queryRandPractiseQuestions的中文名称：随机查询练习试题
	 * 
	 * queryRandPractiseQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryRandPractiseQuestions(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = practiseService.queryRandPractiseQuestions(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常信息返回
		}
	}

	/**
	 * 
	 * queryCollectQuestions的中文名称：查询收藏试题
	 * 
	 * queryCollectQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryCollectQuestions(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = practiseService.queryCollectQuestions(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常信息返回
		}
	}
	
	/**
	 * 
	 * addCollectQuestion的中文名称：添加收藏
	 * 
	 * addCollectQuestion的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addCollectQuestion(HttpServletRequest request, @Param("..") OtsQuestionsCollectDTO dto) {
		return SysmanageUtil.execAjaxResult(practiseService.addCollectQuestion(request, dto));
	}
	
	/**
	 * 
	 * deleteCollectQuestion的中文名称：删除收藏试题
	 * 
	 * deleteCollectQuestion的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteCollectQuestion(HttpServletRequest request, @Param("..") OtsQuestionsCollectDTO dto) {
		return SysmanageUtil.execAjaxResult(practiseService.deleteCollectQuestion(request, dto));
	}
	
}
