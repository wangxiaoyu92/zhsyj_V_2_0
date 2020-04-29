package com.zzhdsoft.siweb.service.workflow;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.askj.oa.entity.Egarchiveinfo;
import com.askj.oa.service.EgWorkTaskService;
import com.lbs.util.StringUtils;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushInfoDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.workflow.*;
import com.zzhdsoft.siweb.service.jpush.JpushService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.JDOMException;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.Param;

import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.mvc.workflow.Activity;
import com.zzhdsoft.mvc.workflow.Transition;
import com.zzhdsoft.mvc.workflow.WorkflowProcess;
import com.zzhdsoft.mvc.workflow.domain.ProcessResult;
import com.zzhdsoft.mvc.workflow.util.SimpleXMLWorkShop;
import com.zzhdsoft.mvc.workflow.util.WorkflowProcessSaxUtil;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.workflow.WorkflowDTO;
import com.askj.zfba.dto.ZfajzfwsDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysrole;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.zfba.entity.Zfajzfwsnode;
import com.zzhdsoft.siweb.service.BaseService;
import com.askj.zfba.service.pub.WsgldyService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * WorkflowService的中文名称：工作流管理service
 * 
 * WorkflowService的描述：
 * 
 * Written by : zjf
 */
public class
WorkflowService extends BaseService {
	protected final Logger logger = Logger.getLogger(WorkflowService.class);
	@Inject
	private Dao dao;
	@Inject
	private WsgldyService wsgldyService;

	@Inject
	protected JpushService jpushService;

	public static int SUCCESS = 0;
	public static int FAIL = 1;
	public static int FILE_EXIST = 3;
	public static int FILE_NOT_FOUND = 5;
	public static int XML_PARSER_ERROR = 7;
	public static int IO_ERROR = 9;

	/**
	 * 
	 * queryWfworkday的中文名称：查询工作年度
	 * 
	 * queryWfworkday的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map queryWfworkday(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select distinct wdyear from Wf_workday a");
		sb.append(" where 1=1 ");
		sb.append("  and  a.wdyear = :wdyear ");
		sb.append("  order by a.wdyear desc");

		String[] ParaName = new String[] { "wdyear" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * queryWfworkdayDetail的中文名称：查询年度工作日明细
	 * 
	 * queryWfworkdayDetail的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map queryWfworkdayDetail(WorkflowDTO dto, PagesDTO pd)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select wdid, wdyear,wdday from Wf_workday a");
		sb.append(" where 1=1 ");
		sb.append("  and  a.wdyear = :wdyear ");
		sb.append("  order by a.wdyear ");

		String[] ParaName = new String[] { "wdyear" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * isExistsWfworkday的中文名称：校验年度工作日是否已经设置
	 * 
	 * isExistsWfworkday的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public boolean isExistsWfworkday(String getCurYear) throws Exception {
		boolean existFlag = false;
		WorkflowDTO wddto = new WorkflowDTO();
		PagesDTO pd = new PagesDTO();
		wddto.setWdyear(getCurYear);
		Map m = queryWfworkday(wddto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			existFlag = true;
		}
		return existFlag;
	}

	/**
	 * 
	 * getWorkdayByYear的中文名称：获取年度工作日明细，并以，分隔
	 * 
	 * getWorkdayByYear的概要说明：
	 * 
	 * @param wd_year
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public String getWorkdayByYear(String wd_year) throws Exception {
		StringBuffer sb = new StringBuffer("");
		Map map = new HashMap();
		WorkflowDTO dto = new WorkflowDTO();
		PagesDTO pd = new PagesDTO();
		dto.setWdyear(wd_year);
		map = queryWfworkdayDetail(dto, pd);
		List ls = (List) map.get("rows");
		if (null != ls && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				WorkflowDTO wd = (WorkflowDTO) ls.get(i);
				sb.append(wd.getWdday() + ",");
			}
		}
		String workday = sb.toString();
		if (workday.indexOf(",") > 0) {
			workday = workday.substring(0, workday.length() - 1);
		}
		return workday;
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
	public String addWfworkday(HttpServletRequest request, WorkflowDTO dto) {
		try {
			addWfworkdayImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addWfworkdayImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		String curr_year = request.getParameter("curr_year");
		String workday = request.getParameter("new_workday");
		if (workday.indexOf("end") > 0) {
			workday = workday.substring(0, workday.indexOf("end"));
		}

		String[] dataArr = workday.split(",");
		for (int i = 0; i < dataArr.length; i++) {
			Wf_workday wd = new Wf_workday();
			wd.setWdid(DbUtils.getSequenceStr());
			wd.setWdday(dataArr[i]);
			wd.setWdyear(curr_year);
			dao.insert(wd);
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public String updateWfworkday(HttpServletRequest request, WorkflowDTO dto) {
		try {
			updateWfworkdayImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateWfworkdayImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		String curr_year = request.getParameter("curr_year");
		String workday = request.getParameter("new_workday");
		if (workday.indexOf("end") > 0) {
			workday = workday.substring(0, workday.indexOf("end"));
		}

		// 先删除原记录
		dao.clear(Wf_workday.class, Cnd.where("wdyear", "=", curr_year));

		String[] dataArr = workday.split(",");
		for (int i = 0; i < dataArr.length; i++) {
			Wf_workday wd = new Wf_workday();
			wd.setWdid(DbUtils.getSequenceStr());
			wd.setWdday(dataArr[i]);
			wd.setWdyear(curr_year);
			dao.insert(wd);
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * queryWfprocess的中文名称：查询工作流
	 * 
	 * queryWfprocess的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map queryWfprocess(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select psid,psbh,psmc,psxml,pszt,");
		sb.append(" (select username from Sysuser");
		sb.append("   where userid = a.aae011) as aae011,aae036");
		sb.append(" from Wf_process a");
		sb.append(" where 1=1 ");
		sb.append("  and a.psbh = :psbh ");
		sb.append("  and a.psmc = :psmc ");
		sb.append("  and a.psid = :psid ");//gu20180606
		sb.append("  order by a.psid desc");

		String[] ParaName = new String[] { "psbh", "psmc","psid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * checkProcessNameIsExist的中文名称：查看要保存的工作流名称是否存在
	 * 
	 * checkProcessNameIsExist的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public boolean checkProcessNameIsExist(WorkflowDTO dto) throws Exception {
		boolean existFlag = false;
		PagesDTO pd = new PagesDTO();
		Map map = queryWfprocess(dto, pd);
		List ls = (List) map.get("rows");
		if (ls != null && ls.size() > 0) {
			existFlag = true;
		}
		return existFlag;
	}

	/**
	 * 
	 * checkProcessIsBindYewu的中文名称：判断此流程是否已经和业务绑定
	 * 
	 * checkProcessIsBindYewu的概要说明：绑定后不能删除此流程
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public boolean checkProcessIsBindYewu(WorkflowDTO dto) throws Exception {
		boolean bindFlag = false;
		// List ls = dao.query(Wf_menu_process.class, Cnd.where("psbh", "=", dto
		// .getPsbh()));
		// if (ls != null && ls.size() > 0) {
		// bindFlag = true;
		// }
		return bindFlag;
	}

	/**
	 * 
	 * checkProcessIsUse的中文名称：判断此流程是否正在使用
	 * 
	 * checkProcessIsUse的概要说明：使用时不能删除此流程
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public boolean checkProcessIsUse(WorkflowDTO dto) throws Exception {
		boolean useFlag = false;
		// List ls = dao.query(Wf_shlog.class, Cnd.where("psbh", "=", dto
		// .getPsbh()));
		// if (ls != null && ls.size() > 0) {
		// useFlag = true;
		// }
		return useFlag;
	}

	/**
	 * 
	 * addWfprocess的中文名称：新增工作流
	 * 
	 * addWfprocess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public ProcessResult addWfprocess(HttpServletRequest request,
			WorkflowDTO dto, File file) {
		try {
			return addWfprocessImp(request, dto, file);
		} catch (Exception e) {
			ProcessResult processResult = new ProcessResult();
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes(Lang.wrapThrow(e).getMessage());
			return processResult;
		}
	}

	@Aop( { "trans" })
	public ProcessResult addWfprocessImp(HttpServletRequest request,
			WorkflowDTO dto, File file) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();

		ProcessResult processResult = new ProcessResult();
		String name = StringHelper.showNull2Empty(request.getParameter("name"));
		String xml = StringHelper.showNull2Empty(request.getParameter("xml"));
		if ("".equals(name) || "".equals(xml)) {
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes("工作流名称、流程图不能为空！");
			return processResult;
		}
		dto.setPsmc(name);
		dto.setPsxml(xml);

		if (checkProcessNameIsExist(dto)) {
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes("工作流【" + name + "】已经存在，无法新增！");
			return processResult;
		} else {
			// 先写入XML文件，再写入数据库
			Document doc = null;
			try {
				doc = SimpleXMLWorkShop.str2Doc(xml);
			} catch (IOException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
				return processResult;
			} catch (JDOMException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
				return processResult;
			}

			if (doc != null) {
				try {
					SimpleXMLWorkShop.outputXML(doc, file);
				} catch (FileNotFoundException e) {
					processResult.setStatus(WorkflowService.FAIL);
					processResult.setMes(e.getMessage());
					return processResult;
				} catch (IOException e) {
					processResult.setStatus(WorkflowService.FAIL);
					processResult.setMes(e.getMessage());
					return processResult;
				}
			}

			// 写入数据到数据库wf_process, wf_node, wf_node_trans
			InputStream is = new FileInputStream(file);
			WorkflowProcess workflowProcess = WorkflowProcessSaxUtil
					.getWorkflowProcessData(is);
			if (null != workflowProcess) {
				// 写入主表wf_process
				Wf_process wfProcess = new Wf_process();
				wfProcess.setPsid(dto.getPsid());
				String psbh = DbUtils.getOneValue(dao,
						"select getPsbh() from dual");
				wfProcess.setPsbh(psbh);
				wfProcess.setPsmc(name);
				wfProcess.setPsxml(xml);
				wfProcess.setPszt("1");
				wfProcess.setAae011(sysuser.getUserid());
				wfProcess.setAae036(startTime);
				dao.insert(wfProcess);

				List<Activity> activityList = null;
				List<Transition> transList = null;
				activityList = workflowProcess.getActivityList();
				transList = workflowProcess.getTransitionList();
				// 写入表wf_node,Wf_node_trans
				for (Activity act : activityList) {
					Wf_node wfNode = new Wf_node();
					wfNode.setWfnodeid(DbUtils.getSequenceStr());
					wfNode.setPsbh(psbh);
					wfNode.setNodeid(act.getId());
					wfNode.setNodename(act.getName());
					wfNode.setNodetype(act.getType());
					wfNode.setNodex(act.getXCoordinate());
					wfNode.setNodey(act.getYCoordinate());
					wfNode.setNodewidth(act.getWidth());
					wfNode.setNodeheight(act.getHeight());
					wfNode.setNodecl("1");
					dao.insert(wfNode);
				}

				for (Transition trans : transList) {
					Wf_node_trans wfNodeTrans = new Wf_node_trans();
					wfNodeTrans.setNodetransid(DbUtils.getSequenceStr());
					wfNodeTrans.setPsbh(psbh);
					wfNodeTrans.setTransid(trans.getId());
					wfNodeTrans.setTransname(trans.getName());
					wfNodeTrans.setTransfrom(trans.getFrom());
					wfNodeTrans.setTransto(trans.getTo());
					dao.insert(wfNodeTrans);
				}
			}
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

		return processResult;
	}

	/**
	 * 
	 * updateWfprocess的中文名称：修改工作流
	 * 
	 * updateWfprocess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public ProcessResult updateWfprocess(HttpServletRequest request,
			WorkflowDTO dto, File file) {
		try {
			return updateWfprocessImp(request, dto, file);
		} catch (Exception e) {
			ProcessResult processResult = new ProcessResult();
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes(Lang.wrapThrow(e).getMessage());
			return processResult;
		}
	}

	@Aop( { "trans" })
	public ProcessResult updateWfprocessImp(HttpServletRequest request,
			WorkflowDTO dto, File file) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		ProcessResult processResult = new ProcessResult();
		String name = StringHelper.showNull2Empty(request.getParameter("name"));
		String xml = StringHelper.showNull2Empty(request.getParameter("xml"));
		if ("".equals(name) || "".equals(xml)) {
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes("工作流名称、流程图不能为空！");
			return processResult;
		}
//		dto.setPsmc(name);
		dto.setPsid(name);
		dto.setPsxml(xml);

		if (checkProcessNameIsExist(dto)) {
			// 先写入XML文件，再写入数据库
			Document doc = null;
			try {
				doc = SimpleXMLWorkShop.str2Doc(xml);
			} catch (IOException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
				return processResult;
			} catch (JDOMException e) {
				processResult.setStatus(WorkflowService.FAIL);
				processResult.setMes(e.getMessage());
				doc = null;
				return processResult;
			}

			if (doc != null) {
				try {
					SimpleXMLWorkShop.outputXML(doc, file);
				} catch (FileNotFoundException e) {
					processResult.setStatus(WorkflowService.FAIL);
					processResult.setMes(e.getMessage());
					return processResult;
				} catch (IOException e) {
					processResult.setStatus(WorkflowService.FAIL);
					processResult.setMes(e.getMessage());
					return processResult;
				}
			}

			// 写入数据到数据库wf_process, wf_node, wf_node_trans
			InputStream is = new FileInputStream(file);
			WorkflowProcess workflowProcess = WorkflowProcessSaxUtil
					.getWorkflowProcessData(is);
			if (null != workflowProcess) {
				// 更新主表wf_process
				Wf_process wfProcess = null;
				List ls = dao.query(Wf_process.class, Cnd.where("psid", "=",
						name));
				if (ls != null && ls.size() > 0) {
					wfProcess = (Wf_process) ls.get(0);
				}
				wfProcess.setPsxml(xml);
				dao.update(wfProcess);

				// 获取xml文件的节点、流向数据
				List<Activity> activityList = null;
				List<Transition> transList = null;
				activityList = workflowProcess.getActivityList();
				transList = workflowProcess.getTransitionList();

				// 获取wf_node、wf_node_trans、wf_node_role数据
				List<Wf_node> wfnodeList = dao.query(Wf_node.class, Cnd.where(
						"psbh", "=", wfProcess.getPsbh()));
				// 1.检索wf_node表，不存在的删除
				for (Wf_node wfnode : wfnodeList) {
					boolean isExist = false;
					String a = wfnode.getNodeid();
					for (Activity act : activityList) {
						if (StringHelper.cpObj(wfnode.getNodeid(), act.getId())) {
							isExist = true;
							break;
						}
					}
					if (!isExist) {
						dao.delete(Wf_node.class, wfnode.getWfnodeid());
					}
				}
				// 2.检索xml节点数据，存在的更新，不存在的插入
				for (Activity act : activityList) {
					boolean isExist = false;
					String wfnodeid = null;
					for (Wf_node wfnode : wfnodeList) {
						if (StringHelper.cpObj(wfnode.getNodeid(), act.getId())) {
							isExist = true;
							wfnodeid = wfnode.getWfnodeid();
							break;
						}
					}
					if (isExist) {
						Wf_node wfNode = dao.fetch(Wf_node.class, wfnodeid);
						wfNode.setNodename(act.getName());
						wfNode.setNodetype(act.getType());
						wfNode.setNodex(act.getXCoordinate());
						wfNode.setNodey(act.getYCoordinate());
						wfNode.setNodewidth(act.getWidth());
						wfNode.setNodeheight(act.getHeight());
						dao.update(wfNode);
					} else {
						Wf_node wfNode = new Wf_node();
						wfNode.setWfnodeid(DbUtils.getSequenceStr());
						wfNode.setPsbh(wfProcess.getPsbh());
						wfNode.setNodeid(act.getId());
						wfNode.setNodename(act.getName());
						wfNode.setNodetype(act.getType());
						wfNode.setNodex(act.getXCoordinate());
						wfNode.setNodey(act.getYCoordinate());
						wfNode.setNodewidth(act.getWidth());
						wfNode.setNodeheight(act.getHeight());
						wfNode.setNodecl("1");
						dao.insert(wfNode);
					}
				}

				List<Wf_node_trans> wfnodeTransList = dao.query(
						Wf_node_trans.class, Cnd.where("psbh", "=", wfProcess
								.getPsbh()));
				// 1.检索Wf_node_trans表，不存在的删除
				for (Wf_node_trans wfnodetrans : wfnodeTransList) {
					boolean isExist = false;
					for (Transition trans : transList) {
						if (StringHelper.cpObj(wfnodetrans.getTransid(),trans.getId())) {
							isExist = true;
							break;
						}
					}
					if (!isExist) {
						dao.delete(Wf_node_trans.class, wfnodetrans
								.getNodetransid());
					}
				}
				// 2.检索xml节点数据，存在的更新，不存在的插入
				for (Transition trans : transList) {
					boolean isExist = false;
					String nodetransid = null;
					for (Wf_node_trans wfnodetrans : wfnodeTransList) {
						if (StringHelper.cpObj(wfnodetrans.getTransid(),trans.getId())) {
							isExist = true;
							nodetransid = wfnodetrans.getNodetransid();
							break;
						}
					}
					if (isExist) {
						Wf_node_trans wfNodeTrans = dao.fetch(
								Wf_node_trans.class, nodetransid);
						wfNodeTrans.setTransname(trans.getName());
						wfNodeTrans.setTransfrom(trans.getFrom());
						wfNodeTrans.setTransto(trans.getTo());
						dao.update(wfNodeTrans);
					} else {
						Wf_node_trans wfNodeTrans = new Wf_node_trans();
						wfNodeTrans.setNodetransid(DbUtils.getSequenceStr());
						wfNodeTrans.setPsbh(wfProcess.getPsbh());
						wfNodeTrans.setTransid(trans.getId());
						wfNodeTrans.setTransname(trans.getName());
						wfNodeTrans.setTransfrom(trans.getFrom());
						wfNodeTrans.setTransto(trans.getTo());
						dao.insert(wfNodeTrans);
					}
				}

				List<Wf_node_role> wfnodeRoleList = dao.query(
						Wf_node_role.class, Cnd.where("psbh", "=", wfProcess
								.getPsbh()));
				// 1.检索Wf_node_role表，不存在的删除
				for (Wf_node_role wfnoderole : wfnodeRoleList) {
					boolean isExist = false;
					for (Activity act : activityList) {
						if (StringHelper.cpObj(wfnoderole.getNodeid(), act.getId())) {
							isExist = true;
							break;
						}
					}
					if (!isExist) {
						dao.delete(Wf_node_role.class, wfnoderole
								.getNoderoleid());
					}
				}
			}
		} else {
			processResult.setStatus(WorkflowService.FAIL);
			processResult.setMes("工作流【" + name + "】不存在，无法修改！");
			return processResult;
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

		return processResult;
	}

	/**
	 * 
	 * delWfprocess的中文名称：删除工作流
	 * 
	 * delWfprocess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delWfprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			delWfprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delWfprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String psid = dto.getPsid();
		String psbh = dto.getPsbh();
		String name = dto.getPsmc();

		if (checkProcessIsBindYewu(dto)) {
			throw new BusinessException("此工作流已经绑定业务，禁止删除！");
		} else if (checkProcessIsUse(dto)) {
			throw new BusinessException("此工作流正在使用，禁止删除！");
		} else {// 删除工作流
			dao.clear(Wf_process.class, Cnd.where("psbh", "=", psbh));
			dao.clear(Wf_node.class, Cnd.where("psbh", "=", psbh));
			dao.clear(Wf_node_trans.class, Cnd.where("psbh", "=", psbh));

			String rootPath = request.getSession().getServletContext()
					.getRealPath("/");
			String filepath = rootPath + File.separator + "processes";
			String filename = filepath + File.separator + psid + ".xml";
			if (FileUtil.checkFile(filename)) {// 删除process目录下的xml流程文件
				FileUtil.delFile(filename);
			}
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * queryWfyewuProcess的中文名称：查询业务工作流绑定表
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
	public Map queryWfyewuProcess(WorkflowDTO dto, PagesDTO pd)
			throws Exception {		
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.yewuprocessid,a.yewumc,a.yewumcpym,");
		sb.append(" a.sfqygzl,a.psbh,a.aae036,");
		sb.append(" a.aaa027,(select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" (select b.psmc from Wf_process b ");
		sb.append("   where b.psbh = a.psbh) as psmc");
		sb.append("  from Wf_yewu_process a");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.yewuprocessid = :yewuprocessid ");
		sb.append("   and a.psbh = :psbh ");
		sb.append("   and a.aaa027 like :aaa027 ");

		String[] ParaName = new String[] { "yewuprocessid", "psbh","aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * checkYewumcpymIsExist的中文名称：检查业务名称拼音码是否存在
	 * 
	 * checkYewumcpymIsExist的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public boolean checkYewumcpymIsExist(WorkflowDTO dto) throws Exception {
		String aaa027 = StringHelper.showNull2Empty(dto.getAaa027());
		if ("".equals(aaa027)) {
			throw new BusinessException("没有获取到前台传入的统筹区编码！");
		}

		boolean existFlag = false;
		List ls = dao.query(Wf_yewu_process.class, Cnd.where("yewumcpym", "=",
				dto.getYewumcpym()).and("aaa027", "=", aaa027));
		if (ls != null && ls.size() > 0) {
			existFlag = true;
		}
		return existFlag;
	}

	/**
	 * 
	 * addWfyewuProcess的中文名称：新增业务工作流绑定
	 * 
	 * addWfyewuProcess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addWfyewuProcess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			addWfyewuProcessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addWfyewuProcessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		if (checkYewumcpymIsExist(dto)) {
			throw new BusinessException("业务名称拼音码已经存在，请换用其他业务名称拼音码！");
		} else {
			// 写入表wf_yewu_process
			Wf_yewu_process yewuProcess = new Wf_yewu_process();
			BeanHelper.copyProperties(dto, yewuProcess);
			yewuProcess.setYewuprocessid(DbUtils.getSequenceStr());
			yewuProcess.setAae036(startTime);
			dao.insert(yewuProcess);
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateWfyewuProcess的中文名称：修改业务工作流绑定
	 * 
	 * updateWfyewuProcess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateWfyewuProcess(HttpServletRequest request,
			WorkflowDTO dto) {
		try {
			updateWfyewuProcessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateWfyewuProcessImp(HttpServletRequest request,
			WorkflowDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Wf_yewu_process yewuProcess = dao.fetch(Wf_yewu_process.class, dto
				.getYewuprocessid());
		if (!(yewuProcess.getYewumcpym()).equalsIgnoreCase(dto.getYewumcpym())) {
			if (checkYewumcpymIsExist(dto)) {
				throw new BusinessException("业务名称拼音码已经存在，请换用其他业务名称拼音码！");
			}
		}
		// 更新表wf_yewu_process
		yewuProcess.setYewumc(dto.getYewumc());
		yewuProcess.setYewumcpym(dto.getYewumcpym());
		yewuProcess.setSfqygzl(dto.getSfqygzl());
		yewuProcess.setPsbh(dto.getPsbh());
		yewuProcess.setAaa027(dto.getAaa027());
		dao.update(yewuProcess);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delWfyewuProcess的中文名称：删除业务工作流绑定
	 * 
	 * delWfyewuProcess的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delWfyewuProcess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			delWfyewuProcessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delWfyewuProcessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		if (checkProcessIsBindYewu(dto)) {
			throw new BusinessException("此工作流已经绑定业务，禁止删除！");
		} else if (checkProcessIsUse(dto)) {
			throw new BusinessException("此工作流正在使用，禁止删除！");
		} else {
			dao.delete(Wf_yewu_process.class, dto.getYewuprocessid());
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public List queryWfprocessZTree(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		// String orgcode = SysmanageUtil.getSysuserOrgcode();
		// orgcode = orgcode.replaceAll("0*$", "");
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String aaa027 = sysuser.getAaa027();

		StringBuffer sb = new StringBuffer();
		sb.append(" select '0' as psbh,'工作流列表' as psmc,'-1' as parent,");
		sb.append(" 'true' as isparent,'true' as isopen from dual");
		sb.append(" union");
		sb.append(" select psbh,psmc,'0' as parent,");
		sb.append(" 'false' as isparent,'false' as isopen ");
		sb.append("  from Wf_process a");
		sb.append(" where exists (select 1 from Wf_yewu_process b");
		sb.append("                where b.psbh = a.psbh");
		sb.append("         and b.aaa027 = '").append(aaa027).append("')");
		// sb.append("         and b.aaa027 like '").append(aaa027).append("%')");

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
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
	public List queryWfnodeZTree(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select '0' as nodeid,'节点列表' as nodename,'-1' as parent,");
		sb.append(" 'true' as isparent,'true' as isopen from dual");
		sb.append(" union");
		sb.append(" select nodeid,nodename,'0' as parent,");
		sb.append(" 'false' as isparent,'false' as isopen from Wf_node a");
		sb.append(" where psbh = '").append(dto.getPsbh()).append("'");
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * queryWfnode的中文名称：查询工作流节点
	 * 
	 * queryWfnode的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map queryWfnode(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select wfnodeid,a.psbh,b.psmc,nodeid,nodetype,");
		sb.append(" nodename,nodepym,nodesx,nodeurl");
		sb.append("   from Wf_node a,Wf_process b");
		sb.append("  where a.psbh = b.psbh");
		sb.append("    and a.psbh = :psbh");
		sb.append("    and a.nodeid = :nodeid");

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public Map queryWfnodeRole(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.psbh,a.nodeid,a.nodename,a.nodetype,");
		sb.append(" a.nodesx,a.nodeurl,b.roleid,b.noderoleid,");
		sb.append(" (select rolename from Sysrole ");
		sb.append("  where roleid = b.roleid) rolename");
		sb.append(" from Wf_node a,Wf_node_role b");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = b.psbh  ");
		sb.append("   and a.nodeid = b.nodeid ");
		sb.append("   and a.psbh = :psbh");
		sb.append("   and a.nodeid = :nodeid");
		if ("0".equals(userid)) {// 超级管理员
			//
		} else {
			sb.append(" and exists (");
			sb.append("  select 1");
			sb.append("   from sysrole c,sysorg d");
			sb.append("  where c.orgid = d.orgid");
			sb.append("    and c.roleid = b.roleid");
			sb.append("    and d.orgcode like '").append(orgcode).append("%'");
			sb.append(")");
		}

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd
				.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public Map queryWfnodeNoRole(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		if ("0".equals(userid)) {// 超级管理员
			sb.append(" select roleid,rolename,roledesc");
			sb.append(" from sysrole a");
		} else {
			sb.append(" select roleid,rolename,roledesc from ");
			sb.append(" (select a.roleid,rolename,roledesc ");
			sb.append("   from sysrole a,sysuserrole b");
			sb.append("  where a.roleid = b.roleid");
			sb.append("    and b.userid = ").append(userid);
			sb.append(" union ");
			sb.append(" select roleid,rolename,roledesc");
			sb.append("   from sysrole a,sysorg b");
			sb.append("  where a.orgid = b.orgid");
			sb.append("  and b.orgcode like '").append(orgcode).append("%') a");
		}
		sb.append(" where 1=1 ");
		sb.append("   and not exists (");
		sb.append(" select roleid");
		sb.append("   from Wf_node_role c");
		sb.append("  where c.roleid = a.roleid");
		sb.append("    and c.nodeid = :nodeid");
		sb.append("    and c.psbh = :psbh)");

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println(sb.toString());
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				Sysrole.class, pd.getPage(), pd.getPageSize());

		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * updateWfnode的中文名称：修改工作流节点
	 * 
	 * updateWfnode的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateWfnode(HttpServletRequest request, WorkflowDTO dto) {
		try {
			updateWfnodeImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateWfnodeImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Wf_node wfnode = dao.fetch(Wf_node.class, dto.getWfnodeid());
		wfnode.setNodesx(dto.getNodesx());
		wfnode.setNodeurl(dto.getNodeurl());
		dao.update(wfnode);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public String addWfnodeRole(HttpServletRequest request, WorkflowDTO dto) {
		try {
			addWfnodeRoleImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addWfnodeRoleImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		String psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
		String nodeid = StringHelper.showNull2Empty(request
				.getParameter("nodeid"));
		if ("".equals(psbh) || "".equals(nodeid)) {
			throw new BusinessException("工作流编号、工作流节点ID不能为空！");
		}
		String JsonStr = request.getParameter("JsonStr");
		List<Sysrole> ls = Json.fromJsonAsList(Sysrole.class, JsonStr);
		for (Sysrole sysrole : ls) {
			Wf_node_role wfnoderole = new Wf_node_role();
			wfnoderole.setNoderoleid(DbUtils.getSequenceStr());
			wfnoderole.setNodeid(nodeid);
			wfnoderole.setPsbh(psbh);
			wfnoderole.setRoleid(sysrole.getRoleid()
					.toString());
			dao.insert(wfnoderole);
		}
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delWfnodeRole的中文名称：删除工作流节点权限
	 * 
	 * delWfnodeRole的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delWfnodeRole(HttpServletRequest request, WorkflowDTO dto) {
		try {
			delWfnodeRoleImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delWfnodeRoleImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		// 删除工作流角色表
		dao.delete(Wf_node_role.class, dto.getNoderoleid());
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public Map queryWfnodeTrans(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select nodetransid,psbh,transid,transname,transval,");
		sb
				.append(" (select nodename from Wf_node b where b.psbh = a.psbh and b.nodeid = a.transfrom) transfrom,");
		sb
				.append(" (select nodename from Wf_node b where b.psbh = a.psbh and b.nodeid = a.transto) transto");
		sb.append("  from Wf_node_trans a");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = :psbh ");
		sb.append("   and a.transfrom = :transfrom ");

		String[] ParaName = new String[] { "psbh", "transfrom" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd
				.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public List<Wf_node_trans> queryWfnodeTransList(String prm_psbh,
			String prm_transfrom) throws Exception {
		// String v_sql =
		// "select a.nodetransid,a.psbh,a.transid,(CASE WHEN (a.transname!='' && a.transname IS NOT null) THEN a.transname ELSE (select MAX(b.nodename) from wf_node b where b.psbh=a.psbh and b.nodeid=a.transto) end )  AS transname,a.transval,a.transfrom,a.transto from Wf_node_trans a where a.psbh='"
		String v_sql = "select a.nodetransid,a.psbh,a.transid,(CASE WHEN (a.transname!='' && a.transname IS NOT null) THEN a.transname ELSE (select fun_get_nextTransname(a.psbh,a.transto)) end )  AS transname,a.transval,a.transfrom,a.transto from Wf_node_trans a where a.psbh='"
				+ prm_psbh + "' and a.transfrom='" + prm_transfrom + "'";
		System.out.println("queryWfnodeTransList v_sql " + v_sql);
		List<Wf_node_trans> v_a = (List<Wf_node_trans>) DbUtils.getDataList(
				v_sql, Wf_node_trans.class);
		return v_a;
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
	public String updateWfnodeTrans(HttpServletRequest request, WorkflowDTO dto) {
		try {
			updateWfnodeTransImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateWfnodeTransImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Wf_node_trans wfnodetrans = dao.fetch(Wf_node_trans.class, dto
				.getNodetransid());
		wfnodetrans.setTransval(dto.getTransval());
		dao.update(wfnodetrans);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * beginWfprocess的中文名称：启动工作流
	 * 
	 * beginWfprocess的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String beginWfprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			beginWfprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void beginWfprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String aaa027 = sysuser.getAaa027();

		String v_ywbh = request.getParameter("ywbh");// 业务编号
		String v_yewumcpym = request.getParameter("yewumcpym");// 业务名称拼音码
		String v_transname = PubFunc.urlDecodeUTF(request
				.getParameter("transname"));// 分支节点流向名称
//		String v_transval = PubFunc.urlDecodeUTF(request
//				.getParameter("transval"));// 分支节点流向值
		String v_transyy = PubFunc
				.urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
		String v_comdm = request.getParameter("comdm");// 
		String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
		String v_yewutablename = request.getParameter("yewutablename");// 表名
		String v_yewucolname = request.getParameter("yewucolname");// 字段
		String type = request.getParameter("type");
		String v_zfajslsj = PubFunc
				.urlDecodeUTF(request.getParameter("ajdjslsj")); // 受理时间
		List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
		List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
		JSONArray json=null;
		JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();

		StringBuffer sl_sql = new StringBuffer();
		sl_sql.append(" update ").append(v_yewutablename);
		sl_sql.append(" set slbz='1',slczy='").append(sysuser.getDescription());
		if (v_zfajslsj != null && !"".equals(v_zfajslsj)) {
			sl_sql.append("' ,slsj= '").append(v_zfajslsj).append("' ");
		} else {
			sl_sql.append("' ,slsj=now() ");
		}
		sl_sql.append(" where ").append(v_yewucolname);
		sl_sql.append(" = '").append(v_ywbh).append("' ");
		
		
		String v_sql = "";
//		// 更新相应表处理标志
//		v_sql = "update " + v_yewutablename + " set slbz='1',slczy='"
//				+ sysuser.getDescription() + "',slsj=now() where "
//				+ v_yewucolname + "='" + v_ywbh + "'";
		Sql sql = Sqls.create(sl_sql.toString());
		dao.execute(sql);

		// 获取业务工作流关系表
		v_sql = "select a.* from Wf_yewu_process a where a.yewumcpym = '"
				+ v_yewumcpym + "' and a.aaa027 = '" + aaa027 + "'";
		List<?> wf_yewuprocessList = DbUtils.getDataList(v_sql,
				Wf_yewu_process.class);
		if (wf_yewuprocessList == null || wf_yewuprocessList.size() == 0) {
			throw new BusinessException("获取业务名称拼音码【" + v_yewumcpym
					+ "】对应的业务工作流关系表Wf_yewu_process数据失败！");
		}
		Wf_yewu_process wfyewuprocess = (Wf_yewu_process) wf_yewuprocessList
				.get(0);
		if ("1".equals(wfyewuprocess.getSfqygzl())) {// 启用工作流
			// 获取工作流起始节点
			List<?> wf_nodelList = dao
					.query(Wf_node.class, Cnd.where("psbh", "=",
							wfyewuprocess.getPsbh()).and("nodetype", "=",
							"START_NODE"));
			if (wf_nodelList != null && wf_nodelList.size() > 0) {
				Wf_node wfnode = (Wf_node) wf_nodelList.get(0);

				// 获取业务流程的下一个节点
				if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ wfnode.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + wfnode.getPsbh()
							+ "'   and b.transfrom = '" + wfnode.getNodeid()
							+ "'   and b.transname = '" + v_transname + "')";
				} else {// 不是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ wfnode.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + wfnode.getPsbh()
							+ "'   and b.transfrom = '" + wfnode.getNodeid()
							+ "')";
				}
				List<?> wfnodeNextList = (List<?>) DbUtils.getDataList(v_sql,
						Wf_node.class);
				if (wfnodeNextList == null) {
					throw new BusinessException("根据工作流编号【" + wfnode.getPsbh()
							+ "】，流程节点【" + wfnode.getNodeid()
							+ "】获取业务流程下一个节点的Wf_node数据失败！");
				}
				Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

				while (true) {// 循环，一直取到需要处理的节点
					if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
						// 获取下一个节点
						if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
							v_sql = "select a.* from Wf_node a where a.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
									+ "  where b.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and b.transfrom = '"
									+ v_wfnodeNext.getNodeid()
									+ "'   and b.transname = '"
									+ v_transname
									+ "')";
						} else {// 不是分支节点
							v_sql = "select a.* from Wf_node a where a.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
									+ "  where b.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and b.transfrom = '"
									+ v_wfnodeNext.getNodeid() + "')";
						}
						List<?> ls = (List<?>) DbUtils.getDataList(v_sql,
								Wf_node.class);
						if (ls == null) {
							throw new BusinessException("根据工作流编号【"
									+ v_wfnodeNext.getPsbh() + "】，流程节点【"
									+ v_wfnodeNext.getNodeid()
									+ "】获取业务流程下一个节点的Wf_node数据失败！");
						}
						v_wfnodeNext = (Wf_node) ls.get(0);
					} else {
						break;
					}
				}

				// 获取时限开始时间、时限结束时间
				String v_node_sx_begin = DateUtil.getCurYearMonthDay();
				String v_node_sx_end = "";
				String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext
						.getNodesx());
				if (!"".equals(v_nodesx)) {
					v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin
							+ "','" + v_nodesx + "') as node_sx_end from dual";
					v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
					if ("-1".equals(v_node_sx_end)) {
						throw new BusinessException("根据当前年月日【"
								+ v_node_sx_begin + "】和节点工作时限【" + v_nodesx
								+ "】没有获取到时限结束时间，请检查工作日设置信息是否完整！");
					}
				}

				String v_ywlcjsbz = "0";// 未结束
				String v_ywlczcjsbz = "0";// 处理中
				String v_sftzjd = "1";// 是否跳转节点
				String v_shifouTongguo = "1";// 通过
				// 插入业务流程表
				Wf_ywlc v_wfywlc = new Wf_ywlc();
				v_wfywlc.setYwlcid(DbUtils.getSequenceStr());
				v_wfywlc.setYwbh(v_ywbh);
				v_wfywlc.setPsbh(wfyewuprocess.getPsbh());
				v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
				v_wfywlc.setNodesx(v_nodesx);
				if (!PubFunc.isNullStr(v_node_sx_begin)) {
					v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
							.getTime(v_node_sx_begin)));
				}
				if (!PubFunc.isNullStr(v_node_sx_end)) {
					v_wfywlc.setNodesxend(new Timestamp(PubFunc
							.getTime(v_node_sx_end)));
				}
				v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
				v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
				v_wfywlc.setComdm(v_comdm);
				v_wfywlc.setCommc(v_commc);
				v_wfywlc.setAaa027(aaa027);
//                if(type!=null&&!"".equals(type)){
//					v_wfywlc.setType(type);
//					v_wfywlc.setYwlcuserid(sysuser.getUserid());
//				}
				dao.insert(v_wfywlc);

					if("gwglswlc".equals(v_yewumcpym)||"gwglfwlc".equals(v_yewumcpym)||"xtdcksw".equals(v_yewumcpym)){
						dao.clear(Wf_node_fzr.class, Cnd.where("psbh", "=", v_wfywlc.getYwbh()));
						Wf_node_fzr  fzrnew=new Wf_node_fzr();
						fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
						fzrnew.setPsbh(v_wfywlc.getYwbh());
						SysuserDTO sdto2=new SysuserDTO();
						fzrnew.setFzruserid(sysuser.getUserid());
						sdto2.setUserid(sysuser.getUserid());
						listgw.add(sdto2);
						fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
						fzrnew.setCzyuserid(sysuser.getUserid());
						fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

						String ywlcuserid = request.getParameter("fzruserid");
						String[] strArray = null;
						strArray = ywlcuserid.split(",");
						Wf_node_fzr  fzr=new Wf_node_fzr();
						if(!StringUtils.isEmpty(ywlcuserid)) {
							for (int i = 0; i < strArray.length; i++) {
								fzr.setWfnodefzrid(DbUtils.getSequenceStr());
								fzr.setPsbh(v_wfywlc.getYwbh());
								fzr.setFzruserid(strArray[i]);
								fzr.setNodeid(v_wfywlc.getYwlccurnode());
								fzr.setCzyuserid(sysuser.getUserid());
								fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
								dao.insert(fzr);
								SysuserDTO sdto3 = new SysuserDTO();
								sdto3.setUserid(strArray[i]);
								listgw.add(sdto3);
							}
						}else{
							dao.insert(fzrnew);
						}
						json = JSONArray.fromObject(listgw);
						jpushInfoDTO.setMessage("公文流转消息");
				}else{
						SysuserDTO sdto2=new SysuserDTO();
						sdto2.setUserid(sysuser.getUserid());
						listother.add(sdto2);
						json = JSONArray.fromObject(listother);
						jpushInfoDTO.setMessage("执法办案流转消息");
					}

				// 插入 业务流程日志表
				Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
				wf_ywlclog.setYwlclogid(DbUtils.getSequenceStr());
				wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
				wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
				wf_ywlclog.setSftzjd(v_sftzjd);
				wf_ywlclog.setYwbljg(v_shifouTongguo);
				wf_ywlclog.setNodeid(wfnode.getNodeid());
				wf_ywlclog.setNodepym(wfnode.getNodepym());//
				wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
				wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
				wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
				wf_ywlclog.setTransname(v_transname);
				wf_ywlclog.setTransyy(v_transyy);
				wf_ywlclog.setComdm(v_comdm);
				wf_ywlclog.setCommc(v_commc);
				wf_ywlclog.setAae011(sysuser.getDescription().toString());
				wf_ywlclog.setAae036(startTime);
				dao.insert(wf_ywlclog);

				// 插入节点对应的文书
				ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
				v_ZfajzfwsDTO.setAjdjid(v_ywbh);
				v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
				v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
				v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

				wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);
			}
		} else {
			throw new BusinessException("工作流：" + v_yewumcpym + "未启用！");
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
		jpushInfoDTO.setAccertuserid_rows(json.toString());

		jpushInfoDTO.setTitle(v_commc);
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);
	}

    public String beginWffwprocess(HttpServletRequest request, WorkflowDTO dto) {
        try {
            beginWffwprocessImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop( { "trans" })
    public void beginWffwprocessImp(HttpServletRequest request, WorkflowDTO dto)
            throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser sysuser = SysmanageUtil.getSysuser();
        String aaa027 = sysuser.getAaa027();
        Sysuser s = dao.fetch(Sysuser.class, sysuser.getUserid());
        String v_ywbh = request.getParameter("ywbh");// 业务编号
        String v_yewumcpym = request.getParameter("yewumcpym");// 业务名称拼音码
        String v_transname = PubFunc.urlDecodeUTF(request
                .getParameter("transname"));// 分支节点流向名称
//		String v_transval = PubFunc.urlDecodeUTF(request
//				.getParameter("transval"));// 分支节点流向值
        String v_transyy = PubFunc
                .urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
        String v_comdm = request.getParameter("comdm");//
        String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
        String v_yewutablename = request.getParameter("yewutablename");// 表名
        String v_yewucolname = request.getParameter("yewucolname");// 字段
        String swzbh = request.getParameter("swzbh");// 字段
        String type = request.getParameter("type");
        String v_zfajslsj = PubFunc
                .urlDecodeUTF(request.getParameter("ajdjslsj")); // 受理时间
        List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
        List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
        JSONArray json=null;
        JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();
        StringBuffer sl_sql = new StringBuffer();
        sl_sql.append(" update ").append(v_yewutablename);
        sl_sql.append(" set slbz='1',slczy='").append(sysuser.getDescription());
        if (v_zfajslsj != null && !"".equals(v_zfajslsj)) {
            sl_sql.append("' ,slsj= '").append(v_zfajslsj).append("' ");
        } else {
            sl_sql.append("' ,slsj=now() ");
        }
        sl_sql.append(" where ").append(v_yewucolname);
        sl_sql.append(" = '").append(v_ywbh).append("' ");


        String v_sql = "";
//		// 更新相应表处理标志
//		v_sql = "update " + v_yewutablename + " set slbz='1',slczy='"
//				+ sysuser.getDescription() + "',slsj=now() where "
//				+ v_yewucolname + "='" + v_ywbh + "'";
        Sql sql = Sqls.create(sl_sql.toString());
        dao.execute(sql);

        // 获取业务工作流关系表
        v_sql = "select a.* from Wf_yewu_process a where a.yewumcpym = '"
                + v_yewumcpym + "' and a.aaa027 = '" + aaa027 + "'";
        List<?> wf_yewuprocessList = DbUtils.getDataList(v_sql,
                Wf_yewu_process.class);
        if (wf_yewuprocessList == null || wf_yewuprocessList.size() == 0) {
            throw new BusinessException("获取业务名称拼音码【" + v_yewumcpym
                    + "】对应的业务工作流关系表Wf_yewu_process数据失败！");
        }
        Wf_yewu_process wfyewuprocess = (Wf_yewu_process) wf_yewuprocessList
                .get(0);
        if ("1".equals(wfyewuprocess.getSfqygzl())) {// 启用工作流
            // 获取工作流起始节点
            List<?> wf_nodelList = dao
                    .query(Wf_node.class, Cnd.where("psbh", "=",
                            wfyewuprocess.getPsbh()).and("nodetype", "=",
                            "START_NODE"));
            if (wf_nodelList != null && wf_nodelList.size() > 0) {
                Wf_node wfnode = (Wf_node) wf_nodelList.get(0);

                // 获取业务流程的下一个节点
                if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + wfnode.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + wfnode.getPsbh()
                            + "'   and b.transfrom = '" + wfnode.getNodeid()
                            + "'   and b.transname = '" + v_transname + "')";
                } else {// 不是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + wfnode.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + wfnode.getPsbh()
                            + "'   and b.transfrom = '" + wfnode.getNodeid()
                            + "')";
                }
                List<?> wfnodeNextList = (List<?>) DbUtils.getDataList(v_sql,
                        Wf_node.class);
                if (wfnodeNextList == null) {
                    throw new BusinessException("根据工作流编号【" + wfnode.getPsbh()
                            + "】，流程节点【" + wfnode.getNodeid()
                            + "】获取业务流程下一个节点的Wf_node数据失败！");
                }
                Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

                while (true) {// 循环，一直取到需要处理的节点
                    if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
                        // 获取下一个节点
                        if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
                            v_sql = "select a.* from Wf_node a where a.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                                    + "  where b.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and b.transfrom = '"
                                    + v_wfnodeNext.getNodeid()
                                    + "'   and b.transname = '"
                                    + v_transname
                                    + "')";
                        } else {// 不是分支节点
                            v_sql = "select a.* from Wf_node a where a.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                                    + "  where b.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and b.transfrom = '"
                                    + v_wfnodeNext.getNodeid() + "')";
                        }
                        List<?> ls = (List<?>) DbUtils.getDataList(v_sql,
                                Wf_node.class);
                        if (ls == null) {
                            throw new BusinessException("根据工作流编号【"
                                    + v_wfnodeNext.getPsbh() + "】，流程节点【"
                                    + v_wfnodeNext.getNodeid()
                                    + "】获取业务流程下一个节点的Wf_node数据失败！");
                        }
                        v_wfnodeNext = (Wf_node) ls.get(0);
                    } else {
                        break;
                    }
                }

                // 获取时限开始时间、时限结束时间
                String v_node_sx_begin = DateUtil.getCurYearMonthDay();
                String v_node_sx_end = "";
                String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext
                        .getNodesx());
                if (!"".equals(v_nodesx)) {
                    v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin
                            + "','" + v_nodesx + "') as node_sx_end from dual";
                    v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
                    if ("-1".equals(v_node_sx_end)) {
                        throw new BusinessException("根据当前年月日【"
                                + v_node_sx_begin + "】和节点工作时限【" + v_nodesx
                                + "】没有获取到时限结束时间，请检查工作日设置信息是否完整！");
                    }
                }

                String v_ywlcjsbz = "0";// 未结束
                String v_ywlczcjsbz = "0";// 处理中
                String v_sftzjd = "1";// 是否跳转节点
                String v_shifouTongguo = "1";// 通过
                // 插入业务流程表
                Wf_ywlc v_wfywlc = new Wf_ywlc();
                v_wfywlc.setYwlcid(DbUtils.getSequenceStr());
                v_wfywlc.setYwbh(v_ywbh);
                v_wfywlc.setPsbh(wfyewuprocess.getPsbh());
                v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
                v_wfywlc.setNodesx(v_nodesx);
                if (!PubFunc.isNullStr(v_node_sx_begin)) {
                    v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
                            .getTime(v_node_sx_begin)));
                }
                if (!PubFunc.isNullStr(v_node_sx_end)) {
                    v_wfywlc.setNodesxend(new Timestamp(PubFunc
                            .getTime(v_node_sx_end)));
                }
                v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
                v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
                v_wfywlc.setComdm(v_comdm);
                v_wfywlc.setCommc(v_commc);
                v_wfywlc.setAaa027(aaa027);
//                if(type!=null&&!"".equals(type)){
//					v_wfywlc.setType(type);
//					v_wfywlc.setYwlcuserid(sysuser.getUserid());
//				}


                if(!"5".equals(s.getUserposition())&&!"4".equals(s.getUserposition())){
                    dao.clear(Wf_node_fzr.class, Cnd.where("psbh", "=", v_wfywlc.getYwbh()));
                    Wf_node_fzr  fzrnew=new Wf_node_fzr();
                    fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
                    fzrnew.setPsbh(v_wfywlc.getYwbh());
                    SysuserDTO sdto2=new SysuserDTO();
                    fzrnew.setFzruserid(sysuser.getUserid());
                    sdto2.setUserid(sysuser.getUserid());
                    listgw.add(sdto2);
                    fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
                    fzrnew.setCzyuserid(sysuser.getUserid());
                    fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

                    String ywlcuserid = request.getParameter("fzruserid");
                    String[] strArray = null;
                    strArray = ywlcuserid.split(",");
                    Wf_node_fzr  fzr=new Wf_node_fzr();
                    if(!StringUtils.isEmpty(ywlcuserid)) {
                        for (int i = 0; i < strArray.length; i++) {
                            fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                            fzr.setPsbh(v_wfywlc.getYwbh());
                            fzr.setFzruserid(strArray[i]);
                            fzr.setNodeid(v_wfywlc.getYwlccurnode());
                            fzr.setCzyuserid(sysuser.getUserid());
                            fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(fzr);
                            SysuserDTO sdto3 = new SysuserDTO();
                            sdto3.setUserid(strArray[i]);
                            listgw.add(sdto3);
                        }
                    }else{
                        dao.insert(fzrnew);
                    }
					dao.insert(v_wfywlc);
                    json = JSONArray.fromObject(listgw);
                    jpushInfoDTO.setMessage("公文流转消息");
                }else if("5".equals(s.getUserposition())){
                     WorkflowDTO wd=new WorkflowDTO();
                    String ywlcuserid="";
                     if("2".equals(swzbh)){
                         wd.setPsbh("WF2018070400359");
                         wd.setNodeid("7");
                         List list = queryWfywlcuser(wd);
                         if(list!=null&&list.size()>0){
                             for(int i=0;i<list.size();i++) {
                                 WorkflowDTO wdto = (WorkflowDTO) list.get(i);
                                 if("".equals(ywlcuserid)){
									 ywlcuserid=wdto.getUserid();
                                 }else{
									 ywlcuserid+=","+wdto.getUserid();
                                 }
                             }
                         }
                     }else if("1".equals(swzbh)){
                         wd.setPsbh("WF2018070400359");
                         wd.setNodeid("5");
                         List list = queryWfywlcuser(wd);
                         if(list!=null&&list.size()>0){
                             for(int i=0;i<list.size();i++) {
                                 WorkflowDTO wdto = (WorkflowDTO) list.get(i);
                                 if("".equals(ywlcuserid)){
									 ywlcuserid=wdto.getUserid();
                                 }else{
									 ywlcuserid+=","+wdto.getUserid();
                                 }
                             }
                         }
                    }else if("3".equals(swzbh)){
                         wd.setPsbh("WF2018070400359");
                         wd.setNodeid("9");
                         List list = queryWfywlcuser(wd);
                         if(list!=null&&list.size()>0){
                             for(int i=0;i<list.size();i++) {
                                 WorkflowDTO wdto = (WorkflowDTO) list.get(i);
                                 if("".equals(ywlcuserid)){
									 ywlcuserid=wdto.getUserid();
                                 }else{
									 ywlcuserid+=","+wdto.getUserid();
                                 }
                             }
                         }
                     }
                     v_wfywlc.setYwlccurnode("46");
					String[] strArray = null;
					strArray = ywlcuserid.split(",");
					Wf_node_fzr  fzr=new Wf_node_fzr();
					if(!StringUtils.isEmpty(ywlcuserid)) {
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(sysuser.getUserid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}
					dao.insert(v_wfywlc);
					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh("WF2018070400359");
					w.setYwlccurnode("2");
					w.setAae011(v_wfywlc.getYwlccurnode());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					dao.insert(w);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(w.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("公文流转消息");
                }else if("4".equals(s.getUserposition())){
					WorkflowDTO wd=new WorkflowDTO();
					String ywlcuserid="";
					if("2".equals(swzbh)){
						v_wfywlc.setYwlccurnode("66");
						wd.setPsbh("WF2016062700303");
						wd.setNodeid("66");
						List list = queryWfywlcuser(wd);
						if(list!=null&&list.size()>0){
							for(int i=0;i<list.size();i++) {
								WorkflowDTO wdto = (WorkflowDTO) list.get(i);
								if("".equals(ywlcuserid)){
									ywlcuserid=wdto.getUserid();
								}else{
									ywlcuserid+=","+wdto.getUserid();
								}
							}
						}
					}else if("1".equals(swzbh)){
						v_wfywlc.setYwlccurnode("54");
						wd.setPsbh("WF2016062700303");
						wd.setNodeid("54");
						List list = queryWfywlcuser(wd);
						if(list!=null&&list.size()>0){
							for(int i=0;i<list.size();i++) {
								WorkflowDTO wdto = (WorkflowDTO) list.get(i);
								if("".equals(ywlcuserid)){
									ywlcuserid=wdto.getUserid();
								}else{
									ywlcuserid+=","+wdto.getUserid();
								}
							}
						}
					}else if("3".equals(swzbh)){
						v_wfywlc.setYwlccurnode("54");
						wd.setPsbh("WF2016062700303");
						wd.setNodeid("54");
						List list = queryWfywlcuser(wd);
						if(list!=null&&list.size()>0){
							for(int i=0;i<list.size();i++) {
								WorkflowDTO wdto = (WorkflowDTO) list.get(i);
								if("".equals(ywlcuserid)){
									ywlcuserid=wdto.getUserid();
								}else{
									ywlcuserid+=","+wdto.getUserid();
								}
							}
						}
					}

					String[] strArray = null;
					strArray = ywlcuserid.split(",");
					Wf_node_fzr  fzr=new Wf_node_fzr();
					if(!StringUtils.isEmpty(ywlcuserid)) {
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(sysuser.getUserid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}
					dao.insert(v_wfywlc);
					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh("WF2018070400359");
					w.setYwlccurnode("2");
					w.setAae011(v_wfywlc.getYwlccurnode());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					dao.insert(w);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(w.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("公文流转消息");
				}

                // 插入 业务流程日志表
                Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
                wf_ywlclog.setYwlclogid(DbUtils.getSequenceStr());
                wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
                wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
                wf_ywlclog.setSftzjd(v_sftzjd);
                wf_ywlclog.setYwbljg(v_shifouTongguo);
                wf_ywlclog.setNodeid(wfnode.getNodeid());
                wf_ywlclog.setNodepym(wfnode.getNodepym());//
                wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
                wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
                wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
                wf_ywlclog.setTransname(v_transname);
                wf_ywlclog.setTransyy(v_transyy);
                wf_ywlclog.setComdm(v_comdm);
                wf_ywlclog.setCommc(v_commc);
                wf_ywlclog.setAae011(sysuser.getDescription().toString());
                wf_ywlclog.setAae036(startTime);
                dao.insert(wf_ywlclog);

                // 插入节点对应的文书
                ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
                v_ZfajzfwsDTO.setAjdjid(v_ywbh);
                v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
                v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
                v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

                wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);
            }
        } else {
            throw new BusinessException("工作流：" + v_yewumcpym + "未启用！");
        }

        Timestamp endTime = SysmanageUtil.currentTime();
        SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
        jpushInfoDTO.setAccertuserid_rows(json.toString());

        jpushInfoDTO.setTitle(v_commc);
        jpushInfoDTO.setType("1004");
        jpushInfoDTO.setUserid(dto.getUserid());
        jpushService.sendMessage(request, jpushInfoDTO);
    }

	public String beginWfprocessnew(HttpServletRequest request, WorkflowDTO dto) {
		try {
			beginWfprocessImpnew(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void beginWfprocessImpnew(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String aaa027 = sysuser.getAaa027();

		String v_ywbh = request.getParameter("ywbh");// 业务编号
		String v_yewumcpym = request.getParameter("yewumcpym");// 业务名称拼音码
		String v_transname = PubFunc.urlDecodeUTF(request
				.getParameter("transname"));// 分支节点流向名称
//		String v_transval = PubFunc.urlDecodeUTF(request
//				.getParameter("transval"));// 分支节点流向值
		String v_transyy = PubFunc
				.urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
		String v_comdm = request.getParameter("comdm");//
		String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
		String v_yewutablename = request.getParameter("yewutablename");// 表名
		String v_yewucolname = request.getParameter("yewucolname");// 字段
		String type = request.getParameter("type");
		String v_zfajslsj = PubFunc
				.urlDecodeUTF(request.getParameter("ajdjslsj")); // 受理时间
		List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
		List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
		JSONArray json=null;
		JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();

		StringBuffer sl_sql = new StringBuffer();
		sl_sql.append(" update ").append(v_yewutablename);
		sl_sql.append(" set slbz='1',slczy='").append(sysuser.getDescription());
		if (v_zfajslsj != null && !"".equals(v_zfajslsj)) {
			sl_sql.append("' ,slsj= '").append(v_zfajslsj).append("' ");
		} else {
			sl_sql.append("' ,slsj=now() ");
		}
		sl_sql.append(" where ").append(v_yewucolname);
		sl_sql.append(" = '").append(v_ywbh).append("' ");


		String v_sql = "";
//		// 更新相应表处理标志
//		v_sql = "update " + v_yewutablename + " set slbz='1',slczy='"
//				+ sysuser.getDescription() + "',slsj=now() where "
//				+ v_yewucolname + "='" + v_ywbh + "'";
		Sql sql = Sqls.create(sl_sql.toString());
		dao.execute(sql);

		// 获取业务工作流关系表
		v_sql = "select a.* from Wf_yewu_process a where a.yewumcpym = '"
				+ v_yewumcpym + "' and a.aaa027 = '" + aaa027 + "'";
		List<?> wf_yewuprocessList = DbUtils.getDataList(v_sql,
				Wf_yewu_process.class);
		if (wf_yewuprocessList == null || wf_yewuprocessList.size() == 0) {
			throw new BusinessException("获取业务名称拼音码【" + v_yewumcpym
					+ "】对应的业务工作流关系表Wf_yewu_process数据失败！");
		}
		Wf_yewu_process wfyewuprocess = (Wf_yewu_process) wf_yewuprocessList
				.get(0);
		if ("1".equals(wfyewuprocess.getSfqygzl())) {// 启用工作流
			// 获取工作流起始节点
			List<?> wf_nodelList = dao
					.query(Wf_node.class, Cnd.where("psbh", "=",
							wfyewuprocess.getPsbh()).and("nodetype", "=",
							"START_NODE"));
			if (wf_nodelList != null && wf_nodelList.size() > 0) {
				Wf_node wfnode = (Wf_node) wf_nodelList.get(0);

				// 获取业务流程的下一个节点
				if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ wfnode.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + wfnode.getPsbh()
							+ "'   and b.transfrom = '" + wfnode.getNodeid()
							+ "'   and b.transname = '" + v_transname + "')";
				} else {// 不是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ wfnode.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + wfnode.getPsbh()
							+ "'   and b.transfrom = '" + wfnode.getNodeid()
							+ "')";
				}
				List<?> wfnodeNextList = (List<?>) DbUtils.getDataList(v_sql,
						Wf_node.class);
				if (wfnodeNextList == null) {
					throw new BusinessException("根据工作流编号【" + wfnode.getPsbh()
							+ "】，流程节点【" + wfnode.getNodeid()
							+ "】获取业务流程下一个节点的Wf_node数据失败！");
				}
				Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

				while (true) {// 循环，一直取到需要处理的节点
					if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
						// 获取下一个节点
						if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
							v_sql = "select a.* from Wf_node a where a.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
									+ "  where b.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and b.transfrom = '"
									+ v_wfnodeNext.getNodeid()
									+ "'   and b.transname = '"
									+ v_transname
									+ "')";
						} else {// 不是分支节点
							v_sql = "select a.* from Wf_node a where a.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
									+ "  where b.psbh = '"
									+ v_wfnodeNext.getPsbh()
									+ "'   and b.transfrom = '"
									+ v_wfnodeNext.getNodeid() + "')";
						}
						List<?> ls = (List<?>) DbUtils.getDataList(v_sql,
								Wf_node.class);
						if (ls == null) {
							throw new BusinessException("根据工作流编号【"
									+ v_wfnodeNext.getPsbh() + "】，流程节点【"
									+ v_wfnodeNext.getNodeid()
									+ "】获取业务流程下一个节点的Wf_node数据失败！");
						}
						v_wfnodeNext = (Wf_node) ls.get(0);
					} else {
						break;
					}
				}

				// 获取时限开始时间、时限结束时间
				String v_node_sx_begin = DateUtil.getCurYearMonthDay();
				String v_node_sx_end = "";
				String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext
						.getNodesx());
				if (!"".equals(v_nodesx)) {
					v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin
							+ "','" + v_nodesx + "') as node_sx_end from dual";
					v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
					if ("-1".equals(v_node_sx_end)) {
						throw new BusinessException("根据当前年月日【"
								+ v_node_sx_begin + "】和节点工作时限【" + v_nodesx
								+ "】没有获取到时限结束时间，请检查工作日设置信息是否完整！");
					}
				}

				String v_ywlcjsbz = "0";// 未结束
				String v_ywlczcjsbz = "0";// 处理中
				String v_sftzjd = "1";// 是否跳转节点
				String v_shifouTongguo = "1";// 通过
				// 插入业务流程表
				Wf_ywlc v_wfywlc = new Wf_ywlc();
				v_wfywlc.setYwlcid(DbUtils.getSequenceStr());
				v_wfywlc.setYwbh(v_ywbh);
				v_wfywlc.setPsbh(wfyewuprocess.getPsbh());
				v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
				v_wfywlc.setNodesx(v_nodesx);
				if (!PubFunc.isNullStr(v_node_sx_begin)) {
					v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
							.getTime(v_node_sx_begin)));
				}
				if (!PubFunc.isNullStr(v_node_sx_end)) {
					v_wfywlc.setNodesxend(new Timestamp(PubFunc
							.getTime(v_node_sx_end)));
				}
				v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
				v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
				v_wfywlc.setComdm(v_comdm);
				v_wfywlc.setCommc(v_commc);
				v_wfywlc.setAaa027(aaa027);
//                if(type!=null&&!"".equals(type)){
//					v_wfywlc.setType(type);
//					v_wfywlc.setYwlcuserid(sysuser.getUserid());
//				}
				dao.insert(v_wfywlc);

				if("gwglswlc".equals(v_yewumcpym)||"gwglfwlc".equals(v_yewumcpym)){
					dao.clear(Wf_node_fzr.class, Cnd.where("psbh", "=", v_wfywlc.getYwbh()));
					Wf_node_fzr  fzrnew=new Wf_node_fzr();
					fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
					fzrnew.setPsbh(v_wfywlc.getYwbh());
					SysuserDTO sdto2=new SysuserDTO();
					fzrnew.setFzruserid(sysuser.getUserid());
					sdto2.setUserid(sysuser.getUserid());
					listgw.add(sdto2);
					fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
					fzrnew.setCzyuserid(sysuser.getUserid());
					fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

					String ywlcuserid = request.getParameter("fzruserid");
					String[] strArray = null;
					strArray = ywlcuserid.split(",");
					Wf_node_fzr  fzr=new Wf_node_fzr();
					if(!StringUtils.isEmpty(ywlcuserid)) {
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(v_wfywlc.getYwlcid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}else{
						dao.insert(fzrnew);
					}
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("公文流转消息");
				}else{
					SysuserDTO sdto2=new SysuserDTO();
					sdto2.setUserid(sysuser.getUserid());
					listother.add(sdto2);
					json = JSONArray.fromObject(listother);
					jpushInfoDTO.setMessage("执法办案流转消息");
				}

				// 插入 业务流程日志表
				Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
				wf_ywlclog.setYwlclogid(DbUtils.getSequenceStr());
				wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
				wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
				wf_ywlclog.setSftzjd(v_sftzjd);
				wf_ywlclog.setYwbljg(v_shifouTongguo);
				wf_ywlclog.setNodeid(wfnode.getNodeid());
				wf_ywlclog.setNodepym(wfnode.getNodepym());//
				wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
				wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
				wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
				wf_ywlclog.setTransname(v_transname);
				wf_ywlclog.setTransyy(v_transyy);
				wf_ywlclog.setComdm(v_comdm);
				wf_ywlclog.setCommc(v_commc);
				wf_ywlclog.setAae011(sysuser.getDescription().toString());
				wf_ywlclog.setAae036(startTime);
				dao.insert(wf_ywlclog);

				// 插入节点对应的文书
				ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
				v_ZfajzfwsDTO.setAjdjid(v_ywbh);
				v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
				v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
				v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

				wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);
			}
		} else {
			throw new BusinessException("工作流：" + v_yewumcpym + "未启用！");
		}

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
		jpushInfoDTO.setAccertuserid_rows(json.toString());

		jpushInfoDTO.setTitle(v_commc);
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);
	}

    public String beginWfgongwenprocess(HttpServletRequest request, WorkflowDTO dto) {
        try {
            beginWfgongwenprocessImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop( { "trans" })
    public void beginWfgongwenprocessImp(HttpServletRequest request, WorkflowDTO dto)
            throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser sysuser = SysmanageUtil.getSysuser();
        String aaa027 = sysuser.getAaa027();

        String v_ywbh = request.getParameter("ywbh");// 业务编号
        String v_yewumcpym = request.getParameter("yewumcpym");// 业务名称拼音码
        String v_transname = PubFunc.urlDecodeUTF(request
                .getParameter("transname"));// 分支节点流向名称
//		String v_transval = PubFunc.urlDecodeUTF(request
//				.getParameter("transval"));// 分支节点流向值
        String v_transyy = PubFunc
                .urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
        String v_comdm = request.getParameter("comdm");//
        String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
        String v_yewutablename = request.getParameter("yewutablename");// 表名
        String v_yewucolname = request.getParameter("yewucolname");// 字段
        String type = request.getParameter("type");
        String v_zfajslsj = PubFunc
                .urlDecodeUTF(request.getParameter("ajdjslsj")); // 受理时间
        List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
        List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
        JSONArray json=null;
        JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();

        StringBuffer sl_sql = new StringBuffer();
        sl_sql.append(" update ").append(v_yewutablename);
        sl_sql.append(" set slbz='1',slczy='").append(sysuser.getDescription());
        if (v_zfajslsj != null && !"".equals(v_zfajslsj)) {
            sl_sql.append("' ,slsj= '").append(v_zfajslsj).append("' ");
        } else {
            sl_sql.append("' ,slsj=now() ");
        }
        sl_sql.append(" where ").append(v_yewucolname);
        sl_sql.append(" = '").append(v_ywbh).append("' ");


        String v_sql = "";
//		// 更新相应表处理标志
//		v_sql = "update " + v_yewutablename + " set slbz='1',slczy='"
//				+ sysuser.getDescription() + "',slsj=now() where "
//				+ v_yewucolname + "='" + v_ywbh + "'";
        Sql sql = Sqls.create(sl_sql.toString());
        dao.execute(sql);

        // 获取业务工作流关系表
        v_sql = "select a.* from Wf_yewu_process a where a.yewumcpym = '"
                + v_yewumcpym + "' and a.aaa027 = '" + aaa027 + "'";
        List<?> wf_yewuprocessList = DbUtils.getDataList(v_sql,
                Wf_yewu_process.class);
        if (wf_yewuprocessList == null || wf_yewuprocessList.size() == 0) {
            throw new BusinessException("获取业务名称拼音码【" + v_yewumcpym
                    + "】对应的业务工作流关系表Wf_yewu_process数据失败！");
        }
        Wf_yewu_process wfyewuprocess = (Wf_yewu_process) wf_yewuprocessList
                .get(0);
        if ("1".equals(wfyewuprocess.getSfqygzl())) {// 启用工作流
            // 获取工作流起始节点
            List<?> wf_nodelList = dao
                    .query(Wf_node.class, Cnd.where("psbh", "=",
                            wfyewuprocess.getPsbh()).and("nodetype", "=",
                            "START_NODE"));
            if (wf_nodelList != null && wf_nodelList.size() > 0) {
                Wf_node wfnode = (Wf_node) wf_nodelList.get(0);

                // 获取业务流程的下一个节点
                if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + wfnode.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + wfnode.getPsbh()
                            + "'   and b.transfrom = '" + wfnode.getNodeid()
                            + "'   and b.transname = '" + v_transname + "')";
                } else {// 不是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + wfnode.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + wfnode.getPsbh()
                            + "'   and b.transfrom = '" + wfnode.getNodeid()
                            + "')";
                }
                List<?> wfnodeNextList = (List<?>) DbUtils.getDataList(v_sql,
                        Wf_node.class);
                if (wfnodeNextList == null) {
                    throw new BusinessException("根据工作流编号【" + wfnode.getPsbh()
                            + "】，流程节点【" + wfnode.getNodeid()
                            + "】获取业务流程下一个节点的Wf_node数据失败！");
                }
                Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

                while (true) {// 循环，一直取到需要处理的节点
                    if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
                        // 获取下一个节点
                        if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
                            v_sql = "select a.* from Wf_node a where a.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                                    + "  where b.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and b.transfrom = '"
                                    + v_wfnodeNext.getNodeid()
                                    + "'   and b.transname = '"
                                    + v_transname
                                    + "')";
                        } else {// 不是分支节点
                            v_sql = "select a.* from Wf_node a where a.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                                    + "  where b.psbh = '"
                                    + v_wfnodeNext.getPsbh()
                                    + "'   and b.transfrom = '"
                                    + v_wfnodeNext.getNodeid() + "')";
                        }
                        List<?> ls = (List<?>) DbUtils.getDataList(v_sql,
                                Wf_node.class);
                        if (ls == null) {
                            throw new BusinessException("根据工作流编号【"
                                    + v_wfnodeNext.getPsbh() + "】，流程节点【"
                                    + v_wfnodeNext.getNodeid()
                                    + "】获取业务流程下一个节点的Wf_node数据失败！");
                        }
                        v_wfnodeNext = (Wf_node) ls.get(0);
                    } else {
                        break;
                    }
                }

                // 获取时限开始时间、时限结束时间
                String v_node_sx_begin = DateUtil.getCurYearMonthDay();
                String v_node_sx_end = "";
                String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext
                        .getNodesx());
                if (!"".equals(v_nodesx)) {
                    v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin
                            + "','" + v_nodesx + "') as node_sx_end from dual";
                    v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
                    if ("-1".equals(v_node_sx_end)) {
                        throw new BusinessException("根据当前年月日【"
                                + v_node_sx_begin + "】和节点工作时限【" + v_nodesx
                                + "】没有获取到时限结束时间，请检查工作日设置信息是否完整！");
                    }
                }

                String v_ywlcjsbz = "0";// 未结束
                String v_ywlczcjsbz = "0";// 处理中
                String v_sftzjd = "1";// 是否跳转节点
                String v_shifouTongguo = "1";// 通过
                // 插入业务流程表
                Wf_ywlc v_wfywlc = new Wf_ywlc();
                v_wfywlc.setYwlcid(DbUtils.getSequenceStr());
                v_wfywlc.setYwbh(v_ywbh);
                v_wfywlc.setPsbh(wfyewuprocess.getPsbh());
                v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
                v_wfywlc.setNodesx(v_nodesx);
                if (!PubFunc.isNullStr(v_node_sx_begin)) {
                    v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
                            .getTime(v_node_sx_begin)));
                }
                if (!PubFunc.isNullStr(v_node_sx_end)) {
                    v_wfywlc.setNodesxend(new Timestamp(PubFunc
                            .getTime(v_node_sx_end)));
                }
                v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
                v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
                v_wfywlc.setComdm(v_comdm);
                v_wfywlc.setCommc(v_commc);
                v_wfywlc.setAaa027(aaa027);
//                if(type!=null&&!"".equals(type)){
//					v_wfywlc.setType(type);
//					v_wfywlc.setYwlcuserid(sysuser.getUserid());
//				}
                dao.insert(v_wfywlc);

                if("gzsblc".equals(v_yewumcpym)){
                    dao.clear(Wf_node_fzr.class, Cnd.where("psbh", "=", v_wfywlc.getYwbh()));
                    Wf_node_fzr  fzrnew=new Wf_node_fzr();
                    fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
                    fzrnew.setPsbh(v_wfywlc.getYwbh());
                    SysuserDTO sdto2=new SysuserDTO();
                    fzrnew.setFzruserid(sysuser.getUserid());
                    sdto2.setUserid(sysuser.getUserid());
                    listgw.add(sdto2);
                    fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
                    fzrnew.setCzyuserid(sysuser.getUserid());
                    fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

                    String ywlcuserid = request.getParameter("fzruserid");
                    String[] strArray = null;
                    strArray = ywlcuserid.split(",");
                    Wf_node_fzr  fzr=new Wf_node_fzr();
                    if(!StringUtils.isEmpty(ywlcuserid)) {
                        for (int i = 0; i < strArray.length; i++) {
                            fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                            fzr.setPsbh(v_wfywlc.getYwbh());
                            fzr.setFzruserid(strArray[i]);
                            fzr.setNodeid(v_wfywlc.getYwlccurnode());
                            fzr.setCzyuserid(sysuser.getUserid());
                            fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(fzr);
                            SysuserDTO sdto3 = new SysuserDTO();
                            sdto3.setUserid(strArray[i]);
                            listgw.add(sdto3);
                        }
                    }else{
                        dao.insert(fzrnew);
                    }
                    json = JSONArray.fromObject(listgw);
                    jpushInfoDTO.setMessage("工作上报流转消息");
                }else if("ayrw".equals(v_yewumcpym)){
					dao.clear(Wf_node_fzr.class, Cnd.where("psbh", "=", v_wfywlc.getYwbh()));
					Wf_node_fzr  fzrnew=new Wf_node_fzr();
					fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
					fzrnew.setPsbh(v_wfywlc.getYwbh());
					SysuserDTO sdto2=new SysuserDTO();
					fzrnew.setFzruserid(sysuser.getUserid());
					sdto2.setUserid(sysuser.getUserid());
					listgw.add(sdto2);
					fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
					fzrnew.setCzyuserid(sysuser.getUserid());
					fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

					String ywlcuserid = request.getParameter("fzruserid");
					String[] strArray = null;
					strArray = ywlcuserid.split(",");
					Wf_node_fzr  fzr=new Wf_node_fzr();
					if(!StringUtils.isEmpty(ywlcuserid)) {
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(sysuser.getUserid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}else{
						dao.insert(fzrnew);
					}
					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh("WF2018070400359");
					w.setYwlccurnode("26");
					w.setAae011(v_wfywlc.getYwlccurnode());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					dao.insert(w);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("26");
					f.setCzyuserid(w.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("工作任务流转消息");

				}else{
                    SysuserDTO sdto2=new SysuserDTO();
                    sdto2.setUserid(sysuser.getUserid());
                    listother.add(sdto2);
                    json = JSONArray.fromObject(listother);
                    jpushInfoDTO.setMessage("执法办案流转消息");
                }

                // 插入 业务流程日志表
                Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
                wf_ywlclog.setYwlclogid(DbUtils.getSequenceStr());
                wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
                wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
                wf_ywlclog.setSftzjd(v_sftzjd);
                wf_ywlclog.setYwbljg(v_shifouTongguo);
                wf_ywlclog.setNodeid(wfnode.getNodeid());
                wf_ywlclog.setNodepym(wfnode.getNodepym());//
                wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
                wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
                wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
                wf_ywlclog.setTransname(v_transname);
                wf_ywlclog.setTransyy(v_transyy);
                wf_ywlclog.setComdm(v_comdm);
                wf_ywlclog.setCommc(v_commc);
                wf_ywlclog.setAae011(sysuser.getDescription().toString());
                wf_ywlclog.setAae036(startTime);
                dao.insert(wf_ywlclog);

                // 插入节点对应的文书
                ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
                v_ZfajzfwsDTO.setAjdjid(v_ywbh);
                v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
                v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
                v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

                wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);
            }
        } else {
            throw new BusinessException("工作流：" + v_yewumcpym + "未启用！");
        }

        Timestamp endTime = SysmanageUtil.currentTime();
        SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
        jpushInfoDTO.setAccertuserid_rows(json.toString());

        jpushInfoDTO.setTitle(v_commc);
        jpushInfoDTO.setType("1004");
        jpushInfoDTO.setUserid(dto.getUserid());
        jpushService.sendMessage(request, jpushInfoDTO);
    }
	
	/**
	 * 
	 * rollbackWfprocess的中文名称：回滚工作流
	 * 
	 * rollbackWfprocess的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String rollbackWfprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			rollbackWfprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void rollbackWfprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String aaa027 = sysuser.getAaa027();

		String v_ywbh = request.getParameter("ywbh");// 业务编号
		String v_yewumcpym = request.getParameter("yewumcpym");// 业务名称拼音码
		String v_yewutablename = request.getParameter("yewutablename");// 表名
		String v_yewucolname = request.getParameter("yewucolname");// 字段
		
		String v_sql = "";

		// 获取业务工作流关系表
		v_sql = "select a.* from Wf_yewu_process a where a.yewumcpym = '"
				+ v_yewumcpym + "' and a.aaa027 = '" + aaa027 + "'";
		List<?> wf_yewuprocessList = DbUtils.getDataList(v_sql, Wf_yewu_process.class);
		if (wf_yewuprocessList == null || wf_yewuprocessList.size() == 0) {
			throw new BusinessException("获取业务名称拼音码【" + v_yewumcpym
					+ "】对应的业务工作流关系表Wf_yewu_process数据失败！");
		}
		Wf_yewu_process wfyewuprocess = (Wf_yewu_process) wf_yewuprocessList.get(0);
		if ("1".equals(wfyewuprocess.getSfqygzl())) { // 启用工作流
			// 查询工作流当前结点
			List<?> wf_ywlcList = dao.query(Wf_ywlc.class, Cnd.where("psbh", "=",
					wfyewuprocess.getPsbh()).and("ywbh", "=", v_ywbh ));
			if (wf_ywlcList != null && wf_ywlcList.size() > 0) {
				Wf_ywlc ywlc = (Wf_ywlc) wf_ywlcList.get(0);
				
				//gu20161229add只要案件受经办人 才能做回退操作
				v_sql="select count(*) from zfajcbr a where a.userid='"+sysuser.getUserid()+
						"' and a.ajdjid='"+ywlc.getYwbh()+"'";
				int v_count=Integer.parseInt(DbUtils.getOneValue(dao, v_sql));
				if (v_count==0){
					throw new BusinessException("不是案件经办人不能办理“受理回退”");
				}
				
				if ("8".equals(ywlc.getYwlccurnode())) { // 如果为初始节点
					// 案件登记受理标志更改
					StringBuffer sl_sql = new StringBuffer();
					sl_sql.append(" update ").append(v_yewutablename);
					sl_sql.append(" set slbz='0'");
					sl_sql.append(" where ").append(v_yewucolname);
					sl_sql.append(" = '").append(v_ywbh).append("' ");
					Sql sql = Sqls.create(sl_sql.toString());
					dao.execute(sql);
					// 删除工作流
					dao.clear(Wf_ywlc.class, Cnd.where("psbh", "=",
							wfyewuprocess.getPsbh()).and("ywbh", "=", v_ywbh ));
					// 删除工作流日志
					dao.clear(Wf_ywlclog.class, Cnd.where("psbh", "=",
							wfyewuprocess.getPsbh()).and("ywbh", "=", v_ywbh ));
				} else {
					throw new BusinessException("该工作流已启用，不能退回！");
				}
			} 
		} else {
			throw new BusinessException("工作流：" + v_yewumcpym + "未启用！");
		}
	}

	/**
	 * 
	 * doWfprocess的中文名称：通用操作,推动工作流向下走一步
	 * 
	 * beginWfprocess的概要说明：工作流待办业务
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String doWfprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			return doWfprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
	}

    public String doWffwprocess(HttpServletRequest request, WorkflowDTO dto) {
        try {
            return doWffwprocessImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
    }

	/**
	 *
	 * doWfgongwenprocess的中文名称：通用操作,推动公文工作流向下走一步
	 *
	 * doWfgongwenprocess的概要说明：公文工作流待办业务
	 *
	 * @param dto
	 * @return Written by : zk
	 *
	 */
	public String doWfgongwenprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			return doWfgongwenprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
	}

	public String doWfprocessnew(HttpServletRequest request, WorkflowDTO dto) {
		try {
			return doWfprocessnewImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
	}

    public String doWfswprocess(HttpServletRequest request, WorkflowDTO dto) {
        try {
            return doWfswprocessImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
    }

	@Aop( { "trans" })
	public String doWfprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();
		if(sysuser==null){
			sysuser = SysmanageUtil.getSysuser(dto.getUserid());
		}
		String aaa027 = sysuser.getAaa027();

		String v_ywlcid = request.getParameter("ywlcid");// 业务流程表ID
		String v_transname = PubFunc.urlDecodeUTF(request
				.getParameter("transname"));// 分支节点流向名称
		String v_transval = PubFunc.urlDecodeUTF(request
				.getParameter("transval"));// 分支节点流向值
		String v_transyy = PubFunc
				.urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
		String v_shifouTongguo = request.getParameter("shifouTongguo");// 该节点操作是否通过
		String v_comdm = request.getParameter("comdm");// 
		String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
		String v_sql = "";
		List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
		List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
		JSONArray json=null;
		JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		// 获取业务流程
		Wf_ywlc v_wfywlc = dao.fetch(Wf_ywlc.class, v_ywlcid);

		// 获取业务流程的当前节点
		v_sql = "select a.* from Wf_node a where a.psbh = '"
				+ v_wfywlc.getPsbh() + "' and a.nodeid = '"
				+ v_wfywlc.getYwlccurnode() + "'";
		List wfnodeList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
		if (wfnodeList == null) {
			throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
					+ "】，流程节点【" + v_wfywlc.getYwlccurnode()
					+ "】获取业务流程当前节点的Wf_node数据失败！");
		}
		Wf_node wfnode = (Wf_node) wfnodeList.get(0);

		// 获取业务流程的下一个节点
		if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
			v_sql = "select a.* from Wf_node a where a.psbh = '"
					+ wfnode.getPsbh()
					+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
					+ "  where b.psbh = '" + wfnode.getPsbh()
					+ "'   and b.transfrom = '" + wfnode.getNodeid()
					+ "'   and b.transname = '" + v_transname + "')";
		} else {// 不是分支节点
			v_sql = "select a.* from Wf_node a where a.psbh = '"
					+ wfnode.getPsbh()
					+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
					+ "  where b.psbh = '" + wfnode.getPsbh()
					+ "'   and b.transfrom = '" + wfnode.getNodeid() + "')";
		}
		List wfnodeNextList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
		if (wfnodeNextList == null||wfnodeNextList.size()==0) {
			throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
					+ "】，流程节点【" + wfnode.getNodeid()
					+ "】获取业务流程下一个节点的Wf_node数据失败！");
		}
		Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

		while (true) {// 循环，一直取到需要处理的节点
			if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
				// 获取下一个节点
				if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ v_wfnodeNext.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + v_wfnodeNext.getPsbh()
							+ "'   and b.transfrom = '"
							+ v_wfnodeNext.getNodeid()
							+ "'   and b.transname = '" + v_transname + "')";
				} else {// 不是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ v_wfnodeNext.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + v_wfnodeNext.getPsbh()
							+ "'   and b.transfrom = '"
							+ v_wfnodeNext.getNodeid() + "')";
				}
				List ls = (List) DbUtils.getDataList(v_sql, Wf_node.class);
				if (ls == null) {
					throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
							+ "】，流程节点【" + v_wfnodeNext.getNodeid()
							+ "】获取业务流程下一个节点的Wf_node数据失败！");
				}
				v_wfnodeNext = (Wf_node) ls.get(0);
			} else {
				break;
			}
		}

		// 获取下一个节点的【时限开始时间、时限结束时间】
		String v_node_sx_begin = DateUtil.getCurYearMonthDay();
		String v_node_sx_end = "";
		String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext.getNodesx());
		if (!"".equals(v_nodesx)) {
			v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin + "','"
					+ v_nodesx + "') as node_sx_end from dual";
			v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
			if ("-1".equals(v_node_sx_end)) {
				throw new BusinessException("根据当前年月日【" + v_node_sx_begin
						+ "】和节点工作时限【" + v_nodesx + "】没有获取到时限结束时间，请检查工作日设置！");
			}
		}

		// 审核通过，更改业务流程的当前节点
		// 审核不通过，只插入业务流程日志表
		String v_ywlcjsbz = "0";// 未结束
		String v_ywlczcjsbz = "0";// 处理中
		String v_sftzjd = "1";// 是否跳转节点
		if ("END_NODE".equals(v_wfnodeNext.getNodetype())) {
			v_ywlcjsbz = "1";
			if ("0".equals(v_shifouTongguo)) {
				v_ywlczcjsbz = "2";// 非正常结束
			} else if ("1".equals(v_shifouTongguo)) {
				v_ywlczcjsbz = "1";// 正常结束
			}
		}

		if ("1".equals(v_shifouTongguo)) {
			// 更新业务流程表：将业务流程表的当前节点改为下一个节点
			v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
			v_wfywlc.setNodesx(v_nodesx);
			if (!PubFunc.isNullStr(v_node_sx_begin)) {
				v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
						.getTime(v_node_sx_begin)));
			}
			if (!PubFunc.isNullStr(v_node_sx_end)) {
				v_wfywlc.setNodesxend(new Timestamp(PubFunc
						.getTime(v_node_sx_end)));
			}
			v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
			v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
			dao.update(v_wfywlc);

			WorkflowDTO wdto=new WorkflowDTO();
			wdto.setYwlcid(v_ywlcid);
			List list1=queryWfywlc(wdto);
			if(list1!=null&&list1.size()>0){
				wdto=(WorkflowDTO) list1.get(0);
				if("gwglswlc".equals(wdto.getYewumcpym())||"gwglfwlc".equals(wdto.getYewumcpym())){
					Wf_node_fzr  fzrnew=new Wf_node_fzr();
					fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
					fzrnew.setPsbh(v_wfywlc.getYwbh());
					SysuserDTO sdto2=new SysuserDTO();
					if(StringUtils.isEmpty(dto.getUserid())) {
						fzrnew.setFzruserid(sysuser.getUserid());
						sdto2.setUserid(sysuser.getUserid());
						listgw.add(sdto2);
					}else{
						fzrnew.setFzruserid(dto.getUserid());
						sdto2.setUserid(dto.getUserid());
						listgw.add(sdto2);
					}
					fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
					fzrnew.setCzyuserid(sysuser.getUserid());
					fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

						/*dao.insert(fzrnew);*/

					String ywlcuserid = request.getParameter("ywlcuserid");
					if(!StringUtils.isEmpty(ywlcuserid)) {
						String[] strArray = null;
						strArray = ywlcuserid.split(",");
						Wf_node_fzr fzr = new Wf_node_fzr();
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(sysuser.getUserid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}
					if("gwglfwlc".equals(wdto.getYewumcpym())&&"核稿".equals(v_transname)){
						String cuserid = request.getParameter("cuserid");
						if(!StringUtils.isEmpty(cuserid)) {
							String[] strArray = null;
							strArray = cuserid.split(",");
							Wf_node_fzr fzr = new Wf_node_fzr();
							for (int i = 0; i < strArray.length; i++) {
								fzr.setWfnodefzrid(DbUtils.getSequenceStr());
								fzr.setPsbh(v_wfywlc.getYwbh());
								fzr.setFzruserid(strArray[i]);
								fzr.setNodeid("68");
								fzr.setCzyuserid(sysuser.getUserid());
								fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
								dao.insert(fzr);
							}
						}
					}
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("公文流转消息");
				}else{
					SysuserDTO sdto2=new SysuserDTO();
					if(StringUtils.isEmpty(dto.getUserid())) {
						sdto2.setUserid(sysuser.getUserid());
					    listother.add(sdto2);
					}else{
						sdto2.setUserid(sysuser.getUserid());
						listother.add(sdto2);
					}
					json = JSONArray.fromObject(listother);
					jpushInfoDTO.setMessage("执法办案流转消息");
				}
			}
		}

		// 插入 业务流程日志表
		Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
		String id =  DbUtils.getSequenceStr();
		wf_ywlclog.setYwlclogid(id);
		wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
		wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
		wf_ywlclog.setSftzjd(v_sftzjd);
		wf_ywlclog.setYwbljg(v_shifouTongguo);
		wf_ywlclog.setNodeid(wfnode.getNodeid());
		wf_ywlclog.setNodepym(wfnode.getNodepym());//
		wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
		wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
		wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
		wf_ywlclog.setTransname(v_transname);
		wf_ywlclog.setTransyy(v_transyy);
		wf_ywlclog.setComdm(v_comdm);
		wf_ywlclog.setCommc(v_commc);
		wf_ywlclog.setAae011(sysuser.getDescription().toString());
		wf_ywlclog.setAae036(startTime);
		dao.insert(wf_ywlclog);

		// 插入节点对应的文书
		ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
		v_ZfajzfwsDTO.setAjdjid(v_wfywlc.getYwbh());
		v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
		v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
		v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

		wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

	/*	JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		jpushInfoDTO.setAccertuserid_rows("[{\"userid\":\"2018032211212513221228065\",\"username\":\"安阳市管理员\",\"bmmc\":\"河南省食药局\"}]");
		jpushInfoDTO.setMessage("公文流转消息");
		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);*/

		jpushInfoDTO.setAccertuserid_rows(json.toString());

		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);
		return id;
	}


    @Aop( { "trans" })
    public String doWffwprocessImp(HttpServletRequest request, WorkflowDTO dto)
            throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser sysuser = SysmanageUtil.getSysuser();
        if(sysuser==null){
            sysuser = SysmanageUtil.getSysuser(dto.getUserid());
        }
        String aaa027 = sysuser.getAaa027();

        String v_ywlcid = request.getParameter("ywlcid");// 业务流程表ID
        String v_transname = PubFunc.urlDecodeUTF(request
                .getParameter("transname"));// 分支节点流向名称
		String v_transnamea = PubFunc.urlDecodeUTF(request
				.getParameter("transnamea"));// 分支节点流向名称
        String v_transval = PubFunc.urlDecodeUTF(request
                .getParameter("transval"));// 分支节点流向值
        String v_transyy = PubFunc
                .urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
        String v_shifouTongguo = request.getParameter("shifouTongguo");// 该节点操作是否通过
        String v_comdm = request.getParameter("comdm");//
        String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
        String v_sql = "";
        List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
        List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
        JSONArray json=null;
        JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
        // 获取业务流程
        Wf_ywlc v_wfywlc = dao.fetch(Wf_ywlc.class, v_ywlcid);
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();
        // 获取业务流程的当前节点
        v_sql = "select a.* from Wf_node a where a.psbh = '"
                + v_wfywlc.getPsbh() + "' and a.nodeid = '"
                + v_wfywlc.getYwlccurnode() + "'";
        List wfnodeList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeList == null) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + v_wfywlc.getYwlccurnode()
                    + "】获取业务流程当前节点的Wf_node数据失败！");
        }
        Wf_node wfnode = (Wf_node) wfnodeList.get(0);

        // 获取业务流程的下一个节点
        if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid()
                    + "'   and b.transname = '" + v_transname + "')";
        } else {// 不是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid() + "')";
        }
        List wfnodeNextList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeNextList == null||wfnodeNextList.size()==0) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + wfnode.getNodeid()
                    + "】获取业务流程下一个节点的Wf_node数据失败！");
        }
        Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

        while (true) {// 循环，一直取到需要处理的节点
            if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
                // 获取下一个节点
                if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid()
                            + "'   and b.transname = '" + v_transname + "')";
                } else {// 不是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid() + "')";
                }
                List ls = (List) DbUtils.getDataList(v_sql, Wf_node.class);
                if (ls == null) {
                    throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                            + "】，流程节点【" + v_wfnodeNext.getNodeid()
                            + "】获取业务流程下一个节点的Wf_node数据失败！");
                }
                v_wfnodeNext = (Wf_node) ls.get(0);
            } else {
                break;
            }
        }

        // 获取下一个节点的【时限开始时间、时限结束时间】
        String v_node_sx_begin = DateUtil.getCurYearMonthDay();
        String v_node_sx_end = "";
        String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext.getNodesx());
        if (!"".equals(v_nodesx)) {
            v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin + "','"
                    + v_nodesx + "') as node_sx_end from dual";
            v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
            if ("-1".equals(v_node_sx_end)) {
                throw new BusinessException("根据当前年月日【" + v_node_sx_begin
                        + "】和节点工作时限【" + v_nodesx + "】没有获取到时限结束时间，请检查工作日设置！");
            }
        }

        // 审核通过，更改业务流程的当前节点
        // 审核不通过，只插入业务流程日志表
        String v_ywlcjsbz = "0";// 未结束
        String v_ywlczcjsbz = "0";// 处理中
        String v_sftzjd = "1";// 是否跳转节点
        if ("END_NODE".equals(v_wfnodeNext.getNodetype())) {
            v_ywlcjsbz = "1";
            if ("0".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "2";// 非正常结束
            } else if ("1".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "1";// 正常结束
            }
        }

        if ("1".equals(v_shifouTongguo)) {
            // 更新业务流程表：将业务流程表的当前节点改为下一个节点
            v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
            v_wfywlc.setNodesx(v_nodesx);
            if (!PubFunc.isNullStr(v_node_sx_begin)) {
                v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
                        .getTime(v_node_sx_begin)));
            }
            if (!PubFunc.isNullStr(v_node_sx_end)) {
                v_wfywlc.setNodesxend(new Timestamp(PubFunc
                        .getTime(v_node_sx_end)));
            }
            v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
            v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
            if("合法性审查".equals(v_transname)&&"合法性审查".equals(v_transnamea)){
                //queryWfnodefzr
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("39");
                List listhf=queryWfnodefzr(fto);
                if(listhf!=null&&listhf.size()>1){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }else{
                    dao.update(v_wfywlc);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }
            }else if("合法性审查".equals(v_transname)&&"签发".equals(v_transnamea)){
				//queryWfnodefzr
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("39");
				List listhf=queryWfnodefzr(fto);
				if(listhf!=null&&listhf.size()>1){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
				}else{
					v_wfywlc.setYwlccurnode("68");
					dao.update(v_wfywlc);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
				}
			}else if("主要领导审批".equals(v_transname)||"审核".equals(v_transname)){
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("68");
                List listha=queryWfnodefzr(fto);
                if(listha!=null&&listha.size()>1){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }else{
                    WorkflowDTO o=new WorkflowDTO();
                    o.setYwbh(v_wfywlc.getYwbh());
                    List j=queryW6(o);
                    if(j!=null&&j.size()>0) {
                        v_wfywlc.setYwlccurnode("54");
						f.setWfnodefzrid(DbUtils.getSequenceStr());
						f.setPsbh(v_wfywlc.getYwbh());
						f.setFzruserid("2018041209155115245772233");
						f.setNodeid("54");
						f.setCzyuserid(w.getYwlcid());
						f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
						dao.insert(f);
						dao.clear(Wf_node_fzr.class, Cnd.where("nodeid", "=","46").and("psbh", "=",v_wfywlc.getYwbh() ));
                    }else{
                    	if("54".equals(v_wfywlc.getYwlccurnode())){
							f.setWfnodefzrid(DbUtils.getSequenceStr());
							f.setPsbh(v_wfywlc.getYwbh());
							f.setFzruserid("2018041209155115245772233");
							f.setNodeid("54");
							f.setCzyuserid(w.getYwlcid());
							f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(f);
							dao.clear(Wf_node_fzr.class, Cnd.where("nodeid", "=","46").and("psbh", "=",v_wfywlc.getYwbh() ));
						}else{
							dao.clear(Wf_node_fzr.class, Cnd.where("nodeid", "=","54").and("psbh", "=",v_wfywlc.getYwbh() ));
						}
					}

                    dao.update(v_wfywlc);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }
            }else if("流程结束".equals(v_transname)){
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("64");
                List listha=queryWfnodefzr(fto);
                if(listha!=null&&listha.size()>1){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
                }else{
					dao.update(v_wfywlc);
					dao.clear(Wf_ywlc.class, Cnd.where("ywbh", "=",v_wfywlc.getYwbh()).and("psbh", "=","WF2018070400359" ));
				}

            }else if("签发".equals(v_transname)){

            	List position=queryWfywlcnbusernew(v_wfywlc.getYwbh());
            	if(position!=null&&position.size()>0){
            		WorkflowDTO p=(WorkflowDTO)position.get(0);
            		if("4".equals(p.getNodeid())){
            			v_wfywlc.setYwlccurnode("54");
						f.setWfnodefzrid(DbUtils.getSequenceStr());
						f.setPsbh(v_wfywlc.getYwbh());
						f.setFzruserid("2018041209155115245772233");
						f.setNodeid("54");
						f.setCzyuserid(w.getYwlcid());
						f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
						dao.insert(f);
					}
				}
				dao.update(v_wfywlc);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
			}else if("结束".equals(v_transname)){
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("31");
                List listha=queryWfnodefzr(fto);
                if(listha!=null&&listha.size()>0){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
                }
				/*dao.clear(Wf_ywlc.class, Cnd.where("aae011", "=",wfnode.getNodeid()).and("psbh", "=","WF2018070400359" ));*/
            }else if("核稿".equals(v_transname)){
				dao.update(v_wfywlc);
				w.setYwlcid(DbUtils.getSequenceStr());
				w.setYwbh(v_wfywlc.getYwbh());
				w.setPsbh("WF2018070400359");
				w.setYwlccurnode("2");
				w.setAae011(v_wfywlc.getYwlccurnode());
				w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
				w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
				w.setComdm(v_wfywlc.getComdm());
				w.setCommc(v_wfywlc.getCommc());
				w.setAaa027(v_wfywlc.getAaa027());
				dao.insert(w);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(w.getYwlcid());
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
			}else {
                dao.update(v_wfywlc);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(queryWfywlcid(v_wfywlc.getYwbh()));
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
            }
            WorkflowDTO wdto=new WorkflowDTO();
            wdto.setYwlcid(v_ywlcid);
            List list1=queryWfywlc(wdto);
            if(list1!=null&&list1.size()>0){
                wdto=(WorkflowDTO) list1.get(0);
                if("gwglswlc".equals(wdto.getYewumcpym())||"gwglfwlc".equals(wdto.getYewumcpym())){
                    Wf_node_fzr  fzrnew=new Wf_node_fzr();
                    fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
                    fzrnew.setPsbh(v_wfywlc.getYwbh());
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        fzrnew.setFzruserid(sysuser.getUserid());
                        sdto2.setUserid(sysuser.getUserid());
                        listgw.add(sdto2);
                    }else{
                        fzrnew.setFzruserid(dto.getUserid());
                        sdto2.setUserid(dto.getUserid());
                        listgw.add(sdto2);
                    }
                    fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
                    fzrnew.setCzyuserid(sysuser.getUserid());
                    fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

                    /*dao.insert(fzrnew);*/

                    String ywlcuserid = request.getParameter("ywlcuserid");
                    if(!StringUtils.isEmpty(ywlcuserid)&&!"54".equals(v_wfywlc.getYwlccurnode())) {
                        String[] strArray = null;
                        strArray = ywlcuserid.split(",");
                        Wf_node_fzr fzr = new Wf_node_fzr();
                        for (int i = 0; i < strArray.length; i++) {
                            fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                            fzr.setPsbh(v_wfywlc.getYwbh());
                            fzr.setFzruserid(strArray[i]);
                            fzr.setNodeid(v_wfywlc.getYwlccurnode());
                            fzr.setCzyuserid(sysuser.getUserid());
                            fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(fzr);
                            SysuserDTO sdto3 = new SysuserDTO();
                            sdto3.setUserid(strArray[i]);
                            listgw.add(sdto3);
                        }
                    }
                    if("gwglfwlc".equals(wdto.getYewumcpym())&&"核稿".equals(v_transname)){
                        String cuserid = request.getParameter("cuserid");
                        if(!StringUtils.isEmpty(cuserid)) {
                            String[] strArray = null;
                            strArray = cuserid.split(",");
                            Wf_node_fzr fzr = new Wf_node_fzr();
                            for (int i = 0; i < strArray.length; i++) {
                                fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                                fzr.setPsbh(v_wfywlc.getYwbh());
                                fzr.setFzruserid(strArray[i]);
                                fzr.setNodeid("68");
                                fzr.setCzyuserid(sysuser.getUserid());
                                fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                                dao.insert(fzr);
                            }
                        }
                    }
                    json = JSONArray.fromObject(listgw);
                    jpushInfoDTO.setMessage("公文流转消息");
                }else{
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }else{
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }
                    json = JSONArray.fromObject(listother);
                    jpushInfoDTO.setMessage("执法办案流转消息");
                }
            }
        }

        // 插入 业务流程日志表
        Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
        String id =  DbUtils.getSequenceStr();
        wf_ywlclog.setYwlclogid(id);
        wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
        wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
        wf_ywlclog.setSftzjd(v_sftzjd);
        wf_ywlclog.setYwbljg(v_shifouTongguo);
        wf_ywlclog.setNodeid(wfnode.getNodeid());
        wf_ywlclog.setNodepym(wfnode.getNodepym());//
        wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
        wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
        wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
        wf_ywlclog.setTransname(v_transname);
        wf_ywlclog.setTransyy(v_transyy);
        wf_ywlclog.setComdm(v_comdm);
        wf_ywlclog.setCommc(v_commc);
        wf_ywlclog.setAae011(sysuser.getDescription().toString());
        wf_ywlclog.setAae036(startTime);
        dao.insert(wf_ywlclog);

        // 插入节点对应的文书
        ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
        v_ZfajzfwsDTO.setAjdjid(v_wfywlc.getYwbh());
        v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
        v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
        v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

        wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);

        Timestamp endTime = SysmanageUtil.currentTime();
        SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

	/*	JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		jpushInfoDTO.setAccertuserid_rows("[{\"userid\":\"2018032211212513221228065\",\"username\":\"安阳市管理员\",\"bmmc\":\"河南省食药局\"}]");
		jpushInfoDTO.setMessage("公文流转消息");
		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);*/

        jpushInfoDTO.setAccertuserid_rows(json.toString());

        jpushInfoDTO.setTitle(v_wfywlc.getCommc());
        jpushInfoDTO.setType("1004");
        jpushInfoDTO.setUserid(dto.getUserid());
        jpushService.sendMessage(request, jpushInfoDTO);
        return id;
    }


    @Aop( { "trans" })
    public String doWfswprocessImp(HttpServletRequest request, WorkflowDTO dto)
            throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser sysuser = SysmanageUtil.getSysuser();
        if(sysuser==null){
            sysuser = SysmanageUtil.getSysuser(dto.getUserid());
        }
        String aaa027 = sysuser.getAaa027();

        String v_ywlcid = request.getParameter("ywlcid");// 业务流程表ID
        String v_transname = PubFunc.urlDecodeUTF(request
                .getParameter("transname"));// 分支节点流向名称
        String v_transval = PubFunc.urlDecodeUTF(request
                .getParameter("transval"));// 分支节点流向值
        String v_transyy = PubFunc
                .urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
        String v_shifouTongguo = request.getParameter("shifouTongguo");// 该节点操作是否通过
        String v_comdm = request.getParameter("comdm");//
        String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
        String v_sql = "";
        List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
        List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
        JSONArray json=null;
        JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
        // 获取业务流程
        Wf_ywlc v_wfywlc = dao.fetch(Wf_ywlc.class, v_ywlcid);
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();
        // 获取业务流程的当前节点
        v_sql = "select a.* from Wf_node a where a.psbh = '"
                + v_wfywlc.getPsbh() + "' and a.nodeid = '"
                + v_wfywlc.getYwlccurnode() + "'";
        List wfnodeList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeList == null) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + v_wfywlc.getYwlccurnode()
                    + "】获取业务流程当前节点的Wf_node数据失败！");
        }
        Wf_node wfnode = (Wf_node) wfnodeList.get(0);

        // 获取业务流程的下一个节点
        if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid()
                    + "'   and b.transname = '" + v_transname + "')";
        } else {// 不是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid() + "')";
        }
        List wfnodeNextList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeNextList == null||wfnodeNextList.size()==0) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + wfnode.getNodeid()
                    + "】获取业务流程下一个节点的Wf_node数据失败！");
        }
        Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

        while (true) {// 循环，一直取到需要处理的节点
            if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
                // 获取下一个节点
                if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid()
                            + "'   and b.transname = '" + v_transname + "')";
                } else {// 不是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid() + "')";
                }
                List ls = (List) DbUtils.getDataList(v_sql, Wf_node.class);
                if (ls == null) {
                    throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                            + "】，流程节点【" + v_wfnodeNext.getNodeid()
                            + "】获取业务流程下一个节点的Wf_node数据失败！");
                }
                v_wfnodeNext = (Wf_node) ls.get(0);
            } else {
                break;
            }
        }

        // 获取下一个节点的【时限开始时间、时限结束时间】
        String v_node_sx_begin = DateUtil.getCurYearMonthDay();
        String v_node_sx_end = "";
        String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext.getNodesx());
        if (!"".equals(v_nodesx)) {
            v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin + "','"
                    + v_nodesx + "') as node_sx_end from dual";
            v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
            if ("-1".equals(v_node_sx_end)) {
                throw new BusinessException("根据当前年月日【" + v_node_sx_begin
                        + "】和节点工作时限【" + v_nodesx + "】没有获取到时限结束时间，请检查工作日设置！");
            }
        }

        // 审核通过，更改业务流程的当前节点
        // 审核不通过，只插入业务流程日志表
        String v_ywlcjsbz = "0";// 未结束
        String v_ywlczcjsbz = "0";// 处理中
        String v_sftzjd = "1";// 是否跳转节点
        if ("END_NODE".equals(v_wfnodeNext.getNodetype())) {
            v_ywlcjsbz = "1";
            if ("0".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "2";// 非正常结束
            } else if ("1".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "1";// 正常结束
            }
        }

        if ("1".equals(v_shifouTongguo)) {
            // 更新业务流程表：将业务流程表的当前节点改为下一个节点
            v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
            v_wfywlc.setNodesx(v_nodesx);
            if (!PubFunc.isNullStr(v_node_sx_begin)) {
                v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
                        .getTime(v_node_sx_begin)));
            }
            if (!PubFunc.isNullStr(v_node_sx_end)) {
                v_wfywlc.setNodesxend(new Timestamp(PubFunc
                        .getTime(v_node_sx_end)));
            }
            v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
            v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
            if("合法性审查".equals(v_transname)){
                //queryWfnodefzr
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("39");
                List listhf=queryWfnodefzr(fto);
                if(listhf!=null&&listhf.size()>1){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
                }else{
                    dao.update(v_wfywlc);
					WorkflowDTO o=new WorkflowDTO();
					o.setYwbh(v_wfywlc.getYwbh());
					List list1=queryWfywlcnew(o);
					o=(WorkflowDTO)list1.get(0);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(o.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }
            }else if("主要领导审批".equals(v_transname)||"办公室审核".equals(v_transname)){
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("68");
                List listha=queryWfnodefzr(fto);
                if(listha!=null&&listha.size()>1){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
                }else{
                    dao.update(v_wfywlc);
					WorkflowDTO o=new WorkflowDTO();
					o.setYwbh(v_wfywlc.getYwbh());
					List list1=queryWfywlcnew(o);
					o=(WorkflowDTO)list1.get(0);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(o.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
                }
            }else if("结束".equals(v_transname)){
                WorkflowDTO fto=new WorkflowDTO();
                fto.setPsbh(v_wfywlc.getYwbh());
                fto.setNodeid("6");
                List listha=queryWfnodefzr(fto);
				if(listha!=null&&listha.size()==1){
					dao.clear(Wf_ywlc.class, Cnd.where("ywbh", "=",v_wfywlc.getYwbh()).and("psbh", "=","WF2018070400359" ));
				}
                if(listha!=null&&listha.size()>0){
                    dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
                }
            }else if("请示".equals(v_transname)){
				dao.update(v_wfywlc);
				w.setYwlcid(DbUtils.getSequenceStr());
				w.setYwbh(v_wfywlc.getYwbh());
				w.setPsbh("WF2018070400359");
				w.setYwlccurnode("2");
				w.setAae011(v_wfywlc.getYwlccurnode());
				w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
				w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
				w.setComdm(v_wfywlc.getComdm());
				w.setCommc(v_wfywlc.getCommc());
				w.setAaa027(v_wfywlc.getAaa027());
				dao.insert(w);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(w.getYwlcid());
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
			}else {
                dao.update(v_wfywlc);
				WorkflowDTO o=new WorkflowDTO();
				o.setYwbh(v_wfywlc.getYwbh());
				List list1=queryWfywlcnew(o);
				o=(WorkflowDTO)list1.get(0);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(o.getYwlcid());
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
            }
            WorkflowDTO wdto=new WorkflowDTO();
            wdto.setYwlcid(v_ywlcid);
            List list1=queryWfywlc(wdto);
            if(list1!=null&&list1.size()>0){
                wdto=(WorkflowDTO) list1.get(0);
                if("gwglswlc".equals(wdto.getYewumcpym())||"gwglfwlc".equals(wdto.getYewumcpym())||"xtdcksw".equals(wdto.getYewumcpym())){
                    Wf_node_fzr  fzrnew=new Wf_node_fzr();
                    fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
                    fzrnew.setPsbh(v_wfywlc.getYwbh());
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        fzrnew.setFzruserid(sysuser.getUserid());
                        sdto2.setUserid(sysuser.getUserid());
                        listgw.add(sdto2);
                    }else{
                        fzrnew.setFzruserid(dto.getUserid());
                        sdto2.setUserid(dto.getUserid());
                        listgw.add(sdto2);
                    }
                    fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
                    fzrnew.setCzyuserid(sysuser.getUserid());
                    fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

                    /*dao.insert(fzrnew);*/

                    String ywlcuserid = request.getParameter("ywlcuserid");
                    if(!StringUtils.isEmpty(ywlcuserid)) {
                        String[] strArray = null;
                        strArray = ywlcuserid.split(",");
                        Wf_node_fzr fzr = new Wf_node_fzr();
                        for (int i = 0; i < strArray.length; i++) {
                            fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                            fzr.setPsbh(v_wfywlc.getYwbh());
                            fzr.setFzruserid(strArray[i]);
                            fzr.setNodeid(v_wfywlc.getYwlccurnode());
                            fzr.setCzyuserid(sysuser.getUserid());
                            fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(fzr);
                            SysuserDTO sdto3 = new SysuserDTO();
                            sdto3.setUserid(strArray[i]);
                            listgw.add(sdto3);
                        }
                    }
                    if("gwglfwlc".equals(wdto.getYewumcpym())&&"核稿".equals(v_transname)){
                        String cuserid = request.getParameter("cuserid");
                        if(!StringUtils.isEmpty(cuserid)) {
                            String[] strArray = null;
                            strArray = cuserid.split(",");
                            Wf_node_fzr fzr = new Wf_node_fzr();
                            for (int i = 0; i < strArray.length; i++) {
                                fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                                fzr.setPsbh(v_wfywlc.getYwbh());
                                fzr.setFzruserid(strArray[i]);
                                fzr.setNodeid("68");
                                fzr.setCzyuserid(sysuser.getUserid());
                                fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                                dao.insert(fzr);
                            }
                        }
                    }
                    json = JSONArray.fromObject(listgw);
                    jpushInfoDTO.setMessage("公文流转消息");
                }else{
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }else{
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }
                    json = JSONArray.fromObject(listother);
                    jpushInfoDTO.setMessage("执法办案流转消息");
                }
            }
        }

        // 插入 业务流程日志表
        Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
        String id =  DbUtils.getSequenceStr();
        wf_ywlclog.setYwlclogid(id);
        wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
        wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
        wf_ywlclog.setSftzjd(v_sftzjd);
        wf_ywlclog.setYwbljg(v_shifouTongguo);
        wf_ywlclog.setNodeid(wfnode.getNodeid());
        wf_ywlclog.setNodepym(wfnode.getNodepym());//
        wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
        wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
        wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
        wf_ywlclog.setTransname(v_transname);
        wf_ywlclog.setTransyy(v_transyy);
        wf_ywlclog.setComdm(v_comdm);
        wf_ywlclog.setCommc(v_commc);
        wf_ywlclog.setAae011(sysuser.getDescription().toString());
        wf_ywlclog.setAae036(startTime);
        dao.insert(wf_ywlclog);

        // 插入节点对应的文书
        ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
        v_ZfajzfwsDTO.setAjdjid(v_wfywlc.getYwbh());
        v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
        v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
        v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

        wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);

        Timestamp endTime = SysmanageUtil.currentTime();
        SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

	/*	JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		jpushInfoDTO.setAccertuserid_rows("[{\"userid\":\"2018032211212513221228065\",\"username\":\"安阳市管理员\",\"bmmc\":\"河南省食药局\"}]");
		jpushInfoDTO.setMessage("公文流转消息");
		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);*/

        jpushInfoDTO.setAccertuserid_rows(json.toString());

        jpushInfoDTO.setTitle(v_wfywlc.getCommc());
        jpushInfoDTO.setType("1004");
        jpushInfoDTO.setUserid(dto.getUserid());
        jpushService.sendMessage(request, jpushInfoDTO);
        return id;
    }

	@Aop( { "trans" })
	public String doWfprocessnewImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();
		if(sysuser==null){
			sysuser = SysmanageUtil.getSysuser(dto.getUserid());
		}
		String aaa027 = sysuser.getAaa027();

		String v_ywlcid = request.getParameter("ywlcid");// 业务流程表ID
		String v_transname = PubFunc.urlDecodeUTF(request
				.getParameter("transname"));// 分支节点流向名称
		String v_transval = PubFunc.urlDecodeUTF(request
				.getParameter("transval"));// 分支节点流向值
		String v_transyy = PubFunc
				.urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
		String v_shifouTongguo = request.getParameter("shifouTongguo");// 该节点操作是否通过
		String v_comdm = request.getParameter("comdm");//
		String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
		String v_sql = "";
		List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
		List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
		JSONArray json=null;
		JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		// 获取业务流程
		Wf_ywlc v_wfywlc = dao.fetch(Wf_ywlc.class, v_ywlcid);
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();

		// 获取业务流程的当前节点
		v_sql = "select a.* from Wf_node a where a.psbh = '"
				+ v_wfywlc.getPsbh() + "' and a.nodeid = '"
				+ v_wfywlc.getYwlccurnode() + "'";
		List wfnodeList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
		if (wfnodeList == null) {
			throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
					+ "】，流程节点【" + v_wfywlc.getYwlccurnode()
					+ "】获取业务流程当前节点的Wf_node数据失败！");
		}
		Wf_node wfnode = (Wf_node) wfnodeList.get(0);

		// 获取业务流程的下一个节点
		if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
			v_sql = "select a.* from Wf_node a where a.psbh = '"
					+ wfnode.getPsbh()
					+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
					+ "  where b.psbh = '" + wfnode.getPsbh()
					+ "'   and b.transfrom = '" + wfnode.getNodeid()
					+ "'   and b.transname = '" + v_transname + "')";
		} else {// 不是分支节点
			v_sql = "select a.* from Wf_node a where a.psbh = '"
					+ wfnode.getPsbh()
					+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
					+ "  where b.psbh = '" + wfnode.getPsbh()
					+ "'   and b.transfrom = '" + wfnode.getNodeid() + "')";
		}
		List wfnodeNextList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
		if (wfnodeNextList == null||wfnodeNextList.size()==0) {
			throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
					+ "】，流程节点【" + wfnode.getNodeid()
					+ "】获取业务流程下一个节点的Wf_node数据失败！");
		}
		Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

		while (true) {// 循环，一直取到需要处理的节点
			if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
				// 获取下一个节点
				if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ v_wfnodeNext.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + v_wfnodeNext.getPsbh()
							+ "'   and b.transfrom = '"
							+ v_wfnodeNext.getNodeid()
							+ "'   and b.transname = '" + v_transname + "')";
				} else {// 不是分支节点
					v_sql = "select a.* from Wf_node a where a.psbh = '"
							+ v_wfnodeNext.getPsbh()
							+ "'   and a.nodeid = (select b.transto from Wf_node_trans b "
							+ "  where b.psbh = '" + v_wfnodeNext.getPsbh()
							+ "'   and b.transfrom = '"
							+ v_wfnodeNext.getNodeid() + "')";
				}
				List ls = (List) DbUtils.getDataList(v_sql, Wf_node.class);
				if (ls == null) {
					throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
							+ "】，流程节点【" + v_wfnodeNext.getNodeid()
							+ "】获取业务流程下一个节点的Wf_node数据失败！");
				}
				v_wfnodeNext = (Wf_node) ls.get(0);
			} else {
				break;
			}
		}

		// 获取下一个节点的【时限开始时间、时限结束时间】
		String v_node_sx_begin = DateUtil.getCurYearMonthDay();
		String v_node_sx_end = "";
		String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext.getNodesx());
		if (!"".equals(v_nodesx)) {
			v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin + "','"
					+ v_nodesx + "') as node_sx_end from dual";
			v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
			if ("-1".equals(v_node_sx_end)) {
				throw new BusinessException("根据当前年月日【" + v_node_sx_begin
						+ "】和节点工作时限【" + v_nodesx + "】没有获取到时限结束时间，请检查工作日设置！");
			}
		}

		// 审核通过，更改业务流程的当前节点
		// 审核不通过，只插入业务流程日志表
		String v_ywlcjsbz = "0";// 未结束
		String v_ywlczcjsbz = "0";// 处理中
		String v_sftzjd = "1";// 是否跳转节点
		if ("END_NODE".equals(v_wfnodeNext.getNodetype())) {
			v_ywlcjsbz = "1";
			if ("0".equals(v_shifouTongguo)) {
				v_ywlczcjsbz = "2";// 非正常结束
			} else if ("1".equals(v_shifouTongguo)) {
				v_ywlczcjsbz = "1";// 正常结束
			}
		}

		if ("1".equals(v_shifouTongguo)) {
			// 更新业务流程表：将业务流程表的当前节点改为下一个节点
			v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
			v_wfywlc.setNodesx(v_nodesx);
			if (!PubFunc.isNullStr(v_node_sx_begin)) {
				v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
						.getTime(v_node_sx_begin)));
			}
			if (!PubFunc.isNullStr(v_node_sx_end)) {
				v_wfywlc.setNodesxend(new Timestamp(PubFunc
						.getTime(v_node_sx_end)));
			}
			v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
			v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
			if("合法性审查".equals(v_transname)){
				//queryWfnodefzr
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("39");
				List listhf=queryWfnodefzr(fto);
				if(listhf!=null&&listhf.size()>1){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
				}else{
					dao.update(v_wfywlc);
					WorkflowDTO o=new WorkflowDTO();
					o.setYwbh(v_wfywlc.getYwbh());
					List list1=queryWfywlcnew(o);
					o=(WorkflowDTO)list1.get(0);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(o.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
				}
			}else if("主要领导批示".equals(v_transname)||"直接转批示".equals(v_transname)){

					dao.update(v_wfywlc);
					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh("WF2018070400359");
					w.setYwlccurnode("2");
					w.setAae011(v_wfywlc.getYwlccurnode());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					dao.insert(w);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(w.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);


			}else if("流程结束".equals(v_transname)){
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("64");
				List listha=queryWfnodefzr(fto);
				if(listha!=null&&listha.size()>0){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
				}
			}else if("结束".equals(v_transname)){
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("31");
				List listha=queryWfnodefzr(fto);
				if(listha!=null&&listha.size()>0){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
					List dsitinct=queryWfywlcdistinct(v_wfywlc.getYwbh());
					if(dsitinct!=null&&dsitinct.size()==1){
						dao.clear(Wf_ywlc.class, Cnd.where("ywbh", "=",v_wfywlc.getYwbh()).and("psbh", "=","WF2018070400359" ));
					}
				}
			}else if("分办".equals(v_transname)){
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("46");
				List listha=queryWfnodefzr(fto);
				if(listha!=null&&listha.size()>1){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));

					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh(v_wfywlc.getPsbh());
					w.setYwlccurnode(v_wfywlc.getYwlccurnode());
					w.setNodesxbegin(v_wfywlc.getNodesxbegin());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					dao.insert(w);
					WorkflowDTO o=new WorkflowDTO();
					o.setYwbh(v_wfywlc.getYwbh());
					List list1=queryWfywlcnew(o);
					o=(WorkflowDTO)list1.get(0);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(o.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
				}else{
					w.setYwlcid(v_wfywlc.getYwlcid());
					dao.update(v_wfywlc);
					WorkflowDTO o=new WorkflowDTO();
					o.setYwbh(v_wfywlc.getYwbh());
					List list1=queryWfywlcnew(o);
					o=(WorkflowDTO)list1.get(0);
					f.setWfnodefzrid(DbUtils.getSequenceStr());
					f.setPsbh(v_wfywlc.getYwbh());
					f.setFzruserid(sysuser.getUserid());
					f.setNodeid("2");
					f.setCzyuserid(o.getYwlcid());
					f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
					dao.insert(f);
				}
			}else {
				dao.update(v_wfywlc);
				WorkflowDTO o=new WorkflowDTO();
				o.setYwbh(v_wfywlc.getYwbh());
				List list1=queryWfywlcnew(o);
				o=(WorkflowDTO)list1.get(0);
				f.setWfnodefzrid(DbUtils.getSequenceStr());
				f.setPsbh(v_wfywlc.getYwbh());
				f.setFzruserid(sysuser.getUserid());
				f.setNodeid("2");
				f.setCzyuserid(o.getYwlcid());
				f.setCzsj(SysmanageUtil.getDbtimeYmdHns());
				dao.insert(f);
			}
			WorkflowDTO wdto=new WorkflowDTO();
			wdto.setYwlcid(v_ywlcid);
			List list1=queryWfywlc(wdto);
			if(list1!=null&&list1.size()>0){
				wdto=(WorkflowDTO) list1.get(0);
				if("gwglswlc".equals(wdto.getYewumcpym())||"gwglfwlc".equals(wdto.getYewumcpym())){
					Wf_node_fzr  fzrnew=new Wf_node_fzr();
					fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
					fzrnew.setPsbh(v_wfywlc.getYwbh());
					SysuserDTO sdto2=new SysuserDTO();
					if(StringUtils.isEmpty(dto.getUserid())) {
						fzrnew.setFzruserid(sysuser.getUserid());
						sdto2.setUserid(sysuser.getUserid());
						listgw.add(sdto2);
					}else{
						fzrnew.setFzruserid(dto.getUserid());
						sdto2.setUserid(dto.getUserid());
						listgw.add(sdto2);
					}
					fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
					fzrnew.setCzyuserid(sysuser.getUserid());
					fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

					/*dao.insert(fzrnew);*/

					String ywlcuserid = request.getParameter("ywlcuserid");
					if(!StringUtils.isEmpty(ywlcuserid)) {
						String[] strArray = null;
						strArray = ywlcuserid.split(",");
						Wf_node_fzr fzr = new Wf_node_fzr();
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							if(!"分办".equals(v_transname)) {
								fzr.setCzyuserid(v_wfywlc.getYwlcid());
							}else{
								fzr.setCzyuserid(w.getYwlcid());
							}
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}
					if("gwglfwlc".equals(wdto.getYewumcpym())&&"核稿".equals(v_transname)){
						String cuserid = request.getParameter("cuserid");
						if(!StringUtils.isEmpty(cuserid)) {
							String[] strArray = null;
							strArray = cuserid.split(",");
							Wf_node_fzr fzr = new Wf_node_fzr();
							for (int i = 0; i < strArray.length; i++) {
								fzr.setWfnodefzrid(DbUtils.getSequenceStr());
								fzr.setPsbh(v_wfywlc.getYwbh());
								fzr.setFzruserid(strArray[i]);
								fzr.setNodeid("68");
								fzr.setCzyuserid(sysuser.getUserid());
								fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
								dao.insert(fzr);
							}
						}
					}
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("公文流转消息");
				}else{
					SysuserDTO sdto2=new SysuserDTO();
					if(StringUtils.isEmpty(dto.getUserid())) {
						sdto2.setUserid(sysuser.getUserid());
						listother.add(sdto2);
					}else{
						sdto2.setUserid(sysuser.getUserid());
						listother.add(sdto2);
					}
					json = JSONArray.fromObject(listother);
					jpushInfoDTO.setMessage("执法办案流转消息");
				}
			}
		}

		// 插入 业务流程日志表
		Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
		String id =  DbUtils.getSequenceStr();
		wf_ywlclog.setYwlclogid(id);
		wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
		wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
		wf_ywlclog.setSftzjd(v_sftzjd);
		wf_ywlclog.setYwbljg(v_shifouTongguo);
		wf_ywlclog.setNodeid(wfnode.getNodeid());
		wf_ywlclog.setNodepym(wfnode.getNodepym());//
		wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
		wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
		wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
		wf_ywlclog.setTransname(v_transname);
		wf_ywlclog.setTransyy(v_transyy);
		wf_ywlclog.setComdm(v_comdm);
		wf_ywlclog.setCommc(v_commc);
		wf_ywlclog.setAae011(sysuser.getDescription().toString());
		wf_ywlclog.setAae036(startTime);
		dao.insert(wf_ywlclog);

		// 插入节点对应的文书
		ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
		v_ZfajzfwsDTO.setAjdjid(v_wfywlc.getYwbh());
		v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
		v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
		v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

		wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

	/*	JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		jpushInfoDTO.setAccertuserid_rows("[{\"userid\":\"2018032211212513221228065\",\"username\":\"安阳市管理员\",\"bmmc\":\"河南省食药局\"}]");
		jpushInfoDTO.setMessage("公文流转消息");
		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);*/

		jpushInfoDTO.setAccertuserid_rows(json.toString());

		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);
		return id;
	}

	@Aop( { "trans" })
	public String doWfgongwenprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser sysuser = SysmanageUtil.getSysuser();
        if(sysuser==null){
            sysuser = SysmanageUtil.getSysuser(dto.getUserid());
        }
        String aaa027 = sysuser.getAaa027();

        String v_ywlcid = request.getParameter("ywlcid");// 业务流程表ID
        String v_transname = PubFunc.urlDecodeUTF(request
                .getParameter("transname"));// 分支节点流向名称
        String v_transval = PubFunc.urlDecodeUTF(request
                .getParameter("transval"));// 分支节点流向值
        String v_transyy = PubFunc
                .urlDecodeUTF(request.getParameter("transyy"));// 分支节点流向原因
        String v_shifouTongguo = request.getParameter("shifouTongguo");// 该节点操作是否通过
        String v_comdm = request.getParameter("comdm");//
        String v_commc = PubFunc.urlDecodeUTF(request.getParameter("commc"));//
        String v_sql = "";
        List<Object> listgw = new ArrayList<Object>();//公文流程的推送人
        List<Object> listother = new ArrayList<Object>();//非公文流程的推送人
        JSONArray json=null;
        JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
        // 获取业务流程
        Wf_ywlc v_wfywlc = dao.fetch(Wf_ywlc.class, v_ywlcid);
		Wf_ywlc w = new Wf_ywlc();
		Wf_node_fzr f = new Wf_node_fzr();
        // 获取业务流程的当前节点
        v_sql = "select a.* from Wf_node a where a.psbh = '"
                + v_wfywlc.getPsbh() + "' and a.nodeid = '"
                + v_wfywlc.getYwlccurnode() + "'";
        List wfnodeList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeList == null) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + v_wfywlc.getYwlccurnode()
                    + "】获取业务流程当前节点的Wf_node数据失败！");
        }
        Wf_node wfnode = (Wf_node) wfnodeList.get(0);

        // 获取业务流程的下一个节点
        if ("FORK_NODE".equals(wfnode.getNodetype())) {// 是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid()
                    + "'   and b.transname = '" + v_transname + "')";
        } else {// 不是分支节点
            v_sql = "select a.* from Wf_node a where a.psbh = '"
                    + wfnode.getPsbh()
                    + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                    + "  where b.psbh = '" + wfnode.getPsbh()
                    + "'   and b.transfrom = '" + wfnode.getNodeid() + "')";
        }
        List wfnodeNextList = (List) DbUtils.getDataList(v_sql, Wf_node.class);
        if (wfnodeNextList == null||wfnodeNextList.size()==0) {
            throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                    + "】，流程节点【" + wfnode.getNodeid()
                    + "】获取业务流程下一个节点的Wf_node数据失败！");
        }
        Wf_node v_wfnodeNext = (Wf_node) wfnodeNextList.get(0);

        while (true) {// 循环，一直取到需要处理的节点
            if ("0".equals(v_wfnodeNext.getNodecl())) {// 不需要处理
                // 获取下一个节点
                if ("FORK_NODE".equals(v_wfnodeNext.getNodetype())) {// 是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid()
                            + "'   and b.transname = '" + v_transname + "')";
                } else {// 不是分支节点
                    v_sql = "select a.* from Wf_node a where a.psbh = '"
                            + v_wfnodeNext.getPsbh()
                            + "'   and a.nodeid = (select b.transto from Wf_node_trans b "
                            + "  where b.psbh = '" + v_wfnodeNext.getPsbh()
                            + "'   and b.transfrom = '"
                            + v_wfnodeNext.getNodeid() + "')";
                }
                List ls = (List) DbUtils.getDataList(v_sql, Wf_node.class);
                if (ls == null) {
                    throw new BusinessException("根据工作流编号【" + v_wfywlc.getPsbh()
                            + "】，流程节点【" + v_wfnodeNext.getNodeid()
                            + "】获取业务流程下一个节点的Wf_node数据失败！");
                }
                v_wfnodeNext = (Wf_node) ls.get(0);
            } else {
                break;
            }
        }

        // 获取下一个节点的【时限开始时间、时限结束时间】
        String v_node_sx_begin = DateUtil.getCurYearMonthDay();
        String v_node_sx_end = "";
        String v_nodesx = StringHelper.showNull2Empty(v_wfnodeNext.getNodesx());
        if (!"".equals(v_nodesx)) {
            v_sql = "select fun_getNode_sx_end('" + v_node_sx_begin + "','"
                    + v_nodesx + "') as node_sx_end from dual";
            v_node_sx_end = DbUtils.getOneValue(dao, v_sql);
            if ("-1".equals(v_node_sx_end)) {
                throw new BusinessException("根据当前年月日【" + v_node_sx_begin
                        + "】和节点工作时限【" + v_nodesx + "】没有获取到时限结束时间，请检查工作日设置！");
            }
        }

        // 审核通过，更改业务流程的当前节点
        // 审核不通过，只插入业务流程日志表
        String v_ywlcjsbz = "0";// 未结束
        String v_ywlczcjsbz = "0";// 处理中
        String v_sftzjd = "1";// 是否跳转节点
        if ("END_NODE".equals(v_wfnodeNext.getNodetype())) {
            v_ywlcjsbz = "1";
            if ("0".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "2";// 非正常结束
            } else if ("1".equals(v_shifouTongguo)) {
                v_ywlczcjsbz = "1";// 正常结束
            }
        }

        if ("1".equals(v_shifouTongguo)) {
            // 更新业务流程表：将业务流程表的当前节点改为下一个节点
            v_wfywlc.setYwlccurnode(v_wfnodeNext.getNodeid());
            v_wfywlc.setNodesx(v_nodesx);
            if (!PubFunc.isNullStr(v_node_sx_begin)) {
                v_wfywlc.setNodesxbegin(new Timestamp(PubFunc
                        .getTime(v_node_sx_begin)));
            }
            if (!PubFunc.isNullStr(v_node_sx_end)) {
                v_wfywlc.setNodesxend(new Timestamp(PubFunc
                        .getTime(v_node_sx_end)));
            }
            v_wfywlc.setYwlcjsbz(v_ywlcjsbz);
            v_wfywlc.setYwlczcjsbz(v_ywlczcjsbz);
			if("提交处理意见".equals(v_transname)){
				//queryWfnodefzr
				WorkflowDTO fto=new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("3");
				List listhf=queryWfnodefzr(fto);
				if(listhf!=null&&listhf.size()>1){
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",sysuser.getUserid()).and("psbh", "=",v_wfywlc.getYwbh() ));
				}else{
					dao.update(v_wfywlc);
				}

			}else if("反馈任务".equals(v_transname)) {
				WorkflowDTO fto = new WorkflowDTO();
				fto.setPsbh(v_wfywlc.getYwbh());
				fto.setNodeid("2");
				List listha = queryWfnodefzr(fto);
				if (listha != null && listha.size() > 1) {
					dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=", sysuser.getUserid()).and("psbh", "=", v_wfywlc.getYwbh()));

					w.setYwlcid(DbUtils.getSequenceStr());
					w.setYwbh(v_wfywlc.getYwbh());
					w.setPsbh(v_wfywlc.getPsbh());
					w.setYwlccurnode(v_wfywlc.getYwlccurnode());
					w.setNodesxbegin(v_wfywlc.getNodesxbegin());
					w.setYwlcjsbz(v_wfywlc.getYwlcjsbz());
					w.setYwlczcjsbz(v_wfywlc.getYwlczcjsbz());
					w.setComdm(v_wfywlc.getComdm());
					w.setCommc(v_wfywlc.getCommc());
					w.setAaa027(v_wfywlc.getAaa027());
					w.setAae011(sysuser.getUserid());
					dao.insert(w);
				} else {
					w.setYwlcid(v_wfywlc.getYwlcid());
					v_wfywlc.setAae011(sysuser.getUserid());
					dao.update(v_wfywlc);
					dao.clear(Wf_ywlc.class, Cnd.where("aae011", "=", wfnode.getNodeid()).and("psbh", "=", "WF2018070400359"));
				}
				}else {
			dao.update(v_wfywlc);
		}




            WorkflowDTO wdto=new WorkflowDTO();
            wdto.setYwlcid(v_ywlcid);
            List list1=queryWfywlc(wdto);
            if(list1!=null&&list1.size()>0){
                wdto=(WorkflowDTO) list1.get(0);
                if("gzsblc".equals(wdto.getYewumcpym())){
                    Wf_node_fzr  fzrnew=new Wf_node_fzr();
                    fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
                    fzrnew.setPsbh(v_wfywlc.getYwbh());
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        fzrnew.setFzruserid(sysuser.getUserid());
                        sdto2.setUserid(sysuser.getUserid());
                        listgw.add(sdto2);
                    }else{
                        fzrnew.setFzruserid(dto.getUserid());
                        sdto2.setUserid(dto.getUserid());
                        listgw.add(sdto2);
                    }
                    fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
                    fzrnew.setCzyuserid(sysuser.getUserid());
                    fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

                    /*dao.insert(fzrnew);*/

                    String ywlcuserid = request.getParameter("ywlcuserid");
                    if(!StringUtils.isEmpty(ywlcuserid)) {
                        String[] strArray = null;
                        strArray = ywlcuserid.split(",");
                        Wf_node_fzr fzr = new Wf_node_fzr();
                        for (int i = 0; i < strArray.length; i++) {
                            fzr.setWfnodefzrid(DbUtils.getSequenceStr());
                            fzr.setPsbh(v_wfywlc.getYwbh());
                            fzr.setFzruserid(strArray[i]);
                            fzr.setNodeid(v_wfywlc.getYwlccurnode());
                            fzr.setCzyuserid(sysuser.getUserid());
                            fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(fzr);
                            SysuserDTO sdto3 = new SysuserDTO();
                            sdto3.setUserid(strArray[i]);
                            listgw.add(sdto3);
                        }
                    }
                    json = JSONArray.fromObject(listgw);
                    jpushInfoDTO.setMessage("工作上报流转消息");
                }else if("ayrw".equals(wdto.getYewumcpym())){
					Wf_node_fzr  fzrnew=new Wf_node_fzr();
					fzrnew.setWfnodefzrid(DbUtils.getSequenceStr());
					fzrnew.setPsbh(v_wfywlc.getYwbh());
					SysuserDTO sdto2=new SysuserDTO();
					if(StringUtils.isEmpty(dto.getUserid())) {
						fzrnew.setFzruserid(sysuser.getUserid());
						sdto2.setUserid(sysuser.getUserid());
						listgw.add(sdto2);
					}else{
						fzrnew.setFzruserid(dto.getUserid());
						sdto2.setUserid(dto.getUserid());
						listgw.add(sdto2);
					}
					fzrnew.setNodeid(v_wfywlc.getYwlccurnode());
					fzrnew.setCzyuserid(sysuser.getUserid());
					fzrnew.setCzsj(SysmanageUtil.getDbtimeYmdHns());

					/*dao.insert(fzrnew);*/

					String ywlcuserid = request.getParameter("ywlcuserid");
					if(!StringUtils.isEmpty(ywlcuserid)) {
						String[] strArray = null;
						strArray = ywlcuserid.split(",");
						Wf_node_fzr fzr = new Wf_node_fzr();
						for (int i = 0; i < strArray.length; i++) {
							fzr.setWfnodefzrid(DbUtils.getSequenceStr());
							fzr.setPsbh(v_wfywlc.getYwbh());
							fzr.setFzruserid(strArray[i]);
							fzr.setNodeid(v_wfywlc.getYwlccurnode());
							fzr.setCzyuserid(sysuser.getUserid());
							fzr.setCzsj(SysmanageUtil.getDbtimeYmdHns());
							dao.insert(fzr);
							SysuserDTO sdto3 = new SysuserDTO();
							sdto3.setUserid(strArray[i]);
							listgw.add(sdto3);
						}
					}
					json = JSONArray.fromObject(listgw);
					jpushInfoDTO.setMessage("工作任务流转消息");
				}else{
                    SysuserDTO sdto2=new SysuserDTO();
                    if(StringUtils.isEmpty(dto.getUserid())) {
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }else{
                        sdto2.setUserid(sysuser.getUserid());
                        listother.add(sdto2);
                    }
                    json = JSONArray.fromObject(listother);
                    jpushInfoDTO.setMessage("执法办案流转消息");
                }
            }
        }

        // 插入 业务流程日志表
        Wf_ywlclog wf_ywlclog = new Wf_ywlclog();
        String id =  DbUtils.getSequenceStr();
        wf_ywlclog.setYwlclogid(id);
        wf_ywlclog.setYwbh(v_wfywlc.getYwbh());
        wf_ywlclog.setPsbh(v_wfywlc.getPsbh());
        wf_ywlclog.setSftzjd(v_sftzjd);
        wf_ywlclog.setYwbljg(v_shifouTongguo);
        wf_ywlclog.setNodeid(wfnode.getNodeid());
        wf_ywlclog.setNodepym(wfnode.getNodepym());//
        wf_ywlclog.setNodesx(v_wfywlc.getNodesx());
        wf_ywlclog.setNodesxbegin(v_wfywlc.getNodesxbegin());
        wf_ywlclog.setNodesxend(v_wfywlc.getNodesxend());
        wf_ywlclog.setTransname(v_transname);
        wf_ywlclog.setTransyy(v_transyy);
        wf_ywlclog.setComdm(v_comdm);
        wf_ywlclog.setCommc(v_commc);
        wf_ywlclog.setAae011(sysuser.getDescription().toString());
        wf_ywlclog.setAae036(startTime);
        dao.insert(wf_ywlclog);

        // 插入节点对应的文书
        ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
        v_ZfajzfwsDTO.setAjdjid(v_wfywlc.getYwbh());
        v_ZfajzfwsDTO.setPsbh(v_wfywlc.getPsbh());
        v_ZfajzfwsDTO.setNodeid(v_wfnodeNext.getNodeid());
        v_ZfajzfwsDTO.setNodename(v_wfnodeNext.getNodename());

        wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);

        Timestamp endTime = SysmanageUtil.currentTime();
        SysmanageUtil.writeSysoperatelog(request, startTime, endTime);

	/*	JpushInfoDTO jpushInfoDTO = new JpushInfoDTO();
		jpushInfoDTO.setAccertuserid_rows("[{\"userid\":\"2018032211212513221228065\",\"username\":\"安阳市管理员\",\"bmmc\":\"河南省食药局\"}]");
		jpushInfoDTO.setMessage("公文流转消息");
		jpushInfoDTO.setTitle(v_wfywlc.getCommc());
		jpushInfoDTO.setType("1004");
		jpushInfoDTO.setUserid(dto.getUserid());
		jpushService.sendMessage(request, jpushInfoDTO);*/

        jpushInfoDTO.setAccertuserid_rows(json.toString());

        jpushInfoDTO.setTitle(v_wfywlc.getCommc());
        jpushInfoDTO.setType("1004");
        jpushInfoDTO.setUserid(dto.getUserid());
        jpushService.sendMessage(request, jpushInfoDTO);
        return id;
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
	/* 
	public Map queryWfywDaiban(WorkflowDTO dto, PagesDto pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.ywlcid,a.ywbh,a.ywlccurnode,a.nodesx,");
		sb.append("  a.nodesxbegin,a.nodesxend,'1' as sxzt,");
		sb.append("  b.psbh,b.psmc,c.nodeid,c.nodename,c.nodepym,c.nodeurl,c.fjcsdmlb,c.fjcsdlbh,a.comdm,a.commc ");
		sb.append("  from Wf_ywlc a,Wf_process b,Wf_node c,Wf_node_role d");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = b.psbh ");
		sb.append("   and a.psbh = c.psbh ");
		sb.append("   and a.psbh = d.psbh ");
		sb.append("   and a.ywlccurnode = c.nodeid ");
		sb.append("   and c.psbh = d.psbh ");
		sb.append("   and c.nodeid = d.nodeid ");
		sb.append("   and d.roleid in(select roleid from Sysuserrole e ");
		sb.append("    where e.userid =").append(sysuser.getUserid());
		sb.append(")");
		sb.append("   and a.ywlcid = :ywlcid ");
		sb.append("   and a.ywbh = :ywbh ");
		sb.append("   and a.ywlcjsbz = '0' ");
		sb.append("   and a.aaa027 =  ").append(sysuser.getAaa027());
		sb.append("   order by a.ywbh desc  ");

		String[] ParaName = new String[] { "ywlcid", "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println(sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}*/
	
	public Map queryWfywDaiban(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = null;
		String aaa027 = null;
		if(sysuser==null){
			userid = dto.getUserid();
			aaa027 = dto.getAaa027();
		}else{
			userid = sysuser.getUserid();
			aaa027 = sysuser.getAaa027();
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.ywlcid,a.ywbh,a.ywlccurnode,a.nodesx,");
		sb.append("  a.nodesxbegin,a.nodesxend,'1' as sxzt,");
		sb.append("  b.psbh,b.psmc,c.nodeid,c.nodename,c.nodepym,c.nodeurl,c.fjcsdmlb,c.fjcsdlbh,a.comdm,a.commc, ");
		sb.append("  (select max(e.yewumcpym) from wf_yewu_process e where e.psbh=b.psbh and e.aaa027=a.aaa027) yewumcpym");
		sb.append("  from Wf_ywlc a,Wf_process b,Wf_node c,Wf_node_userid d");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = b.psbh ");
		sb.append("   and a.psbh = c.psbh ");
		sb.append("   and a.psbh = d.psbh ");
		sb.append("   and a.ywlccurnode = c.nodeid ");
		sb.append("   and c.psbh = d.psbh ");
		sb.append("   and c.nodeid = d.nodeid ");
		sb.append("   and d.userid = '").append(userid).append("' ");
		sb.append("   and a.ywlcid = :ywlcid ");
		sb.append("   and a.ywbh = :ywbh ");
		sb.append("   and a.ywlcjsbz = '0' ");
		sb.append("   and a.aaa027 =  '").append(aaa027).append("' ");
		//gu20160930add 案件办理相关人员，才能看到这个案件
		sb.append("   and fun_ShiFouKeYiAnJianBanLi(a.ywlcid,'"+userid+"')='1' ");
		sb.append("   and a.commc!='工作任务' ");
		sb.append("   order by a.ywbh desc  ");

		String[] ParaName = new String[] { "ywlcid", "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println(sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		if(ls!=null&&ls.size()>0){
			for(int i=0;i<ls.size();i++){
				WorkflowDTO fdto=(WorkflowDTO) ls.get(i);
				if("WF2016062700303".equals(fdto.getPsbh())&&"/pub/egovernment/fwshMainIndex".equals(fdto.getNodeurl())){
					Egarchiveinfo info=dao.fetch(Egarchiveinfo.class, fdto.getYwbh());
					if("1".equals(info.getSwzbh())){
						fdto.setNodeurl("/pub/egovernment/fwsh1MainIndex");
					}else if("3".equals(info.getSwzbh())){
						fdto.setNodeurl("/pub/egovernment/fwsh2MainIndex");
					}
				}else if("WF2018070400359".equals(fdto.getPsbh())){
					WorkflowDTO b=new WorkflowDTO();
					b.setYwbh(fdto.getYwbh());
					List list1=queryR(b);
					List list2=queryr(b);
					List list3=querysw(b);
					String s1="";
					String s2="";
					String s3="";
					if(list1!=null&&list1.size()>0) {
						WorkflowDTO c = (WorkflowDTO) list1.get(0);
						if(c.getUserid()!=null) {
							s1 = c.getUserid();
						}
					}
					if(list2!=null&&list2.size()>0) {
						WorkflowDTO c = (WorkflowDTO) list2.get(0);
						if(c.getUserid()!=null) {
							s2 = c.getUserid();
						}
					}
					if(list3!=null&&list3.size()>0) {
						WorkflowDTO c = (WorkflowDTO) list3.get(0);
						if(c.getUserid()!=null) {
							s3 = c.getUserid();
						}
					}

					fdto.setAaa027name(s1+s2+s3);

				}

			}
		}
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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

	public Map queryWfywgongwenDaiban(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = null;
		String aaa027 = null;
		if(sysuser==null){
			userid = dto.getUserid();
			aaa027 = dto.getAaa027();
		}else{
			userid = sysuser.getUserid();
			aaa027 = sysuser.getAaa027();
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.ywlcid,a.ywbh,a.ywlccurnode,a.nodesx,");
		sb.append("  a.nodesxbegin,a.nodesxend,'1' as sxzt,");
		sb.append("  b.psbh,b.psmc,c.nodeid,c.nodename,c.nodepym,c.nodeurl,c.fjcsdmlb,c.fjcsdlbh,a.comdm,a.commc, ");
		sb.append("  (select max(e.yewumcpym) from wf_yewu_process e where e.psbh=b.psbh and e.aaa027=a.aaa027) yewumcpym");
		sb.append("  from Wf_ywlc a,Wf_process b,Wf_node c,Wf_node_userid d");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = b.psbh ");
		sb.append("   and a.psbh = c.psbh ");
		sb.append("   and a.psbh = d.psbh ");
		sb.append("   and a.ywlccurnode = c.nodeid ");
		sb.append("   and c.psbh = d.psbh ");
		sb.append("   and c.nodeid = d.nodeid ");
		sb.append("   and d.userid = '").append(userid).append("' ");
		sb.append("   and a.ywlcid = :ywlcid ");
		sb.append("   and a.ywbh = :ywbh ");
		sb.append("   and a.ywlcjsbz = '0' ");
		sb.append("   and a.aaa027 =  '").append(aaa027).append("' ");
		//gu20160930add 案件办理相关人员，才能看到这个案件
		sb.append("   and fun_ShiFouKeYiAnJianBanLi(a.ywlcid,'"+userid+"')='1' ");
		sb.append("   and a.commc='工作任务' ");
		sb.append("   order by a.ywbh desc  ");

		String[] ParaName = new String[] { "ywlcid", "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println(sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				WorkflowDTO.class, pd.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		if(ls!=null&&ls.size()>0){
			for(int i=0;i<ls.size();i++){
				WorkflowDTO fdto=(WorkflowDTO) ls.get(i);
				if("WF2016062700303".equals(fdto.getPsbh())&&"/pub/egovernment/fwshMainIndex".equals(fdto.getNodeurl())){
					Egarchiveinfo info=dao.fetch(Egarchiveinfo.class, fdto.getYwbh());
					if("1".equals(info.getSwzbh())){
						fdto.setNodeurl("/pub/egovernment/fwsh1MainIndex");
					}else if("3".equals(info.getSwzbh())){
						fdto.setNodeurl("/pub/egovernment/fwsh2MainIndex");
					}
				}else if("WF2018070400359".equals(fdto.getPsbh())){
					WorkflowDTO a=new WorkflowDTO();
					a.setYwlcid(fdto.getYwlcid());
					WorkflowDTO b=new WorkflowDTO();
					b.setYwbh(fdto.getYwbh());
					List list1=queryR(b);
					List list2=queryr(b);
					String s1="";
					String s2="";
					if(list1!=null&&list1.size()>0) {
						for (int j = 0; j < list1.size(); j++) {
							WorkflowDTO c = (WorkflowDTO) list1.get(j);
							if (!StringUtils.isEmpty(c.getUserid())) {
								if("".equals(s1)){
									s1 = c.getUserid() + "未阅";
								}else{
									s1 += ","+c.getUserid() + "未阅";
								}

							}
						}
					}
					if(list2!=null&&list2.size()>0) {
						for (int j = 0; j < list2.size(); j++) {
							WorkflowDTO c = (WorkflowDTO) list2.get(j);
							if (!StringUtils.isEmpty(c.getUserid())) {
								if("".equals(s2)){
									s2 = c.getUserid() + "未阅";
								}else{
									s2 += ","+c.getUserid() + "未阅";
								}
							}
						}
					}
				/*	fdto.setYwbh(s1+s2);*/

				}

			}
		}
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryYwlclog的中文名称：查询案件办理流程环节
	 *
	 * queryYwlclog的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public List queryWfywlc(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.*,");
		sb.append(" (select b.yewumcpym from wf_yewu_process b where b.psbh=a.psbh and b.aaa027=a.aaa027) yewumcpym");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywlcid=:ywlcid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywlcid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryWfywlcnew(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ywlcid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.psbh='WF2018070400359'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryWfnodefzr(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.fzruserid userid");
		sb.append(" FROM wf_node_fzr a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.psbh=:psbh");
		sb.append(" and a.nodeid=:nodeid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "psbh","nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}



	public List queryR(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ywlccurnode,GROUP_CONCAT(distinct(d.description)) userid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" LEFT JOIN (select c.psbh,c.nodeid,(select CONCAT(s.description,'未',w.nodename) from sysuser s where s.userid=c.fzruserid) description from ");
		sb.append(" wf_node_fzr c");
		sb.append(" left join wf_node w on w.nodeid=c.nodeid and w.psbh='WF2016062700303'");
		sb.append(" )d");
		sb.append(" ON d.psbh = a.ywbh and d.nodeid = a.ywlccurnode ");
		sb.append(" where 1=1");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.psbh = 'WF2016062700303'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryr(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ywlccurnode,GROUP_CONCAT(distinct(d.description)) userid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" LEFT JOIN (select c.psbh,c.nodeid,(select CONCAT(s.description,'未',w.nodename) from sysuser s where s.userid=c.fzruserid) description from ");
		sb.append(" wf_node_fzr c");
		sb.append(" left join wf_node w on w.nodeid=c.nodeid and w.psbh='WF2018051100356'");
		sb.append(" )d");
		sb.append(" ON d.psbh = a.ywbh and d.nodeid = a.ywlccurnode ");
		sb.append(" where 1=1");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.psbh = 'WF2018051100356'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List querysw(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ywlccurnode,GROUP_CONCAT(distinct(d.description)) userid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" LEFT JOIN (select c.psbh,c.nodeid,(select CONCAT(s.description,'未',w.nodename) from sysuser s where s.userid=c.fzruserid) description from ");
		sb.append(" wf_node_fzr c");
		sb.append(" left join wf_node w on w.nodeid=c.nodeid and w.psbh='WF2018070400358'");
		sb.append(" )d");
		sb.append(" ON d.psbh = a.ywbh and d.nodeid = a.ywlccurnode ");
		sb.append(" where 1=1");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.psbh = 'WF2018070400358'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}


	public List queryWfywlcuser(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.*");
		sb.append(" FROM wf_node_userid a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.psbh=:psbh");
		sb.append(" and a.nodeid=:nodeid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "psbh","nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryW1(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.*");
		sb.append(" FROM wf_ywlclog a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and (a.nodeid='38' or a.nodeid='46') ");
		sb.append(" order by a.nodeid asc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryW2(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.*");
		sb.append(" FROM wf_ywlclog a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and (a.nodeid='33' or a.nodeid='50') ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryW3(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.*");
		sb.append(" FROM wf_ywlclog a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.nodeid='3'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

    public List queryW4(WorkflowDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*");
        sb.append(" FROM wf_ywlclog a ");
        sb.append(" WHERE 1=1 ");
        sb.append(" and a.ywbh=:ywbh");
        sb.append(" and a.nodeid='2'");
        String sql = sb.toString();
        String[] ParaName = new String[] { "ywbh" };
        int[] ParaType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                WorkflowDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    public List queryW5(WorkflowDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*");
        sb.append(" FROM wf_ywlclog a ");
        sb.append(" WHERE 1=1 ");
        sb.append(" and a.ywbh=:ywbh");
        sb.append(" and a.nodeid='4'");
        String sql = sb.toString();
        String[] ParaName = new String[] { "ywbh" };
        int[] ParaType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                WorkflowDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    public List queryW6(WorkflowDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*");
        sb.append(" FROM wf_ywlclog a ");
        sb.append(" WHERE 1=1 ");
        sb.append(" and a.ywbh=:ywbh");
        sb.append(" and a.transname='主要领导审批'");
        String sql = sb.toString();
        String[] ParaName = new String[] { "ywbh" };
        int[] ParaType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                WorkflowDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

	public List queryW7(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.aae011,");
		sb.append(" (SELECT b.userid from sysuser b where b.description=a.aae011) userid");
		sb.append(" FROM wf_ywlclog a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh=:ywbh");
		sb.append(" and a.nodeid='1'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryW8(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.aae011,");
		sb.append(" (SELECT b.description from sysuser b where b.userid=a.aae011) userid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywlcid=:ywbh");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public String queryWfywlcid(String ywbh) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ywlcid");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh = '" +ywbh + "'");
		sb.append(" and a.psbh='WF2018070400359'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		WorkflowDTO dto=new WorkflowDTO();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String s="";
		if(ls!=null&&ls.size()>0){
			WorkflowDTO w=(WorkflowDTO)ls.get(0);
			 s=w.getYwlcid();
		}
		return s;
	}

	public List queryWfywlcdistinct(String ywbh) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT distinct(a.ywlccurnode)");
		sb.append(" FROM wf_ywlc a ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh = '" +ywbh + "'");
		sb.append(" and a.psbh='WF2018051100356'");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR};
		WorkflowDTO dto=new WorkflowDTO();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryWfywlcnbuser(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT b.userid as userid");
		sb.append(" from wf_ywlclog a ");
		sb.append(" left join sysuser b on a.aae011=b.DESCRIPTION ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.nodeid=:nodeid");
		sb.append(" and a.ywbh=:ywbh");
		String sql = sb.toString();
		String[] ParaName = new String[] { "nodeid","ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List queryWfywlcnbusernew(String ywbh) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT b.userposition as nodeid");
		sb.append(" from egarchiveinfo a ");
		sb.append(" left join sysuser b on a.archiveopperuserid=b.userid ");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.archiveid = '" +ywbh + "'");
		String sql = sb.toString();
		String[] ParaName = new String[] {"ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR };
		WorkflowDTO dto=new WorkflowDTO();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * queryYwlclog的中文名称：查询案件办理流程环节
	 * 
	 * queryYwlclog的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Map queryYwlclog(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		//left join fj f on f.fjwid=a.ywlclogid
		sb.append(" SELECT a.ywlclogid,a.ywbh,a.ywbljg,a.psbh,a.nodeid,a.nodepym,a.sftzjd,");
		sb.append(" a.nodesx,a.nodesxbegin,a.nodesxend,a.transname,a.transyy,a.aae011,a.aae036,");
		sb.append(" ifnull((select f.fjpath from fj f where f.fjwid=a.ywlclogid),'') fjpath,");
		sb.append(" a.aae013,b.nodename,c.psmc,d.comdm,d.commc");
		sb.append(" FROM wf_ywlclog a,wf_node b,wf_process c,wf_ywlc d ");
		sb.append(" WHERE a.nodeid=b.nodeid AND a.psbh=b.psbh AND a.psbh=c.psbh ");
		sb.append(" and a.psbh=d.psbh and a.ywbh=d.ywbh ");
		sb.append(" and a.ywbh = :ywbh");
		sb.append(" order by a.aae036 desc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh" };
		int[] ParaType = new int[] { Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class, pd.getPage(),pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	public Map queryYwlclogDto(WorkflowDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.transyy,f.fjpath");
		sb.append(" FROM wf_ywlclog a");
		sb.append(" left join fj f on f.fjwid=a.ywlclogid");
		sb.append(" WHERE 1=1 ");
		sb.append(" and a.ywbh = :ywbh");
		sb.append(" and a.nodeid = :nodeid");
		sb.append(" order by a.aae036 desc limit 1 ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ywbh","nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR ,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				WorkflowDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		return r;
	}

    public Map FJ(FjDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.fjpath,fjname");
        sb.append(" FROM fj a");
        sb.append(" WHERE 1=1 ");
        sb.append(" and a.fjwid = :fjwid");
		sb.append(" and a.fjtype = :fjtype");
		sb.append(" and a.fjuserid = :fjuserid");
        String sql = sb.toString();
        String[] ParaName = new String[] { "fjwid","fjtype","fjuserid" };
        int[] ParaType = new int[] { Types.VARCHAR ,Types.VARCHAR,Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                FjDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        return r;
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
	public Map queryWfnodeWsgl(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select zfajzfwsnodeid,zfwsdmz,fjcsdmmc as zfwsdmmc");
		sb.append(" from Viewzfajzfws a,Zfajzfwsnode b");
		sb.append(" where 1=1 ");
		sb.append("   and b.zfwsdmz = a.fjcsdmz");
		sb.append("   and b.psbh = :psbh");
		sb.append("   and b.nodeid = :nodeid");

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd
				.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public Map queryWfnodeWsglNo(WorkflowDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjcsdmz as zfwsdmz,fjcsdmmc as zfwsdmmc");
		sb.append(" from Viewzfajzfws a");
		sb.append(" where 1=1 ");
		sb.append("   and not exists (select 1");
		sb.append("   				from Zfajzfwsnode b");
		sb.append("  				where b.zfwsdmz = a.fjcsdmz");
		sb.append("    				  and b.psbh = :psbh ) ");
		// gu20160511 sb.append("    				  and b.nodeid = :nodeid)");

		String[] ParaName = new String[] { "psbh" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd
				.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public String addWfnodeWsgl(HttpServletRequest request, WorkflowDTO dto) {
		try {
			addWfnodeWsglImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addWfnodeWsglImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		String psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
		String nodeid = StringHelper.showNull2Empty(request
				.getParameter("nodeid"));
		if ("".equals(psbh) || "".equals(nodeid)) {
			throw new BusinessException("工作流编号、工作流节点ID不能为空！");
		}
		//String JsonStr = request.getParameter("JsonStr"); gu20171217
		String JsonStr = dto.getMygridrows(); 
		List<Zfajzfwsnode> ls = Json
				.fromJsonAsList(Zfajzfwsnode.class, JsonStr);
		for (Zfajzfwsnode zfajzfwsnode : ls) {
			Zfajzfwsnode wfnodewsgl = new Zfajzfwsnode();
			wfnodewsgl.setZfajzfwsnodeid(DbUtils.getSequenceStr());
			wfnodewsgl.setPsbh(psbh);
			wfnodewsgl.setNodeid(nodeid);
			wfnodewsgl.setZfwsdmz(zfajzfwsnode.getZfwsdmz());
			dao.insert(wfnodewsgl);
		}
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public String delWfnodeWsgl(HttpServletRequest request, WorkflowDTO dto) {
		try {
			delWfnodeWsglImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delWfnodeWsglImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		// 删除执法案件执法文书和流程节点对照表
		dao.delete(Zfajzfwsnode.class, dto.getZfajzfwsnodeid());
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}
	
	/**
	 * 
	 * queryWfnodeUserid的中文名称：查询
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
	public Map queryWfnodeUserid(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		//orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.psbh,a.nodeid,a.nodename,a.nodetype,");
		sb.append(" a.nodesx,a.nodeurl,b.userid,b.nodeuserid,");
		sb.append(" c.description,d.orgname ");
		sb.append(" from Wf_node a,Wf_node_userid b,Sysuser c,Sysorg d ");
		sb.append(" where 1=1 ");
		sb.append("   and a.psbh = b.psbh  ");
		sb.append("   and a.nodeid = b.nodeid ");
		sb.append("   and b.userid = c.userid ");
		sb.append("   and c.orgid = d.orgid ");
		sb.append("   and a.psbh = :psbh");
		sb.append("   and a.nodeid = :nodeid");
		if ("0".equals(userid)) {// 超级管理员
			//
		} else {
			sb.append(" and d.orgcode like '").append(orgcode).append("%'");
		}

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd
				.getPage(), pd.getPageSize());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryWfnodeNoUserid的中文名称：查询工作流节点没有绑定的操作员Id
	 * 
	 * queryWfnodeNoUserid的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public Map queryWfnodeNoUserid(WorkflowDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		//orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		if ("0".equals(userid)) {// 超级管理员
			sb.append(" select userid,username,description,b.orgname");
			sb.append(" from sysuser a,sysorg b ");
			sb.append(" where a.orgid=b.orgid and a.userkind<>'6' ");
			if (dto.getUsername()!=null && !"".equals(dto.getUsername())){
				sb.append(" and (a.username like '%"+dto.getUsername()+"%' or a.description like '%"+
			   dto.getUsername()+"%' or a.MOBILE like '%"+dto.getUsername()+
			   "%' or a.mobile2 like '%"+dto.getUsername()+"%') ");
			}
			sb.append(" and not exists (select t.userid from wf_node_userid t where t.userid=a.userid ");
			sb.append(" and t.psbh=:psbh ");
			sb.append(" and t.nodeid=:nodeid ");
			sb.append(") ");
		} else {
			sb.append(" select userid,username,description,t.orgname");
			sb.append(" from sysuser a,sysorg t ");
			sb.append(" where a.orgid=t.orgid ");
			sb.append("   and a.userkind<>'6' ");
			sb.append("   and t.orgcode like '"+orgcode+"%' ");
			if (dto.getUsername()!=null && !"".equals(dto.getUsername())){
				sb.append(" and (a.username like '%"+dto.getUsername()+"%' or a.description like '%"+
			   dto.getUsername()+"%' or a.MOBILE like '%"+dto.getUsername()+
			   "%' or a.mobile2 like '%"+dto.getUsername()+"%') ");
			}			
			sb.append(" and not exists (select t.userid from wf_node_userid t where t.userid=a.userid ");
			sb.append(" and t.psbh=:psbh ");
			sb.append(" and t.nodeid=:nodeid ");
			sb.append(") ");			
		}

		String[] ParaName = new String[] { "psbh", "nodeid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println(sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				Sysuser.class, pd.getPage(), pd.getPageSize());

		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	public String addWfnodeUserid(HttpServletRequest request, WorkflowDTO dto) {
		try {
			addWfnodeUseridImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addWfnodeUseridImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		String psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
		String nodeid = StringHelper.showNull2Empty(request
				.getParameter("nodeid"));
		if ("".equals(psbh) || "".equals(nodeid)) {
			throw new BusinessException("工作流编号、工作流节点ID不能为空！");
		}
		//String JsonStr = request.getParameter("JsonStr");
		String JsonStr = dto.getUserrows();
		List<Sysuser> ls = Json.fromJsonAsList(Sysuser.class, JsonStr);
		for (Sysuser sysuser : ls) {
			Wf_node_userid v_Wf_node_userid = new Wf_node_userid();
			v_Wf_node_userid.setNodeuserid(DbUtils.getSequenceStr());
			v_Wf_node_userid.setNodeid(nodeid);
			v_Wf_node_userid.setPsbh(psbh);
			v_Wf_node_userid.setUserid(sysuser.getUserid());  
			dao.insert(v_Wf_node_userid);
		}
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}	
	
	/**
	 * 
	 * delWfnodeRole的中文名称：删除工作流节点权限
	 * 
	 * delWfnodeRole的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delWfnodeUserid(HttpServletRequest request, WorkflowDTO dto) {
		try {
			delWfnodeUseridImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delWfnodeUseridImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		// 删除工作流角色表
		String JsonStr = request.getParameter("JsonStr");
		System.out.println("JsonStr"+JsonStr);
		List<Wf_node_userid> ls = Json.fromJsonAsList(Wf_node_userid.class, JsonStr);
		for (Wf_node_userid mybean : ls) {
			dao.delete(Wf_node_userid.class, mybean.getNodeuserid());
		}
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}	
	
	/**
	 * 
	 * huituiWfprocess的中文名称：通用操作,回退工作流到上一步
	 * 
	 * huituiWfprocess的概要说明：工作流待办业务
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String huituiWfprocess(HttpServletRequest request, WorkflowDTO dto) {
		try {
			huituiWfprocessImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void huituiWfprocessImp(HttpServletRequest request, WorkflowDTO dto)
			throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Sysuser sysuser = SysmanageUtil.getSysuser();
		if(sysuser==null){
			sysuser = SysmanageUtil.getSysuser(dto.getUserid());
		}
		String aaa027 = sysuser.getAaa027();
		//回退思路
		int v_count=0;
		Sql mysql = Sqls.create("");
		//String v_sql="SELECT COUNT(*) AS aa FROM wf_ywlclog wy "+
		String v_sql=" wf_ywlclog wy "+
		   " WHERE wy.psbh='"+dto.getPsbh()+"' AND wy.ywbh='"+dto.getYwbh()+"'";
		v_count=dao.count(v_sql);
		if (v_count==1){//回退到受理
			v_sql="update zfajdj set slbz='0' where ajdjid='"+dto.getYwbh()+"'";
			mysql = Sqls.create(v_sql);
			dao.execute(mysql);
			
			v_sql="delete a from wf_ywlclog a WHERE a.psbh='"+dto.getPsbh()+"' AND a.ywbh='"+dto.getYwbh()+"'";
			mysql= Sqls.create(v_sql);
			dao.execute(mysql);	
			
			v_sql="delete a from wf_ywlc a WHERE a.psbh='"+dto.getPsbh()+"' AND a.ywbh='"+dto.getYwbh()+"'";
			mysql= Sqls.create(v_sql);
			dao.execute(mysql);				
		}else if (v_count>1){//回退到上一步
			//获取wf_ywlclog表最大记录
			v_sql="select a.* from wf_ywlclog a WHERE a.psbh='"+dto.getPsbh()+
					"' AND a.ywbh='"+dto.getYwbh()+"' and a.ywlclogid=(select max(b.ywlclogid) from wf_ywlclog b where b.psbh='"+
					dto.getPsbh()+"' and b.ywbh='"+dto.getYwbh()+"')";
			List<Wf_ywlclog> v_wf_ywlcloglist=(List<Wf_ywlclog>)DbUtils.getDataList(v_sql,Wf_ywlclog.class);			
			if (v_wf_ywlcloglist.size()>0){
				Wf_ywlclog v_Wf_ywlclog=(Wf_ywlclog)v_wf_ywlcloglist.get(0);
				Wf_node v_wf_node=dao.fetch(Wf_node.class, Cnd.where("psbh", "=", dto.getPsbh()).and("nodeid", "=", v_Wf_ywlclog.getNodeid()));
				//根据节点拼音码 对一些节点 进行特殊的回退操作
//				if ("".equals(v_wf_node.getNodepym())){
//					
//				}
				//把当前节点改下
				v_sql="update wf_ywlc a set a.ywlccurnode='"+v_Wf_ywlclog.getNodeid()
						+"',nodesx='"+v_Wf_ywlclog.getNodesx()+"',";
						if (v_Wf_ywlclog.getNodesxbegin()!=null){
							v_sql+="nodesxbegin='"+v_Wf_ywlclog.getNodesxbegin()+"',";			
						}else{
							v_sql+="nodesxbegin="+v_Wf_ywlclog.getNodesxbegin()+",";
						};
						if (v_Wf_ywlclog.getNodesxend()!=null){
							v_sql+="nodesxend='"+v_Wf_ywlclog.getNodesxend()+"' ";			
						}else{
							v_sql+="nodesxend="+v_Wf_ywlclog.getNodesxend();
						};						
						//"',nodesxbegin="+v_Wf_ywlclog.getNodesxbegin()+
						//",nodesxend="+v_Wf_ywlclog.getNodesxend()+
						v_sql+=" WHERE a.psbh='"+dto.getPsbh()+
						"' AND a.ywbh='"+dto.getYwbh()+"'";
				mysql= Sqls.create(v_sql);
				dao.execute(mysql);	
				
				//把log信息删除
				v_sql="delete a from  wf_ywlclog a where a.ywlclogid='"+
						v_Wf_ywlclog.getYwlclogid()+"'";
				mysql= Sqls.create(v_sql);
				dao.execute(mysql);					
			}
			
		}
	}
	
	/**
	 * 
	 * querySysuserHaveAaa027Grant的中文名称：查询操作员【已授权】的统筹区
	 * 
	 * querySysuserHaveAaa027Grant的概要说明：
	 * 
	 * @param roleid
	 * @return Written by : zjf
	 * 
	 */
	public List queryUserHavedNode(@Param("..") Wf_node_userid dto) {
		return dao.query(Wf_node_userid.class, 
				Cnd.where("userid", "=", dto.getUserid()).and("psbh", "=",dto.getPsbh()));
	}	
	
	/**
	 * 
	 * saveUserHavedNode的中文名称：统筹区授权【保存】
	 * 
	 * saveUserHavedNode的概要说明：
	 * 
	 * @param roleid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	public String saveUserHavedNode(HttpServletRequest request, 
			final String userid,final String psbh, final List fid) {
		try {
			saveUserHavedNodeImp(request, userid,psbh, fid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveUserHavedNodeImp(HttpServletRequest request, final String userid,final String psbh, final List fid) throws Exception {
		// 删除该角色所有权限
		dao.clear(Wf_node_userid.class, Cnd.where("userid", "=", userid).and("psbh", "=", psbh));

		if (fid != null) {
			// 插入提交的权限
			Iterator it = fid.iterator();
			while (it.hasNext()) {
				Wf_node_userid s = new Wf_node_userid();
				String nodeuserid = DbUtils.getSequenceStr();
				s.setNodeuserid(nodeuserid);
				s.setPsbh(psbh);
				s.setUserid(userid);
				s.setNodeid(String.valueOf(it.next()));
				dao.insert(s);
			}
		}
	}

	public String delWfywlc(HttpServletRequest request,WorkflowDTO dto) {
		try {
			delWfywlcImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void delWfywlcImp(HttpServletRequest request, WorkflowDTO dto) throws Exception {
		// 删除工作流
		dao.clear(Wf_ywlc.class, Cnd.where("ywbh", "=", dto.getYwbh()));
	}

	public String delWfnodezr(HttpServletRequest request,WorkflowDTO dto) {
		try {
			delWfnodezrImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void delWfnodezrImp(HttpServletRequest request, WorkflowDTO dto) throws Exception {
		// 删除工作流权限
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		dao.clear(Wf_node_fzr.class, Cnd.where("fzruserid", "=",vSysUser.getUserid() ).and("psbh", "=", dto.getYwbh()));
		Wf_ywlc w=dao.fetch(Wf_ywlc.class,dto.getYwlcid());
		WorkflowDTO f=new WorkflowDTO();
		f.setYwbh(w.getYwbh());
		f.setNodeid(w.getYwlccurnode());
        List ls=queryWfnode(f);
        if(ls!=null&&ls.size()==1){
            dao.clear(Wf_ywlc.class, Cnd.where("ywbh", "=",dto.getYwbh() ).and("psbh", "=", "WF2018070400359"));
        }
	}


    public List queryWfnode(WorkflowDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.nodeid");
        sb.append(" FROM wf_node_fzr a ");
        sb.append(" WHERE 1=1 ");
        sb.append(" and a.psbh =:ywbh");
        sb.append(" and a.nodeid=:nodeid");
        String sql = sb.toString();
        String[] ParaName = new String[] { "ywbh","nodeid" };
        int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                WorkflowDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }





}
