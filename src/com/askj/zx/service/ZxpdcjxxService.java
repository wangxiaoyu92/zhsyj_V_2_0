package com.askj.zx.service;
import java.sql.Timestamp;
import java.sql.Types; 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpdcjxxDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.zx.entity.Zxpdcjxx;
import com.askj.zx.entity.Zxpdxmcs;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
public class ZxpdcjxxService extends BaseService{

	//dao注入
		@Inject
		private Dao dao;
		/**
		 * 查询
		 */  
		@SuppressWarnings({ "unchecked", "rawtypes" })
		public Map queryZxpdcjxx(ZxpdcjxxDTO dto, PagesDTO pd) throws Exception{
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT z.cjid,z.comid ,z.cjdf,z.czyxm ,z.czsj,z.beizhu,z.niandu,z.sjly , ");
			sb.append(" (SELECT p.commc FROM pcompany p WHERE p.comid=z.comid) commc , "); 
			sb.append(" (SELECT x.xmcsmc FROM zxpdxmcs x WHERE x.xmcsbm=z.xmcsdm  AND x.cssyzt=1)  xmcsdm  "); 
			sb.append(" FROM zxpdcjxx z, pcompany p ");
			 sb.append(" WHERE 1=1 AND p.comid=z.comid AND z.niandu=:niandu  AND z.cjid=:cjid ");
			 if (dto.getCommc()!=null && !dto.getCommc().equals("")){
					sb.append("  and commc like :commc ");
					dto.setCommc('%'+dto.getCommc()+'%');
				}
			 sb.append("order by czsj desc");
			String sql = sb.toString();
			String[] ParaName = new String[] { "niandu", "commc","cjid"};
			int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR  };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpdcjxxDTO.class, pd.getPage(), pd.getRows());
			List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
			Map r = new HashMap();
			r.put("rows", ls);
			r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
			return r;
		} 
		
		
	/**
	 * 采集信息	
	 */
		public String saveZxpdcjxx(HttpServletRequest request,final ZxpdcjxxDTO dto){
			try{ 
				zxpdcjxxImpl(request,dto);
			}catch(Exception e){
				return Lang.wrapThrow(e).getMessage();
			}
			return null;
		}
		
		/** 
		 * 使用事务控制
		 * @param request
		 * @param dto
		 * @throws Exception 
		 */
		@Aop({"trans"})
		public void zxpdcjxxImpl(HttpServletRequest request, ZxpdcjxxDTO dto) throws Exception {
			Timestamp cz  = SysmanageUtil.currentTime();	//获取当前操作时间
			String czsj=cz .toString(); 
			String niandu=czsj.substring(0,4);
			if (null == dto.getCjid() || "".equals(dto.getCjid())) {
			Sysuser User=(Sysuser)SysmanageUtil.getSysuser();
			  Zxpdcjxx zxpd  = new Zxpdcjxx();
			  BeanHelper.copyProperties(dto, zxpd );  //拷贝对应的从前台传来的数据
			  String cj = DbUtils.getSequenceStr();
			   
			    zxpd.setCjid(cj.toString());
			    zxpd.setCzsj(czsj);
			    zxpd.setNiandu(niandu);
			    zxpd.setCzyxm(User.getUsername());
			    zxpd.setSjly("1");
				dao.insert(zxpd);
			}else{
				
				Zxpdcjxx zxpd  =dao.fetch(Zxpdcjxx.class, Cnd.where("cjid","=",dto.getCjid()));
				
				  //BeanHelper.copyProperties(dto, zxpd );	
				zxpd.setCzsj(czsj);
				zxpd.setNiandu(niandu);
				zxpd.setComid(dto.getComid());
				zxpd.setCjid(dto.getCjid());
				zxpd.setBeizhu(dto.getBeizhu());
				zxpd.setCzyxm(dto.getCzyxm());
				zxpd.setXmcsdm(dto.getXmcsdm());
				zxpd.setCjdf(dto.getCjdf());
				  dao.update(zxpd);
			}
				
			}
		
		
		
		
		public String cjxxdel(HttpServletRequest request, ZxpdcjxxDTO dto) {
			try {
				if (null != dto.getCjid()) { 
					delImp(request, dto);
				} else {
					return "没有接收到要删除的采集信息的ID！";
				}
			} catch (Exception e) {
				return Lang.wrapThrow(e).getMessage();
			}
			return null;
		}

		@Aop( { "trans" })
		public void delImp(HttpServletRequest request, ZxpdcjxxDTO dto) {
			// 删除采集信息
			dao.clear(Zxpdcjxx.class, Cnd.where("cjid", "=", dto.getCjid()));
		}
 
		/*
		 * **********************项目参数维护***********************
		 */
		
		 
		//征信评定参数维护   insert
		public String addZxpdxmcs(HttpServletRequest request,final ZxpdcjxxDTO dto){
			try{ 
				zxpdxmcsImpl(request,dto);
			}catch(Exception e){
				return Lang.wrapThrow(e).getMessage();
			}
			return null;
		}
		
		/** 
		 * 使用事务控制
		 * @param request
		 * @param dto
		 * @throws Exception 
		 */
		@Aop({"trans"})
		public void zxpdxmcsImpl(HttpServletRequest request, ZxpdcjxxDTO dto) throws Exception   {
			String sj=SysmanageUtil.getDbtimeYmdHns();	//获取当前操作时间 
			Condition cnd = Cnd.where("  cssyzt='1'  and xmcsbm", "=", dto.getXmcsbm() );
			Zxpdxmcs ls = dao.fetch(Zxpdxmcs.class, cnd);
			if (null == dto.getXmcsid()) {
				if (null == ls ) { 
					addxmcs(request,dto);
				}else{  
					Zxpdxmcs xmcs = new Zxpdxmcs();//dao.fetch(Zxpdxmcs.class, dto.getXmcsbm());
					xmcs.setXmcsid(ls.getXmcsid());
					xmcs.setXmcsbm(ls.getXmcsbm());
					xmcs.setCzyxm(ls.getCzyxm());
					xmcs.setXmcsfz(ls.getXmcsfz());
					xmcs.setXmcsksrq(ls.getXmcsksrq());
					xmcs.setXmcsmc(ls.getXmcsmc());
					xmcs.setCzsj(ls.getCzsj());
					xmcs.setCssyzt("0");
						xmcs.setSystemcode(ls.getSystemcode());
					xmcs.setXmcsjsrq(sj);
					xmcs.setXmcszxt("");
					dao.update(xmcs);
//					Zxpdxmcs xm=dao.fetch(Zxpdxmcs.class, dto.getXmcsbm());
//					BeanHelper.copyProperties(dto, xm);
					addxmcs(request,dto); 
				}				
			}	
			} 
		
		
		public void addxmcs(HttpServletRequest request, ZxpdcjxxDTO dto) throws Exception{
			String sj=SysmanageUtil.getDbtimeYmdHns();	 
			Sysuser User=(Sysuser)SysmanageUtil.getSysuser();
			Zxpdxmcs xmcs  = new Zxpdxmcs();
			String cj = DbUtils.getSequenceStr(); 
			xmcs.setXmcsid(cj);
			xmcs.setCzsj(sj);
			xmcs.setCzyxm(User.getUsername());
			xmcs.setXmcsbm(dto.getXmcsbm());
			xmcs.setXmcsfz(dto.getXmcsfz()); 
			xmcs.setXmcsksrq(sj);
			xmcs.setXmcsmc(dto.getXmcsmc());
			xmcs.setSystemcode(dto.getSystemcode());
			xmcs.setCssyzt("1");
			xmcs.setXmcszxt("");
			dao.insert(xmcs); 
		}
		/**
		 * 
		 *  Zxpdxmcs的中文名称：查出项目参数
		 *  Zxpdxmcs的概要说明：
		 *  @param dto
		 *  @param pd
		 *  @return
		 *  @throws Exception
		 *  Written by:ly
		 */
		@SuppressWarnings({ "unchecked", "rawtypes" })
		public Map  Zxpdxmcs(ZxpdcjxxDTO dto, PagesDTO pd) throws Exception{
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT zz.*  FROM zxpdxmcs zz  WHERE  1=1");
			sb.append(" AND xmcsid=:xmcsid AND xmcsbm=:xmcsbm  AND cssyzt=:cssyzt"); 
			 if (dto.getXmcsmc()!=null && !dto.getXmcsmc().equals("")){
					sb.append("  and xmcsmc like :xmcsmc"); 
					dto.setCommc('%'+dto.getXmcsmc()+'%');
				}
			String sql = sb.toString();
			String[] ParaName = new String[] { "xmcsid","xmcsbm","xmcsmc" ,"cssyzt" };
			int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpdcjxxDTO.class, pd.getPage(), pd.getRows());
			List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
			Map r = new HashMap();
			r.put("rows", ls);
			r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
			return r;
		} 
		/**
		 * 
		 *  update的中文名称：更新参数
		 *  update的概要说明：
		 *  @param request
		 *  @param dto
		 *  @throws Exception
		 *  Written by:ly
		 */
		public String xmcsupdate(HttpServletRequest request, ZxpdcjxxDTO dto) throws Exception{
//			Zxpdxmcs ls = dao.fetch(Zxpdxmcs.class, dto.getXmcsid());
			String sj=SysmanageUtil.getDbtimeYmdHns();
			//int result=ls.getXmcsjsrq().compareTo(sj);
			//System.out.println(result<0);
     		//int result2=ls.getXmcsjsrq().compareTo(sj);
			if(dto.getXmcsksrq().compareTo(sj)<0 && (null==dto.getXmcsjsrq()||
					"".equals(dto.getXmcsjsrq())||dto.getXmcsjsrq().compareTo(sj)>0)){
				Zxpdxmcs xmcs = new Zxpdxmcs();//dao.fetch(Zxpdxmcs.class, dto.getXmcsbm());
				xmcs.setXmcsid(dto.getXmcsid());
				xmcs.setXmcsbm(dto.getXmcsbm());
				xmcs.setCzyxm(dto.getCzyxm());
				xmcs.setXmcsfz(dto.getXmcsfz());
				xmcs.setXmcsksrq(dto.getXmcsksrq());
				xmcs.setXmcsmc(dto.getXmcsmc());
				xmcs.setCzsj(dto.getCzsj());
				xmcs.setXmcsjsrq(dto.getXmcsjsrq()==""? null:dto.getXmcsjsrq() );
				xmcs.setCssyzt(dto.getCssyzt());
				xmcs.setSystemcode(dto.getSystemcode());
				xmcs.setXmcszxt("");
				dao.update(xmcs);
			  	return null;
     		}else{
     			return "请检查您的时间范围";
     		}
		}
		/**
		 * 
		 *  xmcsdel的中文名称：删除项目参数
		 *  xmcsdel的概要说明：
		 *  @param request
		 *  @param dto
		 *  @return
		 *  Written by:ly
		 */
		public String xmcsdel(HttpServletRequest request, ZxpdcjxxDTO dto) {
			try {
				if (null != dto.getXmcsid()) { 
					dImp(request, dto);
				} else {
					return "没有接收到要删除的项目参数的ID！";
				}
			} catch (Exception e) {
				return Lang.wrapThrow(e).getMessage();
			}
			return null;
		}

		@Aop( { "trans" })
		public void dImp(HttpServletRequest request, ZxpdcjxxDTO dto) {
			// 删除采集信息
			dao.clear(Zxpdxmcs.class, Cnd.where("xmcsid", "=", dto.getXmcsid()));
		}
		
		/**
		 * 
		 *  xmcsbox的中文名称：项目参数下拉框
		 *  xmcsbox的概要说明：
		 *  @param dto
		 *  @param pd
		 *  @return
		 *  @throws Exception
		 *  Written by:ly
		 */
		@SuppressWarnings({ "unchecked", "rawtypes" })
		public Map xmcsbox(ZxpdcjxxDTO dto, PagesDTO pd) throws Exception{
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT z.cjid,z.comid ,z.cjdf,z.czyxm ,z.czsj,z.beizhu,z.niandu,z.sjly , ");
			sb.append(" (SELECT p.commc FROM pcompany p WHERE p.comid=z.comid) commc , "); 
			sb.append(" (SELECT x.xmcsbm FROM zxpdxmcs x WHERE x.xmcsbm=z.xmcsdm  AND x.cssyzt=1)  xmcsdm  "); 
			sb.append(" FROM zxpdcjxx z, pcompany p ");
			 sb.append(" WHERE 1=1 AND p.comid=z.comid AND z.niandu=:niandu  AND z.cjid=:cjid ");
			 if (dto.getCommc()!=null && !dto.getCommc().equals("")){
					sb.append("  and commc like :commc ");
					dto.setCommc('%'+dto.getCommc()+'%');
				}
			 sb.append("order by czsj desc");
			String sql = sb.toString();
			String[] ParaName = new String[] { "niandu", "commc","cjid"};
			int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR  };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpdcjxxDTO.class, pd.getPage(), pd.getRows());
			List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
			Map r = new HashMap();
			r.put("rows", ls);
			r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); 
			return r;
		}
}	 	
		
 
