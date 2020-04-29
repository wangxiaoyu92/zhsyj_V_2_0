package com.askj.supervision.service;

import com.askj.baseinfo.dto.OmprintDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.entity.Viewzfry;
import com.askj.supervision.ConstSupervison;
import com.askj.supervision.dto.*;
import com.askj.supervision.entity.*;
import com.askj.supervision.rule.CheckRuleDivision;
import com.askj.supervision.rule.CheckRuleDivisionImpTangYin;
import com.askj.supervision.rule.CheckRuleDivisionImpZDXQ;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.Sys;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.util.StringUtil;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * CheckHandlerService的中文名称：检查处理类
 *
 * CheckHandlerService的中文描述：
 * 
 * Written by:syf
 */
public class CheckHandlerService {
	
	protected final Logger logger = Logger.getLogger(CheckInfoService.class);
	
	@Inject
	private Dao dao;

	/**
	 * 
	 * saveCheckDetailForBatch的中文名称：批量保存检查结果明细
	 * 
	 * saveCheckDetailForBatch的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception 
	 * 
	 */
	@Aop( { "trans" })
	public Map saveCheckDetailForBatch(HttpServletRequest request, BsCheckDetailDTO dto) throws Exception {
		Map retMap = new HashMap<String, Object>();
		int v_count=0;
		boolean v_exists=false;
		List<BsCheckDetail> v_mydetail=null;

		// 是否合并检查计划
		String isMergePlans = StringHelper.showNull2Empty(request.getParameter("isMergePlans"));
		if ("true".equals(isMergePlans)) {
			// 合并检查
			String[] resultids = dto.getResultid().split(",");
			for (int i = 0; i < resultids.length; i++) {
				try{
					dto.setResultid(resultids[i]);
					for(BsCheckDetailDTO detail : dto.getDetaillist())
					{
						v_exists=false;
						if (v_count==0){
							v_mydetail=DbUtils.getDataList("select a.* from bscheckdetail a where a.resultid='"+dto.getResultid()
																   +"'", BsCheckDetail.class);
						}

						for (BsCheckDetail v_BsCheckDetail:v_mydetail){
							if (v_BsCheckDetail.getContentid().equals(detail.getContentid())
									&& ("2".equals(v_BsCheckDetail.getDetaildecide()))){
								v_exists=true;
								break;
							}
						}
						v_count=v_count+1;

						if (!v_exists){//gu20180106
							BsCheckDetail detailbean = new BsCheckDetail();
							detailbean.setContentid(detail.getContentid());
							detailbean.setResultid(dto.getResultid());
							detailbean.setDetaildecide(detail.getDetaildecide());
							detailbean.setOperatetype(dto.getOperatetype());
							//符合，填写分数
							if("1".equals(detail.getDetaildecide())){
								//					System.out.println(detail.getDetailscore());
								detailbean.setDetailscore(detail.getDetailscore());
							}
							//gu20180512 if(!"2".equals(detail.getDetaildecide())){
							saveCheckDetail(request, detailbean);
							//gu20180512}
						};
					}
					retMap.put("success", true);
					retMap.put("msg", "保存成功");
				}catch (Exception e) {
					retMap.put("success", false);
					retMap.put("msg", "保存失败");
				}
			}
		}else{//不合并
			try{
				for(BsCheckDetailDTO detail : dto.getDetaillist())
				{
					v_exists=false;
					if (v_count==0){
						v_mydetail=DbUtils.getDataList("select a.* from bscheckdetail a where a.resultid='"+dto.getResultid()
															   +"'", BsCheckDetail.class);
					}

					for (BsCheckDetail v_BsCheckDetail:v_mydetail){
						if (v_BsCheckDetail.getContentid().equals(detail.getContentid())
								&& ("2".equals(v_BsCheckDetail.getDetaildecide()))){
							v_exists=true;
							break;
						}
					}
					v_count=v_count+1;

					if (!v_exists){//gu20180106
						BsCheckDetail detailbean = new BsCheckDetail();
						detailbean.setContentid(detail.getContentid());
						detailbean.setResultid(dto.getResultid());
						detailbean.setDetaildecide(detail.getDetaildecide());
						detailbean.setOperatetype(dto.getOperatetype());
						//符合，填写分数
						if("1".equals(detail.getDetaildecide())){
							//					System.out.println(detail.getDetailscore());
							detailbean.setDetailscore(detail.getDetailscore());
						}
						//gu20180512 if(!"2".equals(detail.getDetaildecide())){
						saveCheckDetail(request, detailbean);
						//gu20180512}
					};
				}
				retMap.put("success", true);
				retMap.put("msg", "保存成功");
			}catch (Exception e) {
				retMap.put("success", false);
				retMap.put("msg", "保存失败");
			}
		}

		return retMap;
	}

	public Map saveCheckDetailForBatch_20180519(HttpServletRequest request, BsCheckDetailDTO dto) throws Exception {
		Map retMap = new HashMap<String, Object>();
		System.out.println("99999999999999999999999999999999999999"+dto.getOperatetype());
		int v_count=0;
		boolean v_exists=false;
		List<BsCheckDetail> v_mydetail=null;
		try{
			for(BsCheckDetailDTO detail : dto.getDetaillist())
			{
				v_exists=false;
				if (v_count==0){
					v_mydetail=DbUtils.getDataList("select a.* from bscheckdetail a where a.resultid='"+dto.getResultid()
														   +"'", BsCheckDetail.class);
				}

				for (BsCheckDetail v_BsCheckDetail:v_mydetail){
					if (v_BsCheckDetail.getContentid().equals(detail.getContentid())
							&& ("2".equals(v_BsCheckDetail.getDetaildecide()))){
						v_exists=true;
						break;
					}
				}
				v_count=v_count+1;

				if (!v_exists){//gu20180106
					BsCheckDetail detailbean = new BsCheckDetail();
					detailbean.setContentid(detail.getContentid());
					detailbean.setResultid(dto.getResultid());
					detailbean.setDetaildecide(detail.getDetaildecide());
					detailbean.setOperatetype(dto.getOperatetype());
					//符合，填写分数
					if("1".equals(detail.getDetaildecide())){
//					System.out.println(detail.getDetailscore());
						detailbean.setDetailscore(detail.getDetailscore());
					}
					//gu20180512 if(!"2".equals(detail.getDetaildecide())){
					saveCheckDetail(request, detailbean);
					//gu20180512}
				};
			}
			retMap.put("success", true);
			retMap.put("msg", "保存成功");
		}catch (Exception e) {
			retMap.put("success", false);
			retMap.put("msg", "保存失败");
		}
		return retMap;
	}

	/******************保存结果信息处理块******ST**********/
	/**
	 * 根据检查结果ID修改检查结果信息
	 *   业务逻辑:
	 *      判断检查结果是否存在
	 * 			不存在  返回  success=false   msg=没有相关数据无法进行此操作
	 * 		    存在
	 * 		         修改结果状态
	 * 		            如果 Resultstate = 3  明细固化
	 * 		            如果 Planchecktype = 0 说明是量化检查，计算得分、平均分、评定等级
	 *
	 *
	 *
	 * @param dto
	 *            检查结果概要信息DTO
	 * @return
	 * @throws Exception
	 */
	public Map updateBsCheckMasterStateByResultid(HttpServletRequest request,
												  BsCheckMasterDTO dto) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		Map map = new HashMap();
		StringBuffer sb = new StringBuffer();

		sb.append(" select b.planchecktype,b.planmobankind,a.*  ");
		sb.append("from bscheckmaster a ,bscheckplan b ");
		sb.append(" where a.planid=b.planid ");
		sb.append("and a.resultid =:resultid ");
		sb.append(" order by a.planid ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "resultid"};
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> list = (List) m.get(GlobalNames.SI_RESULTSET);
		if (list.size() == 0) {
			map.put("msg", "没有相关数据无法进行此操作");
			map.put("success", false);
		} else {// 修改结果状态
			BsCheckMasterDTO masterold = list.get(0);
			BsCheckMaster master = new BsCheckMaster();
			BeanHelper.copyProperties(masterold, master);

			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			master.setResultstate(dto.getResultstate());// 结束检查
			master.setResultdate(new Date());// 结束时间
			//master.setOperatedate(sdf.parse(masterold.getOperatedate()));//经办时间
			master.setOperatedate(SysmanageUtil.currentTime());//经办时间

			//检查类型
			dto.setPlanchecktype(masterold.getPlanchecktype());
			dto.setCheckgroupstate(masterold.getCheckgroupstate());

			//明细固化 //gu20170903add 6
			if(ConstSupervison.CheckType.LiangHua.equals(dto.getPlanchecktype())){//量化
				BsCheckMasterDTO checkMaster = getAverageScore(dto);
				if(checkMaster!=null){
					//得分
					master.setResultscore(checkMaster.getChecknum());
					//平均分
					master.setCheckavgscore(checkMaster.getAverageScore());//检查平均分
					master.setLhfjdtpddj(checkMaster.getLhfjdtpddj());//量化分级动态评定等级A优秀B良好C一般
				}
			};
			if (StringUtils.isNotEmpty(masterold.getPlanmobankind())){
				if(ConstSupervison.CheckType.SPSXDTLH.equals(masterold.getPlanmobankind())//食品销售环节动态风险因素量化分值表
						||ConstSupervison.CheckType.SPSPTJJ_SPQYDTFXYSPJB.equals(masterold.getPlanmobankind()) //食品食品添加剂生产企业动态风险因素评价表
						){
					BsCheckMasterDTO checkMaster = getCheckSumScore(dto);
					if(checkMaster!=null){
						//得分
						master.setResultscore(checkMaster.getResultscore());
						addOrUpdatePcompanynddtpj(dto.getComid(),"dongtai","",String.valueOf(checkMaster.getResultscore()),"","");
						dto.setResultscore(checkMaster.getResultscore());
					}
				}else if( ConstSupervison.CheckType.SPTJJJTLH.equals(masterold.getPlanmobankind())//食品、食品添加剂生产者静态风险因素量化分值表
						){
					BsCheckMasterDTO checkMaster = getCheckSumScore(dto);
					if(checkMaster!=null){
						//得分
						master.setResultscore(checkMaster.getResultscore());
						addOrUpdatePcompanynddtpj(dto.getComid(),"jingtai",String.valueOf(checkMaster.getResultscore()),"","","");
						dto.setResultscore(checkMaster.getResultscore());
					}
				}
			}


			//dao.update(master);

			if( //gu20180426 保存时已经生成报表 状态3就不再固话 ConstSupervison.CheckMasterState.Freezed.equals(dto.getResultstate())||
					ConstSupervison.CheckMasterState.Committed.equals(dto.getResultstate())
					|| ConstSupervison.CheckMasterState.ResultDecideFreezed.equals(dto.getResultstate())//gu20180411
					){
				String result = SysmanageUtil.getAA027Str(dto.getAaa027(), dto.getAaa383());
				dto.setAaa027(result);
				//gu20180411 master.setDetailinfo((String)getDetailByid(request, dto).get("data"));

				if ("houtaitijiao".equals(dto.getOperatetype())){
					BeanHelper.copyProperties(master, dto);
				}
				BsCheckMasterDTO v_printdto=getDetailByid(request, dto);

				master.setCheckresultinfo(v_printdto.getCheckresultinfo());
				master.setDetailinfo(v_printdto.getDetailinfo());
				//master.setCheckresultinfo(getDetailByid(request, dto));
			}
			dao.update(master);


			map.put("msg", "保存成功");
//				map.put("data", getDetailByid(request, dto).get("data"));
			map.put("success", true);
		}

		return map;
	}
//新增或修改企业年度动态评级表
	public void addOrUpdatePcompanynddtpj(String prm_comid, String prm_kind, String prm_jingtaifen,
										   String prm_dongtaifen,String prm_defen,String prm_lhfjndpddj){
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		List<Pcompanynddtpj> v_PcompanynddtpjList=dao.query(Pcompanynddtpj.class,Cnd.where("comid","=",prm_comid).and("pdyear","=",v_year));

		if (v_PcompanynddtpjList!=null && v_PcompanynddtpjList.size()>0) {
			Pcompanynddtpj v_oldPcompanynddtpj=v_PcompanynddtpjList.get(0);
			if ("dongtai".equals(prm_kind)){
				v_oldPcompanynddtpj.setDongtaifen(prm_dongtaifen);
			}else if ("jingtai".equals(prm_kind)){
				v_oldPcompanynddtpj.setJingtaifen(prm_jingtaifen);
			}else if ("niandupingji".equals(prm_kind)){
				v_oldPcompanynddtpj.setJingtaifen(prm_jingtaifen);
				v_oldPcompanynddtpj.setDongtaifen(prm_dongtaifen);
				v_oldPcompanynddtpj.setDefen(prm_defen);
				v_oldPcompanynddtpj.setLhfjndpddj(prm_lhfjndpddj);
			}
			dao.update(v_oldPcompanynddtpj);
		}else{
			Pcompanynddtpj v_newPcompanynddtpj=new Pcompanynddtpj();
			String v_pcompanynddtpjid=DbUtils.getSequenceStr();
			v_newPcompanynddtpj.setPcompanynddtpjid(v_pcompanynddtpjid);
			v_newPcompanynddtpj.setComid(prm_comid);
			v_newPcompanynddtpj.setPdyear(v_year);

			if ("dongtai".equals(prm_kind)){
				v_newPcompanynddtpj.setDongtaifen(prm_dongtaifen);
			}else if ("jingtai".equals(prm_kind)){
				v_newPcompanynddtpj.setJingtaifen(prm_jingtaifen);
			}else if ("niandupingji".equals(prm_kind)){
				v_newPcompanynddtpj.setJingtaifen(prm_jingtaifen);
				v_newPcompanynddtpj.setDongtaifen(prm_dongtaifen);
				v_newPcompanynddtpj.setDefen(prm_defen);
				v_newPcompanynddtpj.setLhfjndpddj(prm_lhfjndpddj);
			}
			dao.insert(v_newPcompanynddtpj);
		}


	}

	/**
	 *得到量化平均分
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	private BsCheckMasterDTO getAverageScore(BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		double  averageScore=0;
		BsCheckMasterDTO checkMaster = null;
		sb.append(" select sum(a.detailscore) as checknum,sum(b.contentscore) as checkgetnum ");
		sb.append(" from bscheckdetail a , omcheckcontent b ");
		sb.append(" where a.contentid = b.contentid");
		sb.append(" and a.resultid= :resultid  and 1=1 ");
		sb.append(" ORDER BY  a.detailscore ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> list = (List<BsCheckMasterDTO>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			checkMaster = list.get(0);
//				//实际得到分数
			double checkNum = checkMaster.getChecknum();
//				//总分
			double checkSumScore = checkMaster.getCheckgetnum();
			averageScore = checkNum/checkSumScore*10;
			checkMaster.setAverageScore(averageScore);
			DecimalFormat df = new DecimalFormat("#.0");//格式化小数，不足的补0
			averageScore = Float.parseFloat(df.format(averageScore));

			//gu20170220begin
			String v_sql="select f_getLhfjdj("+dto.getResultid()+",'0',"+averageScore+","+dto.getResultdate()+") as lhfjdtpddj ";//量化分级动态评定等级"
			String v_lhfjdtpddj = DbUtils.getOneValue(dao, v_sql);//量化分级动态评定等级
			checkMaster.setLhfjdtpddj(v_lhfjdtpddj);
			//gu20170220end
			checkMaster.setResultscore(checkSumScore);
		}
		return checkMaster;

	}

	/**
	 *得到量化平均分
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	private BsCheckMasterDTO getCheckSumScore(BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		double  averageScore=0;
		BsCheckMasterDTO checkMaster = null;
		sb.append(" select sum(a.detailscore) as checknum,sum(b.contentscore) as checkgetnum ");
		sb.append(" from bscheckdetail a , omcheckcontent b ");
		sb.append(" where a.contentid = b.contentid");
		sb.append(" and a.resultid= :resultid  and 1=1 ");
		sb.append(" ORDER BY  a.detailscore ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> list = (List<BsCheckMasterDTO>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			checkMaster = list.get(0);
//				//实际得到分数
			double checkNum = checkMaster.getChecknum();
//				//总分
			double checkSumScore = checkMaster.getCheckgetnum();
			checkMaster.setResultscore(checkSumScore);
		}
		return checkMaster;

	}

    private List<BsCheckDetailDTO> getCheckDetail(BsCheckMasterDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		String str ="";
		sb.append(" select b.contentcode,b.contentimpt ,getAa10_aaa103('CONTENTIMPT',b.contentimpt) as contentimptaaa103,");
		sb.append(" b.contentsortid,b.contentscore ,c.itemsortid sortid,  ");
		sb.append("  a.resultid , b.contentid  , b.content  ,c.itemname ,c.itemid,c.itempid ,   ");
		sb.append("  a.detaildecide , a.detailscore ,a.detailng ,ifnull(a.detailremark,'') as detailremark, ");
		sb.append("  (select COUNT(*) from bscheckdetail d ,omcheckcontent e  ");
		sb.append("  where d.contentid=e.contentid and e.itemid=c.itemid and d.resultid = :resultid ) count ");
		sb.append("  from bscheckdetail a , omcheckcontent b , omcheckgroup c ");
		sb.append("  where a.contentid = b.contentid ");
		sb.append("  and b.itemid = c.itemid ");
		sb.append(" and a.resultid= :resultid ");
		sb.append(" ORDER BY sortid ,b.contentsortid");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println("sql  "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckDetailDTO.class);
		List<BsCheckDetailDTO> list = (List<BsCheckDetailDTO>) m.get(GlobalNames.SI_RESULTSET);
        return list;
	};

	/**
	 * 查询检查明细结果 结果id，
	 * @param dto  计划dto
	 * @return
	 * @throws Exception
	 */
	private BsCheckMasterDTO getDetailByid(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
		BsCheckMasterDTO v_retCheckDto=new BsCheckMasterDTO();
		String v_tbodytype="";
		String  contextPath = request.getContextPath();
        if (dto.getTbodytype()==null || "".equals(dto.getTbodytype())){
			// 不再分四品一械 量化日常 只根据tbodytype 来区分报表
			//需要用哪个报表 从手机打印和检查模板对应表omprint查

			String v_sql="select  b.* from bscheckpicset a,omprint b,omcheckgroup c,bscheckmaster d "
					+" where a.itemid=c.itemid and c.itempid=b.itemid and a.planid=d.planid and d.resultid='"+dto.getResultid()+"' limit 1";
			List<OmprintDTO> v_omprintList=(List<OmprintDTO>)DbUtils.getDataList(v_sql,OmprintDTO.class);

			if (v_omprintList!=null && v_omprintList.size()>0){
				v_tbodytype=v_omprintList.get(0).getTbodytype();
			}else{
				//throw new BusinessException("未找到对应的报表");
				v_tbodytype="yuanlaide";
			};
		}else{
			v_tbodytype=dto.getTbodytype();
		}
        //gu20180426 if (!"yuanlaide".equals(v_tbodytype)){//为了兼容原来的
			dto.setTbodytype(v_tbodytype);
			List<BsCheckDetailDTO> listCheckDetailDto;

			//获取表头信息
			BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);

			if(tbodybean==null){
				throw new BusinessException("未获取到报表信息");
			}
			String v_sql="";
			int v_loopcount=0;
			List itemidlist = new ArrayList();
			StringBuffer sb = new StringBuffer();
			String tbodyinfo="";
			String tfootinfo="";

			String tbody="";//☑
			String v_kuozhan1="";
			String v_kuozhan2="";
			String v_kuozhan3="";
			String v_kuozhan4="";
			String v_kuozhan5="";
			String v_kuozhan6="";

			String v_spscjy_rcjdjcjgjlb_tbodyinfo="";//食品生产经营日常监督检查结果记录表 这个表存在公用

			String v_checkTrue ="☑是 □否";
			String v_checkFalse ="□是 ☑否";//&#9633;□
			String v_nocheck="□是 □否";
			String v_detaildecide="";

			if ("spxs_dtfxlhfzb".equals(v_tbodytype)){//食品销售环节动态风险因素量化分值表【系统内置，不要删】检查结果
				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//食品通用检查项目
				v_kuozhan2=tbodybean.getKuozhan2();//明细项目tr 不合并行
				v_kuozhan3=tbodybean.getKuozhan3();//特殊场所和特殊食品检查项目tr
				v_kuozhan4=tbodybean.getKuozhan4();//明细项目tr 合并行

				String v_mygridtable=v_kuozhan1;
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}

					if (listCheckDetailDto.get(i).getContentcode().equals("7.1")) {
						v_mygridtable+=v_kuozhan3;
					};

					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailscore",String.valueOf(listCheckDetailDto.get(i).getDetailscore()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan4.replace("rowspancount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailscore",String.valueOf(listCheckDetailDto.get(i).getDetailscore()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable)
								   .replace("resultscore","本次检查合计得分："+dto.getResultscore());
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spsptjj_scqydtfxyspjb".equals(v_tbodytype)){//食品食品添加剂生产企业动态风险因素评价表
				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//明细项目tr 合并行
				v_kuozhan2=tbodybean.getKuozhan2();//明细项目tr 不合并行

