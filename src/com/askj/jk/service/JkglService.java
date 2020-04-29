package com.askj.jk.service;

import java.net.URLDecoder;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.zzhdsoft.utils.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.lbs.util.StringUtils;
import com.askj.jk.entity.Azsxtqyylb;
import com.askj.jk.entity.Jkqyfzr;
import com.askj.jk.entity.Jkyb;
import com.askj.jk.entity.Pcompanyimport;
import com.zzhdsoft.utils.HttpUtil;
import com.zzhdsoft.utils.StringHelper;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.ValidateData;
import com.lbs.leaf.validate.ValidateData.ErrorItem;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserdw;
import com.askj.jk.dto.JkDTO;
import com.askj.jk.dto.JkqyfzrDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.jk.entity.Jk;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

import static com.zzhdsoft.utils.db.DbUtils.*;

/**
 * 
 * JkglService的中文名称：监控管理Service
 * 
 * JkglService的描述：
 * 
 * Written by : zjf
 */
public class JkglService extends BaseService {
	protected static final Log log = Logs.get();
	@Inject
	private Dao dao;

	private static Sql updateByJK = Sqls.create("UPDATE pcompanyimport INNER JOIN jk ON pcompanyimport.outercomid=jk.camorgid SET pcompanyimport.comid=jk.jkqybh");
	private static Sql updateByPcom = Sqls.create("UPDATE pcompanyimport INNER JOIN pcompany ON pcompanyimport.outercomname=pcompany.commc SET pcompanyimport.comid=pcompany.comid");

