package com.askj.ncjtjc.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.ncjtjc.service.JcglService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.ZyDTO;
import com.askj.ncjtjc.entity.Jcsbfj;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * JcglModule的中文名称：聚餐管理
 * 
 * JcglModule的描述：
 * 
 * Written by : zjf
 */
@At("/ncjtjc/jcgl")
@IocBean
public class JcglModule {
	protected final Logger logger = Logger.getLogger(JcglModule.class);

	@Inject
	protected JcglService jcglService;

	/**
	 * 
	 * jcglIndex的中文名称：聚餐管理页面
	 * 
	 * jcglIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcgl/jcgl")
	public void jcglIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryJcsb的中文名称：查询聚餐申报
	 * 
	 * queryJcsb的概要说明：
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
	public Object queryJcsb(HttpServletRequest request, @Param("..") ZyDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		return jcglService.queryJcsb(dto, pd);
	}

	/**
	 * 
	 * jcsbFormIndex的中文名称：聚餐申报编辑页面
	 * 
	 * jcsbFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcgl/jcsbForm")
	public void jcsbFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryJcsbDTO的中文名称：查询聚餐申报DTO
	 * 
	 * queryJcsbDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryJcsbDTO(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcsb(dto, pd);
			List ls = (List) map.get("rows");
			ZyDTO csDTO = null;
			if (ls != null && ls.size() > 0) {
				csDTO = (ZyDTO) ls.get(0);
			}
			map.put("data", csDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addJcsb的中文名称：新增聚餐申报
	 * 
	 * addJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String jcsbid = jcglService.addJcsb(request,dto);
			if (jcsbid != null) {
				result.put("jcsbid", jcsbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null); 
	}

	/**
	 * 
	 * updateJcsb的中文名称：修改聚餐申报
	 * 
	 * updateJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService
				.updateJcsb(request, dto));
	}

	/**
	 * 
	 * delJcsb的中文名称：删除聚餐申报
	 * 
	 * delJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsb(request, dto));
	}

	/**
	 * 
	 * uploadFjIndex的中文名称：上传附件页面
	 * 
	 * uploadFjIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcgl/uploadFj")
	public void uploadFjIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * uploadFj的中文名称：上传附件【保存】
	 * 
	 * uploadFj的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request, @Param("..") Jcsbfj dto) {
		return SysmanageUtil.execAjaxResult(jcglService.uploadFj(request, dto));
	}

	/**
	 * 
	 * delFjIndex的中文名称：删除附件页面
	 * 
	 * delFjIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/ncjtjc/jcgl/delFj")
	public void delFjIndex(HttpServletRequest request, @Param("..") Jcsbfj dto)
			throws Exception {
		// 页面初始化
		List fjList = jcglService.queryFjList(request, dto);
		if (fjList != null && fjList.size() > 0) {
			request.setAttribute("fjList", fjList);
		} else {
			request.setAttribute("fjList", null);
		}
	}

	/**
	 * 
	 * delFj的中文名称：删除附件【保存】
	 * 
	 * delFj的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object delFj(HttpServletRequest request, @Param("..") Jcsbfj dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delFj(request, dto));
	}

	/**
	 * 
	 * queryJcsbcs的中文名称：查询聚餐申报厨师
	 * 
	 * queryJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJcsbcs(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return jcglService.queryJcsbcs(dto, pd);
	}

	/**
	 * 
	 * addJcsbcs的中文名称：聚餐申报厨师【保存】
	 * 
	 * addJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil
				.execAjaxResult(jcglService.addJcsbcs(request, dto));
	}

	/**
	 * 
	 * delJcsbcs的中文名称：聚餐申报厨师【删除】
	 * 
	 * delJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil
				.execAjaxResult(jcglService.delJcsbcs(request, dto));
	}

	/**
	 * 
	 * queryJcsbcd的中文名称：查询聚餐申报菜单
	 * 
	 * queryJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJcsbcd(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return jcglService.queryJcsbcd(dto, pd);
	}

	/**
	 * 
	 * addJcsbcd的中文名称：聚餐申报菜单【保存】
	 * 
	 * addJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJcsbcd(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil
				.execAjaxResult(jcglService.addJcsbcd(request, dto));
	}

	/**
	 * 
	 * delJcsbcd的中文名称：聚餐申报菜单【删除】
	 * 
	 * delJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJcsbcd(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil
				.execAjaxResult(jcglService.delJcsbcd(request, dto));
	}

	/**
	 * 
	 * queryJcsbpswp的中文名称：查询聚餐申报配送物品
	 * 
	 * queryJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJcsbpswp(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return jcglService.queryJcsbpswp(dto, pd);
	}

	/**
	 * 
	 * addJcsbpswp的中文名称：聚餐申报配送物品【保存】
	 * 
	 * addJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJcsbpswp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcsbpswp(request,
				dto));
	}

	/**
	 * 
	 * delJcsbpswp的中文名称：聚餐申报配送物品【删除】
	 * 
	 * delJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJcsbpswp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsbpswp(request,
				dto));
	}

	/**
	 * 
	 * jcjgIndex的中文名称：聚餐监管页面
	 * 
	 * jcjgIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcjg/jcjg")
	public void jcjgIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryJcjgyNo的中文名称：查询聚餐可指派的现场监管员
	 * 
	 * queryJcjgyNo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJcjgyNo(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return jcglService.queryJcjgyNo(dto, pd);
	}

	/**
	 * 
	 * queryJcjgy的中文名称：查询聚餐已指派的现场监管员
	 * 
	 * queryJcjgy的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJcjgy(HttpServletRequest request,
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return jcglService.queryJcjgy(dto, pd);
	}

	/**
	 * 
	 * addJcjgy的中文名称：聚餐指派现场监管员【保存】
	 * 
	 * addJcjgy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJcjgy(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcjgy(request, dto));
	}
	
	
	/**
	 *printJcsbbadj的中文名称：聚餐备案表打印
	 * 
	 * printJcsbbadj的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/ncjtjc/jcgl/printJcsbbadj")
	public Object printJcsbbadj(HttpServletRequest request,@Param("..")ZyDTO dto) {
		// 页面初始化
		Map map = new HashMap();
		try {
			map = jcglService.getJcsbRecord(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
}
