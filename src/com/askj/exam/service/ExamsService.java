package com.askj.exam.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.askj.exam.dto.OtsExamUserDTO;
import com.askj.exam.dto.OtsExamsDataDTO;
import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.exam.dto.OtsExamsMateDTO;
import com.askj.exam.dto.OtsResultMateDTO;
import com.askj.exam.entity.OtsExamUser;
import com.askj.exam.entity.OtsExamsData;
import com.askj.exam.entity.OtsExamsInfo;
import com.askj.exam.entity.OtsExamsMate;
import com.askj.exam.entity.OtsExamsPapers;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  ExamsService的中文名称：考试子系统-考试管理
 *
 *  ExamsService的描述：
 *
 *  @author  : zy
 */
@IocBean
public class ExamsService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(ExamsService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryExamInfos的中文名称：查询考试列表
	 * 
	 * queryExamInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamInfos(HttpServletRequest request, OtsExamsInfoDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.exams_info_id, info.exams_info_state, info.exams_info_name, ");
		sb.append(" (SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = info.aae011) aae011, ");
		sb.append(" info.aae036 ");
		sb.append(" FROM ots_exams_info info ");
		sb.append(" where 1=1 ");
		sb.append(" and info.exams_info_state = :examsInfoState "); // 考试状态
		sb.append(" and info.exams_info_name like :examsInfoName "); // 考试名称
		sb.append(" order by exams_info_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "examsInfoState", "examsInfoName" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamsInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * saveExamInfo的中文名称：保存考试信息（考试功能信息）
	 * 
	 * saveExamInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveExamInfo(HttpServletRequest request, OtsExamsMateDTO dto) {
		try {
			saveExamInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveExamInfoImp的中文名称：保存试卷方法实现
	 * 
	 * saveExamInfoImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveExamInfoImp(HttpServletRequest request, OtsExamsMateDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		String v_infoId =  (dto.getExamsInfoId() != null && !"".equals(dto.getExamsInfoId())) ? 
			 dto.getExamsInfoId() : DbUtils.getSequenceStr(); // 考试信息id
			 
		// 对考试数据信息先删除，再保存
		// 删除考试数据信息
		dao.clear(OtsExamsData.class, Cnd.where("exams_info_id", "=", v_infoId));
		// 保存考试数据信息
		JSONArray arr = JSONArray.fromObject(dto.getExamPapers());
		Object[] v_objArray  = arr.toArray();
		if (v_objArray.length > 0) {
			for (int i = 0; i < v_objArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
				// 考试数据表保存
				OtsExamsData v_data = new OtsExamsData();
				v_data.setExamsDataId(DbUtils.getSequenceStr()); // 考试数据id
				v_data.setPaperInfoId(v_obj.getString("paperInfoId")); // 关联试卷ID
				v_data.setExamsInfoId(v_infoId); // 关联考试信息ID
				v_data.setExamsDataSort(Integer.toString(i + 1)); // 当前结构在整体的位置
				v_data.setAae011(vSysUser.getUserid()); // 经办人
				v_data.setAae036(v_dbDatetime); // 经办时间
				dao.insert(v_data);
			}
		}
		// 对考试保存（考试信息/考试功能信息）
		// 如果id存在，更新
		if (dto.getExamsInfoId() != null && !"".equals(dto.getExamsInfoId())) {
			// 考试信息
			OtsExamsInfo v_info = dao.fetch(OtsExamsInfo.class, dto.getExamsInfoId());
			v_info.setExamsInfoState(dto.getExamsInfoState()); // 考试状态,0=禁用,1=启用
			v_info.setExamsInfoName(dto.getExamsName()); // 考试名称
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			dao.update(v_info); // 更新
			
			// 考试功能信息
			OtsExamsMate v_mate = dao.fetch(OtsExamsMate.class, dto.getExamsInfoId());
			v_mate.setAllowIp(dto.getAllowIp()); // 限制学习ip段
			v_mate.setCoverImg(dto.getCoverImg()); // 考试封面
			v_mate.setCredit(dto.getCredit()); // 考试所需金额
			v_mate.setDisableExam(dto.getDisableExam()); // 禁止进入考场时间(m),0=不限制
			v_mate.setDisablesubmit(dto.getDisablesubmit()); // 禁止提前交卷时间
			v_mate.setDuration(dto.getDuration()); // 考试限时
			v_mate.setEndTime(dto.getEndTime()); // 结束时间
			v_mate.setExamManual(dto.getExamManual()); // 是否需要人工评卷
			v_mate.setExamMode(dto.getExamMode()); // 考试方式 1=整卷 2=逐题
			v_mate.setExamModeAnswer(dto.getExamModeAnswer()); // 逐题查看答案
			v_mate.setExamModePrev(dto.getExamModePrev()); // 逐题模式，是否允许查看上一题
			v_mate.setExamsCategory(dto.getExamsCategory()); // 考试分类
			v_mate.setExamsName(dto.getExamsName()); // 考试名称
			v_mate.setExamsNotice(dto.getExamsNotice()); // 考试须知
			v_mate.setExamsType(dto.getExamsType()); // 考试类型 0=练习 1=考试
			v_mate.setExamWay(dto.getExamWay()); // 考试方式（线上/线下）
			v_mate.setIsAntiCheat(dto.getIsAntiCheat()); // 是否防作弊 0=否 1=是
			v_mate.setIsDisableUserInfo(dto.getIsDisableUserInfo()); // 评卷时是否屏蔽考生信息
			v_mate.setIsListShow(dto.getIsListShow()); // 是否在考试列表中显示
			v_mate.setIsQuestionsRandom(dto.getIsQuestionsRandom()); // 是否随机显示试题
			v_mate.setIsResultRank(dto.getIsResultRank()); // 是否显示排行榜
			v_mate.setIsSurveillance(dto.getIsSurveillance()); // 是否启用考试监控
			v_mate.setMaxTimes(dto.getMaxTimes()); // 最大监考次数
			v_mate.setNoAll(dto.getNoAll()); // 禁止右键，剪切等
			v_mate.setOfflinePass(dto.getOfflinePass()); // 线下及格分
			v_mate.setOfflineScore(dto.getOfflineScore()); // 线下总分
			v_mate.setPublishAnswerFlg(dto.getPublishAnswerFlg()); // 是否允许考生查看答案
			v_mate.setResultPublishTime(dto.getResultPublishTime()); // 考试结果发布时间
			v_mate.setSignUpEndTime(dto.getSignUpEndTime()); // 报名结束时间
			v_mate.setSignUpStartTime(dto.getSignUpStartTime()); // 报名起始时间
			v_mate.setStartTime(dto.getStartTime()); // 开始时间
			v_mate.setUnityDuration(dto.getUnityDuration()); // 统一考试时间
			v_mate.setUnityPoint(dto.getUnityPoint()); // 统一总分
			v_mate.setUnPass(dto.getUnPass()); // 及格后不能再考
			v_mate.setAae011(vSysUser.getUserid()); // 经办人
			v_mate.setAae036(v_dbDatetime); // 经办时间
			dao.update(v_mate); // 更新
		} else {
			// 试题对象
			OtsExamsInfo v_info = new OtsExamsInfo();
			v_info.setExamsInfoId(v_infoId); // 考试信息id
			v_info.setExamsInfoState(dto.getExamsInfoState()); // 考试状态,0=禁用,1=启用
			v_info.setExamsInfoName(dto.getExamsName()); // 考试名称
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			dao.insert(v_info); // 保存
			
			// 考试功能信息
			OtsExamsMate v_mate = new OtsExamsMate();
			v_mate.setExamsInfoId(v_infoId); // 关联考试信息ID
			v_mate.setAllowIp(dto.getAllowIp()); // 限制学习ip段
			v_mate.setCoverImg(dto.getCoverImg()); // 考试封面
			v_mate.setCredit(dto.getCredit()); // 考试所需金额
			v_mate.setDisableExam(dto.getDisableExam()); // 禁止进入考场时间(m),0=不限制
			v_mate.setDisablesubmit(dto.getDisablesubmit()); // 禁止提前交卷时间
			v_mate.setDuration(dto.getDuration()); // 考试限时
			v_mate.setEndTime(dto.getEndTime()); // 结束时间
			v_mate.setExamManual(dto.getExamManual()); // 是否需要人工评卷
			v_mate.setExamMode(dto.getExamMode()); // 考试方式 1=整卷 2=逐题
			v_mate.setExamModeAnswer(dto.getExamModeAnswer()); // 逐题查看答案
			v_mate.setExamModePrev(dto.getExamModePrev()); // 逐题模式，是否允许查看上一题
			v_mate.setExamsCategory(dto.getExamsCategory()); // 考试分类
			v_mate.setExamsName(dto.getExamsName()); // 考试名称
			v_mate.setExamsNotice(dto.getExamsNotice()); // 考试须知
			v_mate.setExamsType(dto.getExamsType()); // 考试类型 0=练习 1=考试
			v_mate.setExamWay(dto.getExamWay()); // 考试方式（线上/线下）
			v_mate.setIsAntiCheat(dto.getIsAntiCheat()); // 是否防作弊 0=否 1=是
			v_mate.setIsDisableUserInfo(dto.getIsDisableUserInfo()); // 评卷时是否屏蔽考生信息
			v_mate.setIsListShow(dto.getIsListShow()); // 是否在考试列表中显示
			v_mate.setIsQuestionsRandom(dto.getIsQuestionsRandom()); // 是否随机显示试题
			v_mate.setIsResultRank(dto.getIsResultRank()); // 是否显示排行榜
			v_mate.setIsSurveillance(dto.getIsSurveillance()); // 是否启用考试监控
			v_mate.setMaxTimes(dto.getMaxTimes()); // 最大监考次数
			v_mate.setNoAll(dto.getNoAll()); // 禁止右键，剪切等
			v_mate.setOfflinePass(dto.getOfflinePass()); // 线下及格分
			v_mate.setOfflineScore(dto.getOfflineScore()); // 线下总分
			v_mate.setPublishAnswerFlg(dto.getPublishAnswerFlg()); // 是否允许考生查看答案
			v_mate.setResultPublishTime(dto.getResultPublishTime()); // 考试结果发布时间
			v_mate.setSignUpEndTime(dto.getSignUpEndTime()); // 报名结束时间
			v_mate.setSignUpStartTime(dto.getSignUpStartTime()); // 报名起始时间
			v_mate.setStartTime(dto.getStartTime()); // 开始时间
			v_mate.setUnityDuration(dto.getUnityDuration()); // 统一考试时间
			v_mate.setUnityPoint(dto.getUnityPoint()); // 统一总分
			v_mate.setUnPass(dto.getUnPass()); // 及格后不能再考
			v_mate.setAae011(vSysUser.getUserid()); // 经办人
			v_mate.setAae036(v_dbDatetime); // 经办时间
			dao.insert(v_mate); // 更新
		}
	}
	
	/**
	 * 
	 * queryExamInfoObj的中文名称：查询考试信息
	 * 
	 * queryExamInfoObj的概要说明：考试基本信息、考试功能信息、考试所包含试卷信息
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamInfoObj(HttpServletRequest request, OtsExamsInfoDTO dto) throws Exception {
		// 考试信息
		OtsExamsInfo examInfo = dao.fetch(OtsExamsInfo.class, dto.getExamsInfoId());
		// 考试功能信息
		OtsExamsMate examMate = dao.fetch(OtsExamsMate.class, dto.getExamsInfoId());
		Map map = new HashMap();
		map.put("examInfo", examInfo); // 考试功能信息
		map.put("examMate", examMate); // 考试功能信息
		return map;
	}
	
	/**
	 * 
	 * delExamInfos的中文名称：删除考试信息
	 * 
	 * delExamInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	public String delExamInfos(HttpServletRequest request) {
		try {
			delExamInfosImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delExamInfosImp的中文名称：删除考试信息方法实现
	 * 
	 * delExamInfosImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delExamInfosImp(HttpServletRequest request) throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<OtsExamsInfoDTO> infoList = Json.fromJsonAsList(OtsExamsInfoDTO.class, JsonStr);
		for (int i = 0; i < infoList.size(); i++) {
			OtsExamsInfoDTO info = (OtsExamsInfoDTO) infoList.get(i);
			// 删除考试信息
			dao.clear(OtsExamsInfo.class, Cnd.where("exams_info_id", "=", info.getExamsInfoId()));
			// 删除考试数据表
			dao.clear(OtsExamsData.class, Cnd.where("exams_info_id", "=", info.getExamsInfoId()));
			// 删除考试功能信息表
			dao.clear(OtsExamsMate.class, Cnd.where("exams_info_id", "=", info.getExamsInfoId()));
			// 删除考试缓存试卷表
			dao.clear(OtsExamsPapers.class, Cnd.where("exams_info_id", "=", info.getExamsInfoId()));
		}
	}
	
	/**
	 * 
	 * queryExamPapers的中文名称：查询试卷所包含试卷信息
	 * 
	 * queryExamPapers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamPapers(HttpServletRequest request, OtsExamsInfoDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.exams_data_id, a.exams_info_id, a.paper_info_id, ");
		sb.append(" a.exams_data_sort, a.aae011, a.aae036, ");
		sb.append(" b.paper_info_state, b.paper_info_pass, b.paper_info_name, ");
		sb.append(" SUM(c.qsn_info_point) points, COUNT(c.qsn_info_point) total "); // 试卷分数，与试题总数
		sb.append(" FROM ots_exams_data a, ots_papers_info b, ots_paper_content c ");
		sb.append(" where 1=1 ");
		sb.append(" and b.paper_info_state = '1' "); // 试卷状态,0=禁用,1=启用
		sb.append(" and a.paper_info_id = b.paper_info_id "); 
		sb.append(" and b.paper_info_id = c.paper_info_id "); 
		if (dto.getExamsInfoId() != null && !"".equals(dto.getExamsInfoId())) {
			sb.append(" and a.exams_info_id = :examsInfoId "); 
		}
		sb.append(" GROUP BY a.paper_info_id ");
		sb.append(" order by paper_info_id desc ");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "examsInfoId" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamsDataDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryExamUsers的中文名称：查询考试用户关系
	 * 
	 * queryExamUsers的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamUsers(OtsExamUserDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("   select e.exam_user_id, e.exams_info_id, e.user_id,  ");
		sb.append("   sys.username, sys.userkind, sys.description, sys.mobile, org.orgname ");
		sb.append("   from ots_exam_user e, sysuser sys, sysorg org  ");
		sb.append("   where 1 = 1 ");
		sb.append("   and e.user_id = sys.USERID ");
		sb.append("   and sys.ORGID = org.ORGID  ");
		sb.append("   and e.exams_info_id = :examsInfoId ");
		String[] ParaName = new String[] { "examsInfoId" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamUserDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * addUserToExam的中文名称：添加考试人员
	 * 
	 * addUserToExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String addUserToExam(HttpServletRequest request, OtsExamUserDTO dto) {
		try {
			addUserToExamImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * addUserToExamImp的中文名称：添加考试人员实现
	 * 
	 * addUserToExamImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void addUserToExamImp(HttpServletRequest request, OtsExamUserDTO dto)
			throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<SysuserDTO> userList = Json.fromJsonAsList(SysuserDTO.class, JsonStr);
		for (int i = 0; i < userList.size(); i++) {
			SysuserDTO user = (SysuserDTO) userList.get(i);
			// 判断用户是否加入考试
			boolean flag = checkUserIsInExam(user.getUserid(), dto.getExamsInfoId());
			if (!flag) {
				String v_id = DbUtils.getSequenceStr();
				OtsExamUser se = new OtsExamUser();
				se.setExamUserId(v_id); // 主键id
				se.setExamsInfoId(dto.getExamsInfoId()); // 考试ID
				se.setUserId(user.getUserid()); // 用户id
				dao.insert(se);
			}
		}
	}
	
	/**
	 * 
	 * checkUserIsInExam的中文名称：判断用户是否与考试建立关系
	 * 
	 * checkUserIsInExam的概要说明：
	 *
	 * @param userid
	 * @param examInfoId
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public boolean checkUserIsInExam(String userid, String examInfoId)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select a.* ");
		sb.append("  from ots_exam_user a ");
		sb.append("  where 1 = 1 ");
		sb.append("  and user_id = '").append(userid).append("' ");
		sb.append("  and exams_info_id = '").append(examInfoId).append("' ");
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				OtsExamUser.class);
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
		if (ls != null && ls.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * delUserOutOfExam的中文名称：将用户从考试用户关系表中删除
	 * 
	 * delUserOutOfExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delUserOutOfExam(HttpServletRequest request, OtsExamUserDTO dto) {
		try {
			delUserOutOfExamImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delUserOutOfExamImp的中文名称：将用户从考试用户关系表中删除实现方法
	 * 
	 * delUserOutOfExamImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delUserOutOfExamImp(HttpServletRequest request, OtsExamUserDTO dto)
			throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<OtsExamUserDTO> list = Json.fromJsonAsList(OtsExamUserDTO.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			OtsExamUserDTO v_dto = (OtsExamUserDTO) list.get(i);
			dao.clear(OtsExamUser.class, Cnd.where("exam_user_id", "=", v_dto.getExamUserId()));
		}
	}
	
	/**
	 * 
	 * queryExamMonInfos的中文名称：查询考试监控
	 * 
	 * queryExamMonInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamMonInfos(HttpServletRequest request, OtsExamsMateDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT `ots_exams_mate`.exams_info_id, ");
		sb.append(" `ots_exams_mate`.`exams_name`, `ots_exams_mate`.`exams_type`,`ots_exams_mate`.`duration`,");// 考试名称
		sb.append(" DATE_FORMAT(`ots_exams_mate`.startTime, '%Y-%m-%d %H:%i') start_time, "); // 考试开始时间
		sb.append(" DATE_FORMAT(`ots_exams_mate`.endTime, '%Y-%m-%d %H:%i') end_time, "); // 考试结束时间
		//sb.append("  (CASE WHEN `ots_exams_mate`.duration!=0 THEN `ots_exams_mate`.duration ELSE '不限时' END) duration, "); 
		sb.append(" MINUTE(TIMEDIFF(NOW(), ots_exams_mate.startTime)) exam_time,  "); // 答卷时间
		sb.append(" COUNT(DISTINCT `ots_result_mate`.user_id) num_exam_users  "); // 统计当前正在考试的人数
		sb.append(" FROM  `ots_exams_mate` ");
		sb.append(" LEFT JOIN (`ots_result_mate`, `ots_exams_papers`) ON  ");
		sb.append(" `ots_result_mate`.exam_info_id = `ots_exams_mate`.exams_info_id ");
		sb.append(" AND `ots_result_mate`.exams_papers_id = `ots_exams_papers`.exams_papers_id ");
		sb.append(" WHERE 1=1 ");
		if (dto.getExamsName() != null && !"".equals(dto.getExamsName())) {
			sb.append(" AND `ots_exams_mate`.`exams_name` like '%").append(dto.getExamsName()).append("%' ");
		}
		if (dto.getStartTime() != null && !"".equals(dto.getStartTime())
				&& dto.getEndTime() != null && !"".equals(dto.getEndTime())) {
			sb.append(" AND `ots_exams_mate`.startTime>= '").append(dto.getStartTime())
				.append("' and `ots_exams_mate`.endTime<=  '").append(dto.getEndTime()).append("' ");
		}
		//sb.append(" AND NOW() BETWEEN :startTime and :endTime ");
		if(dto.getExamsType() != null && !"".equals(dto.getExamsType())){
			sb.append(" AND ots_exams_mate.exams_type =	'").append(dto.getExamsType()).append("'");
		}
		//sb.append(" AND ots_exams_mate.exams_type =	:examsType ");
		sb.append(" GROUP BY `ots_exams_mate`.exams_info_id ");
		sb.append(" ORDER BY  `ots_exams_mate`.aae036 DESC");
		String sql = sb.toString();
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamsMateDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();                                               
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
		return map;
	}
	
	
	/**
	 * 
	 * queryExamMonUsers的中文名称：查询考试监控
	 * 
	 * queryExamMonUsers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamMonUsers(HttpServletRequest request, OtsExamUserDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT c.exams_info_id, a.USERNAME, a.DESCRIPTION, a.AAC002, a.MOBILE  ");
		sb.append(" from  sysuser a, ots_exam_user b, ots_exams_mate c ");
		sb.append(" where a.USERID = b.user_id AND b.exams_info_id = c.exams_info_id ");
		sb.append(" AND c.exams_info_id = :examsInfoId  ");
		String[] ParaName = new String[] { "examsInfoId" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamUserDTO.class,pd
				.getPage(),pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;

	}	
	
	/**
	 * 
	 * queryExamMonDetails的中文名称：查询考试监控
	 * 
	 * queryExamMonDetails的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamMonDetails(HttpServletRequest request, OtsResultMateDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT SUM(d.points) points, d.paper_info_id paper_info_Id, ");
		sb.append(" b.exams_info_id exam_info_id, c.USERNAME user_name, c.DESCRIPTION, c.AAC002, ");
		sb.append(" a.show_time, TIMESTAMPDIFF(SECOND, a.show_time, NOW()) costtimes ");
		sb.append(" from ots_result_mate a, ots_exams_mate b, sysuser c, ots_exams_papers d, ots_papers_info e ");
		sb.append(" WHERE a.user_id = c.USERID  and b.exams_info_id = a.exam_info_id ");
		sb.append(" and d.exams_info_id = b.exams_info_id AND d.paper_info_id = e.paper_info_id ");
		sb.append(" AND b.exams_info_id= :examInfoId ");
		sb.append(" AND c.USERNAME like :userName ");
		String[] ParaName = new String[] { "examInfoId", "userName"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsResultMateDTO.class,pd
				.getPage(),pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
}
