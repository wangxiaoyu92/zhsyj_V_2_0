package com.askj.tmsyj.tmcsc.service;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.askj.baseinfo.dto.HviewjgztDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.tmsyj.tmcsc.dto.PscfqDTO;
import com.askj.tmsyj.tmcsc.dto.PshDTO;
import com.askj.tmsyj.tmcsc.entity.Pscfq;
import com.askj.tmsyj.tmcsc.entity.Psh;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserrole;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
@IocBean
public class ScfqHshService {
	public static final Log log = Logs.get();
	@Inject
	private Dao dao; 
	@Inject
	private PcompanyService pcompanyService;		
	
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	public List queryScfq(PscfqDTO dto,PagesDTO pd) throws Exception{
		 Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		 StringBuffer sb = new StringBuffer();
		 if("".equals(dto.getPscfqid()) || dto.getPscfqid()==null){
			sb.append(" SELECT   p.comid AS pscfqid,p.commc AS scfqmc ");
			sb.append(" ,(select count(*) from pscfq where comid = p.comid ) childnum , ");
			sb.append("  'true' as isparent , 'true' as isopen ");
			//gu20170506 以前只取菜市场 现在放开为企业账户 都可添加自己的分区 sb.append("  FROM pcompany p WHERE  p.comdalei LIKE '101401%'  ");
			sb.append("  FROM pcompany p WHERE  p.comid='"+vSysUser.getAaz001()+"' ");
		} else{
			sb.append(" SELECT z.* , case when childnum > 0 then 'true' else 'false'  ");
			sb.append(" end as isparent, case when childnum > 0 then 'true' else 'false' ");
			sb.append(" end as isopen FROM ( SELECT p.*, (SELECT COUNT(*) FROM pscfq WHERE  ");
			sb.append(" scfqbh=p.pscfqid) childnum, (SELECT  scfqmc  FROM pscfq WHERE pscfqid=p.scfqbh) parentname  ");
			sb.append(" FROM pscfq p WHERE 1=1 and p.comid =:pscfqid   ) z "); 
		}
		String[] ParaName = new String[] { "pscfqid", "scfqbh" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, PscfqDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return ls ;
	} 
	 
	/**
	 * 
	 * saveScfq的中文名称：保存和更新市场分区
	 * 
	 * saveScfq的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String saveScfq(PscfqDTO dto){
		try {
			saveScfqImpl(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return Lang.wrapThrow(e).getMessage();
		}
		return null; 
	}
	/**
	 * 
	 * saveScfqImpl的中文名称：实现 保存和更新市场分区
	 * 
	 * saveScfqImpl的概要说明：
	 *
	 * @param dto
	 * @throws Exception
	 * @author : ly
	 */
	@Aop("trans")
	public void saveScfqImpl(PscfqDTO dto) throws Exception{
		if("".equals(dto.getParent()) || dto.getParent()==null){
			dto.setComid("0");    //市场分区编号就是父市场id
		}else{
			dto.setComid(dto.getParent());
		}
		Pscfq scfq = new Pscfq();
		if("".equals(dto.getPscfqid()) || dto.getPscfqid() == null){
			Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser(); 
			String datetime = SysmanageUtil.getDbtimeYmdHns();
			BeanHelper.copyProperties(dto, scfq);
			scfq.setAae011(sysuser.getUsername());
			scfq.setAae036(Timestamp.valueOf(datetime));
			scfq.setPscfqid(DbUtils.getSequenceStr());
			dao.insert(scfq);
		}else{
			scfq = dao.fetch(Pscfq.class,Cnd.where("pscfqid","=",dto.getPscfqid()));
			scfq.setComid(dto.getComid()); 
			scfq.setScfqbh(dto.getScfqbh());
			scfq.setScfqmc(dto.getScfqmc());
			dao.update(scfq);
		}
	}
	
	/**
	 * 
	 * delScfq的中文名称：删除市场分区
	 * 
	 * delScfq的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String delScfq(PscfqDTO dto){
		try {
			delScfqImpl(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}
	/**
	 * 
	 * delScfqImpl的中文名称：实现  删除市场分区
	 * 
	 * delScfqImpl的概要说明：
	 *
	 * @param dto
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@Aop("trans")
	public void delScfqImpl(PscfqDTO dto) throws Exception{
		if( !"".equals(dto.getPscfqid()) && dto.getPscfqid() != null){
			PagesDTO pd = new PagesDTO();
			List sc =  queryScfq(dto,pd);//sc为空表示没有孩子直接删除
			if(sc==null || sc.size()==0){
				dao.delete(Pscfq.class,dto.getPscfqid());	
			}else{//如果sc>0 表示有孩子  如下遍历孩子
				 for(int q =0;q<sc.size();q++){
					PscfqDTO scfq = (PscfqDTO) sc.get(q); //获取第q个孩子
					if(scfq.getChildnum()==0){//若显示孩子个数为0 删除
						dao.delete(Pscfq.class,scfq.getPscfqid());
					}else{  //若显示孩子个数为>0则把当前的id调用 delScfqImpl，即函数本身
						 PscfqDTO fq = new PscfqDTO();
						fq.setPscfqid(scfq.getPscfqid()); 
						delScfqImpl(fq); 
					}
				}
				 dao.delete(Pscfq.class,dto.getPscfqid());//最后把父亲干掉，即外层文件夹
			}
		}
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querySh(PshDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select h.*,s.scfqmc parentname,");
		sb.append("(select aaa103 from aa10 where aaa100='comzzzm' and h.shzzzmmc=aaa102 ) shzzzmmcinfo ");
		sb.append(" ,(select commc from pcompany where  h.comid=comid ) commc, ");
        sb.append("(select t.username from sysuser t where t.aaz001=h.pshid) as shusername ");
		sb.append(" from psh h,pscfq s where h.pscfqid=s.pscfqid ");
		sb.append(" and h.pscfqid=:pscfqid ");
		sb.append(" and h.comid=:comid ");
		sb.append(" and h.pshid=:pshid ");
		String[] ParaName = new String[]{"pscfqid","comid","pshid"};
		int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, PshDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r; 
	}
	
	/**
	 * 
	 * saveSh的中文名称：删除商户
	 * 
	 * saveSh的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String saveSh(PshDTO dto){
		try {
			saveShImpl(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}
	
	/**
	 * 
	 * saveShImpl的中文名称：
	 * 
	 * saveShImpl的概要说明：
	 *
	 * @param dto
	 * @author : ly
	 * @throws Exception 
	 */
	@Aop("trans")
	public void saveShImpl(PshDTO dto) throws Exception{
		Psh sh = new Psh();
		BeanHelper.copyProperties(dto, sh);
		if("".equals(dto.getPshid()) || dto.getPshid() == null){ 
			String v_pshid=DbUtils.getSequenceStr();
			sh.setPshid(v_pshid);
			dao.insert(sh);
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(v_pshid);
			v_HviewjgztDTO.setDokind("add");
			v_HviewjgztDTO.setTablemc("psh");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);
			
			//商户增加时 产生用户账号
			Pcompany v_pcompany =dao.fetch(Pcompany.class, Cnd.where("comid", "=", dto.getComid()));
			Sysuser v_newSysuser = new Sysuser();
			String v_username=SysmanageUtil.getComUsername(v_pcompany.getComdm());
			v_newSysuser.setUserid(v_pshid);
			v_newSysuser.setUsername(v_username);
			v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
			v_newSysuser.setUserkind("8");// 商户
			v_newSysuser.setDescription(dto.getShmc());
			v_newSysuser.setAaa027(v_pcompany.getAaa027());
			v_newSysuser.setOrgid("2017050814384364214643306");
			v_newSysuser.setMobile(dto.getShyddh());//gu20161020add
			v_newSysuser.setAaz001(v_pshid);//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
			
			Sysuserrole v_Sysuserrole=new Sysuserrole();
			String v_USERROLEID = DbUtils.getSequenceStr();
			v_Sysuserrole.setUserroleid(v_USERROLEID);
			v_Sysuserrole.setUserid(v_pshid);
			v_Sysuserrole.setRoleid("2017050815244129895839170");
			dao.insert(v_newSysuser);
			dao.insert(v_Sysuserrole);	
			
		}else{
			dao.update(sh);
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(sh.getPshid());
			v_HviewjgztDTO.setDokind("update");
			v_HviewjgztDTO.setTablemc("psh");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);	
			
			//更新操作员的姓名和手机号
			Sysuser v_oldsysuser=dao.fetch(Sysuser.class, Cnd.where("aaz001", "=", dto.getPshid()));
			v_oldsysuser.setDescription(dto.getShmc());
			v_oldsysuser.setMobile(dto.getShyddh());
			dao.update(v_oldsysuser);
		}
	}
	/**
	 * 
	 * delSh的中文名称：删除商户
	 * 
	 * delSh的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	public String delSh(PshDTO dto) throws Exception{
		delShImpl(dto);
		return null;
	}
	/**
	 * 
	 * delShImpl的中文名称：
	 * 
	 * delShImpl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@Aop("trans")
	public void delShImpl(PshDTO dto) throws Exception{
		Psh ps = dao.fetch(Psh.class,dto.getPshid());
		if(ps != null){
			dao.delete(Psh.class,dto.getPshid());
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(dto.getPshid());
			v_HviewjgztDTO.setDokind("delete");
			v_HviewjgztDTO.setTablemc("psh");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);				
		}else{
			throw new BusinessException("商户不存在！！！");
		}
	}
}
