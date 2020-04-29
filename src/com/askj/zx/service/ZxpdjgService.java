package com.askj.zx.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.zx.dto.ZxpddjcsDTO;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpdjgDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.zx.entity.Zxpdcjxx;
import com.askj.zx.entity.Zxpddjcs;
import com.askj.zx.entity.Zxpdjg;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import common.Logger;

/**
 * 征信评定结果  业务逻辑层
 * @author CatchU
 *
 */
public class ZxpdjgService extends BaseService {

	protected final Logger logger = Logger.getLogger(ZxpdjgService.class);
	
	@Inject
	private Dao dao;

	/**
	 * 查询企业诚信评定信息
	 */
	public Map queryZxpdjg(ZxpdjgDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select pdjgid,pdjg.comid,djcsbm,djcshh,niandu,pdjgscfs,");
		sb.append(" beizhu,reason,czyxm,czsj,pdjgdf,pdjg.commc ");
		sb.append(" from zxpdjg pdjg,pcompany pcom");
		sb.append(" where pdjg.comid=pcom.comid ");
		sb.append(" and pdjg.comid = :comid");
		sb.append(" and pdjg.niandu = :niandu");
		sb.append(" and pdjg.djcshh = :djcshh");
		sb.append(" and pdjg.pdjgid = :pdjgid");
		sb.append(" and pdjg.commc like :commc");
		sb.append(" order by pdjgid");
		String sql = sb.toString();
		String[] paramName = new String[]{"comid","niandu","djcshh","pdjgid","commc"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpdjgDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}



	/**
	 * 查询黑红名单信息
	 */
	public Map queryZxpdjgs(ZxpdjgDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		String djcshhs=dto.getDjcshh();
		StringBuffer sb = new StringBuffer();
		sb.append(" select pdjgid,pdjg.comid,djcsbm,djcshh,niandu,pdjgscfs,");
		sb.append(" beizhu,reason,czyxm,czsj,pdjgdf,pdjg.commc ");
		sb.append(" from zxpdjg pdjg,pcompany pcom");
		sb.append(" where pdjg.comid=pcom.comid ");
		if (dto.getDjcshh() != null && !"".equals(dto.getDjcshh())) {
			sb.append(" and pdjg.djcshh = '").append(dto.getDjcshh()).append("' "); // 红名单
		}
		sb.append(" and pdjg.comid = :comid");

		sb.append(" and pdjg.pdjgid = :pdjgid");
		if (dto.getCommc() != null && !"".equals(dto.getCommc())) {
			sb.append(" and pdjg.commc like '%").append(dto.getCommc()).append("%' "); // 企业名称
		}
		if (dto.getNiandu() != null && !"".equals(dto.getNiandu())) {
			sb.append(" and pdjg.niandu = ").append(dto.getNiandu()).append(" "); // 年度
		}

		sb.append(" order by pdjgid");
		String sql = sb.toString();
		String[] paramName = new String[]{"comid","pdjgid"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpdjgDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * queryzxpddjcs的中文名称：获取红黑榜对应的最小分值和最大分值
	 *
	 * queryzxpddjcs的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param
	 * @return
	 * @throws Exception
	 * @author : zk
	 */
	@SuppressWarnings("rawtypes")
	public Map queryzxpddjcs(HttpServletRequest request, ZxpddjcsDTO dto)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select min(djcsqsfz) as djcsqsfz, max(djcsjsfz) as djcsjsfz from ");
		sb.append("  zxpddjcs ");
		sb.append("  where 1=1 ");
		sb.append("  and djcshh = :djcshh ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "djcshh" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpddjcsDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		return r;
	}


	/**
	 * 添加企业诚信评定信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveZxpdjgs(HttpServletRequest request, final ZxpdjgDTO dto) {
		try{
			saveZxpdjgsImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 添加企业诚信评定实现方法
	 * 使用事务管理
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@Aop({"trans"})
	private void 	saveZxpdjgsImpl(HttpServletRequest request, ZxpdjgDTO dto) throws Exception {
		//获取企业得分
		Integer score = dto.getPdjgdf();
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		if(sysuser == null){
			sysuser = new Sysuser();
			sysuser.setUsername(dto.getCzyxm());
		}
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		//首先判断是更新还是添加
		if(dto.getPdjgid()!=null && !"".equals(dto.getPdjgid())){// 更新操作
			Zxpdjg zxpdjg = dao.fetch(Zxpdjg.class, dto.getPdjgid());
			/*BeanHelper.copyProperties(dto, zxpdjg);*/
			//获取评定信息
			Zxpddjcs djcs = (Zxpddjcs)judgeRedOrBlack(score).get(0);
			zxpdjg.setDjcsbm(djcs.getDjcsbm());  //等级参数编码
			zxpdjg.setDjcshh(dto.getDjcshh());  //等级参数红黑
			zxpdjg.setPdjgid(dto.getPdjgid());
			zxpdjg.setComid(dto.getComid());
			zxpdjg.setCommc(dto.getCommc());
			zxpdjg.setNiandu(dto.getNiandu());
			zxpdjg.setPdjgscfs(dto.getPdjgscfs());
			zxpdjg.setBeizhu(dto.getBeizhu());
			zxpdjg.setCzyxm(sysuser.getUsername());
			zxpdjg.setCzsj(datetime);
			zxpdjg.setPdjgdf(dto.getPdjgdf());
			dao.update(zxpdjg);
		}else{  //添加操作
			//一个单位一个年度一条
			String v_sql="select a.* from zxpdjg a where a.comid='"+dto.getComid()+"' and a.niandu='"+dto.getNiandu()+"'";
			List<Zxpdjg> v_zxpdjglist=DbUtils.getDataList(v_sql, Zxpdjg.class);
			if (v_zxpdjglist==null || v_zxpdjglist.size()>0){
				throw new BusinessException("该企业该年度评定结果已经存在");
			}
			String pdjgid = DbUtils.getSequenceStr();
			Zxpdjg zxpdjg = new Zxpdjg();
			BeanHelper.copyProperties(dto, zxpdjg);
			Zxpddjcs djcs = new Zxpddjcs();
			if(judgeRedOrBlack(score).size()>0){
				djcs = (Zxpddjcs)judgeRedOrBlack(score).get(0);
				zxpdjg.setDjcsbm(djcs.getDjcsbm());
				zxpdjg.setDjcshh(dto.getDjcshh());
			}
			zxpdjg.setPdjgid(pdjgid);
			zxpdjg.setCzyxm(sysuser.getUsername());
			zxpdjg.setCzsj(datetime);
			dao.insert(zxpdjg);
		}

		//gu20161121同步更新相应企业
		Pcompany v_pcom=dao.fetch(Pcompany.class, dto.getComid());
		v_pcom.setComhhbbz(dto.getDjcshh());
		dao.update(v_pcom);

	}



	/**
	 * 添加企业诚信评定信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveZxpdjg(HttpServletRequest request, final ZxpdjgDTO dto) {
		try{
			saveZxpdjgImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}

	/**
	 * 添加企业诚信评定实现方法
	 * 使用事务管理
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	private void 	saveZxpdjgImpl(HttpServletRequest request, ZxpdjgDTO dto) throws Exception {
		//获取企业得分
		Integer score = dto.getPdjgdf();
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser(); 
		if(sysuser == null){
			sysuser = new Sysuser();
			sysuser.setUsername(dto.getCzyxm());
		} 
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		//首先判断是更新还是添加
		if(dto.getPdjgid()!=null && !"".equals(dto.getPdjgid())){// 更新操作
			Zxpdjg zxpdjg = dao.fetch(Zxpdjg.class, dto.getPdjgid());
			/*BeanHelper.copyProperties(dto, zxpdjg);*/
			//获取评定信息
			Zxpddjcs djcs = (Zxpddjcs)judgeRedOrBlack(score).get(0);
			zxpdjg.setDjcsbm(djcs.getDjcsbm());  //等级参数编码
			zxpdjg.setDjcshh(djcs.getDjcshh());  //等级参数红黑
			zxpdjg.setPdjgid(dto.getPdjgid());
			zxpdjg.setComid(dto.getComid());
			zxpdjg.setCommc(dto.getCommc());
			zxpdjg.setNiandu(dto.getNiandu());
			zxpdjg.setPdjgscfs(dto.getPdjgscfs());
			zxpdjg.setBeizhu(dto.getBeizhu());
			zxpdjg.setCzyxm(sysuser.getUsername()); 
			zxpdjg.setCzsj(datetime);
			zxpdjg.setPdjgdf(dto.getPdjgdf());
			zxpdjg.setReason(dto.getReason());
			dao.update(zxpdjg);
		}else{  //添加操作
			//一个单位一个年度一条
			String v_sql="select a.* from zxpdjg a where a.comid='"+dto.getComid()+"' and a.niandu='"+dto.getNiandu()+"'";
			List<Zxpdjg> v_zxpdjglist=DbUtils.getDataList(v_sql, Zxpdjg.class);
			if (v_zxpdjglist==null || v_zxpdjglist.size()>0){
				throw new BusinessException("该企业该年度评定结果已经存在");
			}
			String pdjgid = DbUtils.getSequenceStr();
			Zxpdjg zxpdjg = new Zxpdjg();
			BeanHelper.copyProperties(dto, zxpdjg);
			Zxpddjcs djcs = new Zxpddjcs();
			if(judgeRedOrBlack(score).size()>0){
				djcs = (Zxpddjcs)judgeRedOrBlack(score).get(0);
				zxpdjg.setDjcsbm(djcs.getDjcsbm());
				zxpdjg.setDjcshh(djcs.getDjcshh());
			}
			zxpdjg.setPdjgid(pdjgid);
			zxpdjg.setCzyxm(sysuser.getUsername()); 
			zxpdjg.setCzsj(datetime);
			dao.insert(zxpdjg);
		}
		
