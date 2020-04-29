package com.askj.supervision.module;


import com.askj.supervision.dto.BsCheckDetailDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.supervision.entity.BsCheckDetail;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.supervision.service.*;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.commons.lang.StringUtils;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SupervisionApiModule的中文名称：【安全监管手机端】api接口module
 * 
 * SupervisionApiModule的描述：从SjbModule提取安全监管涉及到的方法
 * 
 * @author ：sunyifeng
 * @version ：V1.0
 */
@At("api/supervision/")
@IocBean
public class SupervisionOldApiModule extends BaseModule {

	@Inject
	protected	CheckHandlerService checkHandlerService;
	@Inject
	protected SupervisionApiService supervisionApiService;
	@Inject
	protected CheckTbodyService checkTbodyService;
	@Inject
	protected CheckForNcjtjcService checkForNcjtjcService;

	/**
	 *
	 * queryCheckMasterId的中文名称：查询检查结果ID 新增检查
	 *
	 * queryCheckMasterId的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : tmm
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "操作失败");
		result.put("success", false);
		result.put("resultid", "");
		// gu20170221begin
		dto.setUserid(dto.getOperateperson());//
		// gu20170221end
		if ("null".equalsIgnoreCase(dto.getPlanid()) || StringUtils.isEmpty(dto.getPlanid())) {
			result.put("msg", "检查计划ID[planid]不能为空");
			return result;
		}
		// 是否合并检查计划 // TODO 合并检查
		String isMergePlans = StringHelper.showNull2Empty(request.getParameter("isMergePlans"));
		if ("true".equals(isMergePlans)) {
			String type = request.getParameter("type");
			Map retMap = new HashMap();
			String[] planids = dto.getPlanid().split(",");
			String resultid = "";
			for (int i = 0; i < planids.length; i++) {
				dto.setPlanid(planids[0]);
				if("jcsb".equals(type)){//聚餐申报
					retMap = checkHandlerService.queryCheckMasterIsExist(request, dto);
				}else {//日常检查
					if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
						result.put("msg", "企业单位ID[comid]不能为空");
						return result;
					}
					//查询有没有完成的计划(如果有未检查的计划返回未检查完的结果id)
					retMap = supervisionApiService.queryPlanListForNotFinished(request, dto);
				}
				int total = (Integer) retMap.get("total");
				if(total>0){
					BsCheckMaster bc = (BsCheckMaster) ((List) retMap.get("rows")).get(0);
					result.put("success", true);
					resultid += bc.getResultid() + ",";
//					result.put("resultid", bc.getResultid());
					result.put("code", "0000");
					result.put("msg", "查询成功");
				} else {//返回结果id
					result = checkHandlerService.saveCheckMaster(request, dto);
					if ((Boolean) result.get("success")) {
						resultid += result.get("resultid") + ",";
						result.put("code", "0000");
						result.put("msg", "保存成功");
					}
				}
			}
			result.put("resultid", resultid.substring(0, resultid.lastIndexOf(",")));
			return result;
		} else {
			String type = request.getParameter("type");
			Map retMap = new HashMap();
			if("jcsb".equals(type)){//聚餐申报
				retMap = checkHandlerService.queryCheckMasterIsExist(request, dto);
			}else {//日常检查
				if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
					result.put("msg", "企业单位ID[comid]不能为空");
					return result;
				}
				//查询有没有完成的计划(如果有未检查的计划返回未检查完的结果id)
				retMap = supervisionApiService.queryPlanListForNotFinished(request, dto);
			}
			int total = (Integer) retMap.get("total");
			if(total>0){
				BsCheckMaster bc = (BsCheckMaster) ((List) retMap.get("rows")).get(0);
				result.put("success", true);
				result.put("resultid", bc.getResultid());
				result.put("code", "0000");
				result.put("msg", "查询成功");
			} else {//返回结果id
				result = checkHandlerService.saveCheckMaster(request, dto);
				if ((Boolean) result.get("success")) {
					result.put("code", "0000");
					result.put("msg", "保存成功");
				}
			}
			return result;
		}
	}

	/**
	 *
	 * saveCheckMasterId的中文名称：新增结果表
	 *
	 * saveCheckMasterId的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : syf
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object saveCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "-1");
		result.put("msg", "操作失败");
		result.put("success", false);
		result.put("resultid", "");
		Map retMap = supervisionApiService.queryPlanListForNotFinished(request, dto);
		int total = (Integer) retMap.get("total");
		if(total>0){
			BsCheckMaster bc = (BsCheckMaster) ((List) retMap.get("rows")).get(0);
			result.put("success", true);
			result.put("resultid", bc.getResultid());
			result.put("code", "0000");
			result.put("msg", "查询成功");
		} else {//返回结果id
			result = checkHandlerService.saveCheckMaster(request, dto);
			if ((Boolean) result.get("success")) {
				result.put("code", "0000");
				result.put("msg", "保存成功");
			}
		}
		return result;
	}

	/**
	 *
	 * updateResultStateBy的中文名称：修改结果状态
	 *
	 * updateResultStateBy的概要说明：传入planid和comid
	 *
	 * @param dto
	 * @return Written by : tmm
	 *
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object updateResultStateBy(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			map = supervisionApiService.updateBsCheckMasterState(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * updateResultByid的中文名称：根据检查结果ID修改检查结果信息
	 *
	 * updateResultByid的概要说明：resulid(查询顺序需要调整)
	 *
	 * @param dto
	 * @return Written by : tmm
	 *
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object updateResultByid(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			// 修改结果状态和明细信息
			// 判断大类选择后台页面拼接
			map = checkHandlerService.updateBsCheckMasterStateByResultid(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getResultRecordHtmlByresultId的中文名称：根据结果id获取结果记录页面信息
	 *
	 * getResultRecordHtmlByresultIds的概要说明：传入resultid
	 *
	 * @param dto
	 * @return Written by : tmm
	 *
	 */
	@At
	@Ok("raw:htm")
	public Object getResultRecordHtmlByresultId(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		try {
			return supervisionApiService.getResultRecord(request, dto).getCheckresultinfo();
		} catch (Exception e) {
			return "暂无数据";
		}
	}

