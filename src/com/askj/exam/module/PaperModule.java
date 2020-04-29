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

import com.askj.exam.dto.OtsPapersInfoDTO;
import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.entity.OtsPapersInfo;
import com.askj.exam.service.PaperService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * PaperModule的中文名称：考试子系统-试卷管理
 * 
 * PaperModule的描述：
 * 
 * Written by : zy
 */
@At("/exam/paper")
@IocBean
public class PaperModule {
	
	protected final Logger logger = Logger.getLogger(PaperModule.class);
	
	@Inject
	protected PaperService paperService;

	/**
	 * 
	 * paperManagerIndex的中文名称：试卷管理页面
	 * 
	 * paperManagerIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/paper/paperManager")
	public void paperManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * paperInfoFormIndex的中文名称：试卷信息页面
	 * 
	 * paperInfoFormIndex的概要说明：
	 * @param request
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/paper/paperInfoForm")
	public void paperInfoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * autoMakePaperIndex的中文名称：自动组卷页面
	 * 
	 * autoMakePaperIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/paper/autoMakePaper")
	public void autoMakePaperIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryPapers的中文名称：查询试卷信息
	 * 
	 * queryPapers的概要说明：
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
	public Object queryPapers(HttpServletRequest request, 
			@Param("..") OtsPapersInfoDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {		
			map = paperService.queryPapers(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * savePaperInfo的中文名称：保存试卷信息
	 * 
	 * savePaperInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object savePaperInfo(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		return SysmanageUtil.execAjaxResult(paperService.savePaperInfo(request, dto));
	}
	
	/**
	 * 
	 * autoMakePaper的中文名称：自动组卷
	 * 
	 * autoMakePaper的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object autoMakePaper(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {		
			map = paperService.autoMakePaper(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * queryPaperInfoObj的中文名称：查询试卷信息对象
	 * 
	 * queryPaperInfoObj的概要说明：
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
	public Object queryPaperInfoObj(HttpServletRequest request, 
			@Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = paperService.queryPaperInfoObj(request, dto);
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
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/exam/paper/showPaperInfo")
	@SuppressWarnings({ "rawtypes" })
	public void showPaperInfo(HttpServletRequest request, @Param("..") OtsPapersInfoDTO dto) {
		Map map = new HashMap();
		try {
			map = paperService.showPaperInfo(request, dto);
			// 试卷信息
			OtsPapersInfo paperInfo = (OtsPapersInfo) map.get("paperInfo");
			request.setAttribute("paperInfo", paperInfo);
			// 试卷内容信息
			List paperInfoList = (List) map.get("paperInfoList");
			request.setAttribute("paperInfoList", paperInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * delPaperInfos的中文名称：删除试卷信息
	 * 
	 * delPaperInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object delPaperInfos(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(paperService.delPaperInfos(request));
	}
	
	/**
	 * 
	 * queryQsnNumOfType的中文名称：查询各类型试题条数
	 * 
	 * queryQsnNumOfType的概要说明：自动组卷使用
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryQsnNumOfType(HttpServletRequest request, @Param("..") OtsQuestionsInfoDTO dto) {
		Map map = new HashMap();
		try {		
			map = paperService.queryQsnNumOfType(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
}
