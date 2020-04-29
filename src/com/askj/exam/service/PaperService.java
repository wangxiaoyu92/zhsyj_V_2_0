package com.askj.exam.service;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
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
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.askj.exam.dto.OtsPapersInfoDTO;
import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.entity.OtsPaperContent;
import com.askj.exam.entity.OtsPaperQsnType;
import com.askj.exam.entity.OtsPapersInfo;
import com.askj.exam.entity.OtsQuestionsData;
import com.askj.exam.entity.OtsQuestionsInfo;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  PaperService的中文名称：考试子系统-试卷管理
 *
 *  PaperService的描述：
 *
 *  @author : zy
 */
public class PaperService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(PaperService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryPapers的中文名称：查询试卷列表
	 * 
	 * queryPapers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPapers(HttpServletRequest request, OtsPapersInfoDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.paper_info_id, info.paper_info_state, info.paper_info_pass, ");
		sb.append(" info.paper_info_name, info.aae013, info.aae036, ");
		sb.append(" (SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = info.aae011) aae011, ");
		sb.append(" SUM(con.qsn_info_point) points, COUNT(con.qsn_info_point) total ");
		sb.append(" FROM ots_papers_info info LEFT JOIN ots_paper_content con ");
		sb.append(" ON info.paper_info_id = con.paper_info_id "); 
		sb.append(" where 1=1 ");
		if (dto.getPaperInfoState() != null && !"".equals(dto.getPaperInfoState())) {
			sb.append(" and info.paper_info_state = :paperInfoState "); // 试卷状态
		}
		if (dto.getPaperInfoName() != null && !"".equals(dto.getPaperInfoName())) {
			sb.append(" and info.paper_info_name like :paperInfoName "); // 试卷名称
		}
		sb.append(" GROUP BY info.paper_info_id ");
		sb.append(" order by paper_info_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "paperInfoState", "paperInfoName" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsPapersInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * savePaperInfo的中文名称：保存试卷
	 * 
	 * savePaperInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String savePaperInfo(HttpServletRequest request, OtsPapersInfoDTO dto) {
		try {
			savePaperInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * savePaperInfoImp的中文名称：保存试卷方法实现
	 * 
	 * savePaperInfoImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void savePaperInfoImp(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		String v_infoId =  (dto.getPaperInfoId() != null && !"".equals(dto.getPaperInfoId())) ? 
			 dto.getPaperInfoId() : DbUtils.getSequenceStr(); // 试卷信息id
			 
		// 对试卷内容先删除，再保存
		// 删除试卷题型对应关系
		dao.clear(OtsPaperQsnType.class, Cnd.where("paper_info_id", "=", v_infoId));
		// 删除试卷内容
		dao.clear(OtsPaperContent.class, Cnd.where("paper_info_id", "=", v_infoId));
		
		// 保存数据内容
		JSONArray arr = JSONArray.fromObject(dto.getPaperInfoData());
		Object[] v_objArray  = arr.toArray();
		if (v_objArray.length > 0) {
			for (int i = 0; i < v_objArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
				// 试卷题型对应保存
				OtsPaperQsnType v_type = new OtsPaperQsnType();
				v_type.setPaperInfoId(v_infoId); // 试卷id
				v_type.setQsnTypePosition(Integer.toString(i + 1)); // 试题所处试卷位置
				v_type.setQsnTypeTitle(v_obj.getString("qsnTypeTitle")); // 试题名称
				v_type.setQsnType(v_obj.getString("qsnType")); // 试题类型
				v_type.setQsnPoint(v_obj.getString("qsnPoint")); // 每类试题分值
				v_type.setAae011(vSysUser.getUserid()); // 经办人
				v_type.setAae036(v_dbDatetime); // 经办时间
				dao.insert(v_type);
				// 试卷内容保存
				JSONArray childrenArr = v_obj.getJSONArray("children");
				Object[] v_chiArr  = childrenArr.toArray();
				for (int j = 0; j < v_chiArr.length; j++) {
					JSONObject v_chiObj = JSONObject.fromObject(v_chiArr[j]);
					OtsPaperContent v_con = new OtsPaperContent();
					v_con.setPaperInfoId(v_infoId); // 试卷id5
					v_con.setQsnInfoId(v_chiObj.getString("qsnInfoId")); // 试题id
					v_con.setQsnTypePosition(Integer.toString(i + 1)); // 试题大题题型所处试卷位置
					v_con.setQsnInfoPosition(Integer.toString(j + 1)); // 试题所处大题位置
					v_con.setQsnInfoPoint(v_chiObj.getString("qsnInfoPoint")); // 试题分值
					v_con.setQsnInfoType(v_chiObj.getString("qsnInfoType")); // 试题类型
					v_con.setAae011(vSysUser.getUserid()); // 经办人
					v_con.setAae036(v_dbDatetime); // 经办时间
					dao.insert(v_con);
				}
			}
		}
		// 对试题内容保存
		// 如果id存在，更新
		if (dto.getPaperInfoId() != null && !"".equals(dto.getPaperInfoId())) {
			// 试题对象
			OtsPapersInfo v_info = dao.fetch(OtsPapersInfo.class, dto.getPaperInfoId());
			v_info.setPaperInfoName(dto.getPaperInfoName()); // 试卷名称
			v_info.setPaperInfoPass(dto.getPaperInfoPass()); // 及格分数
			v_info.setPaperInfoState(dto.getPaperInfoState()); // 试卷状态
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			v_info.setAae013(dto.getAae013()); // 备注
			dao.update(v_info); // 保存
		} else {
			// 试题对象
			OtsPapersInfo v_info = new OtsPapersInfo();
			v_info.setPaperInfoId(v_infoId); // 试题信息id
			v_info.setPaperInfoName(dto.getPaperInfoName()); // 试卷名称
			v_info.setPaperInfoPass(dto.getPaperInfoPass()); // 及格分数
			v_info.setPaperInfoState(dto.getPaperInfoState()); // 试卷状态
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			v_info.setAae013(dto.getAae013()); // 备注
			dao.insert(v_info); // 保存
		}
	}
	
	/**
	 * 
	 * autoMakePaper的中文名称：自动组卷
	 * 
	 * autoMakePaper的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map autoMakePaper(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		Map m = new HashMap();
		String paperId = autoMakePaperImp(request, dto);
		m.put("paperId", paperId);
		return m;
	}
	
	/**
	 * 
	 * autoMakePaperImp的中文名称：自动组卷实现
	 * 
	 * autoMakePaperImp的概要说明：
	 *
	 * @param request
	 * @param dto TODO
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public String autoMakePaperImp(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		String v_infoId = DbUtils.getSequenceStr(); // 试卷信息id
		// 保存数据内容
		JSONArray arr = JSONArray.fromObject(dto.getPaperInfoData());
		Object[] v_objArray  = arr.toArray();
		if (v_objArray.length > 0) {
			for (int i = 0; i < v_objArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
				String qsnType = v_obj.getString("qsnType"); // 试题类型
				int qsnNum = v_obj.getInt("qsnNum"); // 试题数目
				String qsnPoint = v_obj.getString("qsnPoint"); // 试题分数
				// 试卷题型对应保存
				OtsPaperQsnType v_type = new OtsPaperQsnType();
				v_type.setPaperInfoId(v_infoId); // 试卷id
				v_type.setQsnTypePosition(Integer.toString(i + 1)); // 试题所处试卷位置
				v_type.setQsnTypeTitle(v_obj.getString("qsnTypeTitle")); // 试题名称
				v_type.setQsnType(qsnType); // 试题类型
				v_type.setQsnPoint(qsnPoint); // 每类试题分值
				v_type.setAae011(vSysUser.getUserid()); // 经办人
				v_type.setAae036(v_dbDatetime); // 经办时间
				dao.insert(v_type);
				// 试卷内容保存 
				List<OtsQuestionsInfoDTO> qsnList = queryRandQuestions(qsnType, qsnNum);
				for (int j = 0; j < qsnList.size(); j++) {
					OtsPaperContent v_con = new OtsPaperContent();
					v_con.setPaperInfoId(v_infoId); // 试卷id5
					v_con.setQsnInfoId(qsnList.get(j).getQsnInfoId()); // 试题id
					v_con.setQsnTypePosition(Integer.toString(i + 1)); // 试题大题题型所处试卷位置
					v_con.setQsnInfoPosition(Integer.toString(j + 1)); // 试题所处大题位置
					v_con.setQsnInfoPoint(Integer.toString(qsnNum)); // 试题分值
					v_con.setQsnInfoType(qsnType); // 试题类型
					v_con.setAae011(vSysUser.getUserid()); // 经办人
					v_con.setAae036(v_dbDatetime); // 经办时间
					dao.insert(v_con);
				}
			}
		}
		// 对试题内容保存
		OtsPapersInfo v_info = new OtsPapersInfo();
		v_info.setPaperInfoId(v_infoId); // 试题信息id
		v_info.setPaperInfoName(dto.getPaperInfoName()); // 试卷名称
		v_info.setPaperInfoPass(dto.getPaperInfoPass()); // 及格分数
		v_info.setPaperInfoState(dto.getPaperInfoState()); // 试卷状态
		v_info.setAae011(vSysUser.getUserid()); // 经办人
		v_info.setAae036(v_dbDatetime); // 经办时间
		v_info.setAae013(dto.getAae013()); // 备注
		dao.insert(v_info); // 保存
		return v_infoId;
	}
	
	/**
	 * 
	 * queryRandQuestions的中文名称：随机选择试题
	 * 
	 * queryRandQuestions的概要说明：
	 *
	 * @param qsnType
	 * @param qsnNum
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<OtsQuestionsInfoDTO> queryRandQuestions(String qsnType, int qsnNum) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, ");
		sb.append(" info.qsn_info_desc, info.qsn_info_explain, ");
		sb.append(" info.aae013, info.aae011, info.aae036");
		sb.append(" FROM ots_questions_info info ");
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_state = '1' "); // 试题状态, 只查询启用的试题
		sb.append(" and info.qsn_info_type = '").append(qsnType).append("' "); // 试题类型
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, OtsQuestionsInfoDTO.class);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class);
		List<OtsQuestionsInfoDTO> list = (List) m.get(GlobalNames.SI_RESULTSET);
		Collections.shuffle(list); // 首先对list进行一下随机排序
		List  praList = new ArrayList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < qsnNum; i++) {
				praList.add(list.get(i));
			}
		}
		return praList;
	}
	
	/**
	 * 
	 * queryPaperInfoObj的中文名称：查询试卷信息
	 * 
	 * queryPaperInfoObj的概要说明：试卷所包含大题类型及大题所包含试题信息
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPaperInfoObj(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		// 试卷信息
		OtsPapersInfo paperInfo = dao.fetch(OtsPapersInfo.class, dto.getPaperInfoId());
		// 试卷试题数组
		JSONArray paperQsnArr = new JSONArray();
		// 试卷题型对应(每套试卷包含哪些类型的大题)
		List<OtsPaperQsnType> v_types = dao.query(OtsPaperQsnType.class, 
				Cnd.where("paper_info_id", "=", dto.getPaperInfoId()).asc("qsn_type_position"));
		for (int i = 0; i < v_types.size(); i++) {
			OtsPaperQsnType v_type = v_types.get(i);
			JSONObject parentObj = new JSONObject();
			parentObj.accumulate("qsnType", v_type.getQsnType()); // 试题类型
			parentObj.accumulate("qsnTypeTitle", v_type.getQsnTypeTitle()); // 试题名称
			parentObj.accumulate("qsnTypePosition", v_type.getQsnTypePosition()); // 试题所处试卷位置
			parentObj.accumulate("qsnPoint", v_type.getQsnPoint()); // 试题分值(每题)
			// 子节点数据(每类大题所包含试题内容)
			JSONArray childrenArr = new JSONArray();
			List<OtsPaperContent> v_cons = dao.query(OtsPaperContent.class, 
					Cnd.where("paper_info_id", "=", dto.getPaperInfoId())
						.and("qsn_type_position", "=", v_type.getQsnTypePosition()).asc("qsn_info_position"));
			for (int j = 0; j < v_cons.size(); j++) {
				OtsPaperContent v_con = v_cons.get(j);
				JSONObject childObj = new JSONObject();
				childObj.accumulate("qsnType", v_con.getQsnInfoType()); // 试题类型
				childObj.accumulate("qsnTypePosition", v_con.getQsnInfoId()); // 试题所处试卷位置
				childObj.accumulate("qsnPoint", v_con.getQsnInfoPoint()); // 试题分值
				// 试题信息（用于查询试题题干描述，用于编辑展示用）
				OtsQuestionsInfo qsnInfo = dao.fetch(OtsQuestionsInfo.class, v_con.getQsnInfoId());
				childObj.accumulate("qsnTypeTitle", qsnInfo.getQsnInfoDesc()); // 试题名称（试题题干描述）
				childrenArr.add(childObj);
			}
			parentObj.accumulate("children", childrenArr); // 大题类型子节点
			paperQsnArr.add(parentObj);
		}
		Map map = new HashMap();
		map.put("paperInfo", paperInfo); // 试卷信息
		map.put("paperInfoData", paperQsnArr.toString()); // 试题信息
		return map;
	}
	
	/**
	 * 
	 * showPaperInfo的中文名称：试卷预览
	 * 
	 * showPaperInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map showPaperInfo(HttpServletRequest request, OtsPapersInfoDTO dto) throws Exception {
		// 返回的数据
		Map retMap = new HashMap();
		// 试卷信息
		OtsPapersInfo paperInfo = dao.fetch(OtsPapersInfo.class, dto.getPaperInfoId());
		// 试卷信息集合
		List paperInfoList = new ArrayList();
		// 试卷题型对应(每套试卷包含哪些类型的大题)
		List<OtsPaperQsnType> v_types = dao.query(OtsPaperQsnType.class, 
				Cnd.where("paper_info_id", "=", dto.getPaperInfoId()).asc("qsn_type_position"));
		for (int i = 0; i < v_types.size(); i++) {
			// 获取到试卷大题类型
			OtsPaperQsnType v_type = v_types.get(i);
			JSONObject typeObj = new JSONObject();
			typeObj.accumulate("paperQsnType", v_type);
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
				// 试题内容信息
				qsnObj.accumulate("qsnInfo", qsnInfo); 
				qsnObj.accumulate("qsnDataList", queryQuestionInfoObj(v_con.getQsnInfoId())); 
				qsnInfoList.add(qsnObj);
			}
			typeObj.accumulate("qsnInfoList", qsnInfoList); // 每类大题所包含试题
			paperInfoList.add(typeObj);
		}
		retMap.put("paperInfo", paperInfo); // 试卷信息
		retMap.put("paperInfoList", paperInfoList); // 试题信息
		return retMap;
	}
	
	/**
	 * 
	 * queryQuestionInfoObj的中文名称：查询试题选项信息
	 * 
	 * queryQuestionInfoObj的概要说明：用于试卷内容展示
	 *
	 * @param qsnId 试题id
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	public List<OtsQuestionsData> queryQuestionInfoObj(String qsnId) throws Exception {
		// 试题选项信息
		List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class, 
				Cnd.where("qsn_info_id", "=", qsnId).asc("qsn_data_sort"));
		return dataList;
	}
	
	/**
	 * 
	 * delPaperInfos的中文名称：删除试卷信息
	 * 
	 * delPaperInfos的概要说明：
	 *
	 * @param request
	 * @return
	 *        Written by : zy
	 */
	public String delPaperInfos(HttpServletRequest request) {
		try {
			delPaperInfosImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delPaperInfosImp的中文名称：删除试卷信息方法实现
	 * 
	 * delPaperInfosImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void delPaperInfosImp(HttpServletRequest request) throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<OtsPapersInfoDTO> infoList = Json.fromJsonAsList(OtsPapersInfoDTO.class, JsonStr);
		for (int i = 0; i < infoList.size(); i++) {
			OtsPapersInfoDTO info = (OtsPapersInfoDTO) infoList.get(i);
			// 删除试卷
			dao.clear(OtsPapersInfo.class, Cnd.where("paper_info_id", "=", info.getPaperInfoId()));
			// 删除试卷题型对应关系
			dao.clear(OtsPaperQsnType.class, Cnd.where("paper_info_id", "=", info.getPaperInfoId()));
			// 删除试卷内容
			dao.clear(OtsPaperContent.class, Cnd.where("paper_info_id", "=", info.getPaperInfoId()));
		}
	}
	
	/**
	 * 
	 * queryQsnNumOfType的中文名称：查询各类型试题条数
	 * 
	 * queryQsnNumOfType的概要说明：自动组卷使用
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQsnNumOfType(HttpServletRequest request, OtsQuestionsInfoDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select oqi.qsn_info_type, getAa10_aaa103('QSNLX', oqi.qsn_info_type) name, ");
		sb.append(" COUNT(oqi.qsn_info_id) num ");
		sb.append(" FROM ots_questions_info oqi ");
		sb.append(" where 1=1 ");
		sb.append(" AND oqi.qsn_info_state = '1' "); // 排除禁用试题
		sb.append(" GROUP BY oqi.qsn_info_type ");
		sb.append(" ORDER BY oqi.qsn_info_type ");
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		String sqlString = QueryFactory.getSQL(sb.toString(), paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
}
