package com.askj.supervision.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import com.askj.supervision.service.CheckHandlerService;
import com.askj.supervision.service.CheckResultService;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ViewModel;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.supervision.entity.BsCheckMaster;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * @author Administrator
 *
 */
@IocBean
@At("/supervision/checkresult/")
public class CheckResultModule {
	protected final Logger logger = Logger.getLogger(CheckResultModule.class);
	@Inject
	private CheckHandlerService checkHandlerService;
	@Inject
	private CheckResultService checkResultService;
	/**
	 * 
	 * plansIndex的中文名称：检查结果管理初始化页面
	 * 
	 * plansIndex的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/resultList.jsp")
	public void resultIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * resultlist的中文名称：查询所有结果信息并分页显示
	 *
	 * resultlist的概要说明：
	 *
	 * @param request
	 *
	 *
	 */

	@At
	@Ok("json")
	public Object resultlist(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Sysuser user  = SysmanageUtil.getSysuser();
		dto.setUserid(user.getUserid());
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		Map mapc = new HashMap();
		try {
			mapc = checkResultService.queryResultList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	/**
	 *
	 * resultJson的中文名称：获取检查结果
	 *
	 * resultJson的概要说明：
	 *
	 * @param request
	 *
	 *
	 */
	@At
	@Ok("json")
	public Object resultJson(HttpServletRequest request,@Param("..") BsCheckMaster dto) throws Exception {
		List list = checkResultService.queryCheckResut(request, dto);
		return list;
	}

	
	/**
	 * 
	 * resultReportlist的中文名称：统计显示查询结果信息并分页显示
	 * 
	 * resultReportlist的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */

	@At
	@Ok("json")
	public Object resultReportlist(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Sysuser user  = SysmanageUtil.getSysuser();
		dto.setUserid(user.getUserid());
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
//		return checkResultService.queryResultReportList(request, dto,pd);
		Map mapc = new HashMap();
		try {
			mapc = checkResultService.queryResultReportList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
	 * 
	 * saveresultDetail的中文名称：保存结果明细
	 * 
	 * saveresultDetail的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object saveresultDetail(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(checkHandlerService.saveresultDetail(request, dto));
	}
	
	/**
	 * 
	 * resultjsp的中文名称：检查计划管理初始化页面(根据企业大类判断跳转页面)
	 * 
	 * resultjsp的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("re:jsp:/jsp/supervision/resultDetail.jsp")
	public Object resultdetail(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, ViewModel model) {
		Map map = new HashMap();
		try {
			map = checkResultService.getQiyeInfoByid(request,dto);
			model.setv("map", map);
			if("2".equals(dto.getComdalei())){//药品生产企业（死数据）
				return "jsp:/jsp/supervision/jpsc/resultDetail.jsp";
			}else if("8".equals(dto.getComdalei())){//药品批发
				return "jsp:/jsp/supervision/jpjy/resultDetail.jsp";
			}else if("9".equals(dto.getComdalei())){//药品零售
				return "jsp:/jsp/supervision/jpjy/resultDetail.jsp";
			}
			return null;
//			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	

	/**
	 * 
	 * viewResult的中文名称：检查结果管理预览页面
	 * 
	 * viewResult的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/resultView.jsp")
	public void viewResult(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		// 页面初始化
	}
	
	
	/**
	 * 
	 * plansIndex的中文名称：检查结果初始化页面
	 * 
	 * plansIndex的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/resultCheckInfo.jsp")
	public void viewResultinfo(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * resultMaster的中文名称：根据检查结果ID查询结果概要信息
	 * 
	 * resultMaster的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object resultMaster(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map.put("data", checkResultService.getResultInfoForHTML(request,dto)) ;
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * resultDetailList的中文名称：根据结果id 查询检查明细结果List
	 * 
	 * resultDetailList的概要说明：根据结果id 查询检查明细结果List
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object resultDetailList(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map =  checkResultService.getDetailByid(request,dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getTbodyInfo的中文名称：获取检查结果信息
	 * 
	 * getTbodyInfo的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object getTbodyInfo(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			map = checkResultService.getTbodyInfo(request,dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getTbodyHtml的中文名称：获取检查结果html页面
	 * 
	 * getTbodyHtml的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("raw:xml")
	public Object getTbodyHtml(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
//			map = checkResultService.getTbodyInfo(request,dto);
			return checkResultService.getTbodyInfoHtml(request,dto).getTbodyinfo();
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	

	/**
	 * 
	 * getResultNumByPlanid的中文名称：通过计划id得到结果对象数据以判断该计划是否正在实施
	 * 
	 * getResultNumByPlanid的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object getResultNumByPlanid(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map=checkResultService.getResultNumByPlanid(request,dto) ;
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	
	
	/***********************************************聚餐申报*********************************** ST  *************************/
	/**
	 * 
	 * jcsbresultIndex的中文名称：(聚餐申报)检查结果管理初始化页面
	 * 
	 * jcsbresultIndex的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/jcsbCheckResult/jscbCheckResultList.jsp")
	public void jcsbresultIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jcsbresultlist的中文名称：查询聚餐申报列表
	 * 
	 * resultlist的概要说明：查询聚餐申报列表
	 * 
	 * @param request
	 *          
	 * 
	 */
	
	@At
	@Ok("json")
	public Object jcsbresultlist(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = checkResultService.jcsbqueryResultList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * jcsbresultDetail的中文名称：查询聚餐申报结果明细
	 *
	 * jcsbresultDetail的概要说明：
	 *
	 * @param request
	 *
	 *
	 */
	@At
	@Ok("jsp:/jsp/supervision/jcsbCheckResult/jcsbresultDetail.jsp")
	public Object jcsbresultDetail(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			map = checkResultService.getQiyeInfoByid(request,dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


	/***********************************************聚餐申报*********************************** ED  *************************/




	
	
	/**
	 * 
	 * xkzManage的中文名称：许可证管理
	 * 
	 * xkzManage的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/xkz/xkzIndex.jsp")
	public void xkzManage(HttpServletRequest request) {
		// 页面初始化
	}
	
	
	
	
}
