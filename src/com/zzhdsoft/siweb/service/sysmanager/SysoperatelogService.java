package com.zzhdsoft.siweb.service.sysmanager;
 
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysoperateService的中文名称：系统操作日志service
 * 
 * SysoperateService的描述：
 * 
 * Written by : zjf
 */ 

public class SysoperatelogService {
	protected final Logger logger = Logger.getLogger(SysoperatelogService.class);
	@Inject
	private Dao dao;
	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 
	 * querySysoperatelog的中文名称：查询系统操作日志
	 * 
	 * querySysoperatelog的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysoperatelog(Sysoperatelog dto, PagesDTO pd)
			throws Exception {
		// 当前登录用户所属机构及下级机构
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select t.*,m.username,m.userkind,");
		sb
				.append(" (select title from sysfunction a where a.functionid = t.operate) title,");
		sb
				.append(" (select title from sysfunction h where h.functionid = t.module) parent");
		sb.append(" from Sysoperatelog t,Sysuser m,Sysorg n");
		sb.append(" where 1=1");
		sb.append("  and t.userid = m.userid");
		sb.append("  and m.orgid = n.orgid");
		sb.append("  and m.userid = :userid");
		sb.append("  and m.username like :username");
		sb.append("  and m.userkind = :userkind");
		sb.append("  and n.orgcode like '").append(orgcode).append("%'");
		sb.append("  order by operatelogid desc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "userid", "username", "userkind" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * querySysoperatelogPrint的中文名称：查询系统操作日志打印
	 * 
	 * querySysoperatelogPrint的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysoperatelogPrint(Sysoperatelog dto, PagesDTO pd)
			throws Exception {
		// 当前登录用户所属机构及下级机构
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select t.*,m.username,m.userkind,");
		sb
				.append(" (select title from sysfunction a where a.functionid = t.operate) title,");
		sb
				.append(" (select title from sysfunction h where h.functionid = t.module) parent");
		sb.append(" from Sysoperatelog t,Sysuser m,Sysorg n");
		sb.append(" where 1=1");
		sb.append("  and t.userid = m.userid");
		sb.append("  and m.orgid = n.orgid");
		sb.append("  and m.userid = :userid");
		sb.append("  and m.username = :username");
		sb.append("  and m.userkind = :userkind");
		sb.append("  and n.orgcode like '").append(orgcode).append("%'");
		sb.append("  order by operatelogid desc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "userid", "username", "userkind" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null,0, 0);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("recordset", ls);
		return r;
	}  
}
