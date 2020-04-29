package com.zzhdsoft.mvc.workflow;

import com.askj.oa.dto.EgarchiveinfoDTO;
import com.askj.oa.service.ArchiveService;
import com.askj.zfba.dto.ZfajdjDTO;
import com.askj.zfba.service.AjdjService;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.util.StringUtils;
import com.zzhdsoft.mvc.workflow.domain.ProcessResult;
import com.zzhdsoft.mvc.workflow.util.SimpleXMLWorkShop;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushInfoDTO;
import com.zzhdsoft.siweb.dto.workflow.WorkflowDTO;
import com.zzhdsoft.siweb.entity.workflow.Wf_node_trans;
import com.zzhdsoft.siweb.entity.workflow.Wf_node_userid;
import com.zzhdsoft.siweb.service.jpush.JpushService;
import com.zzhdsoft.siweb.service.workflow.WorkflowService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.document.DocumentInfo;
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

/**
 * 
 * WorkflowModule的中文名称：工作流管理Module
 * 
 * WorkflowModule的描述：
 * 
 * Written by : zjf
 */
@At("/api/wf")
@IocBean
public class WorkflowAPIModule {
	protected final Logger logger = Logger.getLogger(WorkflowAPIModule.class);

	@Inject
	protected WorkflowService workflowService;

	@Inject
	protected JpushService jpushService;

	@Inject
	protected AjdjService ajdjService;

	@Inject
	private ArchiveService archiveService;

