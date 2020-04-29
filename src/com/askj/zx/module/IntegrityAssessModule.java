package com.askj.zx.module;

 

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxIntegrityDTO;
import com.askj.zx.entity.Zxintegrityassess;
import com.askj.zx.service.IntegrityassessService;
import com.zzhdsoft.utils.SysmanageUtil;
/**
 * 诚信评估
 * @author lfy
 *
 */
@IocBean
@At("/zx/IntegrityAssess")
@Fail("jsp:/jsp/error/error")
public class IntegrityAssessModule extends BaseModule{
	@Inject
	private IntegrityassessService integrityassessService;
	
	@At
	@Ok("jsp:/jsp/zx/integrityassess")
	public void init() throws Exception{
		
	}
	/**
	 * 查询诚信评估信息
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryIntegrityAssessInfo(@Param("..") ZxIntegrityDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		
		return integrityassessService.queryIntegrityAssessInfo(dto, pd); 
	}
	/**
	 * 返回页面
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/zx/integrityassess/integrity")
	public void integrityIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *  保存诚信评估信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public Object savaIntegrity(HttpServletRequest request,
			@Param("..") Zxintegrityassess dto){
		return SysmanageUtil.execAjaxResult(integrityassessService.saveZxIntegrity(request, dto));
		
	}
	
}
