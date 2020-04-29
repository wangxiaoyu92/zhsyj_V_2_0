package com.askj.tmsyj.tmcy.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.tmsyj.tmcy.dto.HcyjxxjlDTO;
import com.askj.tmsyj.tmcy.dto.HsplyDTO;
import com.askj.tmsyj.tmcy.dto.HyzcpDTO;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * TmcyApiService的中文名称：【透明餐饮子系统】api接口service
 * 
 * TmcyApiService的描述：
 * 
 * @author ：zjf
 * @version ：V1.0
 */
public class TmcyApiService extends BaseService {
	public static final Log log = Logs.get();
	@Inject
	public Dao dao;

	/**
	 * 
	 * getSplyList的中文名称：获取食品留样列表
	 *
	 * getSplyList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getSplyList(HttpServletRequest request,HsplyDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,p.commc,getAa10_aaa103('jccc',a.jccc) jcccmc, ");
		sb.append(" (select max(fjpath) from Fj t where t.fjwid=a.hsplyid) as icon ");
		sb.append(" from Hsply a ,Pcompany p  "); 
		sb.append(" where a.comid = p.comid  ");
		sb.append(" and a.hsplyid = :hsplyid ");
		sb.append(" and a.comid = :comid ");
		sb.append(" and order by aae036 desc ");
		String[] ParaName = new String[]{"hsplyid","comid"};
		int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}
	
	/**
	 * 
	 * getYzcpList的中文名称：获取一周菜谱列表
	 *
	 * getYzcpList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getYzcpList(HttpServletRequest request,HyzcpDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.hyzcpid,a.cprq,a.cpxq,a.aae011,a.aae036,a.comid,");
		sb.append(" a.jccc,getAa10_aaa103('jccc',a.jccc) jcccmc, ");
		sb.append(" case when (a.jccc=1 and a.cpxq=1) then a.cpmc end bf1,");
		sb.append(" case when (a.jccc=1 and a.cpxq=2) then a.cpmc end bf2,");
		sb.append(" case when (a.jccc=1 and a.cpxq=3) then a.cpmc end bf3,");
		sb.append(" case when (a.jccc=1 and a.cpxq=4) then a.cpmc end bf4,");
		sb.append(" case when (a.jccc=1 and a.cpxq=5) then a.cpmc end bf5,");
		sb.append(" case when (a.jccc=1 and a.cpxq=6) then a.cpmc end bf6,");
		sb.append(" case when (a.jccc=1 and a.cpxq=0) then a.cpmc end bf7,");		
		sb.append(" case when (a.jccc=2 and a.cpxq=1) then a.cpmc end lc1,");
		sb.append(" case when (a.jccc=2 and a.cpxq=2) then a.cpmc end lc2,");
		sb.append(" case when (a.jccc=2 and a.cpxq=3) then a.cpmc end lc3,");
		sb.append(" case when (a.jccc=2 and a.cpxq=4) then a.cpmc end lc4,");
		sb.append(" case when (a.jccc=2 and a.cpxq=5) then a.cpmc end lc5,");
		sb.append(" case when (a.jccc=2 and a.cpxq=6) then a.cpmc end lc6,");
		sb.append(" case when (a.jccc=2 and a.cpxq=0) then a.cpmc end lc7,");		
		sb.append(" case when (a.jccc=3 and a.cpxq=1) then a.cpmc end dn1,");
		sb.append(" case when (a.jccc=3 and a.cpxq=2) then a.cpmc end dn2,");
		sb.append(" case when (a.jccc=3 and a.cpxq=3) then a.cpmc end dn3,");
		sb.append(" case when (a.jccc=3 and a.cpxq=4) then a.cpmc end dn4,");
		sb.append(" case when (a.jccc=3 and a.cpxq=5) then a.cpmc end dn5,");
		sb.append(" case when (a.jccc=3 and a.cpxq=6) then a.cpmc end dn6,");
		sb.append(" case when (a.jccc=3 and a.cpxq=0) then a.cpmc end dn7");
		sb.append(" from Hyzcp a ,Pcompany p  "); 
		sb.append(" where a.comid = p.comid  ");
		sb.append(" and a.hyzcpid = :hyzcpid ");
		sb.append(" and a.comid = :comid ");
		sb.append(" and order by cprq desc ");
		String[] ParaName = new String[]{"hyzcpid","comid"};
		int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}
	
	/**
	 * 
	 * getCyjxxjlList的中文名称：获取餐饮具消毒记录列表
	 *
	 * getYzcpList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getCyjxxjlList(HttpServletRequest request,HcyjxxjlDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,getAa10_aaa103('xdfs',a.xdfs) xdfsmc ");
		sb.append(" from Hcyjxxjl a ,Pcompany p  "); 
		sb.append(" where a.comid = p.comid  ");
		sb.append(" and a.hcyjxxjlid = :hcyjxxjlid ");
		sb.append(" and a.comid = :comid ");
		sb.append(" and order by aae036 desc ");
		String[] ParaName = new String[]{"hcyjxxjlid","comid"};
		int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}

}
