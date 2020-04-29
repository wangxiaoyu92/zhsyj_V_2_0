package com.askj.zfba.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zfba.dto.ZfajzfwsmbDTO;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * WsmbglService的中文名称：文书模板管理
 *
 * WsmbglService的描述
 *
 * Written by CatchU 2016年5月18日下午6:03:31
 */
public class WsmbglService extends BaseService {
	protected final Logger logger = Logger.getLogger(WsmbglService.class);
	@Inject
	private Dao dao;
	
	/*******************文书模板管理start***************************/
	/**
	 * 
	 * queryWsmb的中文名称:查询文书模板
	 *
	 * queryWsmb的概要说明:
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * Written by CatchU 2016年5月18日下午5:43:50
	 * @throws Exception 
	 */
	public Map queryWsmb(ZfajzfwsmbDTO dto, PagesDTO pd) throws Exception {
		//查询三张表拼接需要的信息
		StringBuffer sb=new StringBuffer();
		sb.append("  select a.*,b.fjcsdmmc,b.FJCSZFWSTITLE,b.zfwsurl,c.zfwsmbid,c.zfwsmbmc, ");
		sb.append("  c.zfwsmbczy,c.zfwsmbczsj,c.aaa027,c.userid,c.aaa146  ");
		//sb.append("  select a.*,b.fjcsdmmc,b.zfwsurl,b.fjcszfwstitle, ");
  		//sb.append("  (select count(t.fjid) from pfj t where t.fjcsdmz=a.zfwsdmz and t.fjwid=a.ajdjid) as zfwsycfjzs,  ");
		//sb.append("  c.zfwsmbid,c.zfwsmbmc,c.zfwsmbczy,c.zfwsmbczsj,c.aaa027,c.userid,c.aaa146 ");
		sb.append("  from Zfajzfws a,Viewzfajzfws b,zfajzfwsmb c ");
		sb.append("  where 1=1");
		sb.append("  and a.zfwsdmz=b.fjcsdmz");
		sb.append("  and a.ajdjid = c.ajdjid");
		sb.append("  and a.zfwsqtbid = c.zfwsqtbid");
		sb.append("  and c.zfwsdmz = :zfwsdmz");
		if("".equals(dto.getZfwsmbmc())||dto.getZfwsmbmc()==null){
			sb.append("  and zfwsmbmc like '"+"%预定模板%'");
		}else{
			sb.append("  and zfwsmbmc like '%"+dto.getZfwsmbmc()+"%'");
		}
		sb.append("  and c.zfwsmbczy like :zfwsmbczy ");
		sb.append("  and aaa027 = '410000000000'");
		sb.append("  ORDER BY b.FJCSDMZ ");
		String sql=sb.toString();
		String[] ParaName = new String[] {"zfwsdmz","zfwsmbczy"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajzfwsmbDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	/*******************文书模板管理end***************************/

	

}
