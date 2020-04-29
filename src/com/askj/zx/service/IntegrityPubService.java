package com.askj.zx.service;
 
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.IntegrityPubDTO;
import com.askj.zx.entity.Zxintegrityassess;
import com.askj.zx.entity.Zxintegritypublicity;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/*
 * 征信公示
 */
public class IntegrityPubService extends BaseService{
	protected final Logger logger = Logger.getLogger(IntegrityPubService.class);
	//dao注入
	@Inject
	private Dao dao;
	/**
	 * sql语句的生成以及调用封装好的工具返回有map封装的list列表
	 * 应注意sql的拼接
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryIntegrityPub(IntegrityPubDTO dto, PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select gs.ipUpDate,gs.ipId,pg.spYear,pg.iaid,pg.iaAccessDate,pg.iaScore ,p.commc, p.comid,gs.ipNote, ");
		sb.append(" (SELECT aaa103 FROM aa10 a1 WHERE a1.AAA102=pg.spzxgrade) AS  spzxgrade,  ");
		sb.append(" (SELECT aaa103 FROM aa10 a1 WHERE a1.AAA102=p.comxiaolei) AS comxiaolei,  ");
		sb.append(" getAa10_aaa103('AAB020',p.comqyxz) AS comqyxz ");
		sb.append(" from zxintegritypublicity  gs , zxintegrityassess  pg ,pcompany p ");
		sb.append(" WHERE  gs.comId=p.comid AND gs.iaId=pg.iaId"); 
		sb.append(" and 1=1");
		sb.append(" and pg.spzxgrade=:spzxgrade");
		sb.append(" and comxiaolei=:comxiaolei");
		sb.append(" and comqyxz=:comqyxz");
		String sql = sb.toString();
		String[] ParaName = new String[] { "spzxgrade", "comxiaolei", "comqyxz"};
		int[] ParaType = new int[] { Types. VARCHAR, Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, IntegrityPubDTO.class, pd.getPage(), pd.getRows());
		List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
		return r;
	} 
	
	/**
	 * 查询详细明细
	 */
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querybusinesscode(IntegrityPubDTO dto, PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT  s4.*,");
		sb.append("  (SELECT z.bcname FROM zxbusinesscode z WHERE z.bcLevel='2' AND z.bccode=s4.bpCodeBusiness) bcparentcode,   ");
		sb.append("  (SELECT z.bcname FROM zxbusinesscode z WHERE z.bcLevel='3' AND z.bccode=s4.bpCodeItem) bccode,   ");
		sb.append("  (SELECT z.bcname FROM zxbusinesscode z WHERE z.bcLevel='4' AND z.bccode=s4.bpCodeLevel ) bcname  ");
		sb.append("   FROM  zxintegrityassess a , ");
		sb.append("   zxbusinesspara s4  ");
		sb.append("   ,zxintegrityassessdetail mx ");  
		sb.append(" WHERE  "); 
		sb.append("    s4.bpId=mx.bpId  AND a.iaid=mx.iaid AND a.comid=:comid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "comid" };
		int[] ParaType = new int[] { Types. VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,IntegrityPubDTO.class, pd.getPage(), pd.getRows());
		List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
		return r;
		}
	/**
	 *   强制拉下榜单
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public String UpdateIntegrityPub(HttpServletRequest request, IntegrityPubDTO dto)throws Exception{
			try {  
				UpdateIntegrityPubimpl(request, dto);
			} catch (Exception e) {
				return Lang.wrapThrow(e).getMessage();
			}
		return null;
	}
	@Aop({"trans"})
	public void UpdateIntegrityPubimpl(HttpServletRequest request, IntegrityPubDTO dto) throws Exception{
		Zxintegritypublicity zxintegritypublicity = dao.fetch(Zxintegritypublicity.class,dto.getIpid());
				zxintegritypublicity.setIpnote(dto.getIpnote());
				dao.update(zxintegritypublicity); 
		 Zxintegrityassess zxintegrityassess = dao.fetch(Zxintegrityassess.class,dto.getIaid());
 		 zxintegrityassess.setSpzxgrade(dto.getSpzxgrade());
 		 zxintegrityassess.setIascore(dto.getIascore());
 			   dao.update(zxintegrityassess); 
	}
}