				String v_mygridtable="";
				double v_koufenheji=0;
				String v_detailscore="";
				for(int i =0;i<listCheckDetailDto.size();i++){
					v_detailscore="";
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
						v_koufenheji=v_koufenheji+listCheckDetailDto.get(i).getDetailscore();
						v_detailscore=String.valueOf(listCheckDetailDto.get(i).getDetailscore());
					}else {
						v_detaildecide=v_nocheck;
					}

					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
								.replaceFirst("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
								.replace("contentscore",listCheckDetailDto.get(i).getContentscore()==null?"":listCheckDetailDto.get(i).getContentscore())
								.replace("detailscore",v_detailscore)
								.replace("detailremark",listCheckDetailDto.get(i).getDetailremark()==null?"":listCheckDetailDto.get(i).getDetailremark());

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan1.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replaceFirst("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("contentscore",listCheckDetailDto.get(i).getContentscore()==null?"":listCheckDetailDto.get(i).getContentscore())
												 .replace("detailscore",v_detailscore)
												 .replace("detailremark",listCheckDetailDto.get(i).getDetailremark()==null?"":listCheckDetailDto.get(i).getDetailremark());

						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable)
								   .replace("koufenheji",String.valueOf(v_koufenheji));
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spxs_jtfxlh".equals(v_tbodytype)) {//食品销售企业静态风险因素量化分值表【系统内置，不要删】
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_sql="select a.* from pjingspxs a where a.pjingspxsid='"+dto.getPjingspxsid()+"'";
				List<PjingspxsDTO> v_PjingspxsDTOList=DbUtils.getDataList(v_sql,PjingspxsDTO.class);
				if (v_PjingspxsDTOList!=null && v_PjingspxsDTOList.size()>0){
					PjingspxsDTO v_PjingspxsDTO=v_PjingspxsDTOList.get(0);
					if (v_PjingspxsDTO!=null) {
						tbodyinfo=tbodyinfo.replace("spjycsmj", v_PjingspxsDTO.getSpjycsmj()==null?"":v_PjingspxsDTO.getSpjycsmj())
										   .replace("ybzcw", v_PjingspxsDTO.getYbzcw()==null?"":v_PjingspxsDTO.getYbzcw())
										   .replace("ybzlc", v_PjingspxsDTO.getYbzlc()==null?"":v_PjingspxsDTO.getYbzlc())
										   .replace("ybzld", v_PjingspxsDTO.getYbzld()==null?"":v_PjingspxsDTO.getYbzld())
										   .replace("szcw", v_PjingspxsDTO.getSzcw()==null?"":v_PjingspxsDTO.getSzcw())
										   .replace("szlc", v_PjingspxsDTO.getSzlc()==null?"":v_PjingspxsDTO.getSzlc())
										   .replace("szld", v_PjingspxsDTO.getSzld()==null?"":v_PjingspxsDTO.getSzld())
										   .replace("ghzsl", v_PjingspxsDTO.getGhzsl()==null?"":v_PjingspxsDTO.getGhzsl())
										   .replace("dfzh", v_PjingspxsDTO.getDfzh()==null?"":v_PjingspxsDTO.getDfzh());
					}
				}
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("sptjj_jtfxlh".equals(v_tbodytype)){//食品、食品添加剂生产者静态风险因素量化分值表
				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//明细表格
				v_kuozhan2=tbodybean.getKuozhan2();//结尾表格

				String v_mygridtable=v_kuozhan1;
				for(int i =0;i<listCheckDetailDto.size();i++){
					String v_content=listCheckDetailDto.get(i).getContent();
					int v_post=v_content.indexOf("】");
					String v_contentleibie=v_content.substring(2,v_post-1);
					String v_contentreal=v_content.substring(v_post+1);

					v_mygridtable+=v_kuozhan1.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
											 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
											 .replace("contentleibie",v_contentleibie)
											 .replace("contentreal",v_contentreal)
											 .replace("contentimptaaa103",listCheckDetailDto.get(i).getContentimptaaa103())
											 .replace("detailscore",String.valueOf(listCheckDetailDto.get(i).getDetailscore()));


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable)
								   .replace("resultscore","本次检查合计得分："+dto.getResultscore());
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spcyfw_jtfxlh".equals(v_tbodytype)) {//餐饮服务提供者静态风险因素量化分值表【系统内置，不要删】
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_sql="select a.* from pjingcyfwlh a where a.pjingcyfwlhid='"+dto.getPjingcyfwlhid()+"'";
				List<PjingcyfwlhDTO> v_PjingcyfwlhDTOList=DbUtils.getDataList(v_sql,PjingcyfwlhDTO.class);
				if (v_PjingcyfwlhDTOList!=null && v_PjingcyfwlhDTOList.size()>0){
					PjingcyfwlhDTO v_PjingcyfwlhDTO=v_PjingcyfwlhDTOList.get(0);
					if (v_PjingcyfwlhDTO!=null) {
						tbodyinfo=tbodyinfo.replace("ythgm", v_PjingcyfwlhDTO.getYthgm()==null?"":v_PjingcyfwlhDTO.getYthgm())
										   .replace("lengshidp", v_PjingcyfwlhDTO.getLengshidp()==null?"":v_PjingcyfwlhDTO.getLengshidp())
										   .replace("lengshiyf", v_PjingcyfwlhDTO.getLengshiyf()==null?"":v_PjingcyfwlhDTO.getLengshiyf())
										   .replace("shengshidp", v_PjingcyfwlhDTO.getShengshidp()==null?"":v_PjingcyfwlhDTO.getShengshidp())
										   .replace("gaodiandp", v_PjingcyfwlhDTO.getGaodiandp()==null?"":v_PjingcyfwlhDTO.getGaodiandp())
										   .replace("gaodianyf", v_PjingcyfwlhDTO.getGaodianyf()==null?"":v_PjingcyfwlhDTO.getGaodianyf())
										   .replace("reshidp", v_PjingcyfwlhDTO.getReshidp()==null?"":v_PjingcyfwlhDTO.getReshidp())
										   .replace("reshiyf", v_PjingcyfwlhDTO.getReshiyf()==null?"":v_PjingcyfwlhDTO.getReshiyf())
										   .replace("zizhiyinpindp", v_PjingcyfwlhDTO.getZizhiyinpindp()==null?"":v_PjingcyfwlhDTO.getZizhiyinpindp())
										   .replace("qitadp", v_PjingcyfwlhDTO.getQitadp()==null?"":v_PjingcyfwlhDTO.getQitadp())
										   .replace("dfzh", v_PjingcyfwlhDTO.getDfzh()==null?"":v_PjingcyfwlhDTO.getDfzh());
					}
				}
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spcyfw_nddjpd".equals(v_tbodytype)) {//餐饮服务食品安全监督年度等级评定表【系统内置，不要删】检查结果
				//listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo = tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1 = tbodybean.getKuozhan1();//明细项目不合并
				v_kuozhan2 = tbodybean.getKuozhan2();//明细项目tr 合并行
				v_kuozhan3 = tbodybean.getKuozhan3();//明细扩展空行
				v_kuozhan4 = tbodybean.getKuozhan4();//无明细
				String v_nddjpdmxgrid = "";

				v_sql = "select a.*,getAa10_aaa103('LHFJNDPDDJ',a.lhfjndpddj) as lhfjndpddjaaa103 from pcyfwnddjpdmx a where a.pcyfwnddjpdid='" + dto.getPcyfwnddjpdid() + "'";
				List<PcyfwnddjpdmxDTO> v_PcyfwnddjpdmxDTOList = DbUtils.getDataList(v_sql, PcyfwnddjpdmxDTO.class);
				v_loopcount=1;
				if (v_PcyfwnddjpdmxDTOList != null && v_PcyfwnddjpdmxDTOList.size() > 0) {
					for (PcyfwnddjpdmxDTO v_tempPcyfwnddjpdmxDTO : v_PcyfwnddjpdmxDTOList) {
						if (v_loopcount == 0) {
							v_nddjpdmxgrid += v_kuozhan1.replace("jcrq", v_tempPcyfwnddjpdmxDTO.getJcrq()
																							   .toString() == null ? "" : v_tempPcyfwnddjpdmxDTO.getJcrq()
																																				.toString())
														.replace("defen",
																 v_tempPcyfwnddjpdmxDTO.getDefen() == null ? "" : v_tempPcyfwnddjpdmxDTO.getDefen())
														.replace("lhfjndpddj",
																 v_tempPcyfwnddjpdmxDTO.getLhfjndpddjaaa103() == null ? "" : v_tempPcyfwnddjpdmxDTO.getLhfjndpddjaaa103());
						} else {
							if (v_loopcount <= 6) {
								v_nddjpdmxgrid += v_kuozhan2.replace("jcrq",
																	 v_tempPcyfwnddjpdmxDTO.getJcrq()
																						   .toString() == null ? "" : v_tempPcyfwnddjpdmxDTO.getJcrq()
																																			.toString())
															.replace("defen",
																	 v_tempPcyfwnddjpdmxDTO.getDefen() == null ? "" : v_tempPcyfwnddjpdmxDTO.getDefen())
															.replace("lhfjndpddj",
																	 v_tempPcyfwnddjpdmxDTO.getLhfjndpddjaaa103() == null ? "" : v_tempPcyfwnddjpdmxDTO.getLhfjndpddjaaa103());
							}
						}
						v_loopcount += 1;
					}
				};
				if (v_loopcount==1) {//wu mingxi
					v_nddjpdmxgrid+=v_kuozhan4;
					for (int k = 1; k <= 5; k++) {
						v_nddjpdmxgrid += v_kuozhan3;
					}
				}else{
					if (v_loopcount <=6) {
						for (int k = v_loopcount; k <= 6; k++) {
							v_nddjpdmxgrid += v_kuozhan3;
						}
					};
				}


				v_sql = "select a.*,getAa10_aaa103('LHFJNDPDDJ',a.lhfjndpddj) as lhfjndpddjaaa103 from pcyfwnddjpd a where a.pcyfwnddjpdid='" + dto.getPcyfwnddjpdid() + "'";
				List<PcyfwnddjpdDTO> v_PcyfwnddjpdDTOList = DbUtils.getDataList(v_sql, PcyfwnddjpdDTO.class);
				if (v_PcyfwnddjpdDTOList != null && v_PcyfwnddjpdDTOList.size() > 0) {
					PcyfwnddjpdDTO v_PcyfwnddjpdDTO = v_PcyfwnddjpdDTOList.get(0);
					String v_cpdj="";
					if (StringUtils.isNotEmpty(v_PcyfwnddjpdDTO.getCpdj())){
						v_cpdj="初评等级"+v_PcyfwnddjpdDTO.getCpdj()+",";
					};
					String v_fpdj="";
					if (StringUtils.isNotEmpty(v_PcyfwnddjpdDTO.getFpdj())){
						v_fpdj="复评等级"+v_PcyfwnddjpdDTO.getFpdj()+",";
					};
					String v_spdj="";
					if (StringUtils.isNotEmpty(v_PcyfwnddjpdDTO.getSpdj())){
						v_spdj="审评等级"+v_PcyfwnddjpdDTO.getSpdj()+",";
					}
					tbodyinfo = tbodyinfo.replace("nddjpdmxgrid", v_nddjpdmxgrid);
					tbodyinfo=tbodyinfo.replace("dwmc",
												  v_PcyfwnddjpdDTO.getDwmc() == null ? "" : v_PcyfwnddjpdDTO.getDwmc())
										 .replace("comdz",
												  v_PcyfwnddjpdDTO.getComdz() == null ? "" : v_PcyfwnddjpdDTO.getComdz())
										 .replace("comfrhyz",
												  v_PcyfwnddjpdDTO.getComfrhyz() == null ? "" : v_PcyfwnddjpdDTO.getComfrhyz())
										 .replace("comyddh",
												  v_PcyfwnddjpdDTO.getComyddh() == null ? "" : v_PcyfwnddjpdDTO.getComyddh())
										 .replace("cyfwxkzh",
												  v_PcyfwnddjpdDTO.getCyfwxkzh() == null ? "" : v_PcyfwnddjpdDTO.getCyfwxkzh())
										 .replace("xklb",
												  v_PcyfwnddjpdDTO.getXklb() == null ? "" : v_PcyfwnddjpdDTO.getXklb())
										 .replace("ndpjdf",
												  v_PcyfwnddjpdDTO.getNdpjdf() == null ? "" : v_PcyfwnddjpdDTO.getNdpjdf())
										 .replace("cpyj",
												  v_PcyfwnddjpdDTO.getCpyj() == null ? "" : v_cpdj+v_PcyfwnddjpdDTO.getCpyj())
										 .replace("fpyj",
												  v_PcyfwnddjpdDTO.getFpyj() == null ? "" : v_fpdj+ v_PcyfwnddjpdDTO.getFpyj())
										 .replace("spyj",
												  v_PcyfwnddjpdDTO.getSpyj() == null ? "" : v_spdj + v_PcyfwnddjpdDTO.getSpyj());
				}
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spscjy_fxdjqdb".equals(v_tbodytype)) {//食品生产经营者风险等级确定表
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_sql="select a.* from pcomriskconfirm a where a.pcomriskconfirmid='"+dto.getPcomriskconfirmid()+"'";
				List<PcomriskconfirmDTO> v_PcomriskconfirmDTOList=DbUtils.getDataList(v_sql,PcomriskconfirmDTO.class);
				if (v_PcomriskconfirmDTOList!=null && v_PcomriskconfirmDTOList.size()>0){
					PcomriskconfirmDTO v_PcomriskconfirmDTO=v_PcomriskconfirmDTOList.get(0);

					String tbrqmrq=SysmanageUtil.getDateYMD(v_PcomriskconfirmDTO.getTbrqmrq());
					String shrqmrq=SysmanageUtil.getDateYMD(v_PcomriskconfirmDTO.getShrqmrq());
					if (v_PcomriskconfirmDTO!=null) {
						tbodyinfo=tbodyinfo.replace("checkyear", v_PcomriskconfirmDTO.getCheckyear()) // 检查年度
										   .replace("checkno", v_PcomriskconfirmDTO.getCheckno() == null ? "" : v_PcomriskconfirmDTO.getCheckno()) // 检查编号
										   .replace("commc", v_PcomriskconfirmDTO.getCommc() == null ? "" : v_PcomriskconfirmDTO.getCommc()) // 企业名称
										   .replace("comdz", v_PcomriskconfirmDTO.getComdz() == null ? "" : v_PcomriskconfirmDTO.getComdz()) // 企业地址
										   .replace("zzzmbh", v_PcomriskconfirmDTO.getZzzmbh() == null ? "" : v_PcomriskconfirmDTO.getZzzmbh()) // 营业执照编号或信用代码
										   .replace("lxrhfs", v_PcomriskconfirmDTO.getLxrhfs()) // 联系人及联系方式
										   .replace("sndfxdj", v_PcomriskconfirmDTO.getSndfxdj() == null ? "" : v_PcomriskconfirmDTO.getSndfxdj()) // 上年度风险等级
										   .replace("staticscore", v_PcomriskconfirmDTO.getStaticscore() == null ? "" : v_PcomriskconfirmDTO.getStaticscore()) // 静态风险因素量化风险分值
										   .replace("dynamicscore", v_PcomriskconfirmDTO.getDynamicscore() == null ? "" : v_PcomriskconfirmDTO.getDynamicscore()) // 动态风险因素量化风险分值
										   .replace("totalscore", v_PcomriskconfirmDTO.getTotalscore() == null ? "" : v_PcomriskconfirmDTO.getTotalscore()) // 风险等级得分
										   .replaceFirst("fxdj_a", "1".equals(v_PcomriskconfirmDTO.getFxdj()) ? "☑" : "□") // 风险等级A对应aa10 COMFXDJ 1
										   .replaceFirst("fxdj_b", "2".equals(v_PcomriskconfirmDTO.getFxdj()) ? "☑" : "□") // 风险等级B对应aa10 COMFXDJ 2
										   .replaceFirst("fxdj_c", "3".equals(v_PcomriskconfirmDTO.getFxdj()) ? "☑" : "□") // 风险等级C对应aa10 COMFXDJ 3
										   .replaceFirst("fxdj_d", "4".equals(v_PcomriskconfirmDTO.getFxdj()) ? "☑" : "□") // 风险等级D对应aa10 COMFXDJ 4
										   .replace("gywfflfg", ("1".equals(v_PcomriskconfirmDTO.getGywfflfg())) ? "☑" : "□") // 故意违反食品安全法律法规 0:未选中 1:选中
										   //.replace("gywfflfg", v_temp) // 故意违反食品安全法律法规 0:未选中 1:选中
										   .replace("ycjysbfh", ("1".equals(v_PcomriskconfirmDTO.getYcjysbfh())) ? "☑" : "□") // 有1次及以上国家或者省级监督抽检不符合食品安全标准的0:未选中 1:选中
										   .replace("wfflfg", ("1".equals(v_PcomriskconfirmDTO.getWfflfg())) ? "☑" : "□") // 违反食品安全法律法规规定0:未选中 1:选中
										   .replace("fsaqsg", ("1".equals(v_PcomriskconfirmDTO.getFsaqsg())) ? "☑" : "□") // 发生食品安全事故的0:未选中 1:选中
										   .replace("bagd", ("1".equals(v_PcomriskconfirmDTO.getBagd())) ? "☑" : "□") // 不按规定0:未选中 1:选中
										   .replace("bpezf", ("1".equals(v_PcomriskconfirmDTO.getBpezf())) ? "☑" : "□") // 不配合执法0:未选中 1:选中
										   .replace("kstdj", ("1".equals(v_PcomriskconfirmDTO.getKstdj())) ? "☑" : "□") // 可以上调风险等级0:未选中 1:选中
										   .replace("stfxdj", "1".equals(v_PcomriskconfirmDTO.getSuggestfxdj()) ? "☑" : "□") // 上调个风险等级对应aa10 FXDJJY 1
										   .replace("btzfxdj", "2".equals(v_PcomriskconfirmDTO.getSuggestfxdj()) ? "☑" : "□") // 不调风险等级对应aa10 FXDJJY 2
										   .replace("xtfxdj", "3".equals(v_PcomriskconfirmDTO.getSuggestfxdj()) ? "☑" : "□") // 下调个风险等级对应aa10 FXDJJY 3
										   .replace("xyndfxdj", (v_PcomriskconfirmDTO.getXyndfxdj() == null) ? "" : v_PcomriskconfirmDTO.getXyndfxdj()) // 下一年度风险等级
										   .replace("fxdjbz", (v_PcomriskconfirmDTO.getFxdjbz() == null) ? "" : v_PcomriskconfirmDTO.getFxdjbz()) // 备注
										   .replaceFirst("tbrqm", (v_PcomriskconfirmDTO.getTbrqm() == null) ? "" : contextPath+v_PcomriskconfirmDTO.getTbrqm()) // 填表人签名图片
										   .replaceFirst("tbrnian", (StringUtils.isEmpty(tbrqmrq)) ? "&nbsp;" : tbrqmrq.substring(0,4)) // 填表人签名图片
										   .replaceFirst("tbryue", (StringUtils.isEmpty(tbrqmrq)) ? "&nbsp;" : tbrqmrq.substring(4,6)) // 填表人签名图片
										   .replaceFirst("tbrri", (StringUtils.isEmpty(tbrqmrq)) ? "&nbsp;" : tbrqmrq.substring(6,8)) // 填表人签名图片
										   .replaceFirst("shrqm", (v_PcomriskconfirmDTO.getShrqm() == null) ? "" : contextPath+v_PcomriskconfirmDTO.getShrqm())// 审核人签名图片
										   .replaceFirst("shrnian", (StringUtils.isEmpty(shrqmrq)) ? "&nbsp;" : shrqmrq.substring(0,4)) // 填表人签名图片
										   .replaceFirst("shryue", (StringUtils.isEmpty(shrqmrq)) ? "&nbsp;" : shrqmrq.substring(4,6)) // 填表人签名图片
										   .replaceFirst("shrri", (StringUtils.isEmpty(shrqmrq)) ? "&nbsp;" : shrqmrq.substring(6,8)); // 填表人签名图片
					}
				}
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return tbodyinfo;
			}else if ("spcy_dydjpdb".equals(v_tbodytype)) {//餐饮服务食品安全监督动态等级评定表
			    tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				tbody = tbodybean.getTbody();//明细
				tfootinfo= tbodybean.getTfootinfo();//平均分脚行
				v_kuozhan1 = tbodybean.getKuozhan1();//说明信息
				String tbodyval="";
		        //获取企业信息
		        PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_sql="select a.* from Pcyfwdtdjpdb a where a.resultid='"+dto.getResultid()+"'";
				List<PcyfwdtdjpdbDTO> v_PcyfwdtdjpdbList=DbUtils.getDataList(v_sql,PcyfwdtdjpdbDTO.class);
				PcyfwdtdjpdbDTO v_PcyfwdtdjpdbDTO=new PcyfwdtdjpdbDTO();
				if (v_PcyfwdtdjpdbList!=null && v_PcyfwdtdjpdbList.size()>0){
					v_PcyfwdtdjpdbDTO=v_PcyfwdtdjpdbList.get(0);
				}


//				String starttime = company.getOperatedate();
//				String endtime = company.getResultdate();
				String starttime = "";
				if (v_PcyfwdtdjpdbDTO.getJcjssj()!=null){
					starttime=v_PcyfwdtdjpdbDTO.getJcjssj().toString();
				}else{
					starttime = company.getOperatedate();
				}

				String endtime = "";
				if (v_PcyfwdtdjpdbDTO.getJcjssj()!=null){
					endtime=v_PcyfwdtdjpdbDTO.getJcjssj().toString();
				}else{
					endtime = company.getResultdate();
				}

				String v_to_check_time=endtime==null?"":endtime.substring(11,13);
				if(starttime.substring(0,10) != endtime.substring(0,10)){//同一天
					v_to_check_time=endtime==null?"":endtime.substring(0,13);
				};
				String zfryzjhm="";
				//获取执法人员信息
				zfryzjhm=  getzfzjh(dto.getUserid()); //执法证件号

				tbodyval=tbodyinfo.replace("commc",v_PcyfwdtdjpdbDTO.getCommc()==null?"":v_PcyfwdtdjpdbDTO.getCommc())
								  .replace("comdz",v_PcyfwdtdjpdbDTO.getComdz()==null?"":v_PcyfwdtdjpdbDTO.getComdz())
								  .replace("comfrhyz",v_PcyfwdtdjpdbDTO.getComfrhyz()==null?"":v_PcyfwdtdjpdbDTO.getComfrhyz())
								  .replace("comyddh",v_PcyfwdtdjpdbDTO.getComyddh()==null?"":v_PcyfwdtdjpdbDTO.getComyddh())
//				  					.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
//				  					.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
								  .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
								  .replace("comxkzbh",v_PcyfwdtdjpdbDTO.getComxkzbh()==null?"":v_PcyfwdtdjpdbDTO.getComxkzbh())
								  .replace("comdmlx",v_PcyfwdtdjpdbDTO.getXklb()==null?"":v_PcyfwdtdjpdbDTO.getXklb())//店面
								  .replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
								  .replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
								  .replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
								  .replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
								  .replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
								  .replace("to_check_time",endtime.substring(11,13)==null?"":endtime.substring(11,13))
								  .replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16))
								  .replaceFirst("zfryqmpic", v_PcyfwdtdjpdbDTO.getJcryqzpic()==null?"":v_PcyfwdtdjpdbDTO.getJcryqzpic()) //执法人员签名图片
								  .replaceFirst("bjcdwqmpic", v_PcyfwdtdjpdbDTO.getSpaqglrypic()==null?"":v_PcyfwdtdjpdbDTO.getSpaqglrypic());//被检查单位签名图片
				//固定表头
				if(tbody!=null&&!"".equals(tbody)){
					String str = tbody.replace("</tbody>", "").replace("</table>", "");
					sb.append(str);
				};
				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				for(int i =0;i<listCheckDetailDto.size();i++){
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						sb.append("<tr ><td id="+listCheckDetailDto.get(i).getItemid()+" rowspan="+listCheckDetailDto.get(i).getCount()+"  style='text-align:center;' >"+listCheckDetailDto.get(i).getItemname()+"</td><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getDetailscore()+"</td></tr>");
					}
				};
					  /*gu20170220 注销
					  //平均分
					 float  averageScore =0;
					 BsCheckMasterDto  checkMaster = getAverageScore(dto);
					 if(checkMaster!=null){
						 averageScore=checkMaster.getAverageScore();
					 }
					 //等级
					 String level= getlevelInfo(averageScore, dto);
					 */
				v_sql="select a.*,(select getAa10_aaa102aaa103('LHFJNDPDDJ',a.lhfjdtpddj,'&') ) as lhfjdtpddjstr  "+
						" from bscheckmaster a "+
						" where a.resultid='"+dto.getResultid()+"'";
				BsCheckMaster v_myBsCheckMaster=(BsCheckMaster)DbUtils.getDataList(v_sql, BsCheckMaster.class).get(0);
				//平均分
				double  averageScore =v_myBsCheckMaster.getCheckavgscore();
				//等级
				String level= v_myBsCheckMaster.getLhfjdtpddjstr();

