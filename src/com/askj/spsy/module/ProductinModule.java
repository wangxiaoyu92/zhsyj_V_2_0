package com.askj.spsy.module;

import com.askj.spsy.dto.QledgersalesDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.service.ProductinService;
import com.zzhdsoft.siweb.dto.PagesDTO;
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
 * ProductinModule的中文名称：范围内企业产品管理
 * ProductinModule的描述：
 * Written by ：ly
 *
 */
@IocBean
@At("/spsy/productin")
public class ProductinModule { 
    protected final Logger logger = Logger.getLogger(ProductinModule.class);
	
	@Inject
	protected ProductinService productinService; 
	
	/**
	 * 
	 *  productOutAdminIndex的中文名称：范围内企业产品管理页面
	 *  productOutAdminIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/productin/productinAdmin")
	public void productinAdminIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	
    /**
     * 
     *  queryProductin的中文名称：查询范围内企业产品
     *  queryProductin的概要说明：
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written by:ly
     */
	@At
	@Ok("json")
	public Object queryProductin (@Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map =productinService.queryProductin(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	@At
	@Ok("jsp:/jsp/spsy/productin/productinadd")
	public void productinaddIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	
	/**
	 * 
	 *  queryProductinDTO的中文名称：查询范围内企业产品
	 *  queryProductinDTO的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryProductinDTO (@Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map =productinService.queryProductin(dto, pd);
			List ls = (List) map.get("rows");
			QproductDTO v_QproductDTO = null;
			if (ls != null && ls.size() > 0) {
				v_QproductDTO = (QproductDTO) ls.get(0);
			}
			map.put("data", v_QproductDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		} 
	}
	
	/**
	 * 
	 *  addProductin的中文名称：添加，更新 新产品 
	 *  addProductin的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object addProductin (@Param("..") QproductDTO dto) {
		return SysmanageUtil.execAjaxResult(productinService.addProductin(dto));
	}
	
	/**
	 * 
	 *  delProductin的中文名称：删除已有的产品
	 *  delProductin的概要说明：
	 *  @param proid
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object delProductin (@Param("proid") String proid) throws Exception{
		return SysmanageUtil.execAjaxResult(productinService.delProductin(proid));
	}
	
	/**
	 * 
	 *  productclMainIndex的中文名称：产品材料主页
	 *  productclMainIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/productin/productclMain")
	public void productclMainIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	 
	/**
	  * 
	  *  queryproductZTreeAsync的中文名称：查出企业所有产品
	  *  queryproductZTreeAsync的概要说明：
	  *  @param request
	  *  @return
	  *  @throws Exception
	  *  Written by:ly
	  */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryproductZTreeAsync(HttpServletRequest request) {
		try {
			List proList = (List) productinService.queryproductinZTreeAsync(request);
			String proData = Json.toJson(proList, JsonFormat.compact());
			proData = proData.replace("isparent", "isParent");
			proData = proData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("proData", proData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
	/**
	 * 
	 *  queryProductcl的中文名称：查看材料列表
	 *  queryProductcl的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object queryProductcl (@Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = productinService.queryProductcl(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryComCl的中文名称：查询企业材料
	 * 
	 * queryComCl的概要说明：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object queryComCl(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = productinService.queryComCl(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 *  procladdIndex的中文名称：添加产品材料页面
	 *  procladdIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/productin/procladd")
	public void procladdIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	
	/**
	 * 
	 *  addProductCls的中文名称：添加产品材料(产品与材料的对应关系)
	 *  addProductCls的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object addProductCls(HttpServletRequest request, @Param("..") QproductDTO dto) {
		return SysmanageUtil.execAjaxResult(productinService.addProductCls(request, dto));
	}
	
	/**
	 * 
	 *  delprocl的中文名称：删除材料操作
	 *  delprocl的概要说明：
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object delprocl(HttpServletRequest request, @Param("..") QproductDTO dto){
		return  SysmanageUtil.execAjaxResult(productinService.delprocl(dto));
	} 
	 
	 
	////////////////////////////销货台账管理页///////////////////////////////////////////////
	/**
	 * 
	 *  gjproIndex的中文名称：销货台账管理页  查出进货数量即库存剩余
	 *  gjproIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/xhtz/xhtzmain")
	public void xhtzmainIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	/**
	 * 
	 *  salesIndex的中文名称：出售页面
	 *  salesIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/xhtz/sales")
	public void salesIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	/**
	 * 
	 *  querykcsy的中文名称：库存剩余
	 *  querykcsy的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object querykcsy(@Param("..") QledgerstockDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.querykcsy(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  querysckc的中文名称：生产库存
	 *  querysckc的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object querysckc(@Param("..") QledgerstockDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.querysckc(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 *  querykcsyDTO的中文名称：库存剩余DTO
	 *  querykcsyDTO的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@At
	@Ok("json")
	public Object querykcsyDTO(@Param("..") QledgerstockDTO dto) {
		Map map = new HashMap();
		try {
			map =productinService.querykcsy(dto);
			List ls = (List) map.get("rows");
			QledgerstockDTO QledgerstockDTO = null;
			if (ls != null && ls.size() > 0) {
				QledgerstockDTO = (QledgerstockDTO) ls.get(0);
			}
			map.put("data", QledgerstockDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}  
	}
	/**
	 * 
	 *  querysckcDTO的中文名称：生产库存DTO
	 *  querysckcDTO的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@At
	@Ok("json")
	public Object querysckcDTO(@Param("..") QledgerstockDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.querysckc(dto);
			List ls = (List) map.get("rows");
			QledgerstockDTO QledgerstockDTO = null;
			if (ls != null && ls.size() > 0) {
				QledgerstockDTO = (QledgerstockDTO) ls.get(0);
			}
			map.put("data", QledgerstockDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}  
	}
	/**
	 * 
	 *  savesales的中文名称：保存销售记录
	 *  savesales的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object savesales( @Param("..") QledgerstockDTO dto) {
		return SysmanageUtil.execAjaxResult(productinService.savesales(dto));
	}
	/**
	 * 
	 *  querySalesDetail的中文名称：销售明细
	 *  querySalesDetail的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object querySalesDetail( @Param("..") QledgersalesDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.querySalesDetail(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * saleshz 概要明细： 企业销货台账监管
	 *  
	 * @param dto
	 * @return
	 *  by ly
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object salestzgl( @Param("..") QledgersalesDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.salestzjg(dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 *     台账监管主页
	 * @param request
	 * @throws Exception
	 */
	@At
	@Ok("jsp:/jsp/spsy/xhtz/salestzgl")
	public void salestzglIndex(HttpServletRequest request) throws Exception {
		//页面跳转
	}
	
	/**
	 * 
	 *  tzdetailIndex的中文名称：台账出售明细
	 *  tzdetailIndex的概要说明：
	 *  @param request
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/spsy/xhtz/tzdetail")
	public void tzdetailIndex (HttpServletRequest request) throws Exception {
		//页面跳转
	}
	
	/**
	 * salestzglDTO 概要明细： 企业销货台账监管DTO
	 *  
	 * @param dto
	 * @return
	 *  by ly
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object salestzglDTO( @Param("..") QledgersalesDTO dto) {
		Map map = new HashMap();
		try {
			map = productinService.salestzjg(dto);
			List ls = (List) map.get("rows");
			QledgersalesDTO QledgersalesDTO = null;
			if (ls != null && ls.size() > 0) {
				QledgersalesDTO = (QledgersalesDTO) ls.get(0);
			}
			map.put("data", QledgersalesDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}   
	}
}