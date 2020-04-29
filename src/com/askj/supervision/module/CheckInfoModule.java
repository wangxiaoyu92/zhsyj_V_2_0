package com.askj.supervision.module;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.upload.UploadAdaptor;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BsCheckPalnAndTypeDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.supervision.dto.pubkeyDTO;
import com.askj.supervision.entity.CheckContent;
import com.askj.supervision.entity.CheckGroup;
import com.askj.supervision.service.CheckInfoService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CheckInfoModule的中文名称：检查基本信息管理
 * 
 * CheckInfoModule的描述：
 * 
 * Written by : syf
 */
@IocBean
@At("/supervision/checkinfo")
public class CheckInfoModule {
	protected final Logger logger = Logger.getLogger(CheckInfoModule.class);
	@Inject
	private CheckInfoService checkInfoService;

	/**
	 * 
	 * index的中文名称：检查项目管理首页
	 * 
	 * index的概要说明：
	 *   
	 * @param request
	 *            Written by : syf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/itemList")
	public void index(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryItemZTreeAsync的中文名称：查询检查项目节点树
	 * 
	 * queryItemZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : syf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryItemZTreeAsync(HttpServletRequest request)
			throws Exception {
		try {
			List sysorgList = (List) checkInfoService
					.queryItemZTreeAsync(request);
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
	 * saveCheckGroup的中文名称：保存检查项目
	 * 
	 * saveCheckGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception 
	 * 
	 */
	@At
	@Ok("json")
	public Object saveCheckGroup(HttpServletRequest request,
			@Param("..") CheckGroup dto) throws Exception {
		checkInfoService.saveCheckGroup(request, dto);
		Map m = new HashMap();
		m.put("code", "0");
		return SysmanageUtil.execAjaxResult(m,null);
	}
	
	/**
	 * 
	 * delCheckGroup的中文名称：删除检查项目
	 * 
	 * delCheckGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception 
	 * 
	 */
	@At
	@Ok("json")
	public Object delCheckGroup(HttpServletRequest request,
			@Param("..") CheckGroup dto) throws Exception {
		String res = checkInfoService.delCheckGroup(request, dto);
		Map m = new HashMap();
		m.put("code", res);
		return SysmanageUtil.execAjaxResult(m,null);
	}
	
	
	/**
	 * 
	 * index的中文名称：检查内容管理首页
	 * 
	 * index的概要说明：
	 * 
	 * @param request
	 *            Written by : syf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/contentList.jsp")
	public void contentIndex(HttpServletRequest request) {
	}
	
	/**
	 * 
	 * index的中文名称：检查内容管理表单页
	 * 
	 * index的概要说明：
	 * 
	 * @param request
	 *            Written by : syf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/contentForm.jsp")
	public void contentForm(HttpServletRequest request) {
	}
	
	/**
	 * 
	 * queryContent的中文名称：分页查询项目内容
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : syf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryContent(HttpServletRequest request,@Param("..") CheckContent dto,
							   @Param("..") PagesDTO pd) {
		// 页面初始化
		Map mapc = new HashMap();
		try {
			mapc = checkInfoService.queryContent(dto,pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
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
	public Object queryContentByContent(HttpServletRequest request,@Param("..") CheckContent dto,@Param("..") PagesDTO pd)
			throws Exception {
		Map m = new HashMap<String, Object>();
		m = checkInfoService.queryContent(dto,pd);
		List ls = (List) m.get("rows");
		CheckContent cc = null;
		if (ls != null && ls.size() == 1) {
			cc = (CheckContent) ls.get(0);
			m.put("code", "0");
			m.put("data", cc);
		}else{
			m.put("code", "1");
			m.put("msg", "查询信息结果存在多条或者不存在该条数据！");
		}
		return SysmanageUtil.execAjaxResult(m,null);
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
	@At
	@Ok("json")
	public Object saveContent(HttpServletRequest request,
			@Param("..") CheckContent dto) throws Exception {
		checkInfoService.saveContent(request, dto);
		Map m = new HashMap();
		m.put("code", "0");
		return SysmanageUtil.execAjaxResult(m,null);
	}
	
	/**
	 * 
	 * delContent的中文名称：删除检查项目内容
	 * 
	 * delContent的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * @throws Exception 
	 * 
	 */
	@At
	@Ok("json")
	public Object delContent(HttpServletRequest request,
			@Param("..") CheckContent dto) throws Exception {
		String code = checkInfoService.delContent(request, dto);
		Map m = new HashMap();
		m.put("code", code);
		return SysmanageUtil.execAjaxResult(m,null);
	}

