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
import com.zzhdsoft.siweb.service.sysmanager.SysCommonFunService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * SysCommonFunModule的中文名称：系统公用功能（不过滤用户权限）
 * 
 * SysCommonFunModule的描述：
 * 
 * Written by : zjf
 */
@At("/syscommonfun")
@IocBean
public class SysCommonFunModule {
	protected final Logger logger = Logger.getLogger(SysCommonFunModule.class);

	@Inject
	protected SysCommonFunService sysCommonFunService;

	/**
	 * 
	 * go2home的中文名称：系统登录页面
	 * 
	 * go2home的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/index.jsp")
	public void go2Login() {
		// logger.info("测试ceshi");
	}

	/**
	 * 
	 * go2Blank的中文名称：调整空白页
	 * 
	 * go2Blank的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/error/blank.jsp")
	public void go2Blank() {
		// logger.info("测试ceshi");
	}

	/**
	 * 
	 * queryRegionZTree的中文名称：根据Ztree插件的树格式，组装行政区划树。
	 * 
	 * queryRegionZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryRegionZTree(HttpServletRequest request) throws Exception {
		try {
			List regionList = (List) sysCommonFunService
					.queryRegionZTree(request);
			String regionData = Json.toJson(regionList, JsonFormat.compact());
			regionData = regionData.replace("isparent", "isParent");
			regionData = regionData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("regionData", regionData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * queryRegionTree的中文名称：按easyui tree格式构造行政区划树
	 * 
	 * queryRegionTree的概要说明:
	 * 
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public List queryRegionTree(HttpServletRequest request) {
		return sysCommonFunService.queryRegionTree(request);
	}

	/**
	 * 
	 * queryRegionZTreeAsync的中文名称：根据Ztree插件的树格式，组装行政区划树。
	 * 
	 * queryRegionZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryRegionZTreeAsync(HttpServletRequest request)
			throws Exception {
		try {
			List regionList = (List) sysCommonFunService
					.queryRegionZTreeAsync(request);
			String regionData = Json.toJson(regionList, JsonFormat.compact());
			regionData = regionData.replace("isparent", "isParent");
			regionData = regionData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("regionData", regionData);
			System.out.println("regionData"+regionData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
}