	/***********************************************离线同步*********************************** ST  *************************/
	/**
	 *
	 * synchronousCheckMasterId的中文名称：同步结果表（同步离线结果数据）
	 *
	 * synchronousCheckMasterId的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : tmm
	 */
	@At
	@Ok("json")
	public Object synchronousCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "-1");
		result.put("msg", "操作失败");
		result.put("success", false);
		result.put("resultid", "");
		BsCheckMaster bsCheckMaster = supervisionApiService.checkMasterIsExistByresultId(request, dto);
		if(bsCheckMaster!=null&&!"".equals(bsCheckMaster)){
			result = checkHandlerService.synchronousCheckMaster(request, dto,"update");
			if ((Boolean) result.get("success")) {
				result.put("code", "0000");
				result.put("msg", "修改成功");
			}
		} else {//返回结果id
			result = checkHandlerService.synchronousCheckMaster(request, dto,"save");
			if ((Boolean) result.get("success")) {
				result.put("code", "0000");
				result.put("msg", "保存成功");
			}
		}
		return result;
	}

	/**
	 *
	 * synchronousCheckBathSaveCheckDetail的中文名称：同步检查结果明细（同步离线结果明细数据）
	 *
	 * synchronousCheckBathSaveCheckDetail的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : tmm
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object synchronousCheckBathSaveCheckDetail(HttpServletRequest request,
													  @Param("..") BsCheckDetailDTO dto, @Param("..") BsCheckMasterDTO mdto)
			throws Exception {
		// request.getParameter(arg0);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "保存失败");
		result.put("success", false);
		// 批量保存明细
		Map map = checkHandlerService.saveCheckDetailForBatch(request, dto);
		if ((Boolean) map.get("success")) {
			result.put("msg", map.get("msg"));
			result.put("success", map.get("success"));
			result.put("code", "0000");
		} else {
			result.put("msg", map.get("msg"));
		}
		return result;

	}

	/**
	 *
	 * getCheckDetailForSaveAfter的中文名称：获取保存后未检查项目
	 *
	 * getCheckDetailForSaveAfter的概要说明：返回大项ID，明细ID和所在检查表位置，位置从0开始
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object getCheckDetailForSaveAfter(HttpServletRequest request,
											 @Param("..") BsCheckMasterDTO dto)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// request.getParameter(arg0);

			// 批量保存明细
			List<Object> list = checkHandlerService.getCheckDetailForSaveAfter(request,dto);
			resultMap.put("rows", list);
			resultMap.put("total", list.size());
			return SysmanageUtil.execAjaxResult(resultMap, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(resultMap, e);
		}
	}
	/***********************************************离线同步*********************************** ED  *************************/


	/***********************************************聚餐申报*********************************** ED  *************************/
	/**
	 *
	 * getJdjcResultList的中文名称：获取监督检查结果列表
	 *
	 * getJdjcResultList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJdjcResultList(HttpServletRequest request,
			@Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = checkForNcjtjcService.getJdjcResultList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * querytbodys的中文名称：查询表单数据（手机离线）
	 *
	 * querytbodys的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : tmm
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object querytbodys(HttpServletRequest request, @Param("..")BsCheckMasterDTO dto,
							  @Param("..") PagesDTO pd) throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		Map map = new HashMap();
		try {
			map =checkTbodyService.getTbodyInfos(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
}
