package com.askj.tmsyj.tmcy.module;  
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param; 
import com.askj.tmsyj.tmcy.dto.HcycdDTO; 
import com.askj.tmsyj.tmcy.dto.HcyjxxjlDTO;
import com.askj.tmsyj.tmcy.dto.HsplyDTO;
import com.askj.tmsyj.tmcy.dto.HyzcpDTO; 
import com.askj.tmsyj.tmcy.service.HcycdService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  HcycdModule的中文名称：
 *
 *  HcycdModule的描述：
 *
 *  @author : ly
 *  @version : V1.0
 */
@At("tmcy/cdgl/")
@IocBean
public class HcycdModule extends BaseModule{ 
	@Inject
	private HcycdService hcycdService;
	/**
	 * 
	 * CdMainIndex的中文名称：菜谱主页面
	 * 
	 * CdMainIndex的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/cdMain")
	public void CdMainIndex(){}
	/**
	 * 
	 * CdFrom的中文名称：菜谱附页
	 * 
	 * CdFrom的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/cdFrom")
	public void CdFrom(){}
    
	/**
	 * 
	 * QueryCd的中文名称：查询菜谱
	 *                可查一条或多条
	 * QueryCd的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object QueryCd(HttpServletRequest request, 
			@Param("..")HcycdDTO dto,  @Param("..")PagesDTO pd) {
		
		Map map = new HashMap();
		try {
			map = hcycdService.QueryCd(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * SaveCd的中文名称：保存菜单
	 * 
	 * SaveCd的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object SaveCd(HttpServletRequest request, @Param("..")HcycdDTO dto){
		return  SysmanageUtil.execAjaxResult(hcycdService.Savecd(request, dto));
	}
	/**
	 * 
	 * DelCd的中文名称：
	 * 
	 * DelCd的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object DelCd(HttpServletRequest request, @Param("..")HcycdDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelCd(request, dto));
	}
	
	/**
	 * 
	 * SplyMain的中文名称：食品留样主页
	 * 
	 * SplyMain的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/splyMain")
	public void SplyMainIndex(){}
	
	/**
	 * 
	 * SplyFrom的中文名称：食品留样附页
	 * 
	 * SplyFrom的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/splyFrom")
	public void SplyFrom(){}
	
	/**
	 * 
	 * QuerySply的中文名称：查询留样食品
	 *                  
	 * QuerySply的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object QuerySply(HttpServletRequest request,
			@Param("..") HsplyDTO dto,@Param("..")PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = hcycdService.QuerySply(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * SaveSply的中文名称：保存或更新留样食品
	 * 
	 * SaveSply的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object SaveSply(HttpServletRequest request, @Param("..") HsplyDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveSply(request, dto));
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
	@At
	@Ok("json")
	public Object DelSply(HttpServletRequest request, @Param("..") HsplyDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelSply(request, dto));
	}
	/**
	 * 
	 * YzcpMain的中文名称：一周菜谱主页
	 * 
	 * YzcpMain的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/yzcpMain")
	public void YzcpMainIndex(){}
	
	/**
	 * 
	 * YzcpFrom的中文名称：一周菜谱附页
	 * 
	 * YzcpFrom的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/yzcpFrom")
	public void YzcpFrom(){}
	
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
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object QueryYzcp(HttpServletRequest request,
			@Param("..") HyzcpDTO dto,@Param("..")PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = hcycdService.QueryYzcp(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * SaveYzcp的中文名称：
	 * 
	 * SaveYzcp的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object SaveYzcp(HttpServletRequest request, @Param("..")HyzcpDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveYzcp(request, dto));
	}
	
	/**
	 * 
	 * delYzcp的中文名称：删除一周菜谱
	 * 
	 * delYzcp的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object delYzcp(HttpServletRequest request, @Param("..")HyzcpDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelYzcp(request, dto));
	}
	
	/**
	 * 
	 * XxjiMainIndex的中文名称：餐饮具洗消记录主页
	 * 
	 * XxjiMainIndex的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/xxjlMain")
	public void XxjlMainIndex(){}
	
	/**
	 * 
	 * XxjiFrom的中文名称：餐饮具洗消记录附页
	 * 
	 * XxjiFrom的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcy/qycd/xxjlFrom")
	public void XxjlFrom(){}
	
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
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object QueryXxjl(HttpServletRequest request,
			@Param("..")HcyjxxjlDTO dto,@Param("..")PagesDTO pd){
		
		Map map = new HashMap();
		try {
			map = hcycdService.QueryXxjl(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
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
	@At
	@Ok("json")
	public Object SaveXxjl(HttpServletRequest request, @Param("..")HcyjxxjlDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.SaveXxjl(request, dto));
	}
	
	/**
	 * 
	 * DelXxjl的中文名称：删除一条洗消记录
	 * 
	 * DelXxjl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object DelXxjl(@Param("..")HcyjxxjlDTO dto){
		return SysmanageUtil.execAjaxResult(hcycdService.DelXxjl(dto));
	}
	
}
