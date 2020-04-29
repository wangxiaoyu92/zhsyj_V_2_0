package com.askj.exam.service;

import java.sql.Types;
import java.util.ArrayList;
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
import org.nutz.lang.Lang;

import com.askj.exam.dto.OtsExamsDataDTO;
import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.exam.dto.OtsPapersInfoDTO;
import com.askj.exam.dto.OtsResultInfoDTO;
import com.askj.exam.entity.OtsExamsMate;
import com.askj.exam.entity.OtsExamsPapers;
import com.askj.exam.entity.OtsPaperContent;
import com.askj.exam.entity.OtsPaperQsnType;
import com.askj.exam.entity.OtsPapersInfo;
import com.askj.exam.entity.OtsQuestionsData;
import com.askj.exam.entity.OtsQuestionsInfo;
import com.askj.exam.entity.OtsResultInfo;
import com.askj.exam.entity.OtsResultMate;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  ResultService的中文名称：考试子系统-考试结果管理
 *
 *  ResultService的描述：
 *
 *  Written  by  : zy
 */
public class ResultService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(ResultService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryUserExams的中文名称：查询用户所能参加考试
	 * 
	 * queryUserExams的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryUserExams(HttpServletRequest request, OtsExamsInfoDTO dto, PagesDTO pd) throws Exception {
		
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = new Sysuser();
			vSysUser = dao.fetch(Sysuser.class, userid);
		} else {
			if (vSysUser == null) {
				throw new Exception("用户id不能为空");
			}
		}
		// 使用字符串缓冲器类拼接查询语句 
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.exams_info_id, info.exams_info_state, info.exams_info_name, ");
		sb.append(" info.aae011, info.aae036, mate.starttime, mate.endtime, mate.exams_type, mate.duration ");
		sb.append(" FROM ots_exams_info info, ots_exam_user user, ots_exams_mate mate ");
		sb.append(" where 1=1 ");                                                                                                                        
		sb.append(" and info.exams_info_id = user.exams_info_id ");
		sb.append(" and info.exams_info_id = mate.exams_info_id ");
		sb.append(" and info.exams_info_state = '1' "); // 考试状态为可用
		sb.append(" and user.user_id = '").append(vSysUser.getUserid()).append("' "); // 当前用户id
		sb.append(" and info.exams_info_name = :examsInfoName "); // 考试名称
		sb.append(" order by exams_info_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "examsInfoName" };
		int[] paramType = new int[] { Types.VARCHAR };
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
	 * queryExamPapers的中文名称：查询考试所包含试卷信息
	 * 
	 * queryExamPapers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamPapers(HttpServletRequest request, OtsExamsInfoDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.exams_data_id, a.exams_info_id, a.paper_info_id, ");
		sb.append(" a.exams_data_sort, a.aae011, a.aae036, ");
		sb.append(" b.paper_info_state, b.paper_info_pass, b.paper_info_name, ");
		sb.append(" SUM(c.qsn_info_point) points, COUNT(c.qsn_info_point) total ");
		sb.append(" FROM ots_exams_data a, ots_papers_info b, ots_paper_content c ");
		sb.append(" where 1=1 ");
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
	 * startExam的中文名称：用户开始考试业务实现
	 * 
	 * startExam的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map startExam(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		// 返回的数据
		Map retMap = new HashMap();
		// 考试功能信息
		OtsExamsMate oem = dao.fetch(OtsExamsMate.class, dto.getExamsInfoId());
		// 试卷信息
		OtsPapersInfo paperInfo = dao.fetch(OtsPapersInfo.class, dto.getPaperInfoId());
		// 试卷对象
		JSONObject paperObj = new JSONObject();
		paperObj.accumulate("paperInfoId", paperInfo.getPaperInfoId()); // 试卷id
		paperObj.accumulate("paperInfoName", paperInfo.getPaperInfoName()); // 试卷名称
		paperObj.accumulate("paperInfoPass", paperInfo.getPaperInfoPass()); // 及格分数
		paperObj.accumulate("points", dto.getPoints()); // 试卷总分
		paperObj.accumulate("examsInfoId", dto.getExamsInfoId()); // 考试id
		// 试卷大题类型集合
		List paperQsnTypeList = new ArrayList();
		// 试卷题型对应(每套试卷包含哪些类型的大题)
		List<OtsPaperQsnType> v_types = dao.query(OtsPaperQsnType.class, 
				Cnd.where("paper_info_id", "=", dto.getPaperInfoId()).asc("qsn_type_position"));
		for (int i = 0; i < v_types.size(); i++) {
			// 获取到试卷大题类型
			OtsPaperQsnType v_type = v_types.get(i);
			// 大题类型信息
			JSONObject typeInfoObj = new JSONObject();
			typeInfoObj.accumulate("qsnPoint", v_type.getQsnPoint()); // 大题分数（每题分数）
			typeInfoObj.accumulate("qsnTypeTitle", v_type.getQsnTypeTitle()); // 大题标题
			typeInfoObj.accumulate("qsnType", v_type.getQsnType()); // 大题类型
			// 每类大题所包含试题信息
			List qsnInfoList = new ArrayList();
			// 试卷每类题型所包含试题结合
			List<OtsPaperContent> v_cons = dao.query(OtsPaperContent.class, 
					Cnd.where("paper_info_id", "=", dto.getPaperInfoId())
						.and("qsn_type_position", "=", v_type.getQsnTypePosition()).asc("qsn_info_position"));
			for (int j = 0; j < v_cons.size(); j++) {
				// 获取到试卷的每个试题
				OtsPaperContent v_con = v_cons.get(j);
				JSONObject qsnObj = new JSONObject();
				// 试题信息（用于查询试题题干描述，用于编辑展示用）
				OtsQuestionsInfo qsnInfo = dao.fetch(OtsQuestionsInfo.class, v_con.getQsnInfoId());
				
				qsnObj.accumulate("qsnInfoId", qsnInfo.getQsnInfoId()); // 试题信息id
				qsnObj.accumulate("qsnInfoDesc", qsnInfo.getQsnInfoDesc()); // 试题题干描述
				qsnObj.accumulate("qsnInfoType", qsnInfo.getQsnInfoType()); // 试题类型
				qsnObj.accumulate("qsnInfoExplain", qsnInfo.getQsnInfoExplain()); // 试题答案解析
				// 试题选项信息
				List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class, 
						Cnd.where("qsn_info_id", "=", v_con.getQsnInfoId()).asc("qsn_data_sort"));
				// 每道题内容选项
				List qsnDataList = new ArrayList();
				for (int k = 0; k < dataList.size(); k++) {
					OtsQuestionsData v_data = dataList.get(k);
					JSONObject qsnDataObj = new JSONObject();
					qsnDataObj.accumulate("qsnDataId", v_data.getQsnDataId()); // 试题数据id
					qsnDataObj.accumulate("qsnDataIsanswer", v_data.getQsnDataIsanswer()); // 是否为答案
					qsnDataObj.accumulate("qsnDataOption", v_data.getQsnDataOption()); // 组件参数
					qsnDataObj.accumulate("qsnDataOptiondesc", v_data.getQsnDataOptiondesc()); // 组件参数描述
					qsnDataList.add(qsnDataObj);
				}
				qsnObj.accumulate("qsnDataList", qsnDataList); 
				qsnInfoList.add(qsnObj);
			}
			typeInfoObj.accumulate("qsnInfo", qsnInfoList); // 每类大题包含的试题信息
			paperQsnTypeList.add(typeInfoObj);
		}
		paperObj.accumulate("paperQsnType", paperQsnTypeList); // 试卷包含题型数据
		retMap.put("paperInfo", paperObj); // 试卷信息
		retMap.put("examMate", oem); // 考试功能信息
		String orm_id =  saveUserExamInfo(request, dto, paperObj.toString()); // 用户考试信息表,开始考试便插入一条数据
		retMap.put("resultMateId", orm_id); // 用户考试信息表id
		return retMap;
	}
	
	
	/**
	 * 
	 * saveUserExamInfo的中文名称：保存用户考试信息表
	 * 
	 * saveUserExamInfo的概要说明：开始考试便插入一条数据
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 * @throws Exception 
	 */
	public String saveUserExamInfo(HttpServletRequest request, OtsPapersInfoDTO dto, 
			String paperInfo) throws Exception {
		return saveUserExamInfoImp(request, dto, paperInfo);
	}
	
	/**
	 * 
	 * saveUserExamInfoImp的中文名称：保存用户考试信息表实现方法
	 * 
	 * saveUserExamInfoImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public String saveUserExamInfoImp(HttpServletRequest request, OtsPapersInfoDTO dto, 
			String paperInfo) throws Exception {
		String orm_id = DbUtils.getSequenceStr();
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = new Sysuser();
			vSysUser = dao.fetch(Sysuser.class, userid);
		} else {
			if (vSysUser == null) {
				throw new Exception("用户id不能为空");
			}
		}
		// 保存试卷缓存数据
		List<OtsExamsPapers> papers = dao.query(OtsExamsPapers.class, 
				Cnd.where("exams_info_id", "=", dto.getExamsInfoId()).and("paper_info_id", "=", dto.getPaperInfoId()));
		String v_cachePaperId = "";
		// 如果已经存在该人员对应的考试缓存试卷，则不再添加
		if (papers == null || papers.size() == 0) {
			v_cachePaperId = DbUtils.getSequenceStr();
			// 考试缓存试卷表
			OtsExamsPapers paperCache = new OtsExamsPapers();
			paperCache.setExamsPapersId(v_cachePaperId); // 数据ID
			paperCache.setExamsInfoId(dto.getExamsInfoId()); // 关联考试信息ID
			paperCache.setPaperInfoId(dto.getPaperInfoId()); // 所使用的试卷ID
			paperCache.setPoints(dto.getPoints()); // 试卷总分
			paperCache.setData(paperInfo); // 缓存的试卷数据
			paperCache.setModified(SysmanageUtil.getDbtimeYmdHns()); // 修改时间
			dao.insert(paperCache);
		} else {
			OtsExamsPapers v_paper = papers.get(0);
			v_cachePaperId = v_paper.getExamsPapersId();
		}
		// 每次开始考试前，判断是否参加过该考试
		List<OtsResultMate> mates = dao.query(OtsResultMate.class, Cnd.where("exam_info_id", "=", dto.getExamsInfoId())
				.and("exams_papers_id", "=", v_cachePaperId).and("user_id", "=", vSysUser.getUserid()).desc("times"));
		int times = 1; // 默认考试次数为1
		// 如果参加过该考试
		if (mates != null && mates.size() > 0) {
			OtsResultMate v_mate = mates.get(0);
			// 判断是否考试结束
			String isExamOver = v_mate.getResultInfoId();
			if (!"".equals(isExamOver)) {
				// 如果考试结束，
				times = Integer.parseInt(v_mate.getTimes()) + 1;
			} else {
				orm_id = v_mate.getResultMateId();
				return orm_id; // 如果考试没结束，返回继续开始考试
			}
		}
		// 用户考试信息表,开始考试便插入一条数据
		OtsResultMate orm = new OtsResultMate();
		orm.setResultMateId(orm_id); // 用户考试信息ID
		orm.setResultInfoId(""); // 考试结果信息ID(空=还没有考试结束)
		orm.setExamInfoId(dto.getExamsInfoId()); // 关联的考试ID
		orm.setUserId(vSysUser.getUserid()); // 用户ID
		orm.setExamsPapersId(v_cachePaperId); // 关联考试所使用的试卷 ots_exams_papers`.exams_papers_id
		orm.setCourseId(""); // 关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试
		orm.setPlanId(""); // 关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试
		orm.setShowTime(SysmanageUtil.getDbtimeYmdHns()); // 进入考试时间
		orm.setTimes(Integer.toString(times)); // 当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据
		orm.setIpAddress(getIpAddr(request)); // IP地址
		orm.setJudge(""); // 评分人ID(空=未评卷)
		dao.insert(orm);
		return orm_id;
	}
	
	/**
	 * 
	 * submitExamImp的中文名称：提交试卷
	 * 
	 * submitExamImp的概要说明：目前只支持选择题，判断题自动判分（填空题，简答题不支持）
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Aop( { "trans" })
	public Map submitExam(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		// 返回的数据
		Map retMap = new HashMap();
		double score = 0; // 总分（默认为0）
		JSONArray submitData = null;
		String v_submitDataStr = dto.getSubmitData();
		if (v_submitDataStr != null && !"".equals(v_submitDataStr)) {
			submitData = JSONArray.fromObject(v_submitDataStr);
		}
		
		String submitDataStr = "[";
		for (int i = 0; i < submitData.size(); i++) {
			String qsnInfo = submitData.get(i).toString();
			if (i == submitData.size() - 1) {
				submitDataStr += qsnInfo;
			} else {
				submitDataStr += qsnInfo + ",";
			}
			
			// 获取每道题大题结果
			JSONObject qsnObj = JSONObject.fromObject(qsnInfo);
			// 每道题大题类型
			int qsnType = qsnObj.getInt("qsnType");
			if (qsnType == 1 || qsnType == 3) { // 当为单选题或者判断题时
				String qsnInfoId = qsnObj.getString("qsnInfoId"); // 获取试题id
				String qsnDataId = qsnObj.getString("qsnDataId"); // 获取所选选项id
				double qsnPoint = qsnObj.getDouble("qsnPoint"); // 获取该题分数
				if (isRadioOrJudgeRight(dto, qsnInfoId, qsnDataId)) {  
					score +=  qsnPoint;
				}
			} else if (qsnType == 2) { // 当为多选题时
				String qsnInfoId = qsnObj.getString("qsnInfoId"); // 获取试题id
				JSONArray qsnDataIds = qsnObj.getJSONArray("qsnDataIds"); // 获取所选选项id
				String[] qsnDataIdArr = new String[qsnDataIds.size()];
				if (qsnDataIds.size() > 0) {
					for (int j = 0; j < qsnDataIds.size(); j++) {
						qsnDataIdArr[j] = JSONObject.fromObject(qsnDataIds.get(j)).getString("qsnDataId");
					}
				}
				double qsnPoint = qsnObj.getDouble("qsnPoint"); // 获取该题分数
				double currentScore = getCurrentCheckScore(dto, qsnInfoId, qsnDataIdArr, qsnPoint);
				score +=  currentScore;
			}
		}
		
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = new Sysuser();
			vSysUser = dao.fetch(Sysuser.class, userid);
		} else {
			if (vSysUser == null) {
				throw new Exception("用户id不能为空");
			}
		}
		// 向参加考试结果信息表添加数据
		// 获取用户考试信息表信息
		OtsResultMate v_mate = dao.fetch(OtsResultMate.class, dto.getResultMateId());
		
		// 获取缓存的试卷数据
		OtsExamsPapers paperData = dao.query(OtsExamsPapers.class, 
				Cnd.where("exams_info_id", "=", dto.getExamsInfoId())
					.and("paper_info_id", "=", dto.getPaperInfoId())).get(0);
		
		String v_resultId = DbUtils.getSequenceStr(); // 参加考试结果信息表id
		OtsResultInfo v_info = new OtsResultInfo();
		v_info.setResultInfoId(v_resultId); // id
		v_info.setResultInfoName(dto.getExamsName()); // 考试名称
		v_info.setResultInfoPoints(paperData.getPoints()); // 考试总分
		v_info.setResultInfoScores(Double.toString(score)); // 考试得分
		v_info.setResultInfoPass(dto.getPaperInfoPass()); // 及格分数
		v_info.setExamInfoId(dto.getExamsInfoId()); // 参加考试的id
		v_info.setPaperInfoId(dto.getPaperInfoId()); // 考试使用的试卷id
		v_info.setPaperdata(paperData.getData()); // 使用的卷子数据 
		v_info.setResultdata(submitDataStr + "]"); // 用户提交的数据 
		v_info.setStartTime(v_mate.getShowTime()); // 开始考试时间
		v_info.setEndTime(SysmanageUtil.getDbtimeYmdHns()); // 提交考试时间
		if (score >= Integer.parseInt(dto.getPaperInfoPass()) ) { // 考试总评
			v_info.setRemark("及格");
		} else {
			v_info.setRemark("不及格");
		}
		v_info.setAae011(vSysUser.getUserid()); // 经办人
		v_info.setAae036(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
		dao.insert(v_info);
		// 更新用户考试信息表
		v_mate.setResultInfoId(v_resultId); 
		dao.update(v_mate);
		retMap.put("score", score);
		return retMap;
	}
	
	/**
	 * 
	 * isRadioOrJudgeRight的中文名称：判断单选题或选择题是否回答正确
	 * 
	 * isRadioOrJudgeRight的概要说明：
	 *
	 * @param dto
	 * @param qsnInfoId 所答试题id
	 * @param qsnDataId 选项id
	 * @return
	 *        Written by : zy
	 */
	public boolean isRadioOrJudgeRight(OtsPapersInfoDTO dto, String qsnInfoId, String qsnDataId) {
		
		boolean flag = false;
		// 获取缓存的试卷数据
		String paperData = dao.query(OtsExamsPapers.class, 
				Cnd.where("exams_info_id", "=", dto.getExamsInfoId())
					.and("paper_info_id", "=", dto.getPaperInfoId())).get(0).getData();
		if (!"".equals(paperData)) {
			JSONObject paperObj = JSONObject.fromObject(paperData);
			// 获取试卷大题类型
			JSONArray paperQsnType = paperObj.getJSONArray("paperQsnType");
			for (int i = 0; i < paperQsnType.size(); i++) {
				// 每类大题
				JSONObject typeObj = paperQsnType.getJSONObject(i);
				// 获取试题类型
				String qsnType = typeObj.getString("qsnType");
				if ("1".equals(qsnType) || "3".equals(qsnType)) {
					// 获取大题所包含的试题
					JSONArray qsnInfo = typeObj.getJSONArray("qsnInfo");
					// 对所包含的试题进行遍历
					for (int j = 0; j < qsnInfo.size(); j++) {
						// 每道小题
						JSONObject qsnObj = qsnInfo.getJSONObject(j);
						// 每到试题id
						String qsnId = qsnObj.getString("qsnInfoId");
						if (qsnInfoId.equals(qsnId)) {
							// 获取每道试题所包含的选项信息
							JSONArray qsnData = qsnObj.getJSONArray("qsnDataList");
							for (int k = 0; k < qsnData.size(); k++) {
								// 每个选项信息
								JSONObject dataObj = qsnData.getJSONObject(k);
								// 选项id
								String dataId = dataObj.getString("qsnDataId");
								if (qsnDataId.equals(dataId)) {
									String isAnswer = dataObj.getString("qsnDataIsanswer");
									if ("1".equals(isAnswer)) {
										flag = true;
									}
								}
							}
						}
					}
				}
			}
		}
		return flag;
	}
	
	/**
	 * 
	 * getCurrentCheckScore的中文名称：获取当前多选题分数
	 * 
	 * getCurrentCheckScore的概要说明：全队满分，少选获得一半，打错不得分
	 *
	 * @param dto
	 * @param qsnInfoId
	 * @param qsnDataIds
	 * @param point
	 * @return
	 * @author : zy
	 */
	public double getCurrentCheckScore(OtsPapersInfoDTO dto, String qsnInfoId, String[] qsnDataIds, double point) {
		
		double score = 0; // 该试题得分数
		List<String> answersList = new ArrayList<String>(); // 正确答案选项
		// 获取缓存的试卷数据
		String paperData = dao.query(OtsExamsPapers.class, 
				Cnd.where("exams_info_id", "=", dto.getExamsInfoId())
					.and("paper_info_id", "=", dto.getPaperInfoId())).get(0).getData();
		if (!"".equals(paperData)) {
			JSONObject paperObj = JSONObject.fromObject(paperData);
			// 获取试卷大题类型
			JSONArray paperQsnType = paperObj.getJSONArray("paperQsnType");
			for (int i = 0; i < paperQsnType.size(); i++) {
				// 每类大题
				JSONObject typeObj = paperQsnType.getJSONObject(i);
				// 获取试题类型
				String qsnType = typeObj.getString("qsnType");
				if ("2".equals(qsnType)) {
					// 获取大题所包含的试题
					JSONArray qsnInfo = typeObj.getJSONArray("qsnInfo");
					// 对所包含的试题进行遍历
					for (int j = 0; j < qsnInfo.size(); j++) {
						// 每道小题
						JSONObject qsnObj = qsnInfo.getJSONObject(j);
						// 每到试题id
						String qsnId = qsnObj.getString("qsnInfoId");
						if (qsnInfoId.equals(qsnId)) {
							// 获取每道试题所包含的选项信息
							JSONArray qsnData = qsnObj.getJSONArray("qsnDataList");
							for (int k = 0; k < qsnData.size(); k++) {
								// 每个选项信息
								JSONObject dataObj = qsnData.getJSONObject(k);
								// 选项id
								String dataId = dataObj.getString("qsnDataId");
								String isAnswer = dataObj.getString("qsnDataIsanswer");
								if ("1".equals(isAnswer)) {
									answersList.add(dataId);
								}
							}
						}
					}
				}
			}
		}
		// 如果所选选项和答案选项个数相同(全部答对，满分)
		if ((answersList.size() == qsnDataIds.length) && (answersList.size() > 0)) {
			for (int i = 0; i < qsnDataIds.length; i++) {
				if (answersList.contains(qsnDataIds[i])) { // 如果包含正确答案，获得分数
					score = point;
				} else { // 如果不包含正确答案，不得分，跳出循环判断
					score = 0;
					return score;
				}
			}
		} else if (answersList.size() > qsnDataIds.length) { // 如果所选选项和答案选项个数不同(答对一部分，获取一般分数)
			for (int i = 0; i < qsnDataIds.length; i++) {
				if (answersList.contains(qsnDataIds[i])) {
					score = point / 2;
				} else { // 如果不包含正确答案，不得分，跳出循环判断
					score = 0;
					return score;
				}
			}
		}
		return score;
	}
	
	/**
	 * 
	 * queryExamResults的中文名称：查询考试成绩
	 * 
	 * queryExamResults的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryExamResults(HttpServletRequest request, 
			OtsResultInfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = new Sysuser();
			vSysUser = dao.fetch(Sysuser.class, userid);
		} else {
			if (vSysUser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 使用字符串缓冲器类拼接查询语句 
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.result_info_id, a.result_info_name, a.result_info_points, ");
		sb.append(" a.result_info_scores, a.result_info_pass, a.exam_info_id, a.paper_info_id, ");
		sb.append(" a.start_time, a.end_time, a.remark, ");
		sb.append(" b.times, c.DESCRIPTION, TIMESTAMPDIFF(SECOND, a.start_time, a.end_time) costtimes ");                                                                                                                        
		sb.append(" FROM ots_result_info a, ots_result_mate b, sysuser c ");
		sb.append(" WHERE a.result_info_id = b.result_info_id  ");
		sb.append(" AND b.user_id = c.USERID ");
		sb.append(" AND b.user_id ='").append(vSysUser.getUserid()).append("' ");
		sb.append(" AND a.result_info_name like :resultInfoName "); 
		sb.append(" order by a.result_info_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "resultInfoName" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsResultInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryResultInfo的中文名称：查询考试结果
	 * 
	 * queryResultInfo的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public OtsResultInfo queryResultInfo(OtsResultInfoDTO dto) throws Exception {
		
		return dao.fetch(OtsResultInfo.class, dto.getResultInfoId());
	}
	
	/**
	 * 
	 * delResult的中文名称：删除考试结果
	 * 
	 * delResult的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public String delResult(HttpServletRequest request, OtsResultInfoDTO dto) {
		try {
			delResultImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delResultImp的中文名称：删除考试结果实现方法
	 * 
	 * delResultImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void delResultImp(HttpServletRequest request, OtsResultInfoDTO dto) throws Exception {
		// 删除考试记录
		dao.clear(OtsResultInfo.class, Cnd.where("result_info_id", "=", dto.getResultInfoId()));
	}
	
	/**
	 * 
	 * getIpAddr的中文名称：获取用户ip地址
	 * 
	 * getIpAddr的概要说明：
	 *
	 * @param request
	 * @return
	 *        Written by : zy
	 */
	public String getIpAddr(HttpServletRequest request) { 
		String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("Proxy-Client-IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("WL-Proxy-Client-IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("HTTP_CLIENT_IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getRemoteAddr();  
            }  
        } else if (ip.length() > 15) {  
            String[] ips = ip.split(",");  
            for (int index = 0; index < ips.length; index++) {  
                String strIp = (String) ips[index];  
                if (!("unknown".equalsIgnoreCase(strIp))) {  
                    ip = strIp;  
                    break;  
                }  
            }  
        }  
        return ip.equals("0:0:0:0:0:0:0:1") ? "127.0.0.1" : ip; 
	}
	
}
