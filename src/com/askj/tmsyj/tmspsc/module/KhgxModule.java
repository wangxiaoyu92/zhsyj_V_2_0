package com.askj.tmsyj.tmspsc.module; 

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.tmsyj.tmsyj.dto.HjgztkhgxDTO;
import com.askj.tmsyj.tmspsc.service.KhgxService; 
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
/**
 * 
 * 
 *  KhgxModule的中文名称：客户管理
 *
 *  KhgxModule的描述：
 *
 *  @author : ly
 *  @version : V1.0
 */
@IocBean
@At("/khgx")
public class KhgxModule extends BaseModule{
    @Inject
	private KhgxService khgxService;
    /**
	 * 
	 *  ListIndex的中文名称：客户关系主页
	 * 
	 *  ListIndex的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
     */
	@At
	@Ok("jsp:/jsp/tmsyj/tmspsc/khgx/khgxMain")
    public void khgxMainIndex() {}
	
	/** 
	 * 
	 *  khgxFromIndex的中文名称：客户关系 附页
	 * 
	 *  khgxFromIndex的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmspsc/khgx/khgxFrom")
	public void khgxFrom() {}
	
	/**
	 * 
	 * 
	 *  queryKhgxList的中文名称 ：客户关系查询
	 * 
	 *  queryKhgxList的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryKhgxList(HttpServletRequest request, 
			@Param("..") HjgztkhgxDTO dto,@Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = khgxService.queryKhgxList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		} 
	}
	/**
	 * 
	 * 
	 *  saveKhgx的中文名称：添加客户关系
	 * 
	 *  saveKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object saveKhgx(HttpServletRequest request, @Param("..") HjgztkhgxDTO dto) {
		return SysmanageUtil.execAjaxResult(khgxService.saveKhgx(request, dto));
	}
	/**
	 * 
	 * 
	 *  delKhgx的中文名称：删除客户关系
	 * 
	 *  delKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object delKhgx(HttpServletRequest request, @Param("..") HjgztkhgxDTO dto) {
		return SysmanageUtil.execAjaxResult(khgxService.delKhgx(dto));
	}
	
}
