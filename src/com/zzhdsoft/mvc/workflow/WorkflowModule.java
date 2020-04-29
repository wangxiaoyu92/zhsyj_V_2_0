package com.zzhdsoft.mvc.workflow;

import com.zzhdsoft.mvc.workflow.domain.ProcessResult;
import com.zzhdsoft.mvc.workflow.util.SimpleXMLWorkShop;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushInfoDTO;
import com.zzhdsoft.siweb.dto.workflow.WorkflowDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.workflow.Wf_node_userid;
import com.zzhdsoft.siweb.service.jpush.JpushService;
import com.zzhdsoft.siweb.service.workflow.WorkflowService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.JDOMException;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * WorkflowModule的中文名称：工作流管理Module
 *
 * WorkflowModule的描述：
 *
 * Written by : zjf
 */
@At("/workflow")
@IocBean
public class WorkflowModule {
	protected final Logger logger = Logger.getLogger(WorkflowModule.class);

	@Inject
	protected WorkflowService workflowService;



	/**
	 *
	 * wf_workdayIndex的中文名称：工作日管理页面
	 *
	 * wf_workdayIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_workday")
	public void wf_workdayIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfworkday的中文名称：查询工作年度
	 *
	 * queryWfworkday的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfworkday(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.queryWfworkday(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	@At
	@Ok("json")
	public Object FJ(HttpServletRequest request,
								 @Param("..") FjDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.FJ(dto);
			List list=(List)map.get("rows");
			Map map2=new HashMap();
			map2.put("data",list);
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			map2.put("orgid", vSysUser.getOrgid());
			map2.put("orgname",vSysUser.getOrgname());
			return SysmanageUtil.execAjaxResult(map2, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	@At
	@Ok("json")
	public Object queryWfywlcuser(HttpServletRequest request,
					 @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryWfywlcuser(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if("".equals(s)){
						s=wdto.getUserid();
					}else{
						s+=","+wdto.getUserid();
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW1(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW1(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if(wdto.getTransyy()!=null&&!"".equals(wdto.getTransyy())) {
						if ("".equals(s)) {
							s = wdto.getTransyy() + "------" + wdto.getAae011();
						} else {
							s += "," + wdto.getTransyy() + "------" + wdto.getAae011();
						}
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW2(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW2(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if(wdto.getTransyy()!=null&&!"".equals(wdto.getTransyy())) {
						if ("".equals(s)) {
							s = wdto.getTransyy() + "------" + wdto.getAae011();
						} else {
							s += "," + wdto.getTransyy() + "------" + wdto.getAae011();
						}
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW3(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW3(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if(wdto.getTransyy()!=null&&!"".equals(wdto.getTransyy())) {
						if ("".equals(s)) {
							s = wdto.getTransyy() + "------" + wdto.getAae011();
						} else {
							s += "," + wdto.getTransyy() + "------" + wdto.getAae011();
						}
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW4(HttpServletRequest request,
						  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW4(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if(wdto.getTransyy()!=null&&!"".equals(wdto.getTransyy())) {
						if ("".equals(s)) {
							s = wdto.getTransyy() + "------" + wdto.getAae011();
						} else {
							s += "," + wdto.getTransyy() + "------" + wdto.getAae011();
						}
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW5(HttpServletRequest request,
						  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW5(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if(wdto.getTransyy()!=null&&!"".equals(wdto.getTransyy())) {
						if ("".equals(s)) {
							s = wdto.getTransyy() + "------" + wdto.getAae011();
						} else {
							s += "," + wdto.getTransyy() + "------" + wdto.getAae011();
						}
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW7(HttpServletRequest request,
						  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW7(dto);
			String s="";
			String s1="";
			if(list!=null&&list.size()>0){

					WorkflowDTO wdto = (WorkflowDTO) list.get(0);
					s=wdto.getAae011();
					s1=wdto.getUserid();
			}
			map.put("aae011",s);
			map.put("userid",s1);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryW8(HttpServletRequest request,
						  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryW8(dto);
			String s="";
			String s1="";
			if(list!=null&&list.size()>0){

				WorkflowDTO wdto = (WorkflowDTO) list.get(0);
				s=wdto.getAae011();
				s1=wdto.getUserid();
			}
			map.put("aae011",s);
			map.put("userid",s1);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	@At
	@Ok("json")
	public Object queryWfywlcnbuser(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto)
			throws Exception {
		Map map = new HashMap();
		try {
			List list = workflowService.queryWfywlcnbuser(dto);
			String s="";
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++) {
					WorkflowDTO wdto = (WorkflowDTO) list.get(i);
					if("".equals(s)){
						s=wdto.getUserid();
					}else{
						s+=","+wdto.getUserid();
					}
				}
			}
			map.put("fzruserid",s);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * wf_workdayFormIndex的中文名称：工作日设置页面
	 *
	 * wf_workdayFormIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_workdayForm")
	public void wf_workdayFormIndex(HttpServletRequest request)
			throws Exception {
		// 页面初始化
		String getCurYear = StringHelper.showNull2Empty(request
				.getParameter("getCurYear"));
		if ("".equals(getCurYear)) {
			getCurYear = String.valueOf(DateUtil.getCurrentYear());
		}

		boolean haveCurYearData = workflowService.isExistsWfworkday(getCurYear);
		request.setAttribute("haveCurYearData", haveCurYearData);

		String workday = workflowService.getWorkdayByYear(getCurYear);
		request.setAttribute("workdays", workday);
	}

	/**
	 *
	 * queryWfworkdayDetail的中文名称：查询年度工作日明细
	 *
	 * queryWfworkdayDetail的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfworkdayDetail(HttpServletRequest request,
									   @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfworkdayDetail(dto, pd);
	}

	/**
	 *
	 * addWfworkday的中文名称：新增年度工作日
	 *
	 * addWfworkday的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addWfworkday(HttpServletRequest request,
							   @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.addWfworkday(
				request, dto));
	}

	/**
	 *
	 * updateWfworkday的中文名称：修改年度工作日
	 *
	 * updateWfworkday的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object updateWfworkday(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.updateWfworkday(
				request, dto));
	}

	/**
	 *
	 * wf_adminIndex的中文名称：工作流管理页面
	 *
	 * wf_adminIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflow/wf_admin")
	public void wf_adminIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfprocess的中文名称：查询工作流
	 *
	 * queryWfprocess的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfprocess(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.queryWfprocess(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getWfprocess的中文名称：获取工作流的XML文件
	 *
	 * getWfprocess的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("raw:xml")
	public File getWfprocess(HttpServletRequest request,
							 @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		ProcessResult processResult = new ProcessResult();
		String name = StringHelper.showNull2Empty(request.getParameter("name"));
		//gu20180606 改为根据id查，psmc汉字会出莫名的问题 dto.setPsmc(name);
		dto.setPsid(name);

		String rootPath = request.getSession().getServletContext().getRealPath(
				"/");
		String filepath = rootPath + File.separator + "processes";
		FileUtil.createFolder(filepath);
		String filename = filepath + File.separator + name + ".xml";
		if (FileUtil.checkFile(filename)) {// 文件存在时，直接删除原XML文件
			FileUtil.delFile(filename);
		}

		File file = new File(filename);
		Document doc = null;
		if (workflowService.checkProcessNameIsExist(dto)) {
			String xml = "";
			Map map = workflowService.queryWfprocess(dto, pd);
			List ls = (List) map.get("rows");
			if (ls != null && ls.size() > 0) {
				WorkflowDTO wfProcess = (WorkflowDTO) ls.get(0);
				xml = wfProcess.getPsxml();
			}

			try {
				doc = SimpleXMLWorkShop.str2Doc(xml);
			} catch (IOException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
			} catch (JDOMException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
			}
		} else {
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes("工作流【" + name + "】不存在，无法查看！");
		}

		doc = (doc == null) ? ProcessResult.convertXml(processResult) : doc;
		SimpleXMLWorkShop.outputXML(doc, file);

		return file;
	}

	/**
	 *
	 * checkWfprocessState的中文名称：检查工作流是否正在使用
	 *
	 * checkWfprocessState的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object checkProcessIsUse(HttpServletRequest request,
									@Param("..") WorkflowDTO dto) throws Exception {
		String msg = "";
		if (workflowService.checkProcessIsUse(dto)) {
			msg = "此工作流正在使用，禁止修改！";
		}
		return SysmanageUtil.execAjaxResult(msg);
	}

	/**
	 *
	 * addWfprocess的中文名称：新增工作流
	 *
	 * addWfprocess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("raw:xml")
	public File addWfprocess(HttpServletRequest request,
							 @Param("..") WorkflowDTO dto) throws Exception {
		String name = StringHelper.showNull2Empty(request.getParameter("name"));
		String wfPsid = DbUtils.getSequenceStr();
		dto.setPsid(wfPsid);
		String rootPath = request.getSession().getServletContext().getRealPath(
				"/");
		String filepath = rootPath + File.separator + "processes";
		FileUtil.createFolder(filepath);
		String filename = filepath + File.separator + wfPsid + ".xml";
		if (FileUtil.checkFile(filename)) {// 文件存在时，直接删除原XML文件
			FileUtil.delFile(filename);
		}

		File file = new File(filename);
		Document doc = null;
		ProcessResult processResult = workflowService.addWfprocess(request,
				dto, file);
		doc = ProcessResult.convertXml(processResult);
		SimpleXMLWorkShop.outputXML(doc, file);
		return file;
	}

	/**
	 *
	 * updateWfprocess的中文名称：修改工作流
	 *
	 * updateWfprocess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("raw:xml")
	public File updateWfprocess(HttpServletRequest request,
								@Param("..") WorkflowDTO dto) throws Exception {
		String name = StringHelper.showNull2Empty(request.getParameter("name"));
		String rootPath = request.getSession().getServletContext().getRealPath(
				"/");
		String filepath = rootPath + File.separator + "processes";
		FileUtil.createFolder(filepath);
		String filename = filepath + File.separator + name + ".xml";
		if (FileUtil.checkFile(filename)) {// 文件存在时，直接删除原XML文件
			FileUtil.delFile(filename);
		}

		File file = new File(filename);
		Document doc = null;
		ProcessResult processResult = workflowService.updateWfprocess(request,
				dto, file);
		doc = ProcessResult.convertXml(processResult);
		SimpleXMLWorkShop.outputXML(doc, file);
		return file;
	}

	/**
	 *
	 * delWfprocess的中文名称：删除工作流
	 *
	 * delWfprocess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delWfprocess(HttpServletRequest request,
							   @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfprocess(
				request, dto));
	}

	@At
	@Ok("json")
	public Object delWfywlc(HttpServletRequest request,
							@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfywlc(
				request, dto));
	}

	@At
	@Ok("json")
	public Object delWfnodezr(HttpServletRequest request,
							@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfnodezr(
				request, dto));
	}

	/**
	 *
	 * wf_yewu_processIndex的中文名称：业务工作流绑定管理页面
	 *
	 * wf_yewu_processIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_yewu_process")
	public void wf_yewu_processIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfyewuProcess的中文名称：查询业务工作流绑定记录
	 *
	 * queryWfyewuProcess的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfyewuProcess(HttpServletRequest request,
									 @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		return workflowService.queryWfyewuProcess(dto, pd);
	}

	/**
	 *
	 * wfcz_yewu_process_bindFormIndex的中文名称：业务工作流绑定编辑页面
	 *
	 * wfcz_yewu_process_bindFormIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_yewu_processForm")
	public void wf_yewu_processFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfyewuProcessDTO的中文名称：查询业务工作流绑定记录DTO
	 *
	 * queryWfyewuProcessDTO的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfyewuProcessDTO(HttpServletRequest request,
										@Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.queryWfyewuProcess(dto, pd);
			List ls = (List) map.get("rows");
			WorkflowDTO wfdto = null;
			if (ls != null && ls.size() > 0) {
				wfdto = (WorkflowDTO) ls.get(0);
			}
			map.put("data", wfdto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * addWfyewuProcess的中文名称：新增业务工作流绑定
	 *
	 * addWfyewuProcess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addWfyewuProcess(HttpServletRequest request,
								   @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.addWfyewuProcess(
				request, dto));
	}

	/**
	 *
	 * updateWfyewuProcess的中文名称：修改业务工作流绑定
	 *
	 * updateWfyewuProcess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object updateWfyewuProcess(HttpServletRequest request,
									  @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService
				.updateWfyewuProcess(request, dto));
	}

	/**
	 *
	 * delWfyewuProcess的中文名称：删除业务工作流绑定
	 *
	 * delWfyewuProcess的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delWfyewuProcess(HttpServletRequest request,
								   @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfyewuProcess(
				request, dto));
	}

	/**
	 *
	 * wf_node_roleIndex的中文名称：工作流节点权限管理页面
	 *
	 * wf_node_roleIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_role")
	public void wf_node_roleIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfprocessZTree的中文名称：查询工作流ZTree
	 *
	 * queryWfprocessZTree的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfprocessZTree(HttpServletRequest request,
									  @Param("..") WorkflowDTO dto) throws Exception {
		try {
			List ls = (List) workflowService.queryWfprocessZTree(request, dto);
			String mydata = Json.toJson(ls, JsonFormat.compact());
			mydata = mydata.replace("isparent", "isParent");
			mydata = mydata.replace("isopen", "open");
			Map m = new HashMap();
			m.put("mydata", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 *
	 * queryWfnodeZTree的中文名称：查询工作流节点ZTree
	 *
	 * queryWfnodeZTree的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeZTree(HttpServletRequest request,
								   @Param("..") WorkflowDTO dto) throws Exception {
		try {
			List ls = (List) workflowService.queryWfnodeZTree(request, dto);
			String mydata = Json.toJson(ls, JsonFormat.compact());
			mydata = mydata.replace("isparent", "isParent");
			mydata = mydata.replace("isopen", "open");
			Map m = new HashMap();
			m.put("mydata", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 *
	 * queryWfnodeRole的中文名称：查询工作流节点权限
	 *
	 * queryWfnodeRole的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeRole(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeRole(dto, pd);
	}

	/**
	 *
	 * queryWfnodeNoRole的中文名称：查询工作流节点没有的权限
	 *
	 * queryWfnodeNoRole的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeNoRole(HttpServletRequest request,
									@Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeNoRole(dto, pd);
	}

	/**
	 *
	 * wf_node_roleFormIndex的中文名称：工作流节点编辑页面
	 *
	 * wf_node_roleFormIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_roleForm")
	public void wf_node_roleFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfnodeDTO的中文名称：查询工作流节点DTO
	 *
	 * queryWfnodeDTO的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeDTO(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.queryWfnode(dto, pd);
			List ls = (List) map.get("rows");
			WorkflowDTO wfdto = null;
			if (ls != null && ls.size() > 0) {
				wfdto = (WorkflowDTO) ls.get(0);
			}
			map.put("data", wfdto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * updateWfnode的中文名称：修改工作流节点时限/URL
	 *
	 * updateWfnode的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object updateWfnode(HttpServletRequest request,
							   @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.updateWfnode(
				request, dto));
	}

	/**
	 *
	 * wf_node_roleAddRoleIndex的中文名称：工作流节点权限绑定页面
	 *
	 * wf_node_roleAddRoleIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_roleAddRole")
	public void wf_node_roleAddRoleIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * addWfnodeRole的中文名称：新增工作流节点权限
	 *
	 * addWfnodeRole的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addWfnodeRole(HttpServletRequest request,
								@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.addWfnodeRole(
				request, dto));
	}

	/**
	 *
	 * delWfnodeRole的中文名称：删除工作流节点权限
	 *
	 * delWfnodeRole的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delWfnodeRole(HttpServletRequest request,
								@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfnodeRole(
				request, dto));
	}

	/**
	 *
	 * queryWfnodeTrans的中文名称：查询工作流节点流向
	 *
	 * queryWfnodeTrans的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeTrans(HttpServletRequest request,
								   @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeTrans(dto, pd);
	}

	/**
	 *
	 * updateWfnodeTrans的中文名称：修改工作流节点流向值
	 *
	 * updateWfnodeTrans的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object updateWfnodeTrans(HttpServletRequest request,
									@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.updateWfnodeTrans(
				request, dto));
	}

	/**
	 *
	 * beginWfprocess的中文名称：启动工作流
	 *
	 * beginWfprocess的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object beginWfprocess(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.beginWfprocess(
				request, dto));
	}

	@At
	@Ok("json")
	public Object beginWffwprocess(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.beginWffwprocess(
				request, dto));
	}

	@At
	@Ok("json")
	public Object beginWfgongwenprocess(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.beginWfgongwenprocess(
				request, dto));
	}


	@At
	@Ok("json")
	public Object beginWfprocessnew(HttpServletRequest request,
								 @Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.beginWfprocessnew(
				request, dto));
	}

	/**
	 *
	 * rollbackWfprocess的中文名称：回滚工作流
	 *
	 * rollbackWfprocess的概要说明：将刚点击受理还未往下进行的工作流回滚
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 *
	 */
	@At
	@Ok("json")
	public Object rollbackWfprocess(HttpServletRequest request,
									@Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.rollbackWfprocess(
				request, dto));
	}

	/**
	 *
	 * doWfprocess的中文名称：通用操作，推动工作流向下走一步
	 *
	 * doWfprocess的概要说明：工作流待办业务
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object doWfprocess(HttpServletRequest request,
							  @Param("..") WorkflowDTO dto) throws Exception {
		String message=workflowService.doWfprocess(
				request, dto);
		String regex = "^[\\u4e00-\\u9fa5]*$";
		Matcher m = Pattern.compile(regex).matcher(message);

		if(m.find()) {
			SysmanageUtil.execAjaxResult(message);
		}
		return SysmanageUtil.execAjaxResult("");
	}

	/**
	 *
	 * doWfgongwenprocess的中文名称：通用操作,推动公文工作流向下走一步
	 *
	 * doWfgongwenprocess的概要说明：公文工作流待办业务
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zk
	 *
	 */
	@At
	@Ok("json")
	public Object doWfgongwenprocess(HttpServletRequest request,
							  @Param("..") WorkflowDTO dto) throws Exception {
		String message=workflowService.doWfgongwenprocess(
				request, dto);
		String regex = "^[\\u4e00-\\u9fa5]*$";
		Matcher m = Pattern.compile(regex).matcher(message);

		if(m.find()) {
			SysmanageUtil.execAjaxResult(message);
		}
		return SysmanageUtil.execAjaxResult("");
	}
	@At
	@Ok("json")
	public Object doWfprocessnew(HttpServletRequest request,
							  @Param("..") WorkflowDTO dto) throws Exception {
		String message=workflowService.doWfprocessnew(
				request, dto);
		String regex = "^[\\u4e00-\\u9fa5]*$";
		Matcher m = Pattern.compile(regex).matcher(message);

		if(m.find()) {
			SysmanageUtil.execAjaxResult(message);
		}
		return SysmanageUtil.execAjaxResult("");
	}
	@At
	@Ok("json")
	public Object doWfswprocess(HttpServletRequest request,
							  @Param("..") WorkflowDTO dto) throws Exception {
		String message=workflowService.doWfswprocess(
				request, dto);
		String regex = "^[\\u4e00-\\u9fa5]*$";
		Matcher m = Pattern.compile(regex).matcher(message);

		if(m.find()) {
			SysmanageUtil.execAjaxResult(message);
		}
		return SysmanageUtil.execAjaxResult("");
	}
    @At
    @Ok("json")
    public Object doWffwprocess(HttpServletRequest request,
                                @Param("..") WorkflowDTO dto) throws Exception {
        String message=workflowService.doWffwprocess(
                request, dto);
        String regex = "^[\\u4e00-\\u9fa5]*$";
        Matcher m = Pattern.compile(regex).matcher(message);

        if(m.find()) {
            SysmanageUtil.execAjaxResult(message);
        }
        return SysmanageUtil.execAjaxResult("");
    }

	/**
	 *
	 * wfyw_daibanIndex的中文名称：待办任务
	 *
	 * wfyw_daibanIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowyewu/wfyw_daiban")
	public void wfyw_daibanIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * wfyw_daibangongwenIndex的中文名称：公文待办任务
	 *
	 * wfyw_daibangongwenIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowyewu/wfyw_daibangongwen")
	public void wfyw_daibangongwenIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfywDaiban的中文名称：查询工作流待办业务
	 *
	 * queryWfywDaiban的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfywDaiban(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {

		Map map=new HashMap();
		try {
			map = workflowService.queryWfywDaiban(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryWfywgongwenDaiban的中文名称：查询公文管理待办业务
	 *
	 * queryWfywgongwenDaiban的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zk
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfywgongwenDaiban(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {

		Map map=new HashMap();
		try {
			map = workflowService.queryWfywgongwenDaiban(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * ajdjMain的中文名称：查询办理流程环节
	 *
	 * newsIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowyewu/wfywlclog")
	public void wfywlclogIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryYwlclog的中文名称：查询办理流程环节
	 *
	 * queryYwlclog的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryYwlclog(@Param("..") WorkflowDTO dto,
							   @Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = workflowService.queryYwlclog(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryYwlclogDto(@Param("..") WorkflowDTO dto
							   ) throws Exception {
		Map map=new HashMap();
		try {
			map = workflowService.queryYwlclogDto(dto);
			WorkflowDTO ws=new WorkflowDTO();
			List ls = (List) map.get("rows");
			if (ls != null && ls.size() > 0) {
				ws = (WorkflowDTO) ls.get(0);
			}
			map.put("data", ws);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}



	/**
	 *
	 * queryYwlclogList的中文名称：查询办理流程环节List
	 *
	 * queryYwlclogList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	@Filters()
	public Object queryYwlclogList(@Param("..") WorkflowDTO dto,
								   @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = workflowService.queryYwlclog(dto, pd);
			List ls = (List) map.get("rows");
			map.put("data", ls);
			map.put("count", ls.size());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * wf_node_wsglIndex的中文名称：工作流节点关联文书页面
	 *
	 * wf_node_wsglIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_wsgl")
	public void wf_node_wsglIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * wf_node_wsglAddIndex的中文名称：工作流节点选择文书关联页面
	 *
	 * wf_node_wsglAddIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_wsglAdd")
	public void wf_node_wsglAddIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfnodeWsgl的中文名称：查询工作流节点已关联文书
	 *
	 * queryWfnodeWsgl的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeWsgl(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeWsgl(dto, pd);
	}

	/**
	 *
	 * queryWfnodeWsglNo的中文名称：查询工作流节点未关联文书
	 *
	 * queryWfnodeWsglNo的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeWsglNo(HttpServletRequest request,
									@Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeWsglNo(dto, pd);
	}

	/**
	 *
	 * addWfnodeWsgl的中文名称：新增节点关联文书
	 *
	 * addWfnodeWsgl的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addWfnodeWsgl(HttpServletRequest request,
								@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.addWfnodeWsgl(
				request, dto));
	}

	/**
	 *
	 * delWfnodeWsgl的中文名称：删除节点关联文书
	 *
	 * delWfnodeWsgl的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delWfnodeWsgl(HttpServletRequest request,
								@Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfnodeWsgl(
				request, dto));
	}

	/**
	 *
	 * wf_node_useridIndex的中文名称：工作流节点绑定操作员管理页面
	 *
	 * wf_node_useridIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_userid")
	public void wf_node_useridIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfnodeUserid的中文名称：查询工作流节点绑定的操作员信息
	 *
	 * queryWfnodeUserid的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeUserid(HttpServletRequest request,
									@Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeUserid(dto, pd);
	}

	/**
	 *
	 * wf_node_roleAddUseridIndex的中文名称：工作流节点操作员绑定页面
	 *
	 * wf_node_roleAddUseridIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_roleAddUserid")
	public void wf_node_roleAddUseridIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryWfnodeNoRole的中文名称：查询工作流节点没有的权限
	 *
	 * queryWfnodeNoRole的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryWfnodeNoUserid(HttpServletRequest request,
									  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		return workflowService.queryWfnodeNoUserid(dto, pd);
	}

	/**
	 *
	 * addWfnodeUserid的中文名称：新增工作流节点权限保存
	 *
	 * addWfnodeUserid的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object addWfnodeUserid(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.addWfnodeUserid(
				request, dto));
	}

	/**
	 *
	 * delWfnodeUserid的中文名称：删除工作流节点操作员绑定
	 *
	 * delWfnodeUserid的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object delWfnodeUserid(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto) {
		return SysmanageUtil.execAjaxResult(workflowService.delWfnodeUserid(
				request, dto));
	}

	/**
	 *
	 * huituiWfprocess的中文名称：通用操作，推动工作流回退到上一步
	 *
	 * huituiWfprocess的概要说明：工作流待办业务
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object huituiWfprocess(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(workflowService.huituiWfprocess(
				request, dto));
	}

	/**
	 *
	 * wf_node_useridIndex的中文名称：工作流节点绑定操作员管理页面
	 *
	 * wf_node_useridIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/workflowcz/wf_node_fromuser")
	public void wf_node_fromuserIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryUserHavedNode的中文名称：查询操作员【已授权】的节点权限
	 *
	 * queryUserHavedNode的概要说明：
	 *
	 * @param userid
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryUserHavedNode(@Param("..") Wf_node_userid dto) {
		return workflowService.queryUserHavedNode(dto);
	}

	/**
	 *
	 * saveUserHavedNode的中文名称：操作员统筹区授权【保存】
	 *
	 * saveUserHavedNode的概要说明：
	 *
	 * @param roleid
	 * @param fid
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object saveUserHavedNode(HttpServletRequest request, @Param("userid") String userid,@Param("psbh") String psbh, @Param("nodeid") List fid) {
		return SysmanageUtil.execAjaxResult(workflowService.saveUserHavedNode(request, userid,psbh, fid));
	}


}
