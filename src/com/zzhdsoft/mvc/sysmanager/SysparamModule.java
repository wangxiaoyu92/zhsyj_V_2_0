package com.zzhdsoft.mvc.sysmanager;

import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.service.sysmanager.SysparamService;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysparamModule的中文名称：系统参数管理
 * 
 * SysparamModule的描述：
 * 
 * Written by : zjf
 */
@At("/sysmanager/sysparam")
@IocBean
public class SysparamModule {
	protected final Logger logger = Logger.getLogger(SysparamModule.class);

	@Inject
	protected SysparamService sysparamService;

	/**
	 * 
	 * sysparamIndex的中文名称：系统参数管理页面初始化
	 * 
	 * sysparamIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysparam")
	public void sysparamIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 签到时间设置
	 * @param request
	 * zy
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/signInTime")
	public void signInTimeIndex(HttpServletRequest request) {
		// 签到截至时间
		Aa01 aa01 = SysmanageUtil.getAa01("SIGNINCLOSETIME");
		request.setAttribute("data", aa01);
	}

	/**
	 * 
	 *  sysparamFormIndex的中文名称：系统参数编辑页面初始化
	 *
	 *  sysparamFormIndex的概要说明：
	 *
	 *  @param request
	 *  Written  by  : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysparamForm")
	public void sysparamFormIndex(HttpServletRequest request){
		// 初始化aa01页面 
	}
	
	/**
	 * 
	 * queryAa01的中文名称：查询系统参数Aa01
	 * 
	 * queryAa01的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAa01(@Param("..") Aa01 dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = sysparamService.queryAa01(dto, pd);
			Aa01 aa01 = null;
			List list = (List) map.get("rows");
			if(null != list && list.size() > 0){
				aa01 = (Aa01) list.get(0);
			}
			map.put("data", aa01);
			return SysmanageUtil.execAjaxResult(map,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map,e); 
		}
	}

	/**
	 * 
	 * addAa01的中文名称：新增系统参数Aa01
	 * 
	 * addAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addAa01(HttpServletRequest request, @Param("..") Aa01 dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.addAa01(request,
				dto));
	}

	/**
	 * 
	 * updateAa01的中文名称：修改系统参数Aa01
	 * 
	 * updateAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateAa01(HttpServletRequest request, @Param("..") Aa01 dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.updateAa01(request,
				dto));
	}

	/**
	 * 
	 * delAa01的中文名称：删除系统参数Aa01
	 * 
	 * delAa01的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delAa01(HttpServletRequest request, @Param("..") Aa01 dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.delAa01(request,
				dto));
	}
	
	/**
	 * 
	 * queryAa10的中文名称：查询系统参数Aa10
	 * 
	 * queryAa10的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAa10(@Param("..") Aa10DTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = sysparamService.queryAa10(dto, pd);
			Aa10DTO aa10 = null;
			List list = (List) map.get("rows");
			if(list!=null && list.size()>0){
				aa10 = (Aa10DTO)list.get(0);
			}
			map.put("data", aa10);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return sysparamService.queryAa10(dto, pd);
	}
	
	/**
	 * 
	 * delAa10的中文名称：删除系统参数Aa10
	 * 
	 * delAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delAa10(HttpServletRequest request, @Param("..") Aa10DTO dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.delAa10(request,
				dto));
	}
	
	/**
	 * 
	 * addAa10的中文名称：新增系统参数Aa10
	 * 
	 * addAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addAa10(HttpServletRequest request, @Param("..") Aa10DTO dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.addAa10(request,
				dto));
	}
	
	/**
	 * 
	 * updateAa10的中文名称：修改系统参数Aa10
	 * 
	 * updateAa10的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateAa10(HttpServletRequest request, @Param("..") Aa10DTO dto) {
		return SysmanageUtil.execAjaxResult(sysparamService.updateAa10(request,
				dto));
	}
	
	/**
	 * 
	 * refreshAa10Map的中文名称：刷新aa10参数
	 * 
	 * refreshAa10Map的概要说明：
	 * 
	 * @param aaa100
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object refreshAa10Map(@Param("aaa100") String aaa100)
			throws Exception {
		Map map = new HashMap();
		try{
			SysmanageUtil.refreshAa10MapOnekey(aaa100);
			return SysmanageUtil.execAjaxResult(map,null);	
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
			
	}
	
	/**
	 * 
	 * refreshAa10Map的中文名称：刷新aa10参数
	 * 
	 * refreshAa10Map的概要说明：
	 * 
	 * @param aaa100
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("raw")
	public String getAa10MapOneKey(@Param("aaa100") String aaa100)
			throws Exception {
		String v_ret=SysmanageUtil.getAa10toJsonArray(aaa100);
		return v_ret;
	}	
	
}
