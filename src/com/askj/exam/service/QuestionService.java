package com.askj.exam.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.askj.exam.dto.OtsQuestionsInfoDTO;
import com.askj.exam.entity.OtsPaperContent;
import com.askj.exam.entity.OtsQuestionTrade;
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
 *  QuestionService的中文名称：考试子系统-试题管理
 *
 *  QuestionService的描述：
 *
 *  @author : zy
 */
@IocBean
public class QuestionService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(QuestionService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryQuestionInfos的中文名称：查询试题列表信息
	 * 
	 * queryQuestionInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQuestionInfos(HttpServletRequest request, OtsQuestionsInfoDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select info.qsn_info_id, info.qsn_info_type, info.qsn_info_state, ");
		sb.append(" info.qsn_info_preview, info.qsn_info_desc, info.qsn_info_rule, ");
		sb.append(" info.aae013, info.aae036, info.qsn_info_trade, ");
		sb.append(" (SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = info.aae011) aae011");
		sb.append(" FROM ots_questions_info info ");  
		sb.append(" where 1=1 ");
		sb.append(" and info.qsn_info_type = :qsnInfoType ");
		if (dto.getQsnInfoTrade() != null && !"".equals(dto.getQsnInfoTrade())) {
			sb.append(" and find_in_set('" + dto.getQsnInfoTrade() + "', info.qsn_info_trade) ");
		}
		
		sb.append(" and info.qsn_info_state = :qsnInfoState "); // 试题状态,0=禁用,1=启用(选择试题时，查询启用的)
		sb.append(" order by qsn_info_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "qsnInfoType", "qsnInfoState" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsQuestionsInfoDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * saveQuestionInfo的中文名称：保存试题
	 * 
	 * saveQuestionInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveQuestionInfo(HttpServletRequest request, OtsQuestionsInfoDTO dto) {
		try {
			saveQuestionInfoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveQuestionInfoImp的中文名称：保存试题方法实现
	 * 
	 * saveQuestionInfoImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveQuestionInfoImp(HttpServletRequest request, OtsQuestionsInfoDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
		String v_infoId =  (dto.getQsnInfoId() != null && !"".equals(dto.getQsnInfoId())) ? 
			 dto.getQsnInfoId() : DbUtils.getSequenceStr(); // 试题信息id
		// 对试题内容先删除，再保存
		dao.clear(OtsQuestionsData.class, Cnd.where("qsn_info_id", "=", v_infoId));
		
		String optionsStr = request.getParameter("optionsStr"); // 选项(A.B.C或1.2.3等)
		String[] optionArr = optionsStr.split(","); // 选项数组
		String[] optiondescArr = dto.getQsnDataOptiondescArr(); // 选项描述数组
		if (!"".equals(optionsStr)) {
			for (int i = 0; i < optionArr.length; i++) {
				String v_dataId = DbUtils.getSequenceStr(); // id
				OtsQuestionsData v_data = new OtsQuestionsData();
				v_data.setQsnDataId(v_dataId); // id
				v_data.setQsnInfoId(v_infoId); // 试题信息id
				v_data.setAae011(vSysUser.getUserid()); // 经办人
				v_data.setAae036(v_dbDatetime); // 经办时间
				v_data.setQsnDataOptiondesc(optiondescArr[i]); // 组件参数[选项描述]
				v_data.setQsnDataOption(optionArr[i]); // 组件参数[选项]
				// 如果试题类型为选择题或者判断题
				if ("1".equals(dto.getQsnInfoType()) || "2".equals(dto.getQsnInfoType())
						|| "3".equals(dto.getQsnInfoType())) {
					String isanswersStr = request.getParameter("isanswersStr"); // 选项选择结果
					String[] isanswerArr = isanswersStr.split(","); // 选中结果数组
					v_data.setQsnDataIsanswer(isanswerArr[i]); // 组件参数[是否为答案]
					String[] sortArr = dto.getQsnDataSort().split(","); // 当前结构在整体的位置
					v_data.setQsnDataSort(sortArr[i]);
				} else {
					v_data.setQsnDataIsanswer("1"); // 组件参数[是否为答案]，默认为答案
					v_data.setQsnDataSort("" + i); // 当前结构在整体的位置
				}
				dao.insert(v_data);
			}
		}
		// 试题预览信息
		StringBuffer previewInfo = new StringBuffer();
		previewInfo.append(dto.getQsnInfoDesc() + "</br>"); // 试题描述
		List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class, 
				Cnd.where("qsn_info_id", "=", v_infoId).asc("qsn_data_sort"));
		for (int i = 0; i < dataList.size(); i++) {
			OtsQuestionsData data = dataList.get(i);
			previewInfo.append(data.getQsnDataOptiondesc()); // 选项描述
			previewInfo.append("</br>"); // 换行
			previewInfo.append(data.getQsnDataIsanswer()); // 是否为答案
			previewInfo.append("</br>"); // 换行
		}
		
		// 对试题内容保存
		// 如果id存在，更新
		if (dto.getQsnInfoId() != null && !"".equals(dto.getQsnInfoId())) {
			// 试题对象
			OtsQuestionsInfo v_info = dao.fetch(OtsQuestionsInfo.class, dto.getQsnInfoId());
			v_info.setQsnInfoState(dto.getQsnInfoState()); // 试题状态
			v_info.setQsnInfoDesc(dto.getQsnInfoDesc()); // 试题题干描述
			v_info.setQsnInfoType(dto.getQsnInfoType()); // 试题类型
			v_info.setQsnInfoExplain(dto.getQsnInfoExplain()); // 试题答案解释
			v_info.setQsnInfoRule(dto.getQsnInfoRule()); // 试题判分规则
			v_info.setQsnInfoTrade(dto.getQsnInfoTrade()); // 试题大类 
			v_info.setQsnInfoPreview(previewInfo.toString()); // 试题预览信息
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			v_info.setAae013(dto.getAae013()); // 备注
			dao.update(v_info); // 保存
		} else {
			// 试题对象
			OtsQuestionsInfo v_info = new OtsQuestionsInfo();
			v_info.setQsnInfoId(v_infoId); // 试题信息id
			v_info.setQsnInfoState(dto.getQsnInfoState()); // 试题状态
			v_info.setQsnInfoDesc(dto.getQsnInfoDesc()); // 试题题干描述
			v_info.setQsnInfoType(dto.getQsnInfoType()); // 试题类型
			v_info.setQsnInfoExplain(dto.getQsnInfoExplain()); // 试题答案解释
			v_info.setQsnInfoRule(dto.getQsnInfoRule()); // 试题判分规则
			v_info.setQsnInfoTrade(dto.getQsnInfoTrade()); // 试题大类
			v_info.setQsnInfoPreview(previewInfo.toString()); // 试题预览信息
			v_info.setAae011(vSysUser.getUserid()); // 经办人
			v_info.setAae036(v_dbDatetime); // 经办时间
			v_info.setAae013(dto.getAae013()); // 备注
			dao.insert(v_info); // 保存
		}
		// 试题知识点
		dao.clear(OtsQuestionTrade.class, Cnd.where("qsn_id", "=", v_infoId));
		String[] qsnTrade = dto.getQsnInfoTrade().split(",");
		for (int i = 0; i < qsnTrade.length; i++) {
			OtsQuestionTrade oqt = new OtsQuestionTrade();
			oqt.setQsnId(v_infoId); // 试题id
			oqt.setQsnTrade(qsnTrade[i]);
			oqt.setQsnTradeId(DbUtils.getSequenceStr());
			dao.insert(oqt);
		}
	}
	
	/**
	 * 
	 * queryQuestionInfoObj的中文名称：考试试题预览
	 * 
	 * queryQuestionInfoObj的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQuestionInfoObj(OtsQuestionsInfoDTO dto) throws Exception {
		// 试题信息
		OtsQuestionsInfo info = dao.fetch(OtsQuestionsInfo.class, dto.getQsnInfoId());
		// 试题选项信息
		List<OtsQuestionsData> dataList = dao.query(OtsQuestionsData.class, 
				Cnd.where("qsn_info_id", "=", dto.getQsnInfoId()).asc("qsn_data_sort"));
		Map map = new HashMap();
		map.put("info", info); // 试题信息
		map.put("dataList", dataList); // 试题选项信息
		return map;
	}
	
	/**
	 * 
	 * delQusetionInfos的中文名称：删除试题信息
	 * 
	 * delQusetionInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : zy
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	public Map delQusetionInfos(HttpServletRequest request) throws Exception {
		return delQusetionInfosImp(request);
	}
	
	/**
	 * 
	 * delQusetionInfosImp的中文名称：删除试题信息方法实现
	 * 
	 * delQusetionInfosImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map delQusetionInfosImp(HttpServletRequest request) throws Exception {
		Map map = new HashMap();
		String JsonStr = request.getParameter("JsonStr");
		List<OtsQuestionsInfoDTO> infoList = Json.fromJsonAsList(OtsQuestionsInfoDTO.class, JsonStr);
		for (int i = 0; i < infoList.size(); i++) {
			OtsQuestionsInfoDTO info = (OtsQuestionsInfoDTO) infoList.get(i);
			// 判断试卷中是否包含试题(包含：不能删除；不包含：可以删除)
			boolean flag = isPaperIncludeQsn(info.getQsnInfoId());
			if (flag) {
				map.put("msg", "该试题被引用，无法删除！");
				map.put("code", "-1");
			} else {
				// 删除试题数据
				dao.clear(OtsQuestionsData.class, Cnd.where("qsn_info_id", "=", info.getQsnInfoId()));
				// 删除试题信息
				dao.clear(OtsQuestionsInfo.class, Cnd.where("qsn_info_id", "=", info.getQsnInfoId()));
				map.put("msg", "删除成功！");
				map.put("code", "0");
			}
		}
		return map;
	}
	
	/**
	 * 
	 * queryQsnTrade的中文名称：查询试题知识点
	 * 
	 * queryQsnTrade的概要说明：将知识点以combotree下拉树的json格式返回
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes"})
	public JSONArray queryQsnTrade(HttpServletRequest request) throws Exception {
		
		String sql = "SELECT a.aaa102, a.aaa103, a.aaa104 FROM aa10 a WHERE a.AAA100 = 'EXAMTRADE' and a.aaa104 = '1'  ";
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				Map p = (Map) ls.get(i);
				sb.append("{");
				sb.append("\"id\":\"" + p.get("aaa102") + "\",");
				sb.append("\"text\":\"" + p.get("aaa103") + "\"");
				String sql2 = "SELECT a.aaa102, a.aaa103, a.aaa104 FROM aa10 a " +
						"WHERE a.AAA100 = 'EXAMTRADE' and a.aaa104 = '" + p.get("aaa102") + "'";
				Map m2 = DbUtils.DataQuery(GlobalNames.sql, sql2, null, null);
				List ls2 = (List) m2.get(GlobalNames.SI_RESULTSET);
				for (int j = 0; j < ls2.size(); j++) {
					Map p2 = (Map) ls2.get(j);
					if (j == 0 && ls2.size() > 0) {
						sb.append(", children : [");
						sb.append("{");
						sb.append("\"id\":\"" + p2.get("aaa102") + "\",");
						sb.append("\"text\":\"" + p2.get("aaa103") + "\"");
						sb.append("},");
					} else if (j != 0 && (j == ls2.size() - 1)) {
						sb.append("{");
						sb.append("\"id\":\"" + p2.get("aaa102") + "\",");
						sb.append("\"text\":\"" + p2.get("aaa103") + "\"");
						sb.append("}]");
					} else {
						sb.append("{");
						sb.append("\"id\":\"" + p2.get("aaa102") + "\",");
						sb.append("\"text\":\"" + p2.get("aaa103") + "\"");
						sb.append("},");
					}
				}
				sb.append("},");
			}
			sb.deleteCharAt(sb.length() - 1);
			sb.append("]");
		}
		return JSONArray.fromObject(sb.toString());
	}
	
	/**
	 * 
	 * isPaperIncludeQsn的中文名称：判断试卷中是否包含试题
	 * 
	 * isPaperIncludeQsn的概要说明：如果试卷中包含试题，不允许删除该试题
	 *
	 * @param qsnInfoId
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public boolean isPaperIncludeQsn(String qsnInfoId) throws Exception {
		
		// 试题选项信息
		List<OtsPaperContent> list = dao.query(OtsPaperContent.class, 
				Cnd.where("qsn_info_id", "=", qsnInfoId));
		boolean flag = false;
		if (list != null && list.size() > 0) {
			flag = true;
		}
		return flag;
	}
}
