package com.zzhdsoft.mvc.sysmanager;

import com.zzhdsoft.siweb.entity.sysmanager.Sysfunction;
import com.zzhdsoft.siweb.service.sysmanager.SysfunctionService;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysfunctionModule的中文名称:菜单管理Module
 * 
 * SysfunctionModule的描述:
 * 
 * Written by : zjf
 */
@At("/sysmanager/sysfunction")
@IocBean
public class SysfunctionModule {
	protected final Logger logger = Logger.getLogger(SysfunctionModule.class);
	@Inject
	protected SysfunctionService sysfunctionService;

	/**
	 * 
	 * sysfunctionIndex的中文名称：菜单管理页面
	 * 
	 * sysfunctionIndex的概要说明：Ztree菜单树
	 * 
	 * @param request
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysfunction")
	public void sysfunctionIndex(HttpServletRequest request) throws Exception {
		// 页面初始化
	}

	/**
	 * 
	 * getSysfunctionById的中文名称：根据id获取菜单项
	 * 
	 * getSysfunctionById的概要说明:
	 * 
	 * @param functionid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object getSysfunctionById(@Param("functionid") String functionid) {
		return sysfunctionService.getSysfunctionById(functionid);
	}

	/**
	 * 
	 * saveSysfunction的中文名称：保存菜单项
	 * 
	 * saveSysfunction的概要说明:
	 * 
	 * @param dto
	 * @return 返回空串表示保存成功，其他则为异常信息字符串 Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysfunction(HttpServletRequest request, @Param("..") Sysfunction dto) {
		return SysmanageUtil.execAjaxResult(sysfunctionService.saveSysfunction(request, dto));
	}

	/**
	 * 
	 * delSysfunction的中文名称：删除菜单项
	 * 
	 * delSysfunction的概要说明:
	 * 
	 * @param functionid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delSysfunction(HttpServletRequest request, @Param("functionid") String functionid) {
		return SysmanageUtil.execAjaxResult(sysfunctionService.delSysfunction(request, functionid));
	}

	/**
	 * 
	 * querySysfunctionTree的中文名称：按easyui tree格式构造菜单树
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
			return sysfunctionService.querySysfunctionTree(userid, userkind, flag, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * querySysfunctionZTree的中文名称：按Ztree插件格式构造菜单树
	 * 
	 * querySysfunctionZTree的概要说明：0 包含按钮 1不包含按钮
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
			List sysfunctionList = (List) sysfunctionService.querySysfunctionZTree(userid, userkind, flag, null);
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
	 * querySysfunctionZTreeAsync的中文名称：按Ztree插件格式构造菜单树
	 * 
	 * querySysfunctionZTreeAsync的概要说明：异步加载（传入父节点ID）
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
	public Object querySysfunctionZTreeAsync(HttpServletRequest request,
											 @Param("userid") String userid, @Param("userkind") String userkind,
			@Param("flag") String flag) {
		try {
			List sysfunctionList = (List) sysfunctionService.querySysfunctionZTreeAsync(request, userid, userkind, flag);
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
}