	/**
	 *
	 * queryJkqy的中文名称：查询监控企业
	 *
	 * queryJkqy的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJkqy(JkDTO dto, PagesDTO pd) throws Exception {
		//处理中文乱码
		if(StringUtils.isNotEmpty(dto.getJkqymc())){
			dto.setJkqymc(new String(dto.getJkqymc().getBytes("ISO-8859-1"),"utf-8"));
		}

		String preYear = String.valueOf(DateUtil.getCurrentYear()-1);
		StringBuffer sb = new StringBuffer();
		sb.append(" select  distinct a.*, ");
		sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=a.comid and fjtype='4') as filepath, ");
		sb.append(" (select t.qrcodepath from Pcomqrcode t where t.comid=a.comid) as qrcode, ");
		sb.append(" (select t.lhfjndpddj from Pcompanynddtpj t where t.comid=a.comid and t.pdyear='").append(preYear).append("') as lhfjndpddj, ");
		sb.append(" a.comid as jkqybh,a.commc as jkqymc,c.state,c.outercomid camorgid ");
		sb.append(" from Pcompany a left join Pcompanyimport c on a.comid=c.comid ");
		sb.append(" where 1=1");
		sb.append(" and a.comid = :jkqybh ");
		sb.append(" and a.comspjkbz =:comspjkbz ");
		sb.append(" and a.commc like :jkqymc ");
		sb.append(" and a.aaa027 like :aaa027 ");
		if (StringUtils.isNotEmpty(dto.getQuerytype())&&"mobilecam".equals(dto.getQuerytype())){
			sb.append(" and a.comcameraflag='1' ");
		}
//		if (StringUtils.isEmpty(dto.getComcameraflag())){
//			sb.append(" and a.comspjkbz='1' ");
//		}

		sb.append(" and a.comfwnfww = '0' ");
		sb.append(" and  c.state = :state ");
		if(!"".equals(StringHelper.showNull2Empty(dto.getComdalei()))){
			//gu20180622 sb.append(" and find_in_set(").append(dto.getComdalei()).append(",a.comdalei) ");
			sb.append(" and exists (select 1 from pcompanycomdalei t1 where t1.comid=a.comid and t1.comdalei  like '%"+dto.getComdalei()+"%')");
		}
//			if(!"".equals(StringHelper.showNull2Empty(dto.getComxiaolei()))){
//				sb.append(" and find_in_set(").append(dto.getComxiaolei()).append(",a.comxiaolei) ");
//			}
		//gu20171129add 摄像头标志 控制摄像头企业的显示
		sb.append(" and  a.comcameraflag = :comcameraflag ");
		sb.append(" order by a.orderno+0 desc");

		String sql = sb.toString();
		String[] paramName = new String[] { "jkqybh", "jkqymc", "aaa027","comspjkbz","state","comcameraflag" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}
	/**
	 * 
	 * queryJkqy2的中文名称：查询监控企业
	 * 
	 * queryJkqy2的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJkqy2(JkDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		// 添加是否指派监管员查询条件
		sb.append("  select * from (");
		// 左关联监控企业负责人表，查看是否指派监管人
		sb.append("  select t.*, case when d.jkqyfzrid then true  ELSE false end as ishavejgy from (");
		sb.append("  select distinct jkqybh,jkqymc,c.state,c.synchtime,b.comdz, ");
		sb.append("  IFNULL((select distinct c.FJPATH from fj c where c.FJWID=b.comid LIMIT 1 ),'null') as filepath ");
		sb.append("  from Jk a,Pcompany b,Pcompanyimport c ");
		sb.append("  where 1=1 ");
		sb.append("  and  a.jkqybh = b.comid ");
		sb.append("  and  b.comid = c.comid ");
		sb.append("  and  a.jkqybh like :jkqybh ");
		sb.append("  and  a.jkqymc like :jkqymc ");
		sb.append("  and  a.jklx = :jklx ");
		//sb.append("  and  find_in_set(:comdalei,b.comdalei) ");zjf modify 
		if(!"".equals(StringHelper.showNull2Empty(dto.getComdalei()))){
			sb.append(" and find_in_set(").append(dto.getComdalei()).append(",b.comdalei) ");
		}
		sb.append("  and  b.aaa027 like :aaa027 ");
		sb.append("  and  c.state = :state ");
		sb.append("  order by c.state desc, a.orderno ");
		sb.append("  ) t LEFT JOIN jkqyfzr d ON t.jkqybh = d.comid ) tt");
		// 添加是否指派监管员查询条件
		if (dto.getIshavejgy() != null && "0".equals(dto.getIshavejgy())) {
			sb.append("  where 1=1 and  tt.ishavejgy = '0' "); // 没有指派
		} else if (dto.getIshavejgy() != null && "1".equals(dto.getIshavejgy())) {
			sb.append("  where 1=1 and  tt.ishavejgy = '1' "); // 指派了
		}

		String[] ParaName = new String[] { "jkqybh", "jkqymc", "jklx", "comdalei", "aaa027", "state" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,  
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DataQuery(GlobalNames.sql, sqlString, null, JkDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * queryJkcomList 查询监控企业
	 * 
	 * queryJkcomList 查询监控企业
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJkcomList(PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select b.comid, b.commc, b.comdz ");
		sb.append("  from Jk a, Pcompany b, Pcompanyimport c ");
		sb.append("  where 1=1 ");
		sb.append("  and  a.jkqybh = b.comid ");
		sb.append("  and  b.comid = c.comid ");
		if (dto.getCommc() != null && !"".equals(dto.getCommc())) {
			sb.append("  and  b.commc like :commc ");
		}
		if (dto.getAaa027() != null && !"".equals(dto.getAaa027())) {
			sb.append("  and  b.aaa027 = :aaa027 ");
		}
		sb.append("  group by b.comid ");
		sb.append("  order by b.comid ");

		String[] ParaName = new String[] { "commc", "aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DataQuery(GlobalNames.sql, sqlString, null,
				PcompanyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryJkfzrList 查询监控企业负责人
	 * 
	 * queryJkfzrList 查询监控企业负责人
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJkfzrList(JkqyfzrDTO dto, PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select b.*, org.ORGNAME bmmc, a.mobile2, org.ORGID orgid, a.DESCRIPTION username ");
		sb.append(" from jkqyfzr b, sysuser a, sysorg org ");
		sb.append(" where 1=1 ");
		sb.append(" and b.userid = a.userid ");
		sb.append(" and a.orgid = org.orgid ");
		sb.append(" and b.comid = :comid ");
		sb.append(" order by jkqyfzrid desc ");
		String sql = sb.toString();
		String[] paramName = new String[]{ "comid" };
		int[] paramType = new int[]{ Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		Map m = DataQuery(GlobalNames.sql, sql, null, JkqyfzrDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * saveJkFzr 保存监控负责人
	 * 
	 * saveJkFzr
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String saveJkFzr(HttpServletRequest request, JkqyfzrDTO dto){
		try{
			saveJkFzrImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveJkFzrImpl 保存负责人实习那方法
	 * 
	 * saveJkFzrImpl
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void saveJkFzrImpl(HttpServletRequest request, JkqyfzrDTO dto) throws Exception {
		
		// 获取监控企业
		JSONArray v_comArr = JSONArray.fromObject(dto.getComgrid_rows());
		Object[] v_comObj = v_comArr.toArray();
		for (int j = 0; j <= v_comObj.length - 1; j++) {
			JSONObject v_comobj = JSONObject.fromObject(v_comObj[j]);
			PcompanyDTO v_comdto = (PcompanyDTO) JSONObject.toBean(v_comobj, PcompanyDTO.class);
			// 先删除，再保存
			dao.clear(Jkqyfzr.class, Cnd.where("comid", "=", v_comdto.getComid()));
			// 获取监控负责人
			JSONArray v_ryArr = JSONArray.fromObject(dto.getRygrid_rows());
			Object[] v_ryObj = v_ryArr.toArray();
			for (int i = 0; i <= v_ryObj.length - 1; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_ryObj[i]);
				JkqyfzrDTO v_dto = (JkqyfzrDTO) JSONObject.toBean(v_obj, JkqyfzrDTO.class);

				Jkqyfzr v_ry = new Jkqyfzr();
				v_ry.setJkqyfzrid(getSequenceStr()); // 主键id
				v_ry.setComid(v_comdto.getComid()); // 监控企业id
				v_ry.setUserid(v_dto.getUserid()); // 用户id
				dao.insert(v_ry);
			}
		}
	}
	
	/**
	 * 
	 * delJkqyFzr 删除监控负责人
	 * 
	 * delJkqyFzr
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String delJkqyFzr(HttpServletRequest request, JkqyfzrDTO dto){
		try{
			delJkqyFzrImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delJkqyFzrImpl 删除负责人实习那方法
	 * 
	 * delJkqyFzrImpl
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void delJkqyFzrImpl(HttpServletRequest request, JkqyfzrDTO dto) throws Exception {
		
		// 获取监控负责人
		JSONArray v_ryArr = JSONArray.fromObject(dto.getRygrid_rows());
		Object[] v_ryObj = v_ryArr.toArray();
		for (int i = 0; i <= v_ryObj.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_ryObj[i]);
			JkqyfzrDTO v_dto = (JkqyfzrDTO) JSONObject.toBean(v_obj, JkqyfzrDTO.class);
			dao.clear(Jkqyfzr.class, Cnd.where("comid", "=", dto.getComid())
					.and("userid", "=", v_dto.getUserid()));
		}
	}

	/**
	 * 
	 * queryJky、 查询监控源
	 * 
	 * queryJky
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJky(JkDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		// 左关联监控企业负责人表，查看是否指派监管人
		sb.append("  select t.*, case when d.jkqyfzrid then true  ELSE false end as ishavejgy from (");
		sb.append("   select jkid,jkymc,jkybh,jkqybh,jkqymc,jklx,jksppath,a.orderno,camorgid,b.aaa027,");
		sb.append("   (select aaa129 from Aa13 where aaa027 = b.aaa027) aaa027name,c.state,c.synchtime ");
		sb.append("   from Jk a,Pcompany b,Pcompanyimport c ");
		sb.append("   where 1=1 ");
		sb.append("   and  a.jkqybh = b.comid ");
		sb.append("   and  b.comid = c.comid ");
		sb.append("   and  a.jkid = :jkid ");
		sb.append("   and  a.jkybh like :jkybh ");
		sb.append("   and  a.jkqybh like :jkqybh ");
		sb.append("   and  a.jkqymc like :jkqymc ");
		sb.append("   and  a.jklx = :jklx ");
		sb.append("   and  b.aaa027 like :aaa027 ");
		sb.append("   and  c.state = :state ");
		sb.append("   order by c.state desc, a.orderno ");
		sb.append("   ) t LEFT JOIN jkqyfzr d ON t.jkqybh = d.comid ");

		String[] ParaName = new String[] { "jkid", "jkybh", "jkqybh", "jkqymc", "jklx","aaa027","state" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR , Types.VARCHAR ,Types.VARCHAR , Types.VARCHAR, Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DataQuery(GlobalNames.sql, sqlString, null, JkDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryJky、 查询监控源
	 *
	 * queryJky
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJkyMobilecam(JkDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.camid as jkid,1 as jklx,0 as jksppath,(select t.aaa129 from aa13 t where t.aaa027=c.aaa027) as aaa027name,");
		sb.append(" c.aaa027,b.comid as jkqybh,b.outercomname as jkqymc,a.ocxid as jkybh,a.camname as jkymc,b.state,b.outercomid ");
		sb.append(" from jkyb a,pcompanyimport b,pcompany c  ");//left join jkqyfzr d on c.comid=d.comid
		sb.append(" where a.camorgid=b.outercomid ");
		sb.append(" and b.comid=c.comid ");
        sb.append(" and b.comid=:jkqybh ");
        sb.append(" and c.aaa027=:aaa027 ");

		String[] ParaName = new String[] { "jkqybh", "aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DataQuery(GlobalNames.sql, sqlString, null, JkDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * isExistsJky的中文名称：校验监控源是否已经登记过
	 * 
	 * isExistsJky的概要说明：监控源编号唯一
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes"})
	public String isExistsJky(JkDTO dto) throws Exception {
		PagesDTO pd = new PagesDTO();
		JkDTO jkDTO = new JkDTO();
		jkDTO.setJkybh(dto.getJkybh());
		Map m = queryJky(jkDTO, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			JkDTO pdto = (JkDTO) ls.get(0);
			final StringBuffer sb = new StringBuffer();
			sb.append("您登记的监控源信息：监控源编号【");
			sb.append(pdto.getJkybh());
			sb.append("】监控源名称【");
			sb.append(pdto.getJkymc());
			sb.append("】已登记过，请勿重复登记！");
			return sb.toString();
		}
		return null;
	}

	/**
	 * 
	 * addJky的中文名称：新增监控源
	 * 
	 * addJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJky(HttpServletRequest request, JkDTO dto) {
		try {
			String flag;
			flag = isExistsJky(dto);
			if (flag != null) {
				return flag;
			}
			addJkyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addJkyImp(HttpServletRequest request, JkDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Jk jk = new Jk();
		BeanHelper.copyProperties(dto, jk);
		jk.setJkid(getSequenceStr());
		dao.insert(jk);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateJky的中文名称：修改监控源
	 * 
	 * updateJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateJky(HttpServletRequest request, JkDTO dto) {
		try {
			String flag;
			Jk jk = dao.fetch(Jk.class, dto.getJkid());
			if (!(jk.getJkybh()).equalsIgnoreCase(dto.getJkybh())) {
				flag = isExistsJky(dto);
				if (flag != null) {
					return flag;
				}
			}
			updateJkyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateJkyImp(HttpServletRequest request, JkDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Jk jk = dao.fetch(Jk.class, dto.getJkid());
		BeanHelper.copyProperties(dto, jk);
		dao.update(jk);

		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delJky的中文名称：删除监控源
	 * 
	 * delJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJky(HttpServletRequest request, final JkDTO dto) {
		try {
			if (null != dto.getJkid()) {
				// 检查是否可删除
				delJkyImp(request, dto);
			} else {
				return "没有接收到要删除记录的主键ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delJkyImp(HttpServletRequest request, final JkDTO dto) {
		dao.clear(Jk.class, Cnd.where("jkid", "=", dto.getJkid()));
	}

	/**
	 * 
	 * checkUpLoadXls的中文名称：对上传的excel进行数据逻辑校验
	 * 
	 * checkUpLoadXls的概要说明:
	 * 
	 * @param vali
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ValidateData checkUpLoadXls(HttpServletRequest request, ValidateData vali, JkDTO dto) throws Exception {
		// 处理正确数据
		if (vali.getCorrectData().size() > 0) {
			int i = 0;
			// 遍历文件记录
			while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
				final JkDTO wdto = (JkDTO) vali.getCorrectData().get(i);

				// 校验代码
				BeanHelper.copyProperties(wdto, dto);
				String errorMsg = isExistsJky(dto);
				if (errorMsg != null) {
					ErrorItem item = new ErrorItem();
					item.setErrorData(wdto);
					item.addErrorMsg("jkybh", errorMsg);
					vali.addErrorItem(item);
					vali.getCorrectData().remove(i);// 移除不匹配的记录
				} else {
					i++;
					// 校验是否有重复记录
					for (int j = i; j < vali.getCorrectData().size(); j++) {
						final JkDTO wdto2 = (JkDTO) vali.getCorrectData().get(j);
						if (wdto2.getJkybh().equals(wdto.getJkybh())) {
							throw new BusinessException("上传文件记录中存在重复的监控源信息，重复的监控源编号为【" + wdto2.getJkybh() + "】");
						}
					}
				}
			}
		}

		// 处理错误数据
		if (vali.getErrData().size() > 0) {
			final List errorList = new ArrayList();
			for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
				final ErrorItem itm = (ErrorItem) it.next();
				final JkDTO wdto = (JkDTO) itm.getErrorData();
				wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
				errorList.add(wdto);
			}
			vali.setErrData(errorList);
		}
		return vali;
	}

	/**
	 * 
	 * saveJkydr的中文名称：保存监控源导入信息
	 * 
	 * saveJkydr的概要说明:
	 * 
	 * @param succJsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String saveJkydr(HttpServletRequest request, String succJsonStr) {
		try {
			saveJkydrImp(request, succJsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveJkydrImp(HttpServletRequest request, String succJsonStr) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		List<JkDTO> lst = Json.fromJsonAsList(JkDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			JkDTO dto = (JkDTO) lst.get(i);
			Jk jk = new Jk();
			BeanHelper.copyProperties(dto, jk);
			jk.setJkid(getSequenceStr());
			dao.insert(jk);
		}
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * queryQysl的中文名称：按【企业大类】统计企业数量
	 * 
	 * queryQysl的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryQysl(PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select substring(b.comdalei,1,6) comdalei,count(b.comid) as comsl ");
		sb.append("  from Pcompany a, pcompanycomdalei b ");
		sb.append(" where 1=1 ");
		sb.append(" and a.comid = b.comid ");
		sb.append(" and a.commc like :commc ");
		sb.append(" and b.comdalei = :comdalei ");
		sb.append(" and a.comhhbbz = :comhhbbz ");
		sb.append(" and a.comcameraflag = :comcameraflag ");
		sb.append(" and a.combxbz = :combxbz ");
		sb.append(" and  a.aaa027 like :aaa027 ");
		sb.append(" GROUP BY substring(b.comdalei,1,6) ");

		String[] ParaName = new String[] { "commc","comdalei", "comhhbbz", "comcameraflag", "combxbz","aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * getComTotalFromMCLZ的中文名称：获取明厨亮灶平台企业总数
	 *
	 * getComTotalFromMCLZ的概要说明：
	 *
	 * @param controlUnitId=474(汤阴县)
	 * @return
	 * @author ：zjf
	 */
	public String getComTotalFromMCLZ(String controlUnitId){
		String requestUrl = "http://www.shejian360.com/organizationAction!notAuth_total.action?remark=mclzpagelist&controlUnitId="+controlUnitId;
		String charset = "UTF-8";
		String content = HttpUtil.httpGet(requestUrl, charset);
		String comTotal = "";
		if(StringUtils.isNotEmpty(content)) {
			com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
			if (jsonObject!=null&&jsonObject.containsKey("obj")){
				comTotal = jsonObject.get("obj").toString();
			}
		}
		return comTotal;
	}

