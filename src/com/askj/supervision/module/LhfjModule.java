package com.askj.supervision.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BschecklhfjDTO;
import com.askj.supervision.dto.LhfjcxDTO;
import com.askj.supervision.service.LhfjService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 量化分级 控制层
 * 
 * @author CatchU
 * 
 */
@IocBean
@At("/lhfj")
public class LhfjModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(LhfjModule.class);

	@Inject
	private LhfjService lhfjService;
	
	/**
	 * 企业导入
	 * @param request
     */
	@At
	@Ok("jsp:/jsp/supervision/lhfj/lhfjtj")
	public void lhfjtjIndex(HttpServletRequest request) {
		// 用于页面跳转
	}
	
	
	/**
	 * 查询量化分级统计
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryLhfjtj(HttpServletRequest request, @Param("..") BschecklhfjDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map =  lhfjService.queryLhfjtj(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 量化分级查询
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryLhfjcx(HttpServletRequest request, @Param("..") LhfjcxDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = lhfjService.queryLhfjcx(request, dto, pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
	 * 企业导入
	 * @param request
     */
	@At
	@Ok("jsp:/jsp/supervision/lhfj/lhfjcx")
	public void lhfjcxIndex(HttpServletRequest request) {
		// 用于页面跳转
	}	
	
	/**
	 * 企业导入
	 * @param request
     */
	@At
	@Ok("jsp:/jsp/supervision/lhfj/lhfjnddtpj")
	public void lhfjnddtpjIndex(HttpServletRequest request) {
		// 用于页面跳转
	}
	
    /**
     * 保存物品清单
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveCreateNddj(HttpServletRequest request, @Param("..") BschecklhfjDTO dto) {
		return SysmanageUtil.execAjaxResult(lhfjService.saveCreateNddj(request, dto));
    }
    
}
