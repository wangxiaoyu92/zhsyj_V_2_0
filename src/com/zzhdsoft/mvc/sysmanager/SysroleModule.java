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
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysrole;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.sysmanager.SysfunctionService;
import com.zzhdsoft.siweb.service.sysmanager.SysroleService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * SysroleModule的中文名称：角色管理
 * 
 * SysroleModule的描述：
 * 
 * Written by : zjf
 */
@At("/sysmanager/sysrole")
@IocBean
public class SysroleModule {
	protected final Logger logger = Logger.getLogger(SysroleModule.class);

	@Inject
	protected SysroleService sysroleService;
	@Inject
	protected SysfunctionService sysfunctionService;

	/**
	 * 
	 * sysroleIndex的中文名称：角色管理页面
	 * 
	 * sysroleIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysrole")
	public void sysroleIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysrole的中文名称：查询角色
	 * 
	 * querySysrole的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysrole(HttpServletRequest request, @Param("..") Sysrole dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysroleService.querySysrole(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * sysroleFormIndex的中文名称：角色编辑页面
	 * 
	 * sysroleFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysroleForm")
	public void sysroleFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysroleDTO的中文名称：查询角色DTO
	 * 
	 * querySysroleDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysroleDTO(HttpServletRequest request, @Param("..") Sysrole dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysroleService.querySysrole(dto, pd);
			List ls = (List) map.get("rows");
			Sysrole sysrole = null;
			if (ls != null && ls.size() > 0) {
				sysrole = (Sysrole) ls.get(0);
			}
			map.put("data", sysrole);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addSysrole的中文名称：新增角色
	 * 
	 * addSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addSysrole(HttpServletRequest request, @Param("..") Sysrole dto) {
		return SysmanageUtil.execAjaxResult(sysroleService.addSysrole(request, dto));
	}

	/**
	 * 
	 * updateSysrole的中文名称：修改角色
	 * 
	 * updateSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateSysrole(HttpServletRequest request, @Param("..") Sysrole dto) {
		return SysmanageUtil.execAjaxResult(sysroleService.updateSysrole(request, dto));
	}

	/**
	 * 
	 * delSysrole的中文名称：删除角色
	 * 
	 * delSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delSysrole(HttpServletRequest request, @Param("..") Sysrole dto) {
		return SysmanageUtil.execAjaxResult(sysroleService.delSysrole(request, dto));
	}

	/**
	 * 
	 * querySysfunctionTree的中文名称：按easyui tree格式构造权限菜单树
	 * 
	 * querySysfunctionTree的概要说明:
	 * 
	 * @param userid
	 *            过滤用户权限
	 * @param flag
	 *            0 包含按钮 1不包含按钮
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysfunctionTree(@Param("userid") String userid,
									   @Param("userkind") String userkind, @Param("flag") String flag) {
		try {
			Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();// 获取当前登录用户
			return sysfunctionService.querySysfunctionTree(sysuser.getUserid().toString(),
					sysuser.getUserkind(), flag, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySysfunctionZTree的中文名称：按Ztree插件格式构造权限菜单树
	 * 
	 * querySysfunctionZTree的概要说明：flag=1,不包含按钮
	 * 
	 * @param userid
	 * @param userkind
	 * @param flag
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysfunctionZTree(@Param("userid") String userid,
										@Param("userkind") String userkind, @Param("flag") String flag) {
		try {
			Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();// 获取当前登录用户
			List sysfunctionList = (List) sysfunctionService.querySysfunctionZTree(sysuser.getUserid().toString(),
					sysuser.getUserkind(), flag, null);
			String menuData = Json.toJson(sysfunctionList, JsonFormat.compact());
			menuData = menuData.replace("isparent", "isParent");
			menuData = menuData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("menuData", menuData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * sysroleGrantIndex的中文名称：角色授权页面
	 * 
	 * sysroleGrantIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysroleGrant")
	public void sysroleGrantIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysroleGrant的中文名称：查询某个角色的菜单权限
	 * 
	 * querySysroleGrant的概要说明：
	 * 
	 * @param roleid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysroleGrant(@Param("roleid") String roleid) {
		if (Strings.isBlank(roleid)) {
			return null;
		}
		return sysroleService.querySysroleGrant(roleid);
	}

	/**
	 * 
	 * saveSysroleGrant的中文名称：角色授权【保存】
	 * 
	 * saveSysroleGrant的概要说明：
	 * 
	 * @param roleid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysroleGrant(HttpServletRequest request,
								   @Param("roleid") String roleid, @Param("functionid") List fid) {
		return SysmanageUtil.execAjaxResult(sysroleService.saveSysroleGrant(request, roleid, fid));
	}

	/**
	 * 
	 * sysroleUserIndex的中文名称：角色绑定用户页面
	 * 
	 * sysroleUserIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysroleUser")
	public void sysroleUserIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysroleUser的中文名称：查询角色已绑定的用户
	 * 
	 * querySysroleUser的概要说明：
	 * 
	 * @param userid
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysroleUser(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysroleService.querySysroleUser(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * querySysroleNoUser的中文名称：查询角色未绑定的用户
	 * 
	 * querySysroleNoUser的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysroleNoUser(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysroleService.querySysroleNoUser(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addSysuserRole的中文名称：角色绑定用户
	 * 
	 * addSysuserRole的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addSysuserRole(HttpServletRequest request, @Param("..") SysuserDTO dto, String JsonStr) {
		return SysmanageUtil.execAjaxResult(sysroleService.addSysuserRole(request, dto, JsonStr));
	}

	/**
	 * 
	 * delSysuserRole的中文名称：角色绑定用户【解除】
	 * 
	 * delSysuserRole的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delSysuserRole(HttpServletRequest request, @Param("..") SysuserDTO dto, String JsonStr) {
		return SysmanageUtil.execAjaxResult(sysroleService.delSysuserRole(request, dto, JsonStr));
	}
}