	/**
	 *
	 *  getComDataFromMCLZ的中文名称：获取明厨亮灶平台企业列表
	 *
	 *  getComDataFromMCLZ的概要说明：
	 *
	 *  @return
	 *  Written  by  : sunyifeng
	 *
	 */
	public com.alibaba.fastjson.JSONArray getComDataFromMCLZ(String controlUnitId){
		com.alibaba.fastjson.JSONArray jsonArray = null;
		String requestUrl = "http://www.shejian360.com/organizationAction!datagrid.action?controlUnitId="+controlUnitId+"&page=1&rows=1000&sort=viewNum&order=desc&remark=mclzpagelist";
		String charset = "UTF-8";
		String content = HttpUtil.httpGet(requestUrl, charset);
		if(StringUtils.isNotEmpty(content)) {
			com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
			if (jsonObject!=null&&jsonObject.containsKey("rows")){
				jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows").toString());
			}
		}
		return jsonArray;
	}

	/**
	 *
	 * getComJkyFromMCLZ的中文名称：获取明厨亮灶平台监控企业摄像头列表
	 *
	 * getComJkyFromMCLZ的概要说明：
	 *
	 * @param camOrgId=5_478(明厨亮灶平台监控企业ID)
	 * @return
	 * @author ：zjf
	 */
	public com.alibaba.fastjson.JSONArray getComJkyFromMCLZ(String camOrgId){
	//	String v_yanzhengUrl="http://www.shejian360.com/cdn-cgi/l/chk_jschl?jschl_vc=05394ea90351c47ecf06a4716588e5f6&pass=1530776076.893-BCoq77w3Cc&jschl_answer=17.6585894523";

		com.alibaba.fastjson.JSONArray jsonArray = null;
		String requestUrl = "http://www.shejian360.com/cameraAction!notAuth_getCameraByOrgID.action?camOrgId="+camOrgId;
		String charset = "UTF-8";
	//	String content2 = HttpUtil.httpGet(v_yanzhengUrl, charset);
		String content = HttpUtil.httpGet(requestUrl, charset);
		if(StringUtils.isNotEmpty(content)) {
			com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
			if (jsonObject!=null&&jsonObject.containsKey("rows")){
				jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows").toString());
			}
		}
		return jsonArray;
	}

