package com.askj.supervision.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean; 

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BschecktaskDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

@IocBean
public class AqjcglService {

	protected final Logger logger = Logger.getLogger(AqjcglService.class);

	@Inject
	private Dao dao;

	/**
	 * 查询检查任务
	 * @param dto  检查任务DTO
	 * @param pd  分页对象
	 * @return
	 * @throws Exception
     */
	public Map queryjcrw(BschecktaskDTO dto, PagesDTO pd) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
	    String userid=vSysUser.getUserid();
	    String aa027= vSysUser.getAaa027();
	    System.out.println(aa027);
	    System.out.println(aa027.substring(0,2));
	    aa027 = aa027.substring(0,2) ;
	    System.out.println(aa027);
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT cp.planid,cp.plantitle,cp.planchecktype,cp.plantype,ct.taskname,p.comid,p.comdalei, ");
		sb.append(" ct.taskremark,ct.tasktimest,ct.tasktimeed,p.commc,p.aaa027, a.aaz093 ");
		sb.append(" FROM bscheckplan cp,bschecktask ct,bschecktaskdetail ctd,bschecktaskperson ctp,pcompany p ,aa10 a,pcompanycomdalei cd ");
		sb.append("  WHERE 1=1 AND ctp.taskid=ct.taskid AND ct.planid=cp.planid  AND  cd.comdalei = a.AAA102 ");
		sb.append(" AND ctd.taskid=ct.taskid AND ctd.comid=p.comid AND a.AAA100='comdalei' and a.AAA101 = 'SPSC' AND cd.comid=p.comid  ");
        sb.append(" AND ctp.userid= '").append(userid).append("' AND p.aaa027 like '").append(aa027).append("%'");
		String sql=sb.toString();
		 String[] ParaName = new String[] { };
		 int[] ParaType = new int[] { };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BschecktaskDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	} 
	
}
