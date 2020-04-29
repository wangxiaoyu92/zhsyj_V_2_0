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

import com.askj.exam.dto.OtsQuestionsAnsweredDTO;
import com.askj.exam.dto.OtsQuestionsCollectDTO;
import com.askj.exam.dto.OtsQuestionsErrorDTO;
import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.service.PractiseService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * PractiseModule的中文名称：考试子系统-练习管理
 * 
 * PractiseModule的描述：
 * 
 * Written by : zy
 */
@At("/exam/practise")
@IocBean
public class PractiseModule {
	
	protected final Logger logger = Logger.getLogger(PractiseModule.class);
	
	@Inject
	protected PractiseService practiseService;

	/**
	 * 
	 * orderPractiseIndex的中文名称：顺序练习页面
	 * 
	 * orderPractiseIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/practise/practise")
	public void orderPractiseIndex(HttpServletRequest request) {
		
	}
	
	/**
	 * 
	 * specialPractiseIndex的中文名称：专项练习页面
	 * 
	 * specialPractiseIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/practise/specialPractise")
	public void specialPractiseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * randomPractiseIndex的中文名称：随机练习页面
	 * 
	 * randomPractiseIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/practise/randPractise")
	public void randomPractiseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * errorPractiseIndex的中文名称：错题练习
	 * 
	 * errorPractiseIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/practise/errorPractise")
	public void errorPractiseIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryPractiseQuestions的中文名称：查询练习试题
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
