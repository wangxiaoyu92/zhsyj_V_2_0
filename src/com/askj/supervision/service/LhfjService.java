package com.askj.supervision.service;

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

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BschecklhfjDTO;
import com.askj.supervision.dto.LhfjcxDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.supervision.entity.Pcompanynddtpj;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import org.nutz.lang.Lang;

/**
 * 企业基本信息 业务逻辑层
 * 
 * @author CatchU
 * 
 */
@IocBean
public class LhfjService extends BaseService {

	protected final Logger logger = Logger.getLogger(LhfjService.class);

	@Inject
	private Dao dao;
	
	/**
	 * 查询量化分级统计
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryLhfjtj(HttpServletRequest request, BschecklhfjDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("select uuu.*,");
		sb.append("(case when uuu.checkoverndavgscore=0 then '9' else (SELECT ifnull(MAX(ps.lhfjpddj),'9') FROM bschecklhfjpjcs ps WHERE ps.lhfjpdlx='1' ");
		sb.append("  AND substring(ps.lhfjpdksrq,1,4)<=uuu.checkyear AND substring(ps.lhfjpdjsrq,1,4)>=uuu.checkyear"); 
        sb.append("  AND ps.lhfjpdqsf<=uuu.checkoverndavgscore AND ps.lhfjpdjsf>=uuu.checkoverndavgscore ) end)  as bndpddjyp ");
		sb.append(" from (");
		sb.append("select uu.* ,FORMAT((case when checkovercount>0 then uu.checkoverndavgscoresum/uu.checkovercount else 0 end),2) AS checkoverndavgscore,");
		sb.append("(case when (bndpddj is null or length(bndpddj)=0)  then 0 else 1 end) as bndsfpddj ");
		sb.append("from (");
		sb.append("Select b.comid,a.checkyear,b.commc,b.comdz,fun_getcomdalei(1,a.comid) AS comdaleistr,b.aaa027,b.orgid,");
		sb.append("Count(a.comid) AS checkcountsum,");
		sb.append("SUM(case when IFNULL(a.resultstate,'0')='4' then 1 else 0 end) AS checkovercount,");
		sb.append("SUM(case when IFNULL(a.resultstate,'0')<>'4' then 1 else 0 end) AS checknoovercount,");
		sb.append("SUM(Case when a.resultdecision='101' then 1 else 0 end) AS checkfhcount,");
		sb.append("SUM(Case when a.resultdecision='102' then 1 else 0 end) AS checkbfhcount,");
		sb.append("SUM(Case when a.resultdecision='103' then 1 else 0 end) AS checkxqzgcount,");
		sb.append("(case when IFNULL(t1.planchecktype,'0') = '0' then 0 else 1 end) as lhflag,");
		sb.append("IFNULL(d.lhfjpdndyjccs,0) AS lhfjpdndyjccs,");
		sb.append("(case when IFNULL(d.lhfjpdndyjccs,0)-Count(a.comid)>=0 then IFNULL(d.lhfjpdndyjccs,0)-Count(a.comid) else 0 end) as hyjccs,");
		sb.append("SUM(case when IFNULL(a.resultstate, '0') = '4' then a.checkavgscore else 0 end) as checkoverndavgscoresum,");
		sb.append("(SELECT MAX(pj.lhfjndpddj) FROM pcompanynddtpj pj WHERE pj.comid=a.comid AND pj.pdyear=(a.checkyear-1)) as sndpddj,");
		sb.append("(SELECT MAX(pj.lhfjndpddj) FROM pcompanynddtpj pj WHERE pj.comid=a.comid AND pj.pdyear=a.checkyear) as bndpddj ");		
		sb.append(" FROM pcompany b LEFT JOIN bscheckmaster a ON a.comid=b.comid ");
		sb.append(" LEFT JOIN pcompanynddtpj c ON b.comid=c.comid ");
		sb.append(" LEFT JOIN bschecklhfjpjcs d ON c.lhfjndpddj=d.lhfjpddj ");
		sb.append(" LEFT JOIN bscheckplan t1 ON d.lhfjpdlx='1' AND a.planid=t1.planid ");
//		sb.append(" and c.lhfjndpddj=d.lhfjpddj )");
//		sb.append(" ON b.comid=c.comid ");
		if (!StringHelper.strisnull(dto.getCheckyear())){
			sb.append(" and c.pdyear='"+dto.getCheckyear()+"'");
		}
//		sb.append(",bscheckplan t1");
//		sb.append(" WHERE a.comid=b.comid");
		sb.append(" WHERE b.comid<>'0'");

		if (!StringHelper.strisnull(dto.getCheckyear())){
			sb.append(" and a.checkyear='"+dto.getCheckyear()+"'");
		}		
//		sb.append(" and a.planid=t1.planid");
//		sb.append(" and t1.planchecktype='0'");
		
		if (!StringHelper.strisnull(dto.getComid())){
			sb.append(" and b.comid='"+dto.getComid()+"'");
		}
		if (!StringHelper.strisnull(dto.getCommc())){
			sb.append(" and b.commc like '%"+dto.getCommc()+"%'");
		}			
		sb.append(" group by b.comid,a.checkyear order by a.checkyear ");
		sb.append(" ) uu where 1=1 ");
		
		if (!StringHelper.strisnull(dto.getCheckcountsumstart())){//检查总次数
			sb.append(" and uu.checkcountsum>='"+dto.getCheckcountsumstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckcountsumend())){//检查总次数
			sb.append(" and uu.checkcountsum<='"+dto.getCheckcountsumend()+"'");
		}
		
		if (!StringHelper.strisnull(dto.getCheckovercountstart())){//检查完成次数
			sb.append(" and uu.checkovercount>='"+dto.getCheckovercountstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckovercountend())){//检查完成次数
			sb.append(" and uu.checkovercount<='"+dto.getCheckovercountend()+"'");
		}	
		
		if (!StringHelper.strisnull(dto.getChecknoovercountstart())){//未完成次数
			sb.append(" and uu.checknoovercount>='"+dto.getChecknoovercountstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getChecknoovercountend())){//未完成次数
			sb.append(" and uu.checknoovercount<='"+dto.getChecknoovercountend()+"'");
		}	
		
		if (!StringHelper.strisnull(dto.getCheckfhcountstart())){//符合次数
			sb.append(" and uu.checkfhcount>='"+dto.getCheckfhcountstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckfhcountend())){//符合次数
			sb.append(" and uu.checkfhcount<='"+dto.getCheckfhcountend()+"'");
		}	
		
		if (!StringHelper.strisnull(dto.getCheckbfhcountstart())){//不符合次数
			sb.append(" and uu.checkbfhcount>='"+dto.getCheckbfhcountstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckfhcountend())){//不符合次数
			sb.append(" and uu.checkbfhcount<='"+dto.getCheckbfhcountend()+"'");
		}		
		
		if (!StringHelper.strisnull(dto.getCheckxqzgcountstart())){//限期整改次数
			sb.append(" and uu.checkxqzgcount>='"+dto.getCheckxqzgcountstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckfhcountend())){//限期整改次数
			sb.append(" and uu.checkxqzgcount<='"+dto.getCheckxqzgcountend()+"'");
		}	
		
		if (!StringHelper.strisnull(dto.getLhfjpdndyjccsstart())){//本年度应检查次数
			sb.append(" and uu.Lhfjpdndyjccs>='"+dto.getLhfjpdndyjccsstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getLhfjpdndyjccsend())){//限期整改次数
			sb.append(" and uu.Lhfjpdndyjccs<='"+dto.getLhfjpdndyjccsend()+"'");
		}	
		
		if (!StringHelper.strisnull(dto.getHyjccsstart())){//还应检查次数
			sb.append(" and uu.hyjccs>='"+dto.getHyjccsstart()+"'");
		}
		if (!StringHelper.strisnull(dto.getHyjccsend())){//还应检查次数
			sb.append(" and uu.hyjccs<='"+dto.getHyjccsend()+"'");
		}
		
		sb.append(") uuu where 1=1 ");
		if (!StringHelper.strisnull(dto.getBndsfpddj())){//本年度是否评定等级
			sb.append(" and uuu.bndsfpddj='"+dto.getBndsfpddj()+"'");
//			if ("0".equals(dto.getBndsfpddj())){
//				sb.append(" and (uu.bndpddj is null or length(uu.bndpddj)=0) ");
//			}else if ("1".equals(dto.getBndsfpddj())){
//				sb.append(" and (uu.bndpddj is not null or length(uu.bndpddj)>0) ");
//			};	
		}			
		
		sb.append(" order by uuu.comid ");
		String sql = sb.toString();
		
		// 转化sql语句
//		String[] paramName = new String[] {};
//		int[] paramType = new int[] {};
//		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//		System.out.println(sql);
		
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, BschecklhfjDTO.class, pd.getPage(), pd.getRows(),vSysUser.getUserid(),"aaa027,aae140,orgid");
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 查询量化分级统计
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryLhfjcx(HttpServletRequest request, LhfjcxDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.resultid,a.planid,c.plantitle,c.planchecktype,a.comid,b.commc,b.comdz,a.resultdecision,a.resultng,a.resultremark,");
		sb.append(" a.resultscore,a.resultstate,a.operatedate,a.operateperson,");
		sb.append("(SELECT u.description FROM sysuser u WHERE u.USERID=a.operateperson) AS operatepersonstr,");
		sb.append("a.resultdate,a.resultperson,");
		sb.append(" a.location,a.lxr,a.lxdh,b.aaa027,a.userid,a.orgid,a.checkavgscore,a.lhfjdtpddj,a.checkyear,");
		sb.append(" (SELECT COUNT(p1.picid) FROM bscheckpicset p1 WHERE p1.planid=a.planid) AS jcnrcount,");
		sb.append(" d.ywcjcnrcount,d.impjcnrcount,d.fhjcnrcount,d.bfhjcnrcount,d.hlqxjcnrcount,d.impbfhjcnrcount");
		sb.append(" FROM pcompany b,bscheckplan c,bscheckmaster a left join ");
		sb.append(" (SELECT t1.resultid,");
		sb.append(" COUNT(t1.contentid) AS ywcjcnrcount,");
		sb.append(" SUM(case when t2.contentimpt>1 then 1 else 0 end) AS impjcnrcount,");
		sb.append(" SUM(case when t1.detaildecide='1' then 1 else 0 end) AS fhjcnrcount,");
		sb.append(" SUM(case when t1.detaildecide='2' then 1 else 0 end) AS bfhjcnrcount,");
		sb.append(" SUM(case when t1.detaildecide='3' then 1 else 0 end) AS hlqxjcnrcount,");
		sb.append(" SUM(case when t1.detaildecide='2' AND t2.contentimpt>1 then 1 else 0 end) AS impbfhjcnrcount ");       
		sb.append(" FROM bscheckdetail t1,omcheckcontent t2 WHERE t1.contentid=t2.contentid");
		sb.append(" GROUP BY t1.resultid");
		sb.append(" ) d on a.resultid=d.resultid ");
		sb.append(" WHERE a.comid=b.comid");
		sb.append(" AND a.planid=c.planid");
		//sb.append(" AND a.resultid=d.resultid");
		sb.append(" AND c.planchecktype='0'");
		if (!StringHelper.strisnull(dto.getComid())){//
			sb.append(" and a.comid='"+dto.getComid()+"'");
		}
		if (!StringHelper.strisnull(dto.getPlanid())){//计划id
			sb.append(" and a.planid>='"+dto.getPlanid()+"'");
		}
		if (!StringHelper.strisnull(dto.getCheckyear())){//计划id
			sb.append(" and a.checkyear>='"+dto.getCheckyear()+"'");
		}		
		if (!StringHelper.strisnull(dto.getOperatedatestart())){//还应检查次数
			sb.append(" and a.operatedate>='"+dto.getOperatedatestart()+"'");
		}
		if (!StringHelper.strisnull(dto.getOperatedateend())){//还应检查次数
			sb.append(" and a.operatedate<='"+dto.getOperatedateend()+"'");
		}		
		sb.append(" ORDER BY a.resultid desc");

		String sql = sb.toString();
		
		// 转化sql语句
//		String[] paramName = new String[] {};
//		int[] paramType = new int[] {};
//		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//		System.out.println(sql);
		
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, LhfjcxDTO.class, pd.getPage(), pd.getRows(),vSysUser.getUserid(),"aaa027,aae140,orgid");
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * saveCreateNddj的中文名称：保存年度等级
	 * 
	 * saveCreateNddj的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception 
	 */
	public String saveCreateNddj(HttpServletRequest request, BschecklhfjDTO dto) {
		try{
			saveCreateNddjImp(request, dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * @Description: 保存年度等级
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void saveCreateNddjImp(HttpServletRequest request, BschecklhfjDTO dto)
			throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		JSONArray v_array = null;
		Object[] v_objArray = null;
		// 物品明细情况
		v_array = JSONArray.fromObject(dto.getMyLhfjtjGridchecked());
		v_objArray = v_array.toArray();
		String v_pcompanynddtpjid="";//企业年度动态评级表ID
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
		String v_lhfjndpddj=dto.getLhfjndpddj();//量化分级年度评定等级
		String v_pdjgscfs=dto.getPdjgscfs();//评定结果生产方式0自动1手动
		String v_sfcxsc=dto.getSfcxsc();//是否重新生成0否1是
		String v_insert="1";
		int v_count=0;
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			BschecklhfjDTO v_BschecklhfjDTO = (BschecklhfjDTO) JSONObject.toBean(
					v_obj, BschecklhfjDTO.class);
			v_insert="1";
			if (v_sfcxsc!=null){
				if ("1".equals(v_sfcxsc)){
					dao.clear(Pcompanynddtpj.class, Cnd.where("comid","=",v_BschecklhfjDTO.getComid()).and("pdyear", "=", v_BschecklhfjDTO.getCheckyear()));
				}else{
					v_count=dao.count(Pcompanynddtpj.class, Cnd.where("comid","=",v_BschecklhfjDTO.getComid()).and("pdyear", "=", v_BschecklhfjDTO.getCheckyear()));
					if (v_count>0){
						v_insert="0";
					}
				}
			}

			if (v_pdjgscfs!=null && "1".equals(v_pdjgscfs)){
				v_lhfjndpddj=dto.getLhfjndpddj();
			}else{
				v_lhfjndpddj=v_BschecklhfjDTO.getBndpddjyp();
			}			
			
			// 获取物品明细id
			if ("1".equals(v_insert)){
				v_pcompanynddtpjid = DbUtils.getSequenceStr();
				Pcompanynddtpj v_newPcompanynddtpj=new Pcompanynddtpj();
				v_newPcompanynddtpj.setPcompanynddtpjid(v_pcompanynddtpjid);
				v_newPcompanynddtpj.setComid(v_BschecklhfjDTO.getComid());
				v_newPcompanynddtpj.setPdyear(v_BschecklhfjDTO.getCheckyear());
				v_newPcompanynddtpj.setLhfjndpddj(v_lhfjndpddj);
				v_newPcompanynddtpj.setAae011(vSysUser.getDescription());
				v_newPcompanynddtpj.setAae036(v_dbDatetime);
				v_newPcompanynddtpj.setPdjgscfs(dto.getPdjgscfs());
				
				dao.insert(v_newPcompanynddtpj);
			}
		}
		
	}	
	

}
