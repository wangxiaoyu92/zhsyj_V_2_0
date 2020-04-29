package com.askj.supervision.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.supervision.service.SupervisionApiService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger; 
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean; 
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param; 
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BsCheckDetailDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.BschecktaskDTO;
import com.askj.app.service.SjbService;
import com.askj.supervision.service.AqjcglService;
import com.askj.supervision.service.CheckHandlerService;
import com.zzhdsoft.utils.SysmanageUtil;
 /**
  * 
  *  安全监管PC版实现
  * Written by ：ly
  *
  */
@IocBean
@At("/aqgl")
@Fail("jsp:/jsp/error/error")
public class AqjcglModule {
	protected final Logger logger = Logger.getLogger(AqjcglModule.class);
	@Inject
	protected AqjcglService aqjcglService;
	@Inject
	protected CheckHandlerService checkHandlerService;
	@Inject
	protected SupervisionApiService supervisionApiService;
	/**
	 * aqrwIndex :检查任务页面加载
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/aqjg/aqrw")
	public void aqrwIndex(HttpServletRequest request) {
		// 页面初始化
	}
	 /**
	 * aqrwIndex :企业检查页面加载
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/pcomjc/pcomjcList")
	public void pcomjcIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * queryjcrw ：查询检查任务 根据用户和地区编码
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryjcrw(@Param("..") BschecktaskDTO dto, @Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = aqjcglService.queryjcrw(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return aqjcglService.queryjcrw(dto, pd);
		
	}
	/**
	 * 
	 *  jclsIndex的中文名称：跳转到检查历史  
	 *  jcxIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/aqjg/jcls")
	public void jclsIndex(HttpServletRequest request) {
		// 页面初始化
	} 
	/**
	 * 
	 *  jcjgPrintIndex的中文名称：打印页
	 *  jcxIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/aqjg/jcjgPrint")
	public void jcjgPrintIndex(HttpServletRequest request) {
		// 页面初始化
	} 
	/**
	 * 
	 *  jcxIndex的中文名称：跳转到安全检查   检查项页面
	 *  jcxIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/aqjg/jcx")
	public void jcxIndex(HttpServletRequest request) {
		// 页面初始化
	} 
	/**
	 * bathSaveCheckDetail： 批量保存检查明细并修改检查结果概要信息表的状态
	 * 业务逻辑描述：
	 * 	   批量保存检查明细并修改检查结果概要信息表的状态
	 * @param request
	 * @param dto
	 * @param mdto
	 * @return
	 * @throws Exception
	 */
//	@AdaptBy(type = JsonAdaptor.class)
	@At
	@Ok("json")
	public Object bathSaveCheckDetail(HttpServletRequest request, @Param("..") BsCheckDetailDTO dto, @Param("..") BsCheckMasterDTO mdto)
			throws Exception {
		// request.getParameter(arg0);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "9999");
		result.put("msg", "保存失败");
		result.put("success", false);
		// 批量保存明细
		Map map = checkHandlerService.saveCheckDetailForBatch(request, dto);
		// 修改结果状态(保存平均分)
		mdto.setResultid(dto.getResultid());
		checkHandlerService.updateBsCheckMasterStateByResultid(request, mdto);

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
	 *  jcjgIndex的中文名称：跳转到安全检查   检查结果
	 *  jcxIndex的概要说明：
	 *  @param request
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/aqjg/jcjg")
	public void jcjgIndex(HttpServletRequest request) {
		// 页面初始化
	} 
	/**
	 * 
	 * updateResultByid的中文名称：修改结果状态和明细信息 (食品生产企业特殊判断)
	 * 
	 * updateResultByid的概要说明：resulid(查询顺序需要调整)
	 * 
	 * @param dto
	 * @return Written by :ly
	 * 
	 */
	@At
	@Ok("json")
	public Object updateResultByid(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
		Map map = new HashMap();
		try {
			// 修改结果状态和明细信息
			// 判断大类选择后台页面拼接
			map = checkHandlerService.updateBsCheckMasterStateByResultid(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


	 /**
	  *
	  * updateResultinfo的中文名称：修改结果信息
	  *
	  * updateResultinfo的概要说明：修改结果信息
	  *
	  * @param dto
	  * @return Written by :ly
	  *
	  */
	 @At
	 @Ok("json")
	 public Object updateResultinfo(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) throws Exception {
		 Map<String, Object> result = new HashMap<String, Object>();
		 result.put("code", "9999");
		 result.put("msg", "操作失败");
		 result.put("success", false);
		 if ("null".equalsIgnoreCase(dto.getResultid()) || StringUtils.isEmpty(dto.getResultid())) {
			 result.put("msg", "检查计划ID[resultid]不能为空");
			 return result;
		 }
		 if ("null".equalsIgnoreCase(dto.getComid()) || StringUtils.isEmpty(dto.getComid())) {
			 result.put("msg", "公司ID[commid]不能为空");
			 return result;
		 }
		 return SysmanageUtil.execAjaxResult(checkHandlerService.updateResultinfo(request, dto));

	 }

 }
