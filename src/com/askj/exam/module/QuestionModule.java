package com.askj.exam.module;

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

import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.entity.OtsQuestionsData;
import com.askj.exam.entity.OtsQuestionsInfo;
import com.askj.exam.service.QuestionService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * QuestionModule的中文名称：考试子系统-试题管理
 * 
 * QuestionModule的描述：
 * 
 * @author : zy
 */
@At("/exam/question")
@IocBean
public class QuestionModule {
	
	protected final Logger logger = Logger.getLogger(QuestionModule.class);
	
	@Inject
	protected QuestionService questionService;

	/**
	 * 
	 * questionManagerIndex的中文名称：试题管理页面
	 * 
	 * questionManagerIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/question/questionManager")
	public void questionManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * questionInfoFormIndex的中文名称：试题信息页面
	 * 
	 * questionInfoFormIndex的概要说明：
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/question/questionInfoForm")
	public void questionInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryQuestionInfos的中文名称：查询试题列表信息
	 * 
	 * queryQuestionInfos的概要说明：
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
	 * saveQuestionInfo的中文名称：保存试题信息
	 * 
	 * saveQuestionInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveQuestionInfo(HttpServletRequest request, @Param("..") OtsQuestionsInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(questionService.saveQuestionInfo(request, dto));
	}
	
	/**
	 * 
	 * queryQuestionInfoObj的中文名称：查询试题信息对象
	 * 
	 * queryQuestionInfoObj的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object queryQuestionInfoObj(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = questionService.queryQuestionInfoObj(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * showQuestionPreview的中文名称：考试试题预览
	 * 
	 * showQuestionPreview的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/question/showQuestionPreview")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void showQuestionPreview(HttpServletRequest request, 
			@Param("..") OtsQuestionsInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = questionService.queryQuestionInfoObj(dto);
			// 试题信息
			OtsQuestionsInfo info = (OtsQuestionsInfo) map.get("info");
			request.setAttribute("qsnInfo", info);
			// 试题选项信息
			List<OtsQuestionsData> dataList = (List<OtsQuestionsData>) map.get("dataList");
			request.setAttribute("dataList", dataList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * delQusetionInfos的中文名称：删除试题信息
	 * 
	 * delQusetionInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object delQusetionInfos(HttpServletRequest request) {
		Map map = new HashMap();
		try {
			return questionService.delQusetionInfos(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryQsnTrade的中文名称：获取试题考点
	 * 
	 * queryQsnTrade的概要说明：将知识点以combotree下拉树的json格式返回
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object queryQsnTrade(HttpServletRequest request){
		try {
			return questionService.queryQsnTrade(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
}
