package com.zzhdsoft.mvc.sysmanager;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.QddszDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Qddczybd;
import com.zzhdsoft.siweb.entity.sysmanager.Qddsz;
import com.zzhdsoft.siweb.entity.sysmanager.Syslogonlog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.sysmanager.SysuserService;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 
 * SysuserModule的中文名称：用户管理
 * 
 * SysuserModule的描述：
 * 
 * Written by : zjf
 */
@IocBean
@At("/sysmanager/sysuser")
public class SysuserModule {
	protected final Logger logger = Logger.getLogger(SysuserModule.class);
	@Inject
	private SysuserService sysuserService;

	/**
	 * 
	 * sysuserIndex的中文名称：用户管理页面
	 * 
	 * sysuserIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuser")
	public void sysuserIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysuserByUsername的中文名称：查询用户
	 * 
	 * querySysuserByUsername的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserByUsername(@Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserByUsername(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * querySysuser的中文名称：查询用户
	 * 
	 * querySysuser的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuser(@Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuser(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * isExistsUsername的中文名称：校验用户名是否存在
	 * 
	 * isExistsUsername的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object isExistsUsername(Sysuser dto) throws Exception {
		return SysmanageUtil.execAjaxResult(sysuserService.isExistsUsername(dto));
	}

	/**
	 * 
	 * sysuserFormIndex的中文名称：用户编辑页面
	 * 
	 * sysuserFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuserForm")
	public void sysuserFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySysuserDTO的中文名称：查询用户DTO
	 * 
	 * querySysuserDTO的概要说明：
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
	public Object querySysuserDTO(HttpServletRequest request, @Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuser(dto, pd);
			List ls = (List) map.get("rows");
			Sysuser sysuser = null;
			if (ls != null && ls.size() > 0) {
				sysuser = (Sysuser) ls.get(0);
			}
			map.put("data", sysuser);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addSysuser的中文名称：新增用户
	 * 
	 * addSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addSysuser(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.addSysuser(request, dto));
	}

	/**
	 * 
	 * updateSysuser的中文名称：修改用户
	 * 
	 * updateSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateSysuser(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.updateSysuser(request, dto));
	}

	/**
	 * 
	 * delSysuser的中文名称：删除用户
	 * 
	 * delSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delSysuser(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.delSysuser(request, dto));
	}

	/**
	 * 
	 * lockSysuser的中文名称：封锁用户
	 * 
	 * lockSysuser的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object lockSysuser(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.lockSysuser(request, dto));
	}

	/**
	 * 
	 * unlockSysuser的中文名称：解锁用户
	 * 
	 * unlockSysuser的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object unlockSysuser(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.unlockSysuser(request, dto));
	}

	/**
	 * 
	 * resetPasswd的中文名称：重置密码
	 * 
	 * resetPasswd的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object resetPasswd(HttpServletRequest request, @Param("..") Sysuser dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.resetPasswd(request, dto));
	}

	/**
	 * 
	 * initSuperIndex的中文名称：初始化超级管理员角色权限页面
	 * 
	 * initSuperIndex的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/initSuper.jsp")
	public void initSuperIndex() {
		//
	}

	/**
	 * 
	 * initSuper的中文名称：初始化超级管理员角色权限
	 * 
	 * initSuper的概要说明：
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object initSuper(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(sysuserService.initSuper(request));
	}
	
	/**
	 * 
	 * querySysuserNoRole的中文名称：查询操作员【可绑定】的角色
	 * 
	 * querySysuserNoRole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserNoRole(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserNoRole(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * querySysuserRole的中文名称：查询操作员【已绑定】的角色
	 * 
	 * querySysuserRole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserRole(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserRole(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveSysuserRole的中文名称：操作员角色授权【保存】
	 * 
	 * saveSysuserRole的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysuserRole(HttpServletRequest request, @Param("..") Sysuser dto, String JsonStr) {
		return SysmanageUtil.execAjaxResult(sysuserService.saveSysuserRole(request, dto, JsonStr));
	}
	
	
	/**
	 * 
	 * querySysuserNoAae140的中文名称：查询操作员【未授权】的四品一械大类
	 * 
	 * querySysuserNoAae140的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserNoAae140(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserNoAae140(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * querySysuserAae140的中文名称：查询操作员【已授权】的四品一械大类
	 * 
	 * querySysuserAae140的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserAae140(@Param("..") SysuserDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserAae140(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveSysuserAae140的中文名称：操作员四品一械大类授权【保存】
	 * 
	 * saveSysuserAae140的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysuserAae140(HttpServletRequest request, @Param("..") Sysuser dto, String JsonStr){
		return SysmanageUtil.execAjaxResult(sysuserService.saveSysuserAae140(request, dto, JsonStr));
	}	
	
	/**
	 * 
	 * querySysuserAaa027ZTree的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySysuserAaa027ZTree的概要说明：
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserAaa027ZTree(HttpServletRequest request) {
		try {
			List aaa027List = (List) sysuserService.querySysuserAaa027ZTree(request);
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
	 * querySysuserHaveAaa027Grant的中文名称：查询操作员【已授权】的统筹区
	 * 
	 * querySysuserHaveAaa027Grant的概要说明：
	 * 
	 * @param userid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserHaveAaa027Grant(@Param("userid") String userid) {
		if (Strings.isBlank(userid)) {
			return null;
		}
		Map map = new HashMap();
		List<SysuserDTO> lis;
		try {
			lis = sysuserService.querySysuserHaveAaa027Grant(userid);
			map.put("rows", lis);
			map.put("total", lis.size());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveSysuserAaa027Grant的中文名称：操作员统筹区授权【保存】
	 * 
	 * saveSysuserAaa027Grant的概要说明：
	 * 
	 * @param userid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysuserAaa027Grant(HttpServletRequest request,
										 @Param("userid") String userid, @Param("aaa027") List fid) {
		return SysmanageUtil.execAjaxResult(sysuserService.saveSysuserAaa027Grant(request, userid, fid));
	}
	
	/**
	 * 
	 * querySysuserOrgZTree的中文名称：按Ztree插件格式构造机构树
	 * 
	 * querySysuserOrgZTree的概要说明：
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserOrgZTree(HttpServletRequest request) {
		try {
			List sysorgList = (List) sysuserService.querySysuserOrgZTree(request);
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
	 * querySysuserHaveOrgGrant的中文名称：查询操作员【已授权】的机构
	 * 
	 * querySysuserHaveOrgGrant的概要说明：
	 * 
	 * @param userid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object querySysuserHaveOrgGrant(@Param("userid") String userid) {
		if (Strings.isBlank(userid)) {
			return null;
		}
		Map map = new HashMap();
		List<SysuserDTO> lis;
		try {
			lis = sysuserService.querySysuserHaveOrgGrant(userid);
			map.put("rows", lis);
			map.put("total", lis.size());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveSysuserOrgGrant的中文名称：操作员机构授权【保存】
	 * 
	 * saveSysuserOrgGrant的概要说明：
	 * 
	 * @param userid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveSysuserOrgGrant(HttpServletRequest request, @Param("userid") String userid, @Param("orgid") List fid) {
		return SysmanageUtil.execAjaxResult(sysuserService.saveSysuserOrgGrant(request, userid, fid));
	}	
		
	/**
	 * sysuserOnlineIndex的中文名称：在线用户统计页面
	 * 
	 * sysuserOnlineIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuserOnline.jsp")
	public void sysuserOnlineIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *  sysuserGrantFrom : 用户授权页面
	 * @param request
	 * @return Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuserGrant")
	public void sysuserGrantFrom(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *  QueryqddbdIndex :签到点增改查页面
	 * @param request
	 * @return Written by : ly
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/QianDaodszFrom")
	public void QianDaodszFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 *  QianDaodbdIndex的中文名称：签到点设置主页面
	 *
	 *  QianDaodbdIndex的概要说明：
	 *
	 *  @param request
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/Qiandaodsz")
	public void QianDaodszIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 *  Queryqdd的中文名称：查询签到点
	 *
	 *  Queryqdd的概要说明：
	 *
	 *  @param request
	 *  Written  by  : ly
	 * @throws Exception 
	 *
	 */
	@At
	@Ok("json")
	public Object Queryqdd(HttpServletRequest request,@Param("..")Qddsz dto,@Param("..") PagesDTO pd){
		Map map = new HashMap();
		try{
			map = sysuserService.Queryqdd(request, dto, pd) ;
			List ls = (List) map.get("rows");
			Qddsz sz = null;
			if (ls != null && ls.size() > 0) {
				sz = (Qddsz) ls.get(0);
			}
			map.put("data", sz);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch(Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  addqdd的中文名称：添加签到点
	 *
	 *  addqdd的概要说明：
	 *
	 *  @param request
	 *  @param dto 
	 *  @return
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("json")
	public Object addqdd(HttpServletRequest request,@Param("..")Qddsz dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.addqdd(request, dto));
	}
	/**
	 * 
	 *  delqdd的中文名称：删除设置的坐标点
	 *
	 *  delqdd的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @return
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("json")
	public Object delqdd(HttpServletRequest request,@Param("..")Qddsz dto) {
		return SysmanageUtil.execAjaxResult(sysuserService.delqdd(request, dto));
	}
	/**
	 * 
	 *  QianDaodbdIndex的中文名称：签到点绑定页
	 *
	 *  QianDaodbdIndex的概要说明：
	 *
	 *  @param request
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/Qiandaodbd")
	public void QianDaodbdIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 *  Queryqdd的中文名称：查询执法人员绑定的签到点
	 *
	 *  Queryqdd的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("json")
	public Object Queryqddczybd(HttpServletRequest request,@Param("..")QddszDTO dto,@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.Queryqddczybd(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  Queryqddsz的中文名称：查询签到点
	 *
	 *  Queryqddsz的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("json")
	public Object Queryqddsz(HttpServletRequest request,@Param("..")QddszDTO dto,@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.Queryqddsz( dto, pd) ;
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  Saveqddczybd的中文名称：保存签到点和执法人员的绑定
	 *
	 *  Saveqddczybd的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @param succes
	 *  @return
	 *  @throws Exception
	 *  Written  by  : ly
	 *
	 */
	@At
	@Ok("json")
	public Object Saveqddczybd(HttpServletRequest request,@Param("..")Qddczybd dto ,String succes) {
		return  SysmanageUtil.execAjaxResult(sysuserService.Saveqddczybd( request,dto,succes)) ;  
	}
	
	/**
	 *  version ------ 查看手机版本号初始化页面
	 * @param request
	 * @return Written by : ly
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/version")
	public void versionIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryversion的中文名称：查询版本号
	 * 
	 * queryversion的概要说明：
	 * 
	 * @param dto
	 * @return Written by : ly
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryversion(@Param("..") Syslogonlog dto ) {
		Map map = new HashMap();  
		List<Syslogonlog> lis;
		try {
			lis = sysuserService.queryversion(dto);
			map.put("rows", lis); 
			map.put("total", lis.size());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}  
	}
	
	/**
	 *  dkckIndex ------ 签到查看初始化页面
	 * @param request
	 * @return Written by : ly
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/dkck")
	public void dkckIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * qiandaoquery ： pc端签到查询 
	 * 参数 unlocktime 选择的日期    格式为 2001-01-01  
	 * @return
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object qiandaoquery(@Param("..")SysuserDTO dto) {
		Map map = new HashMap();  
		List<SysuserDTO> lis;
		try {
			lis = sysuserService.qiandaoquery(dto);
			map.put("rows", lis); 
			map.put("total", lis.size());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}  
	}

	@At
	@Ok("json")
	public Object  find_zfry(String aaa027) {
		Map map = new HashMap();
		try {
			map = sysuserService.find_zfry(aaa027);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 用户签到时间设置
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object  saveSysuserSignInTime(HttpServletRequest request, @Param("..")SysuserDTO dto){
		return  SysmanageUtil.execAjaxResult(sysuserService.saveSysuserSignInTime(request, dto)) ;
	}

	@At
	@Ok("json")
	public Object recreateHuanXinUser(HttpServletRequest request){
		return SysmanageUtil.execAjaxResult(sysuserService.recreateHuanXinUser(request));
	}

	/**
	 *
	 * zhuxiaohuanxin的中文名称：注销环信用户
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object zhucehuanxin(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.zhucehuanxin(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}

	/**
	 *
	 * zhuxiaohuanxin的中文名称：注销环信用户
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delHuanxinUserBatch(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.delHuanxinUserBatch(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}


	/**
	 *
	 * zhuxiaohuanxin的中文名称：注销环信用户
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addHuanxinUserBatch(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.addHuanxinUserBatch(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}

	/**
	 *
	 * zhuxiaohuanxin的中文名称：注销环信用户
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delHuanxinUser(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.delHuanxinUser(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}

	/**
	 *
	 * sysuserIndex的中文名称：用户管理页面
	 *
	 * sysuserIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuserHuanxin")
	public void sysuserhuanxinIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * queryHuanxinSysuser的中文名称：查询环信用户
	 *
	 * queryHuanxinSysuser的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryHuanxinSysuser(@Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.queryHuanxinSysuser(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * zhuxiaohuanxin的中文名称：删除环信好友
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object delHuanxinFriendBatch(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.delHuanxinFriendBatch(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}


	/**
	 *
	 * zhuxiaohuanxin的中文名称：注销环信用户
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object addHuanxinFriendBatch(HttpServletRequest request, @Param("..") Sysuser dto) {
		Boolean v_ok=sysuserService.addHuanxinFriendBatch(request, dto);
		String v_ret="";
		if (!v_ok){
			v_ret="err";
		}
		return SysmanageUtil.execAjaxResult(v_ret);
	}

	/**
	 *
	 * sysuserIndex的中文名称：用户管理页面
	 *
	 * sysuserIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/sysmanager/sysuserHuanxinFriend")
	public void sysuserHuanxinFriendIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * querySysuser的中文名称：查询用户
	 *
	 * querySysuser的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object querySysuserNocom(@Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = sysuserService.querySysuserNocom(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


}
