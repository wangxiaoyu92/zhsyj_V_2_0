package com.askj.exam.service;

import com.askj.exam.dto.OtsQuestionsAnsweredDTO;
import com.askj.exam.dto.OtsQuestionsCollectDTO;
import com.askj.exam.dto.OtsQuestionsErrorDTO;
import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.entity.OtsQuestionsAnswered;
import com.askj.exam.entity.OtsQuestionsCollect;
import com.askj.exam.entity.OtsQuestionsData;
import com.askj.exam.entity.OtsQuestionsError;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.*;

/**
 *
 *  PractiseService的中文名称：考试子系统-练习管理
 *
 *  PractiseService的描述：
 *
 *  Written  by  : zy
 */
public class PractiseService extends BaseService{

	protected final Logger logger = Logger.getLogger(PractiseService.class);

	@Inject
	private Dao dao;

	/**
	 *
	 * queryPractiseQuestions的中文名称：查询练习试题
	 *
	 * queryPractiseQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return TODO
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPractiseQuestions(HttpServletRequest request,
									  OtsQuestionsInfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 获取参数，判断是重新答题还是继续上次答题（1 继续 0 重新）
		String continueFlag = StringHelper.showNull2Empty(request.getParameter("continueFlag"));
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036, IFNULL(c.flag, 0) flag ");
		sb.append(" FROM ots_questions_info info LEFT JOIN ots_questions_answered b ");
		sb.append(" ON info.qsn_info_id = b.qsn_info_id ");
		sb.append(" and b.answer_type = :answerType");
		// 如果继续上次的练习
		if ("1".equals(continueFlag)) {
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT MAX(oqa.answer_number) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		} else { // 如果重新开始练习
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT (IFNULL(MAX(oqa.answer_number), 0) + 1) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		}
		sb.append(" and b.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		sb.append(" and b.qsn_info_id IS NULL "); // 查询没有做过的
		sb.append(" LEFT JOIN ots_questions_collect c "); // 收藏试题
		sb.append(" ON info.qsn_info_id = c.qsn_info_id ");
		sb.append(" and c.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用的试题
		sb.append(" and info.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		sb.append(" and info.qsn_info_type = :qsnInfoType ");
		if (dto.getQsnInfoTrade() != null && !"".equals(dto.getQsnInfoTrade())) {
			sb.append(" and find_in_set('" + dto.getQsnInfoTrade() + "', info.qsn_info_trade) ");
		}
		sb.append(" order by aae036 asc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "answerType", "qsnInfoType" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		// 获取试题选项数据
		if (list != null && list.size() > 0) {
			List  praList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				Map infoMap = new HashMap();
				OtsQuestionsInfoDTO v_info = (OtsQuestionsInfoDTO) list.get(i);
				// 试题选项信息
				List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class,
						Cnd.where("qsn_info_id", "=", v_info.getQsnInfoId()).asc("qsn_data_sort"));
				infoMap.put("dataList", dataList); // 试题选项信息
				infoMap.put("info", v_info);
				praList.add(infoMap);
			}
			map.put("qsnList", praList);
		}
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * queryRandPractiseQuestions的中文名称：查询随机练习试题
	 *
	 * queryRandPractiseQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return TODO
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryRandPractiseQuestions(HttpServletRequest request,
										  OtsQuestionsInfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 获取参数，判断是重新答题还是继续上次答题（1 继续 0 重新）
		String continueFlag = StringHelper.showNull2Empty(request.getParameter("continueFlag"));
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036, IFNULL(c.flag, 0) flag ");
		sb.append(" FROM ots_questions_info info LEFT JOIN ots_questions_answered b ");
		sb.append(" ON info.qsn_info_id = b.qsn_info_id ");
		sb.append(" and b.answer_type = :answerType");
		// 如果继续上次的练习
		if ("1".equals(continueFlag)) {
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT MAX(oqa.answer_number) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		} else { // 如果重新开始练习
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT (IFNULL(MAX(oqa.answer_number), 0) + 1) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		}
		sb.append(" and b.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		sb.append(" and b.qsn_info_id IS NULL "); // 查询没有做过的
		sb.append(" LEFT JOIN ots_questions_collect c "); // 收藏试题
		sb.append(" ON info.qsn_info_id = c.qsn_info_id ");
		sb.append(" and c.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用的试题
		sb.append(" and info.aae011 = '").append(user.getUserid()).append("' "); // 当前用户
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "answerType" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Collections.shuffle(list); // 首先对list进行一下随机排序
		Map map = new HashMap();
		if (list != null && list.size() > 0) {
			List  praList = new ArrayList();
			int qsnNo = list.size() > pd.getRows() ? pd.getRows() : list.size(); // 一次性返回试题条数
			for (int i = 0; i < qsnNo; i++) {
				Map infoMap = new HashMap();
				OtsQuestionsInfoDTO v_info = (OtsQuestionsInfoDTO) list.get(i);
				// 试题选项信息
				List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class,
						Cnd.where("qsn_info_id", "=", v_info.getQsnInfoId()).asc("qsn_data_sort"));
				infoMap.put("dataList", dataList); // 试题选项信息
				infoMap.put("info", v_info);
				praList.add(infoMap);
			}
			map.put("qsnList", praList);
		}
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * queryErrorQuestions的中文名称：查询错题
	 *
	 * queryErrorQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return TODO
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryErrorQuestions(HttpServletRequest request, OtsQuestionsInfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 获取参数，判断是重新答题还是继续上次答题（1 继续 0 重新） TODO
		String continueFlag = StringHelper.showNull2Empty(request.getParameter("continueFlag"));
		// 使用字符串缓冲器类拼接查询语句 
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036, err.qsn_error_item, err.error_id, c.flag ");
		sb.append(" FROM ots_questions_info info ");
		sb.append(" LEFT JOIN ots_questions_collect c "); // 收藏试题
		sb.append(" ON info.qsn_info_id = c.qsn_info_id ");
		sb.append(" and c.aae011 = '").append(user.getUserid()).append("', "); // 当前用户
		sb.append(" (SELECT a.* FROM ots_questions_error a LEFT JOIN ots_questions_answered b ");
		sb.append(" ON a.error_id = b.answered_id and b.answer_type = '3'  ");
		// 如果继续上次的练习  1 继续 0 重新
		if ("1".equals(continueFlag)) {
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT MAX(oqa.answer_number) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		} else { // 如果重新开始练习
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT (IFNULL(MAX(oqa.answer_number), 0) + 1) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		}
		sb.append(" AND a.aae011 = '").append(user.getUserid()).append("' WHERE b.qsn_info_id IS NULL) err ");
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_id = err.qsn_info_id ");
		sb.append(" and err.aae011 = '").append(user.getUserid()).append("' ");
		sb.append(" and info.qsn_info_type = :qsnInfoType ");
		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用状态的试题
		sb.append(" order by err.aae036 asc");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "qsnInfoType" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		if (list != null && list.size() > 0) {
			List  praList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				Map infoMap = new HashMap();
				OtsQuestionsInfoDTO v_info = (OtsQuestionsInfoDTO) list.get(i);
				// 试题选项信息
				List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class,
						Cnd.where("qsn_info_id", "=", v_info.getQsnInfoId()).asc("qsn_data_sort"));
				infoMap.put("dataList", dataList); // 试题选项信息
				infoMap.put("info", v_info);
				praList.add(infoMap);
			}
			map.put("qsnList", praList);
		}
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * queryQsnNumOfSpecial的中文名称：查询各知识点包含试题数目
	 *
	 * queryQsnNumOfSpecial的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQsnNumOfSpecial(HttpServletRequest request, OtsQuestionsInfoDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select oqt.qsn_trade, getAa10_aaa103('EXAMTRADE', oqt.qsn_trade) name, ");
		sb.append(" COUNT(oqt.qsn_id) num ");
		sb.append(" FROM ots_question_trade oqt ");
		sb.append(" LEFT JOIN ots_questions_info oqi ON oqt.qsn_id = oqi.qsn_info_id ");
		sb.append(" where 1=1 ");
		sb.append(" and oqi.qsn_info_type = :qsnInfoType "); // 试题类型
		sb.append(" AND oqi.qsn_info_state = '1' "); // 排除禁用试题
		sb.append(" GROUP BY oqt.qsn_trade ");
		sb.append(" ORDER BY oqt.qsn_trade ");
		String[] paramName = new String[] { "qsnInfoType" };
		int[] paramType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * saveErrorQuestion的中文名称：保存错题信息
	 *
	 * saveErrorQuestion的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveErrorQuestion(HttpServletRequest request, OtsQuestionsErrorDTO dto) {
		try {
			saveErrorQuestionImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveErrorQuestionImp的中文名称：保存错题信息实现方法
	 *
	 * saveErrorQuestionImp的概要说明：错题只包括选择与判断
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveErrorQuestionImp(HttpServletRequest request, OtsQuestionsErrorDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 当前时间
		OtsQuestionsError oqe = new OtsQuestionsError();
		oqe.setErrorId(DbUtils.getSequenceStr()); // 主键id
		oqe.setQsnInfoId(dto.getQsnInfoId()); // 试题id
		oqe.setQsnErrorItem(dto.getQsnErrorItem()); // 错误选项
		oqe.setAae011(user.getUserid()); // 操作用户z
		oqe.setAae036(v_dbDatetime); // 经办时间
		dao.insert(oqe); // 保存
	}

	/**
	 *
	 * deleteOutOfError的中文名称：删除错题
	 *
	 * deleteOutOfError的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String deleteOutOfError(HttpServletRequest request, OtsQuestionsErrorDTO dto) {
		try {
			deleteOutOfErrorImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * deleteOutOfErrorImp的中文名称：删除错题实现方法
	 *
	 * deleteOutOfErrorImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void deleteOutOfErrorImp(HttpServletRequest request, OtsQuestionsErrorDTO dto) throws Exception {
		dao.clear(OtsQuestionsError.class, Cnd.where("error_id", "=", dto.getErrorId()));
	}

	/**
	 *
	 * saveAnsweredQuestion的中文名称：保存已回答问题
	 *
	 * saveAnsweredQuestion的概要说明：记录已回答问题
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveAnsweredQuestion(HttpServletRequest request, OtsQuestionsAnsweredDTO dto) {
		try {
			saveAnsweredQuestionImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveAnsweredQuestionImp的中文名称：保存已回答问题实现方法
	 *
	 * saveAnsweredQuestionImp的概要说明：记录已回答问题
	 *
	 * @param request TODO
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings("unchecked")
	@Aop( { "trans" })
	public void saveAnsweredQuestionImp(HttpServletRequest request, OtsQuestionsAnsweredDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 获取参数，判断是重新答题还是继续上次答题（1 继续 0 重新）
		String continueFlag = StringHelper.showNull2Empty(request.getParameter("continueFlag"));
		// 查询之前相应练习回答过的最大次数 （练习类型0 顺序 1随机 2专项 3 错题 4 收藏）
		String sql = "SELECT IFNULL(MAX(oqa.answer_number), 1) answer_number FROM  ots_questions_answered oqa " +
				"where oqa.aae011 = '" + user.getUserid() + "' and oqa.answer_type = '" + dto.getAnswerType() + "' ";
		List<OtsQuestionsAnswered> list = DbUtils.getDataList(sql, OtsQuestionsAnswered.class);
		int answerNumber = 1; // 默认练习次数为1
		if (list != null && list.size() > 0) {
			if ("0".equals(continueFlag)) {
				answerNumber = Integer.parseInt(list.get(0).getAnswerNumber()) + 1;
			} else {
				answerNumber = Integer.parseInt(list.get(0).getAnswerNumber());
			}
		}
		String[] answeredQsnIds = dto.getQsnInfoId().split(",");
		for (int i = 0; i < answeredQsnIds.length; i++) {
			OtsQuestionsAnswered oqa = new OtsQuestionsAnswered();
			oqa.setAnsweredId(DbUtils.getSequenceStr()); // 主键id
			oqa.setQsnInfoId(answeredQsnIds[i]); // 试题id
			oqa.setAae011(user.getUserid()); // 用户
			oqa.setAnswerType(dto.getAnswerType()); // 练习类型
			oqa.setAae036(SysmanageUtil.getDbtimeYmdHns()); // 时间
			oqa.setAnswerNumber(Integer.toString(answerNumber)); // 练习次数
			dao.insert(oqa);
		}
	}

	/**
	 *
	 * queryCollectQuestions的中文名称：查询收藏试题
	 *
	 * queryCollectQuestions的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return TODO
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCollectQuestions(HttpServletRequest request,
									 OtsQuestionsInfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 获取参数，判断是重新答题还是继续上次答题（1 继续 0 重新）
		String continueFlag = StringHelper.showNull2Empty(request.getParameter("continueFlag"));
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036 ");
		sb.append(" FROM ots_questions_info info LEFT JOIN ots_questions_answered b ");
		sb.append(" ON info.qsn_info_id = b.qsn_info_id ");
		sb.append(" and b.answer_type = :answerType");
		// 如果继续上次的练习
		if ("1".equals(continueFlag)) {
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT MAX(oqa.answer_number) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		} else { // 如果重新开始练习
			sb.append(" and b.answer_number = ");
			sb.append(" (SELECT (IFNULL(MAX(oqa.answer_number), 0) + 1) answer_number FROM  ots_questions_answered oqa ");
			sb.append(" where oqa.aae011 = '").append(user.getUserid()).append("') ");
		}
		sb.append(" and b.qsn_info_id IS NULL "); // 查询没有做过的
		sb.append(" and b.aae011 = '").append(user.getUserid()).append("', "); // 当前用户
		sb.append(" ots_questions_collect c "); // 收藏试题
		sb.append(" where 1=1 ");
		sb.append(" AND info.qsn_info_id = c.qsn_info_id "); // 收藏试题
		sb.append(" and c.aae011 = '").append(user.getUserid()).append("' "); // 当前用户

		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用的试题
		sb.append(" order by aae036 asc");
		String sql = sb.toString();
		/*sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036");
		sb.append(" FROM ots_questions_info info, ots_questions_collect b ");
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_id = b.qsn_info_id ");
		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用的试题
		sb.append(" and b.aae011 = '").append(user.getUserid()).append("' ");
		sb.append(" and info.qsn_info_type = :qsnInfoType ");
		sb.append(" order by b.aae036 desc");*/
		// 转化sql语句
		String[] paramName = new String[] { "answerType" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		// 获取试题选项数据
		if (list != null && list.size() > 0) {
			List  praList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				Map infoMap = new HashMap();
				OtsQuestionsInfoDTO v_info = (OtsQuestionsInfoDTO) list.get(i);
				// 试题选项信息
				List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class,
						Cnd.where("qsn_info_id", "=", v_info.getQsnInfoId()).asc("qsn_data_sort"));
				infoMap.put("dataList", dataList); // 试题选项信息
				infoMap.put("info", v_info);
				praList.add(infoMap);
			}
			map.put("qsnList", praList);
		}
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * addCollectQuestion的中文名称：添加收藏试题
	 *
	 * addCollectQuestion的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String addCollectQuestion(HttpServletRequest request, OtsQuestionsCollectDTO dto) {
		try {
			addCollectQuestionImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * addCollectQuestionImp的中文名称：添加收藏试题
	 *
	 * addCollectQuestionImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void addCollectQuestionImp(HttpServletRequest request, OtsQuestionsCollectDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		// 查询之前是否已收藏过该试题
		List<OtsQuestionsCollect> list = dao.query(OtsQuestionsCollect.class, Cnd.where("qsn_info_id", "=", dto.getQsnInfoId())
				.and("aae011", "=", user.getUserid()));
		if (list == null || list.size() == 0) {
			OtsQuestionsCollect otc = new OtsQuestionsCollect();
			otc.setAae011(user.getUserid()); // 经办人
			otc.setAae036(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			otc.setFlag("1"); // 收藏标志 0未收藏 1收藏
			otc.setQsnCollectId(DbUtils.getSequenceStr()); // 主键id
			otc.setQsnInfoId(dto.getQsnInfoId());
			dao.insert(otc);
		}
	}

	/**
	 *
	 * deleteCollectQuestion的中文名称：删除收藏试题
	 *
	 * deleteCollectQuestion的概要说明：取消收藏
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String deleteCollectQuestion(HttpServletRequest request, OtsQuestionsCollectDTO dto) {
		try {
			deleteCollectQuestionImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * deleteCollectQuestionImp的中文名称：删除收藏试题实现方法
	 *
	 * deleteCollectQuestionImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void deleteCollectQuestionImp(HttpServletRequest request, OtsQuestionsCollectDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			user = new Sysuser();
			user = dao.fetch(Sysuser.class, userid);
		} else {
			if (user == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		dao.clear(OtsQuestionsCollect.class, Cnd.where("qsn_info_id", "=", dto.getQsnInfoId())
				.and("aae011", "=", user.getUserid()));
	}

}
