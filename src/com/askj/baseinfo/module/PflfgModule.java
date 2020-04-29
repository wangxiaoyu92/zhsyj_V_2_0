package com.askj.baseinfo.module;

import com.askj.baseinfo.dto.PflfgDTO;
import com.askj.baseinfo.dto.PflfglbDTO;
import com.askj.baseinfo.dto.PflfgtkDTO;
import com.askj.baseinfo.entity.Pflfglb;
import com.askj.baseinfo.service.PflfgService;
import com.zzhdsoft.mvc.BaseModule;
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
 * 法律法规
 * @author CatchU
 *
 */
@IocBean
@At("/flfg")
@Fail("jsp:/jsp/error/error")
public class PflfgModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(PflfgModule.class);
	
	@Inject
	private PflfgService pflfgService; 
	
	/*************法律法规相关信息**************************/
	/**
	 * 跳转到法律法规页面
	 */
	@At
	@Ok("jsp:/jsp/flfg/pflfg")
	public void pflfgIndex(HttpServletRequest request){
		//法律法规类别信息初始化
	}
	
	//跳转到法律法规信息详情页
	@At
	@Ok("jsp:/jsp/flfg/pflfgForm")
	public void pflfgFormIndex(HttpServletRequest request){
		//法律法规类别信息详情
	}
	
	/**
	 * 查询法律法规信息
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryPflfg(@Param("..") PflfgDTO dto,@Param("..") PagesDTO pd) throws Exception{
		return pflfgService.queryPflfg(dto,pd);
	}

	/**
	 * 查询法律法规信息
	 */
	@At
	@Ok("json")
	public Object queryPflfgDTO(HttpServletRequest request,
			@Param("..") PflfgDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = pflfgService.queryPflfgForm(dto, pd);
			List list = (List) map.get("rows");
			PflfgDTO pflfgDto = null;
			if(list!=null && list.size()>0){
				pflfgDto = (PflfgDTO)list.get(0);
			}
			map.put("data", pflfgDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	/**
	 * 添加企业法律法规信息
	 */
	@At
	@Ok("json")
	public Object savePflfg(HttpServletRequest request,@Param("..") PflfgDTO dto){
		return SysmanageUtil.execAjaxResult(pflfgService.savePflfg(request,dto));
	}
	/**
	 * 删除法律法规信息
	 * 
	 */
	@At
	@Ok("json")
	public Object delPflfg(HttpServletRequest request,@Param("..") PflfgDTO dto){
		return SysmanageUtil.execAjaxResult(pflfgService.delPflfg(request, dto));
	}
	
	/*************法律法规条款信息**************************/
	/**
	 * 跳转到法律法规条款页面
	 */
	@At
	@Ok("jsp:/jsp/flfg/pflfgtk")
	public void pflfgtkIndex(HttpServletRequest request){
		//法律法规条款初始化
	}
	
	//跳转到法律法规条款详情页
	@At
	@Ok("jsp:/jsp/flfg/pflfgtkForm")
	public void pflfgtkFormIndex(HttpServletRequest request){
		//法律法规条款详情
	}
	
	/**
	 * 查询法律法规条款
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryPflfgtk(@Param("..") PflfgtkDTO dto,@Param("..") PagesDTO pd) throws Exception{
		return pflfgService.queryPflfgtk(dto,pd);
	}

	/**
	 * 查询法律法规条款
	 */
	@At
	@Ok("json")
	public Object queryPflfgtkDTO(HttpServletRequest request,
			@Param("..") PflfgtkDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = pflfgService.queryPflfgtkForm(dto, pd);
			List list = (List) map.get("rows");
			PflfgtkDTO pflfgtkDto = null;
			if(list!=null && list.size()>0){
				pflfgtkDto = (PflfgtkDTO)list.get(0);
			}
			map.put("data", pflfgtkDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	/**
	 * 添加法律法规条款
	 */
	@At
	@Ok("json")
	public Object savePflfgtk(HttpServletRequest request,@Param("..") PflfgtkDTO dto){
		return SysmanageUtil.execAjaxResult(pflfgService.savePflfgtk(request,dto));
	}
	/**
	 * 删除法律法规条款
	 * 
	 */
	@At
	@Ok("json")
	public Object delPflfgtk(HttpServletRequest request,@Param("..") PflfgtkDTO dto){
		return SysmanageUtil.execAjaxResult(pflfgService.delPflfgtk(request, dto));
	}
	
	/**************法律法规类别信息*************************/
	/**
	 * 跳转到结果信息页
	 */
	@At
	@Ok("jsp:/jsp/flfg/pflfglb")
	public void pflfglbIndex(HttpServletRequest request){
		//法律法规类别信息初始化
	}
	
	//跳转到法律法规类别信息详情页
	@At
	@Ok("jsp:/jsp/flfg/pflfglbForm")
	public void pflfglbFormIndex(HttpServletRequest request){
		//法律法规类别信息详情
	}
	
	/**
	 * 查询法律法规类别信息
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryPflfglb(@Param("..") PflfglbDTO dto,@Param("..") PagesDTO pd) throws Exception{
		return pflfgService.queryPflfglb(dto,pd);
	}

	/**
	 * 查询法律法规类别信息
	 */
	@At
	@Ok("json")
	public Object queryPflfglbDTO(HttpServletRequest request,
			@Param("..") PflfglbDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = pflfgService.queryPflfglb(dto, pd);
			List list = (List) map.get("rows");
			PflfglbDTO pflfglbDto = null;
			if(list!=null && list.size()>0){
				pflfglbDto = (PflfglbDTO)list.get(0);
			}
			map.put("data", pflfglbDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	/**
	 * 添加企业法律法规类别信息
	 */
	@At
	@Ok("json")
	public Object savePflfglb(HttpServletRequest request,@Param("..") Pflfglb dto){
		return SysmanageUtil.execAjaxResult(pflfgService.savePflfglb(request,dto));
	}
	/**
	 * 删除法律法规类别信息
	 * 
	 */
	@At
	@Ok("json")
	public Object delPflfglb(HttpServletRequest request,@Param("..") Pflfglb dto){
		return SysmanageUtil.execAjaxResult(pflfgService.delPflfglb(request, dto));
	}
	
	/**
	 * 
	 * queryPflfglbZTree的中文名称：按Ztree插件格式构造机构树
	 * 
	 * queryPflfglbZTree的概要说明：
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPflfglbZTree(HttpServletRequest request) throws Exception {
		try {
			List pflfglbList = (List) pflfgService.queryPflfglbZTree(request);
			String flfglbData = Json.toJson(pflfglbList, JsonFormat.compact());
			flfglbData = flfglbData.replace("isparent", "isParent");
			flfglbData = flfglbData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("flfglbData", flfglbData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		} 
	}

	/**
	 * 
	 * queryPflfglbTree的中文名称：按easyui tree格式构造机构树
	 * 
	 * queryPflfglbTree的概要说明:
	 * 
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPflfglbTree(HttpServletRequest request) throws Exception {
		try {
			return pflfgService.queryPflfglbTree(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
}
