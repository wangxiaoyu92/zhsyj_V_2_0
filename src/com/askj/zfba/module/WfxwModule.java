package com.askj.zfba.module;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PwfxwcsDTO;
import com.askj.zfba.service.WfxwService;
import com.zzhdsoft.utils.SysmanageUtil;

/***
 * 
 * WfxwModule的中文名称：违法行为管理Module
 *
 * WfxwModule的中文描述：
 * 
 * Written by:wanghao
 */
@At("/zfba/wfxw")
@IocBean
public class WfxwModule {
	protected final Logger logger = Logger.getLogger(AjdjModule.class);
	
	@Inject
	protected WfxwService wfxwService;
	
	
	/***
	 * 
	 * wfxwFormIndex的中文名称：违法行为页面初始化
	 *
	 * wfxwFormIndex概要说明：
	 *
	 * @param request
	 * Written by:wanghao
	 */
	@At
	@Ok("jsp:/jsp/zfba/wfxwgl/wfxwMain")
	public void wfxwMainIndex(HttpServletRequest request){
		//页面初始化
	}
	/***
	 * 
	 * querySelectaj的中文名称：查找集合
	 *
	 * querySelectaj概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:wanghao
	 */
	@At
	@Ok("json")
	public Object queryWfxw(@Param("..") PwfxwcsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try{
			map=wfxwService.queryWfxw(dto, pd);
			return  SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return  SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 查询违法行为编号唯一性
	 *
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object checkCode(HttpServletRequest request,
							@Param("..") PwfxwcsDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map = wfxwService.checkCode(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/***
	 * 
	 * wfxwFormIndex的中文名称：跳转到查看编辑页面
	 *
	 * wfxwFormIndex概要说明：
	 *
	 * @param request
	 * Written by:wanghao
	 */
	@At
	@Ok("jsp:/jsp/zfba/wfxwgl/wfxwForm")
	public void wfxwFormIndex(HttpServletRequest request){
		// 页面初始化
	}
	
	/***
	 * 
	 * saveWfxw的中文名称：保存违法行为
	 *
	 * saveWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * Written by:wanghao
	 */
	@At
	@Ok("json")
	public Object saveWfxw(HttpServletRequest request,
			@Param("..") PwfxwcsDTO dto) {
		return SysmanageUtil.execAjaxResult(wfxwService.saveWfxw(request,
				dto));
	}	
	
	/***
	 * 
	 * findWfxw的中文名称：修改违法行为
	 *
	 * findWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * Written by:wanghao
	 */
	@At
	@Ok("json")
	public Object findWfxw(HttpServletRequest request,
			@Param("..") PwfxwcsDTO dto) throws Exception {
			Map map = new HashMap();
			try {
				PwfxwcsDTO pwfxwcsDTO=null;
				pwfxwcsDTO=(PwfxwcsDTO)wfxwService.findWfxw(request,dto);
				map.put("data", pwfxwcsDTO);
				return  SysmanageUtil.execAjaxResult(map, null);
			} catch (Exception e) {
				return  SysmanageUtil.execAjaxResult(map, e);
			}
		 
		 
	}
	
	/***
	 * 
	 * delWfxw的中文名称：删除违法行为
	 *
	 * delWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * Written by:wanghao
	 */
	@At
	@Ok("json")
	public Object delWfxw(HttpServletRequest request,
			@Param("..") PwfxwcsDTO dto) {
		return SysmanageUtil.execAjaxResult(wfxwService.delWfxw(request,
				dto));
	}

	
}
