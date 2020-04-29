package com.askj.tmsyj.tmcy.service;

import java.io.File;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;   
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;

import com.askj.tmsyj.tmcy.dto.HcycdDTO;
import com.askj.tmsyj.tmcy.dto.HcyjxxjlDTO;
import com.askj.tmsyj.tmcy.dto.HsplyDTO;
import com.askj.tmsyj.tmcy.dto.HyzcpDTO;
import com.askj.tmsyj.tmcy.entity.Hcycd; 
import com.askj.tmsyj.tmcy.entity.Hcyjxxjl;
import com.askj.tmsyj.tmcy.entity.Hsply;
import com.askj.tmsyj.tmcy.entity.Hyzcp;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  HcycdService的中文名称：
 *
 *  HcycdService的描述：
 *
 *  @author : ly
 *  @version : V1.0
 */
@IocBean
public class HcycdService {
	protected final Logger logger = Logger.getLogger(HcycdService.class);
	@Inject
	private Dao dao;
	/**
	 * 
	 * QueryCd的中文名称：查询菜谱
	 * 
	 * QueryCd的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map QueryCd(HttpServletRequest request, HcycdDTO dto, PagesDTO pd) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		dto.setComid(sysuser.getAaz001());
		/*
		if("6".equals(sysu.getUserkind())){ 
		}*/
		StringBuffer sb = new StringBuffer();
		sb.append(" select cd.*,p.commc, ");
		sb.append(" getAa10_aaa103('caixi', cd.caixi) caixiinfo,");
		sb.append(" getAa10_aaa103('caipingl', cd.caipingl) caipinglinfo");
		sb.append(" from hcycd cd,pcompany p  where cd.comid=p.comid ");
		sb.append(" and cd.hcycdid = :hcycdid ");
		sb.append(" and cd.comid = :comid ");
		sb.append(" and cd.cpmc like :cpmc ");
		sb.append(" and  order by aae036 desc ");
		String[] ParaName = new String[] { "hcycdid", "comid", "cpmc" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, HcycdDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 * SaveDd的中文名称：保存一条菜谱
	 * 
	 * SaveDd的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String Savecd(HttpServletRequest request, HcycdDTO dto){
		try {
			SaveCdImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * SaveCdImpl的中文名称：事物控制添加菜单
	 * 
	 * SaveCdImpl的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : ly
	 */
	@Aop("trans")
	public void SaveCdImpl(HttpServletRequest request, HcycdDTO dto) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		//获取操作时间
		Timestamp currTime = SysmanageUtil.currentTime();
		
		if (!"".equals(dto.getHcycdid()) && dto.getHcycdid() != null) {
			Hcycd cd = dao.fetch(Hcycd.class, dto.getHcycdid());
			BeanHelper.copyProperties(dto, cd); 
			cd.setComid(sysuser.getAaz001()); //zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
			cd.setAae011(sysuser.getUsername());
			cd.setAae036(currTime);
			dao.update(cd);
		} else { 
			Hcycd cd = new Hcycd();
			BeanHelper.copyProperties(dto, cd);
			cd.setComid(sysuser.getAaz001()); //zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
			cd.setHcycdid(DbUtils.getSequenceStr());
			cd.setAae011(sysuser.getUsername());
			cd.setAae036(currTime);
			dao.insert(cd);
		}
	}
	
	/**
	 * 
	 * DelCd的中文名称：删除菜谱中的一条
	 * 
	 * DelCd的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String DelCd(HttpServletRequest request, HcycdDTO dto){
		try {
			DelCdImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * DelCdImpl的中文名称：删除菜谱中的一条
	 * 
	 * DelCdImpl的概要说明：
	 *
	 * @param dto
	 * @throws Exception
	 * @author : ly
	 */
	public void DelCdImpl(HttpServletRequest request, HcycdDTO dto) throws Exception{
		if (dto.getHcycdid() != null && !"".equals(dto.getHcycdid())) {
			// 删除菜单附件
			List<Fj> v_listFj = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getHcycdid()));
			for (Fj v_fj : v_listFj){
				// 刪除服務器上的附件
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				v_fj.setFjpath(rootPath + File.separator + v_fj.getFjpath());
				File file = new File(v_fj.getFjpath());
				if (file.exists()) {
					file.delete();
				}
				dao.delete(v_fj);			
			}				
			//删除人员信息
			dao.clear(Hcycd.class,Cnd.where("hcycdid", "=", dto.getHcycdid()));
		}
	}
	/**
	 * 
	 * QuerySply的中文名称：查询食品留样
	 * 
	 * QuerySply的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map QuerySply(HttpServletRequest request, 
			HsplyDTO dto , PagesDTO pd) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		dto.setComid(sysuser.getAaz001());
		StringBuffer sb = new StringBuffer(); 
		sb.append(" select ly.*, p.commc, ");
		sb.append(" getAa10_aaa103('jccc', ly.jccc) jcccinfo, ");
		sb.append(" (select max(fjpath) from Fj t where t.fjwid=ly.hsplyid) as icon ");
		sb.append(" from hsply ly ,pcompany p where ly.comid=p.comid "); 
    	sb.append(" and ly.hsplyid =:hsplyid ");
 	    sb.append(" and ly.comid =:comid ");
 	    sb.append(" and ly.splypz =:splypz ");
 	    sb.append(" and  order by aae036 desc ");
		String[] ParaName = new String[]{ "hsplyid", "comid", "splypz" };
		int[] ParaType = new int[]{ Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, HsplyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * SaveSply的中文名称：保存或更新
	 * 
	 * SaveSply的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String SaveSply(HttpServletRequest request, HsplyDTO dto){
		try {
			SaveSplyImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * SaveSplyImpl的中文名称：保存或更新留样食品
	 * 
	 * SaveSplyImpl的概要说明：
	 *
	 * @param dto
	 * @throws Exception
	 * @author : ly
	 */
	@Aop("trans")
	public void SaveSplyImpl(HttpServletRequest request, HsplyDTO dto) throws Exception{ 
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		//获取操作时间
		Timestamp currTime = SysmanageUtil.currentTime();
		if(!"".equals(dto.getHsplyid()) && dto.getHsplyid() != null){
			Hsply sply = dao.fetch(Hsply.class, dto.getHsplyid());
			BeanHelper.copyProperties(dto, sply);
			sply.setAae011(sysuser.getUsername());
			sply.setAae036(currTime);
			dao.update(sply);
		}else{ 
			Hsply sply = new Hsply();
			BeanHelper.copyProperties(dto, sply);
			sply.setComid(sysuser.getAaz001()); // zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
			sply.setHsplyid(DbUtils.getSequenceStr());
			sply.setAae011(sysuser.getUsername());
			sply.setAae036(currTime);
			dao.insert(sply);
		}
	}
	/**
	 * 
	 * DelLysp的中文名称：删除留样食品
	 * 
	 * DelLysp的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String DelSply(HttpServletRequest request, HsplyDTO dto){
		try {
			DelLyspImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * DelLyspImpl的中文名称：删除留样食品
	 * 
	 * DelLyspImpl的概要说明：
	 *
	 * @param dto
	 * @throws Exception
	 * @author : ly
	 */
	@Aop("trans")
	public void DelLyspImpl(HttpServletRequest request, HsplyDTO dto) throws Exception{
        if (dto.getHsplyid() != null && !"".equals(dto.getHsplyid())) {
			// 删除食品留样附件
			List<Fj> v_listFj = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getHsplyid()));
			for (Fj v_fj : v_listFj){
				// 刪除服務器上的附件
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				v_fj.setFjpath(rootPath + File.separator + v_fj.getFjpath());
				File file = new File(v_fj.getFjpath());
				if (file.exists()) {
					file.delete();
				}
				dao.delete(v_fj);			
			}				
			//删除留样信息
			dao.clear(Hsply.class,Cnd.where("hsplyid", "=", dto.getHsplyid()));
		}
	}
	
	/**
	 * 
	 * QueryYzcp的中文名称：查询一周菜谱
	 * 
	 * QueryYzcp的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map QueryYzcp(HttpServletRequest request, HyzcpDTO dto, PagesDTO pd) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("用户id不能为空");
			}
		}
		dto.setComid(sysuser.getAaz001());
		StringBuffer sb = new StringBuffer();
		sb.append(" select cp.*,");
		sb.append(" getAa10_aaa103('jccc', cp.jccc) jcccinfo");
		sb.append(" from Hyzcp cp ,pcompany p  where cp.comid=p.comid  ");
		sb.append(" and cp.hyzcpid =:hyzcpid ");
		sb.append(" and cp.comid =:comid ");
		sb.append(" and cp.cpmc like :cpmc ");
		sb.append(" and order by aae036 desc ");
		String[] ParaName = new String[]{ "hyzcpid", "comid", "cpmc" };
		int[] ParaType = new int[]{ Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, HyzcpDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * SaveYzcp的中文名称：保存或更新一周菜谱
	 * 
	 * SaveYzcp的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String SaveYzcp(HttpServletRequest request, HyzcpDTO dto){
		try {
			SaveYzcpImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop("trans")
	public void SaveYzcpImpl(HttpServletRequest request, HyzcpDTO dto) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		//获取操作时间
		Timestamp currTime = SysmanageUtil.currentTime();
		if ("".equals(dto.getCprq())){
			dto.setCprq(null);
		}
		 if(dto.getHyzcpid() != null && !"".equals(dto.getHyzcpid())){
			 Hyzcp cp = dao.fetch(Hyzcp.class, dto.getHyzcpid());
			 BeanHelper.copyProperties(dto, cp);
			 cp.setAae011(sysuser.getUsername());
			 cp.setAae036(currTime);
			 dao.update(cp);
		 }else{
			 Hyzcp cp = new Hyzcp();
			 BeanHelper.copyProperties(dto, cp);
			 cp.setComid(sysuser.getAaz001()); // zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
			 cp.setHyzcpid(DbUtils.getSequenceStr());
			 cp.setAae011(sysuser.getUsername());
			 cp.setAae036(currTime);
			 dao.insert(cp);
		 }
	}
	
	/**
	 * 
	 * DelYzcp的中文名称：删除一周菜谱中的一条信息
	 * 
	 * DelYzcp的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String DelYzcp(HttpServletRequest request, HyzcpDTO dto){
		try {
			DelYzcpImpl(request, dto);
		} catch (Exception e) { 
			return Lang.wrapThrow(e).getMessage();
		}
		return null; 
	}
	@Aop("trans")
	public void DelYzcpImpl(HttpServletRequest request, HyzcpDTO dto) throws Exception{
		if (dto.getHyzcpid() != null && !"".equals(dto.getHyzcpid())) {
			// 删除一周菜谱附件
			List<Fj> v_listFj = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getHyzcpid()));
			for (Fj v_fj : v_listFj){
				// 刪除服務器上的附件
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				v_fj.setFjpath(rootPath + File.separator + v_fj.getFjpath());
				File file = new File(v_fj.getFjpath());
				if (file.exists()) {
					file.delete();
				}
				dao.delete(v_fj);			
			}				
			//删除留样信息
			dao.clear(Hyzcp.class,Cnd.where("hyzcpid", "=", dto.getHyzcpid()));
		}
	}
	
	/**
	 * 
	 * QueryXxjl的中文名称：查询餐饮具洗消记录
	 * 
	 * QueryXxjl的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map QueryXxjl(HttpServletRequest request, HcyjxxjlDTO dto,PagesDTO pd) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if("6".equals(sysuser.getUserkind())){ 
			dto.setComid(sysuser.getAaz001());
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select jl.*,p.commc,(select aaa103 from aa10 a where a.aaa100='xdfs' and jl.xdfs=a.aaa102 ) xdfsinfo ");
		sb.append(" from hcyjxxjl jl,pcompany p where p.comid=jl.comid "); 
		sb.append(" and jl.hcyjxxjlid = :hcyjxxjlid ");  
		sb.append(" and jl.comid = :comid "); 
		sb.append(" and  order by aae036 desc ");
		String[] ParaName = new String[]{"hcyjxxjlid","comid" };
	    int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR };
	    String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, HcyjxxjlDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * SaveXxjl的中文名称：保存或更新一条洗消记录
	 * 
	 * SaveXxjl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String SaveXxjl(HttpServletRequest request, HcyjxxjlDTO dto){
		try {
			SaveXxjlImpl(request, dto);
		} catch (Exception e) { 
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	public void SaveXxjlImpl(HttpServletRequest request, HcyjxxjlDTO dto) throws Exception{
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		Hcyjxxjl xxjl = new Hcyjxxjl();
		if (!"".equals(dto.getHcyjxxjlid()) && dto.getHcyjxxjlid() != null) {
	        //xxjl = new Hcyjxxjl();
	        BeanHelper.copyProperties(dto, xxjl);
	        dao.update(xxjl);
		}else{
			//获取操作时间
			Timestamp startTime = SysmanageUtil.currentTime();
			BeanHelper.copyProperties(dto, xxjl);
			xxjl.setComid(sysuser.getAaz001());//zjf备注：企业操作员注册用户的时候，启用aaz001（组织ID）存放comid；
            xxjl.setAae011(sysuser.getUsername());
            xxjl.setAae036(startTime);
            xxjl.setHcyjxxjlid(DbUtils.getSequenceStr());
            dao.insert(xxjl);
		}
	}
	
	public String DelXxjl(HcyjxxjlDTO dto){
        try {
			DelXxjlImpl(dto);
		} catch (Exception e) { 
			return Lang.wrapThrow(e).getMessage();
		}		
		return null;
	}
	
	public void DelXxjlImpl(HcyjxxjlDTO dto) throws Exception{
		 if (!"".equals(dto.getHcyjxxjlid()) && dto.getHcyjxxjlid() != null) {
			Hcyjxxjl jl = dao.fetch(Hcyjxxjl.class,dto.getHcyjxxjlid());
			if (jl != null) {
				dao.delete(Hcyjxxjl.class, dto.getHcyjxxjlid());
			}else{
				throw new BusinessException("没有这条洗消记录！！！");
			}
		 }else{
			 throw new BusinessException("洗消记录ID不能为空！！！");
		 }
		
	}
}
