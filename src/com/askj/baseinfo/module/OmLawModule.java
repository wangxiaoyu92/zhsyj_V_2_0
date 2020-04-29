package com.askj.baseinfo.module;

import com.askj.baseinfo.dto.OmLawContentDTO;
import com.askj.baseinfo.dto.OmLawGroupDTO;
import com.askj.baseinfo.service.OmLawService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  OmLawModule的中文名称：法律法规module
 *
 *  OmLawModule的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
@IocBean
@At("/omlaw")
@Fail("jsp:/jsp/error/error")
public class OmLawModule {

	protected final Logger logger = Logger.getLogger(OmLawModule.class);
	
	@Inject
	private OmLawService omLawService;

	/**
	 * 法律法规项目管理页面初始化
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/law/lawItemManager")
	public void lawItemManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * queryItemZTreeAsync的中文名称：查询检查项目节点树
	 *
	 * queryItemZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * @param request
	 * @return
	 * @author ： zy
	 */
	@At
	@Ok("json")
	public Object queryItemZTreeAsync(HttpServletRequest request) {
		try {
			List itemList = (List) omLawService.queryItemZTreeAsync(request);
			String treeData = Json.toJson(itemList, JsonFormat.compact());
			treeData = treeData.replace("isparent", "isParent");
			treeData = treeData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("treeData", treeData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * saveLawGroup的中文名称：保存法律法规项目
	 *
	 * saveLawGroup的概要说明
	 * @param request
	 * @param dto
	 * @return
	 * @author ： zy
	 */
	@At
	@Ok("json")
	public Object saveLawGroup(HttpServletRequest request, @Param("..") OmLawGroupDTO dto) {
		return SysmanageUtil.execAjaxResult(omLawService.saveLawGroup(request, dto));
	}

	/**
	 * delLawGroup的中文名称：删除法律法规项目
	 *
	 * delLawGroup的概要说明
	 * @param request
	 * @param dto
	 * @return
	 * @author ： zy
	 */
	@At
	@Ok("json")
	public Object delLawGroup(HttpServletRequest request, @Param("..") OmLawGroupDTO dto) {
		return SysmanageUtil.execAjaxResult(omLawService.delLawGroup(request, dto));
	}

	/**
	 * 法律法规内容管理页面初始化
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/law/contentManager")
	public void lawContentManagerIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * contentForm的中文名称：内容管理表单页
	 *
	 * contentForm的概要说明：
	 *
	 * @param request
	 * @author : zy
	 *
	 */
	@At
	@Ok("jsp:/jsp/law/contentForm.jsp")
	public void contentForm(HttpServletRequest request) {
	}

	/**
	 * queryContent的中文名称：获取内容列表信息
	 *
	 * queryContent的概要说明
	 * @param request
	 * @param dto
	 * @return
	 * @author ： zy
	 */
	@At
	@Ok("json")
	public Object queryContent(HttpServletRequest request,
		   @Param("..") OmLawContentDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = omLawService.queryContent(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryContent的中文名称：根据dto对象查询项目内容
	 *
	 * @return
	 * @throws Exception
	 *             Written by : syf
	 *
	 */
	@At
	@Ok("json")
	public Object queryContentByContent(HttpServletRequest request,
			@Param("..") OmLawContentDTO dto,@Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = omLawService.queryContent(request, dto, pd);
			List ls = (List) map.get("rows");
			OmLawContentDTO cc = null;
			if (ls != null && ls.size() == 1) {
				cc = (OmLawContentDTO) ls.get(0);
				map.put("code", "0");
				map.put("data", cc);
			}else{
				map.put("code", "1");
				map.put("msg", "查询信息结果存在多条或者不存在该条数据！");
			}
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * saveContent的中文名称：保存检查项目内容
	 *
	 * saveContent的概要说明：
	 *
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception
	 *
	 */
	/**
	 * saveContent的中文名称：保存法律法规内容
	 *
	 * saveContent的概要说明
	 * @param request
	 * @param dto
	 * @return
	 * @author ： zy
	 */
	@At
	@Ok("json")
	public Object saveContent(HttpServletRequest request, @Param("..") OmLawContentDTO dto) {
		return SysmanageUtil.execAjaxResult(omLawService.saveContent(request, dto));
	}

	/**
	 *
	 * delContent的中文名称：删除内容
	 *
	 * delContent的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author ： zy
	 *
	 */
	@At
	@Ok("json")
	public Object delContent(HttpServletRequest request, @Param("..") OmLawContentDTO dto) {
		return SysmanageUtil.execAjaxResult(omLawService.delContent(request, dto));
	}
}
