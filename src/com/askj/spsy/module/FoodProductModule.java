package com.askj.spsy.module;

import com.askj.spsy.dto.*;
import com.askj.spsy.service.FoodProductService;
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
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * FoodProductModule的中文名称：食品加工溯源Moudle
 * 
 * FoodProductModule的描述：
 * 
 * Written by : zy
 */
@At("/spsy/spproduct")
@IocBean
public class FoodProductModule {
	protected final Logger logger = Logger.getLogger(FoodProductModule.class);
	
	@Inject
	protected FoodProductService foodProductService;
	
	/**
	 * 
	 * companyGxMainIndex的中文名称：客户关系主页面
	 * companyGxMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/comgxMain")
	public void companyGxMainIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * queryComList的中文名称：查询客户公司列表
	 * 
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryComList(HttpServletRequest request, @Param("..") QcompanygxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryComList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * addComProducts的中文名称：添加公司商品
	 * 
	 * addComProducts的概要说明：
	 * 
	 * @param request
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object addComProducts(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(foodProductService.addComProducts(request));
	}	
	
	/**
	 * 
	 * showComProductsIndex的中文名称：客户关系信息页面
	 * showComProductsIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/comgxInfo")
	public void showComProductsIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryComDto的中文名称：查询案件登记DTO
	 * 
	 * queryComDto的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryComDto(HttpServletRequest request, @Param("..") QcompanygxDTO dto) {
		Map map = new HashMap();
		try {
			QcompanygxDTO v_dto = foodProductService.queryComDto(dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * delComgx的中文名称：删除客户关系信息
	 * 
	 * delComgx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object delComgx(HttpServletRequest request, @Param("..") QcompanygxDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.delComgx(request, dto));
	}	
	
	/**
	 * 
	 *  comProductPcIndex的中文名称：产品批次管理页面
	 *  comProductPcIndex的概要说明：
	 *  @param request
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/comProductPc")
	public void comProductPcIndex(HttpServletRequest request) throws Exception{
		// 初始化企业产品批次页面
	}
	
	/**
	 * 
	 * queryComProductsListAsync的中文名称：按Ztree插件格式构造机构树 异步加载（传入父节点ID）
	 * 
	 * queryComProductsListAsync的概要说明：查询企业产品树
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryComProductsListAsync(HttpServletRequest request) {
		try {
			List proList = (List) foodProductService.queryComProductsListAsync(request);
			String ComProducts = Json.toJson(proList, JsonFormat.compact());
			ComProducts = ComProducts.replace("isparent", "isParent");
			ComProducts = ComProducts.replace("isopen", "open");
			Map m = new HashMap();
			m.put("ComProducts", ComProducts);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
	/**
	 * 
	 *  comApplySymMainIndex的中文名称：企业申请溯源码页面
	 *  comApplySymMainIndex的概要说明：
	 *  @param request
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/comApplySym")
	public void comApplySymMainIndex(HttpServletRequest request) throws Exception{
		// 初始化企业申请溯源码页面
	}
	
	/**
     * 
     *  queryComProductsPc的中文名称：查询产品批次
     *  queryComProductsPc的概要说明：
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written by:zy
     */
	@At
	@Ok("json")
	public Object queryComProductsPc (HttpServletRequest request, @Param("..") QproductpcDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryComProductsPc(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
     * 
     *  selectComProducts的中文名称：选择商品
     *  selectComProducts的概要说明：
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written by:zy
     */
	@At
	@Ok("json")
	public Object selectComProducts (HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.selectComProducts(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 *  addproductpcIndex的中文名称：添加产品批次页面
	 *  addproductpcIndex的概要说明：
	 *  @param request
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/productpcFrom")
	public void productpcFromIndex(HttpServletRequest request) throws Exception{
		// 初始化企业产品批次页面
	}
	
	/**
	 * 
	 *  addProductPc的中文名称：添加产品批次 
	 *  addProductPc的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object addProductPc(HttpServletRequest request, @Param("..") QproductpcDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.addProductPc(request, dto));
	}
	
	/**
	 * 
	 *  queryProductPcDto的中文名称：查询产品批次dto
	 *  queryProductPcDto的概要说明：
	 *  @param dto
	 *  @param request
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryProductPcDto(HttpServletRequest request, @Param("..") QproductpcDTO dto) {
		Map map = new HashMap();
		try {
			QproductpcDTO v_dto = foodProductService.queryProductPcDto(request, dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		} 
	}
	
	/**
	 * 
	 *  delProductPc的中文名称：删除产品批次
	 *  delProductPc的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object delProductPc(HttpServletRequest request, @Param("..") QproductpcDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.delProductPc(request, dto));
	}
	
	/**
	 * 
	 * applySymFromIndex的中文名称：申请溯源码页面
	 * applySymFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/applySymFrom")
	public void applySymFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * showSymIndex的中文名称：溯源码页面
	 * showSymIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/showSym")
	public void showSymIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 *  queryProductSyms的中文名称：查询产品溯源码
	 *  queryProductSyms的概要说明：
	 *  @param request
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryProductSyms(HttpServletRequest request, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryProductSyms(request, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 *  queryProductSyms的中文名称：查询产品溯源码明细
	 *  queryProductSyms的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object querySymQrcode(HttpServletRequest request, @Param("..") QsymscmxbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.querySymQrcode(request, dto,pd);
			List list = (List) map.get("rows");
			QsymscmxbDTO pcDto = null;
			if (list != null && list.size() > 0) {
				pcDto = (QsymscmxbDTO) list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	
	
	/**
	 * 
	 *  applySym的中文名称：申请溯源码 
	 *  applySym的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object applySym(HttpServletRequest request, @Param("..") QsymscbDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.applySym(request, dto));
	}
	
	/**
	 * 
	 *  exportExcel的中文名称：导出溯源码到excel表格
	 *  exportExcel的概要说明：
	 *  @param request
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
//	public File exportExcel(HttpServletRequest request,HttpServletResponse response) throws Exception{
//		//return SysmanageUtil.execAjaxResult(foodProductService.exportExcel(request,response));
//		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
//		
//	}
	@At
	@Ok("raw")	
	public File exportExcel(HttpServletRequest request) throws IOException {
		return foodProductService.exportExcel(request);
	}	
	
	/**
	 * 
	 * ledgerstockMainIndex的中文名称：进货台账主页面
	 * ledgerstockMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/ledgerstockMain")
	public void ledgerstockMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * selectcomIndex的中文名称：选择公司页面
	 * selectcomIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/selectcom")
	public void selectcomIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
     * 
     *  querySelectcom的中文名称：查询供货商
     *  querySelectcom的概要说明：
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written by:zy
     */
	@At
	@Ok("json")
	public Object querySelectcom (HttpServletRequest request, @Param("..") QcompanygxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.querySelectcom(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryLedgerstock的中文名称：进货台账信息
	 * 
	 * queryLedgerstock的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryLedgerstock(HttpServletRequest request, @Param("..") QledgerstockDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryLedgerstock(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 *  queryStockDTO的中文名称：查询台账信息dto
	 *  queryStockDTO的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryStockDTO(HttpServletRequest request, @Param("..") QledgerstockDTO dto) {
		Map map = new HashMap();
		try {
			QledgerstockDTO v_dto = foodProductService.queryStockDTO(request, dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		} 
	}
	
	/**
	 * 
	 * saveStock的中文名称：添加公司进货台账
	 * 
	 * saveStock的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveStock(HttpServletRequest request, @Param("..") QledgerstockDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.saveStock(request, dto));
	}
	
	/**
	 * 
	 * showStockIndex的中文名称：查看台账信息页面
	 * showStockIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/stockForm")
	public void showStockIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 *  delStock的中文名称：删除台账信息
	 *  delStock的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object delStock(HttpServletRequest request, @Param("..") QledgerstockDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.delStock(request, dto));
	}
	
	/**
	 * 
	 * jhkcMainIndex的中文名称：进货库存
	 * jhkcMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/jhkcMain")
	public void jhkcMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryJhhz的中文名称：进货汇总
	 * 
	 * queryJhhz的概要说明：
	 * 
	 * @param request
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJhhz(HttpServletRequest request, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryJhhz(request, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * protuctscszMainIndex的中文名称：产品生产生长信息管理页面
	 * protuctscszMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/protuctscszMain")
	public void protuctscszMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * scszxxFromIndex的中文名称：产品生产生长信息页面
	 * scszxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/scszxxFrom")
	public void scszxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * showScszxxFromIndex的中文名称：查看产品生产生长信息页面
	 * showScszxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/showScszxxFrom")
	public void showScszxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * saveProductScszxx的中文名称：保存产品生产生产生长信息
	 * 
	 * saveProductScszxx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveProductScszxx(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.saveProductScszxx(request, dto));
	}
	
	/**
	 * 
	 * queryProductScszxx的中文名称：查询产品生产生长信息
	 * 
	 * queryProductScszxx的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryProductScszxx(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryProductScszxx(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryProductScszxxDto的中文名称：查询产品生产生长信息DTO
	 * 
	 * queryProductScszxxDto的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryProductScszxxDto(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto) {
		Map map = new HashMap();
		try {
			QproductszgcxxDTO v_dto = foodProductService.queryProductScszxxDto(dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 *  deleteScszxx的中文名称：删除生产生长信息
	 *  deleteScszxx的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object deleteScszxx(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.deleteScszxx(request, dto));
	}
	
	/**
	 * 
	 * protuctjcjyMainIndex的中文名称：产品检测检验信息管理页面
	 * protuctjcjyMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/protuctjcjyMain")
	public void protuctjcjyMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jcjyxxFromIndex的中文名称：产品检测检验信息页面
	 * jcjyxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/jcjyxxFrom")
	public void jcjyxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * showJcjyxxFromIndex的中文名称：查看产品检测检验信息页面
	 * showJcjyxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/showJcjyxxFrom")
	public void showJcjyxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * saveProductJcjyxx的中文名称：保存产品检测检验信息
	 * 
	 * saveProductJcjyxx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveProductJcjyxx(HttpServletRequest request, @Param("..") QproductjcDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.saveProductJcjyxx(request, dto));
	}
	
	/**
	 * 
	 * queryProductJcjyxx的中文名称：查询产品检测检验信息
	 * 
	 * queryProductJcjyxx的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryProductJcjyxx(HttpServletRequest request, @Param("..") QproductjcDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryProductJcjyxx(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryProductJcjyxxDto的中文名称：查询产品检测检验信息DTO
	 * 
	 * queryProductJcjyxxDto的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryProductJcjyxxDto(HttpServletRequest request, @Param("..") QproductjcDTO dto) {
		Map map = new HashMap();
		try {
			QproductjcDTO v_dto = foodProductService.queryProductJcjyxxDto(dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 *  deleteJcjyxx的中文名称：删除检测检验信息
	 *  deleteJcjyxx的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object deleteJcjyxx(HttpServletRequest request, @Param("..") QproductjcDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.deleteJcjyxx(request, dto));
	}
	
	/**
     * 
     *  deletesym的中文名称：删除溯源码
     *  deletesym的概要说明：
     *  @param dto
     *  @param request
     *  @return
     *  @throws Exception
     *  Written by:gjf
     */
	@At
	@Ok("json")
	public Object deletesym (HttpServletRequest request, @Param("..") QproductpcDTO dto) {
		return  SysmanageUtil.execAjaxResult(foodProductService.deletesym(request,dto)) ;
	}

	/**
	 *
	 * protuctszhjMainIndex的中文名称：产品生长环境信息管理页面
	 * protuctszhjMainIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/protuctszhjMain")
	public void protuctszhjMainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * szhjxxFromIndex的中文名称：产品生长环境信息页面
	 * szhjxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/szhjxxFrom")
	public void szhjxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * showSzhjxxFromIndex的中文名称：查看产品生长环境信息页面
	 * showSzhjxxFromIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/spsy/spproduct/showSzhjxxFrom")
	public void showSzhjxxFromIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * saveProductSzhjxx的中文名称：保存产品生长环境信息
	 *
	 * saveProductSzhjxx的概要说明：
	 *
	 * @param dto
	 * @return Written by : zy
	 *
	 */
	@At
	@Ok("json")
	public Object saveProductSzhjxx(HttpServletRequest request, @Param("..") QproductszhjxxDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.saveProductSzhjxx(request, dto));
	}

	/**
	 *
	 * queryProductSzhjxx的中文名称：查询产品生长环境信息
	 *
	 * queryProductSzhjxx的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryProductSzhjxx(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = foodProductService.queryProductScszxx(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryProductSzhjxxDto的中文名称：查询产品生长环境信息DTO
	 *
	 * queryProductSzhjxxDto的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object queryProductSzhjxxDto(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto) {
		Map map = new HashMap();
		try {
			QproductszgcxxDTO v_dto = foodProductService.queryProductScszxxDto(dto);
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 *  deleteSzhjxx的中文名称：删除产品生长环境信息
	 *  deleteSzhjxx的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:zy
	 */
	@At
	@Ok("json")
	public Object deleteSzhjxx(HttpServletRequest request, @Param("..") QproductszgcxxDTO dto) {
		return SysmanageUtil.execAjaxResult(foodProductService.deleteScszxx(request, dto));
	}
}
