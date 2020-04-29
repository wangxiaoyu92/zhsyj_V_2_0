package com.askj.zx.module;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpddjcsDTO;
import com.askj.zx.service.ZxpddjcsService;
import com.zzhdsoft.utils.SysmanageUtil;

import common.Logger;

/**
 * 征信评定等级参数 控制层
 * @author CatchU
 *
 */
@IocBean
@At("zx/zxpddjcs")
@Fail("jsp:/jsp/error/error")
public class ZxpddjcsModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(ZxpddjcsModule.class);
	
	@Inject
	private ZxpddjcsService zxpddjcsService;
	
	/**
	 * 跳转到评定等级参数页
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpddjcs/zxpddjcs")
	public void zxpddjcsIndex(HttpServletRequest request){
		//跳转
	} 
	
	/**
	 * 跳转到评定等级参数详情页
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpddjcs/zxpddjcsForm")
	public void zxpddjcsFormIndex(HttpServletRequest request){
		//跳转
	}
	
	/**
	 * 查询征信评定等级参数信息
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryZxpddjcs(@Param("..") ZxpddjcsDTO dto,@Param("..") PagesDTO pd) throws Exception{
		return SysmanageUtil.execAjaxResult(zxpddjcsService.query(dto, pd), null);
	}
	
	/**
	 * 查询征信评定等级参数，用于回显
	 */
	@At
	@Ok("json")
	public Object queryZxpddjcsDTO(HttpServletRequest request,@Param("..") ZxpddjcsDTO dto,@Param("..")PagesDTO pd){
		Map map = new HashMap();
		try {
			map = zxpddjcsService.query(dto, pd);
			List list = (List) map.get("rows");
			ZxpddjcsDTO djcsDto = null;
			if(list!=null && list.size()>0){
				djcsDto = (ZxpddjcsDTO) list.get(0);
			}
			map.put("data", djcsDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 保存或更新评定等级参数
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object saveZxpddjcs(HttpServletRequest request,@Param("..") ZxpddjcsDTO dto){
		return SysmanageUtil.execAjaxResult(zxpddjcsService.saveZxpddjcs(request,dto));
	}
	
	/**
	 * 删除评定等级参数
	 */
	@At
	@Ok("json")
	public Object delZxpddjcs(HttpServletRequest request,@Param("..") ZxpddjcsDTO dto){
		return SysmanageUtil.execAjaxResult(zxpddjcsService.delZxpddjcs(request,dto));
	}
}
