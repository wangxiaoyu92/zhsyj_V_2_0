package com.askj.supervision.service;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.askj.baseinfo.dto.OmcheckgroupDTO;
import com.askj.baseinfo.dto.PcheckfregDTO;
import com.askj.baseinfo.entity.Omcheckgroup;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.supervision.dto.*;
import com.askj.supervision.entity.*;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.util.StringUtils;
import com.opensymphony.oscache.util.StringUtil;
import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.utils.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;

import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pdbsx;
import com.askj.baseinfo.entity.Pdbsxjsr;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import com.zzhdsoft.utils.push.JPushAllUtil;

public class CheckPlanService extends BaseService{

protected final Logger logger = Logger.getLogger(CheckPlanService.class);

	@Inject
	private Dao dao;
	@Inject
	private CheckInfoService checkInfoService;
	/**
	 * 添加信息
	 *
	 */
	public String savePlan(HttpServletRequest request,final BscheckplanDTO dto){
		try{
			savePalnImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存信息的实现方法
	 * 使用事务控制
	 * param request
	 * param dto
	 * throws Exception
	 */
	@Aop({"trans"})
	public void savePalnImpl(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		 dto.setPlanoperator(vSysUser.getUserid().toString());
		//首先判断用户是更新还是添加操作
				if(null != dto.getPlanid()&&!"".equals(dto.getPlanid())){//更新，通过id找到本条数据而后跟新
					Bscheckplan plan = new Bscheckplan();
					BeanHelper.copyProperties(dto, plan);
					dao.update(plan);
				}else{
					String planid = DbUtils.getSequenceStr();
					String v_dbtime=SysmanageUtil.getDbtimeYmd();
					Bscheckplan plan = new Bscheckplan();
					BeanHelper.copyProperties(dto, plan);  //拷贝对应的从前台传来的数据
					plan.setPlanid(planid);
					plan.setPlanoperatedate(v_dbtime);
					dao.insert(plan);
				}
	}

	/**
	 * 审核信息修改 未用到
	 *
	 */
	public String saveCheckPlan(HttpServletRequest request,BscheckplanDTO dto ){
		try{
			saveCheckPlanImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存信息的实现方法
	 * 使用事务控制
	 * param request
	 * param dto
	 * throws Exception
	 */
	@Aop({"trans"})
	public void saveCheckPlanImpl(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
//		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
//		Bscheckplan plan = dao.fetch(Bscheckplan.class,dto.getPlanid());
		dto.getCheckitem();//审核标识
        //修改
//		dao.update(plan);
	};

	/**
	 * 查询出所有的计划信息，并分页显示
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPlan(HttpServletRequest request,BscheckplanDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		String v_querytype="no";
		if (StringUtils.isNotEmpty(dto.getQuerytype())){
			v_querytype=dto.getQuerytype();
		}
		//企业检查 通过企业大类筛选检查计划
		Aa10 aa10=null;
		if(dto.getComdalei()!=null&&!"".equals(dto.getComdalei())&&!"undefined".equals(dto.getComdalei())){
			aa10 = dao.fetch(Aa10.class, Cnd.where("AAA100", "=", "COMDALEI").and("AAA102", "=", dto.getComdalei()));
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		Date date = new Date();
		String year= sdf.format(date);
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.*,(select count(*) from bscheckmaster t where t.planid=b.planid and t.resultstate<>'4') as plancheckingcount from bscheckplan b");
		sb.append(" where 1=1 ");
		sb.append(" and b.planid = :planid ");
		sb.append(" and b.plantype = :plantype ");
		sb.append(" and b.plantitle like :plantitle ");
		sb.append(" and b.planstdate >= :planstdate ");
		sb.append(" and b.planstdate <= :planeddate ");

		if ("no".equals(v_querytype)) {
			sb.append(" and b.lhfjndpddj in (SELECT t.lhfjndpddj FROM Pcompanynddtpj t");
			sb.append(" WHERE  t.pdyear ='" + year + "'");
			if (dto.getComid() != null && !"".equals(dto.getComid())) {
				sb.append(" AND  t.comid=:comid ) ");
			}
			sb.append(") ");
		}

//		sb.append(" and b.lhfjndpddj in (SELECT t.lhfjndpddj FROM Pcompanynddtpj t");
//		sb.append(" WHERE  t.pdyear ='"+year+"'");
//		if(dto.getComid()!=null && !"".equals(dto.getComid())){
//			sb.append(" AND  t.comid=:comid  ");
//		}

		if(aa10!=null){
			sb.append(" and b.plantypearea like '%"+aa10.getAaz093()+"%'");
		}
		//gu20180502add 如果
        if (vSysUser!=null && StringUtils.isNotEmpty(vSysUser.getUserid())&&!"0".equals(vSysUser.getUserid())){
        	sb.append(" and b.plancontrol<>'1' ");
		}
		sb.append(" order by planid desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "planid","plantype","plantitle","planstdate","planeddate","comid"};
		int[] paramType = new int[]{ Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckplanDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}


	/**
	 * 查询出所有的计划信息，
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryOnePlan(HttpServletRequest request, CheckGroup dto) throws Exception {
//		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		//sb.append(" select b.*,(select GROUP_CONCAT(t.basetype)  from ombasetype t where t.itemtype=b.itemid) as plantypearea from omcheckgroup b");
		sb.append(" select b.*, ");
		sb.append( "(select GROUP_CONCAT(t2.aaz093) from ombasetype t,viewcomfenlei t2 where t.basetype=t2.aaz093  and t.itemtype=b.itemid) as plantypearea,");
		sb.append( "(select GROUP_CONCAT(t2.aaa103)  from ombasetype t,viewcomfenlei t2 where t.basetype=t2.aaz093  and t.itemtype=b.itemid) as plantypeareadesc ");
		sb.append(" from omcheckgroup b ");
		sb.append(" where 1=1 ");
		sb.append(" and b.itempid = :itempid ");
		sb.append(" and b.itemtype = :itemtype ");//gu20180328
		sb.append(" order by itempid desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "itempid","itemtype"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, CheckGroup.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		return map;
	}

	/**
	 * 删除计划信息，根据id删除
	 */
	public String delPlan(HttpServletRequest request,final BscheckplanDTO dto){
		try {
			delPlanImpl(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除企业信息，实现类
	 * 交给事务管理
	 * param request
	 * param comid
	 */
	@Aop({"trans"})
	public void delPlanImpl(HttpServletRequest request, BscheckplanDTO dto) {
			if(!(dto.getPlanid() == null || "".equals(dto.getPlanid()))){
				//删除企业信息
				dao.clear(Bscheckplan.class,Cnd.where("planid", "=", dto.getPlanid()));
				//删除执行范围
//				dao.clear(Sysuser.class,Cnd.where("username", "=", dto.getUsername()));
			}
	}


	/**
	 * 查询出所有的计划信息，并分页显示
	 * param dto 检查项计划dto
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryItemPlans(HttpServletRequest request, BscheckItemplanDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select g.itempid , g.itemid,g.itemname,c.contentid, c.content");
		sb.append("  from omcheckcontent c ,omcheckgroup  g ");
		sb.append(" where c.itemid =g.itemid ");
		sb.append(" and g.itempid = :itempid ");
		sb.append(" order by g.itemsortid,c.contentsortid ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "itempid"};
		int[] paramType = new int[]{ Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckItemplanDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 添加信息
	 *
	 */
	public String savePicset(HttpServletRequest request,final BscheckpicsetDTO dto){
		try{
			savePicsetImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存信息的实现方法
	 * 使用事务控制
	 * param request
	 * param dto
	 * throws Exception
	 */
	@Aop({"trans"})
	public void savePicsetImpl(HttpServletRequest request, BscheckpicsetDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		 dto.setPicoperator(vSysUser.getUserid().toString());
		 int total = (Integer) getTotalPlanByid(request, dto).get("total");
		//首先判断用户是更新还是添加操作
//				if(null != dto.getPlanid()&&!"".equals(dto.getPlanid())){//更新，通过id找到本条数据而后跟新
//					Bscheckplan plan = new Bscheckplan();
//					BeanHelper.copyProperties(dto, plan);
//					dao.update(plan);
//				}else{picoperatedate
//		   List<Bscheckpicset> list = new ArrayList<Bscheckpicset>();
				if(total>0){
					//删除计划相关的执行项
					if(!(dto.getPlanid() == null || "".equals(dto.getPlanid()))){
//						Sql sql = Sql.class.newInstance();
//						sql.setSourceSql("DELETE FROM BSCHECKPICSET WHERE planid=");
//						dao.execute(sql);
						dao.clear(Bscheckpicset.class, Cnd.where("planid", "=", dto.getPlanid()));
					}
					//新增
					String v_dbtime=SysmanageUtil.getDbtimeYmd();
					String [] items = dto.getItems();
					if(items!=null&&!"".equals(items)){
					for(String item :items){
						Bscheckpicset picset = new Bscheckpicset();
						String picid = DbUtils.getSequenceStr();
						BeanHelper.copyProperties(dto, picset);  //拷贝对应的从前台传来的数据
						picset.setPicid(picid);
						picset.setPicoperatedate(v_dbtime);
						String[] obj = item.split("&");
						picset.setContentid(obj[0]);
						picset.setItemid(obj[1]);
						dao.insert(picset);
					}
					}
				}else {
					String v_dbtime=SysmanageUtil.getDbtimeYmd();
					String [] items = dto.getItems();
					if(items!=null&&!"".equals(items)){
					for(String item :items){
						Bscheckpicset picset = new Bscheckpicset();
						String picid = DbUtils.getSequenceStr();
						BeanHelper.copyProperties(dto, picset);  //拷贝对应的从前台传来的数据
						picset.setPicid(picid);
						picset.setPicoperatedate(v_dbtime);
						String[] obj = item.split("&");
						picset.setContentid(obj[0]);
						picset.setItemid(obj[1]);
						dao.insert(picset);
					}
					}
				}

        //gu20180325add
		BscheckplanDTO v_tempBscheckplanDTO=new BscheckplanDTO();
		v_tempBscheckplanDTO.setPlanid(dto.getPlanid());
		String v_planmobankind="";
        List<OmcheckgroupDTO> v_OmcheckgroupList=(List<OmcheckgroupDTO>)getOmcheckgroupByPlanid(request,v_tempBscheckplanDTO).get("data");
        if (v_OmcheckgroupList!=null && v_OmcheckgroupList.size()>0){
			v_planmobankind=v_OmcheckgroupList.get(0).getPlanmobankind();
		}
		String v_sql="update bscheckplan  set plantypearea='"+dto.getPlantypearea()+
				"',planmobankind='"+v_planmobankind+"'"+
				" where planid='"+dto.getPlanid()+"'";
		Sql sql = Sqls.create(v_sql);
		dao.execute(sql);
	}

	/**根据计划id获取对应的itemid
	 * gu 20180420
	 * */
	public Map getOmcheckgroupByPlanid(HttpServletRequest request,final BscheckplanDTO dto) throws Exception {
		if (StringUtil.isEmpty(dto.getPlanid())){
            throw new BusinessException("getOmcheckgroupByPlanid：planid为空了");
		}
		StringBuffer sb = new StringBuffer();
		sb.append("   select a.* from omcheckgroup a " +
						  "    where exists (select 1 from omcheckcontent b,omcheckgroup c,bscheckpicset d" +
						  "                    where b.itemid=c.itemid and b.contentid=d.contentid" +
						  "                    and d.planid='"+dto.getPlanid()+"'" +
						  "                    and a.itemid=c.itempid)");
		String sql = sb.toString();
		String[] paramName = new String[]{};
		int[] paramType = new int[]{};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OmcheckgroupDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}


	/**
	 * 修改执行项和计划信息
	 * param request
	 * param dto
	 * param itemDto
	 * return
	 */
	public String updateInfo(HttpServletRequest request,final BscheckplanDTO dto,final BscheckpicsetDTO itemDto){
		try{
			//计划信息
			savePalnImpl(request, dto);
			//执行项信息
			savePicsetImpl(request, itemDto);

		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 查询出所有的计划信息根据企业类别，(转移到sjbService手机端service方法)
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPlansByqyType(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ,( select d.resultstate  from bscheckmaster d where " );
		sb.append(" d.planid=a.planid ");
		sb.append(" and d.comid= :comid ");
		sb.append(" ) resultstate from bscheckplan a where a.planid in ");
		sb.append(" ( select DISTINCT b.planid from  bscheckpicset b ,omcheckgroup c  ");
		sb.append(" where b.itemid = c.itemid ");
		sb.append(" and c.itempid = :itemid  ");
		sb.append(" ) order by a.planid desc ");
		String sql = sb.toString();
		String[] paramName = new String[]{"comid","itemid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 查询出所有的计划信息根据企业类别和企业id，(转移到sjbService手机端service方法)
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPlansByqyTypeAndqyeId(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* from bscheckplan a where a.planid  in");
		sb.append(" (select b.planid from bscheckpicset b where b.itemid in");
		sb.append(" (select o.itemid from omcheckgroup o   ");
		sb.append(" where 1=1 ");
		sb.append(" and o.itempid = :itemid");
		sb.append(" ))order by a.planid desc ");
		String sql = sb.toString();
		String[] paramName = new String[]{"itemid"};
		int[] paramType = new int[]{ Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Bscheckplan.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 查询出所有的执行信息根据企业类别和计划id，(转移到sjbService手机端service方法)
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPlansByqyTypeAndid(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select g.*,h.detaildecide,h.detailscore  from (select c.itemid ,c.itemname, ");
		sb.append(" d.contentid,d.content,d.contentsortid from omcheckgroup c ,");
		sb.append(" ( select a.* from omcheckcontent a ,bscheckpicset b where a.contentid = b.contentid ");
		sb.append(" and b.planid= :planid 1=1) d where c.itemid = d.itemid    ");
		sb.append(" and c.itempid = :itemid  1=1 ) g  left join   ");
		sb.append(" (select f.contentid , f.detaildecide,f.detailscore from bscheckmaster e ,bscheckdetail f ");
		sb.append("where e.resultid = f.resultid and e.planid= :planid and e.comid= :comid and 1=1 ");
		sb.append(" ) h on g.contentid = h.contentid order by g.contentsortid");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"planid","itemid","planid","comid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 * 查询出所有的没有执行过的信息根据企业类别和计划id，(手机端service方法)
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryDetailByqyTypeAndid(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select c.itemid ,c.itemname ,d.contentid,d.content from omcheckgroup c , ");
		sb.append(" ( select a.* from omcheckcontent a ,bscheckpicset b where a.contentid = b.contentid ");
		sb.append(" and b.planid= :planid and b.contentid not in (select f.contentid from  ");
		sb.append(" bscheckmaster e ,bscheckdetail f where e.resultid = f.resultid and e.planid= :planid ");
		sb.append(" and e.comid=:comid  )) d where c.itemid = d.itemid   ");
		sb.append(" and c.itempid = :itemid");
		sb.append(" order by  d.contentsortid ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"planid","planid","comid","itemid"};
		int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 * 查询出所有的执行信息根据计划id，
	 * param planid  计划id
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryPlanByid(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select c.itempid ,c.itemid ,c.itemname ,d.contentid,d.content from omcheckgroup c , ");
		sb.append(" (select * from omcheckcontent a where a.contentid in ");
		sb.append(" (select b.contentid from bscheckpicset b   ");
		sb.append(" where 1=1 ");
		sb.append(" and b.planid = :planid");
		sb.append(")) d where c.itemid = d.itemid  ");
		sb.append(" order by c.itemid  ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"planid"};
		int[] paramType = new int[]{ Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 查询出所有的执行信息根据企业类别和计划id，
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getPlansAndpidnameByid(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select c.itempid ,e.itemname as itempidname, c.itemid ,c.itemname ,d.contentid,d.content,d.contentcode from omcheckgroup c , ");
		sb.append(" (select * from omcheckcontent a where a.contentid in ");
		sb.append(" (select b.contentid from bscheckpicset b   ");
		sb.append(" where 1=1 ");
		sb.append(" and b.planid = :planid");
		sb.append(")) d ,omcheckgroup e  where c.itemid = d.itemid  and e.itemid=c.itempid");
		sb.append(" order by c.itemid  ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"planid"};
		int[] paramType = new int[]{ Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckcontentAnditemDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 查询执行项对象，
	 * param itemid 执行项元素id
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryitemsByid(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
		//转化sql语句
		 CheckGroup ityem = dao.fetch(CheckGroup.class,dto.getItemid());
		Map map = new HashMap();
		map.put("data",ityem);
		return map;
	}

	/**
	 * 根据计划ID获取计划信息，
	 * param itemid 执行项元素id
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getPlanByid(HttpServletRequest request, BscheckplanDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
		//转化sql语句
		 Bscheckplan plan = dao.fetch(Bscheckplan.class,dto.getPlanid());
		Map map = new HashMap();
		map.put("data",plan);
		return map;
	}

	/**
	 * 查询出所有的执行信息根据企业类别和计划id，
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getTotalPlanByid(HttpServletRequest request, BscheckpicsetDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
		//转化sql语句
		int li_count= dao.count(Bscheckpicset.class, Cnd.where("planid", "=", dto.getPlanid()));
		Map map = new HashMap();
		map.put("total",li_count);
		return map;
	}

	/**
	 * 查询企业类别
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getqiyeType(HttpServletRequest request, String type) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.AAZ093 as id,a.AAA100 as type ,a.AAZ094 as typeid,");
		sb.append(" a.AAA102 as value,a.AAA103 as name from aa10 a ");
		sb.append(" where 1=1 ");
		if(type!=null && !"".equals(type)){
			sb.append(" and a.AAA100 = '").append(type).append("'");
			}
		String sql = sb.toString();
		//转化sql语句
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BSQyTypeDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("data", list);
		return map;
	}
	/**
	 * 查询出所有的执行信息根据企业类别和计划id，
	 * param dto企业实体类
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map checkCode(HttpServletRequest request, BscheckplanDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
		//转化sql语句
		int li_count= dao.count(Bscheckplan.class, Cnd.where("plancode", "=", dto.getPlancode().trim()));
		Map map = new HashMap();
		map.put("total",li_count);
		return map;
	}

	/**
	 * 根据检查计划查询分派任务
	 * param dto检查任务分派概要表
	 * param pd分页
	 * return
	 * throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryTaskList(HttpServletRequest request, BschecktaskDTO dto, PagesDTO pd) throws Exception {

		// 获取当前日期时间
		String currDate = SysmanageUtil.getDbtimeYmdHns();
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.* from bschecktask b");
		sb.append(" where 1=1 ");
		sb.append(" and b.planid = :planid ");
		sb.append(" and b.taskid = :taskid ");
		sb.append(" and b.tasktimeed >= '").append(currDate).append("' "); // 任务结束日期大于当前日期
		sb.append(" order by taskid desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "planid", "taskid" };
		int[] paramType = new int[]{ Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BschecktaskDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveTask的中文名称：保存任务
	 *
	 * saveTask的概要说明：
	 * param request
	 * param dto
	 * return
	 *        Written by : zy
	 */
	public String saveTask(HttpServletRequest request, BschecktaskDTO dto){
		try{
			saveTaskImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveTaskImpl的中文名称：保存任务
	 *
	 * saveTaskImpl的概要说明：
	 * param request
	 * param dto
	 * throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void saveTaskImpl(HttpServletRequest request, BschecktaskDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		if (dto.getTaskid() != null && !"".equals(dto.getTaskid())) {
			Bschecktask task = dao.fetch(Bschecktask.class, dto.getTaskid());
			task.setAaa011(vSysUser.getUsername()); // 创建人;
			task.setAae036(SysmanageUtil.getDbtimeYmdHns()); // 创建时间
			task.setPlanid(dto.getPlanid()); // 计划id
			task.setTaskname(dto.getTaskname()); // 任务名称
			task.setTaskremark(dto.getTaskremark()); // 任务描述
			task.setTasktimest(dto.getTasktimest()); // 任务开始时间
			task.setTasktimeed(dto.getTasktimeed()); // 任务结束时间
			dao.update(task);
		} else {
			Bschecktask task = new Bschecktask();
			task.setAaa011(vSysUser.getUsername()); // 创建人;
			task.setAae036(SysmanageUtil.getDbtimeYmdHns()); // 创建时间
			task.setPlanid(dto.getPlanid()); // 计划id
			task.setTaskname(dto.getTaskname()); // 任务名称
			task.setTaskremark(dto.getTaskremark()); // 任务描述
			task.setTasktimest(dto.getTasktimest()); // 任务开始时间
			task.setTasktimeed(dto.getTasktimeed()); // 任务结束时间
			task.setTaskid(DbUtils.getSequenceStr()); // 任务id
			dao.insert(task);
		}
	}

	/**
	 *
	 * deleteTask的中文名称：删除任务
	 *
	 * deleteTask的概要说明：
	 * param request
	 * param dto
	 * return
	 *        Written by : zy
	 */
	public String deleteTask(HttpServletRequest request, BschecktaskDTO dto){
		try{
			deleteTaskImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * deleteTaskImpl的中文名称：删除任务实现
	 *
	 * deleteTaskImpl的概要说明：
	 * param request
	 * param dto
	 * throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void deleteTaskImpl(HttpServletRequest request, BschecktaskDTO dto) throws Exception {
		// 删除任务
		dao.delete(Bschecktask.class, dto.getTaskid());
		// 删除检查企业
		dao.clear(Bschecktaskdetail.class, Cnd.where("taskid", "=", dto.getTaskid()));
		// 删除检查人员
		dao.clear(Bschecktaskperson.class, Cnd.where("taskid", "=", dto.getTaskid()));
		// 删除待办事项，待办接收人
		List<Pdbsx> list = dao.query(Pdbsx.class, Cnd.where("qtbid", "=", dto.getTaskid()));
		for (Pdbsx v_db : list) {
			dao.delete(Pdbsx.class, v_db.getPdbsxid()); // 删除待办事项
			dao.clear(Pdbsxjsr.class, Cnd.where("pdbsxid", "=", v_db.getPdbsxid())); // 删除待办事项接收人
		}
	}

	/**
	 *
	 * querySurpervisionCompany的中文名称：查询检查公司
	 *
	 * querySurpervisionCompany的概要说明：
	 * param request
	 * param dto
	 * param pd
	 * return
	 * throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querySupervisionCompany(HttpServletRequest request, BschecktaskdetailDTO dto, PagesDTO pd) throws Exception {

		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.*, a.commc, a.comdz from bschecktaskdetail b, pcompany a");
		sb.append(" where 1=1 ");
		sb.append(" and b.comid = a.comid ");
		sb.append(" and b.taskid = :taskid ");
		sb.append(" order by taskdetailid desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "taskid" };
		int[] paramType = new int[]{ Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BschecktaskdetailDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * querySupervisionPerson的中文名称：查询检查人
	 *
	 * querySupervisionPerson的概要说明：
	 * param request
	 * param dto
	 * param pd
	 * return
	 * throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querySupervisionPerson(HttpServletRequest request, BschecktaskpersonDTO dto, PagesDTO pd) throws Exception {

		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.*, org.orgname ,org.orgid , a.username, a.description ");
		sb.append(" from bschecktaskperson b, sysuser a, sysorg org ");
		sb.append(" where 1=1 ");
		sb.append(" and b.userid = a.userid ");
		sb.append(" and a.orgid = org.orgid ");
		sb.append(" and b.taskid = :taskid ");
		sb.append(" order by id desc ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "taskid" };
		int[] paramType = new int[]{ Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BschecktaskpersonDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveSuperVisionItem的中文名称：保存检查内容（检查公司，检查人员）
	 *
	 * saveSuperVisionItem的概要说明：
	 * param request
	 * param dto
	 * return
	 *        Written by : zy
	 */
	public String saveSuperVisionItem(HttpServletRequest request, BschecktaskDTO dto){
		try{
			saveSuperVisionItemImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveSuperVisionItemImpl的中文名称：保存检查内容（检查公司，检查人员）
	 *
	 * saveSuperVisionItemImpl的概要说明：
	 * param request
	 * param dto
	 * throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void saveSuperVisionItemImpl(HttpServletRequest request, BschecktaskDTO dto) throws Exception {

		Sysuser v_user = SysmanageUtil.getSysuser();
		// 加入代办事项
		Pdbsx v_newPdbsx = new Pdbsx(); // 代办事项
		String v_pdbsxid = DbUtils.getSequenceStr();
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
		v_newPdbsx.setPdbsxid(v_pdbsxid); // 代办事项id
		v_newPdbsx.setQtbid(dto.getTaskid()); // 其他相关表id（任务表id）
		v_newPdbsx.setFsuserid(v_user.getUserid()); // 指派人id
		v_newPdbsx.setFsusername(v_user.getDescription()); // 指派人名字
		v_newPdbsx.setFssj(v_dbDatetime); // 指派时间
		v_newPdbsx.setFsnr(dto.getTaskremark().trim()); // 指派内容
		v_newPdbsx.setFsxtbz("安全监管任务:"+dto.getTaskname().trim()); // 指派备注
		dao.insert(v_newPdbsx);

		//先删除，再插入
		// 删除检查企业
		dao.clear(Bschecktaskdetail.class, Cnd.where("taskid", "=", dto.getTaskid()));
		// 删除检查人员
		dao.clear(Bschecktaskperson.class, Cnd.where("taskid", "=", dto.getTaskid()));

		JSONArray v_array = null;
		Object[]  v_objArray = null;
		// 检查企业
		v_array = JSONArray.fromObject(dto.getComgrid_rows());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			BschecktaskdetailDTO v_dto = (BschecktaskdetailDTO) JSONObject.toBean(v_obj, BschecktaskdetailDTO.class);
			// 获取任务明细id
			Bschecktaskdetail v_detail = new Bschecktaskdetail();
			v_detail.setComid(v_dto.getComid()); // 企业id
			v_detail.setTaskid(dto.getTaskid()); // 任务id
			v_detail.setFlag("-1"); // 默认值，以后根据情况修改
			v_detail.setTaskdetailid(DbUtils.getSequenceStr()); // 任务明细主键
			dao.insert(v_detail);
		}
		List<String> useridList = new ArrayList<String>();
		// 检查人员
		v_array = JSONArray.fromObject(dto.getRygrid_rows());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			BschecktaskpersonDTO v_dto = (BschecktaskpersonDTO) JSONObject.toBean(v_obj, BschecktaskpersonDTO.class);
			// 检查人员
			Bschecktaskperson v_person = new Bschecktaskperson();
			v_person.setId(DbUtils.getSequenceStr()); // 主键id
			v_person.setTaskid(dto.getTaskid()); // 任务id
			v_person.setUserid(v_dto.getUserid()); // 用户id
			dao.insert(v_person);
			// 发送任务给指定人员（平台端待办事项）
			Pdbsxjsr v_Pdbsxjsr = new Pdbsxjsr(); // 代办事项人员
			v_Pdbsxjsr.setPdbsxjsrid(DbUtils.getSequenceStr()); // 主键id
			v_Pdbsxjsr.setPdbsxid(v_pdbsxid); // 代办事项id
			v_Pdbsxjsr.setJsuserid(v_dto.getUserid());
			v_Pdbsxjsr.setJsusername(v_dto.getUsername()); // 接受人用户名
			v_Pdbsxjsr.setJsorgid(v_dto.getOrgid()); // 接受人组织机构id
			v_Pdbsxjsr.setJsorgname(v_dto.getOrgname()); // 接受人部门名称
			v_Pdbsxjsr.setJsbz("0");
			dao.insert(v_Pdbsxjsr);
			// 要接受任务的人员集合
			useridList.add(v_dto.getUserid());
		}
		// 推送信息
		StringBuffer pushinfo = new StringBuffer();
		pushinfo.append("安全监管任务 \n");
		pushinfo.append("任务名称：").append(dto.getTaskname()).append("\n");
		pushinfo.append("任务描述：").append(dto.getTaskremark()).append("\n");
		pushinfo.append("任务开始时间：").append(dto.getTasktimest()).append("\n");
		pushinfo.append("任务结束时间：").append(dto.getTasktimeed()).append("\n");
		// 发送任务给指定人员（手机端极光推送）
		if(useridList.size() > 0){
			JPushAllUtil.androidSendPushByalias(useridList, "1",  pushinfo.toString(), "安全监管通知" );
		}

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryComByPlan(HttpServletRequest request, PcompanyDTO dto, PagesDTO pd) throws Exception {
		String v_planid = StringHelper.showNull2Empty(request.getParameter("planid")); // 检查计划id
		Bscheckplan plan = dao.fetch(Bscheckplan.class, v_planid);
		if(("").equals(plan.getPlantypearea())||plan.getPlantypearea()==null){
			throw new BusinessException("请在执行范围中设置检查公司！");
		}
		String[] planTypeArea =plan.getPlantypearea().split(",");
		String aaa027 = SysmanageUtil.getSysuserAaa027(SysmanageUtil.getSysuser().getAaa027());
		dto.setAaa027(aaa027);
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* , ");
		sb.append(" (SELECT aa.AAA103  FROM aa10 aa WHERE aa.AAA100 ='comdalei' AND aa.AAA102 = p.comdalei) comdaleistr ");
		sb.append(" from pcompany a, aa10 b, pcompanycomdalei p ");
		sb.append(" where 1 = 1 ");
		sb.append("  AND a.comid = p.comid  ");
		sb.append("  and b.AAA100 = 'COMDALEI' AND b.AAA102 = p.comdalei");
//		sb.append("  and a.aaa027 like :aaa027");
		sb.append("  and commc like :commc");
		sb.append("  and b.AAZ093 IN (");
		for (int i = 0; i < planTypeArea.length - 1; i ++) {
			sb.append("'" + planTypeArea[i] + "', ");
		}
		sb.append("'" + planTypeArea[planTypeArea.length-1] + "') ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "commc" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows());
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	};

	/**
	 *
	 * autoCreatePlans：创建检查计划
	 *
	 * param request
	 * return
	 * Written by : zy
	 */
	public String autoCreatePlansTwo(HttpServletRequest request){
		try{
			autoCreatePlansTwoImpl(request);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * autoCreatePlansImpl：创建检查计划
	 *
	 * param request
	 * throws Exception
	 * Written by : zy
	 */
	@Aop({"trans"})
	public void autoCreatePlansTwoImpl(HttpServletRequest request) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 计划年份-默认为当前年份
		String planYear = String.valueOf(DateUtil.getCurrentYear());
		// 获取参数-计划年份
		String paramYear = StringHelper.showNull2Empty(request.getParameter("planYear"));
		planYear = "".equals(paramYear) ? planYear : paramYear;
		int year = Integer.parseInt(planYear);

		String planType = "1"; // 默认检查计划为日常检查  0：量化 1：日常 2:专项 3：校园周边
		// 获取参数-计划类型
		String paramType = StringHelper.showNull2Empty(request.getParameter("planType"));
		planType = "".equals(paramType) ? planType : paramType;

		//gu20180328获取检查计划的名称
		String v_itemid=StringHelper.showNull2Empty(request.getParameter("itemid"));
		String v_itemname="";
		Omcheckgroup v_omcheckgroup=dao.fetch(Omcheckgroup.class, Cnd.where("itemid", "=", v_itemid));
		if (v_omcheckgroup!=null){
			v_itemname="【"+v_omcheckgroup.getItemname()+"】";
		}

        //科室属性
		String v_orgprop = StringHelper.showNull2Empty(request.getParameter("orgprop"));
		String v_planName=""; // 检查计划名称
		String v_planNameQ=""; // 检查计划名称
		String planCode = ""; // 检查计划编号
		String planTypeTag = ""; // 检查类型标签（周边、日常、量化）

		if ("0".equals(planType)) { // 量化检查
			v_planNameQ += "量化检查";
			planTypeTag = "LH";
		} else if ("1".equals(planType)) { // 日常检查
			v_planNameQ += "日常检查";
			planTypeTag = "RC";
		} else if ("2".equals(planType)) { // 专项检查
			v_planNameQ += "专项检查";
			planTypeTag = "ZX";
		} else if ("3".equals(planType)) { // 校园周边
			v_planNameQ += "校园周边日常检查";
			planTypeTag = "ZB";
		};
		String v_plantypearea=selectPlanAreasFromAa10(request,v_itemid);

		String v_sql="select a.* from pcheckfreg a where a.orgprop='"+v_orgprop+"' and itemtype='"+planType+"'";
		List<PcheckfregDTO> v_checkfregList=(List<PcheckfregDTO>)DbUtils.getDataList(v_sql,PcheckfregDTO.class);
        if (v_checkfregList!=null && v_checkfregList.size()>0){
			//v_rowsCount=v_checkfregList.size();
        	for (PcheckfregDTO v_freg:v_checkfregList){
				int v_checkpc=v_freg.getCheckpc();
				for (int k=0;k<v_checkpc;k++){
					String planid = DbUtils.getSequenceStr(); // 计划id
					Date v_stDate=new Date(year - 1900, (k) * 12 / v_checkpc, 1);
					Date v_edDate=new Date(year - 1900, (k + 1) * 12 / v_checkpc, 1);
					String startDate = DateUtil.dateToString(v_stDate,DateUtil.NORMAL_DATE_FORMAT); // 开始检查日期
					String endDate = DateUtil.dateToString(v_edDate,DateUtil.NORMAL_DATE_FORMAT); // 结束检查日期
					v_planName = planYear + "年度"+StringHelper.dowithNull(v_freg.getPlannamebz())+v_planNameQ+ StringHelper.dowithNull(v_freg.getPlancodebz()) + preAppendZero(k + 1)+v_itemname; // 2018年度日常检查 A 01
					planCode = planYear + planTypeTag + "_" + StringHelper.dowithNull(v_freg.getPlancodebz()) + preAppendZero((k + 1))
							+ "-" + preAppendZero((12 / v_checkpc)) + "/1"; // 2018 RC 01 A 01 - 12 /1

					Bscheckplan plan = new Bscheckplan();
					plan.setPlanid(planid); // 计划id
					plan.setPlanoperatedate(SysmanageUtil.getDbtimeYmd()); // 操作时间
					plan.setPlancode(planCode); // 计划编号
					plan.setPlanchecktype(planType); // 检查类型
					plan.setPlanstdate(startDate); // 计划开始时间
					plan.setPlaneddate(endDate); // 计划结束时间
					plan.setPlantitle(v_planName); // 检查标题
					plan.setPlantype("1"); // 计划类型-按类型
					plan.setPlantypearea(v_plantypearea); // 计划使用范围
					plan.setLhfjndpddj(v_freg.getLhfjndpddj());
					dao.insert(plan);
					saveItemForPlan(vSysUser.getUserid(), planid,v_itemid);
				}
			}
		}
	};


	/**
	 *
	 * autoCreatePlans：创建检查计划
	 *
	 * param request
	 * return
	 * Written by : zy
	 */
	public String autoCreatePlans(HttpServletRequest request){
		try{
			autoCreatePlansImpl(request);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * autoCreatePlansImpl：创建检查计划
	 *
	 * param request
	 * throws Exception
	 * Written by : zy
	 */
	@Aop({"trans"})
	public void autoCreatePlansImpl(HttpServletRequest request) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 计划年份-默认为当前年份
		String planYear = String.valueOf(DateUtil.getCurrentYear());
		// 获取参数-计划年份
		String paramYear = StringHelper.showNull2Empty(request.getParameter("planYear"));
		planYear = "".equals(paramYear) ? planYear : paramYear;

		String planType = "1"; // 默认检查计划为日常检查  0：量化 1：日常 2:专项 3：校园周边
		// 获取参数-计划类型
		String paramType = StringHelper.showNull2Empty(request.getParameter("planType"));
		planType = "".equals(paramType) ? planType : paramType;
		String[] planTypes = planType.split(",");
		String planTypeTag = ""; // 检查类型标签（周边、日常、量化）
		String planCode = ""; // 检查计划编号
		String placeholder = "_"; // 占位符
		String[] levelCount = new String[]{"A","B","C","D"}; // 日常检查，量化等级
		int year = Integer.parseInt(planYear);
		String v_itemid=StringHelper.showNull2Empty(request.getParameter("itemid"));

		//gu20180328获取检查计划的名称
		String v_itemname="";
		Omcheckgroup v_omcheckgroup=dao.fetch(Omcheckgroup.class, Cnd.where("itemid", "=", v_itemid));
        if (v_omcheckgroup!=null){
			v_itemname="【"+v_omcheckgroup.getItemname()+"】";
		}

		String v_plantypearea=selectPlanAreasFromAa10(request,v_itemid);
		for (int i = 0; i < planTypes.length; i++) {
			String planName = planYear + "年度"; // 检查计划名称
			Aa01 aa01;
			int planCount = 0; // 检查次数
			if ("0".equals(planTypes[i])) { // 量化检查
				planName += "量化检查";
				aa01 = SysmanageUtil.getAa01("AQJG_TYPE_LH");
				planTypeTag = "LH";
				planCount = Integer.parseInt(aa01.getAaa005());
			} else if ("1".equals(planTypes[i])) { // 日常检查
				planName += "日常检查";
				aa01 = SysmanageUtil.getAa01("AQJG_TYPE_RC");
				planTypeTag = "RC";
				planCount = Integer.parseInt(aa01.getAaa005());
			} else if ("2".equals(planTypes[i])) { // 专项检查
				planName += "专项检查";
				aa01 = SysmanageUtil.getAa01("AQJG_TYPE_ZX");
				planTypeTag = "ZX";
				planCount = Integer.parseInt(aa01.getAaa005());
			} else if ("3".equals(planTypes[i])) { // 校园周边
				planName += "校园周边日常检查";
				aa01 = SysmanageUtil.getAa01("AQJG_TYPE_ZB");
				planTypeTag = "ZB";
				planCount = Integer.parseInt(aa01.getAaa005());
			}
			for (int step = 1; step <= planCount; step++) {
				if ("1".equals(planTypes[i])) { // 当为日常检查时，需要根据量化等级指定检查计划
					for (int level = 0; level < step; level++) {
						String planid = DbUtils.getSequenceStr(); // 计划id
						Date v_stDate=new Date(year - 1900, (level) * 12 / step, 1);
						Date v_edDate=new Date(year - 1900, (level + 1) * 12 / step, 1);

						String startDate = DateUtil.dateToString(v_stDate,DateUtil.NORMAL_DATE_FORMAT); // 开始检查日期
						String endDate = DateUtil.dateToString(v_edDate,DateUtil.NORMAL_DATE_FORMAT); // 结束检查日期

						//String startDateYMD = DateUtil.dateToString(v_stDate,DateUtil.COMPACT_DATE_FORMAT); // 开始检查日期
						//String endDateYMD = DateUtil.dateToString(v_edDate,DateUtil.COMPACT_DATE_FORMAT); // 结束检查日期

						placeholder = levelCount[step-1];
						String v_planName = planName + placeholder + preAppendZero(level + 1)+v_itemname; // 2018年度日常检查 A 01
						planCode = planYear + planTypeTag + "_" + placeholder + preAppendZero((level + 1))
								+ "-" + preAppendZero((12 / step)) + "/1"; // 2018 RC 01 A 01 - 12 /1

						System.out.println(v_planName + "," + planCode + "," + startDate + "~" + endDate);
						Bscheckplan plan = new Bscheckplan();
						plan.setPlanid(planid); // 计划id
						plan.setPlanoperatedate(SysmanageUtil.getDbtimeYmd()); // 操作时间
						plan.setPlancode(planCode); // 计划编号
						plan.setPlanchecktype(planTypes[i]); // 检查类型
						plan.setPlanstdate(startDate); // 计划开始时间
						plan.setPlaneddate(endDate); // 计划结束时间
						plan.setPlantitle(v_planName); // 检查标题
						plan.setPlantype("1"); // 计划类型-按类型
						plan.setPlantypearea(v_plantypearea); // 计划使用范围
						dao.insert(plan);
						saveItemForPlan(vSysUser.getUserid(), planid,v_itemid);
					}
				} else {
					String planid = DbUtils.getSequenceStr(); // 计划id
					planCode = planYear + planTypeTag + "_" + placeholder + preAppendZero(step)
							+ "-" + preAppendZero((12/planCount)) + "/1"; // 2018 RC 01 _ 01 - 12 /1
					String v_planName = planName + preAppendZero(step)+v_itemname; // 2018年度校园周边日常检查 06
					String startDate = DateUtil.dateToString(new Date(year - 1900, (step - 1) * 12 / planCount, 1),
															 DateUtil.NORMAL_DATE_FORMAT); // 结束检查日期
					String endDate = DateUtil.dateToString(new Date(year - 1900, step * 12 / planCount, 1),
														   DateUtil.NORMAL_DATE_FORMAT); // 结束检查日期
					System.out.println(v_planName +"," + planCode + "," + startDate + "~" + endDate);
					Bscheckplan plan = new Bscheckplan();
					plan.setPlanid(planid); // 计划id
					plan.setPlanoperatedate(SysmanageUtil.getDbtimeYmd()); // 操作时间
					plan.setPlancode(planCode); // 计划编号
					plan.setPlanchecktype(planTypes[i]); // 检查类型
					plan.setPlanstdate(startDate); // 计划开始时间
					plan.setPlaneddate(endDate); // 计划结束时间
					plan.setPlantitle(v_planName); // 检查标题
					plan.setPlantype("1"); // 计划类型-按类型
					if ("3".equals(planTypes[i])) {
						plan.setPlantypearea("30991"); // 计划使用范围()
					} else {
						plan.setPlantypearea(v_plantypearea); // 计划使用范围
					}
					dao.insert(plan);
					saveItemForPlan(vSysUser.getUserid(), planid,v_itemid);
				}
			}
		}
	};

	// 为检查计划设置执行范围（默认为食品销售日常检查）
	private void saveItemForPlan(String userid, String planid,String prm_itemid) throws Exception {
		// 获取食品销售日常检查检查项 2016061422103164810282422为食品销售日常检查id
		List<CheckGroup> groupList = dao.query(CheckGroup.class,
											   Cnd.where("itempid", "=", prm_itemid).asc("itemsortid"));
		for(CheckGroup checkGroup : groupList) {
			// 获取检查项检查内容
			List<CheckContent> contentList = dao.query(CheckContent.class,
													   Cnd.where("itemid", "=", checkGroup.getItemid()).asc("contentsortid"));
			for (CheckContent checkContent : contentList) {
				Bscheckpicset picset = new Bscheckpicset(); // 检查计划检查项设置表
				String picid = DbUtils.getSequenceStr();
				picset.setPicid(picid); // id
				picset.setPlanid(planid); // 检查计划id
				picset.setPicoperatedate(SysmanageUtil.getDbtimeYmd()); // 设置时间
				picset.setPicoperator(userid); // 操作人
				picset.setContentid(checkContent.getContentid()); // 检查内容id
				picset.setItemid(checkContent.getItemid()); // 检查项目id
				dao.insert(picset);
			}
		}
	}
	// 获取执法范围（所有企业大类）
	private String selectPlanAreasFromAa10(HttpServletRequest request,String prm_itemid) throws Exception {
		String aaz093 = "";
		BsCheckPalnAndTypeDTO v_dto=new BsCheckPalnAndTypeDTO();
		v_dto.setItemid(prm_itemid);
		PagesDTO pd=new PagesDTO();
		pd.setPage(1);
		pd.setPageSize(1000);

		List list = (List) checkInfoService.querycheckList(request,v_dto,pd).get("rows");
        if (list!=null && list.size()>0){
        	for (int i=0;i<list.size();i++){
				BsCheckPalnAndTypeDTO checkPalnAndType = (BsCheckPalnAndTypeDTO) list.get(i);
				aaz093 += checkPalnAndType.getAaz093() + ",";
			}
		}
		return aaz093.substring(0, aaz093.length() - 1);
//		String aaz093 = "";
//		List<Aa10> aa10List = dao.query(Aa10.class, Cnd.where("aaa100", "=", "comdalei"));
//		if (aa10List != null && aa10List.size() > 0) {
//			for (int i = 0; i < aa10List.size(); i++) {
//				Aa10 aa10 = aa10List.get(i);
//				aaz093 += aa10.getAaz093() + ",";
//			}
//			return aaz093.substring(0, aaz093.length() - 1);
//		}
//		return null;
	}
	// 当数字不足两位时，在前面补0
	private String preAppendZero(int number){
		return number < 10 ? "0" + number : "" + number;
	}

}
