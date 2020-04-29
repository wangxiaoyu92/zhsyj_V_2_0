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
import com.askj.zx.dto.ZxIntegrityDTO;
import com.askj.zx.entity.Zxintegrityassess;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 诚信评估
 * @author lfy
 *
 */
public class IntegrityassessService extends BaseService{
	protected final Logger logger = Logger.getLogger(IntegrityassessService.class);
	@Inject
	private Dao dao;
	/**
	 * 分页查询
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map queryIntegrityAssessInfo(ZxIntegrityDTO dto, PagesDTO pd) throws Exception{
//		Cnd c=null;
//		c = Cnd.where("1", "=", "1");
//		Map map=new HashMap();
//		map.put("rows", GlobalConfig.getSqlByID("C_queryZxAssessInfo"));
//		map.put("total", dao.count(Zxintegrityassess.class, arg1));
		
		
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT  a.iaid, a.spYear,a.iaAccessDate,p.commc,a.iaScore,a1.AAA103,z.logIp,b.bcName,s.USERNAME ");
		sb.append("  FROM zxintegrityassess a,pcompany p,sysuser s,zxoperlog z, zxbusinesscode b,aa10 a1");
		sb.append(" WHERE a.comId=p.comid AND a.userId=s.USERID and ");
		sb.append(" a.logId=z.logId AND a.bcCode=b.bcCode AND a.spZxGrade=a1.AAA102");
		sb.append(" and 1=1");
		sb.append(" and s.username like :username");
		sb.append(" and p.commc like :commc");
		sb.append(" and a1.AAA102 = :aaa102 ");
		String sql=sb.toString();
		String[] ParaName = new String[] { "username", "commc", "aaa102"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		@SuppressWarnings("unchecked")
		Map<Object,Object> m=DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxIntegrityDTO.class,  pd.getPage(),pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map<Object,Object> map=new HashMap<Object,Object>();
		map.put("rows", ls);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	@Aop( { "trans" })
	public void savaIntegrityAssessImp(HttpServletRequest request,Zxintegrityassess dto) throws Exception{
		if(null!=dto.getIaid()){
			Zxintegrityassess assess=dao.fetch(Zxintegrityassess.class, dto.getIaid());
			assess.setSpyear(dto.getSpyear());
			assess.setComid(dto.getComid());
			assess.setBccode(dto.getBccode());
			assess.setIaaccessdate(dto.getIaaccessdate());
			assess.setIascore(dto.getIascore());
			assess.setLogid(dto.getLogid());
			assess.setSpzxgrade(dto.getSpzxgrade());
			assess.setUserid(dto.getUserid());
			dao.update(assess);
		}else{
			//int ii= new Long(ll).intValue();
			//long类型的数据强制转换成integer
			Long iaid=DbUtils.getSequenceL("SQ_ZXASSESS");
			Integer id=new Long(iaid).intValue();
			dto.setIaid(id);
			dao.insert(dto);
		}
	}
	/**
	 * 添加信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveZxIntegrity(HttpServletRequest request,Zxintegrityassess dto){
		try {
			savaIntegrityAssessImp(request, dto);
			
		} catch (Exception e) {
			// TODO: handle exception
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
}
