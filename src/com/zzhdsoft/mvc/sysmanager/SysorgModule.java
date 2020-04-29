package com.zzhdsoft.mvc.sysmanager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.service.sysmanager.SysorgService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * SysorgModule的中文名称：机构管理
 * 
 * SysorgModule的描述：
 * 
 * Written by : zjf
 */
@IocBean
@At("/sysmanager/sysorg")
public class SysorgModule {
	protected final Logger logger = Logger.getLogger(SysorgModule.class);
	@Inject
	protected SysorgService sysorgService;

	/**
	 * 
	 * sysorgIndex的中文名称：机构管理页面
	 * 
	 * sysorgIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysorg")
	public void sysorgIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysorgByOrgcode的中文名称：查询机构
	 * 
	 * querySysorgByOrgcode的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysorgByOrgcode(@Param("..") Sysorg dto, @Param("..") PagesDTO pd) {
		return sysorgService.querySysorgByOrgcode(dto, pd);
	}

	/**
	 * 
	 * querySysorg的中文名称：查询机构
	 * 
	 * querySysorg的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysorg(@Param("..") Sysorg dto, @Param("..") PagesDTO pd) {
		return sysorgService.querySysorg(dto, pd);
	}

	/**
	 * 
	 * isExistsOrgcode的中文名称：校验机构编码是否存在
	 * 
	 * isExistsOrgcode的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object isExistsOrgcode(Sysorg dto) throws Exception {
		return SysmanageUtil.execAjaxResult(sysorgService.isExistsOrgcode(dto));
	}

	/**
	 * 
	 * saveSysorg的中文名称：保存机构
	 * 
	 * saveSysorg的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysorg(HttpServletRequest request, @Param("..") Sysorg dto) {
		return SysmanageUtil.execAjaxResult(sysorgService.saveSysorg(request, dto));
	}

	@At
	@Ok("json")
	public Object querySystcqJxmZTree(HttpServletRequest request) {
		try {
			List jyjcxmList = (List) sysorgService.querySystcqJxmZTree(request);
			String mydata = Json.toJson(jyjcxmList, JsonFormat.compact());
			Map m = new HashMap();
			m.put("aaa027Data", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	/**
	 * 
	 * delSysorg的中文名称：删除机构
	 * 
	 * delSysorg的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delSysorg(HttpServletRequest request, @Param("..") Sysorg dto) {
		return SysmanageUtil.execAjaxResult(sysorgService.delSysorg(request, dto));
	}

	/**
	 * 
	 * querySysorgZTreeAsync的中文名称：按Ztree插件格式构造机构树
	 * 
	 * querySysorgZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysorgZTreeAsync(HttpServletRequest request) throws Exception {
		try {
			List sysorgList = (List) sysorgService.querySysorgZTreeAsync(request);
			String orgData = Json.toJson(sysorgList, JsonFormat.compact());
			orgData = orgData.replace("isparent", "isParent");
			orgData = orgData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("orgData", orgData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	@At
	@Ok("json")
	public Object querySysorgZTreeAsyncgw(HttpServletRequest request) throws Exception {
		try {
			List sysorgList = (List) sysorgService.querySysorgZTreeAsyncgw(request);
			String orgData = Json.toJson(sysorgList, JsonFormat.compact());
			orgData = orgData.replace("isparent", "isParent");
			orgData = orgData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("orgData", orgData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySysorgZTree的中文名称：按Ztree插件格式构造机构树
	 * 
	 * querySysorgZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysorgZTree(HttpServletRequest request) throws Exception {
		try {
			List sysorgList = (List) sysorgService.querySysorgZTree(request);
			String orgData = Json.toJson(sysorgList, JsonFormat.compact());
			orgData = orgData.replace("isparent", "isParent");
			orgData = orgData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("orgData", orgData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySysorgTree的中文名称：按easyui tree格式构造机构树
	 * 
	 * querySysorgTree的概要说明:
	 * 
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysorgTree(HttpServletRequest request) throws Exception {
		try {
			return sysorgService.querySysorgTree(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}


	/**
	 * 
	 * querySystcqZTreeAsync的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySystcqZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object querySystcqZTreeAsync(HttpServletRequest request) throws Exception {
		try {
			List aaa027List = (List) sysorgService.querySystcqZTreeAsync(request);
			String aaa027Data = Json.toJson(aaa027List, JsonFormat.compact());
			aaa027Data = aaa027Data.replace("isparent", "isParent");
			aaa027Data = aaa027Data.replace("isopen", "open");
			Map m = new HashMap();
			m.put("aaa027Data", aaa027Data);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	@At
	@Ok("json")
	public Object queryS(HttpServletRequest request) throws Exception {
		try {
			String fz=sysorgService.queryS(request);
			Map m = new HashMap();
			m.put("fz", fz);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySystcqZTree的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySystcqZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySystcqZTree(HttpServletRequest request) throws Exception {
		try {
			List aaa027List = (List) sysorgService.querySystcqZTree(request);
			String aaa027Data = Json.toJson(aaa027List, JsonFormat.compact());
			aaa027Data = aaa027Data.replace("isparent", "isParent");
			aaa027Data = aaa027Data.replace("isopen", "open");
			Map m = new HashMap();
			m.put("aaa027Data", aaa027Data);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySystcqTree的中文名称：按easyui tree格式构造统筹区树
	 * 
	 * querySystcqTree的概要说明:
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object querySystcqTree(HttpServletRequest request) throws Exception {
		try {
			return sysorgService.querySystcqTree(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
}
