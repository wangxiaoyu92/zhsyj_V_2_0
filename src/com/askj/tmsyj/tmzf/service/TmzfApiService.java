package com.askj.tmsyj.tmzf.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Strings;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.upload.UploadAdaptor;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.news.News;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PcompanyXkzDTO;
import com.askj.baseinfo.dto.PcomryDTO;
import com.askj.baseinfo.dto.PzfryDTO;
import com.askj.jk.dto.JkDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.zfba.dto.ZfajdjDTO;
import com.askj.zfba.dto.ZfajzfwsDTO;
import com.lbs.commons.GlobalNameS;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * TmzfApiService的中文名称：【透明执法】api接口service
 * 
 * TmzfApiService的描述：
 * 
 * @author ：zjf
 * @version ：V1.0
 */
public class TmzfApiService extends BaseService {
	protected static final Log log = Logs.get();
	@Inject
	private Dao dao;

	/**
	 * 
	 * getPzfryList的中文名称：获取执法人员列表
	 *
	 * getPzfryList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getPzfryList(HttpServletRequest request, PzfryDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select v.userid,v.username,v.description,v.mobile,v.aaa027, ");
		sb.append("  v.orgname,v.zfryid,v.zfrypym,v.zfrycsrq, ");
		sb.append("  v.zfrysfzh,v.zfryzjhm,v.zfrybz,v.zfryzw , zfryzflybm ,zfryzflymc,");
		sb.append("  getAa10_aaa103('ryxb',zfryxb) zfryxb, ");
		sb.append("  (select max(fjpath) from Fj t where t.fjwid=v.zfryid) as icon ");
		sb.append("  FROM Viewzfry v ");
		sb.append("  where 1=1 ");
		sb.append("  and  v.zfryid= :zfryid ");
		sb.append("  and  v.zfrysfzh = :zfrysfzh "); 
		sb.append("  and  v.userid = :userid "); 
		sb.append("  and  v.mobile= :mobile ");  

		String[] ParaName = new String[] { "zfryid", "zfrysfzh","userid","mobile" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
		String sql = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);		
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 * 
	 * getZfajList的中文名称：获取执法案件列表
	 *
	 * getZfajList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getZfajList(HttpServletRequest request, ZfajdjDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,getAa10_aaa103('ajzt',ajzt) ajztinfo, ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=a.comid and fjtype='4') as icon ");
		sb.append("  from Zfajdj a, Aa13 b");
		sb.append("  where 1=1 ");
		sb.append("  and a.aaa027 = b.aaa027 ");  
		sb.append("  and a.ajdjid = :ajdjid "); // 案件登记id
		//sb.append("  and a.ajdjbh = :ajdjbh "); // 案件登记编号
		sb.append("  and a.aaa027 = :aaa027 "); // 统筹区
		sb.append("  and a.comid = :comid "); // 
		sb.append("  and (a.commc like :commc or a.ajdjbh like :ajdjbh)  "); // 
		sb.append("  and a.slbz = :slbz "); // 案件受理标志
		sb.append("  and a.ajjsbz = :ajjsbz "); // 案件结束标志
		sb.append("  order by a.ajdjid desc ");
		
		String sql = sb.toString();
		String[] ParaName = new String[] { "ajdjid", "ajdjbh", "aaa027", "comid","commc", "slbz", "ajjsbz" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}
	
	/**
	 * 
	 * getZfajPfjList的中文名称：获取执法案件附件列表
	 *
	 * getZfajPfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getZfajPfjList(HttpServletRequest request, ZfajzfwsDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from fj a,Zfajzfws b ");
		sb.append(" where 1=1");
		sb.append(" and a.fjwid = b.ajdjid ");
		sb.append(" and b.zfwsdmz = 'ZFAJZFWS40' ");
		sb.append(" and b.ajdjid = :ajdjid ");
		
		
		String sql = sb.toString();
		String[] paramName = new String[] { "ajdjid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}
	
}