				//格式化小数，不足的补0
				DecimalFormat df = new DecimalFormat("0.0");
				String  average = df.format(averageScore);
				String v_assesslevel  ="";
				if (level!=null){
					String[] str=level.split("&");
					v_assesslevel=str[0];
				}
				tfootinfo=tfootinfo.replace("average", average).replace("assesslevel", v_assesslevel);
				sb.append(tfootinfo);
				tfootinfo="";
				sb.append("</tbody></table>");
				v_retCheckDto.setDetailinfo(tbodyval+sb.toString()+tfootinfo+v_kuozhan1);
				//return tbodyval+sb.toString()+tfootinfo+v_kuozhan1;
		    } else if ("spcyfw_rcjdjcydb".equals(v_tbodytype)){//餐饮服务日常监督检查要点表
				String v_allRet="";
				//获取企业信息
				PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_spscjy_rcjdjcjgjlb_tbodyinfo=getSpscjyRcjdjcjgjlb(request,company,dto);////食品生产经营日常监督检查结果记录表 公用表


				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//不带rowscount明细
				v_kuozhan2=tbodybean.getKuozhan2();//带rowscount明细

				String v_mygridtable="";
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan1.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",listCheckDetailDto.get(i).getDetailremark()==null?"":listCheckDetailDto.get(i).getDetailremark());

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan2.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark", listCheckDetailDto.get(i).getDetailremark()==null?"":listCheckDetailDto.get(i).getDetailremark());
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable);
				v_retCheckDto.setCheckresultinfo(v_spscjy_rcjdjcjgjlb_tbodyinfo);
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return v_spscjy_rcjdjcjgjlb_tbodyinfo+tbodyinfo;
			}else if ("spsc_rcjdjcydb".equals(v_tbodytype)){//食品生产日常监督检查要点表
				String v_allRet="";
				//获取企业信息
				PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_spscjy_rcjdjcjgjlb_tbodyinfo=getSpscjyRcjdjcjgjlb(request,company,dto);////食品生产经营日常监督检查结果记录表 公用表


				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//带rowscount明细
				v_kuozhan2=tbodybean.getKuozhan2();//不带rowscount明细

				String v_mygridtable="";
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan1.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable);
				v_retCheckDto.setCheckresultinfo(v_spscjy_rcjdjcjgjlb_tbodyinfo);
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return v_spscjy_rcjdjcjgjlb_tbodyinfo+tbodyinfo;
			}else if ("spxs_rcjdjcydb".equals(v_tbodytype)){//食品销售日常监督检查要点表
				String v_allRet="";
				//获取企业信息
				PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_spscjy_rcjdjcjgjlb_tbodyinfo=getSpscjyRcjdjcjgjlb(request,company,dto);////食品生产经营日常监督检查结果记录表 公用表


				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//带rowscount明细
				v_kuozhan2=tbodybean.getKuozhan2();//不带rowscount明细
				v_kuozhan3=tbodybean.getKuozhan3();//食品销售日常监督检查要点表

				String v_mygridtable="";
				itemidlist.clear();
				for(int i =0;i<listCheckDetailDto.size();i++){
					//食品销售日常监督检查要点表
					if (listCheckDetailDto.get(i).getContentcode().equals("7.1")){
						v_mygridtable+=v_kuozhan3;
					}

					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan1.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable);
				v_retCheckDto.setCheckresultinfo(v_spscjy_rcjdjcjgjlb_tbodyinfo);
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return v_spscjy_rcjdjcjgjlb_tbodyinfo+tbodyinfo;
			}else if ("spxs_tscshtsspjcxm".equals(v_tbodytype)){//食品销售特殊场所和特殊食品检查项目
				String v_allRet="";
				//获取企业信息
				PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_spscjy_rcjdjcjgjlb_tbodyinfo=getSpscjyRcjdjcjgjlb(request,company,dto);////食品生产经营日常监督检查结果记录表 公用表


				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//带rowscount明细
				v_kuozhan2=tbodybean.getKuozhan2();//不带rowscount明细

				String v_mygridtable="";
				itemidlist.clear();
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan1.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable);
				v_retCheckDto.setCheckresultinfo(v_spscjy_rcjdjcjgjlb_tbodyinfo);
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return v_spscjy_rcjdjcjgjlb_tbodyinfo+tbodyinfo;
			}else if ("bjspsc_rcjdjcydb".equals(v_tbodytype)){//保健食品生产日常监督检查要点表
				String v_allRet="";
				//获取企业信息
				PcompanyDTO company =  getQiyeInfoByid(request, dto);
				if(company==null ){
					throw new BusinessException("未找到企业数据");
				}
				v_spscjy_rcjdjcjgjlb_tbodyinfo=getSpscjyRcjdjcjgjlb(request,company,dto);////食品生产经营日常监督检查结果记录表 公用表


				listCheckDetailDto = getCheckDetail(dto);//需要获取检查明细
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
				v_kuozhan1=tbodybean.getKuozhan1();//带rowscount明细
				v_kuozhan2=tbodybean.getKuozhan2();//不带rowscount明细

				String v_mygridtable="";
				itemidlist.clear();
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}
					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan1.replace("rowscount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailremark",String.valueOf(listCheckDetailDto.get(i).getDetailremark()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
				tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable);
				v_retCheckDto.setCheckresultinfo(v_spscjy_rcjdjcjgjlb_tbodyinfo);
				v_retCheckDto.setDetailinfo(tbodyinfo);
				//return v_spscjy_rcjdjcjgjlb_tbodyinfo+tbodyinfo;
			};



         /**gu20180426}else{//为了兼容原来的
			//使用字符串缓冲器类拼接查询语句
			StringBuffer sb = new StringBuffer();
			String str ="";
			sb.append(" select b.contentcode,b.contentimpt ,b.contentsortid,b.contentscore ,c.itemsortid sortid,  ");
			sb.append("  a.resultid , b.contentid  , b.content  ,c.itemname ,c.itemid,c.itempid ,   ");
			sb.append("  a.detaildecide , a.detailscore ,a.detailng ,a.detailremark, ");
			sb.append("  (select COUNT(*) from bscheckdetail d ,omcheckcontent e  ");
			sb.append("  where d.contentid=e.contentid and e.itemid=c.itemid and d.resultid = :resultid ) count ");
			sb.append("  from bscheckdetail a , omcheckcontent b , omcheckgroup c ");
			sb.append("  where a.contentid = b.contentid ");
			sb.append("  and b.itemid = c.itemid ");
			sb.append(" and a.resultid= :resultid ");
			sb.append(" ORDER BY sortid ,b.contentsortid");
			String sql = sb.toString();
			//转化sql语句
			String[] paramName = new String[]{"resultid"};
			int[] paramType = new int[]{Types.VARCHAR};
			sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
			System.out.println("sql  "+sql);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckDetailDTO.class);
			List<BsCheckDetailDTO> list = (List<BsCheckDetailDTO>) m.get(GlobalNames.SI_RESULTSET);

			// 拼接数据(通过企业大类类区分表头拼接不同的明细表)
			if("2".equals(dto.getComdalei())){//药品生产企业（死数据）
				str = getYPDetaillist( request, dto,list,"YPSC");
			}else if("8".equals(dto.getComdalei())){//药品批发
				str = getYPDetaillist( request, dto,list,"YPJY");
			}else if("9".equals(dto.getComdalei())){//药品零售
				str = getYPDetaillist( request, dto,list,"YPJY");
			}else if("1".equals(dto.getCheckgroupstate())){//聚餐检查
				str = getJCSBDetaillist( request, dto,list);
			}else if("19".equals(dto.getComdalei()) || "3".equals(dto.getComdalei())){//保健食品
				str = getDetaillist( request, dto,list,"BJP");
			}
			else {
				str = getDetaillist( request, dto,list,null);
			}
			//Map map = new HashMap();
			//map.put("data", str);
			//return map;
			//gu2018
			return str;
		}*/