		//gu20161121同步更新相应企业
		Pcompany v_pcom=dao.fetch(Pcompany.class, dto.getComid());
		v_pcom.setComhhbbz(dto.getDjcshh());
		dao.update(v_pcom);
		
	}
	
	/**
	 * 删除诚信评定信息
	 */
	public String delZxpdjg(HttpServletRequest request,final ZxpdjgDTO dto){
		try{
			delZxpdjgImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 删除企业诚信评定信息实现方法
	 * @param request
	 * @param dto
	 */
	@Aop({"trans"})
	private void delZxpdjgImpl(HttpServletRequest request, ZxpdjgDTO dto) {
		if(!(dto.getPdjgid() == null||"".equals(dto.getPdjgid()))){
			//删除信息
			dao.clear(Zxpdjg.class, Cnd.where("pdjgid", "=", dto.getPdjgid()));
		}
	}
	
	/**
	 * 判断企业的红黑榜，查询出zxpddjcs(征信评定等级参数表)
	 * @throws Exception 
	 */
	protected List judgeRedOrBlack(Integer score) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select djcsid,djcsbm,djcsmc,djcsqsfz,djcsjsfz,djcsksrq,");
		sb.append(" djcsjsrq,czyxm,czsj,djcshh ");
		sb.append(" from zxpddjcs djcs");
		sb.append(" where 1=1");
		sb.append(" and djcs.djcsqsfz <= "+score );
		sb.append(" and djcs.djcsjsfz >= "+score);
		sb.append(" order by djcsid");
		
		String[] ParaName = new String[] { };
		int[] ParaType = new int[] {};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zxpddjcs.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);		
		return list;
//		Sql sql = Sqls.create(sb.toString());
//		sql.setCallback(Sqls.callback.records());
//		dao.execute(sql);
//		return sql.getList(Zxpddjcs.class);
	}
	
	
	/**
	 * 计算企业同一年度得分，并用ajax返回前端页面
	 */
	public Map sumScore(HttpServletRequest request,ZxpdjgDTO dto) throws Exception{
		String comid = dto.getComid();
		String niandu = dto.getNiandu();
		List list = queryScore(comid, niandu);
		/*int length = list.size();
		int sum = 0;
		for(int i = 0;i<length;i++){
			Zxpdcjxx cjxx = (Zxpdcjxx) list.get(i);
			sum += cjxx.getCjdf();
		}*/
		Map map =new HashMap();
		map.put("rows", list);
		return map;
	}
	/**
	 * 查找企业每一检查项得分
	 */
	protected List queryScore(String comid,String niandu) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select cjid,comid,xmcsdm,cjdf,czyxm,");
		sb.append(" czsj,beizhu,niandu,sjly ");
		sb.append(" from zxpdcjxx cjxx");
		sb.append(" where 1=1");
		sb.append(" and cjxx.comid = " + "'" + comid + "'" );
		sb.append(" and cjxx.niandu = " + "'" +niandu + "'");
		sb.append(" order by cjid");
		String sql = sb.toString();
		String[] ParaName = new String[] { };
		int[] ParaType = new int[] { };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zxpdcjxx.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);		
		return list;
	}
	
	/**
	 * 根据采集信息生成征信评定结果
	 * @param request
	 * @param dto
	 * @return
	 */
	public String scZxpdjgFromCjxx(HttpServletRequest request, final ZxpdjgDTO dto) {
		try{
			scZxpdjgFromCjxxImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}	
	
	/**
	 * 根据采集信息生成征信评定结果
	 * 使用事务管理
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	private void scZxpdjgFromCjxxImpl(HttpServletRequest request, ZxpdjgDTO dto) throws Exception {
		//删除操作员所属统筹区，该年度，自动生成的数据
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		String v_aaa027=sysuser.getAaa027();
		String v_niandu=dto.getNiandu();
		String v_sql="";
		v_sql="delete a from zxpdjg a where a.niandu='"+v_niandu+
				"' and pdjgscfs<>'1' and exists (select b.comid from pcompany b where b.comid=a.comid and b.aaa027='"+v_aaa027+"')";
		Sql mysql=Sqls.create(v_sql);
		dao.execute(mysql);
		
		//插入根据采集统计的评定结果
		v_sql="insert into zxpdjg(pdjgid,comid,djcsbm,djcshh,niandu,pdjgscfs,beizhu,"+
		"czyxm,czsj,pdjgdf,commc) "+
		"select f_getSequenceStr(),u1.comid,u2.djcsbm,"+
		"u2.djcshh,u1.niandu,'0','','"+sysuser.getDescription()+
		"',now(),u1.sumfz,u1.commc "+
        "from "+
        " (select a.comid,100+sum(a.cjdf) as sumfz,a.niandu,b.commc "+
        " from zxpdcjxx a,pcompany b where a.comid=b.comid and a.niandu='"+v_niandu+"'"+
        " and b.aaa027='"+v_aaa027+"' and not exists (select c.comid from zxpdjg c where c.comid=a.comid and c.niandu='"+v_niandu
        +"') group by comid) u1, "+
        " zxpddjcs u2 "+
        " where u1.sumfz>=u2.djcsqsfz "+
        " and u1.sumfz<=u2.djcsjsfz ";
		Sql mysql2=Sqls.create(v_sql);
		dao.execute(mysql2);	
		
		//更新pcompany表红黑榜标志
		v_sql="update pcompany a set a.comhhbbz=(select b.djcshh from zxpdjg b where b.comid=a.comid and b.niandu='"+
		      v_niandu+"') where exists (select c.comid from zxpdjg c where c.comid=a.comid and c.niandu='"+
			  v_niandu+"')";
		Sql mysql3=Sqls.create(v_sql);
		dao.execute(mysql3);				
	}
	
	
}
