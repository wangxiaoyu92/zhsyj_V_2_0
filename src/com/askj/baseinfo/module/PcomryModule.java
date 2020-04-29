package com.askj.baseinfo.module;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.baseinfo.dto.PcomryDTO;
import com.askj.baseinfo.service.PcomryService;
import com.lbs.commons.GlobalNameS;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 企业人员基本信息 控制层
 * @author CatchU
 *
 */
@IocBean
@At("/pcomry")
@Fail("jsp:/jsp/error/error")
public class PcomryModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(PcomryModule.class);
	
	@Inject
	private PcomryService pcomryService;
	
	/**
	 * 跳转到用户管理信息页
	 */
	@At
	@Ok("jsp:/jsp/baseinfo/pcomry/pcomry")
	public void pcomryIndex(HttpServletRequest request){
		//用户管理页面初始化
	}
	
	/**
	 * 跳转到人员信息管理页面详情
	 */
	@At
	@Ok("re:jsp:/jsp/baseinfo/pcomry/pcomryForm")
//	@Ok("jsp:/jsp/baseinfo/pcomry/pcomryForm")
	public String pcomryFormIndex(HttpServletRequest request,@Param("querytype")String querytype){
		if("jyjc".equals(querytype)){
			return "jsp:/jsp/jyjc/jcjgryForm";
		}else{
			return "jsp:/jsp/baseinfo/pcomry/pcomryForm";
		}
		//用于页面跳转
	}
	/**
	 * 查询所有人员信息并分页显示
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryPcomry(HttpServletRequest request,@Param("..") PcomryDTO dto,@Param("..") PagesDTO pd,@Param("querytype")String querytype) {

		Map map = new HashMap();
		try {
			map = pcomryService.queryPcomry(request,dto,pd,querytype);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询人员信息
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryPcomryDTO(HttpServletRequest request,
			@Param("..") PcomryDTO dto,
			@Param("..") PagesDTO pd,@Param("querytype")String querytype) throws Exception{
		Map map = new HashMap();
		try {
			map = pcomryService.queryPcomry(request,dto, pd,querytype);
			List list = (List) map.get("rows");
			PcomryDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (PcomryDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	
	/**
	 * 添加企业人员基本信息
	 * 完成的是注册功能
	 */
	@At
	@Ok("json")
	public Object savePcomry(HttpServletRequest request,@Param("..") PcomryDTO dto){
		return SysmanageUtil.execAjaxResult(pcomryService.savePcomry(request, dto));
	}
	
	/**
	 * 删除人员信息
	 * 
	 */
	@At
	@Ok("json")
	public Object delPcomry(HttpServletRequest request,@Param("..") PcomryDTO dto){
		return SysmanageUtil.execAjaxResult(pcomryService.delPcomry(request, dto));
	}
	
	/**
	 * 人员信息审核通过
	 */
	@At
	@Ok("json")
	public Object examPass(HttpServletRequest request,@Param("..") PcomryDTO dto){
		return SysmanageUtil.execAjaxResult(pcomryService.examPass(request,dto));
	}
	
	/**
	 * 
	 * uploadryZp的中文名称:上传人员照片
	 *
	 * uploadryZp的概要说明:
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by CatchU 2016年5月11日上午9:41:23
	 */
	@At
	@Ok("json")
	public Object uploadryZp(HttpServletRequest request) throws Exception{
		return SysmanageUtil.execAjaxResult(pcomryService.uploadryZp(request));
	}
	
	/**
	 * 
	 * getComryzp的中文名称：获取数据库存储的单位人员照片
	 * 
	 * getComryzp的概要说明: 获取数据库存储的单位人员照片
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Map getComryzp(HttpServletRequest request, @Param("..") PcomryDTO dto)
			throws Exception {
		Map map = new HashMap();
		String contextPath = request.getContextPath();
		String fileCtxPath = contextPath + "/images/default.jpg";
		try {
			String filePath = pcomryService.getComryzp(request, dto);
			if (!Strings.isBlank(filePath)) {
				int pfindex = filePath.lastIndexOf("\\");
				String fileName = filePath.substring(pfindex + 1);
				fileCtxPath = contextPath
						+ GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH
						+ File.separator + fileName;
			}

			map.put("fileCtxPath", fileCtxPath);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			map.put("fileCtxPath", fileCtxPath);
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
}
