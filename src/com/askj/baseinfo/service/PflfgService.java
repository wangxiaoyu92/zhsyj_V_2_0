package com.askj.baseinfo.service;

import com.askj.baseinfo.dto.PflfgDTO;
import com.askj.baseinfo.dto.PflfglbDTO;
import com.askj.baseinfo.dto.PflfgtkDTO;
import com.askj.baseinfo.entity.Pflfg;
import com.askj.baseinfo.entity.Pflfglb;
import com.askj.baseinfo.entity.Pflfgtk;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import common.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 企业法律法规 业务逻辑层
 * @author CatchU
 *
 */
public class PflfgService extends BaseService {

	protected final Logger logger = Logger.getLogger(PflfgService.class);
	
	@Inject
	private Dao dao;

	/**************法律法规相关信息***********************/
	/**
	 * 查询法律法规信息
	 */
	public Map queryPflfg(PflfgDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfgid,flfgbh,flfgdlbm,flfgxlbm,flfgnr,");
		sb.append(" flfgczy,flfgczsj,flfgmc,flfgfbjg,flfgfbkssj,flfgfbjssj, ");
		sb.append(" (select aaa103 from aa10 where aaa100='FLFGLX' and aaa102=flfg.flfglx) flfglx");
		sb.append(" from pflfg flfg");
		sb.append(" where 1=1");
		sb.append(" and flfg.flfgid = :flfgid");
		sb.append(" and flfg.flfgdlbm = :flfgdlbm");
		sb.append(" and flfg.flfgxlbm = :flfgxlbm");
		sb.append(" and flfg.flfgmc = :flfgmc");
		sb.append(" order by flfgid");
		String sql = sb.toString();
		String[] paramName = new String[]{"flfgid","flfgdlbm","flfgxlbm","flfgmc"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PflfgDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 * 查询法律法规信息,解决参数不能显示成汉字的问题
	 */
	public Map queryPflfgForm(PflfgDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfgid,flfgbh,flfglx,flfgdlbm,flfgxlbm,flfgnr,");
		sb.append(" flfgczy,flfgczsj,flfgmc,flfgfbjg,flfgfbkssj,flfgfbjssj ");
		sb.append(" from pflfg flfg");
		sb.append(" where 1=1");
		sb.append(" and flfg.flfgid = :flfgid");
		sb.append(" and flfg.flfgdlbm = :flfgdlbm");
		sb.append(" and flfg.flfgxlbm = :flfgxlbm");
		sb.append(" and flfg.flfgmc = :flfgmc");
		sb.append(" order by flfgid");
		String sql = sb.toString();
		String[] paramName = new String[]{"flfgid","flfgdlbm","flfgxlbm","flfgmc"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PflfgDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 * 添加法律法规类别信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String savePflfg(HttpServletRequest request, final PflfgDTO dto) {
		try{
			savePflfgImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}

	/**
	 * 添加法律法规类别信息实现方法
	 * 使用事务管理
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	private void savePflfgImpl(HttpServletRequest request, PflfgDTO dto) throws Exception {
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		//首先判断是更新还是添加
		if(dto.getFlfgid()!=null&&!"".equals(dto.getFlfgid())){// 更新操作
			Pflfg flfg = dao.fetch(Pflfg.class, dto.getFlfgid());
//			BeanHelper.copyProperties(dto, flfg);
			flfg.setFlfgid(dto.getFlfgid());
			flfg.setFlfgbh(dto.getFlfgbh());
			flfg.setFlfglx(dto.getFlfglx());
			flfg.setFlfgnr(dto.getFlfgnr());
			flfg.setFlfgczy(sysuser.getUsername());
			flfg.setFlfgczsj(datetime);
			flfg.setFlfgdlbm(dto.getFlfgdlbm());
			flfg.setFlfgxlbm(dto.getFlfgxlbm());
			flfg.setFlfgmc(dto.getFlfgmc());
			flfg.setFlfgfbjg(dto.getFlfgfbjg());
			flfg.setFlfgfbkssj(dto.getFlfgfbkssj());
			flfg.setFlfgfbjssj(dto.getFlfgfbjssj());
			dao.update(flfg);
		}else{  //添加操作
			String flfgid = DbUtils.getSequenceStr();
			Pflfg flfg = new Pflfg();
			BeanHelper.copyProperties(dto, flfg);
			flfg.setFlfgid(flfgid);
			flfg.setFlfgczy(sysuser.getUsername());
			flfg.setFlfgczsj(datetime);
			dao.insert(flfg);
		}
	}
	
	/**
	 * 删除法律法规类别信息
	 */
	public String delPflfg(HttpServletRequest request,final PflfgDTO dto){
		try{
			delPflfgImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 删除法律法规类别信息实现方法
	 * @param request
	 * @param dto
	 */
	@Aop({"trans"})
	private void delPflfgImpl(HttpServletRequest request, PflfgDTO dto) {
		if(!(dto.getFlfgid() == null||"".equals(dto.getFlfgid()))){
			//删除信息
			dao.clear(Pflfg.class, Cnd.where("flfgid", "=", dto.getFlfgid()));
		}
	}
	
	/**************法律法规条款信息***********************/
	/**
	 * 查询法律法规条款信息
	 */
	public Map queryPflfgtk(PflfgtkDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfgtkid,flfgid,flfgtkxm,flfgtknr ,");
		sb.append("   (select aaa103 from aa10 aa where aaa100='FLFGTKCYBZ' and aaa102=a.flfgtkcybz ) flfgtkcybz  ");
		sb.append(" from pflfgtk a ");
		sb.append(" where 1=1");
		sb.append(" and a.flfgtkid=:flfgtkid");
		sb.append(" and a.flfgtkxm=:flfgtkxm");
		sb.append(" order by flfgtkid");
		String sql = sb.toString();
		String[] paramName = new String[]{"flfgtkid","flfgtkxm"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PflfgtkDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	//用于解决参数不能转化为汉字显示的问题   0显示为常用
	public Map queryPflfgtkForm(PflfgtkDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfgtkid,flfgid,flfgtkxm,flfgtknr,flfgtkcybz");
		sb.append(" from pflfgtk a ");
		sb.append(" where 1=1");
		sb.append(" and a.flfgtkid=:flfgtkid");
		sb.append(" and a.flfgtkxm=:flfgtkxm");
		sb.append(" order by flfgtkid");
		String sql = sb.toString();
		String[] paramName = new String[]{"flfgtkid","flfgtkxm"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PflfgtkDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	/**
	 * 添加法律法规条款信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String savePflfgtk(HttpServletRequest request, final PflfgtkDTO dto) {
		try{
			savePflfgtkImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage(); 
		}
		return null;
	}

	/**
	 * 添加法律法规条款实现方法
	 * 使用事务管理
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	private void savePflfgtkImpl(HttpServletRequest request, PflfgtkDTO dto) throws Exception {
		/*//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();*/
		//首先判断是更新还是添加
		if(dto.getFlfgtkid()!=null&&!"".equals(dto.getFlfgtkid())){// 更新操作
			Pflfgtk flfgtk = dao.fetch(Pflfgtk.class, dto.getFlfgtkid());
//			BeanHelper.copyProperties(dto, flfg);
			flfgtk.setFlfgtkid(dto.getFlfgtkid());
		    flfgtk.setFlfgtkxm(dto.getFlfgtkxm());
			flfgtk.setFlfgid(dto.getFlfgid());
			flfgtk.setFlfgtknr(dto.getFlfgtknr());
			flfgtk.setFlfgtkcybz(dto.getFlfgtkcybz());
			dao.update(flfgtk);
		}else{  //添加操作
			String flfgtkid = DbUtils.getSequenceStr();
			Pflfgtk flfgtk = new Pflfgtk();
			BeanHelper.copyProperties(dto, flfgtk);
			flfgtk.setFlfgtkid(flfgtkid);
			dao.insert(flfgtk);
		}
	}
	
	/**
	 * 删除法律法规条款
	 */
	public String delPflfgtk(HttpServletRequest request,final PflfgtkDTO dto){
		try{
			delPflfgtkImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 删除法律法规条款实现方法
	 * @param request
	 * @param dto
	 */
	@Aop({"trans"})
	private void delPflfgtkImpl(HttpServletRequest request, PflfgtkDTO dto) {
		if(!(dto.getFlfgtkid() == null||"".equals(dto.getFlfgtkid()))){
			//删除信息
			dao.clear(Pflfgtk.class, Cnd.where("flfgtkid", "=", dto.getFlfgtkid()));
		}
	}
	
	/****************法律法规类别信息*************************/
	/**
	 * 查询法律法规类别信息
	 */
	public Map queryPflfglb(PflfglbDTO dto,PagesDTO pd) throws Exception{
		//使用字符串缓冲器类拼接查询sql语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfglbid,flfglbjb,flfglbbm,");
		sb.append(" flfglbmc,flfgczy,flfgczsj,parentnode,orderno ");
		sb.append(" from pflfglb flfglb");
		sb.append(" where 1=1");
		sb.append(" and flfglb.flfglbid = :flfglbid");
		sb.append(" and flfglb.flfglbjb = :flfglbjb");
		sb.append(" and flfglb.flfglbmc = :flfglbmc");
		sb.append(" order by flfglbid");
		String sql = sb.toString();
		String[] paramName = new String[]{"flfglbid","flfglbjb","flfglbmc"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PflfglbDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	
	/**
	 * 
	 * savePflfglb的中文名称：保存法律法规类别
	 * 
	 * savePflfglb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String savePflfglb(HttpServletRequest request, final Pflfglb dto) {
		try {
			String flag;
			if (null != dto.getFlfglbid()&&!"".equals(dto.getFlfglbid())) {
				Pflfglb se = dao.fetch(Pflfglb.class, dto.getFlfglbid());
				if (!(se.getFlfglbbm()).equalsIgnoreCase(dto.getFlfglbbm())) {
					flag = isExistsFlfglbbm(dto);
					if (flag != null) {
						return flag;
					}
				}
			} else {
				flag = isExistsFlfglbbm(dto);
				if (flag != null) {
					return flag;
				}
			}
			//调用实现类
		savePflfglbImp (request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	//保存法律法规实现类
	@Aop( { "trans" })
	public void savePflfglbImp(HttpServletRequest request, Pflfglb dto)
			throws Exception {
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		// 特殊处理一级菜单的父菜单ID
		if (StringHelper.cpObj(dto.getParentnode(), new Long(0))) {
			dto.setParentnode(null);
		}
		if (null != dto.getFlfglbid()&&!"".equals(dto.getFlfglbid())) {
			Pflfglb flfglb = dao.fetch(Pflfglb.class, dto.getFlfglbid());
			flfglb.setFlfgczy(sysuser.getUsername());
			flfglb.setFlfgczsj(datetime);
			BeanHelper.copyProperties(dto, flfglb);
			dao.update(flfglb);
		} else {
			Pflfglb flfglb = new Pflfglb();
			String flfglbid = DbUtils.getSequenceStr();
			dto.setFlfglbid(flfglbid);
			flfglb.setFlfgczy(sysuser.getUsername());
			flfglb.setFlfgczsj(datetime);
			BeanHelper.copyProperties(dto, flfglb);
			dao.insert(flfglb);
		}
	}
	
	/**
	 * 
	 * delPflfglb的中文名称：删除法律法规类别
	 * 
	 * delPflfglb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delPflfglb(HttpServletRequest request, final Pflfglb dto) {
		try {
			if (null != dto.getFlfglbid()&&!"".equals(dto.getFlfglbid())) {
				/*// 检查是否可删除
				List flfglbList = dao.query(Pflfglb.class, Cnd.where("flfglbid",
						"=", dto.getFlfglbid()));
				if (flfglbList != null && flfglbList.size() > 0) {
					return "该机构不允许被删除！";
				}*/
				//调用实现方法
				delPflfglbImp(request, dto);
			} else {
				return "没有接收到要删除的类别ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	//删除法律法规类别的实现方法
	@Aop( { "trans" })
	public void delPflfglbImp(HttpServletRequest request, final Pflfglb dto) {
		// 删除机构
		dao.clear(Pflfglb.class, Cnd.where("flfglbid", "=", dto.getFlfglbid()));
	}
	
	/**
	 * 
	 * queryPflfglbBylbbm的中文名称：查询法律法规类别通过类别编码
	 * 
	 * queryPflfglbBylbbm的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : CatchU
	 * 
	 */
	public Map queryPflfglbBylbbm(Pflfglb dto, PagesDTO pd) {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		c.and("lower(flfglbbm)", "=", dto.getFlfglbbm().toLowerCase());

		Map r = new HashMap();
		r.put("rows", dao.query(Pflfglb.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Pflfglb.class, c));
		return r;
	}
	/**
	 * 
	 * isExistsFlfglbbm的中文名称：校验法律法规类别编码是否存在
	 * 
	 * isExistsFlfglbbm的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 * Written by : CatchU
	 * 
	 */
	public String isExistsFlfglbbm(Pflfglb dto) throws Exception {
		// 校验法律法规类别是否已经存在
		PagesDTO pd = new PagesDTO();
		Map m = queryPflfglbBylbbm(dto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			return "该类别已存在，类别编码不能重复！";
		}
		return null;
	}
	/**
	 * 
	 * queryPflfglbZTree的中文名称：按Ztree插件格式构造法律法规类别树
	 * 
	 * queryPflfglbZTree的概要说明：
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 *             Written by : CatchU
	 * 
	 */
	public List queryPflfglbZTree(HttpServletRequest request) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select flfglbid,flfglbjb,flfglbbm,flfglbmc,");
		sb.append(" flfgczy,flfgczsj,parentnode,orderno,childnum,");
		sb.append(" case when childnum > 0 then 'true' else 'false' end isparent,");
		sb.append(" case when childnum > 0 then 'true' else 'false' end isopen ");
		sb.append(" from(");
		sb.append(" select t.flfglbid,t.flfglbjb,t.flfglbbm,t.flfglbmc,");
		sb.append(" t.flfgczy,t.flfgczsj,t.parentnode,t.orderno,");
		sb.append(" (select count(t1.flfglbid) from pflfglb t1 where t1.parentnode = t.flfglbid) childnum ");
		sb.append(" from pflfglb t ");
		sb.append(" ) h");
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				Pflfglb.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * queryPflfglbTree的中文名称：按easyui tree格式构造机构树
	 * 
	 * queryPflfglbTree的概要说明:
	 * 
	 * @return Written by : CatchU
	 * @throws Exception
	 * 
	 */
	public List queryPflfglbTree(HttpServletRequest request) throws Exception {
		List resLs = new ArrayList();
		List ls = queryPflfglbZTree(request);
		for (int i = 0; i < ls.size(); i++) {
			Pflfglb s = (Pflfglb) ls.get(i);
			if (s.getParentnode() == null || "".equals(s.getParentnode())
					|| (StringHelper.cpObj(s.getFlfglbjb(), "0"))) {   //类别级别是0 的是大类 在大类下面挂小类
				Map cm = new HashMap();
				cm.put("id", s.getFlfglbid());
				cm.put("text", s.getFlfglbmc());
				cm.put("children", getPflfglbChild(ls, s.getFlfglbid().toString()));
				resLs.add(cm);
			}
		}
		System.out.println(resLs);
		return resLs;
	}

	/**
	 * 
	 * getPflfglbChild的中文名称：递归调用
	 * 
	 * getPflfglbChild的概要说明：
	 * 
	 * @param pflfglblist
	 * @param parentnodeid
	 * @return Written by : CatchU
	 * 
	 */
	private List getPflfglbChild(List pflfglblist, final String parentnodeid) {
		List resLs = new ArrayList();
		for (int i = 0; i < pflfglblist.size(); i++) {
			Pflfglb s = (Pflfglb) pflfglblist.get(i);
			if (s.getParentnode() != null
					&& parentnodeid.equals(s.getParentnode().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getFlfglbid());
				cm.put("text", s.getFlfglbmc());
				if (s.getChildnum() > 0) {
					cm.put("children", getPflfglbChild(pflfglblist, s.getFlfglbid()
							.toString()));
				}
				resLs.add(cm);

			}
		}
		return resLs;
	}
	
	/**
	 * 查询法律法规类别信息ID，与用户通过getFlfglbid()相比对，最终在前台页面生成父类别ID的下拉菜单树
	 *//*
	public List<Long> queryPflfglbid() {
	    Sql sql = Sqls.create("SELECT f.flfglbid FROM pflfglb f ");
	    sql.setCallback(new SqlCallback() {
	    	
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<Long> list = new LinkedList<Long>();
	            while (rs.next())
	                list.add(rs.getLong("flfglbid"));
	            return list;
	        }
	    });
	    dao.execute(sql);
	    return sql.getList(Long.class);
	}*/
	
}
