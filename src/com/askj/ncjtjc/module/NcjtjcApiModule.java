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

import com.askj.ncjtjc.dto.CsDTO;
import com.askj.ncjtjc.dto.LyDTO;
import com.askj.ncjtjc.dto.ZyDTO;
import com.askj.ncjtjc.service.CsglService;
import com.askj.ncjtjc.service.JcglService;
import com.askj.ncjtjc.service.LyglService;
import com.askj.ncjtjc.service.NcjtjcApiService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  NcjtjcApiModule的中文名称：【农村集体聚餐手机端】api接口module
 *
 *  NcjtjcApiModule的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
@At("api/ncjtjc/")
@IocBean
public class NcjtjcApiModule extends BaseModule {
	
	protected final Logger logger = Logger.getLogger(NcjtjcApiModule.class);

	@Inject
	protected NcjtjcApiService ncjtjcApiService;
	
	@Inject
	protected CsglService csglService;
	
	@Inject
	protected JcglService jcglService;
	
	@Inject
	protected LyglService lyglService;
	
	/**
	 * 
	 * queryChefList的中文名称：查询厨师列表信息
	 * 
	 * queryChefList的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师dto
	 * @param pd 分页信息
	 * @return 列表信息
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryChefList(HttpServletRequest request, @Param("..") CsDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = csglService.queryCs(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryChefDto的中文名称：查询厨师信息
	 * 
	 * queryChefDto的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师dto
	 * @param pd 分页信息
	 * @return 厨师信息
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryChefDto(HttpServletRequest request, @Param("..") CsDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			String aaa027 = SysmanageUtil.getSysuser().getAaa027();
			dto.setAaa027(aaa027);
			map = csglService.queryCs(dto, pd);
			List ls = (List) map.get("rows");
			CsDTO csDTO = null;
			if (ls != null && ls.size() > 0) {
				csDTO = (CsDTO) ls.get(0);
			}
			map.put("data", csDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addChef的中文名称：添加厨师
	 * 
	 * addChef的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师信息dto
	 * @return 保存数据
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addChef(HttpServletRequest request, @Param("..") CsDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String csid = csglService.addCs(request, dto);
			if (csid != null) {
				result.put("csid", csid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * updateChef的中文名称：修改厨师信息
	 * 
	 * updateChef的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师信息dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object updateChef(HttpServletRequest request, @Param("..") CsDTO dto) {
		return SysmanageUtil.execAjaxResult(csglService.updateCs(request, dto));
	}
	
	/**
	 * 
	 * deleteChef的中文名称：删除厨师信息
	 * 
	 * deleteChef的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师信息dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteChef(HttpServletRequest request, @Param("..") CsDTO dto) {
		return SysmanageUtil.execAjaxResult(csglService.delCs(request, dto));
	}
	
	/**
	 * 
	 * queryJcsbList的中文名称：查询聚餐申报列表
	 * 
	 * queryJcsbList的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 聚餐申报dto
	 * @param pd 分页信息
	 * @return 申报列表信息
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbList(HttpServletRequest request, @Param("..") ZyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = jcglService.queryJcsb(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addJcsb的中文名称：添加聚餐申报
	 * 
	 * addJcsb的概要说明：
	 *
	 * @param request 请求
	 * @param dto 聚餐申报信息
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String jcsbid = jcglService.addJcsb(request, dto);
			if (jcsbid != null) {
				result.put("jcsbid", jcsbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * updateJcsb的中文名称：修改聚餐申报
	 * 
	 * updateJcsb的概要说明：
	 *
	 * @param request 请求
	 * @param dto 聚餐申报信息
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object updateJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.updateJcsb(request, dto));
	}
	
	/**
	 * 
	 * deleteJcsb的中文名称：删除聚餐申报
	 * 
	 * deleteJcsb的概要说明：
	 *
	 * @param request 请求
	 * @param dto 聚餐申报信息
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsb(request, dto));
	}
	
	/**
	 * 
	 * queryJcsbChefs的中文名称：查询聚餐申报厨师
	 * 
	 * queryJcsbChefs的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbChefs(HttpServletRequest request, @Param("..") ZyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcsbcs(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryAllOfJcsbChefs的中文名称：查询所有聚餐申报厨师
	 * 
	 * queryAllOfJcsbChefs的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 厨师信息
	 * @param pd 分页信息
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryAllOfJcsbChefs(HttpServletRequest request, @Param("..") CsDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			
			map = csglService.queryCs(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addJcsbChef的中文名称：添加聚餐申报厨师
	 * 
	 * addJcsbChef的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addJcsbChef(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcsbcs(request, dto));
	}
	
	/**
	 * 
	 * deleteJcsbChef的中文名称：删除聚餐申报厨师
	 * 
	 * deleteJcsbChef的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteJcsbChef(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsbcs(request, dto));
	}
	
	/**
	 * 
	 * queryJcsbMenu的中文名称：查询聚餐申报菜单
	 * 
	 * queryJcsbMenu的概要说明：
	 *
	 * @param request 访问请求
	 * @param dto 
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbMenu(HttpServletRequest request, @Param("..") ZyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcsbcd(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addJcsbMenu的中文名称：添加聚餐申报菜单
	 * 
	 * addJcsbMenu的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addJcsbMenu(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcsbcd(request, dto));
	}
	
	/**
	 * 
	 * deleteJcsbMenu的中文名称：删除聚餐申报菜单
	 * 
	 * deleteJcsbMenu的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object deleteJcsbMenu(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsbcd(request, dto));
	}
	
	/**
	 * 
	 * queryJcsbAccessories的中文名称：查询聚餐申报配送物品
	 * 
	 * queryJcsbAccessories的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbAccessories(HttpServletRequest request, 
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcsbpswp(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addJcsbAccessories的中文名称：添加聚餐申报配送物品
	 * 
	 * addJcsbAccessories的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addJcsbAccessories(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcsbpswp(request, dto));
	}
	
	/**
	 * 
	 * delteJcsbAccessories的中文名称：删除聚餐申报配送物品
	 * 
	 * delteJcsbAccessories的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object delteJcsbAccessories(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.delJcsbpswp(request, dto));
	}
	
	/**
	 * 
	 * queryAllOfJcsbSupervisor的中文名称：查询聚餐申报监管员
	 * 
	 * queryAllOfJcsbSupervisor的概要说明：可指派的监管员
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", })
	public Object queryAllOfJcsbSupervisor(HttpServletRequest request, 
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcjgyNo(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryJcsbSupervisor的中文名称：查询聚餐申报监管员
	 * 
	 * queryJcsbSupervisor的概要说明：已指派的监管员
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbSupervisor(HttpServletRequest request, 
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcjgy(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addJcsbSupervisor的中文名称：添加聚餐申报监管员
	 * 
	 * addJcsbSupervisor的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object addJcsbSupervisor(HttpServletRequest request, @Param("..") ZyDTO dto) {
		return SysmanageUtil.execAjaxResult(jcglService.addJcjgy(request, dto));
	}
	
	/**
	 * 
	 * queryJcsbBySupervisor的中文名称：根据监管员查询聚餐申报
	 * 
	 * queryJcsbBySupervisor的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryJcsbBySupervisor(HttpServletRequest request, 
			@Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jcglService.queryJcsbByJgy(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryLy的中文名称：查询两员
	 * 
	 * queryLy的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes" })
	public Object queryLy(HttpServletRequest request, @Param("..") LyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			int num = pd.getPage() != 0 ? 10 : 0;
			pd.setRows(num); // 每页个数
			map = lyglService.queryLy(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryLyDTO的中文名称：查询两员dto
	 * 
	 * queryLyDTO的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryLyDTO(HttpServletRequest request, @Param("..") LyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = lyglService.queryLy(dto, pd);
			List ls = (List) map.get("rows");
			LyDTO lyDTO = null;
			if (ls != null && ls.size() > 0) {
				lyDTO = (LyDTO) ls.get(0);
			}
			map.put("data", lyDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addLy的中文名称：添加两员
	 * 
	 * addLy的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object addLy(HttpServletRequest request, @Param("..") LyDTO dto) {
		Map map = new HashMap();
		try {
			String flag = lyglService.isExistsLy(dto);
			// 校验两员身份证号是否已经存在
			if(flag != null){
				map.put("msg", flag);
				map.put("code", "-2");
				return map;
			} else {
				String lyid = lyglService.addLy(request, dto);
				map.put("lyid", lyid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}
	
	/**
	 * 
	 * updateLy的中文名称：修改两员
	 * 
	 * updateLy的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object updateLy(HttpServletRequest request, @Param("..") LyDTO dto) {
		return SysmanageUtil.execAjaxResult(lyglService.updateLy(request, dto));
	}
	
	
}
