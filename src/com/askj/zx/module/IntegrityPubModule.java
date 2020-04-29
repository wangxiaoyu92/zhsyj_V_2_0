package com.askj.zx.module;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.IntegrityPubDTO;
import com.askj.zx.service.IntegrityPubService;
import com.zzhdsoft.utils.SysmanageUtil;
/**
 * 征信公示查询
 * @author Administrator
 *
 */
@IocBean
@At("/zx/integritypub")
@Fail("jsp:/jsp/error/error")
public class IntegrityPubModule {
	protected final Logger logger = Logger.getLogger(IntegrityPubModule.class);
    //注入service 需要IOC的引导
	@Inject
	protected IntegrityPubService integrityPubService;
	/**
	 * 获取参数不需要手动获取有系统自动获取
	 *      返回json对象
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object findAllgs(@Param("..") IntegrityPubDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
			return integrityPubService.queryIntegrityPub(dto, pd); 
	}
	/**
	 * ok定义jsp所在的位置
	 * 并以/zx/integritypub/findAllgsIndex作为系统菜单访问本方法的路径
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/zx/integritypub/findAllgs")
	public void findAllgsIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	
	
	@At
	@Ok("json")
	public Object queryzxbusinesscode(@Param("..") IntegrityPubDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
			return integrityPubService.querybusinesscode(dto, pd) ; 
	}
	
	
	@At
	@Ok("jsp:/jsp/zx/integritypub/queryzxbusinesscode")
	public void  queryzxbusinesscodeIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	
	
	
	@At
	@Ok("json")
	public Object  updateIntegrityPubDTO ( HttpServletRequest request,
			@Param("..") IntegrityPubDTO dto) throws Exception {
			return SysmanageUtil.execAjaxResult( integrityPubService.UpdateIntegrityPub(
					request, dto));
	}
}
