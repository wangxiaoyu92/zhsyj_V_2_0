package com.askj.supervision.module;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.supervision.service.CompanySySuperService;

/**
 * 
 * CompanySySuperModule的中文名称：企业溯源监管
 * 
 * CompanySySuperModule的描述：
 * 
 * Written by : zy
 */
@IocBean
@At("/supervision/comsyxx")
public class CompanySySuperModule {
	protected final Logger logger = Logger.getLogger(CompanySySuperModule.class);
	@Inject
	private CompanySySuperService companySySuperService;

	/**
	 * 
	 * ledgerstockMainIndex的中文名称：企业台账监管首页
	 * 
	 * ledgerstockMainIndex的概要说明：
	 *   
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/comsy/ledgerstockMain")
	public void ledgerstockMainIndex(HttpServletRequest request) {
		// 页面初始化
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
	public Object queryLedgerstock(HttpServletRequest request, @Param("..") QledgerstockDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return companySySuperService.queryLedgerstock(dto, pd);
	}
	
	/**
	 * 
	 * comSyxxMainIndex的中文名称：企业溯源监管页面初始化
	 * 
	 * comSyxxMainIndex的概要说明：
	 *   
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/comsy/comSyxxMain")
	public void comSyxxMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * queryCompany的中文名称：查询所有企业信息并分页显示(现在只显示企业对应关系表中信息)（以后需修改）
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryCompany(HttpServletRequest request, 
			@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return companySySuperService.queryCompany(dto, pd);
	}
	
	/**
	 * 
	 * showProductHcAndStockIndex的中文名称：产品批次耗材与进货台账页面
	 * 
	 * showProductHcAndStockIndex的概要说明：
	 *   
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/comsy/pchcledger")
	public void showProductHcAndStockIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * showProductSalesAndStockIndex的中文名称：产品进货销货台账页面
	 * 
	 * showProductSalesAndStockIndex的概要说明：
	 *   
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/comsy/saleandstock")
	public void showProductSalesAndStockIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
}
