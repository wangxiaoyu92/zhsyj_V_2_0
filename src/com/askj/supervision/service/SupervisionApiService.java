package com.askj.supervision.service;

import com.askj.baseinfo.dto.OmLawContentDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.supervision.ConstSupervison;
import com.askj.supervision.dto.*;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.supervision.entity.Bscheckpicset;
import com.askj.supervision.entity.Pcompanynddtpj;
import com.askj.supervision.entity.Pcomriskconfirm;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.DateUtil;
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
import java.text.SimpleDateFormat;
import java.util.*;


public class SupervisionApiService{
	protected final Logger logger = Logger.getLogger(SupervisionApiService.class);

	@Inject
	private Dao dao;

	/**
	 *
	 * getPlanListByCompany的中文名称：根据企业类别获取相关的计划列表（查询结果）和企业id
	 *
	 * getPlanListByCompany的概要说明：根据企业类型和企业id查询计划信息和结果状态
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getPlanListByCompany(HttpServletRequest request, BscheckplanDTO dto)
			throws Exception {
		// 获取用户id
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));

		if ("".equals(userid)) {
			throw new BusinessException("用户ID不能为空！");
		}

		//gu20180331重写获取计划
		// 是否启用[安全监管任务分派功能]
		Aa01 aa01 = SysmanageUtil.getAa01("SFQYAQJGRWFP");
		//SFQYAQJGRWFP 的 aaa005为1时表示启用[安全监管任务分派功能]
		boolean isTaskDistributOn = aa01.getAaa005() != null && "1".equals(aa01.getAaa005());
		//获取该企业的本年度量化等级
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		String v_comLhfjndpddj="wu";
		List<Pcompanynddtpj> v_dtpjList=(List<Pcompanynddtpj>)DbUtils.getDataList("select a.* from Pcompanynddtpj a where a.comid='"+dto.getComid()
																						  +"' and a.pdyear='"+v_year+"'",Pcompanynddtpj.class);
		if (v_dtpjList!=null && v_dtpjList.size()>0){
			Pcompanynddtpj v_Pcompanynddtpj=v_dtpjList.get(0);
			v_comLhfjndpddj=v_Pcompanynddtpj.getLhfjndpddj();
		}

		StringBuffer sb = new StringBuffer("select a.*,fun_getItemidFromPlanid(a.planid) as itemid from bscheckplan a ");
		sb.append(" where a.planstdate<=now() and a.planeddate>=now() ");
		sb.append(" and a.plancontrol='0' ");
		sb.append(" and exists (select 1 from pcompanycomdalei t1 " +
						  " where find_in_set(t1.aaz093,a.plantypearea) " +
						  " and t1.comid=:comid)");
//		sb.append(" and exists (select 1 from pcompanycomdalei t1,viewcomfenlei t2 " +
//						  " where t1.comdalei=t2.aaa102 and find_in_set(t2.aaz093,a.plantypearea) " +
//						  " and t1.comid=:comid)");
		if (!"wu".equals(v_comLhfjndpddj)){
			sb.append(" and (a.lhfjndpddj='"+v_comLhfjndpddj+"' or a.lhfjndpddj is null or length(lhfjndpddj)=0)");
		}
		if (isTaskDistributOn){
			sb.append(" and exists (select 1 from bschecktask t3, bschecktaskperson t4 where t3.planid=a.planid and t3.taskid=t4.taskid and t4.userid='"+userid+"' )");
		}
		sb.append(" order  by a.planid desc ");//end StringBuffer

/*		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyy-MM-dd");
		sb.append(" select DISTINCT a.*,e.itemid from bscheckplan a,  ");
		// 和pcompanynddtpj表关联，是因为要首先进行量化评定后，根据评定等级进行计划检查
		sb.append(" (SELECT aa.AAZ093,p2.lhfjndpddj  FROM pcompany p, pcompanycomdalei p1, aa10 aa, pcompanynddtpj p2 " );
		sb.append("  WHERE p.comid = p1.comid AND p1.comdalei = aa.AAA102 AND p.comid = p2.comid " );
		sb.append("  AND p2.pdyear = '").append(String.valueOf(DateUtil.convertDateToYear(new Date()))).append("'");
		sb.append("  AND aa.AAA100 = 'comdalei' AND p.comid =:comid ) o,  ");
		if (isTaskDistributOn) { // 如果启用[安全监管任务分派功能]
			sb.append(" bschecktask b, bschecktaskperson per, ");
		}
		sb.append(" ( select DISTINCT bc.planid ,c.itempid as itemid  from  bscheckpicset bc ,omcheckgroup c  ");
		sb.append(" where bc.itemid = c.itemid ");
		sb.append(" and c.itempid in( select t.itemtype as itemid from aa10 aaa, ombasetype t,omcheckgroup g ");
		sb.append(" where aaa.AAA100 ='COMDALEI' and aaa.AAZ093 = t.basetype and g.itemid = t.itemtype  ");
		if (dto.getItemid() != null && !"".equals(dto.getItemid())) {
			sb.append(" and g.itempid = '").append(dto.getItemid()).append("' ");
		}
		sb.append("    )) e  ");
		sb.append(" where find_in_set(o.AAZ093, a.plantypearea)  AND a.planid = e.planid ");
		// 查询处于检查时间段内的计划
		sb.append("  AND a.planstdate <= '").append(matter1.format(new Date()));
		sb.append("' AND a.planeddate >= '").append(matter1.format(new Date()));
		// 日常类型的只查看对应量化等级的检查，其它类型的可以查看所有
		sb.append("' AND (a.lhfjndpddj = o.lhfjndpddj OR a.planchecktype <> '1') ");
		if (isTaskDistributOn) {// 如果启用[安全监管任务分派功能]
			sb.append(" AND a.planid = b.planid AND b.taskid = per.taskid AND per.userid = '").append(userid).append("' ");
		}
		sb.append(" order  by a.planid desc ");//end StringBuffer*/
		String sql = sb.toString();
		String[] paramName = new String[] { "comid"};
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	/**
	 *
	 * getPlanListByCompany的中文名称：根据企业类别获取相关的计划列表（查询结果）和企业id
	 *
	 * getPlanListByCompany的概要说明：根据企业类型和企业id查询计划信息和结果状态
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getPlanListByCompany_20180331(HttpServletRequest request, BscheckplanDTO dto)
			throws Exception {
		// 获取用户id
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));

		if ("".equals(userid)) {
			throw new BusinessException("用户ID不能为空！");
		}

		// 是否启用[安全监管任务分派功能]
		Aa01 aa01 = SysmanageUtil.getAa01("SFQYAQJGRWFP");
		//SFQYAQJGRWFP 的 aaa005为1时表示启用[安全监管任务分派功能]
		boolean isTaskDistributOn = aa01.getAaa005() != null && "1".equals(aa01.getAaa005());

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,e.itemid from bscheckplan a,  ");

		if (isTaskDistributOn) { // 如果启用[安全监管任务分派功能]
			sb.append(" bschecktask b, bschecktaskperson per, ");
		}

		sb.append(" ( select DISTINCT b.planid ,c.itempid as itemid  from  bscheckpicset b ,omcheckgroup c  ");
		sb.append(" where b.itemid = c.itemid ");
		sb.append(" and c.itempid in( select o.itemtype as itemid from aa10 b, ombasetype o,omcheckgroup c ");
		sb.append(" where AAA100 ='COMDALEI' and b.AAZ093 = o.basetype and c.itemid=o.itemtype and ");
		sb.append(" c.itempid =:itemid  and b.AAZ093=:aaz093 and 1=1 order by b.AAA102 desc ");
		sb.append("  ) and 1=1 ) e  ");
		sb.append(" where a.planid =e.planid and find_in_set(:aaz093,a.plantypearea)  ");

		if (isTaskDistributOn) {// 如果启用[安全监管任务分派功能]
			sb.append(" AND a.planid = b.planid AND b.taskid = per.taskid AND per.userid = '").append(userid).append("' ");
		}
		sb.append(" order  by a.planid desc ");//end StringBuffer
		String sql = sb.toString();
		String[] paramName = new String[] { "comid", "itemid","aaz093" ,"aaz093" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR ,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * getCheckHistoryListByPlan的中文名称：根据计划得到历史计划检查记录
	 *
	 * getCheckHistoryListByPlan的概要说明：根据企业id计划id查询企业检查历史
	 *
	 * @param request 请求对象
	 * @param dto 检查结果DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckHistoryListByPlan(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.planid,b.plantitle ,fun_getItemidFromPlanid(a.planid) as itemid,b.planchecktype,a.resultid, a.operatedate  ,a.resultdate , a.resultstate, a.resultremark , ");
		sb.append("(select CONCAT(c.username,'(',c.DESCRIPTION,')') from sysuser c where c.userid=a.operateperson )  as operateperson ");
		sb.append(" from bscheckmaster a , bscheckplan b ");
		sb.append("where a.planid=b.planid   ");//and a.resultstate <> 1
		sb.append(" and b.plancontrol<>'1' ");//gu20180712
		sb.append("  and a.operatedate like :year  ");
		sb.append("and a.comid  =:comid  ");
		sb.append("  and a.planid=:planid  ");
		sb.append("  and a.qtbwid=:qtbwid  ");
		sb.append("  and b.planchecktype = :planchecktype ");
		sb.append("order by  a.operatedate desc,a.resultstate");
		String sql = sb.toString();
		String[] paramName = new String[] { "year", "comid","planid","qtbwid","planchecktype"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * getCheckDetailListByCheckHistory的中文名称：根据检查历史相关信息获取相关的执法项内容
	 *
	 * getCheckDetailListByCheckHistory的概要说明： 根据企业类型,企业id和计划id获取检查项目明细 itemid:
	 * 企业类型ID planid: 计划ID comid:企业id resultid:结果id 手机--(聚餐申报：
	 * 传入计划id,聚餐id和企业类别（itemid）)
	 *
	 * @param request
	 *            请求对象
	 * @param dto
	 *            检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckDetailListByCheckHistory(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
		// 是否合并检查计划
		String isMergePlans = StringHelper.showNull2Empty(request.getParameter("isMergePlans"));
		if ("true".equals(isMergePlans)) {
			// 当合并检查时，获取其中一个检查的检查项历史进行检查
			String[] resultids = dto.getResultid().split(",");
			String[] planids = dto.getPlanid().split(",");
			dto.setResultid(resultids[0]);
			dto.setPlanid(planids[0]);
		}
		int planchecnnum = getplanChecknum(dto);//检查总数
		int resultchecnnum = getresultChecknum(dto);//实际检查总数

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select g.*,IFNULL(h.detaildecide,'') as detaildecide,IFNULL(h.detailscore,0) as detailscore   from (select c.itemid ,c.itemname, c.itemsortid,");
		sb.append(" d.contentid,d.content,d.contentsortid,d.contentscore ,d.contentcode ,d.contentimpt,d.jianchazhinancount from omcheckgroup c ,");
		sb.append(" ( select a.*,(select count(1) from omcheckcontentbasisrt t where t.contentid=a.contentid) as jianchazhinancount from omcheckcontent a ,bscheckpicset b where a.contentid = b.contentid ");
		sb.append(" and b.planid= :planid and 1=1) d where c.itemid = d.itemid  ");
		sb.append(" and c.itempid = :itemid and 1=1 ) g  left join  ( ");
		if (dto.getResultid() != null && !"".equals(dto.getResultid())) {
			sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckmaster e ,bscheckdetail f ");
			//gu20180512 sb.append("where e.resultid = f.resultid and  e.resultstate<>4 and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");
			sb.append("where e.resultid = f.resultid and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");//and  e.resultstate<>4
		} else {
			// 查询结果记录中最晚时间结束的结果项
			if (resultchecnnum < planchecnnum && resultchecnnum != 0) {// 已经完成中，最后的结果不是检查完
				sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckdetail f , ");
				sb.append(" ( select l.resultid from bscheckmaster l ,( select MAX(k.resultdate) as resultdate ,k.resultid from bscheckmaster k where ");
				sb.append(" k.planid=:planid and k.comid=:comid  and 1=1");
				sb.append(" ) p where l.resultdate = p.resultdate ) j where f.resultid=j.resultid ");
			} else {
				sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckmaster e ,bscheckdetail f ");
				//gu20180512 sb.append("where e.resultid = f.resultid and  e.resultstate<>4 and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");
				sb.append("where e.resultid = f.resultid  and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");//and  e.resultstate<>4

			}
		}
		sb.append(" ) h on g.contentid = h.contentid order by g.itemsortid,g.contentsortid");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "planid", "itemid", "resultid",
				"planid", "comid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

		return map;
	}

	/**
	 *
	 * getCheckDetailListByCheckHistory的中文名称：根据检查历史相关信息获取相关的执法项内容
	 *
	 * getCheckDetailListByCheckHistory的概要说明：
	 * 		   根据企业类型,企业id和计划id获取检查项目明细
	 * 				itemid: 企业类型ID
	 *				planid: 计划ID
	 *              comid:企业id
	 *              resultid:结果id
	 * 			手机--(聚餐申报： 传入计划id,聚餐id和企业类别（itemid）)
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckDetailListByCheckHistory_20180427(HttpServletRequest request,
												BscheckplanDTO dto) throws Exception {
		int planchecnnum=getplanChecknum(dto);//检查总数
		int resultchecnnum=getresultChecknum(dto);//实际检查总数

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select g.*,IFNULL(h.detaildecide,'') as detaildecide,IFNULL(h.detailscore,0) as detailscore   from (select c.itemid ,c.itemname, c.itemsortid,");
		sb.append(" d.contentid,d.content,d.contentsortid,d.contentscore ,d.contentcode ,d.contentimpt from omcheckgroup c ,");
		sb.append(" ( select a.* from omcheckcontent a ,bscheckpicset b where a.contentid = b.contentid ");
		sb.append(" and b.planid= :planid and 1=1) d where c.itemid = d.itemid  ");
		sb.append(" and c.itempid = :itemid and 1=1 ) g  left join  ( ");
		if(dto.getResultid()!=null &&!"".equals(dto.getResultid())){
			sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckmaster e ,bscheckdetail f ");
			//gu20180420 sb.append("where e.resultid = f.resultid and  e.resultstate<>4 and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");
			sb.append("where e.resultid = f.resultid and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");
		}else {
			//查询结果记录中最晚时间结束的结果项
			if(resultchecnnum<planchecnnum && resultchecnnum!=0){//已经完成中，最后的结果不是检查完
				sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckdetail f , ");
				sb.append(" ( select l.resultid from bscheckmaster l ,( select MAX(k.resultdate) as resultdate ,k.resultid from bscheckmaster k where ");
				sb.append(" k.planid=:planid and k.comid=:comid  and 1=1");
				sb.append(" ) p where l.resultdate = p.resultdate ) j where f.resultid=j.resultid ");
			}else {
				sb.append(" select DISTINCT f.contentid , f.detaildecide,f.detailscore from bscheckmaster e ,bscheckdetail f ");
				sb.append("where e.resultid = f.resultid and  e.resultstate<>4 and  e.resultid=:resultid and e.planid= :planid and e.comid= :comid and 1=1 ");

			}
		}
		sb.append(" ) h on g.contentid = h.contentid order by g.itemsortid,g.contentsortid");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "planid", "itemid","resultid", "planid",
				"comid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

		return map;
	}
	/**
	 *
	 * getCheckDetailByResultIdAndContentId的中文名称：根据明细ID获取检查明细
	 *
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckDetailByResultIdAndContentId(BsCheckDetailDTO dto) throws Exception {

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT * FROM bscheckdetail b ");
		sb.append(" WHERE b.resultid = :resultid ");
		sb.append(" AND b.contentid = :contentid");

		String sql = sb.toString();

		String[] paramName = new String[] { "resultid", "contentid"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  BsCheckDetailDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 *
	 * getCheckProblemListByDetailId的中文名称：
	 *
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckProblemListByContentId(HttpServletRequest request,
											  OmcheckbasisDTO dto) throws Exception {

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();

		sb.append("SELECT             ");
		sb.append("  p.problemdesc,p.problemid");
		if(null != dto.getResultid() && !"".equals(dto.getResultid())){
			sb.append("  ,(SELECT case when INSTR(b.detailng,p.problemid)>0 then 1 ELSE 0 end FROM bscheckdetail b WHERE b.resultid=:resultid and b.contentid =:contentid)  selected ");
		}
		sb.append("  FROM omcheckcontentbasisrt br,omcheckbasisproblemrt bpr,omcheckproblem p ");
		sb.append("  WHERE                                                                      ");
		sb.append("  br.basisid = bpr.basisid AND bpr.problemid = p.problemid ");
		sb.append("  and br.contentid =:contentid and p.problemid =:problemid  order by p.problemid");
		String sql = sb.toString();
		// 转化sql语句

		String[] paramName = new String[] { "resultid", "contentid", "problemid"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  OmcheckproblemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

		return map;
	}

	/**
	 *
	 * getCheckProblemListByDetailId的中文名称：
	 *
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getCheckBasisListByProblemIdOrContentId(HttpServletRequest request,
													   OmcheckbasisDTO dto) throws Exception {

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
//		sb.append("  SELECT distinct o4.contentid,o4.content,o.basisdesc,o.typedesc,o5.basisid, ");
//		sb.append("  o.guide,o.punishmeasures, GROUP_CONCAT(p.problemdesc, ' ')  problemdesc ");
//		sb.append("  FROM omcheckcontent o4,omcheckcontentbasisrt o5,omcheckbasis o, ");
//		sb.append("  omcheckbasisproblemrt o2,omcheckproblem p ");
//		sb.append("  WHERE o4.contentid = o5.contentid AND o5.basisid = o.basisid ");
//		sb.append("  AND o.basisid = o2.basisid AND o2.problemid = p.problemid ");
//		sb.append("  and o4.contentid = :contentid  ");
//		sb.append("  and o2.problemid = :problemid ");
//		sb.append("  and 1=1 GROUP BY o.basisid  ");
//		sb.append("  order by o.sort asc  ");
		sb.append("  SELECT DISTINCT o4.contentid,o4.content,o.basisdesc,o.typedesc,o5.basisid, ");
		sb.append("  o.guide,o.punishmeasures,GROUP_CONCAT(p.problemdesc, ' ') problemdesc ");
		sb.append("  FROM omcheckcontent o4 LEFT JOIN omcheckcontentbasisrt o5 ");
		sb.append("   ON o4.contentid = o5.contentid LEFT JOIN omcheckbasis o ");
		sb.append("  ON o5.basisid = o.basisid LEFT JOIN omcheckbasisproblemrt o2 ");
		sb.append("  ON o.basisid = o2.basisid LEFT JOIN omcheckproblem p  ");
		sb.append("  ON o2.problemid = p.problemid WHERE 1=1 ");
		sb.append("  and  o4.contentid = :contentid");
		sb.append("   and o2.problemid = :problemid ");
		sb.append("AND 1 = 1 GROUP BY o.basisid ORDER BY o.sort ASC");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] { "contentid", "problemid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OmcheckbasisDTO.class);
		List<OmcheckbasisDTO> list = (List<OmcheckbasisDTO>) m.get(GlobalNames.SI_RESULTSET);
		List<OmcheckbasisDTO> retlist = new ArrayList<OmcheckbasisDTO>();
		for(OmcheckbasisDTO omcheckbasisDTO : list){
			omcheckbasisDTO.setProblemInfo(omcheckbasisDTO.getProblemdesc());
			omcheckbasisDTO.setContentdesc(omcheckbasisDTO.getContent());
			Map map  = getLawListByBasisid(request, omcheckbasisDTO);
			List<OmLawContentDTO> lawList =(List<OmLawContentDTO>) map.get("rows");

			omcheckbasisDTO.setLawList(lawList);
			retlist.add(omcheckbasisDTO);
		}
		Map map = new HashMap();
		map.put("rows", retlist);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

		return map;
	}

	/**
	 *
	 * getLawListByBasisid的中文名称：
	 *
	 * @param request 请求对象
	 * @param dto 检查计划DTO
	 * @return Written by : sunyifeng
	 * @throws Exception
	 */
	public Map getLawListByBasisid(HttpServletRequest request,
								   OmcheckbasisDTO dto) throws Exception {

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();

		sb.append("SELECT p.contentid ,p.contentcode,p.content," +
						  "(SELECT itemname FROM omlawgroup WHERE itemid = (SELECT itempid FROM omlawgroup WHERE itemid = p.itemid)) lawname ");
		sb.append("  FROM omcheckcontentbasisrt o5,            ");
		sb.append(" omcheckbasislegalrt o1,omlawcontent p");
		sb.append("  WHERE                                                                      ");
		sb.append("  o5.basisid = o1.basisid                     ");
		sb.append("  AND o1.legalitemid = p.contentid            ");
		sb.append("  and o5.basisid =:basisid   ");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] { "basisid"};
		int[] paramType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  OmLawContentDTO.class);
		List<OmLawContentDTO> list = (List<OmLawContentDTO>) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

		return map;
	}

	/**
	 *
	 * 查询计划信息
	 * 查询指定企业未检查完的计划
	 * @param dto comid:企业ID
	 * @return
	 * @throws Exception
	 */
	public Map queryPlanListForNotFinished(HttpServletRequest request, BsCheckMaster dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select * ");
		sb.append(" from bscheckmaster a , bscheckplan b where a.planid=b.planid ");//and a.resultstate <> 1
		sb.append(" and 1=1 and a.comid  =:comid and a.resultstate <> 4 ");
		sb.append("  and a.planid=:planid order by a.operatedate ");
		String sql = sb.toString();
		String[] paramName = new String[] {"comid","planid"};
		int[] paramType = new int[] {  Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMaster.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 根据结果ID判断该结果是否存在
	 *
	 * @param dto resultid:结果ID
	 * @return　BsCheckMaster
	 * @throws Exception
	 */
	public BsCheckMaster checkMasterIsExistByresultId(HttpServletRequest request, BsCheckMaster dto)
			throws Exception {
		BsCheckMaster bsCheckMaster = dao.fetch(BsCheckMaster.class, Cnd.where("resultid", "=", dto.getResultid()));
		return bsCheckMaster;
	}


	/**
	 * 查询出结果对象
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public BsCheckMaster getResultRecord(HttpServletRequest request,
										 BsCheckMasterDTO dto) throws Exception {
		BsCheckMaster master = dao
				.fetch(BsCheckMaster.class, dto.getResultid());
		StringBuffer sb = new StringBuffer();
		sb.append("<!DOCTYPE html><html> <head><title>结果记录</title><meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
		sb.append("<meta name='Author' content=''> <meta name='Keywords' content=''> <meta name='Description' content=''>");
		sb.append("<title>Document</title></head><body>");
		if (master != null) {
			sb.append(master.getCheckresultinfo());
		} else {
			master = new BsCheckMaster();
			sb.append("暂无数据");
		}
		sb.append("</body></html>");
		master.setCheckresultinfo(sb.toString());
		return master;
	}
	/**
	 * 查询检查明细结果 结果id，(手机调用)
	 *
	 * @param dto 检查结果概要DTO
	 *            计划id
	 * @return
	 * @throws Exception
	 */
	public Map updateBsCheckMasterState(HttpServletRequest request,
										BsCheckMasterDTO dto) throws Exception {

		Map map = new HashMap();
		StringBuffer sb = new StringBuffer();
		try {
			sb.append(" select a.* from bscheckmaster a where 1=1 and  a.planid =:plaind and a.comid= :comid");
			sb.append(" order by a.planid ");
			String sql = sb.toString();
			// 转化sql语句
			String[] paramName = new String[] { "plainid", "comid" };
			int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
			sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
			System.out.println(sql);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
			List<BsCheckMaster> list = (List) m.get(GlobalNames.SI_RESULTSET);
			if (list.size() == 0) {
				map.put("msg", "没有相关数据无法进行此操作");
				map.put("success", false);
			} else {
				// 修改结果状态
				BsCheckMaster master = list.get(0);
				master.setResultstate(ConstSupervison.CheckMasterState.Committed.toString());// 结束检查
				master.setResultdate(new Date());// 结束时间

				dao.update(master);

				map.put("msg", "保存成功");
				map.put("success", true);

			}
		} catch (Exception e) {
			map.put("success", false);
			map.put("error", Lang.wrapThrow(e).getMessage());
		}
		return map;
	}

	/**
	 *计划检查项总数
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	private int  getplanChecknum(BscheckplanDTO dto ) throws Exception {

		//使用字符串缓冲器类拼接查询语句
		Cnd wh = null;
		//转化sql语句
		int li_count= dao.count(Bscheckpicset.class, wh.where("planid", "=", dto.getPlanid().trim()));
		return li_count;

	}

	/**
	 结果检查项总数
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	private int  getresultChecknum(BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from bscheckdetail c , (select l.resultid from bscheckmaster l , (select MAX(a.resultdate) as resultdate  ");
		//sb.append("  a.resultid from bscheckmaster a where  a.planid= :planid and a.comid= :comid");
		sb.append("  from bscheckmaster a where  a.planid= :planid and a.comid= :comid");
		sb.append(" ) p where l.resultdate = p.resultdate ) j where c.resultid= j.resultid ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"planid","comid"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
		int total =  (Integer) m.get(GlobalNames.SI_TOTALROWNUM);
		return total;

	}

	/**
	 * 查询检查计划
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             updata 2018-03-21 根据所属科室查询所属的检查计划
	 */
	public Map queryCheckPlan_zy(HttpServletRequest request, BscheckplanDTO dto,
								 PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT DISTINCT t.*, e.itemid FROM ( ");
		sb.append(" SELECT ou.planid,ou.plantitle,ou.planstdate,ou.planeddate,ou.lhfjdtpddj, ");
		sb.append(" ou.plantype,ou.planchecktype,ou.plancode, ou.plantypearea, ");
		// 未检查
		sb.append(" (SELECT COUNT(aws.comid) FROM (SELECT b.planid,p.comid FROM bscheckplan b,aa10 a,pcompany p ");
		sb.append(" WHERE FIND_IN_SET(a.AAA102,p.comdalei) and FIND_IN_SET(a.AAZ093,b.plantypearea ) ");
		sb.append(" AND b.planstdate <= NOW() AND b.planeddate >= NOW() ");
		sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1  "); // 是为了过滤出已量化的企业
		sb.append(" WHERE b1.comid = p.comid AND b1.planid IS NULL AND b1.resultstate = '4'  ");
		sb.append(" AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1))  ");
		sb.append(" AND  p.comid NOT IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid ");
		sb.append(" AND b1.planid = b.planid ) ) aws WHERE aws.planid = ou.planid ) unchecked, ");
		// 检查中
		sb.append(" (SELECT COUNT(1) FROM bscheckplan b,aa10 a,pcompany p  ");
		sb.append(" WHERE FIND_IN_SET(a.AAA102,p.comdalei) and FIND_IN_SET(a.AAZ093,b.plantypearea ) ");
		sb.append(" AND b.planstdate <= NOW() AND b.planeddate >= NOW() AND b.planid = ou.planid ");
		sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 "); // 是为了过滤出已量化的企业
		sb.append(" WHERE b1.comid = p.comid AND b1.planid IS NULL AND b1.resultstate = '4' ");
		sb.append(" AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1)) ");
		sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 "); // 是为了过滤出正在检查的企业
		sb.append(" WHERE b1.comid = p.comid AND b1.planid = ou.planid ");
		sb.append(" AND b1.resultstate in ('0','1','2','3','5','6'))) checking, ");
		// 已检查
		sb.append(" (SELECT COUNT(1) FROM bscheckplan b,aa10 a,pcompany p  ");
		sb.append(" WHERE FIND_IN_SET(a.AAA102,p.comdalei) and FIND_IN_SET(a.AAZ093,b.plantypearea ) ");
		sb.append(" AND b.planstdate <= NOW() AND b.planeddate >= NOW() AND b.planid = ou.planid ");
		sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 "); // 是为了过滤出已量化的企业
		sb.append(" WHERE b1.comid = p.comid AND b1.planid IS NULL AND b1.resultstate = '4' ");
		sb.append(" AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1)) ");
		sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 ");
		sb.append(" WHERE b1.comid = p.comid AND b1.planid = ou.planid AND b1.resultstate=4)) checked ");

		sb.append(" FROM bscheckplan ou where ou.planstdate < now() and ou.planeddate > now()");
		sb.append(" ) t, aa10 aaa,pcompany ppp, ");
		sb.append(" ( select DISTINCT bc.planid ,c.itempid as itemid  from  bscheckpicset bc ,omcheckgroup c ");
		sb.append(" where bc.itemid = c.itemid and c.itempid in ");
		sb.append(" ( select tt.itemtype as itemid from aa10 aaa, ombasetype tt,omcheckgroup g ");
		sb.append(" where aaa.AAA100 ='COMDALEI' and aaa.AAZ093 = tt.basetype and g.itemid = tt.itemtype)) e ");
		sb.append(" where aaa.AAA100 = 'comdalei' ");
		sb.append(" AND t.planid = e.planid ");
		sb.append(" AND FIND_IN_SET(aaa.AAA102,ppp.comdalei) and FIND_IN_SET(aaa.AAZ093,t.plantypearea ) ");
		sb.append(" AND aaa.AAA104 = :aaa104 ");
		String sql = sb.toString();
		String[] paramName = new String[] { "aaa104" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  BscheckplanDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	public Map queryCheckPlan(HttpServletRequest request,BscheckplanDTO dto,PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		//sb.append("  SELECT ou.planid,ou.plantitle,ou.planstdate, ou.planeddate,ou.plantype,ou.planchecktype,SUBSTRING(ou.plancode, 5, 2) plancode,");
		sb.append(" SELECT ou.planid,ou.plantitle,ou.planstdate,ou.planeddate,ou.lhfjndpddj, ");
		sb.append(" ou.plantype,ou.planchecktype,ou.plancode, ou.plantypearea, ");
		sb.append("	(SELECT count(p.comid) FROM bscheckplan b,pcompanycomdalei a, pcompany p ");
		sb.append(" WHERE a.comid=p.comid and  FIND_IN_SET(a.AAZ093, b.plantypearea) and b.planid=ou.planid ");
		sb.append(" AND NOT EXISTS (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid and b1.planid=b.planid) ) unchecked,");
		sb.append("	(SELECT COUNT(1) FROM bscheckplan b,pcompanycomdalei a,pcompany p WHERE a.comid=p.comid and  FIND_IN_SET(a.AAZ093, b.plantypearea) AND b.planid = ou.planid ");
		sb.append(" AND EXISTS (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid AND b1.planid = ou.planid AND b1.resultstate IN ('0', '1', '2', '3', '5', '6'))) checking,");
		sb.append("	(SELECT COUNT(1) FROM bscheckplan b,pcompanycomdalei a,pcompany p ");
		sb.append(" WHERE a.comid=p.comid and  FIND_IN_SET(a.AAZ093, b.plantypearea) AND b.planid = ou.planid ");
		sb.append(" AND EXISTS (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid AND b1.planid = ou.planid AND b1.resultstate = '4')) checked, ");
		sb.append(" fun_getItemidFromPlanid(ou.planid) as itemid ");
		sb.append(" FROM bscheckplan ou ");
		sb.append(" WHERE ou.planstdate < now() AND ou.planeddate > now() ");
		sb.append(" and ou.plancontrol<>'1'");

		String sql = sb.toString();
		String[] paramName = new String[]{};
		int[] paramType = new int[]{};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckplanDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	/**
	 * queryRiskCheckMasterId的中文名称：查询检查结果ID 新增量化检查
	 *
	 * queryRiskCheckMasterId的概要说明：如果没有检查结果ID，新增一个检查结果
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop( { "trans" })
	public Map<String,Object> saveRiskCheckMaster(HttpServletRequest request, BsCheckMaster dto){
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		//经办时间
		dto.setOperatedate(SysmanageUtil.currentTime());
		SimpleDateFormat myformat = new SimpleDateFormat("yyyy");
		String v_year = myformat.format(new Date());
		dto.setCheckyear(v_year);
		// 获取操作员信息
		Sysuser v_sysuser = dao.fetch(Sysuser.class, Cnd.where("userid", "=", dto.getUserid()));
		if (v_sysuser != null){
			dto.setAaa027(v_sysuser.getAaa027());
		}
		if (null != dto.getResultid()&&!"".equals(dto.getResultid())&&!"null".equalsIgnoreCase(dto.getResultid())) {
			BsCheckMaster se = dao.fetch(BsCheckMaster.class, dto.getResultid());
			se.setResultid(dto.getResultid());
			se.setComid(dto.getComid());
			se.setResultdecision(dto.getResultdecision());
			se.setResultperson(dto.getResultperson());
			se.setResultng(dto.getResultng());
			se.setResultscore(dto.getResultscore());
			se.setResultremark(dto.getResultremark());
			se.setOperateperson(v_sysuser.getDescription());
			se.setResultperson(dto.getResultperson());
			se.setUserid(dto.getUserid());
			se.setResultdate(new Date());
			if(dao.update(se)>0){
				resultMap.put("success", true);
			}
		} else {
			String sequence = DbUtils.getSequenceStr();
			dto.setOperateperson(v_sysuser.getDescription());
			dto.setResultperson(dto.getResultperson());
			dto.setResultid(sequence);
			dto.setResultstate("0");//新建
			dto.setAaa027(dto.getAaa027());
			dto.setUserid(dto.getUserid());
			dto.setOrgid(dto.getOrgid());
			dto.setAae011(dto.getAae011());//经办人姓名
			dto.setResultdate(new Date());

			dao.insert(dto);
			resultMap.put("resultid", sequence);
			resultMap.put("success", true);
		}
		return resultMap;
	};

	/**
	 *
	 * getRiskCheckHistoryList的中文名称：查询企业的量化等级历史记录
	 *
	 * getRiskCheckHistoryList的概要说明：根据企业id企业的量化等级历史记录
	 *
	 * @param request 请求对象
	 * @param dto 检查结果DTO
	 * @return Written by : zy
	 * @throws Exception
	 */
	public Map getRiskCheckHistoryList(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
//		sb.append(" select b.planid,b.plantitle,a.resultid, a.operatedate,a.resultdate, a.resultstate, ");
//		sb.append(" a.resultremark, a.operateperson, a.lhfjdtpddj, a.checkyear,a. ");
		sb.append(" select b.planid,b.plantitle,b.planchecktype,b.planmobankind,");
		sb.append("a.resultid,a.planid,a.comid,a.resultdecision,a.resultng,a.resultremark,a.resultscore,a.checkgroupstate,");
		sb.append("a.resultstate,a.operatedate,a.operateperson,a.resultdate,a.checkdatakind,");
		sb.append("a.lxr,a.lxdh,a.aae036,a.checkavgscore,a.lhfjdtpddj,a.checkyear ");
		sb.append(" from bscheckmaster a,bscheckplan b  ");
		sb.append(" where a.planid=b.planid  ");
		sb.append(" and b.plancontrol='1' ");
		sb.append(" and a.comid  =:comid  ");
		//sb.append(" and a.planid='"+SysmanageUtil.g_planid_spscjy_fxdjqdb+"' ");//gu20180402 2018040315500872759514728 食品生产经营者风险等级确认表【系统内置，不要删】
		//gu20180402  sb.append(" and (a.planid is NULL OR a.planid = '') ");
		sb.append(" order by  a.checkyear desc, a.resultstate");
		String sql = sb.toString();
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	public Map queryRiskPingDing(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {

		String v_sql="select a.* from bscheckmaster a where a.resultid='"+dto.getResultid()+"'";
		List<BsCheckMasterDTO> v_BsCheckMasterDTOlist=DbUtils.getDataList(v_sql,BsCheckMasterDTO.class);
		if (v_BsCheckMasterDTOlist!=null && v_BsCheckMasterDTOlist.size()>0){
			BsCheckMasterDTO v_BsCheckMasterDTO=v_BsCheckMasterDTOlist.get(0);
			String v_planid=v_BsCheckMasterDTO.getPlanid();
			if (v_BsCheckMasterDTO!=null){
				if (SysmanageUtil.g_planid_spxs_jtfxlh.equals(v_planid)){////食品销售企业静态风险因素量化分值表【系统内置，不要删】
					return queryPjingspxs(request,dto,pd);
				}else if (SysmanageUtil.g_planid_spcyfw_jtfxlh.equals(v_planid)) {//餐饮服务提供者静态风险因素量化分值表【系统内置，不要删】
					return queryPjingcyfwlh(request,dto,pd);
				}else if (SysmanageUtil.g_planid_spscjy_fxdjqdb.equals(v_planid)) {//食品生产经营者风险等级确认表【系统内置，不要删】
					return queryPcomriskconfirm(request,dto,pd);
				}else if (SysmanageUtil.g_planid_spcyfw_nddjpd.equals(v_planid)) {//餐饮服务食品安全监督年度等级评定表【系统内置，不要删】
					return queryPcyfwnddjpd(request,dto,pd);
				}
			}
		}else{
			throw new BusinessException("没找到检查结果信息，请核对resultid是否正确");
		}

		return null;
	};
	//食品销售企业静态风险因素量化分值表
	public Map queryPjingspxs(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.* from pjingspxs a where 1=1 ");
		sb.append(" and a.resultid=:resultid");
		String sql = sb.toString();
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PjingspxsDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	//餐饮服务提供者静态风险因素量化分值表
	public Map queryPjingcyfwlh(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.* from pjingcyfwlh a where 1=1 ");
		sb.append(" and a.resultid=:resultid");
		String sql = sb.toString();
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PjingcyfwlhDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	//食品生产经营者风险等级确认表
	public Map queryPcomriskconfirm(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.* from pcomriskconfirm a where 1=1 ");
		sb.append(" and a.resultid=:resultid");
		String sql = sb.toString();
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcomriskconfirmDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	//餐饮服务食品安全监督年度等级评定表
	public Map queryPcyfwnddjpd(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.*, ");
		sb.append(" (case when a.cpdj is not null and a.cpdj<>'' then (select t1.aaa103 from aa10 t1 where t1.aaa100='CYLHFJ' and t1.aaa102=a.cpdj ) else a.cpdj end) as cpdjaaa103, ");
		sb.append(" (case when a.fpdj is not null and a.fpdj<>'' then (select t1.aaa103 from aa10 t1 where t1.aaa100='CYLHFJ' and t1.aaa102=a.fpdj ) else a.fpdj end) as fpdjaaa103, ");
		sb.append(" (case when a.spdj is not null and a.spdj<>'' then (select t1.aaa103 from aa10 t1 where t1.aaa100='CYLHFJ' and t1.aaa102=a.spdj ) else a.spdj end) as spdjaaa103  ");
		sb.append(" from pcyfwnddjpd a where 1=1 ");
		sb.append(" and a.resultid=:resultid");
		String sql = sb.toString();
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcyfwnddjpdDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);

		List list2=null;
		if (list!=null && list.size()>0){
			PcyfwnddjpdDTO v_tempPcyfwnddjpdDTO=(PcyfwnddjpdDTO)list.get(0);
			String v_pcyfwnddjpdid=v_tempPcyfwnddjpdDTO.getPcyfwnddjpdid();
			StringBuffer sb2 = new StringBuffer();
			sb2.append("select a.* from pcyfwnddjpdmx a where 1=1 ");
			sb2.append(" and a.pcyfwnddjpdid ='"+v_pcyfwnddjpdid+"' ");
			String sql2 = sb2.toString();
			String[] paramName2 = new String[]{};
			int[] paramType2 = new int[]{};
			sql2 = QueryFactory.getSQL(sql2, paramName2, paramType2, dto, pd );
			Map m2 = DbUtils.DataQuery(GlobalNames.sql, sql2, null, PcyfwnddjpdmxDTO.class, pd.getPage(), pd.getPageSize());
			list2 = (List) m2.get(GlobalNames.SI_RESULTSET);
		}

		Map map = new HashMap();
		map.put("rows", list);
		map.put("mxrows", list2);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};
	/**
	 * 获取餐饮服务食品安全监督年度等级评定表中 动态等级评定情况
	 * param resultid
	 * return Written by :gjf
	 * */
	public Map queryCyfwNddtpdDtdjpdqk(HttpServletRequest request,BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		String v_qunian=String.valueOf(DateUtil.convertDateToYear(new Date()));

		StringBuffer sb = new StringBuffer();
		sb.append("select a.resultid,a.comid,a.checkyear,a.operatedate,a.resultscore,a.lhfjdtpddj,getAa10_aaa103('LHFJDTPDDJ',a.lhfjdtpddj) as lhfjdtpddjaaa103 ");
		sb.append(" from bscheckmaster a,bscheckplan b where a.planid=b.planid ");
		sb.append(" and b.planmobankind='11'");//11餐饮服务食品安全监督动态评定表
		sb.append(" and a.checkyear='"+v_qunian+"' ");
		sb.append(" and a.comid=:comid ");
		String sql = sb.toString();
		String[] paramName = new String[]{"comid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	/**
	 * 食品生产经营者风险等级确定表,新增时需要的单位信息和单位历史评定信息
	 *
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPcomriskconfirmAddinfo(HttpServletRequest request, Pcomriskconfirm dto, PagesDTO pd) throws Exception {
		Sysuser v_sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		String v_year = String.valueOf(DateUtil.convertDateToYear(new Date()));
		String v_qunian=String.valueOf(DateUtil.convertDateToYear(new Date())-1);

		sb.append(" select a.commc,a.comdz, ");
		sb.append("(select GROUP_CONCAT(t.comxkzbh) from pcompanyxkz t where comid=a.comid and comxkzlx<>'1') as zzzmbh,");
		sb.append("concat(a.comfrhyz,a.comyddh) as lxrhfs, ");
		//sb.append("(select t1.lhfjndpddj from pcompanynddtpj t1,aa10 t2 where t1.comid=a.comid and t1.lhfjndpddj=t2.aaa102 and t2.aaa100='LHFJNDPDDJ') as sndfxdj,");
		sb.append("ifnull((select t1.lhfjndpddj from pcompanynddtpj t1 where t1.comid=a.comid and t1.pdyear='"+v_qunian+"'),'') as sndfxdj,");
		sb.append("b.jingtaifen as staticscore,b.dongtaifen as dynamicscore,ifnull(b.jingtaifen,0)+ifnull(b.dongtaifen,0) as totalscore,");
		sb.append("fun_getRiskLevel('22',ifnull(b.jingtaifen,0)+ifnull(b.dongtaifen,0)) as fxdj ");//b.defen
		sb.append(" from Pcompany a left join  (select t.* from pcompanynddtpj t where t.comid=:comid and t.pdyear='"+v_year+"') b on a.comid=b.comid ");
		sb.append(" where 1=1 ");
		sb.append(" and a.comid = :comid ");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] {Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Pcomriskconfirm.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	/**
	 * TODO 返回企业数目
	 *
	 * @param request
	 * @param resultType
	 *            检查结果完成类型-1:未检查,2:检查中,3:已完成
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Map queryCompanyByPlan(HttpServletRequest request, int resultType,
								  PcompanyDTO dto, PagesDTO pd) throws Exception {
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		// 获取有证无证参数
		String isHaveZzzm = StringHelper.showNull2Empty(request
																.getParameter("ishavezzzm"));
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT DISTINCT p.*,p.comdaleiname comdaleistr, ");
		// 企业还有资质证明 当为0时，没有证件
		sb.append(" (select t.fjpath from fj t where t.fjwid=p.comid and fjtype='4') as qymtzpath, ");
		sb.append(" IFNULL((select COUNT(t1.comxkzid) from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid),'0') havezzzm ");
		sb.append(" FROM bscheckplan b,pcompanycomdalei a,pcompany p ");
		sb.append(" WHERE  p.comid=a.comid and FIND_IN_SET(a.AAZ093,b.plantypearea ) ");
		// 判断有证无证 1：有证 0：无证
		if ("1".equals(isHaveZzzm)) {
			sb.append(" and exists (select 1 from pcompanyxkz t1 where t1.comid=p.comid and t1.comxkzlx<>'1')");
			//sb.append("  AND (select COUNT(t1.comxkzid) num from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid) > 0 ");
		} else if ("0".equals(isHaveZzzm)) {
			//sb.append("  AND (select COUNT(t1.comxkzid) num from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid)  IS null ");
			sb.append(" and not exists (select 1 from pcompanyxkz t1 where t1.comid=p.comid and t1.comxkzlx<>'1')");
		}
		// 根据企业类别获取企业列表信息
		String comdaleiSql = "";
		if (dto.getComdalei() != null && !"".equals(dto.getComdalei())) {
			comdaleiSql = " and FIND_IN_SET( '" + dto.getComdalei()
					+ "', p.comdalei) ";
			sb.append(comdaleiSql);
		}
		sb.append("  AND b.planid = :planid ");
		sb.append("  AND p.commc like :commc "); // 企业模糊查询
		sb.append(" and exists (select 1 from pcompanynddtpj t5 where t5.comid=p.comid and t5.pdyear='"+v_year+
						  "' and t5.lhfjndpddj is not null and t5.lhfjndpddj<>'') ");

//		// 只有量化的企业才能进行检查 add-zy-2018.3.22
//		sb.append("  AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 ");
//		sb.append("  WHERE b1.comid = p.comid AND b1.planid IS NULL AND b1.resultstate = '4' ");
//		// 在当前年份量化过的企业
//		sb.append("  AND b1.checkyear = '")
//		  .append(String.valueOf(DateUtil.convertDateToYear(new Date())))
//		  .append("' ");
//		// 当检查计划有检查等级时，为日常检查；当planchecktype 不等于1时，为其它类型检查
//		sb.append("  AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1)) ");


		switch (resultType) {
			case 1:
				// 未检查
				sb.append(" AND  p.comid NOT IN (SELECT b1.comid FROM bscheckmaster b1   ");
				sb.append("  WHERE b1.comid = p.comid AND b1.planid = b.planid ) ");
				break;
			case 2:
				// 检查中
				sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid ");
				sb.append(" AND b1.planid = b.planid AND b1.resultstate in ('0','1','2','3','5','6'))   ");
				break;
			case 3:
				// 已检查
				sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid  ");
				sb.append(" AND b1.planid = b.planid AND resultstate=4) GROUP BY p.comid  ");
				break;
		}
		// 用于企业个数统计 TODO 统计企业个数
		String countSql = "SELECT DISTINCT p.comid "
				+ "    FROM bscheckplan b,pcompanycomdalei a,pcompany p "
				+ "    WHERE p.comid=a.comid and  FIND_IN_SET(a.AAZ093,b.plantypearea ) "
				+ "    AND b.planid =:planid"
				+ comdaleiSql
				+" and exists (select 1 from pcompanynddtpj t5 where t5.comid=p.comid and t5.pdyear='"+v_year+
				"' and t5.lhfjndpddj is not null and t5.lhfjndpddj<>'') ";
//				+ "    AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
//				+ "    AND b1.planid IS NULL AND b1.resultstate = '4' AND b1.checkyear = '"
//				+ v_year
//				+ "' "
//				+ "    AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1))"; // 用于统计企业个数
		String sql = sb.toString();
		String[] paramName = new String[] { "planid", "commc" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		// 统计有证企业个数（当前检查计划与企业类别下）
		String haveZzzmSql = "SELECT p1.comid FROM pcompanyxkz p1  WHERE  p1.comxkzlx<>'1' and p1.comid IN (SELECT t.comid FROM ("
				+ countSql + ") t)";
		haveZzzmSql = QueryFactory.getSQL(haveZzzmSql, paramName, paramType,
										  dto, pd);
		Map haveMap = DbUtils.DataQuery(GlobalNames.sql, haveZzzmSql, null,
										PcompanyDTO.class);
		// 统计无证企业个数（当前检查计划与企业类别下）
		String noZzzmSql = countSql
				+ " AND p.comid NOT IN (SELECT p1.comid FROM pcompanyxkz p1 where p1.comxkzlx<>'1' GROUP BY p1.comid)";
		noZzzmSql = QueryFactory.getSQL(noZzzmSql, paramName, paramType, dto,
										pd);
		Map noMap = DbUtils.DataQuery(GlobalNames.sql, noZzzmSql, null,
									  PcompanyDTO.class);

		// 统计未检查企业个数（当前检查计划与企业类别下）
		String unCheckedSql = countSql
				+ " AND  p.comid NOT IN (SELECT b1.comid FROM bscheckmaster b1 "
				+ " WHERE b1.comid = p.comid AND b1.planid = b.planid )  GROUP BY p.comid ";
		unCheckedSql = QueryFactory.getSQL(unCheckedSql, paramName, paramType,
										   dto, pd);
		Map unCheckedMap = DbUtils.DataQuery(GlobalNames.sql, unCheckedSql,
											 null, PcompanyDTO.class);
		// 统计检查中企业个数（当前检查计划与企业类别下）
		String checkingSql = countSql
				+ " AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
				+ " AND b1.planid = b.planid AND b1.resultstate in ('0','1','2','3','5','6'))  GROUP BY p.comid ";
		checkingSql = QueryFactory.getSQL(checkingSql, paramName, paramType,
										  dto, pd);
		Map checkingMap = DbUtils.DataQuery(GlobalNames.sql, checkingSql, null,
											PcompanyDTO.class);
		// 统计已检查企业个数（当前检查计划与企业类别下）
		String checkedSql = countSql
				+ " AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
				+ " AND b1.planid = b.planid AND resultstate=4) GROUP BY p.comid ";
		checkedSql = QueryFactory.getSQL(checkedSql, paramName, paramType, dto,
										 pd);
		Map checkedMap = DbUtils.DataQuery(GlobalNames.sql, checkedSql, null,
										   PcompanyDTO.class);

		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  PcompanyDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("haveZzzmNum", haveMap.get(GlobalNames.SI_TOTALROWNUM)); // 有证企业
		map.put("noZzzmNum", noMap.get(GlobalNames.SI_TOTALROWNUM)); // 无证企业
		map.put("unCheckedNum", unCheckedMap.get(GlobalNames.SI_TOTALROWNUM)); // 未检查企业
		map.put("checkingNum", checkingMap.get(GlobalNames.SI_TOTALROWNUM)); // 检查中企业
		map.put("checkedNum", checkedMap.get(GlobalNames.SI_TOTALROWNUM)); // 已检查企业
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	};

	/**
	 * TODO 返回企业数目
	 *
	 * @param request
	 * @param resultType
	 *            检查结果完成类型-1:未检查,2:检查中,3:已完成
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Map queryCompanyByPlan_zy(HttpServletRequest request, int resultType,
									 PcompanyDTO dto, PagesDTO pd) throws Exception {
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		// 获取有证无证参数
		String isHaveZzzm = StringHelper.showNull2Empty(request
																.getParameter("ishavezzzm"));
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT DISTINCT p.*,p.comdaleiname comdaleistr, ");
		// 企业还有资质证明 当为0时，没有证件
		sb.append(" IFNULL((select COUNT(t1.comxkzid) from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid),'0') havezzzm ");
		sb.append(" FROM bscheckplan b,pcompanycomdalei a,pcompany p ");
		sb.append(" WHERE  p.comid=a.comid and FIND_IN_SET(a.AAZ093,b.plantypearea ) ");
		// 判断有证无证 1：有证 0：无证
		if ("1".equals(isHaveZzzm)) {
			sb.append("  AND (select COUNT(t1.comxkzid) num from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid) > 0 ");
		} else if ("0".equals(isHaveZzzm)) {
			sb.append("  AND (select COUNT(t1.comxkzid) num from pcompanyxkz t1 where t1.comid = p.comid and t1.comxkzlx<>'1' group by t1.comid)  IS null ");
		}
		// 根据企业类别获取企业列表信息
		String comdaleiSql = "";
		if (dto.getComdalei() != null && !"".equals(dto.getComdalei())) {
			comdaleiSql = " and FIND_IN_SET( '" + dto.getComdalei()
					+ "', p.comdalei) ";
			sb.append(comdaleiSql);
		}
		sb.append("  AND b.planid = :planid ");
		sb.append("  AND p.commc like :commc "); // 企业模糊查询
		sb.append(" and exists (select 1 from pcompanynddtpj t5 where t5.comid=p.comid and t5.pdyear='"+v_year+
						  "' and t5.lhfjndpddj is not null and t5.lhfjndpddj<>'') ");

//		// 只有量化的企业才能进行检查 add-zy-2018.3.22
//		sb.append("  AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 ");
//		sb.append("  WHERE b1.comid = p.comid AND b1.planid IS NULL AND b1.resultstate = '4' ");
//		// 在当前年份量化过的企业
//		sb.append("  AND b1.checkyear = '")
//		  .append(String.valueOf(DateUtil.convertDateToYear(new Date())))
//		  .append("' ");
//		// 当检查计划有检查等级时，为日常检查；当planchecktype 不等于1时，为其它类型检查
//		sb.append("  AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1)) ");


		switch (resultType) {
			case 1:
				// 未检查
				sb.append(" AND  p.comid NOT IN (SELECT b1.comid FROM bscheckmaster b1   ");
				sb.append("  WHERE b1.comid = p.comid AND b1.planid = b.planid )  GROUP BY p.comid  ");
				break;
			case 2:
				// 检查中
				sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid ");
				sb.append(" AND b1.planid = b.planid AND b1.resultstate in ('0','1','2','3','5','6'))  GROUP BY p.comid  ");
				break;
			case 3:
				// 已检查
				sb.append(" AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid  ");
				sb.append(" AND b1.planid = b.planid AND resultstate=4) GROUP BY p.comid  ");
				break;
		}
		// 用于企业个数统计 TODO 统计企业个数
		String countSql = "SELECT DISTINCT p.comid "
				+ "    FROM bscheckplan b,pcompanycomdalei a,pcompany p "
				+ "    WHERE p.comid=a.comid and  FIND_IN_SET(a.AAZ093,b.plantypearea ) "
				+ "    AND b.planid =:planid"
				+ comdaleiSql
				+" and exists (select 1 from pcompanynddtpj t5 where t5.comid=p.comid and t5.pdyear='"+v_year+
				"' and t5.lhfjndpddj is not null and t5.lhfjndpddj<>'') ";
//				+ "    AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
//				+ "    AND b1.planid IS NULL AND b1.resultstate = '4' AND b1.checkyear = '"
//				+ v_year
//				+ "' "
//				+ "    AND (b1.lhfjdtpddj = b.planlevel OR b.planchecktype <> 1))"; // 用于统计企业个数
		String sql = sb.toString();
		String[] paramName = new String[] { "planid", "commc" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		// 统计有证企业个数（当前检查计划与企业类别下）
		String haveZzzmSql = "SELECT p1.comid FROM pcompanyxkz p1  WHERE  p1.comxkzlx<>'1' and p1.comid IN (SELECT t.comid FROM ("
				+ countSql + ") t)";
		haveZzzmSql = QueryFactory.getSQL(haveZzzmSql, paramName, paramType,
										  dto, pd);
		Map haveMap = DbUtils.DataQuery(GlobalNames.sql, haveZzzmSql, null,
										PcompanyDTO.class);
		// 统计无证企业个数（当前检查计划与企业类别下）
		String noZzzmSql = countSql
				+ " AND p.comid NOT IN (SELECT p1.comid FROM pcompanyxkz p1 where p1.comxkzlx<>'1' GROUP BY p1.comid)";
		noZzzmSql = QueryFactory.getSQL(noZzzmSql, paramName, paramType, dto,
										pd);
		Map noMap = DbUtils.DataQuery(GlobalNames.sql, noZzzmSql, null,
									  PcompanyDTO.class);

		// 统计未检查企业个数（当前检查计划与企业类别下）
		String unCheckedSql = countSql
				+ " AND  p.comid NOT IN (SELECT b1.comid FROM bscheckmaster b1 "
				+ " WHERE b1.comid = p.comid AND b1.planid = b.planid )  GROUP BY p.comid ";
		unCheckedSql = QueryFactory.getSQL(unCheckedSql, paramName, paramType,
										   dto, pd);
		Map unCheckedMap = DbUtils.DataQuery(GlobalNames.sql, unCheckedSql,
											 null, PcompanyDTO.class);
		// 统计检查中企业个数（当前检查计划与企业类别下）
		String checkingSql = countSql
				+ " AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
				+ " AND b1.planid = b.planid AND b1.resultstate in ('0','1','2','3','5','6'))  GROUP BY p.comid ";
		checkingSql = QueryFactory.getSQL(checkingSql, paramName, paramType,
										  dto, pd);
		Map checkingMap = DbUtils.DataQuery(GlobalNames.sql, checkingSql, null,
											PcompanyDTO.class);
		// 统计已检查企业个数（当前检查计划与企业类别下）
		String checkedSql = countSql
				+ " AND p.comid IN (SELECT b1.comid FROM bscheckmaster b1 WHERE b1.comid = p.comid "
				+ " AND b1.planid = b.planid AND resultstate=4) GROUP BY p.comid ";
		checkedSql = QueryFactory.getSQL(checkedSql, paramName, paramType, dto,
										 pd);
		Map checkedMap = DbUtils.DataQuery(GlobalNames.sql, checkedSql, null,
										   PcompanyDTO.class);

		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
								  PcompanyDTO.class, pd.getPage(), pd.getPageSize());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("haveZzzmNum", haveMap.get(GlobalNames.SI_TOTALROWNUM)); // 有证企业
		map.put("noZzzmNum", noMap.get(GlobalNames.SI_TOTALROWNUM)); // 无证企业
		map.put("unCheckedNum", unCheckedMap.get(GlobalNames.SI_TOTALROWNUM)); // 未检查企业
		map.put("checkingNum", checkingMap.get(GlobalNames.SI_TOTALROWNUM)); // 检查中企业
		map.put("checkedNum", checkedMap.get(GlobalNames.SI_TOTALROWNUM)); // 已检查企业
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * getSysorgStatistic的中文名称：各组织机构量化检查统计数量
	 *
	 * getSysorgStatistic的概要说明：只统计各乡所的
	 *
	 * @return
	 * @throws Exception
	 */
	public List getSysorgStatistic(String checkYear) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT t1.ORGNAME, t1.ORGID,IFNULL(t1.lhed, 0) lhed, IFNULL(t2.lhing, 0) lhing,  ");
		sb.append(" IFNULL(t3.checked, 0) checked, IFNULL(t4.checking, 0) checking  ");

		sb.append(" FROM (SELECT COUNT(b.resultid) lhed, s1.ORGNAME, s1.ORGID  ");
		sb.append(" FROM bscheckmaster b, sysorg s1, sysuser s2  ");
		sb.append(" WHERE s2.ORGID = s1.ORGID AND s2.USERID = b.userid ");
		sb.append(" AND b.resultstate = '4' AND b.planid IS NULL AND s1.ORGNAME LIKE '%食药监所' ");
		sb.append(" AND b.checkyear = '").append(checkYear).append("' ");
		sb.append(" GROUP BY s1.ORGID) t1 "); // 已量化
		sb.append(" LEFT JOIN ");

		sb.append(" (SELECT COUNT(b.resultid) lhing, s1.ORGNAME, s1.ORGID  ");
		sb.append(" FROM bscheckmaster b, sysorg s1, sysuser s2  ");
		sb.append(" WHERE s2.ORGID = s1.ORGID AND s2.USERID = b.userid ");
		sb.append(" AND b.resultstate <> '4' AND b.planid IS NULL AND s1.ORGNAME LIKE '%食药监所' ");
		sb.append(" AND b.checkyear = '").append(checkYear).append("' ");
		sb.append(" GROUP BY s1.ORGID) t2 ON t1.ORGID = t2.ORGID "); // 量化中
		sb.append(" LEFT JOIN ");

		sb.append(" (SELECT COUNT(b.resultid) checked, s1.ORGNAME, s1.ORGID  ");
		sb.append(" FROM bscheckmaster b, sysorg s1, sysuser s2  ");
		sb.append(" WHERE s2.ORGID = s1.ORGID AND s2.USERID = b.userid ");
		sb.append(" AND b.resultstate = '4' AND b.planid IS NOT NULL AND s1.ORGNAME LIKE '%食药监所' ");
		sb.append(" AND b.checkyear = '").append(checkYear).append("' ");
		sb.append(" GROUP BY s1.ORGID) t3 ON t3.ORGID = t2.ORGID "); // 已检查
		sb.append(" LEFT JOIN ");

		sb.append(" (SELECT COUNT(b.resultid) checking, s1.ORGNAME, s1.ORGID  ");
		sb.append(" FROM bscheckmaster b, sysorg s1, sysuser s2  ");
		sb.append(" WHERE s2.ORGID = s1.ORGID AND s2.USERID = b.userid ");
		sb.append(" AND b.resultstate <> '4' AND b.planid IS NOT NULL AND s1.ORGNAME LIKE '%食药监所' ");
		sb.append(" AND b.checkyear = '").append(checkYear).append("' ");
		sb.append(" GROUP BY s1.ORGID) t4 ON t3.ORGID = t4.ORGID "); // 检查中
		String sql = sb.toString();
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) map.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

}
