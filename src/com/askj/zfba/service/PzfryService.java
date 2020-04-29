package com.askj.zfba.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.baseinfo.service.pub.PubService;
import com.lbs.util.StringUtils;
import com.zzhdsoft.siweb.dto.FjDTO;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.Param;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PzfryDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pzfry;
import com.askj.baseinfo.entity.Pzfryzfly;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.PinYinUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
/**
 * 
 *ViewzfryService的中文名称：查询执法人员视图
 *ViewzfryService的概要描述：
 * written  by ：ly
 */
public class PzfryService extends BaseService {
	protected final Logger logger = Logger.getLogger(PzfryService.class);
	@Inject
	private Dao dao;
	@Inject
	private PubService pubService;
	/**
	 * 
	 *  pzfry的中文名称：查看页面需 性别和执法领域需要汉字
	 *  pzfry的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map pzfry(PzfryDTO dto, PagesDTO pd) throws Exception{
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String v_aaa027="";
		if(sysuser!=null){
			v_aaa027= sysuser.getAaa027().replaceAll("0*$", "");
		}

		
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT v.userid,v.username,v.description,v.mobile,v.aaa027, ");
		sb.append("   v.orgname,v.zfryid,v.zfrypym,v.zfrycsrq, ");
		sb.append(" v.zfrysfzh,v.zfryzjhm,v.zfrybz,v.zfryzw , zfryzflybm ,zfryzflymc,");
		 sb.append("  (select aaa103 from aa10 where aaa102=zfryzflyid) zfryzflyid , ");
		sb.append("  (select aaa103 from aa10 where aaa100='ryxb' and aaa102=zfryxb) zfryxb ");
		sb.append("   FROM viewzfry v ");
		sb.append("   where v.aaa027 like '"+v_aaa027+"%' ");
		//sb.append("  and  v.zfryzflyid = :zfryzflyid");
		sb.append("  and  v.zfryid= :zfryid ");
		sb.append("  and  v.zfrysfzh = :zfrysfzh "); 
		sb.append("  and  v.userid = :userid ");
		if (StringUtils.isNotEmpty(dto.getMobile())){
			sb.append("  and (v.mobile like '%"+dto.getMobile()+"%' or v.username like '%"+dto.getMobile()+"%'  or v.description like '%"+dto.getMobile()+"%'  or v.zfrypym like '%"+dto.getMobile()+"%' ) ");
		}
		if (dto.getZfrylybm()!=null && !"".equals(dto.getZfrylybm())){
			sb.append("  and  exists (select t.zfrylyid from pzfryzfly t where t.zfryid=v.zfryid and t.zfrylybm='"+dto.getZfrylybm()+"') ");
		}
		
		String[] ParaName = new String[] { "zfryid",  "zfryzflyid", "zfrysfzh","userid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		System.out.println("sqlString "+sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				PzfryDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	} 
	/**
	 * 
	 *  pzfryadd的中文名称：查看页面需 性别和执法领域需要数字
	 *  pzfryadd的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map pzfrych(PzfryDTO dto, PagesDTO pd) throws Exception{
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String v_aaa027= sysuser.getAaa027().replaceAll("0*$", "");
		
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT v.userid,v.username,v.description,v.mobile,v.aaa027, ");
		sb.append("   v.orgname,v.zfryid,v.zfrypym,v.zfrycsrq, ");
		sb.append(" v.zfrysfzh,v.zfryzjhm,v.zfrybz,v.zfryzw , v.zfryzflybm ,v.zfryzflymc,");
		sb.append("  zfryzflyid,zfryxb,v.mobile2,v.telephone," );
		sb.append(" (select t.fjpath from fj t where t.fjwid=v.zfryid and fjtype='10') as zfryzppath ");		
		sb.append("   FROM viewzfry v   ");
		sb.append("   where v.aaa027 like '"+v_aaa027+"%'");
		sb.append("  and  v.zfryzflyid = :zfryzflyid");
		sb.append("  and  v.zfryid= :zfryid ");
		sb.append("  and  v.zfrysfzh = :zfrysfzh "); 
		sb.append("  and  v.userid = :userid "); 
		sb.append("  and  v.mobile= :mobile ");  
		String[] ParaName = new String[] { "zfryid",  "zfryzflyid", "zfrysfzh","userid","mobile" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				PzfryDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	} 
	/*
	 *  执法人员身份证是否登记过
	 */
	public String isExistsZfry(@Param("") PzfryDTO dto){
		Pzfry zfry = null;
		if(!"".equals(dto.getZfrysfzh()) && null!=dto.getZfrysfzh()){
			zfry =dao.fetch(Pzfry.class, Cnd.where("zfrysfzh", "=", dto.getZfrysfzh()));
		}
		if(zfry!=null){
			final StringBuffer sb = new StringBuffer();
			sb.append("您登记的执法人员信息：证件号码【");
			sb.append(zfry.getZfrysfzh());
			sb.append("】姓名【");
			sb.append(zfry.getZfrypym());
			sb.append("】已登记过，请勿重复登记！");
			System.out.println(sb.toString());
			return sb.toString();
		}
		return "0";
	}
	public String getPY(@Param("..") PzfryDTO dto){
		String str=PinYinUtil.GetChineseSpell(dto.getZfrypym());
		return str;
	}
	/**
	 * 
	 *  updateZfry的中文名称：执法注册后需要将信息天道Pzfry表如果执法人员id为空就插入，
	 *  然后将生成的id更新到sysuser表   否则更新Pzfry表
	 *  updateZfry的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	public String updateZfry(HttpServletRequest request, PzfryDTO dto){
		try{ 
			 addZfryImpl(request,dto);
			
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	} 
	 
	@Aop( { "trans" })
	public void addZfryImpl(HttpServletRequest request,PzfryDTO dto) throws Exception{
		if((dto.getZfryid()==null || "".equals(dto.getZfryid())) && "0".equals(isExistsZfry(dto))){
		String zfryid = new String();  //在本if语句内zfryid是全局变量，实现声明
		Pzfry zf=new Pzfry(); 
        String czsj=SysmanageUtil.getDbtimeYmdHns();
		Sysuser User=(Sysuser)SysmanageUtil.getSysuser();
		zfryid = DbUtils.getSequenceStr();
		BeanHelper.copyProperties(dto,zf);
		zf.setZfrycsrq(dto.getZfrycsrq()==""?null:dto.getZfrycsrq());
		zf.setZfryczy(User.getUsername());
		zf.setZfryczsj(czsj);
		zf.setZfryid(zfryid); 
		//zf.setZfryzjhm(DbUtils.getOneValue(dao, "select getZfrybh() from dual"));//执法证号自己填写不统一产生
		dao.insert(zf); 
		String s=dto.getZfryzflybmComBo();
		String[] t=s.split(",");  
		Pzfryzfly pzf=new Pzfryzfly();
		for (int i = 0; i < t.length; i++) {
			pzf.setZfryid(zfryid);
			pzf.setZfrylybm(t[i]); 
			pzf.setZfrylyid(DbUtils.getSequenceStr());
		dao.insert(pzf);
		}
		
		String v_sql="UPDATE Sysuser SET Aaz010='"+zfryid+
        "',mobile='"+dto.getMobile()+"',mobile2='"+
        dto.getMobile2()+"',telephone='"+dto.getTelephone()+
        "' where userid='"+dto.getUserid()+"'";
		Sql v_exesql=Sqls.create(v_sql);
		dao.execute(v_exesql);

			//保存企业门头照 图片
			FjDTO v_fjdto=new FjDTO();
			v_fjdto.setFjwid(zfryid);
			v_fjdto.setFolderName("zfrypic");

			v_fjdto.setFjpath(dto.getZfryzppath());
			v_fjdto.setFjname(dto.getZfryzpname());
			v_fjdto.setFjtype("10");
			pubService.saveFjWuzhuti(request,v_fjdto);

//		  Sql sql = Sqls.create("UPDATE Sysuser SET Aaz010=@masterId $condition");
//		    sql.params().set("masterId", zfryid);
//		    sql.setCondition(Cnd.where("userid","=",dto.getUserid()));
//		    dao.execute(sql); 			
		}else{
			Pzfry zf=new Pzfry();   
			BeanHelper.copyProperties(dto,zf);
			zf.setZfrycsrq(dto.getZfrycsrq()==""?null:dto.getZfrycsrq());
			dao.update(zf); 
			dao.clear(Pzfryzfly.class,Cnd.where("zfryid", "=", dto.getZfryid()));
			String s=dto.getZfryzflybmComBo();
			String[] t=s.split(",");  
			Pzfryzfly pzf=new Pzfryzfly();
			for (int i = 0; i < t.length; i++) {
				pzf.setZfryid(dto.getZfryid());
				pzf.setZfrylybm(t[i]); 
				pzf.setZfrylyid(DbUtils.getSequenceStr());
			dao.insert(pzf);
			}


			
			String v_sql="UPDATE Sysuser SET mobile='"+dto.getMobile()+"',mobile2='"+
	        dto.getMobile2()+"',telephone='"+dto.getTelephone()+"',username='"+dto.getUsername()+
					"',description='"+dto.getDescription()+
	        "' where userid='"+dto.getUserid()+"'";
			Sql v_exesql=Sqls.create(v_sql);
			dao.execute(v_exesql);
			
		} 
		
	};
	
	
}