	/**
	 *
	 * setcheckAndComdalei的中文名称：设置计划项和类别关系
	 *
	 * setcheckAndComdalei的概要说明：
	 *
	 * @param request
	 *            Written by : syf
	 *
	 */
	@At
	@Ok("jsp:/jsp/supervision/checkAndComdalei/checkAndComdaleiManage.jsp")
	public void setcheckAndComdalei(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * getcheckAndTypeList的中文名称：设置计划项和类别关系
	 *
	 * getcheckAndTypeList的概要说明：
	 *
	 * @param request
	 *            Written by : syf
	 *
	 */
	@At
	@Ok("json")
	public Object getcheckAndTypeList(HttpServletRequest request, @Param("..")BsCheckPalnAndTypeDTO dto, @Param("..")PagesDTO pd) {
		// 页面初始化
		Map mapc = new HashMap();
		try {
			mapc = checkInfoService.querycheckList(request, dto,pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
//			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(mapc, e);
		}

	}
	/**
	 * 增加计划和类别关系
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/supervision/checkAndComdalei/checkAndTypeForm.jsp")
	public void addCheckAndTypejsp(HttpServletRequest request){

	}

	/**
	 * 计划和类别关系增加
	 * @param request
	 */
	@At
	@Ok("json")
	public Object saveCheckAndType(HttpServletRequest request,@Param("..")BsCheckPalnAndTypeDTO dto){
		String result = checkInfoService.saveCheckAndType(request, dto);
		if("false".equals(result)){
			return SysmanageUtil.execAjaxResult("数据已经存在，请重新添加");
		}
		return SysmanageUtil.execAjaxResult(result);
	}

	/**
	 * 计划和类别关系增加
	 * @param request
	 */
	@At
	@Ok("json")
	public Object saveItemidComfenlei(HttpServletRequest request,@Param("..") CheckGroup dto){
		return SysmanageUtil.execAjaxResult(checkInfoService.saveItemidComfenlei(request, dto));
	}

	/**
	 * 删除计划和类别关系
	 * @param request
	 */
	@At
	@Ok("json")
	public Object delCheckAndType(HttpServletRequest request,@Param("..")BsCheckPalnAndTypeDTO dto){
		return SysmanageUtil.execAjaxResult(checkInfoService.delCheckAndType(dto));
	}

	/**
	 * 查询计划和类别关系
	 * @param request
	 */
	@At
	@Ok("json")
	public Object queryCheckAndType(HttpServletRequest request, @Param("..")BsCheckPalnAndTypeDTO dto, @Param("..")PagesDTO pd){
		// 页面初始化
		Map mapc = new HashMap();
		try {
			List list = (List) checkInfoService.querycheckList(request, dto,pd).get("rows");
			if(list.size()>0){
				BsCheckPalnAndTypeDTO checkPalnAndType = (BsCheckPalnAndTypeDTO) list.get(0);
				mapc.put("data", checkPalnAndType);
			}
			mapc.put("rows",list);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
//					e.printStackTrace();
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	/**
	 * 跳转模板导入界面
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/supervision/importDoc/importDoc")
	public void toImportWordInfo(HttpServletRequest request,@Param("..")BsCheckPalnAndTypeDTO dto){

	}

	/**
	 * 导入检查表格
	 * @param request
	 */
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/WEB-INF/tmp" })
	public Object saveImportDoc(HttpServletRequest request,@Param("..")BscheckplanDTO dto,@Param("file") File f){
		String filepath = f.getPath();
//		              System.out.println(dto.getItemid());
		return SysmanageUtil.execAjaxResult(this.checkInfoService.saveImportDoc(request, dto,filepath));
	}

	/**
	 *
	 * licencesManageIndex的中文名称：许可管理首页
	 *
	 * licencesManageIndex的概要说明：
	 *
	 * @param request
	 *            Written by : syf
	 *
	 */
	@At
	@Ok("jsp:/jsp/supervision/licencesManage")
	public void licencesManageIndex(HttpServletRequest request) {
		// 页面初始化
	}











	/**
	 * 
	 * xxzttjfxCount中文名称:信息专题分析统计
	 * xxzttjfxCount概要描述:信息专题分析统计
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object xxzttjfxCount(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = checkInfoService.queryxxzttjfxCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
		
		
	}
	/**
	 * 
	 * tjbForm中文名称:统计表
	 * tjbForm概要描述:统计表
	 * written by  :  lfy
	 */
	@At
	@Ok("jsp:/jsp/supervision/tjbForm")
	public void tjbFormIndex(HttpServletRequest request) {
	}
	/**
	 * 
	 * aqjgCount中文名称:查询安全监管统计数量
	 * aqjgCount概要描述:查询安全监管统计数量
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object aqjgCount(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = checkInfoService.queryaqjgCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
		
		
	}

}