//
//
////	          String checkTrue ="<input  type='checkbox' style='height:20px;width:20px;' checked='checked'>";
//		String checkTrue ="☑";
//		String checkFalse ="□";//&#9633;□
//		if(state!=null && "BJP".equals(state)){
//			dto.setTbodytype("bjp_checkPaln");
//		}else {
//			dto.setTbodytype("checkPaln");
//		}
//		dto.setTbodycode(dto.getPlanchecktype());//计划类别
//		//获取执法人员信息
//		zfryzjhm=  getzfzjh(dto.getUserid()); //执法证件号
//		//获取企业信息
//		PcompanyDTO company =  getQiyeInfoByid(request, dto);
//		//获取表头信息
//		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
//		if(tbodybean!=null){
//			tbodyinfo= tbodybean.getTbodyinfo();
//			tfootinfo=tbodybean.getTfootinfo();
//			tbody=tbodybean.getTbody();
//		}
//		String tbodyval="";
//		//表头
//		//量化
//		if(ConstSupervison.CheckType.LiangHua.toString().equals(dto.getPlanchecktype())){
//			if(company!=null ){
//				String starttime = company.getOperatedate();
//				String endtime = company.getResultdate();
//				//表头赋值
//				if(starttime.substring(0,10) == endtime.substring(0,10)){//同一天
//
//					tbodyval=tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
//									  .replace("comdz",company.getComdz()==null?"":company.getComdz())
//									  .replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
//									  .replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
////				  					.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
////				  					.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
//									  .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//									  .replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
//									  .replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())//店面
//									  .replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
//									  .replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
//									  .replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
//									  .replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
//									  .replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
//									  .replace("to_check_time",endtime.substring(11,13)==null?"":endtime.substring(11,13))
//									  .replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
//				}else{
//					tbodyval= tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
//									   .replace("comdz",company.getComdz()==null?"":company.getComdz())
//									   .replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
//									   .replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
////							.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
////							.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
//									   .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//									   .replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
//									   .replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())
//									   .replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
//									   .replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
//									   .replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
//									   .replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
//									   .replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
//									   .replace("to_check_time",endtime.substring(0,13)==null?"":endtime.substring(0,13))
//									   .replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
//				}
//			}
//			//固定表头
//			if(tbody!=null&&!"".equals(tbody)){
//				String str = tbody.replace("</tbody>", "").replace("</table>", "");
//				sb.append(str);
//			}
//
//			for(int i =0;i<list.size();i++){
//				//含有不合并
//				if(itemidlist.contains(list.get(i).getItemid())){
//					sb.append("<tr><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
//				}else{
//					itemidlist.add(list.get(i).getItemid());
//					sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
//				}
//			}
//	        	  /*gu20170220 注销
//	        	  //平均分
//	        	 float  averageScore =0;
//	        	 BsCheckMasterDto  checkMaster = getAverageScore(dto);
//	        	 if(checkMaster!=null){
//	        		 averageScore=checkMaster.getAverageScore();
//				 }
//	        	 //等级
//	        	 String level= getlevelInfo(averageScore, dto);
//	        	 */
//			String v_sql="select a.*,(select getAa10_aaa102aaa103('LHFJDTPDDJ',a.lhfjdtpddj,'&') ) as lhfjdtpddjstr  "+
//					" from bscheckmaster a "+
//					" where a.resultid='"+dto.getResultid()+"'";
//			BsCheckMaster v_myBsCheckMaster=(BsCheckMaster)DbUtils.getDataList(v_sql, BsCheckMaster.class).get(0);
//			//平均分
//			double  averageScore =v_myBsCheckMaster.getCheckavgscore();
//			//等级
//			String level= v_myBsCheckMaster.getLhfjdtpddjstr();
//
//
//
//			//格式化小数，不足的补0
//			DecimalFormat df = new DecimalFormat("0.0");
//			String  average = df.format(averageScore);
//			String[] str  =level.split("&");
//			tfootinfo=tfootinfo.replace("average", average).replace("assesslevel", str[0]);
//			sb.append(tfootinfo);
//			tfootinfo="";
//			sb.append("</tbody></table>");
//		}else if("1".equals(dto.getPlanchecktype())){//日常
//			//表头赋值
//			if(company!=null ){
//				tbodyval=tbodyinfo.replace("Itemname",company.getItemname()==null?"":company.getItemname())
//								  .replace("commc",company.getCommc()==null?"":company.getCommc())
//								  .replace("comdz",company.getComdz()==null?"":company.getComdz())
//								  .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//								  .replaceFirst("check_startime",company.getOperatedate()==null?"": DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getOperatedate()))
//								  .replace("check_endtime",company.getResultdate()==null?"":DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getResultdate()))
//								  .replace("checkdz",company.getComdz()==null?"":company.getComdz());
////	  					.replace("</tbody>", "").replace("</table>", "");
//			}
//			if(tbody!=null&&!"".equals(tbodyinfo)){
//				String str = tbody.replace("Itemname",company.getItemname()==null?"":company.getItemname())
//								  .replace("</tbody>", "").replace("</table>", "");
//				sb.append(str);
//			}
//			//明细拼接
//			for(int i =0;i<list.size();i++){
//				//含有不合并
//				if(itemidlist.contains(list.get(i).getItemid())){
////	      				sb.append("<tr  id='tr"+i+"' ><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
//					sb.append("<tr  id='tr"+i+"' ><td style='text-align:center;'>"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
//				}else{
//					itemidlist.add(list.get(i).getItemid());
////	      				sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
//					sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td style='text-align:center;' >"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
//				}
//			}
//			sb.append("</tbody></table>");
//		}
//
//
//
//		return tbodyval+sb.toString()+tfootinfo;
		return v_retCheckDto;
	};

	/**
	 * 查询检查明细结果 结果id，
	 * @param dto  计划dto
	 * @return
	 * @throws Exception
	 */
	private String getDetailByid_20180412(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		String str ="";
		sb.append(" select b.contentcode,b.contentimpt ,b.contentsortid,b.contentscore ,c.itemsortid sortid,  ");
		sb.append("  a.resultid , b.contentid  , b.content  ,c.itemname ,c.itemid,c.itempid ,   ");
		sb.append("  a.detaildecide , a.detailscore ,a.detailng ,a.detailremark, ");
		sb.append("  (select COUNT(*) from bscheckdetail d ,omcheckcontent e  ");
		sb.append("  where d.contentid=e.contentid and e.itemid=c.itemid and d.resultid = :resultid ) count ");
		sb.append("  from bscheckdetail a , omcheckcontent b , omcheckgroup c ");
		sb.append("  where a.contentid = b.contentid ");
		sb.append("  and b.itemid = c.itemid ");
		sb.append(" and a.resultid= :resultid ");
		sb.append(" ORDER BY sortid ,b.contentsortid");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println("sql  "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckDetailDTO.class);
		List<BsCheckDetailDTO> list = (List<BsCheckDetailDTO>) m.get(GlobalNames.SI_RESULTSET);

		// 拼接数据(通过企业大类类区分表头拼接不同的明细表)
		if("2".equals(dto.getComdalei())){//药品生产企业（死数据）
			str = getYPDetaillist( request, dto,list,"YPSC");
		}else if("8".equals(dto.getComdalei())){//药品批发
			str = getYPDetaillist( request, dto,list,"YPJY");
		}else if("9".equals(dto.getComdalei())){//药品零售
			str = getYPDetaillist( request, dto,list,"YPJY");
		}else if("1".equals(dto.getCheckgroupstate())){//聚餐检查
			str = getJCSBDetaillist( request, dto,list);
		}else if("19".equals(dto.getComdalei()) || "3".equals(dto.getComdalei())){//保健食品
			str = getDetaillist( request, dto,list,"BJP");
		}
		else {
			str = getDetaillist( request, dto,list,null);
		}
		//Map map = new HashMap();
		//map.put("data", str);
		//return map;
		//gu2018
		return str;
	}

	/**
	 * 拼接明细字符串
	 * @param list  明细列表
	 * @return
	 * @throws Exception
	 */
	private String  getJCSBDetaillist(HttpServletRequest request, BsCheckMasterDTO dto, List<BsCheckDetailDTO> list) throws Exception {
		List itemidlist = new ArrayList();
		StringBuffer sb = new StringBuffer();
		String tbody="";
		String tbodyBotoom="";
		String checkTrue ="☑";
		String checkFalse ="□";//&#9633;□
		dto.setTbodytype("jcsbCheckPaln");
		dto.setTbodycode(dto.getPlanchecktype());
		//获取表头信息
		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
		if(tbodybean!=null){
			tbody= tbodybean.getTbodyinfo();
			tbodyBotoom=tbodybean.getTfootinfo();

			String tbodyval="";
			//表头
			for(int i =0;i<list.size();i++){
				//含有不合并
				if(itemidlist.contains(list.get(i).getItemid())){
					sb.append("<tr  id='tr"+i+"' ><td>"+list.get(i).getContent()+"</td><td>"+list.get(i).getContentsortid()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
				}else{
					itemidlist.add(list.get(i).getItemid());
					sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContent()+"</td><td>"+list.get(i).getContentsortid()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
				}
			}
			//表尾
			sb.append("</tbody>");
			tbodyval=tbody.replace("</tbody>", sb.toString());

			return tbodyval+tbodyBotoom;
		}

		return null;
	}
	/**
	 * 药品拼接明细字符串
	 * @param list  明细列表
	 * @return
	 * @throws Exception
	 */
	private String  getYPDetaillist(HttpServletRequest request, BsCheckMasterDTO dto, List<BsCheckDetailDTO> list, String state) throws Exception {
		List itemidlist = new ArrayList();
		StringBuffer sb = new StringBuffer();
		String tbody="";
		String tbodyBotoom="";
		//药品生产
		if("YPSC".equals(state)){
			dto.setTbodytype("JPSCQY_checkPaln");
		}else if ("YPJY".equals(state)){//药品经营
			dto.setTbodytype("JPJYQY_checkPlan");
		}else {//药品经营
			dto.setTbodytype("JPJYQY_checkPlan");
		}

		dto.setTbodycode(dto.getPlanchecktype());
		//获取企业信息
		PcompanyDTO company =  getQiyeInfoByid(request, dto);
		//获取表头信息
		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
		if(tbodybean!=null){
			tbody= tbodybean.getTbodyinfo();
			tbodyBotoom=tbodybean.getTfootinfo();
		}
		String tbodyval="";
		String isFuhe="";
		//表头
		//生产
		if("YPSC".equals(state)){
			if(company!=null ){
				String starttime = company.getOperatedate();
				String endtime = company.getResultdate();
				//表头赋值
				tbodyval=tbody.replace("Itemname", company.getItemname()==null?"":company.getItemname())
						.replace("commc",company.getCommc()==null?"":company.getCommc())
						.replace("comdz",company.getComdz()==null?"":company.getComdz())
						.replace("checktime",starttime==null?"":starttime)
						.replace("checktype", "日常检查")
						.replace("</table>", "").replace("</tbody>", "");
			}
			for(int i =0;i<list.size();i++){
				if("1".equals(list.get(i).getDetaildecide())){
					isFuhe="&radic;";
				}else if("2".equals(list.get(i).getDetaildecide())){
					isFuhe="&times";
				}
				//含有不合并
				if(itemidlist.contains(list.get(i).getItemid())){
					sb.append("<tr><td colspan='2'>"+list.get(i).getContent()+"</td><td>("+isFuhe+")</td></tr>");
				}else{
					itemidlist.add(list.get(i).getItemid());
					sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td colspan='2' >"+list.get(i).getContent()+"</td><td>("+isFuhe+")</td></tr>");
				}
			}
			//表尾
			sb.append(tbodyBotoom);

			sb.append("</tbody></table>");
		}else if("YPJY".equals(state)){//经营
			//表头赋值
			if(company!=null ){
				tbodyval=tbody.replace("Itemname",company.getItemname()==null?"":company.getItemname())
						.replace("commc",company.getCommc()==null?"":company.getCommc())
						.replace("comdz",company.getComdz()==null?"":company.getComdz())
						.replace("comjyfw",company.getComxkfw()==null?"":company.getComxkfw())
						.replace("comxhz",company.getComxkzbh()==null?"":company.getComxkzbh())
						.replace("comqyfr",company.getComfrhyz()==null?"":company.getComfrhyz())
						.replace("tex",company.getComgddh()==null?"":company.getComgddh())
						.replace("phone",company.getComyddh()==null?"":company.getComyddh())
						.replace("comfzr",company.getComfzr()==null?"":company.getComfzr())
						.replace("comzlfzr","").replace("comzc","").replace("bgdh","")
						.replace("modile","").replace("comysandtyep","").replace("xyyj", "")
						.replace("check_startime",company.getOperatedate()==null?"":company.getOperatedate())
						.replace("zyyj","")
//	  					.replace("check_endtime",company.getResultdate()==null?"":company.getResultdate())
//	  					.replace("comdz1",company.getComdz()==null?"":company.getComdz())
						.replace("</tbody>", "").replace("</table>", "");

			}
			//明细拼接
			for(int i =0;i<list.size();i++){
				if("1".equals(list.get(i).getDetaildecide())){
					isFuhe="&radic;";
				}else if("2".equals(list.get(i).getDetaildecide())){
					isFuhe="&times";
				}
				//含有不合并
				if(itemidlist.contains(list.get(i).getItemid())){
					sb.append("<tr  id='tr"+i+"' ><td colspan='5'>"+list.get(i).getContent()+"</td><td colspan='2'>"+isFuhe+"</td></tr>");
				}else{
					itemidlist.add(list.get(i).getItemid());
					sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td colspan='5'>"+list.get(i).getContent()+"</td><td colspan='2'>"+isFuhe+"</td></tr>");
				}
			}
			sb.append(tbodyBotoom);
			sb.append("</tbody></table>");
		}



		return tbodyval+sb.toString();

	}

	/**
	 * 食品拼接明细字符串
	 * @param listCheckDetailDto/明细列表
	 * @return
	 * @throws Exception□是 □否
	 */
	private String  getDetaillist_20180416(HttpServletRequest request, BsCheckMasterDTO dto, List<BsCheckDetailDTO> listCheckDetailDto, String state) throws Exception {

		//        //不再分四品一械 量化日常 只根据tbodytype 来区分报表
		//需要用哪个报表 从手机打印和检查模板对应表omprint查
		String v_sql="select  b.* from bscheckpicset a,omprint b,omcheckgroup c,bscheckmaster d "
				+" where a.itemid=c.itemid and c.itempid=b.itemid and a.planid=d.planid and d.resultid='"+dto.getResultid()+"' limit 1";
		List<OmprintDTO> v_omprintList=(List<OmprintDTO>)DbUtils.getDataList(v_sql,OmprintDTO.class);
		String v_tbodytype="";
		if (v_omprintList!=null && v_omprintList.size()>0){
			v_tbodytype=v_omprintList.get(0).getTbodytype();
		}else{
			throw new BusinessException("未找到对应的报表");
		};
		dto.setTbodytype(v_tbodytype);

		//获取表头信息
		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);

		if(tbodybean==null){
			throw new BusinessException("未获取到报表信息");
		}

		List itemidlist = new ArrayList();
		StringBuffer sb = new StringBuffer();
		String tbodyinfo="";
		String tfootinfo="";
		//String zfryzjhm="";
		String tbody="";//☑
		String v_kuozhan1="";
		String v_kuozhan2="";
		String v_kuozhan3="";
		String v_kuozhan4="";
		String v_kuozhan5="";
		String v_kuozhan6="";

		String v_checkTrue ="☑是 □否";
		String v_checkFalse ="□是 ☑否";//&#9633;□
		String v_nocheck="□是 □否";
		String v_detaildecide="";

		if ("spxs_dtfxlhfzb".equals(v_tbodytype)){//食品销售环节动态风险因素量化分值表【系统内置，不要删】检查结果
				tbodyinfo= tbodybean.getTbodyinfo();//主体表格
			    v_kuozhan1=tbodybean.getKuozhan1();//食品通用检查项目
			    v_kuozhan2=tbodybean.getKuozhan2();//明细项目tr 不合并行
			    v_kuozhan3=tbodybean.getKuozhan3();//特殊场所和特殊食品检查项目tr
			    v_kuozhan4=tbodybean.getKuozhan4();//明细项目tr 合并行

				String v_mygridtable=v_kuozhan1;
				for(int i =0;i<listCheckDetailDto.size();i++){
					//明细结果判定0未选择1符合2不符合3合理缺项
					if ("1".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkTrue;
					}else if ("2".equals(listCheckDetailDto.get(i).getDetaildecide())){
						v_detaildecide=v_checkFalse;
					}else {
						v_detaildecide=v_nocheck;
					}

					if (listCheckDetailDto.get(i).getContentcode().equals("7.1")) {
						v_mygridtable+=v_kuozhan3;
					};

					//含有不合并
					if(itemidlist.contains(listCheckDetailDto.get(i).getItemid())){
						v_mygridtable+=v_kuozhan2.replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailscore",String.valueOf(listCheckDetailDto.get(i).getDetailscore()));

						//sb.append("<tr><td>"+listCheckDetailDto.get(i).getContentcode()+"."+listCheckDetailDto.get(i).getContent()+"</td><td style='text-align:center;'>"+listCheckDetailDto.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}else{
						itemidlist.add(listCheckDetailDto.get(i).getItemid());
						v_mygridtable+=v_kuozhan4.replace("rowspancount",listCheckDetailDto.get(i).getCount())
												 .replace("itemname",listCheckDetailDto.get(i).getItemname()==null?"":listCheckDetailDto.get(i).getItemname())
												 .replace("contentcode",listCheckDetailDto.get(i).getContentcode()==null?"":listCheckDetailDto.get(i).getContentcode())
												 .replace("content",listCheckDetailDto.get(i).getContent()==null?"":listCheckDetailDto.get(i).getContent())
												 .replace("detaildecide",v_detaildecide)
												 .replace("detailscore",String.valueOf(listCheckDetailDto.get(i).getDetailscore()));
						//sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
					}


				}
			tbodyinfo=tbodyinfo.replace("mygridtable",v_mygridtable)
			.replace("resultscore","本次检查合计得分："+dto.getResultscore());
			return tbodyinfo;
		}else if ("spxs_dtfxlhfzb".equals(v_tbodytype)) {//食品销售环节动态风险因素量化分值表【系统内置，不要删】检查结果
            //
		};



//
//
////	          String checkTrue ="<input  type='checkbox' style='height:20px;width:20px;' checked='checked'>";
//		String checkTrue ="☑";
//		String checkFalse ="□";//&#9633;□
//		if(state!=null && "BJP".equals(state)){
//			dto.setTbodytype("bjp_checkPaln");
//		}else {
//			dto.setTbodytype("checkPaln");
//		}
//		dto.setTbodycode(dto.getPlanchecktype());//计划类别
//		//获取执法人员信息
//		zfryzjhm=  getzfzjh(dto.getUserid()); //执法证件号
//		//获取企业信息
//		PcompanyDTO company =  getQiyeInfoByid(request, dto);
//		//获取表头信息
//		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
//		if(tbodybean!=null){
//			tbodyinfo= tbodybean.getTbodyinfo();
//			tfootinfo=tbodybean.getTfootinfo();
//			tbody=tbodybean.getTbody();
//		}
//		String tbodyval="";
//		//表头
//		//量化
//		if(ConstSupervison.CheckType.LiangHua.toString().equals(dto.getPlanchecktype())){
//			if(company!=null ){
//				String starttime = company.getOperatedate();
//				String endtime = company.getResultdate();
//				//表头赋值
//				if(starttime.substring(0,10) == endtime.substring(0,10)){//同一天
//
//					tbodyval=tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
//									  .replace("comdz",company.getComdz()==null?"":company.getComdz())
//									  .replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
//									  .replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
////				  					.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
////				  					.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
//									  .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//									  .replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
//									  .replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())//店面
//									  .replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
//									  .replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
//									  .replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
//									  .replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
//									  .replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
//									  .replace("to_check_time",endtime.substring(11,13)==null?"":endtime.substring(11,13))
//									  .replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
//				}else{
//					tbodyval= tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
//									   .replace("comdz",company.getComdz()==null?"":company.getComdz())
//									   .replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
//									   .replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
////							.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
////							.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
//									   .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//									   .replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
//									   .replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())
//									   .replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
//									   .replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
//									   .replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
//									   .replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
//									   .replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
//									   .replace("to_check_time",endtime.substring(0,13)==null?"":endtime.substring(0,13))
//									   .replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
//				}
//			}
//			//固定表头
//			if(tbody!=null&&!"".equals(tbody)){
//				String str = tbody.replace("</tbody>", "").replace("</table>", "");
//				sb.append(str);
//			}
//
//			for(int i =0;i<list.size();i++){
//				//含有不合并
//				if(itemidlist.contains(list.get(i).getItemid())){
//					sb.append("<tr><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
//				}else{
//					itemidlist.add(list.get(i).getItemid());
//					sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
//				}
//			}
//	        	  /*gu20170220 注销
//	        	  //平均分
//	        	 float  averageScore =0;
//	        	 BsCheckMasterDto  checkMaster = getAverageScore(dto);
//	        	 if(checkMaster!=null){
//	        		 averageScore=checkMaster.getAverageScore();
//				 }
//	        	 //等级
//	        	 String level= getlevelInfo(averageScore, dto);
//	        	 */
//			String v_sql="select a.*,(select getAa10_aaa102aaa103('LHFJDTPDDJ',a.lhfjdtpddj,'&') ) as lhfjdtpddjstr  "+
//					" from bscheckmaster a "+
//					" where a.resultid='"+dto.getResultid()+"'";
//			BsCheckMaster v_myBsCheckMaster=(BsCheckMaster)DbUtils.getDataList(v_sql, BsCheckMaster.class).get(0);
//			//平均分
//			double  averageScore =v_myBsCheckMaster.getCheckavgscore();
//			//等级
//			String level= v_myBsCheckMaster.getLhfjdtpddjstr();
//
//
//
//			//格式化小数，不足的补0
//			DecimalFormat df = new DecimalFormat("0.0");
//			String  average = df.format(averageScore);
//			String[] str  =level.split("&");
//			tfootinfo=tfootinfo.replace("average", average).replace("assesslevel", str[0]);
//			sb.append(tfootinfo);
//			tfootinfo="";
//			sb.append("</tbody></table>");
//		}else if("1".equals(dto.getPlanchecktype())){//日常
//			//表头赋值
//			if(company!=null ){
//				tbodyval=tbodyinfo.replace("Itemname",company.getItemname()==null?"":company.getItemname())
//								  .replace("commc",company.getCommc()==null?"":company.getCommc())
//								  .replace("comdz",company.getComdz()==null?"":company.getComdz())
//								  .replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
//								  .replaceFirst("check_startime",company.getOperatedate()==null?"": DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getOperatedate()))
//								  .replace("check_endtime",company.getResultdate()==null?"":DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getResultdate()))
//								  .replace("checkdz",company.getComdz()==null?"":company.getComdz());
////	  					.replace("</tbody>", "").replace("</table>", "");
//			}
//			if(tbody!=null&&!"".equals(tbodyinfo)){
//				String str = tbody.replace("Itemname",company.getItemname()==null?"":company.getItemname())
//								  .replace("</tbody>", "").replace("</table>", "");
//				sb.append(str);
//			}
//			//明细拼接
//			for(int i =0;i<list.size();i++){
//				//含有不合并
//				if(itemidlist.contains(list.get(i).getItemid())){
////	      				sb.append("<tr  id='tr"+i+"' ><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
//					sb.append("<tr  id='tr"+i+"' ><td style='text-align:center;'>"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
//				}else{
//					itemidlist.add(list.get(i).getItemid());
////	      				sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
//					sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td style='text-align:center;' >"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
//				}
//			}
//			sb.append("</tbody></table>");
//		}
//
//
//
//		return tbodyval+sb.toString()+tfootinfo;
      return "";
	};

	/**
	 * 食品拼接明细字符串
	 * @param list  明细列表
	 * @return
	 * @throws Exception
	 */
	private String  getDetaillist(HttpServletRequest request, BsCheckMasterDTO dto, List<BsCheckDetailDTO> list, String state) throws Exception {
		List itemidlist = new ArrayList();
		StringBuffer sb = new StringBuffer();
		String tbodyinfo="";
		String tfootinfo="";
		String zfryzjhm="";
		String tbody="";//☑
//	          String checkTrue ="<input  type='checkbox' style='height:20px;width:20px;' checked='checked'>";
		String checkTrue ="☑";
		String checkFalse ="□";//&#9633;□
		if(state!=null && "BJP".equals(state)){
			dto.setTbodytype("bjp_checkPaln");
		}else {
			dto.setTbodytype("checkPaln");
		}
		dto.setTbodycode(dto.getPlanchecktype());//计划类别
		//获取执法人员信息
		zfryzjhm=  getzfzjh(dto.getUserid()); //执法证件号
		//获取企业信息
		PcompanyDTO company =  getQiyeInfoByid(request, dto);
		//获取表头信息
		BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
		if(tbodybean!=null){
			tbodyinfo= tbodybean.getTbodyinfo();
			tfootinfo=tbodybean.getTfootinfo();
			tbody=tbodybean.getTbody();
		}
		String tbodyval="";
		//表头
		//量化
		if(ConstSupervison.CheckType.LiangHua.toString().equals(dto.getPlanchecktype())){
			if(company!=null ){
				String starttime = company.getOperatedate();
				String endtime = company.getResultdate();
				//表头赋值
				if(starttime.substring(0,10) == endtime.substring(0,10)){//同一天

					tbodyval=tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
							.replace("comdz",company.getComdz()==null?"":company.getComdz())
							.replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
							.replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
//				  					.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
//				  					.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
							.replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
							.replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
							.replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())//店面
							.replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
							.replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
							.replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
							.replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
							.replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
							.replace("to_check_time",endtime.substring(11,13)==null?"":endtime.substring(11,13))
							.replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
				}else{
					tbodyval= tbodyinfo.replace("commc",company.getCommc()==null?"":company.getCommc())
							.replace("comdz",company.getComdz()==null?"":company.getComdz())
							.replace("comfrhyz",company.getComfrhyz()==null?"":company.getComfrhyz())
							.replace("comyddh",company.getComyddh()==null?"":company.getComyddh())
//							.replace("comfrhyz",dto.getLxr()==null?"":dto.getLxr())
//							.replace("comyddh",dto.getLxdh()==null?"":dto.getLxdh())
							.replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
							.replace("comxkzbh",company.getComxkzbh()==null?"":company.getComxkzbh())
							.replace("comdmlx",company.getComdmlx()==null?"":company.getComdmlx())
							.replace("check_year",starttime.substring(0,4)==null?"":starttime.substring(0,4))
							.replace("check_month",starttime.substring(5,7)==null?"":starttime.substring(5,7))
							.replace("check_data",starttime.substring(8,10)==null?"":starttime.substring(8,10))
							.replaceFirst("check_time",starttime.substring(11,13)==null?"":starttime.substring(11,13))
							.replaceFirst("check_fen",starttime.substring(14,16)==null?"":starttime.substring(14,16))
							.replace("to_check_time",endtime.substring(0,13)==null?"":endtime.substring(0,13))
							.replace("to_check_fen",endtime.substring(14,16)==null?"":endtime.substring(14,16));
				}
			}
			//固定表头
			if(tbody!=null&&!"".equals(tbody)){
				String str = tbody.replace("</tbody>", "").replace("</table>", "");
				sb.append(str);
			}

			for(int i =0;i<list.size();i++){
				//含有不合并
				if(itemidlist.contains(list.get(i).getItemid())){
					sb.append("<tr><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
				}else{
					itemidlist.add(list.get(i).getItemid());
					sb.append("<tr ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+"  style='text-align:center;' >"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentcode()+"."+list.get(i).getContent()+"</td><td style='text-align:center;'>"+list.get(i).getContentscore()+"</td><td style='text-align:center;'>"+list.get(i).getDetailscore()+"</td></tr>");
				}
			}
	        	  /*gu20170220 注销
	        	  //平均分
	        	 float  averageScore =0;
	        	 BsCheckMasterDto  checkMaster = getAverageScore(dto);
	        	 if(checkMaster!=null){
	        		 averageScore=checkMaster.getAverageScore();
				 }
	        	 //等级
	        	 String level= getlevelInfo(averageScore, dto);
	        	 */
			String v_sql="select a.*,(select getAa10_aaa102aaa103('LHFJDTPDDJ',a.lhfjdtpddj,'&') ) as lhfjdtpddjstr  "+
					" from bscheckmaster a "+
					" where a.resultid='"+dto.getResultid()+"'";
			BsCheckMaster v_myBsCheckMaster=(BsCheckMaster)DbUtils.getDataList(v_sql, BsCheckMaster.class).get(0);
			//平均分
			double  averageScore =v_myBsCheckMaster.getCheckavgscore();
			//等级
			String level= v_myBsCheckMaster.getLhfjdtpddjstr();



			//格式化小数，不足的补0
			DecimalFormat df = new DecimalFormat("0.0");
			String  average = df.format(averageScore);
			String[] str  =level.split("&");
			tfootinfo=tfootinfo.replace("average", average).replace("assesslevel", str[0]);
			sb.append(tfootinfo);
			tfootinfo="";
			sb.append("</tbody></table>");
		}else if("1".equals(dto.getPlanchecktype())){//日常
			//表头赋值
			if(company!=null ){
				tbodyval=tbodyinfo.replace("Itemname",company.getItemname()==null?"":company.getItemname())
						.replace("commc",company.getCommc()==null?"":company.getCommc())
						.replace("comdz",company.getComdz()==null?"":company.getComdz())
						.replace("zfryzjhm", zfryzjhm==null?"":zfryzjhm)
						.replaceFirst("check_startime",company.getOperatedate()==null?"": DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getOperatedate()))
						.replace("check_endtime",company.getResultdate()==null?"":DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getResultdate()))
						.replace("checkdz",company.getComdz()==null?"":company.getComdz());
//	  					.replace("</tbody>", "").replace("</table>", "");
			}
			if(tbody!=null&&!"".equals(tbodyinfo)){
				String str = tbody.replace("Itemname",company.getItemname()==null?"":company.getItemname())
						.replace("</tbody>", "").replace("</table>", "");
				sb.append(str);
			}
			//明细拼接
			for(int i =0;i<list.size();i++){
				//含有不合并
				if(itemidlist.contains(list.get(i).getItemid())){
//	      				sb.append("<tr  id='tr"+i+"' ><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
					sb.append("<tr  id='tr"+i+"' ><td style='text-align:center;'>"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
				}else{
					itemidlist.add(list.get(i).getItemid());
//	      				sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td>"+list.get(i).getContentsortid()+"</td><td>"+list.get(i).getContent()+"</td><td>"+getconentimpinfo("CONTENTIMPT",list.get(i).getContentimpt())+"</td><td>"+(("1".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("2".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td><td>"+(("3".equals(list.get(i).getDetaildecide()))?"&radic;":"")+"</td></tr>");
					sb.append("<tr id='total"+i+"' ><td id="+list.get(i).getItemid()+" rowspan="+list.get(i).getCount()+">"+list.get(i).getItemname()+"</td><td style='text-align:center;' >"+list.get(i).getContentcode()+"</td><td>"+list.get(i).getContent()+"</td><td style='text-align:center;'>"+(("1".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"是&nbsp;"+(("2".equals(list.get(i).getDetaildecide()))?checkTrue:checkFalse)+"否</td><td style='text-align:center;'>"+(("3".equals(list.get(i).getDetaildecide()))?"不适用":"")+"</td></tr>");
				}
			}
			sb.append("</tbody></table>");
		}



		return tbodyval+sb.toString()+tfootinfo;

	}

	/**
	 * 查询重要性
	 * @param code
	 * @param value
	 * @return
	 * @throws Exception
	 */
	private String getconentimpinfo(String code,String value ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
//		 System.out.println(dao.fetch(Aa10.class, Cnd.where("AAA100", "=", code).and("AAA102", "=", value)).getAaa103());
		//转化sql语句
		String aaa103 = dao.fetch(Aa10.class, Cnd.where("AAA100", "=", code).and("AAA102", "=", value)).getAaa103();
		return aaa103;
	}
    /******************保存结果信息处理块******ED**********/

	/******************提交结果信息处理块******ST**********/
	/**
	 * 修改结果信息
	 *
	 */
	public String updateResultinfo(HttpServletRequest request,
								   BsCheckMasterDTO dto) {
		try {
			updateResultinfoImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 修改结果信息实现方法 使用事务控制
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@Aop({ "trans" })
	private void updateResultinfoImpl(HttpServletRequest request,
									  BsCheckMasterDTO dto) throws Exception {
		BsCheckMaster master = dao
				.fetch(BsCheckMaster.class, dto.getResultid());

		//gu20180426预览之改下状态
		if (ConstSupervison.CheckMasterState.Preview.toString().equals(dto.getResultstate())){
			master.setResultstate(dto.getResultstate());
		}else{
			//gu20170606 执法人员签字 被检查单位签字 begin
			String v_sql="SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) AS zfryqmpic,"+
					" max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) AS bjcdwqmpic "+
					" FROM fj a "+
					" WHERE a.fjwid='"+dto.getResultid()+"';";
			BsCheckMasterDTO masterDto=(BsCheckMasterDTO)DbUtils.getDataList(v_sql, BsCheckMasterDTO.class).get(0);
			String  contextPath = request.getContextPath();
			if (!com.lbs.util.StringUtils.isEmpty(masterDto.getZfryqmpic())){
				dto.setZfryqmpic(contextPath+masterDto.getZfryqmpic());

			}
			if (!com.lbs.util.StringUtils.isEmpty(masterDto.getBjcdwqmpic())){
				dto.setBjcdwqmpic(contextPath+masterDto.getBjcdwqmpic());
			}
            String v_cyfwdtdjpd="0";
			//gu20180507 add 餐饮服务食品安全监督动态等级评定表
			if (StringUtils.isNotEmpty(dto.getOperatetype())&&"cyfwdtdjpd_biaotou".equals(dto.getOperatetype())){
				v_cyfwdtdjpd="1";
                Pcyfwdtdjpdb v_Pcyfwdtdjpdb=dao.fetch(Pcyfwdtdjpdb.class,Cnd.where("resultid","=",dto.getResultid()));
                String v_pcyfwdtdjpdbid="";
                if (v_Pcyfwdtdjpdb!=null){
					v_pcyfwdtdjpdbid=v_Pcyfwdtdjpdb.getPcyfwdtdjpdbid();
					BeanHelper.copyProperties(dto,v_Pcyfwdtdjpdb);
					v_Pcyfwdtdjpdb.setPcyfwdtdjpdbid(v_pcyfwdtdjpdbid);
					v_Pcyfwdtdjpdb.setJcryqzpic(dto.getZfryqmpic());
					v_Pcyfwdtdjpdb.setSpaqglrypic(dto.getBjcdwqmpic());
					v_Pcyfwdtdjpdb.setAae011(dto.getUserid());
					v_Pcyfwdtdjpdb.setAae036(SysmanageUtil.currentTime());
					dao.update(v_Pcyfwdtdjpdb);
				}else{
					v_Pcyfwdtdjpdb=new Pcyfwdtdjpdb();
					v_pcyfwdtdjpdbid=DbUtils.getSequenceStr();
					BeanHelper.copyProperties(dto,v_Pcyfwdtdjpdb);
					v_Pcyfwdtdjpdb.setPcyfwdtdjpdbid(v_pcyfwdtdjpdbid);
					v_Pcyfwdtdjpdb.setJcryqzpic(dto.getZfryqmpic());
					v_Pcyfwdtdjpdb.setSpaqglrypic(dto.getBjcdwqmpic());
					v_Pcyfwdtdjpdb.setAae011(dto.getUserid());
					v_Pcyfwdtdjpdb.setAae036(SysmanageUtil.currentTime());
					dao.insert(v_Pcyfwdtdjpdb);
				}

			}

			//gu20170606 执法人员签字 被检查单位签字 end

			if (master != null) {
				PcompanyDTO company =getQiyeInfoByid(request, dto);
				// 修改检查完毕标识（4：检查信息固化;5保存完毕）
				master.setResultstate(dto.getResultstate());
				master.setResultdecision(dto.getResultdecision());
				master.setResultng(dto.getResultng());
				master.setResultdate(new Date());// 结束时间
				master.setResultperson(dto.getResultperson());
				master.setLatitude(dto.getLatitude());
				master.setLongitude(dto.getLongitude());
//			if(master.getCheckresultinfo()==null || "".equals(master.getCheckresultinfo())){
//				//编号
//			    String number = DbUtils.getOneValue(dao, "select getResultbh("+company.getComdalei()+") from dual");
//			    dto.setNumber(number);
//			}
				master.setLxr(dto.getLxr());
				master.setLxdh(dto.getLxdh());
				System.out.println("dto.getResultstate() "+dto.getResultstate());

				if(ConstSupervison.CheckMasterState.ResultDecideSaved.toString().equals(dto.getResultstate())
						){
					//gu20180426	|| ConstSupervison.CheckMasterState.Preview.toString().equals(dto.getResultstate())){//6预览 gu20170820add
					System.out.println("dto.getResultstate()222 "+dto.getResultstate());
					String result = SysmanageUtil.getAA027Str(dto.getAaa027(), dto.getAaa383());
					dto.setAaa027(result);


					//处理检查结果信息主体部分
					//gu20180411 String checkresultinfo = getAssignmentResult(company, dto);
					//gu20180411master.setCheckresultinfo(checkresultinfo);
					//故0180426 master.setCheckresultinfo(getDetailByid(request,dto));
					BsCheckMasterDTO v_printdto=getDetailByid(request, dto);
					master.setCheckresultinfo(v_printdto.getCheckresultinfo());
					master.setDetailinfo(v_printdto.getDetailinfo());
				}

				if ("1".equals(v_cyfwdtdjpd)){
					BsCheckMasterDTO v_printdto=getDetailByid(request, dto);
					master.setCheckresultinfo(v_printdto.getCheckresultinfo());
					master.setDetailinfo(v_printdto.getDetailinfo());
				}
//gu20180426			String v_operson= "  ";
//			if("1".equals(company.getComdalei())){//食品生产企业
//
//				v_operson=dto.getResultperson()==null?"":dto.getResultperson();
//			}
//
//			//告知页赋值陪同人
//			String v_Detailinfo=master.getDetailinfo();
//			v_Detailinfo=v_Detailinfo.replace("ptuser", v_operson)
//					.replaceFirst("zfryqmpic", dto.getZfryqmpic()==null?"":dto.getZfryqmpic())
//					.replaceFirst("bjcdwqmpic", dto.getBjcdwqmpic()==null?"":dto.getBjcdwqmpic());
//			master.setDetailinfo(v_Detailinfo);
//			master.setDetailinfo(
//					master.getDetailinfo().replace("ptuser", "  ")
//
//			);
				if(dto.getLocation()==null || "".equals(dto.getLocation())){
					//获取地理位置

				}else{
					master.setLocation(dto.getLocation());
				}
		}


			// 修改
			dao.update(master);
		}
	}

	/**
	 * 结果替换赋值
	 * @param dto  检查计划DTO
	 * @return
	 * @throws Exception
	 */
	private String getAssignmentResult(PcompanyDTO company,BsCheckMasterDTO dto ) throws Exception {
		String resultinfo ="";
		String checkTrue ="☑";
		String checkFalse ="□";
		String nbsp ="&nbsp; &nbsp;";

		if(company!=null){
          if (StringUtils.isEmpty(dto.getTbodytype())){
				dto.setTbodytype("resultInfo");//食品生产经营日常监督检查结果记录表  SELECT * FROM bstbodyinfo WHERE aaa027='410523000000' AND tbodytype='resultInfo' AND tbodycode='1'
			};
            if (StringUtils.isEmpty(dto.getTbodycode())){
				dto.setTbodycode("1");
			}

			BsTbodyInfoDTo	tbodyBean =  getTbodyInfo(null, dto);
			dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
				int total = getResultNumBycomid(null, dto);
				int count = getDetailAllNum(null, dto);
				//序号
				BsResultNumberDTO result = getresultContent(dto);
				//查询
				if(tbodyBean!=null){
					//编号
					String[] dalei =company.getComdalei().split(",");//有的企业大类有多个  函数只能有一个参数，特别处理
					company.setComdalei(dalei[0]);
					String number = DbUtils.getOneValue(dao, "select getResultbh("+company.getComdalei()+") from dual");
					String tdodyInfo = tbodyBean.getTbodyinfo();
					String starttime = company.getOperatedate();
					String resultdisc="";
					//gu20170606add 执法人员签字 被检查企业签字图片路径


					resultinfo = tdodyInfo.replace("commc", company.getCommc()==null?"":company.getCommc())
										  .replace("commdz", company.getComdz()==null?"":company.getComdz())
										  //.replace("comlxr", company.getComfzr()==null?"":company.getComfzr())
										  //.replace("comlxfs", company.getComyddh()==null?"":company.getComyddh())
										  .replace("comlxr", dto.getLxr()==null?"":dto.getLxr())
										  .replace("comlxfs", dto.getLxdh()==null?"":dto.getLxdh())
										  .replace("comxkz", company.getComxkzbh()==null?"":company.getComxkzbh())
										  .replace("year",starttime==null?"":starttime.substring(0,4))
										  .replace("month", starttime==null?"":starttime.substring(5,7))
										  .replace("date",starttime==null?"": starttime.substring(8,10))
										  .replaceFirst("num", String.valueOf(total))
										  .replace("Itemname", company.getItemname()==null?"":company.getItemname())
										  .replaceFirst("count", String.valueOf(count))
										  .replace("fuhe", "101".equals(dto.getResultdecision())?checkTrue:checkFalse)
										  .replace("bufh","103".equals(dto.getResultdecision())?checkTrue:checkFalse)
										  .replace("zhenggai", "102".equals(dto.getResultdecision())?checkTrue:checkFalse)
//						.replace("resultdisc", dto.getResultng()==null?"":dto.getResultng())
										  .replaceFirst("jgbh", number==null?"":number)
										  .replaceFirst("zfryqmpic", dto.getZfryqmpic()==null?"":dto.getZfryqmpic()) //执法人员签名图片
										  .replaceFirst("bjcdwqmpic", dto.getBjcdwqmpic()==null?"":dto.getBjcdwqmpic());//被检查单位签名图片
					//符号赋值
					if(result!=null){
						String impdetail=result.getImpDetail()==null?"":result.getImpDetail();
						String comdetail=result.getComDetail()==null?"":result.getComDetail();
						String str ="<p><strong>结果处理：</strong></p><p>"+
								("1".equals(dto.getResultFinal())?"☑":"□")+"通过 &nbsp;&nbsp;&nbsp;"+
								("2".equals(dto.getResultFinal())?"☑":"□")+"书面限期整改"+
								("3".equals(dto.getResultFinal())?"☑":"□")+"食品生产经营者立即停止食品生产经营活动</p>";
						System.out.println(dto.getResultFinal());
						String checkResult="  ";
						if(!"1".equals(company.getComdalei())){
							resultdisc = impdetail+comdetail;
						}else {//食品生产企业
							resultdisc = dto.getResultng();
							checkResult=str;
						}

						resultinfo=resultinfo.replaceFirst("impcount", String.valueOf(result.getImpcount()))//重点项多少项
											 .replaceFirst("impnum", result.getImpnum()==null?"":result.getImpnum())//重点项，项目序号分别是
											 .replace("resultdisc", resultdisc==null?"":resultdisc)//
											 .replaceFirst("problemcount", String.valueOf(result.getProblemcount()))//发现问题项
											 .replaceFirst("problemnum", result.getProblemnum()==null?"":result.getProblemnum())//发现问题项，项目序号分别是
											 .replaceFirst("commocount", String.valueOf(result.getCommocount()))//一般项多少想
											 .replaceFirst("commnum", result.getCommnum()==null?"":result.getCommnum())//一般项，项目序号分别是
											 .replaceFirst("comproblemcount", String.valueOf(result.getComproblemcount()))//发现问题多少项
											 .replaceFirst("checkResult", checkResult)//检查结果
											 .replaceFirst("comproblemnum", result.getComproblemnum()==null?"":result.getComproblemnum());//发现问题，项目序号分别是
					}
					//巡查笔录
					dto.setTbodytype("lbxcResultInfo");
					dto.setTbodycode("1");
					tbodyBean =  getTbodyInfo(null, dto);
					if(tbodyBean!=null){
						tdodyInfo = tbodyBean.getTbodyinfo();
						starttime = company.getOperatedate();
						String  endtime = company.getResultdate();
						String  lbresultinfo = tdodyInfo.replace("commc", company.getCommc()==null?"":company.getCommc())
														.replace("comdz", company.getComdz()==null?nbsp:company.getComdz())
														//.replace("comfrhyz", company.getComfrhyz()==null?nbsp:company.getComfrhyz())
														//.replace("comyddh", company.getComyddh()==null?nbsp:company.getComyddh())
														.replace("comfrhyz",dto.getLxr()==null?nbsp:dto.getLxr())
														.replace("comyddh", dto.getLxdh()==null?nbsp:dto.getLxdh())
														.replace("year",starttime==null?nbsp:starttime.substring(0,4))
														.replace("month", starttime==null?nbsp:starttime.substring(5,7))
														.replace("date",starttime==null?nbsp: starttime.substring(8,10))
														.replaceFirst("time",starttime==null?nbsp: starttime.substring(11,13))
														.replaceFirst("fen",starttime==null?nbsp: starttime.substring(14,16))
														.replaceFirst("to_time",starttime==null?nbsp: endtime.substring(11,13))
														.replaceFirst("to_fen",starttime==null?nbsp: endtime.substring(14,16));
//								.replace("username", "");
						resultinfo+=lbresultinfo;
					}
				}
		}else {//为其他日常检查
			dto.setTbodytype("resultIfo_jcsb");
			dto.setTbodycode("1");
			BsTbodyInfoDTo	tbodyBean =  getTbodyInfo(null, dto);
			if(tbodyBean!=null){
				String tdodyInfo = tbodyBean.getTbodyinfo();
				resultinfo = tdodyInfo.replace("Itemname", "农村聚餐日常监督检查")
						.replace("fuhe", "101".equals(dto.getResultdecision())?checkTrue:checkFalse)
						.replace("bufh","103".equals(dto.getResultdecision())?checkTrue:checkFalse)
						.replace("zhenggai", "102".equals(dto.getResultdecision())?checkTrue:checkFalse)
						.replace("resultdisc", dto.getResultng()==null?"":dto.getResultng());
			}
		}

		return resultinfo;
	}

	/**
	 * 查询企业年度检查次数
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	private int getResultNumBycomid(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
//		sb.append("   bscheckmaster a , bscheckplan b ");
//		sb.append(" where  a.planid = b.planid and b.planchecktype =:planchecktype ");
		sb.append("   bscheckmaster a ");
		sb.append(" where   a.comid=:comid and a.operatedate like  :year ");
		sb.append(" and 1=1 ");
		sb.append(" order by a.resultid  ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "comid","year" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		int total = dao.count(sql);
		return total;
	}

	/**
	 * 查询出的结果明细个数
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	private int getDetailAllNum(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("   bscheckdetail a, omcheckcontent b  ");
		sb.append(" where  a.contentid=b.contentid and a.resultid=:resultid");
		sb.append(" and a.detaildecide = :detaildecide ");
		if(dto.getNum()!=0){
			sb.append(" and b.contentimpt =:num");
		}
		sb.append(" and 1=1 ");
		sb.append(" order by a.resultid  ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "detaildecide","num","resultid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.INTEGER,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		int total = dao.count(sql);
		return total;
	}

	/**
	 * 查询结果序号内容
	 * @param dto  计划DTO
	 *
	 * @return
	 * @throws Exception
	 */
	private BsResultNumberDTO getresultContent(BsCheckMasterDTO dto) throws Exception {
		//重要性
		BsCheckMasterDTO master = new BsCheckMasterDTO();
		BsResultNumberDTO result = new BsResultNumberDTO();
		//总数
		dto.setNum(1);
		master = getImpDetailNumber(null, dto);
		if(master!=null){
			result.setImpcount(master.getImpnum());//所有设置了重要性的项目数
			result.setImpnum(master.getStr());//所有设置了重要性的项目的项目编码串
		}
		//不及格数（重要性）
		dto.setDetaildecide("2");
		master = getImpDetailNumber(null, dto);
		if(master!=null){
			result.setProblemcount(master.getImpnum());//不符合数
			result.setProblemnum(master.getStr());//不符合项目编码串
			result.setImpDetail(master.getImpDetail());//不符合项目内容串
		}
		//一般性
		dto.setDetaildecide(null);
		master = getGeneralDetailNumber(null, dto);
		if(master!=null){
			result.setCommocount(master.getImpnum());//一般项数
			result.setCommnum(master.getStr());//一般项项目编码串
		}
		//不及格数（一般性）
		dto.setDetaildecide("2");
		master = getGeneralDetailNumber(null, dto);
		if(master!=null){
			result.setComproblemcount(master.getImpnum());//一般项发现问题项目数
			result.setComproblemnum(master.getStr());//一般项发现问题项目编码串
			result.setComDetail(master.getComDetail());//一般项发现问题项目内容串
		}

		return result;
	}

	/**
	 * （重要项）查询具体编号和个数(num 1为不设置)
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	private BsCheckMasterDTO getImpDetailNumber(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select d.contentcode ");
		if("2".equals(dto.getDetaildecide())){
			sb.append(" ,CONCAT(d.contentcode,'.',d.content) as content ");
		}
		sb.append(" from bscheckmaster a ,bscheckdetail c ,omcheckcontent d ");
		sb.append(" where  c.resultid = a.resultid and d.contentid = c.contentid  ");
		sb.append(" and c.detaildecide =:detaildecide and a.resultid =:resultid ");//明细结果判定0未选择1符合2不符合3合理缺项
		sb.append(" and d.contentimpt <>:num");//内容重要性1不设置2×3××4×××
		sb.append(" and 1=1 ");
		sb.append(" order by d.contentsortid  ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "detaildecide","resultid","num"};
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.INTEGER};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		//查询
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> ls = (List<BsCheckMasterDTO>) map.get(GlobalNames.SI_RESULTSET);
		if(ls.size()>0){
			StringBuffer str =new StringBuffer();
			StringBuffer contentstr =new StringBuffer();
			BsCheckMasterDTO masterBean = new BsCheckMasterDTO();
			for(int i =0;i<ls.size();i++){
				//数据太长是表格变形，所以每8个换一次行
				if(i%10==0&&i!=0){
					str.append("</br>");
				}
				str.append(ls.get(i).getContentcode()).append(",");
				if(ls.get(i).getContent()!=null&&!"".equals(ls.get(i).getContent())){
					contentstr.append(ls.get(i).getContent()).append(" </br>");
				}
			}
			if(contentstr.toString()!=null&&!"".equals(contentstr.toString())){
				masterBean.setImpDetail(contentstr==null?"":contentstr.toString());
			}
			masterBean.setStr(str.substring(0, str.lastIndexOf(",")).toString());
			masterBean.setImpnum(ls.size());
			return masterBean;
		}

		return null;
	}

	/**
	 * （一般项）查询具体编号和个数(num 1为不设置)
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	private BsCheckMasterDTO getGeneralDetailNumber(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select d.contentcode ");
		if("2".equals(dto.getDetaildecide())){
			sb.append(" ,CONCAT(d.contentcode,'.',d.content) as content ");
		}
		sb.append(" from bscheckmaster a ,bscheckdetail c ,omcheckcontent d ");
		sb.append(" where  c.resultid = a.resultid and d.contentid = c.contentid ");
		sb.append(" and  c.detaildecide =:detaildecide and a.resultid =:resultid  ");//明细结果判定0未选择1符合2不符合3合理缺项
		sb.append(" and d.contentimpt =:num");
		sb.append(" and 1=1 ");
		sb.append(" order by d.contentsortid ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "detaildecide","resultid","num"};
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.INTEGER};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> ls = (List<BsCheckMasterDTO>) map.get(GlobalNames.SI_RESULTSET);
		if(ls.size()>0){
			StringBuffer str =new StringBuffer();
			StringBuffer contentstr =new StringBuffer();
			BsCheckMasterDTO masterBean = new BsCheckMasterDTO();
			for(int i =0;i<ls.size();i++){
				//数据太长是表格变形，所以每8个换一次行
				if(i%10==0&&i!=0){
					str.append("</br>");
				}
				str.append(ls.get(i).getContentcode()).append(",");
				if(ls.get(i).getContent()!=null&&!"".equals(ls.get(i).getContent())){
					contentstr.append(ls.get(i).getContent()).append(" </br>");
				}
			}
			try {
//			System.out.println("************"+contentstr.toString());
				if(contentstr.toString()!=null&&!"".equals(contentstr.toString())){
					masterBean.setComDetail(contentstr.toString());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			masterBean.setStr(str.substring(0, str.lastIndexOf(",")).toString());
			masterBean.setImpnum(ls.size());
			return masterBean;
		}
		return null;
	}

	/**
	 * 通过查询不符合结果明细个数
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Map getinconformityNumid(HttpServletRequest request,
									BsCheckMasterDTO dto) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		Map map = new HashMap();
		Map mapstr = new HashMap();
		//检查的项目数
		int resultnum = getDetailAllNum(request, dto);
		//合理缺项数
		dto.setDetaildecide(ConstSupervison.Detaildecide.MissedQualified.toString());
		int missItems = getDetailAllNum(request, dto);
		//合格项目数
		dto.setDetaildecide(ConstSupervison.Detaildecide.Qualified.toString());
		int goodItems = getDetailAllNum(request, dto);

		//重要项不合格数
		dto.setDetaildecide(ConstSupervison.Detaildecide.NotQualified.toString());
		dto.setNum(1);
		int impfailitems = getQualifiedNum(request, dto);
		//一般项不合格数
		int generalItems = getDetailAllNum(request, dto);
		//结果状态返给手机做判断
		String state ="";
		CheckRuleDivision checkRuleDivision = null;
		if(Sys.District.ZhengDongXinQu.equals(SysmanageUtil.SYSAAA027)){
			checkRuleDivision = new CheckRuleDivisionImpTangYin();
			state = checkRuleDivision.getState(impfailitems,generalItems);
		}else{
			checkRuleDivision = new CheckRuleDivisionImpZDXQ();
			state = checkRuleDivision.getState(impfailitems,generalItems);
		}


		// 拼接
		sb.append("你单位");
		sb.append("" + BsCheckResultStaticDTO.LABEL_gjxbfhs + impfailitems + "")
				.append("项，");
		sb.append("" + BsCheckResultStaticDTO.LABEL_zdxbfhs + impfailitems + "")
				.append("项，");
		sb.append("" + BsCheckResultStaticDTO.LABEL_ybxbfhs + generalItems + "").append(
				"项，");
		sb.append("" + BsCheckResultStaticDTO.LABEL2_01 + "");
		// 信息传递
		mapstr.put("label1", BsCheckResultStaticDTO.LABEL);
		mapstr.put("label1_01", BsCheckResultStaticDTO.LABEL_01 + impfailitems);
		mapstr.put("label1_02", BsCheckResultStaticDTO.LABEL_03 + (impfailitems+generalItems));
		mapstr.put("label1_03", BsCheckResultStaticDTO.LABEL_05);
		mapstr.put("label2", BsCheckResultStaticDTO.LABEL2);
		mapstr.put("label2_01", sb.toString());
		mapstr.put("label3", BsCheckResultStaticDTO.LABEL3);
		mapstr.put("label3_01", BsCheckResultStaticDTO.LABEL3_01);
		mapstr.put("label3_02", BsCheckResultStaticDTO.LABEL3_02);
		mapstr.put("label3_03", BsCheckResultStaticDTO.LABEL3_03);
		mapstr.put("state", state);
		map.put("data", mapstr);
		return map;
	}

	/**
	 * 通过查询合格明细个数(传入detaildecide和重要性num )
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	private int getQualifiedNum(HttpServletRequest request, BsCheckMasterDTO dto)
			throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("   bscheckdetail a, omcheckcontent b  ");
		sb.append(" where  a.contentid=b.contentid and a.resultid=:resultid");
		sb.append(" and a.detaildecide =:detaildecide and b.contentimpt <> :num");
		sb.append(" and 1=1 ");
		sb.append(" order by a.resultid  ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "detaildecide" ,"num","resultid"};
		int[] paramType = new int[] { Types.VARCHAR,Types.INTEGER,Types.VARCHAR  };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		int total = dao.count(sql);
		return total;
	}


	/******************提交结果信息处理块******ED**********/

	/******************公共信息获取块****ST******/
	/**
	 * 得到表头信息，
	 * @return
	 * @throws Exception
	 */
	private BsTbodyInfoDTo getTbodyInfo(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* from bstbodyinfo a ");
		sb.append("  where 1=1 ");
		sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode and a.aaa027 like :aaa027 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"tbodytype","tbodycode","aaa027"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
		List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}

	//获取执法人员信息
	private  String getzfzjh(String userid) throws Exception{
		if(userid==null){// 手机端传入userid pc端通过session获取userid
			Sysuser s= SysmanageUtil.getSysuser();
			if (s!=null){
				userid=s.getUserid();
			}
		}
		String zjhm="";
		if (!"".equalsIgnoreCase(userid)){
			Viewzfry zfry=dao.fetch(Viewzfry.class, Cnd.where("userid","=",userid));
			if(zfry != null){
				zjhm= zfry.getZfryzjhm();
			}
		}
		return zjhm;
	}

	/**
	 * 查询企业信息通过结果id，
	 * @param   dto 检查结果概要DTO
	 * @return
	 * @throws Exception
	 */
	public PcompanyDTO getQiyeInfoByid(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select  DISTINCT (select e.itemname from omcheckgroup e where e.itemid=d.itempid) itemname, b.*,a.operatedate,a.resultdate,");
		sb.append("(select GROUP_CONCAT(t1.comxkfw)  from pcompanyxkz t1 where t1.comid=b.comid group by t1.comid) as  comxkfw, "); //gu20170421add
		sb.append("(select GROUP_CONCAT(t.comxkzbh) from pcompanyxkz t where comid=a.comid and comxkzlx<>'1') as comxkzbhall,b.comfrhyz,b.comfrhyz ");
		sb.append("  from bscheckmaster a ,pcompany b ,bscheckpicset c ,omcheckgroup d ");
		sb.append("  where a.comid=b.comid and c.planid= a.planid and c.itemid = d.itemid  ");
		sb.append(" and a.resultid= :resultid ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"resultid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class);
		List<PcompanyDTO> list = (List<PcompanyDTO>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}
	/******************公共信息获取块****ED******/

	/**
	 *
	 * saveCheckDetail的中文名称：保存检查结果明细
	 *
	 * saveCheckDetail的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	@Aop( { "trans" })
	public Map saveCheckDetail(HttpServletRequest request, BsCheckDetail dto) throws Exception {
		Map retMap = new HashMap<String, Object>();
		retMap.put("success", false);
		retMap.put("msg", "操作失败");
		retMap.put("detailid", "");
		if(StringUtils.isEmpty(dto.getResultid())){
			retMap.put("msg", "检查结果ID[resultid]不能为空");
			return retMap;
		}
		if(StringUtils.isEmpty(dto.getContentid())){
			retMap.put("msg", "检查内容ID[contentid]不能为空");
			return retMap;
		}
//		Sysuser user = SysmanageUtil.getSysuser();
//		Map<String, Object> resultMap = new HashMap<String, Object>();
		dto.setDetailoperatedate(new Date());
		dto.setDetailcheckdate(new Date());
//		dto.setDetailcheckperson(user.getUserid().toString());
		dto.setDetailoperatedate(new Date());
//		dto.setDetailoperateperson(user.getUserid().toString());
		BsCheckDetail detail = queryResultDetailISExist(request,dto);
		if (null != detail) {
			detail.setDetaildecide(dto.getDetaildecide());
			//符合之外，分数为0
			if(!"1".equals(dto.getDetaildecide())){
				//gu20180512add 生产企业动态评定扣分制
				if (StringUtils.isNotEmpty(dto.getOperatetype()) && "shengchandongtai".equals(dto.getOperatetype())){
					detail.setDetailscore(dto.getDetailscore());
				}else{
					detail.setDetailscore(0);
				}
				//detail.setDetailscore(0);
			}else{
				detail.setDetailscore(dto.getDetailscore());
			}
			detail.setDetailng(dto.getDetailng());
			detail.setDetailattachment(dto.getDetailattachment());
			detail.setDetailremark(dto.getDetailremark());
			if(dao.update(detail)>0){
				retMap.put("success", true);
				retMap.put("msg", "修改成功");
				retMap.put("detailid", detail.getDetailid());

			}
		} else {
			String sequence = DbUtils.getSequenceStr();
			dto.setDetailid(sequence);
			//符合之外，分数为0
			if(!"1".equals(dto.getDetaildecide())){
				//gu20180512add 生产企业动态评定扣分制
				if (StringUtils.isNotEmpty(dto.getOperatetype()) && "shengchandongtai".equals(dto.getOperatetype())){
					//dto.setDetailscore(dto.getDetailscore());
				}else {
					dto.setDetailscore(0);
				}
			}
			dto = dao.insert(dto);
			retMap.put("success", true);
			retMap.put("msg", "保存成功");
			retMap.put("detailid", dto.getDetailid());
		}
		return retMap;
	}

	/**
	 *
	 * saveCheckMaster的中文名称：保存检查结果摘要(手机上用)
	 *
	 * saveCheckMaster的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 *
	 */
	@Aop( { "trans" })
	public Map<String,Object> saveCheckMaster(HttpServletRequest request, BsCheckMaster dto){
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
//		Sysuser user = SysmanageUtil.getSysuser();
		//结束时间
//		dto.setResultdate(new Date());
		//经办时间
		dto.setOperatedate(SysmanageUtil.currentTime());
		//gu20170221begin
		SimpleDateFormat myformat=new SimpleDateFormat("yyyy");
		String v_year=myformat.format(new Date());
		dto.setCheckyear(v_year);
		//aaa027  前台传的有userid 根据userid获取操作员信息
		Sysuser v_sysuser=dao.fetch(Sysuser.class, Cnd.where("userid", "=", dto.getUserid()));
		if (v_sysuser!=null){
			dto.setAaa027(v_sysuser.getAaa027());
		}
		//gu20170221end

		if (null != dto.getResultid()&&!"".equals(dto.getResultid())&&!"null".equalsIgnoreCase(dto.getResultid())) {
			BsCheckMaster se = dao.fetch(BsCheckMaster.class, dto.getResultid());
			se.setResultid(dto.getResultid());
			se.setPlanid(dto.getPlanid());
			se.setComid(dto.getComid());
			se.setResultdecision(dto.getResultdecision());
			se.setResultperson(dto.getResultperson());
			se.setResultng(dto.getResultng());
			se.setResultscore(dto.getResultscore());
			se.setResultremark(dto.getResultremark());
			se.setOperateperson(dto.getOperateperson());
			se.setResultperson(dto.getResultperson());
//			se.setAaa027();
//			se.setAae140();
			se.setUserid(dto.getOperateperson());
			dto.setResultdate(new Date());
//			se.setOrgid();
//			se.setAae011();
//			se.setAae036(new Date());
			if(dao.update(se)>0){
				resultMap.put("success", true);
				return resultMap;
			}
		} else {
			String sequence = DbUtils.getSequenceStr();
			dto.setOperateperson(dto.getOperateperson());
			dto.setResultperson(dto.getResultperson());
			dto.setResultid(sequence);
			dto.setResultstate("0");//新建
			dto.setAaa027(dto.getAaa027());
//			dto.setAae140();
			dto.setUserid(dto.getOperateperson());
			dto.setOrgid(dto.getOrgid());
			dto.setAae011(dto.getAae011());//经办人姓名
			dto.setResultdate(new Date());
//			dto.setAae036(new Date());

			dao.insert(dto);
			resultMap.put("resultid", sequence);
			resultMap.put("success", true);
			return resultMap;
		}
		return resultMap;
	}

	/**
	 *
	 * queryCheckMasterIsExist的中文名称：查询检查结果摘要信息是否存在
	 *
	 * queryCheckMasterIsExist概要说明：
	 *
	 * @param request
	 * @param dto
	 * Written by:syf
	 * @throws Exception
	 */
	public Map queryCheckMasterIsExist(HttpServletRequest request,
									   BsCheckMaster dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.* from bscheckmaster b");
		sb.append(" where 1=1 ");
		sb.append(" and b.comid = :comid and b.planid = :planid ");
		sb.append(" order by b.operatedate");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "comid","planid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMaster.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
//			map.put("success", true);
		return map;
	}

	/**
	 *
	 * getCheckDetailForSaveAfter的中文名称：获取保存后未检查项目
	 *
	 * getCheckDetailForSaveAfter的概要说明：返回大项ID，明细ID和所在检查表位置，位置从0开始
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	public List<Object> getCheckDetailForSaveAfter(HttpServletRequest request, BsCheckMasterDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a1.itemid,a1.contentid,a1.rownum ");
		sb.append(" FROM ( SELECT a.itemid,a.contentid,@rownum:=@rownum+1 AS rownum ");
		sb.append("   FROM (SELECT @rownum:=-1) r,bscheckpicset a where 1=1 and a.planid = :planid ");
		sb.append(" ) a1 LEFT JOIN bscheckdetail b1 ");
		sb.append(" ON a1.contentid = b1.contentid   AND b1.resultid = :resultid ");
		sb.append(" WHERE b1.contentid IS NULL ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "planid","resultid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		return (List<Object>) m.get(GlobalNames.SI_RESULTSET);
	}

	/**
	 * 
	 * queryResultDetailISExist的中文名称：查询检查结果明细信息是否存在
	 *
	 * queryResultDetailISExist概要说明：
	 *
	 * @param request
	 * @param dto
	 * Written by:syf
	 * @throws Exception 
	 */
	private BsCheckDetail queryResultDetailISExist(HttpServletRequest request,
			BsCheckDetail dto) throws Exception  {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* from bscheckdetail a ");
		sb.append(" where 1=1 ");
		sb.append("  and a.contentid = :contentid and a.resultid= :resultid ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "contentid","resultid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckDetail.class);
		List<BsCheckDetail> list = (List) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			BsCheckDetail detail = list.get(0);
			return detail;
		}
		return null;
	}

	/**
	 * 
	 * synchronousCheckMaster的中文名称：同步结果表（同步离线结果数据）
	 * 		保存检查结果摘要(手机上用)
	 * synchronousCheckMaster的中文名称：同步结果表（同步离线结果数据）
	 的概要说明：
	 * 
	 * @param dto
	 * @return Written by : tmm
	 * 
	 */
	@Aop( { "trans" })
	public Map<String,Object> synchronousCheckMaster(HttpServletRequest request, BsCheckMaster dto,String state){
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		if("update".equals(state)){
			dto.setResultstate("4");
    			dao.update(dto);
    			resultMap.put("success", true);	
    			resultMap.put("resultid", dto.getResultid());
		}
        if("save".equals(state)){
        	dto.setResultstate("4");
    			dao.insert(dto);
    			resultMap.put("success", true);
    			resultMap.put("resultid", dto.getResultid());
		}
			return resultMap;
	}

	/**
	 * 添加信息
	 *
	 */
	public String saveresultDetail(HttpServletRequest request,BsCheckMasterDTO dto){
		try{
			saveresultDetailImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 保存信息的实现方法
	 * 使用事务控制
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@Aop({"trans"})
	public void saveresultDetailImpl(HttpServletRequest request, BsCheckMasterDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		BsCheckMaster master = dao.fetch(BsCheckMaster.class,dto.getResultid());
		master.setDetailinfo(dto.getDetailinfo());
		//修改检查完毕标识（3：固化）
		master.setResultstate("3");
		//修改
		dao.update(master);
	}

	/**
	 * 查询量化分级统计
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List queryLhfjtj(HttpServletRequest request, BschecklhfjDTO dto) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("select uu.aaa027, (SELECT a.AAA129 FROM aa13 a WHERE a.AAA027 = uu.aaa027) AS aaa027str, ");
		sb.append("SUM(uu.lhfjpdndyjccs) lhfjpdndyjccs, SUM(uu.hyjccs) hyjccs from (");
		sb.append("Select a.comid,a.checkyear,b.aaa027, ");
		sb.append("IFNULL(d.lhfjpdndyjccs,0) AS lhfjpdndyjccs,");
		sb.append("(case when IFNULL(d.lhfjpdndyjccs,0)-Count(a.comid)>=0 then IFNULL(d.lhfjpdndyjccs,0)-Count(a.comid) else 0 end) as hyjccs ");
		sb.append(" FROM bscheckmaster a,pcompany b LEFT JOIN (pcompanynddtpj c LEFT JOIN bschecklhfjpjcs d ON d.lhfjpdlx='1'");
		sb.append(" and c.lhfjndpddj=d.lhfjpddj )"); 
		sb.append(" ON b.comid=c.comid ");
		sb.append(",bscheckplan t1");      
		sb.append(" WHERE a.comid=b.comid");
		sb.append(" and a.planid=t1.planid");
		sb.append(" and t1.planchecktype='0'");
		sb.append(" group by a.comid,a.checkyear order by a.checkyear ) uu where 1=1 ");
		if (dto.getCheckyear() != null && !"".equals(dto.getCheckyear())) {
			sb.append(" and uu.checkyear = '").append(dto.getCheckyear()).append("' ");
		}
		sb.append(" GROUP BY uu.aaa027,uu.checkyear order by uu.aaa027 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{};
		int[] paramType = new int[]{};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BschecklhfjDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		return list;
	}

/***********************************************aaa027相关*********************************** ST  *************************/

	/**
	 *
	 * queryaaa207list的中文名称：查询项目节点树
	 *
	 * queryaaa207list概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	public Map queryaaa207list(HttpServletRequest request,BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from aa13 a where 1=1 and a.AAA148 =:aaa027  ORDER BY a.BAZ001 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"aaa027"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa13.class);
		List<Aa13> list = (List<Aa13>) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		return map;
	}

	/**
	 *
	 * queryaaa207Strlist的中文名称：查询项目节点树
	 *
	 * queryaaa207Strlist概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	public List<String> queryaaa207Strlist(HttpServletRequest request,BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		List<String> aaa129list = new ArrayList<String>();
		sb.append(" select h.AAA129 from aa13 h where h.AAA027 like :aaa027 and (h.AAE383 = 4 or h.AAE383 = 3) ORDER BY h.AAA027");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"aaa027"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa13.class);
		List<Aa13> list = (List<Aa13>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			for(Aa13 aa13:list){
				aaa129list.add(aa13.getAaa129());

			}
		}
		return aaa129list;
	}

	/**
	 *
	 * querya207Strlist的中文名称：查询项目节点树
	 *
	 * querya207Strlist概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	public List<String> querya207Strlist(HttpServletRequest request,BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		List<String> aaa129list = new ArrayList<String>();
		/*sb.append(" select h.AAA129 from aa13 h where h.AAA027 like :aaa027 and (h.AAE383 = 4 or h.AAE383 = 3) ORDER BY h.AAA027");*/
		sb.append(" select h.AAA129 from aa13 h where h.AAA027 like :aaa027 and ( h.AAE383 = 3) ORDER BY h.AAA027");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"aaa027"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa13.class);
		List<Aa13> list = (List<Aa13>) m.get(GlobalNames.SI_RESULTSET);
		if(list.size()>0){
			for(Aa13 aa13:list){
				aaa129list.add(aa13.getAaa129());

			}
		}
		return aaa129list;
	}


	/**
	 *
	 * getAa10List的中文名称：查询系统代码表AA10
	 *
	 * getAa10List的概要说明：
	 *
	 * @param aaa100
	 * @return
	 * @throws Exception
	 *             Written by : tmm
	 */
	public List<Aa10> getAa10ListByaaa101(String aaa100,String aaa101) throws Exception {
		// sql查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from Aa10 a ");
		sb.append(" WHERE a.AAA100 = '").append(aaa100.toUpperCase())
				.append("'");
		sb.append(" and a.AAA101 = '").append(aaa101.toUpperCase())
				.append("'");
		sb.append(" order by a.AAA102 ASC ");
		String sql = sb.toString();
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa10.class);
		List<Aa10> ls = (List<Aa10>) map.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 *
	 * queryPcomPlanResultNumBycomdalei的中文名称：查询企业计划各类结果个数
	 *
	 * queryPcomPlanResultNumBycomdalei概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	public List<Integer> queryPcomPlanResultNumBycomdalei(HttpServletRequest request,BsCheckMasterDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select IFNULL(f.pcomcount,0) pcomcount ,g.aaa129 from (select * from aa13 h where h.AAA027 like '%"+dto.getAaa027()+"%'  ");
		sb.append(" and ( h.AAE383 = 3)) g LEFT JOIN ( select  sum(c.count) pcomcount , ");
		sb.append(" b.comdalei,b.aaa027,b.comid,b.commc,c.planid,c.resultid ,c.resultdecision,c.count from pcompany b , ");
		sb.append(" (select count(*) count , d.*, e.planchecktype   from bscheckmaster d ,bscheckplan e where   ");
		sb.append(" d.planid=e.planid   ");
		if("4".equals(dto.getResultstate())){//已经完成
			sb.append(" and d.resultstate =4  ");
		}else if("2".equals(dto.getResultstate())){//完成并不合格
			sb.append(" and d.resultstate =4 and d.resultdecision <> 101");
		}
		else {//未完成
			sb.append(" and d.resultstate <>4  ");
		}
		sb.append(" and d.operatedate like :year and e.planchecktype =:planchecktype  and 1=1");
		sb.append(" GROUP BY d.comid ) c where  1=1 and c.comid=b.comid and b.comdalei =:comdalei GROUP BY b.aaa027, b.comdalei ) f on f.aaa027 = g.AAA027  ");
		sb.append(" where  (ISNULL(f.comdalei) or f.comdalei =:comdalei) order by  g.aaa027 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"year","planchecktype","comdalei"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
		List<BsCheckMasterDTO> list = (List<BsCheckMasterDTO>) m.get(GlobalNames.SI_RESULTSET);
		List<Integer> serieslist = new ArrayList<Integer>();
		if(list.size()>0){
			for(BsCheckMasterDTO master:list){
				serieslist.add(master.getPcomcount());
			}
		}

		return serieslist;
	}
/***********************************************aaa027相关*********************************** ED  *************************/
	/**
	 * saveCompanyRiskCheck的中文名称：保存企业量化等级
	 *
	 * saveCompanyRiskCheck的概要说明：首先要对企业进行量化分级后，才能对企业进行检查
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveCompanyRiskCheck_zy(HttpServletRequest request, BsCheckMasterDTO dto) {
		try {
			saveCompanyRiskCheckImpl_zy(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存企业量化等级检查
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop({ "trans" })
	private void saveCompanyRiskCheckImpl_zy(HttpServletRequest request, BsCheckMasterDTO dto) throws Exception {
		BsCheckMaster master = dao.fetch(BsCheckMaster.class, dto.getResultid());
		// 查询填表人与审核人签字附件
		String v_sql = "SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) AS zfryqmpic,"+
				" max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) AS bjcdwqmpic "+
				" FROM fj a WHERE a.fjwid = '" + dto.getResultid() + "';";
		BsCheckMasterDTO masterDto = (BsCheckMasterDTO)DbUtils.getDataList(v_sql, BsCheckMasterDTO.class).get(0);
		String contextPath = request.getContextPath();
		if (!com.lbs.util.StringUtils.isEmpty(masterDto.getZfryqmpic())){
			dto.setTbrqm(contextPath + masterDto.getZfryqmpic()); // 填表人签字（风险等级确定表）
		}
		if (!com.lbs.util.StringUtils.isEmpty(masterDto.getBjcdwqmpic())){
			dto.setShrqm(contextPath + masterDto.getBjcdwqmpic()); // 审核人签字（风险等级确定表）
		}
		if (master != null) {
			// 将检查结果保存进企业年度等级评定表
			//gu20180331
			String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
			Pcompanynddtpj v_oldfj=dao.fetch(Pcompanynddtpj.class,Cnd.where("pdyear","=",v_year).and("comid","=",dto.getComid()));
			String v_Lhfjndpddj="";
			//看参数LHFJNDPDDJ 9	未知
			//0	整改中
			//A	A优秀
			//B	B良好
			//C	C一般
			//1	A级风险
			//2	B级风险
			//3	C级风险
			//4	D级风险

			if ("1".equals(dto.getFxdj())) { // 评定等级
				v_Lhfjndpddj=SysmanageUtil.g_lhfjndpddj_1;
				master.setLhfjdtpddj(SysmanageUtil.g_lhfjndpddj_1); // A级风险
			} else if ("2".equals(dto.getFxdj())) {
				v_Lhfjndpddj=SysmanageUtil.g_lhfjndpddj_2;
				master.setLhfjdtpddj(SysmanageUtil.g_lhfjndpddj_2); // A级风险
			} else if ("3".equals(dto.getFxdj())) {
				v_Lhfjndpddj=SysmanageUtil.g_lhfjndpddj_3;
				master.setLhfjdtpddj(SysmanageUtil.g_lhfjndpddj_3); // A级风险
			} else if ("4".equals(dto.getFxdj())) {
				v_Lhfjndpddj=SysmanageUtil.g_lhfjndpddj_4;
				master.setLhfjdtpddj(SysmanageUtil.g_lhfjndpddj_4); // A级风险
			}

			if (v_oldfj==null){
				Pcompanynddtpj lhdj = new Pcompanynddtpj();
				lhdj.setPcompanynddtpjid(DbUtils.getSequenceStr()); // 主键id
				lhdj.setComid(dto.getComid()); // 企业id
				lhdj.setPdyear(v_year); // 评定年度
				lhdj.setLhfjndpddj(v_Lhfjndpddj);
				lhdj.setPdjgscfs("1"); // 评定结果生产方式0自动1手动
				dao.insert(lhdj);
			}else{
				v_oldfj.setLhfjndpddj(v_Lhfjndpddj);
				v_oldfj.setPdjgscfs("1"); // 评定结果生产方式0自动1手动
				dao.update(v_oldfj);
			}


			// 修改检查完毕标识（4：检查信息固化;5保存完毕）
			master.setPlanid(dto.getPlanid());//gu20180402 2018040315500872759514728 食品生产经营者风险等级确认表【系统内置，不要删】
			master.setResultstate(dto.getResultstate());
			master.setResultdecision(dto.getResultdecision()); // 结果判定(101:符合；102：不符合；103：限时整改)
			master.setResultng(dto.getResultng()); // 结果不符合项说明
			master.setResultdate(new Date());// 结束时间
			master.setResultperson(dto.getResultperson()); // 结果检查人
			master.setLatitude(dto.getLatitude());
			master.setLongitude(dto.getLongitude());
			master.setLxr("".equals(dto.getLxr()) ? "" : dto.getLxr()); // 联系人
			master.setLxdh("".equals(dto.getLxdh()) ? "" : dto.getLxdh()); // 联系电话
			// 处理检查结果信息主体部分
			String checkresultinfo = getAssignmentResultOfLh(dto);
			master.setCheckresultinfo(checkresultinfo); // 检查结果信息
			master.setCheckyear(String.valueOf(DateUtil.convertDateToYear(new Date()))); // 检查年度
			// 修改
			dao.update(master);

			//gu20180410数据存到 食品生产经营者风险等级确定表
			String v_pcomriskconfirmid="";
			List<Pcomriskconfirm> v_pcomriskconfirmList=dao.query(Pcomriskconfirm.class,Cnd.where("comid","=",dto.getComid()).and("checkyear","=",dto.getCheckyear()));
			if (v_pcomriskconfirmList!=null && v_pcomriskconfirmList.size()>0){
				Pcomriskconfirm v_oldPcomriskconfirm=v_pcomriskconfirmList.get(0);
				v_pcomriskconfirmid=v_oldPcomriskconfirm.getPcomriskconfirmid();
				BeanHelper.copyProperties(dto, v_oldPcomriskconfirm); // 拷贝对应的从前台传来的数据
				dao.update(v_oldPcomriskconfirm);
			}else{
				Pcomriskconfirm v_newPcomriskconfirm=new Pcomriskconfirm();
				BeanHelper.copyProperties(dto, v_newPcomriskconfirm); // 拷贝对应的从前台传来的数据
				dao.insert(v_newPcomriskconfirm);
			}
		}
	};

	/**
	 *
	 * 结果替换赋值(量化分级检查)
	 * @param dto 检查
	 * @return
	 * @throws Exception
	 */
	private String getAssignmentResultOfLh(BsCheckMasterDTO dto) throws Exception {
		String resultinfo = "";
		dto.setTbodytype("spscjy_fxdjqdb");// 食品生产经营者风险等级确定表
		dto.setTbodycode("1");
		BsTbodyInfoDTo	tbodyBean = getTbodyInfo(null, dto);
		dto.setCheckyear(String.valueOf(DateUtil.convertDateToYear(new Date()))); // 检查年度
		if(tbodyBean != null){
			String lxrhfs = (dto.getLxr() == null ? "" : dto.getLxr()) +
					((dto.getLxdh()) == null ? "" : dto.getLxdh()); // 联系人及方式
			// 编号
			String tdodyInfo = tbodyBean.getTbodyinfo();
			resultinfo = tdodyInfo.replace("checkyear", dto.getCheckyear()) // 检查年度
								  .replace("checkno", dto.getCheckno() == null ? "" : dto.getCheckno()) // 检查编号
								  .replace("commc", dto.getCommc() == null ? "" : dto.getCommc()) // 企业名称
								  .replace("comdz", dto.getComdz() == null ? "" : dto.getComdz()) // 企业地址
								  .replace("zzzmbh", dto.getZzzmbh() == null ? "" : dto.getZzzmbh()) // 营业执照编号或信用代码
								  .replace("lxrhfs", lxrhfs) // 联系人及联系方式
								  .replace("sndfxdj", dto.getSndfxdj() == null ? "" : dto.getSndfxdj()) // 上年度风险等级
								  .replace("staticscore", dto.getStaticscore() == null ? "" : dto.getStaticscore()) // 静态风险因素量化风险分值
								  .replace("dynamicscore", dto.getDynamicscore() == null ? "" : dto.getDynamicscore()) // 动态风险因素量化风险分值
								  .replace("totalscore", dto.getTotalscore() == null ? "" : dto.getTotalscore()) // 风险等级得分
								  .replaceFirst("fxdj_a", "1".equals(dto.getFxdj()) ? "☑" : "□") // 风险等级A对应aa10 COMFXDJ 1
								  .replaceFirst("fxdj_b", "2".equals(dto.getFxdj()) ? "☑" : "□") // 风险等级B对应aa10 COMFXDJ 2
								  .replaceFirst("fxdj_c", "3".equals(dto.getFxdj()) ? "☑" : "□") // 风险等级C对应aa10 COMFXDJ 3
								  .replaceFirst("fxdj_d", "4".equals(dto.getFxdj()) ? "☑" : "□") // 风险等级D对应aa10 COMFXDJ 4
								  .replace("gywfflfg", ("1".equals(dto.getGywfflfg())) ? "☑" : "□") // 故意违反食品安全法律法规 0:未选中 1:选中
								  .replace("ycjysbfh", ("1".equals(dto.getYcjysbfh())) ? "☑" : "□") // 有1次及以上国家或者省级监督抽检不符合食品安全标准的0:未选中 1:选中
								  .replace("wfflfg", ("1".equals(dto.getWfflfg())) ? "☑" : "□") // 违反食品安全法律法规规定0:未选中 1:选中
								  .replace("fsaqsg", ("1".equals(dto.getFsaqsg())) ? "☑" : "□") // 发生食品安全事故的0:未选中 1:选中
								  .replace("bagd", ("1".equals(dto.getBagd())) ? "☑" : "□") // 不按规定0:未选中 1:选中
								  .replace("bpezf", ("1".equals(dto.getBpezf())) ? "☑" : "□") // 不配合执法0:未选中 1:选中
								  .replace("kstdj", ("1".equals(dto.getKstdj())) ? "☑" : "□") // 可以上调风险等级0:未选中 1:选中
								  .replace("stfxdj", "1".equals(dto.getSuggestfxdj()) ? "☑" : "□") // 上调个风险等级对应aa10 FXDJJY 1
								  .replace("btzfxdj", "2".equals(dto.getSuggestfxdj()) ? "☑" : "□") // 不调风险等级对应aa10 FXDJJY 2
								  .replace("xtfxdj", "3".equals(dto.getSuggestfxdj()) ? "☑" : "□") // 下调个风险等级对应aa10 FXDJJY 3
								  .replace("xyndfxdj", (dto.getXyndfxdj() == null) ? "" : dto.getXyndfxdj()) // 下一年度风险等级
								  .replace("fxdjbz", (dto.getFxdjbz() == null) ? "" : dto.getFxdjbz()) // 备注
								  .replaceFirst("tbrqm", (dto.getTbrqm() == null) ? "" : dto.getTbrqm()) // 填表人签名图片
								  .replaceFirst("shrqm", (dto.getShrqm() == null) ? "" : dto.getShrqm());// 审核人签名图片
		};


		return resultinfo;
	};

	/******************提交结果信息处理块******ED**********/

	/**
	 * saveCompanyRiskCheck的中文名称：保存企业量化等级
	 *
	 * saveCompanyRiskCheck的概要说明：首先要对企业进行量化分级后，才能对企业进行检查
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveSpxsStaticRiskPingji(HttpServletRequest request, PjingspxsDTO dto) {
		try {
			return saveSpxsStaticRiskPingjiImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}

	}

	/**
	 * 保存企业量化等级检查
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop({ "trans" })
	private String saveSpxsStaticRiskPingjiImpl(HttpServletRequest request, PjingspxsDTO dto) throws Exception {
		String v_comid=dto.getComid();
		if (v_comid==null || "".equals(v_comid)){
			throw new BusinessException("企业id不能为空");
		}
		Sysuser v_sysuser=(Sysuser)dao.fetch(Sysuser.class,Cnd.where("userid","=",dto.getUserid()));

		String v_resultid="";
		v_resultid=DbUtils.getSequenceStr();

        Boolean v_exists=false;
		String v_pjingspxsid="";
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		BsCheckMaster v_newBsCheckMaster=new BsCheckMaster();
		Pjingspxs v_newPjingspxs=new Pjingspxs();
		String v_sql="select a.* from pjingspxs a where a.comid='"+v_comid+"' and checkyear='"+v_year+"'";
		List<PjingspxsDTO> v_spxslist=(List<PjingspxsDTO>)DbUtils.getDataList(v_sql,PjingspxsDTO.class);
        if (v_spxslist!=null && v_spxslist.size()>0){//修改
			v_exists=true;
			PjingspxsDTO v_oldPjingspxsDTO=v_spxslist.get(0);
			v_pjingspxsid=v_oldPjingspxsDTO.getPjingspxsid();
            BeanHelper.copyProperties(dto,v_newPjingspxs);
			v_newPjingspxs.setPjingspxsid(v_oldPjingspxsDTO.getPjingspxsid());
			v_newPjingspxs.setComid(v_oldPjingspxsDTO.getComid());
			v_newPjingspxs.setCheckyear(v_oldPjingspxsDTO.getCheckyear());
			v_newPjingspxs.setResultid(v_oldPjingspxsDTO.getResultid());
            dao.update(v_newPjingspxs);
		}else{
            v_pjingspxsid=DbUtils.getSequenceStr();
			BeanHelper.copyProperties(dto,v_newPjingspxs);
			v_newPjingspxs.setPjingspxsid(v_pjingspxsid);
			v_newPjingspxs.setComid(dto.getComid());
			v_newPjingspxs.setCheckyear(v_year);
			v_newPjingspxs.setAae011(dto.getUserid());
			v_newPjingspxs.setAae036(SysmanageUtil.currentTime());
			v_newPjingspxs.setResultid(v_resultid);
			dao.insert(v_newPjingspxs);
		};

        //w往bscheckmaster表插入一条
		BsCheckMasterDTO v_BsCheckMasterDTO=new BsCheckMasterDTO();
		v_BsCheckMasterDTO.setTbodytype("spxs_jtfxlh");
		v_BsCheckMasterDTO.setPjingspxsid(v_pjingspxsid);
		BsCheckMasterDTO v_printdto=getDetailByid(request, v_BsCheckMasterDTO);
		//String v_detailinfo=getDetailByid(request,v_BsCheckMasterDTO);
		Double v_dfzh= Double.valueOf(0);
		if (dto.getDfzh()!=null){
			v_dfzh=Double.valueOf(dto.getDfzh());
		}

		if (v_exists){
            List<BsCheckMaster> v_checkMasterList=dao.query(BsCheckMaster.class, Cnd.where("comid","=",v_comid).and("checkyear","=",v_year).and("planid","=",SysmanageUtil.g_planid_spxs_jtfxlh));
            if (v_checkMasterList!=null && v_checkMasterList.size()>0){
				v_newBsCheckMaster=v_checkMasterList.get(0);
				v_resultid=v_newBsCheckMaster.getResultid();
				v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
				v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
				if (dto.getDfzh()!=null) {
					v_newBsCheckMaster.setResultscore(Double.valueOf(v_dfzh));
				}
				dao.update(v_newBsCheckMaster);
			}
		}else{

			v_newBsCheckMaster.setResultid(v_resultid);
			v_newBsCheckMaster.setPlanid(SysmanageUtil.g_planid_spxs_jtfxlh);
			v_newBsCheckMaster.setComid(v_comid);
			v_newBsCheckMaster.setCheckyear(v_year);
			v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
			v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
			v_newBsCheckMaster.setResultscore(v_dfzh);
			v_newBsCheckMaster.setAae011(dto.getUserid());
			v_newBsCheckMaster.setAae036(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperatedate(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperateperson(v_sysuser.getDescription());
			if (dto.getDfzh()!=null) {
				v_newBsCheckMaster.setResultscore(Double.valueOf(v_dfzh));
			};
			dao.insert(v_newBsCheckMaster);
		}

		//得分
		addOrUpdatePcompanynddtpj(dto.getComid(),"jingtai",dto.getDfzh(),"","","");
		return v_resultid;
	};

	/**
	 * 餐饮服务提供者静态风险因素量化分值表
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveCyfwStaticRiskPingji(HttpServletRequest request, PjingcyfwlhDTO dto) {
		try {
			return saveCyfwStaticRiskPingjiImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}

	}

	/**
	 * 餐饮服务提供者静态风险因素量化分值表
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop({ "trans" })
	private String saveCyfwStaticRiskPingjiImpl(HttpServletRequest request, PjingcyfwlhDTO dto) throws Exception {
		String v_comid=dto.getComid();
		if (v_comid==null || "".equals(v_comid)){
			throw new BusinessException("企业id不能为空");
		}
		String v_resultid="";
		v_resultid=DbUtils.getSequenceStr();
		Sysuser v_sysuser=(Sysuser)dao.fetch(Sysuser.class,Cnd.where("userid","=",dto.getUserid()));

		Boolean v_exists=false;
		String v_pjingcyfwlhid="";
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		BsCheckMaster v_newBsCheckMaster=new BsCheckMaster();
		Pjingcyfwlh v_newPjingcyfwlh=new Pjingcyfwlh();
		String v_sql="select a.* from Pjingcyfwlh a where a.comid='"+v_comid+"' and checkyear='"+v_year+"'";
		List<PjingcyfwlhDTO> v_cyfwlist=(List<PjingcyfwlhDTO>)DbUtils.getDataList(v_sql,PjingcyfwlhDTO.class);
		if (v_cyfwlist!=null && v_cyfwlist.size()>0){//修改
			v_exists=true;
			PjingcyfwlhDTO v_oldPjingcyfwlhDTO=v_cyfwlist.get(0);
			v_pjingcyfwlhid=v_oldPjingcyfwlhDTO.getPjingcyfwlhid();
			BeanHelper.copyProperties(dto,v_newPjingcyfwlh);
			v_newPjingcyfwlh.setPjingcyfwlhid(v_oldPjingcyfwlhDTO.getPjingcyfwlhid());
			v_newPjingcyfwlh.setComid(v_oldPjingcyfwlhDTO.getComid());
			v_newPjingcyfwlh.setCheckyear(v_oldPjingcyfwlhDTO.getCheckyear());
			v_newPjingcyfwlh.setResultid(v_oldPjingcyfwlhDTO.getResultid());
			dao.update(v_newPjingcyfwlh);
		}else{
			v_pjingcyfwlhid=DbUtils.getSequenceStr();
			BeanHelper.copyProperties(dto,v_newPjingcyfwlh);
			v_newPjingcyfwlh.setPjingcyfwlhid(v_pjingcyfwlhid);
			v_newPjingcyfwlh.setComid(dto.getComid());
			v_newPjingcyfwlh.setCheckyear(v_year);
			v_newPjingcyfwlh.setAae011(dto.getUserid());
			v_newPjingcyfwlh.setAae036(SysmanageUtil.currentTime());
			v_newPjingcyfwlh.setResultid(v_resultid);
			dao.insert(v_newPjingcyfwlh);
		};

		//w往bscheckmaster表插入一条

		BsCheckMasterDTO v_BsCheckMasterDTO=new BsCheckMasterDTO();
		v_BsCheckMasterDTO.setTbodytype("spcyfw_jtfxlh");
		v_BsCheckMasterDTO.setPjingcyfwlhid(v_pjingcyfwlhid);
		BsCheckMasterDTO v_printdto=getDetailByid(request, v_BsCheckMasterDTO);
		//String v_detailinfo=getDetailByid(request,v_BsCheckMasterDTO);
		Double v_dfzh= Double.valueOf(0);
		if (dto.getDfzh()!=null){
			v_dfzh=Double.valueOf(dto.getDfzh());
		}

		if (v_exists){
			List<BsCheckMaster> v_checkMasterList=dao.query(BsCheckMaster.class, Cnd.where("comid","=",v_comid).and("checkyear","=",v_year).and("planid","=",SysmanageUtil.g_planid_spcyfw_jtfxlh));
			if (v_checkMasterList!=null && v_checkMasterList.size()>0){
				v_newBsCheckMaster=v_checkMasterList.get(0);
				v_resultid=v_newBsCheckMaster.getResultid();
				v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
				v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
				if (dto.getDfzh()!=null) {
					v_newBsCheckMaster.setResultscore(Double.valueOf(v_dfzh));
				}
				dao.update(v_newBsCheckMaster);
			}
		}else{

			v_newBsCheckMaster.setResultid(v_resultid);
			v_newBsCheckMaster.setPlanid(SysmanageUtil.g_planid_spcyfw_jtfxlh);
			v_newBsCheckMaster.setComid(v_comid);
			v_newBsCheckMaster.setCheckyear(v_year);
			v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
			v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
			v_newBsCheckMaster.setResultscore(v_dfzh);
			v_newBsCheckMaster.setAae011(dto.getUserid());
			v_newBsCheckMaster.setAae036(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperatedate(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperateperson(v_sysuser.getDescription());
			if (dto.getDfzh()!=null) {
				v_newBsCheckMaster.setResultscore(Double.valueOf(v_dfzh));
			}
			dao.insert(v_newBsCheckMaster);
		}

		//得分
		addOrUpdatePcompanynddtpj(dto.getComid(),"jingtai",StringHelper.showNull2Empty(dto.getDfzh()),"","","");
		return v_resultid;
	};

	/**
	 *
	 * querySptjjJtfxlhList的中文名称：查询食品、食品添加剂生产者静态风险因素量化分值表
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map querySptjjJtfxlhList(OmcheckcontentDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.contentid,a.itemid,b.itemname,a.content,a.contentcode,a.contentimpt,");
		sb.append("getAa10_aaa103('CONTENTIMPT',a.contentimpt) as contentimptaaa103,a.contentscore" );
		sb.append( " from omcheckcontent a,omcheckgroup b " );
		sb.append( "  where a.itemid=b.itemid ");
		sb.append("  and b.itempid='2018041015451566756928443'");
		if (dto.getItemname()!=null && !"".equals(dto.getItemname())){
			sb.append(" and (b.itemname like '%"+dto.getItemname()+"%' or a.content like '%"+dto.getItemname()+"%') ");
		}
		sb.append("  order by b.itemsortid,a.contentsortid ");

		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OmcheckcontentDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 餐饮服务提供者静态风险因素量化分值表
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveCyfwNddjpd(HttpServletRequest request, PcyfwnddjpdDTO dto) {
		try {
			return saveCyfwNddjpdImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}

	}

	/**
	 * 保存企业量化等级检查
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop({ "trans" })
	private String saveCyfwNddjpdImpl(HttpServletRequest request, PcyfwnddjpdDTO dto) throws Exception {
		String v_comid=dto.getComid();
		if (v_comid==null || "".equals(v_comid)){
			throw new BusinessException("企业id不能为空");
		}
		String v_resultid="";
		v_resultid=DbUtils.getSequenceStr();
		Sysuser v_sysuser=(Sysuser)dao.fetch(Sysuser.class,Cnd.where("userid","=",dto.getUserid()));
		String v_lhfjndpddj=dto.getCpdj();
		String v_sql="";
//gu20180523		String v_sql="select fun_getRiskLevel('21','"+dto.getNdpjdf()+"');";
//		if (StringUtils.isNotEmpty(dto.getNdpjdf())){
//			v_lhfjndpddj=DbUtils.getOneValue(dao,v_sql);
//			dto.setLhfjndpddj(v_lhfjndpddj);
//		}
		if (StringUtils.isNotEmpty(dto.getSpdj())){
			v_lhfjndpddj=dto.getSpdj();
		}else{
			if (StringUtils.isNotEmpty(dto.getFpdj())){
				v_lhfjndpddj=dto.getFpdj();
			}
		}
		dto.setLhfjndpddj(v_lhfjndpddj);

		Boolean v_exists=false;
		String v_pcyfwnddjpdid="";
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		BsCheckMaster v_newBsCheckMaster=new BsCheckMaster();
		Pcyfwnddjpd v_newPcyfwnddjpd=new Pcyfwnddjpd();
		v_sql="select a.* from pcyfwnddjpd a where a.comid='"+v_comid+"' and checkyear='"+v_year+"'";
		List<PcyfwnddjpdDTO> v_PcyfwnddjpdDTOlist=(List<PcyfwnddjpdDTO>)DbUtils.getDataList(v_sql,PcyfwnddjpdDTO.class);
		if (v_PcyfwnddjpdDTOlist!=null && v_PcyfwnddjpdDTOlist.size()>0){//修改
			v_exists=true;
			PcyfwnddjpdDTO v_oldPcyfwnddjpdDTO=v_PcyfwnddjpdDTOlist.get(0);
			v_pcyfwnddjpdid=v_oldPcyfwnddjpdDTO.getPcyfwnddjpdid();
			BeanHelper.copyProperties(dto,v_newPcyfwnddjpd);
			v_newPcyfwnddjpd.setPcyfwnddjpdid(v_pcyfwnddjpdid);
			v_newPcyfwnddjpd.setComid(v_oldPcyfwnddjpdDTO.getComid());
			v_newPcyfwnddjpd.setCheckyear(v_oldPcyfwnddjpdDTO.getCheckyear());
			v_newPcyfwnddjpd.setResultid(v_oldPcyfwnddjpdDTO.getResultid());
			v_newPcyfwnddjpd.setLhfjndpddj(dto.getLhfjndpddj());
			if (StringUtils.isEmpty(v_newPcyfwnddjpd.getNdpjdf())){
				v_newPcyfwnddjpd.setNdpjdf(null);
			}
			dao.update(v_newPcyfwnddjpd);
			dao.clear(Pcyfwnddjpdmx.class,Cnd.where("pcyfwnddjpdid","=",v_pcyfwnddjpdid));
		}else{
			v_pcyfwnddjpdid=DbUtils.getSequenceStr();
			BeanHelper.copyProperties(dto,v_newPcyfwnddjpd);
			v_newPcyfwnddjpd.setPcyfwnddjpdid(v_pcyfwnddjpdid);
			v_newPcyfwnddjpd.setComid(dto.getComid());
			v_newPcyfwnddjpd.setCheckyear(v_year);
			v_newPcyfwnddjpd.setAae011(dto.getUserid());
			v_newPcyfwnddjpd.setAae036(SysmanageUtil.currentTime());
			v_newPcyfwnddjpd.setResultid(v_resultid);
			v_newPcyfwnddjpd.setLhfjndpddj(dto.getLhfjndpddj());
			if (StringUtils.isEmpty(v_newPcyfwnddjpd.getNdpjdf())){
				v_newPcyfwnddjpd.setNdpjdf(null);
			}
			dao.insert(v_newPcyfwnddjpd);
		};
		//cha
		String v_Pcyfwnddjpdmxlist=dto.getPcyfwnddjpdmxlist();
		if (v_Pcyfwnddjpdmxlist!=null){
			List<PcyfwnddjpdmxDTO> lst = Json.fromJsonAsList(PcyfwnddjpdmxDTO.class, v_Pcyfwnddjpdmxlist);
			String v_pcyfwnddjpdmxid="";
			for (int i = 0; i < lst.size(); i++) {
				PcyfwnddjpdmxDTO mxDTO = (PcyfwnddjpdmxDTO) lst.get(i);
				v_pcyfwnddjpdmxid=DbUtils.getSequenceStr();
				Pcyfwnddjpdmx v_newPcyfwnddjpdmx=new Pcyfwnddjpdmx();
				BeanHelper.copyProperties(mxDTO,v_newPcyfwnddjpdmx);
				v_newPcyfwnddjpdmx.setPcyfwnddjpdmxid(v_pcyfwnddjpdmxid);
				v_newPcyfwnddjpdmx.setPcyfwnddjpdid(v_pcyfwnddjpdid);
				dao.insert(v_newPcyfwnddjpdmx);
			};
		}


		//w往bscheckmaster表插入一条

		BsCheckMasterDTO v_BsCheckMasterDTO=new BsCheckMasterDTO();
		v_BsCheckMasterDTO.setTbodytype("spcyfw_nddjpd");
		v_BsCheckMasterDTO.setPcyfwnddjpdid(v_pcyfwnddjpdid);
		BsCheckMasterDTO v_printdto=getDetailByid(request, v_BsCheckMasterDTO);
		//String v_detailinfo=getDetailByid(request,v_BsCheckMasterDTO);

		//if (v_exists){
		List<BsCheckMaster> v_checkMasterList=dao.query(BsCheckMaster.class, Cnd.where("comid","=",v_comid).and("checkyear","=",v_year).and("planid","=",SysmanageUtil.g_planid_spcyfw_nddjpd));
		if (v_checkMasterList!=null && v_checkMasterList.size()>0){
			v_newBsCheckMaster=v_checkMasterList.get(0);
			v_resultid=v_newBsCheckMaster.getResultid();
			v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
			v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
			v_newBsCheckMaster.setResultscore(Double.valueOf(dto.getNdpjdf()));
			v_newBsCheckMaster.setCheckavgscore(Double.valueOf(dto.getNdpjdf()));
			v_newBsCheckMaster.setLhfjdtpddj(dto.getLhfjndpddj());
			dao.update(v_newBsCheckMaster);
		//	}
		}else{

			v_newBsCheckMaster.setResultid(v_resultid);
			v_newBsCheckMaster.setPlanid(SysmanageUtil.g_planid_spcyfw_nddjpd);
			v_newBsCheckMaster.setComid(v_comid);
			v_newBsCheckMaster.setCheckyear(v_year);
			v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
			v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
			v_newBsCheckMaster.setResultscore(Double.valueOf(dto.getNdpjdf()));
			v_newBsCheckMaster.setCheckavgscore(Double.valueOf(dto.getNdpjdf()));
			v_newBsCheckMaster.setLhfjdtpddj(dto.getLhfjndpddj());
			v_newBsCheckMaster.setAae011(dto.getUserid());
			v_newBsCheckMaster.setAae036(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperatedate(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperateperson(v_sysuser.getDescription());

			dao.insert(v_newBsCheckMaster);
		}

		//得分
		addOrUpdatePcompanynddtpj(dto.getComid(),"niandupingji","","",dto.getNdpjdf(),dto.getLhfjndpddj());
		return v_resultid;
	};

	/**
	 * 保存食品生产经营者风险等级确定表
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveSpscjyRiskCheckConfirm(HttpServletRequest request, PcomriskconfirmDTO dto) {
		try {
			return saveSpscjyRiskCheckConfirmImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}

	}

	/**
	 * 保存食品生产经营者风险等级确定表
	 * @param request
	 * @param dto
	 * @return
	 */
	@Aop({ "trans" })
	private String saveSpscjyRiskCheckConfirmImpl(HttpServletRequest request, PcomriskconfirmDTO dto) throws Exception {
		String v_comid=dto.getComid();
		if (v_comid==null || "".equals(v_comid)){
			throw new BusinessException("企业id不能为空");
		}
		String v_resultid="";
		if (StringUtils.isEmpty(dto.getResultid())){
			throw new BusinessException("resultid不能为空");
		}
		v_resultid=dto.getResultid();

		//else{
		//	v_resultid=DbUtils.getSequenceStr();
		//}
		//获取签名文件
		//gu20170606 执法人员签字 被检查单位签字 begin
		String v_sql="SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) AS zfryqmpic,"+
				" max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) AS bjcdwqmpic "+
				" FROM fj a "+
				" WHERE a.fjwid='"+dto.getResultid()+"';";
		BsCheckMasterDTO masterDto=(BsCheckMasterDTO)DbUtils.getDataList(v_sql, BsCheckMasterDTO.class).get(0);

		String v_zfryqmpic="";
		String v_bjcdwqmpic="";
		if (StringUtils.isNotEmpty(masterDto.getZfryqmpic())){
			//dto.setZfryqmpic(contextPath+masterDto.getZfryqmpic());
			v_zfryqmpic=masterDto.getZfryqmpic();
		};
		if (StringUtils.isNotEmpty(masterDto.getBjcdwqmpic())){
			//dto.setBjcdwqmpic(contextPath+masterDto.getBjcdwqmpic());
			v_bjcdwqmpic=masterDto.getBjcdwqmpic();
		};

		Sysuser v_sysuser=(Sysuser)dao.fetch(Sysuser.class,Cnd.where("userid","=",dto.getUserid()));

		Boolean v_exists=false;
		String v_pcomriskconfirmid="";
		String v_year=String.valueOf(DateUtil.convertDateToYear(new Date()));
		BsCheckMaster v_newBsCheckMaster=new BsCheckMaster();
		Pcomriskconfirm v_newPcomriskconfirm=new Pcomriskconfirm();
		v_sql="select a.* from Pcomriskconfirm a where a.comid='"+v_comid+"' and checkyear='"+v_year+"'";
		List<PcomriskconfirmDTO> v_Pcomriskconfirmlist=(List<PcomriskconfirmDTO>)DbUtils.getDataList(v_sql,PcomriskconfirmDTO.class);

		if (v_Pcomriskconfirmlist!=null && v_Pcomriskconfirmlist.size()>0){//修改
			v_exists=true;
			PcomriskconfirmDTO v_oldPcomriskconfirmDTO=v_Pcomriskconfirmlist.get(0);
			v_pcomriskconfirmid=v_oldPcomriskconfirmDTO.getPcomriskconfirmid();
			BeanHelper.copyProperties(dto,v_newPcomriskconfirm);
			v_newPcomriskconfirm.setPcomriskconfirmid(v_pcomriskconfirmid);
			v_newPcomriskconfirm.setComid(v_oldPcomriskconfirmDTO.getComid());
			v_newPcomriskconfirm.setCheckyear(v_oldPcomriskconfirmDTO.getCheckyear());
			v_newPcomriskconfirm.setResultid(v_oldPcomriskconfirmDTO.getResultid());
			v_newPcomriskconfirm.setTbrqm(v_zfryqmpic);
			v_newPcomriskconfirm.setShrqm(v_bjcdwqmpic);
			dao.update(v_newPcomriskconfirm);
		}else{
			v_pcomriskconfirmid=DbUtils.getSequenceStr();
			BeanHelper.copyProperties(dto,v_newPcomriskconfirm);
			v_newPcomriskconfirm.setPcomriskconfirmid(v_pcomriskconfirmid);
			v_newPcomriskconfirm.setComid(dto.getComid());
			v_newPcomriskconfirm.setCheckyear(v_year);
			v_newPcomriskconfirm.setAae011(dto.getUserid());
			v_newPcomriskconfirm.setAae036(SysmanageUtil.currentTime());
			v_newPcomriskconfirm.setResultid(v_resultid);
			v_newPcomriskconfirm.setTbrqm(v_zfryqmpic);
			v_newPcomriskconfirm.setShrqm(v_bjcdwqmpic);
			dao.insert(v_newPcomriskconfirm);
		};

		//w往bscheckmaster表插入一条

		BsCheckMasterDTO v_BsCheckMasterDTO=new BsCheckMasterDTO();
		v_BsCheckMasterDTO.setTbodytype("spscjy_fxdjqdb");//食品生产经营者风险等级确定表
		v_BsCheckMasterDTO.setPcomriskconfirmid(v_pcomriskconfirmid);
		BsCheckMasterDTO v_printdto=getDetailByid(request, v_BsCheckMasterDTO);
		//String v_detailinfo=getDetailByid(request,v_BsCheckMasterDTO);

		if (v_exists){
			v_sql="select a.* from bscheckmaster a where a.comid='"+v_comid+"' and checkyear='"+v_year+"'";
			List<BsCheckMaster> v_checkMasterList=DbUtils.getDataList(v_sql,BsCheckMaster.class);
			//List<BsCheckMaster> v_checkMasterList=dao.query(BsCheckMaster.class, Cnd.where("comid","=",v_comid).and("checkyear","=",v_year).and("planid","=",SysmanageUtil.g_planid_spcyfw_nddjpd));
			if (v_checkMasterList!=null && v_checkMasterList.size()>0){
				v_newBsCheckMaster=v_checkMasterList.get(0);
				v_resultid=v_newBsCheckMaster.getResultid();
				v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
				v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
				v_newBsCheckMaster.setResultscore(Double.valueOf(dto.getTotalscore()));
				v_newBsCheckMaster.setCheckavgscore(Double.valueOf(dto.getTotalscore()));
				v_newBsCheckMaster.setLhfjdtpddj(dto.getFxdj());
				//v_newBsCheckMaster.setResultid(v_resultid);
				v_newBsCheckMaster.setAae036(SysmanageUtil.currentTime());
				dao.update(v_newBsCheckMaster);
			}
		}else{

			v_newBsCheckMaster.setResultid(v_resultid);
			v_newBsCheckMaster.setPlanid(SysmanageUtil.g_planid_spscjy_fxdjqdb);//食品生产经营者风险等级确定表【系统内置，不要删】
			v_newBsCheckMaster.setComid(v_comid);
			v_newBsCheckMaster.setCheckyear(v_year);
			v_newBsCheckMaster.setCheckresultinfo(v_printdto.getCheckresultinfo());
			v_newBsCheckMaster.setDetailinfo(v_printdto.getDetailinfo());
			v_newBsCheckMaster.setResultscore(Double.valueOf(dto.getTotalscore()));
			v_newBsCheckMaster.setCheckavgscore(Double.valueOf(dto.getTotalscore()));
			v_newBsCheckMaster.setLhfjdtpddj(dto.getFxdj());
			v_newBsCheckMaster.setAae011(dto.getUserid());
			v_newBsCheckMaster.setAae036(SysmanageUtil.currentTime());

			v_newBsCheckMaster.setOperatedate(SysmanageUtil.currentTime());
			v_newBsCheckMaster.setOperateperson(v_sysuser.getDescription());
			dao.insert(v_newBsCheckMaster);
		}

		//得分
		addOrUpdatePcompanynddtpj(dto.getComid(),"niandupingji",dto.getStaticscore(),dto.getDynamicscore(),dto.getTotalscore(),dto.getFxdj());
		return v_resultid;
	};


	/**
	 * 食品生产经营日常监督检查结果记录表
	 * @param dto  检查计划DTO
	 * @return
	 * @throws Exception
	 */
	private String getSpscjyRcjdjcjgjlb(HttpServletRequest request,PcompanyDTO company,BsCheckMasterDTO dto ) throws Exception {
		String resultinfo ="";
		String checkTrue ="☑";
		String checkFalse ="□";

		String nbsp ="&nbsp; &nbsp;";
		//gu20170606 执法人员签字 被检查单位签字 begin
		String v_sql="SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) AS zfryqmpic,"+
				" max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) AS bjcdwqmpic "+
				" FROM fj a "+
				" WHERE a.fjwid='"+dto.getResultid()+"';";
		BsCheckMasterDTO masterDto=(BsCheckMasterDTO)DbUtils.getDataList(v_sql, BsCheckMasterDTO.class).get(0);
		String  contextPath = request.getContextPath();
		if (!com.lbs.util.StringUtils.isEmpty(masterDto.getZfryqmpic())){
			dto.setZfryqmpic(contextPath+masterDto.getZfryqmpic());

		}
		if (!com.lbs.util.StringUtils.isEmpty(masterDto.getBjcdwqmpic())){
			dto.setBjcdwqmpic(contextPath+masterDto.getBjcdwqmpic());
		}

			BsCheckMasterDTO v_tempdto=new BsCheckMasterDTO();//食品生产经营日常监督检查结果记录表
			v_tempdto.setTbodytype("spscjy_rcjdjcjgjlb");
			BsTbodyInfoDTo	tbodyBean =  getTbodyInfo(null, v_tempdto);

			dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
			int total = getResultNumBycomid(null, dto);
			int count = getDetailAllNum(null, dto);
			//序号
			BsResultNumberDTO v_BsResultNumberDTO = getresultContent(dto);
			//查询
			if(tbodyBean!=null){
				//编号
				String[] dalei =company.getComdalei().split(",");//有的企业大类有多个  函数只能有一个参数，特别处理
				company.setComdalei(dalei[0]);
				//gu20180426 String number = DbUtils.getOneValue(dao, "select getResultbh("+company.getComdalei()+") from dual");
				String tdodyInfo = tbodyBean.getTbodyinfo();
				String starttime = company.getOperatedate();
				String resultdisc="";
				//gu20170606add 执法人员签字 被检查企业签字图片路径


				resultinfo = tdodyInfo.replace("commc", company.getCommc()==null?"":company.getCommc())
									  .replace("commdz", company.getComdz()==null?"":company.getComdz())
									  //.replace("comlxr", company.getComfzr()==null?"":company.getComfzr())
									  .replace("comlxr", company.getComfrhyz() ==null?"":company.getComfrhyz())
									  .replace("comlxfs", company.getComyddh()==null?"":company.getComyddh())
									  .replace("comlxr", dto.getLxr()==null?"":dto.getLxr())
									  .replace("comlxfs", dto.getLxdh()==null?"":dto.getLxdh())
									  //gu20180807 .replace("comxkz", company.getComxkzbh()==null?"":company.getComxkzbh())
									  .replace("comxkz", company.getComxkzbhall() ==null?"":company.getComxkzbhall())
									  .replace("year",starttime==null?"":starttime.substring(0,4))
									  .replace("month", starttime==null?"":starttime.substring(5,7))
									  .replace("date",starttime==null?"": starttime.substring(8,10))
									  .replaceFirst("num", String.valueOf(total))
									  .replace("Itemname", company.getItemname()==null?"":company.getItemname())
									  .replaceFirst("count", String.valueOf(count))
									  .replace("fuhe", "101".equals(dto.getResultdecision())?checkTrue:checkFalse)
									  .replace("bufh","103".equals(dto.getResultdecision())?checkTrue:checkFalse)
									  .replace("zhenggai", "102".equals(dto.getResultdecision())?checkTrue:checkFalse)
									  .replace("zfryqmpic", dto.getZfryqmpic()==null?"":dto.getZfryqmpic()) //执法人员签名图片
									  .replace("bjcdwqmpic", dto.getBjcdwqmpic()==null?"":dto.getBjcdwqmpic())//被检查单位签名图片
									  .replace("resultng", dto.getResultng()==null?"":dto.getResultng())//被检查单位签名图片
									  .replace("jgbh", dto.getResultid()==null?"":dto.getResultid());

//						.replace("resultdisc", dto.getResultng()==null?"":dto.getResultng())

				//符号赋值
				if(v_BsResultNumberDTO!=null){
					String impdetail=v_BsResultNumberDTO.getImpDetail()==null?"":v_BsResultNumberDTO.getImpDetail();
					String comdetail=v_BsResultNumberDTO.getComDetail()==null?"":v_BsResultNumberDTO.getComDetail();
					String str ="<p><strong>结果处理：</strong></p><p>"+
							("1".equals(dto.getResultFinal())?"☑":"□")+"通过 &nbsp;&nbsp;&nbsp;"+
							("2".equals(dto.getResultFinal())?"☑":"□")+"书面限期整改"+
							("3".equals(dto.getResultFinal())?"☑":"□")+"食品生产经营者立即停止食品生产经营活动</p>";
					System.out.println(dto.getResultFinal());
					String checkResult="  ";
					if(!"1".equals(company.getComdalei())){
						resultdisc = impdetail+comdetail;
					}else {//食品生产企业
						resultdisc = dto.getResultng();
						checkResult=str;
					}

					resultinfo=resultinfo.replaceFirst("impcount", String.valueOf(v_BsResultNumberDTO.getImpcount()))//重点项多少项
										 .replaceFirst("impnum", v_BsResultNumberDTO.getImpnum()==null?"":v_BsResultNumberDTO.getImpnum())//重点项，项目序号分别是
										 .replace("resultdisc", resultdisc==null?"":resultdisc)//
										 .replaceFirst("problemcount", String.valueOf(v_BsResultNumberDTO.getProblemcount()))//发现问题项
										 .replaceFirst("problemnum", v_BsResultNumberDTO.getProblemnum()==null?"":v_BsResultNumberDTO.getProblemnum())//发现问题项，项目序号分别是
										 .replaceFirst("commocount", String.valueOf(v_BsResultNumberDTO.getCommocount()))//一般项多少想
										 .replaceFirst("commnum", v_BsResultNumberDTO.getCommnum()==null?"":v_BsResultNumberDTO.getCommnum())//一般项，项目序号分别是
										 .replaceFirst("comproblemcount", String.valueOf(v_BsResultNumberDTO.getComproblemcount()))//发现问题多少项
										 .replaceFirst("checkResult", checkResult)//检查结果
										 .replaceFirst("comproblemnum", v_BsResultNumberDTO.getComproblemnum()==null?"":v_BsResultNumberDTO.getComproblemnum());//发现问题，项目序号分别是
				}
				//巡查笔录
//				dto.setTbodytype("lbxcResultInfo");
//				dto.setTbodycode("1");
//				tbodyBean =  getTbodyInfo(null, dto);
//				if(tbodyBean!=null){
//					tdodyInfo = tbodyBean.getTbodyinfo();
//					starttime = company.getOperatedate();
//					String  endtime = company.getResultdate();
//					String  lbresultinfo = tdodyInfo.replace("commc", company.getCommc()==null?"":company.getCommc())
//													.replace("comdz", company.getComdz()==null?nbsp:company.getComdz())
//													//.replace("comfrhyz", company.getComfrhyz()==null?nbsp:company.getComfrhyz())
//													//.replace("comyddh", company.getComyddh()==null?nbsp:company.getComyddh())
//													.replace("comfrhyz",dto.getLxr()==null?nbsp:dto.getLxr())
//													.replace("comyddh", dto.getLxdh()==null?nbsp:dto.getLxdh())
//													.replace("year",starttime==null?nbsp:starttime.substring(0,4))
//													.replace("month", starttime==null?nbsp:starttime.substring(5,7))
//													.replace("date",starttime==null?nbsp: starttime.substring(8,10))
//													.replaceFirst("time",starttime==null?nbsp: starttime.substring(11,13))
//													.replaceFirst("fen",starttime==null?nbsp: starttime.substring(14,16))
//													.replaceFirst("to_time",starttime==null?nbsp: endtime.substring(11,13))
//													.replaceFirst("to_fen",starttime==null?nbsp: endtime.substring(14,16));
////								.replace("username", "");
//					resultinfo+=lbresultinfo;
//				}
			}


		return resultinfo;
	};

	/**
	 * 食品生产经营日常监督检查结果记录表告知页
	 * @param dto  检查计划DTO
	 * @return
	 * @throws Exception
	 */
	private String getSpscjyRcjdjcjgjlbGzy(PcompanyDTO company,BsCheckMasterDTO dto ) throws Exception {
		String resultinfo ="";

		BsCheckMasterDTO v_tempdto=new BsCheckMasterDTO();//食品生产经营日常监督检查结果记录表告知页
		v_tempdto.setTbodytype("spscjy_rcjdjcydbgzy");
		BsTbodyInfoDTo	tbodyBean =  getTbodyInfo(null, v_tempdto);
		//查询
		if(tbodyBean!=null){
			String tdodyInfo = tbodyBean.getTbodyinfo();
			resultinfo = tdodyInfo.replace("Itemname",company.getItemname()==null?"":company.getItemname())
								  .replace("commc",company.getCommc()==null?"":company.getCommc())
								  .replace("comdz",company.getComdz()==null?"":company.getComdz())
								  .replace("zfryzjhm", company.getZfryzjhm()==null?"":company.getZfryzjhm())
								  .replaceFirst("check_startime",company.getOperatedate()==null?"": DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getOperatedate()))
								  .replace("check_endtime",company.getResultdate()==null?"":DateUtil.getDateString("yyyy-MM-dd HH:mm:ss","yyyy年MM月dd日 HH时mm分ss秒",company.getResultdate()))
								  .replace("checkdz",company.getComdz()==null?"":company.getComdz());
		}
		return resultinfo;
	};

}
