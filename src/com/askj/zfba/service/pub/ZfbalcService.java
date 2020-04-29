package com.askj.zfba.service.pub;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.askj.zfba.dto.ZfbalcDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.zfba.entity.Zfajdj;
import com.askj.zx.entity.Zxpdcjxx;
import com.askj.zx.entity.Zxpdxmcs;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;

/**
 * 
 * NewsService的中文名称：新闻管理service
 * 
 * NewsService的描述：
 * 
 * Written by : gjf
 */
public class ZfbalcService extends BaseService {
	protected final Logger logger = Logger.getLogger(ZfbalcService.class);
	@Inject
	private Dao dao;
		
	/**
	 * 
	 * saveAjjs的中文名称：保存案件结束
	 * 
	 * saveAjjs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */

	public String saveAjjs(HttpServletRequest request, ZfbalcDTO dto) {
		try {
			saveAjjsImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void saveAjjsImp(HttpServletRequest request, ZfbalcDTO dto)
			throws Exception {
         if (dto.getZxxmcsbm()!=null && !"".equals(dto.getZxxmcsbm())){
        	Sysuser vSysUser = SysmanageUtil.getSysuser();
        	String v_sql="";
        	v_sql="select a.* from zfajdj a where a.ajdjid='"+dto.getAjdjid()+"'"; 
        	Zfajdj v_Zfajdj=(Zfajdj) DbUtils.getDataList(v_sql, Zfajdj.class).get(0);
        	
        	String v_ymd=SysmanageUtil.getDbtimeYmd();
        	String v_ymdhns=SysmanageUtil.getDbtimeYmdHns();
        	
        	v_sql="select a.* from zxpdxmcs a where a.xmcsbm='"+dto.getZxxmcsbm()+"' and a.xmcsksrq<='"+v_ymd
        	      +"' and (a.xmcsjsrq is null or a.xmcsjsrq>='"+v_ymd+"')"; 
        	Zxpdxmcs v_Zxpdxmcs=(Zxpdxmcs) DbUtils.getDataList(v_sql, Zxpdxmcs.class).get(0);	
        	
        	Zxpdcjxx v_zxpdcjxx=new Zxpdcjxx(); 
        	String v_cjid = DbUtils.getSequenceStr();
        	v_zxpdcjxx.setCjid(v_cjid);
        	v_zxpdcjxx.setComid(v_Zfajdj.getComid());
        	v_zxpdcjxx.setXmcsdm(dto.getZxxmcsbm());
        	v_zxpdcjxx.setCjdf(v_Zxpdxmcs.getXmcsfz());
        	v_zxpdcjxx.setCzyxm(vSysUser.getDescription());
        	v_zxpdcjxx.setCzsj(v_ymdhns);
        	v_zxpdcjxx.setBeizhu("执法办案系统生成");
        	v_zxpdcjxx.setNiandu(v_ymd.substring(0,4));
        	v_zxpdcjxx.setSjly("0");
        	
        	dao.insert(v_zxpdcjxx);
        	
        	//将案件结束标志打上
			v_sql="update zfajdj a set a.ajjsbz='1' where a.ajdjid='"+dto.getAjdjid()+"'";
			Sql sql = Sqls.create(v_sql);
			dao.execute(sql);        	
         }
	}
	
}
