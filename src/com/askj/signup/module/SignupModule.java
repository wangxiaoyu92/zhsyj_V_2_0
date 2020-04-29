package com.askj.signup.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.signup.dto.OtsExamUserEnrollDTO;
import com.askj.signup.dto.OtsExamUserRegDTO;
import com.askj.signup.service.SignupService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * SignupModule的中文名称：报名管理
 * 
 * SignupModule的描述：
 * 
 * @author : wcl
 */
@At("/signups/signup")
@IocBean
public class SignupModule {
	
	protected final Logger logger = Logger.getLogger(SignupModule.class);
	
	@Inject
	protected SignupService signupService;


	/**
	 * 
	 * signupManagerIndex的中文名称：注册页面
	 * 
	 * signupManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/signupManager")
	public void signupManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	
	
	
	
	/**
	 * 
	 * inAuditManagerIndex的中文名称：查询审核中人员
	 * 
	 * inAuditManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 */
	@At
	@Ok("jsp:/jsp/signups/signup/inAuditManager")
	public void inAuditManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	
	

	/**
	 * 
	 * registrationManagerIndex的中文名称：报名页面
	 * 
	 * registrationManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 * @throws Exception 
	 */
	@At
	@Ok("jsp:/jsp/signups/signup/registration")
	public void registrationManagerIndex(HttpServletRequest request, @Param("..") OtsExamUserRegDTO dto) throws Exception {
	}
	
	
	
	/**
	 * 
	 * registrationManagerIndex的中文名称：查看报名详细信息
	 * 
	 * registrationManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/signups/signup/detailedForm")
	public void detailedManagerIndex(HttpServletRequest request, @Param("..") OtsExamUserEnrollDTO dto) throws Exception {
			Map map = signupService.queryDetailedObj(request, dto);
			request.setAttribute("v_examUserEnroll", map.get("v_examUserEnroll"));
	}
	
	
	
	/**
	 * 
	 * InformationManagerIndex的中文名称：我的信息
	 * 
	 * InformationManagerIndex的概要说明：
	 * @param request
	 * @author : wcl
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/signups/signup/informationForm")
	public void informationManagerIndex(HttpServletRequest request, @Param("..") OtsExamUserEnrollDTO dto) throws Exception {
			Map map = signupService.queryExamineObj(request, dto);
			request.setAttribute("v_examUserEnroll", map.get("v_examUserEnroll"));
	}
	
	
	
	
	
	
	
	/**
	 * 
	 * saveUser的中文名称：保存输入的注册信息
	 * 
	 * saveUser的概要说明：
	 *
	 * @param request
	 * @param dto 
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object saveUser(HttpServletRequest request, @Param("..") OtsExamUserRegDTO dto) {
		return SysmanageUtil.execAjaxResult(signupService.saveUser(request, dto));
	}
	
	
	/**
	 * 
	 * examCom的中文名称：考试名称下拉框
	 * 
	 * examCom的概要说明：
	 *
	 * @param request
	 * @param dto 
	 * @return
	 * @author : wcl
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object examCom(HttpServletRequest request, @Param("..") OtsExamsInfoDTO dto) throws Exception {
		try {
			return signupService.examCom(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
	/**
	 * 
	 * saveSign的中文名称：保存报名信息
	 * 
	 * saveSign的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object saveSign(HttpServletRequest request, @Param("..") OtsExamUserEnrollDTO dto) {
		return SysmanageUtil.execAjaxResult(signupService.saveSign(request, dto));
	}
	
	
	/**
	 * 
	 * queryAuditorsInfos的中文名称：查询审核中人员列表
	 * 
	 * queryAuditorsInfos的概要说明：
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
			@Param("..") OtsExamUserEnrollDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = signupService.queryAuditorsInfos(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}
	
	
	/**
	 * 
	 * saveSign的中文名称：修改报名状态
	 * 
	 * saveSign的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object uodateSign(HttpServletRequest request, @Param("..") OtsExamUserEnrollDTO dto) {
		return SysmanageUtil.execAjaxResult(signupService.uodateSign(request, dto));
	}
	
	/**
	 * 
	 * saveSign的中文名称：修改报名状态
	 * 
	 * saveSign的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@At
	@Ok("json")
	public Object uodateState(HttpServletRequest request, @Param("..") OtsExamUserEnrollDTO dto) {
		return SysmanageUtil.execAjaxResult(signupService.uodateState(request, dto));
	}
	
}