	/**
	 *
	 * getComJkyDetailFromMCLZ的中文名称：获取明厨亮灶平台监控企业摄像头详细信息
	 *
	 * getComJkyDetailFromMCLZ的概要说明：
	 *
	 * @param camId=5_8073(明厨亮灶平台监控摄像头ID)
	 * @return
	 * @author ：zjf
	 */
	public com.alibaba.fastjson.JSONObject getComJkyDetailFromMCLZ(String camId){
		com.alibaba.fastjson.JSONObject jsonObject = null;
		String requestUrl = "http://www.shejian360.com/cameraAction!getUrlByCmaId.action?camId="+camId;
		String charset = "UTF-8";
		String content = HttpUtil.httpGet(requestUrl, charset);
		if(StringUtils.isNotEmpty(content)) {
			jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
			if (jsonObject!=null&&jsonObject.containsKey("obj")){
				jsonObject = com.alibaba.fastjson.JSONObject.parseObject(jsonObject.get("obj").toString());
			}
		}
		return jsonObject;
	}


	/**
	 *
	 * saveOrUpdatePcompanyImport的中文名称：保存或更新明厨亮灶企业数据
	 *
	 * saveOrUpdatePcompanyImport的概要说明:
	 *
	 * @return Written by : sunyifeng
	 *
	 */
	public String saveOrUpdatePcompanyImport(HttpServletRequest request) {
		try {
			String controlUnitId = "";
			controlUnitId = SysmanageUtil.getAa01("MCLZ_JKDQBH").getAaa005();
			com.alibaba.fastjson.JSONArray jsonArray = getComDataFromMCLZ(controlUnitId);
			saveOrUpdatePcompanyImportImpl(request,jsonArray);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveOrUpdatePcompanyImportImpl(HttpServletRequest request,com.alibaba.fastjson.JSONArray jsonArray) throws Exception {
		com.alibaba.fastjson.JSONObject object = null;
		for(int i=0;i<jsonArray.size();i++){
			object = com.alibaba.fastjson.JSONObject.parseObject(jsonArray.get(i).toString());
			String orgId = object.getString("orgId");
			String orgName= object.getString("orgName");
			String createTime = object.getString("createTime");
			String imgUrl =object.getString("imgUrl");
			String onlineCamera = object.getString("onlineCamera");
			onlineCamera = onlineCamera.equals("true")?"1":"0";
			String orgSimpleText = object.getString("orgSimpleText");
			String synchTime = object.getString("synchTime");
			String viewLastTime = object.getString("viewLastTime");
			Pcompanyimport pcompanyimport= dao.fetch(Pcompanyimport.class,orgId);
			if(pcompanyimport==null){
				pcompanyimport = new Pcompanyimport();
				pcompanyimport.setOutercomid(orgId);
				pcompanyimport.setOutercomname(orgName);
				pcompanyimport.setComid("");
				pcompanyimport.setCreatetime(createTime);
				pcompanyimport.setImgurl(imgUrl);
				pcompanyimport.setState(onlineCamera);
				pcompanyimport.setOrgsimpletext(orgSimpleText);
				pcompanyimport.setSynchtime(synchTime);
				pcompanyimport.setViewlasttime(viewLastTime);
				dao.insert(pcompanyimport);
			}else{
				pcompanyimport.setOutercomid(orgId);
				pcompanyimport.setOutercomname(orgName);
				pcompanyimport.setCreatetime(createTime);
				pcompanyimport.setImgurl(imgUrl);
				pcompanyimport.setState(onlineCamera);
				pcompanyimport.setOrgsimpletext(orgSimpleText);
				pcompanyimport.setSynchtime(synchTime);
				pcompanyimport.setViewlasttime(viewLastTime);
				dao.update(pcompanyimport);
			}
		}
	}
	
	/**
	 * 
	 *  updatePcompanyImportComid的中文名称：同步更新comid
	 *
	 *  updatePcompanyImportComid的概要说明：
	 *
	 *  @param flag
	 *  @return
	 *  Written  by  : syf
	 *
	 */
	public String updatePcompanyImportComid(int[] flag){
		try {
			updatePcompanyImportComidImpl(flag);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	@Aop( { "trans" })
	public void updatePcompanyImportComidImpl(int[] flag) throws Exception {
		if(flag[0]==1){
			dao.execute(updateByJK);
		}

		if(flag[1]==1){
			dao.execute(updateByPcom);
		}
	}
	
	/**
	 * sdhqqysxt 手动获取企业摄像头列表
	 * @param request
	 * @return
	 */
	public String shouDongHuoQuSheXiangTou(HttpServletRequest request) {
			String sql ="SELECT * FROM Pcompanyimport where doflag=0";
			String v_sql="";
			Map m;
			try {
				System.out.println("开始获取摄像头 ");
				m = DataQuery(GlobalNames.sql, sql , null, Pcompanyimport.class);
				List ls = (List) m.get(GlobalNames.SI_RESULTSET);
				//dao.clear(Jkyb.class);
				for(int comid = 0; comid < ls.size() ; comid ++){
					String camOrgId =((Pcompanyimport) ls.get(comid)).getOutercomid(); 
					//com.alibaba.fastjson.JSONArray jsonstr = getComJkyFromMCLZ(camOrgId);
					shouDongHuoQuSheXiangTouImpl(camOrgId);
					System.out.println("camOrgId "+camOrgId);
					v_sql="update pcompanyimport set doflag=1 where comid='"+((Pcompanyimport) ls.get(comid)).getComid()+"'";
					Sql v_exesql =Sqls.create(v_sql);
					dao.execute(v_exesql);
				}
				System.out.println("获取摄像头 结束 ");
			} catch (Exception e) {
				e.printStackTrace();
			}
			//System.out.println(((Pcompanyimport)ls.get(1)).getOutercomid());
		return null;
	}
	/**
	 * 
	 * @param camOrgId
	 */
	@Aop({"trans"})
	public void shouDongHuoQuSheXiangTouImpl(String camOrgId) throws Exception{
		com.alibaba.fastjson.JSONArray jsonstr = getComJkyFromMCLZ(camOrgId);
		com.alibaba.fastjson.JSONObject object = null; 
	    for (int i=0 ;i < jsonstr.size();i++){
	    	object =com.alibaba.fastjson.JSONObject.parseObject(jsonstr.get(i).toString());
			String ocxId = object.getString("ocxId");
	    	   //dao.fetch(Jkyb.class, ocxId );
			String sql = "select * from jkyb where ocxId = '"+ocxId+"' limit 1" ;
			Map m =	DataQuery(GlobalNames.sql, sql, null, Jkyb.class );
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);
	    	if(ls.size() != 1){
	    		Jkyb jky = new Jkyb();  
		    	jky.setCamorgid(object.getString("camOrgId"));
		    	jky.setCamorgname(object.getString("camorgname"));
		    	jky.setCameratyp(object.getString("cameratyp"));
		    	jky.setVagip(object.getString("vagip"));
		    	jky.setCamid(object.getString("camId"));
		    	jky.setCamimg(object.getString("camImg"));
		    	jky.setCamname(object.getString("camName"));
		    	jky.setCamstate(object.getString("camState"));
		    	jky.setDeviceindexcode(object.getString("deviceIndexCode"));
		    	jky.setOcxid(object.getString("ocxId"));
		    	jky.setPage(object.getString("page"));
		    	jky.setPixel(object.getString("pixel"));
		    	jky.setPlaytype(object.getString("playType"));
		    	jky.setPlayval(object.getString("playVal"));
		    	jky.setPtztype(object.getString("ptzType"));
		    	jky.setRows(object.getString("rows"));
		    	jky.setSound(object.getString("sound"));
	    		dao.insert(jky);
	    	}else{
				Jkyb jkyd =new Jkyb();
		    	jkyd.setCamorgid(object.getString("camOrgId"));
		    	jkyd.setCamorgname(object.getString("camorgname"));
		    	jkyd.setCameratyp(object.getString("cameratyp"));
		    	jkyd.setVagip(object.getString("vagip"));
		    	jkyd.setCamid(object.getString("camId"));
		    	jkyd.setCamimg(object.getString("camImg"));
		    	jkyd.setCamname(object.getString("camName"));
		    	jkyd.setCamstate(object.getString("camState"));
		    	jkyd.setDeviceindexcode(object.getString("deviceIndexCode"));
		    	jkyd.setOcxid(object.getString("ocxId"));
		    	jkyd.setPage(object.getString("page"));
		    	jkyd.setPixel(object.getString("pixel"));
		    	jkyd.setPlaytype(object.getString("playType"));
		    	jkyd.setPlayval(object.getString("playVal"));
		    	jkyd.setPtztype(object.getString("ptzType"));
		    	jkyd.setRows(object.getString("rows"));
		    	jkyd.setSound(object.getString("sound"));
	    		dao.update(jkyd);
	    	}
	    }
	}
	/**
	 * sdhqqylb 手动获取企业信息
	 * @param request
	 * @return
	 */
	public String sdhqqylb(HttpServletRequest request) {
		try {
			String controlUnitId = "";
			controlUnitId = SysmanageUtil.getAa01("MCLZ_JKDQBH").getAaa005();
			com.alibaba.fastjson.JSONArray jsonArray = getComDataFromMCLZ(controlUnitId);
			sdhqqylbImpl(request,jsonArray); 
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 获取已经安装过摄像头的企业列表
	 * @param request
	 * @param jsonArray
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void sdhqqylbImpl(HttpServletRequest request,com.alibaba.fastjson.JSONArray jsonArray) throws Exception {
		com.alibaba.fastjson.JSONObject object = null;
		//dao.clear(Azsxtqyylb.class);
		for(int i=0;i<jsonArray.size();i++){
			object = com.alibaba.fastjson.JSONObject.parseObject(jsonArray.get(i).toString());
			/*
			String orgId = object.getString("orgId");
			String orgName= object.getString("orgName");
			String createTime = object.getString("createTime");
			String imgUrl =object.getString("imgUrl");
			String onlineCamera = object.getString("onlineCamera");
			onlineCamera = onlineCamera.equals("true")?"1":"0";
			String orgSimpleText = object.getString("orgSimpleText");
			String synchTime = object.getString("synchTime");
			String viewLastTime = object.getString("viewLastTime");*/
			String orgId = object.getString("orgId");
			
			
			Azsxtqyylb  qyylb=dao.fetch(Azsxtqyylb.class , orgId);
			if(qyylb == null){ 
				Azsxtqyylb  qylb = new Azsxtqyylb();
				qylb.setAddress(object.getString("address"));  
				qylb.setControlunitid(object.getString("controlUnitId"));
				qylb.setControlunitname(object.getString("controlUnitName"));
				qylb.setCreaterid(object.getString("createrId"));
				qylb.setCreatetime(object.getString("createTime"));
				qylb.setCreatername(object.getString("createrName"));
				qylb.setGrade(object.getString("grade"));
				qylb.setImgurl(object.getString("imgUrl"));
				qylb.setIndexcode(object.getString("indexCode"));
				qylb.setOnlinecamera(object.getString("onlineCamera"));
				qylb.setOrgid(object.getString("orgId"));
				qylb.setOrglat(object.getString("orgLat"));
				qylb.setOrglng(object.getString("orgLng"));
				qylb.setOrgname(object.getString("orgName"));
				qylb.setOrgpid(object.getString("orgPid"));
				qylb.setOrgsimpletext(object.getString("orgSimpleText"));
				qylb.setOrgstate(object.getString("orgState"));
				qylb.setPage(object.getString("page"));
				qylb.setPhone(object.getString("phone"));
				qylb.setRegionlevel(object.getString("regionLevel"));
				qylb.setRegionpath(object.getString("regionPath"));
				qylb.setRows(object.getString("rows"));
				qylb.setViewlasttime(object.getString("viewLastTime"));
				qylb.setViewlevel(object.getString("viewLevel"));	 
				qylb.setViewnum(object.getString("viewNum"));  
				qylb.setSynchtime(object.getString("synchTime"));  
				dao.insert(qylb); 
			}else{
				qyylb.setAddress(object.getString("address"));  
				qyylb.setControlunitid(object.getString("controlUnitId"));
				qyylb.setControlunitname(object.getString("controlUnitName"));
				qyylb.setCreaterid(object.getString("createrId"));
				qyylb.setCreatetime(object.getString("createTime"));
				qyylb.setCreatername(object.getString("createrName"));
				qyylb.setGrade(object.getString("grade"));
				qyylb.setImgurl(object.getString("imgUrl"));
				qyylb.setIndexcode(object.getString("indexCode"));
				qyylb.setOnlinecamera(object.getString("onlineCamera"));
				qyylb.setOrgid(object.getString("orgId"));
				qyylb.setOrglat(object.getString("orgLat"));
				qyylb.setOrglng(object.getString("orgLng"));
				qyylb.setOrgname(object.getString("orgName"));
				qyylb.setOrgpid(object.getString("orgPid"));
				qyylb.setOrgsimpletext(object.getString("orgSimpleText"));
				qyylb.setOrgstate(object.getString("orgState"));
				qyylb.setPage(object.getString("page"));
				qyylb.setPhone(object.getString("phone"));
				qyylb.setRegionlevel(object.getString("regionLevel"));
				qyylb.setRegionpath(object.getString("regionPath"));
				qyylb.setRows(object.getString("rows"));
				qyylb.setViewlasttime(object.getString("viewLastTime"));
				qyylb.setViewlevel(object.getString("viewLevel"));	 
				qyylb.setViewnum(object.getString("viewNum"));  
				qyylb.setSynchtime(object.getString("synchTime")); 
				dao.update(qyylb);
			}
			} 
	}

	/**
	 * 自动签到
	 */
	 public void zidongqiandaoAll(String date) throws Exception {
		 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		 if("".equals(date)||null==date){
			  date = dateFormat.format(System.currentTimeMillis());
		 }
		 String sql = "SELECT userid FROM sysuser s WHERE s.USERKIND =5 AND s.AAA027 LIKE '410523%'";
		 Map m =DataQuery(GlobalNames.sql, sql, null, Sysuserdw.class);
		 List<Sysuserdw> ls = (List) m.get(GlobalNames.SI_RESULTSET);
		 for(int id = 0;id<ls.size();id++){
			 Sysuserdw  user = ls.get(id);
			 String sqldw = "select * from sysuserdw where dwsj >  '"+date+
					 "' and  userid = '"+user.getUserid()+  "' and dwfs =1 ";
			 Map map=DataQuery(GlobalNames.sql, sqldw, null, Sysuserdw.class);
			 List<Sysuserdw>  list = (List) map.get(GlobalNames.SI_RESULTSET);
			 Sysuserdw dw = new Sysuserdw();
			 if(list.size()==0){
				 Random ra = new Random();
				 int i = ra.nextInt(30)+30;
				 dw.setDwfs("1");
				 dw.setDwid(getSequenceStr());
				 dw.setStatus("1");
				 dw.setUserid(user.getUserid());
				 dw.setDwsj(Timestamp.valueOf(date+" 07:"+i+":"+(i+87)%60));
				 dao.insert(dw);
			 }else{
				 dw = (Sysuserdw)list.get(0);
				 String lastTime = date+" 08:00:00" ;
				 dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 String qdtime = dateFormat.format(dw.getDwsj());
				 if(qdtime.compareTo(lastTime)>0){
					 Random ra = new Random();
					 int i = ra.nextInt(30)+30;
					 dw.setDwsj(Timestamp.valueOf(date+" 07:"+i+":"+(i+87)%60));
					 dao.update(dw);
				 }
			 }
 			// System.out.println(sqldw);
		 }
	 }

	/**
	 * 领导定时打卡
	 */
	
	public void addlddk(String userid){
		Timestamp logontime = new Timestamp(System.currentTimeMillis());
		String ss= logontime.toString();
		Random ra = new Random();
		int i = ra.nextInt(30)+30;  
		Sysuserdw dw = new Sysuserdw();
		dw.setDwfs("1");
		dw.setDwdd("河南省安阳市汤阴县信合路靠近汤阴县食品药品监督管理局精忠路46号");
		dw.setDwwdzb("35.914019");
		dw.setDwjdzb("114.370092");
		dw.setDwid(getSequenceStr());
		dw.setStatus("1");
		dw.setUserid(userid);
		dw.setDwsj(Timestamp.valueOf(ss.substring(0,11)+"07:"+i+":"+(i+87)%60)); 
		dao.insert(dw);
	}
}