	@DocumentInfo(
			sort = 1,
			name="queryWfywDaiban",
			desc = "查询待办任务",
			functiondesc = "根据用户ID查询待办任务",
			author = "sunyifeng",
			params = "userid:用户ID,必填/aaz027:用户统筹区,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"psbh:工作流流程编号,"+
					"psmc: 工作流流程名称,"+
					"nodeid: 工作流节点表ID,"+
					"nodename:节点名称,"+
					"nodesx: 节点时限,"+
					"nodeurl:节点URL,"+
					"ywlcid:业务流程ID,"+
					"ywbh:业务编号,"+
					"ywlccurnode:当前节点,"+
					"nodesxbegin:时限开始时间,"+
					"nodesxend:时限结束时间,"+
					"comdm:企业代码,"+
					"commc:流程待办描述}"
					+"]}",
			date="2018-05-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object queryWfywDaiban(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			String message = "";
			if(StringUtils.isEmpty(dto.getUserid())){
				message += "!userid为必填项";
			}
			if(StringUtils.isEmpty(dto.getAaa027())){
				message += "!aaa027为必填项";
			}
			if(StringUtils.isEmpty(dto.getUserid())||StringUtils.isEmpty(dto.getAaa027())){
				throw new BusinessException(message);
			}

			map = workflowService.queryWfywDaiban(dto, pd);

			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 待办任务查看详情
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryLcdb(HttpServletRequest request,
								  @Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		//yewumcpym	zfbalc 		gwglfwlc
		try {
			String str= (String) request.getParameter("userId");
			//案件详情
			if("zfbalc".equals(dto.getYewumcpym())){
				ZfajdjDTO zfajdjDTO=new ZfajdjDTO();
				zfajdjDTO.setAjdjid(dto.getYwbh());
				zfajdjDTO.setUserid(str);
				map = ajdjService.queryAjdj(zfajdjDTO, pd);
				List ls = (List) map.get("rows");
				zfajdjDTO = null;
				if (ls != null && ls.size() > 0) {
					zfajdjDTO = (ZfajdjDTO) ls.get(0);
				}
				map.remove("rows");
				map.put("data", zfajdjDTO);
			}
			//发文详情
			if("gwglfwlc".equals(dto.getYewumcpym())||"xtdcksw".equals(dto.getYewumcpym())||"gwglswlc".equals(dto.getYewumcpym())){
				EgarchiveinfoDTO egarchiveinfoDTO=new EgarchiveinfoDTO();
				egarchiveinfoDTO.setArchiveid(dto.getYwbh());
				map =archiveService.queryArchiveDTO(egarchiveinfoDTO, pd);
				List ls = (List) map.get("rows");
				egarchiveinfoDTO = null;
				if (ls != null && ls.size() > 0) {
					egarchiveinfoDTO = (EgarchiveinfoDTO) ls.get(0);
				}
				map.remove("rows");
				map.put("data", egarchiveinfoDTO);
			}

			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryWfnodeTransList的中文名称：查询工作流节点流向返回list
	 *
	 * queryWfnodeTransList的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	public  Object  queryWfnodeTransList(@Param("..")Wf_node_trans wf_node_trans) throws Exception {
		Map map = new HashMap();
		try {
			List<Wf_node_trans> trans = workflowService.queryWfnodeTransList(wf_node_trans.getPsbh(),wf_node_trans.getTransfrom());
			map.put("data",trans);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
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

	@DocumentInfo(
			sort = 2,
			name="queryWfnodeTrans",
			desc = "查询工作流节点流向",
			functiondesc = "根据用户psbhh和transfrom工作流节点流向",
			author = "sunyifeng",
			params = "psbh:工作流流程编号,必填/transfrom:要查询节点的编号,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"psbh:工作流流程编号,"+
					"nodetransid: 节点流向ID,"+
					"transid: 流向ID,"+
					"transname:流向名称,"+
					"transfrom: 流向发起节点名称,"+
					"transto:流向目标节点名称,"+
					"}"
					+"]}",
			date="2018-05-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object queryWfnodeTrans(HttpServletRequest request,
			@Param("..") WorkflowDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			String message = "";
			if(StringUtils.isEmpty(dto.getPsbh())){
				message += "!psbh:工作流流程编号为必填项";
			}
			if(StringUtils.isEmpty(dto.getTransfrom())){
				message += "!transfrom:要查询节点的编号为必填项";
			}
			if(StringUtils.isEmpty(dto.getPsbh())||StringUtils.isEmpty(dto.getTransfrom())){
				throw new BusinessException(message);
			}
			return workflowService.queryWfnodeTrans(dto, pd);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
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

	@DocumentInfo(
			sort = 3,
			name="doWfprocess",
			desc = "流程提交",
			functiondesc = "通用操作，推动工作流向下走一步",
			author = "sunyifeng",
			params = "ywlcid:业务流程ID,必填/transval:流向值,必填/"+
					"shifouTongguo:是否通过,必填/transname:流向名称,必填/"+
					"transyy:流向原因,必填/time:时间当前时期毫秒数,必填",
			returndesc = "{msg:返回消息,ywlclogid:业务流程日志ID,code:返回码}",
			date="2018-05-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object doWfprocess(HttpServletRequest request,
			@Param("..") WorkflowDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			String message = "";
			boolean flag = false;
			if(StringUtils.isEmpty(dto.getYwlcid())){
				flag = true;
				message += "!ywlcid:业务流程ID为必填项";
			}
			if(StringUtils.isEmpty(dto.getTransval())){
				flag = true;
				message += "!transval:流向值为必填项";
			}
			if(StringUtils.isEmpty(request.getParameter("shifouTongguo"))){
				flag = true;
				message += "!shifouTongguo:是否通过为必填项";
			}
			if(StringUtils.isEmpty(dto.getTransyy())){
				flag = true;
				message += "!transyy:流向原因为必填项";
			}
			if(StringUtils.isEmpty(request.getParameter("time"))){
				flag = true;
				message += "!time:时间当前时期毫秒数为必填项";
			}
			if(flag){
				throw new BusinessException(message);
			}
			flag = false;
			String id = workflowService.doWfprocess(
					request, dto);
			map.put("ywlclogid",id);
			return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}






	@DocumentInfo(
			sort = 4,
			name="queryYwlclog",
			desc = "查询办理流程日志",
			functiondesc = "查询办理流程环节",
			author = "sunyifeng",
			params = "ywbh:业务编号,必填",
			returndesc = "{msg:返回消息,total:总条数 ,code:返回码,rows:[{"+
					"psbh:工作流流程编号,"+
					"psmc: 工作流流程名称,"+
					"nodeid: 工作流节点表ID,"+
					"nodename:节点名称,"+
					"nodesx: 节点时限,"+
					"nodeurl:节点URL,"+
					"ywlcid:业务流程ID,"+
					"ywbh:业务编号,"+
					"ywlccurnode:当前节点,"+
					"nodesxbegin:时限开始时间,"+
					"nodesxend:时限结束时间,"+
					"aae036:操作时间,"+
					"aae011:操作人,"+
					"transname:流向名称,"+
					"ywlclogid:业务流程操作日志ID,"+
					"ywbljg:办理结果 01通过 02不通过 03打回,"+
					"sftzjd:是否是跳转节点1是0否,"+
					"transyy:流向原因,"+
					"comdm:企业代码,"+
					"commc:流程待办描述}"
					+"]}",
			date="2018-05-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object queryYwlclog(@Param("..") WorkflowDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			String message = "";
			boolean flag = false;
			if(StringUtils.isEmpty(dto.getYwbh())){
				flag = true;
				message += "!ywbh:业务编号为必填项";
			}

			if(flag){
				throw new BusinessException(message);
			}
			flag = false;
			map = workflowService.queryYwlclog(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
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
	@DocumentInfo(
			sort = 4,
			name="huituiWfprocess",
			desc = "回退工作流",
			functiondesc = "通用操作，推动工作流回退到上一步",
			author = "sunyifeng",
			params = "ywlcid:业务流程ID,必填/ywbh:业务编号,必填/psbh:工作流流程编号,必填/nodeid:工作流节点表ID,必填",
			returndesc = "{msg:返回消息,code:返回码}"
					+"]}",
			date="2018-05-23",
			version = "1.0.0")
	@At
	@Ok("json")
	public Object huituiWfprocess(HttpServletRequest request,
			@Param("..") WorkflowDTO dto) throws Exception {
		try{
			return SysmanageUtil.execAjaxResult(workflowService.huituiWfprocess(
					request, dto));
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(null, e);
		}

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
