package com.askj.zfba.module.pub;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ViewModel;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.alibaba.fastjson.JSON;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.ViewzfajzfwsDTO;
import com.askj.zfba.dto.ZfajzfwsDTO;
import com.askj.zfba.dto.ZfajzfwsmbDTO;
import com.askj.zfba.dto.Zfwsajdczjbg9DTO;
import com.askj.zfba.dto.Zfwsajhyjl18DTO;
import com.askj.zfba.dto.Zfwsajjttljl19DTO;
import com.askj.zfba.dto.ZfwsajlydjbDTO;
import com.askj.zfba.dto.Zfwsajyss3DTO;
import com.askj.zfba.dto.Zfwscaspb21DTO;
import com.askj.zfba.dto.Zfwscfkyjds12DTO;
import com.askj.zfba.dto.Zfwscfkywpyjtzs6DTO;
import com.askj.zfba.dto.Zfwscfkyyqtzs15DTO;
import com.askj.zfba.dto.Zfwscssbbl34DTO;
import com.askj.zfba.dto.Zfwscssbfhyjs35DTO;
import com.askj.zfba.dto.Zfwsdcxzcfjds29DTO;
import com.askj.zfba.dto.Zfwsdshz38DTO;
import com.askj.zfba.dto.Zfwsft13DTO;
import com.askj.zfba.dto.Zfwsfzjgshyjs47DTO;
import com.askj.zfba.dto.Zfwsjccfkyjds17DTO;
import com.askj.zfba.dto.Zfwsjcdwjclj46DTO;
import com.askj.zfba.dto.Zfwsjyjcjyjdgzs14DTO;
import com.askj.zfba.dto.Zfwslaspb2DTO;
import com.askj.zfba.dto.Zfwslxxzcfjdcgs32DTO;
import com.askj.zfba.dto.Zfwsmswpclqd31DTO;
import com.askj.zfba.dto.Zfwsmswppz30DTO;
import com.askj.zfba.dto.Zfwsspb39DTO;
import com.askj.zfba.dto.Zfwsspypxzcfwsfy36DTO;
import com.askj.zfba.dto.Zfwssxfzajyss5DTO;
import com.askj.zfba.dto.Zfwssxfzajysspb4DTO;
import com.askj.zfba.dto.Zfwstzbl24DTO;
import com.askj.zfba.dto.Zfwstzgzs22DTO;
import com.askj.zfba.dto.Zfwstztzs23DTO;
import com.askj.zfba.dto.Zfwstzyjs25DTO;
import com.askj.zfba.dto.Zfwswpqd37DTO;
import com.askj.zfba.dto.Zfwsxcjcbl8DTO;
import com.askj.zfba.dto.Zfwsxwdcbl7DTO;
import com.askj.zfba.dto.ZfwsxwdctzsDTO;
import com.askj.zfba.dto.Zfwsxxclwptzs16DTO;
import com.askj.zfba.dto.Zfwsxxdjbcwpcljds11DTO;
import com.askj.zfba.dto.Zfwsxxdjbcwptzs10DTO;
import com.askj.zfba.dto.Zfwsxzcfjabg40DTO;
import com.askj.zfba.dto.Zfwsxzcfjds28DTO;
import com.askj.zfba.dto.Zfwsxzcfjdspb27DTO;
import com.askj.zfba.dto.Zfwsxzcfqzzxsqs33DTO;
import com.askj.zfba.dto.Zfwsxzcfsxgzs26DTO;
import com.askj.zfba.dto.Zfwsxzcfsxtzgzspb41DTO;
import com.askj.zfba.dto.Zfwsxzcfwts42DTO;
import com.askj.zfba.dto.Zfwszdgxtzs43DTO;
import com.askj.zfba.dto.Zfwszlgztzs20DTO;
import com.askj.zfba.dto.zfwsjbdjb45DTO;
import com.askj.zfba.entity.Zfajzfwsmb;
import com.askj.zfba.service.pub.WsgldyService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;

/**
 * 
 * WsgldyModule的中文名称：文书管理打印
 * 
 * WsgldyModule的描述：
 * 
 * Written by : gjf
 */
@At("/pub/wsgldy")
@IocBean
public class WsgldyModule {
	protected final Logger logger = Logger.getLogger(WsgldyModule.class);
	
	@Inject
	protected WsgldyService wsgldyService;	
	
	/**
	 * 
	 * pubUploadFjList的中文名称：附件列表页面初始化
	 * 
	 * pubUploadFjList的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/pubWsgl")
	public void pubWsglIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryAjwslist的中文名称：查询文书列表
	 * 
	 * queryAjwslist的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAjwslist(@Param("..") ZfajzfwsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = wsgldyService.queryAjwslist(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryAjwslistHis的中文名称：查询文书列表 历史环节用到的文书
	 * 
	 * queryAjwslistHis的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAjwslistHis(@Param("..") ZfajzfwsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return wsgldyService.queryAjwslistHis(dto, pd);
	}	
	
	/**
	 * 
	 * queryAjwslist的中文名称：查询文书列表
	 * 
	 * queryAjwslist的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAjwsParamlist(@Param("..") ViewzfajzfwsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = wsgldyService.queryAjwsParamlist(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryAjwsParamlistOrder的中文名称：查询文书列表
	 * 
	 * queryAjwsParamlistOrder的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryAjwsParamlistOrder(@Param("..") ViewzfajzfwsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = wsgldyService.queryAjwsParamlistOrder(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	
	
	/**
	 * 
	 * pubUploadFjList的中文名称：附件列表页面增加初始化
	 * 
	 * pubUploadFjList的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/pubWsglAdd")
	public void pubWsglAddIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * saveAjdj的中文名称：保存执法文书
	 * 
	 * saveAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveZfwsadd(HttpServletRequest request,
			@Param("..") ZfajzfwsDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsadd(request,
				dto));
	}	
	
	/**
	 * 
	 * delAjdj的中文名称：删除案件登记执法文书
	 * 
	 * delAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delZfws(HttpServletRequest request,
			@Param("..") ZfajzfwsDTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.delZfws(request,
				dto));
	}
	
	/**
	 * 
	 * zfwsajlydjbIndex的中文名称：执法文书：案件来源登记表
	 * 
	 * zfwsajlydjbIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/1tyzfwsajlydjb")
	public void zfwsajlydjbIndex(HttpServletRequest request, @Param("..") ZfwsajlydjbDTO dto)
			throws Exception {
		// 页面初始化
		ZfwsajlydjbDTO v_ZfwsajlydjbDTO=(ZfwsajlydjbDTO)wsgldyService.queryZfwsajlydjbObj(request, dto);
		request.setAttribute("mybean", v_ZfwsajlydjbDTO);
	}	
	
	/**
	 * 
	 * queryAjdjDTO的中文名称：查询案件登记DTO
	 * 
	 * queryAjdjDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryZfwsajlydjbDTO(HttpServletRequest request,
			@Param("..") ZfwsajlydjbDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = wsgldyService.queryZfwsajlydjbDTO(dto, pd);
			List ls = (List) map.get("rows");
			ZfwsajlydjbDTO zfwsajlydjbDTO = null;
			if (ls != null && ls.size() > 0) {
				zfwsajlydjbDTO = (ZfwsajlydjbDTO) ls.get(0);
			}
			map.put("data", zfwsajlydjbDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveZfwsajlydjb的中文名称：保存执法文书案件来源登记表
	 * 
	 * saveZfwsajlydjb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object saveZfwsajlydjb(HttpServletRequest request,
			@Param("..") ZfwsajlydjbDTO dto) {
		//为了把执行后的表主键返回前台 做改动
		String v_retstr=wsgldyService.saveZfwsajlydjb(request,dto);
		Map v_map=SysmanageUtil.execAjaxResult(v_retstr);
		v_map.put("zfwszhujianid", dto.getZfwslydjid());
		return v_map;
		
//		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsajlydjb(request,
//				dto));
	}
	
	/**
	 * 
	 * zfwsajlydjbIndex的中文名称：执法文书：案件来源登记表
	 * 
	 * zfwsajlydjbIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/1tyzfwsajlydjbPrint")
	//@Ok("jsp:/jsp/pub/zfws/spjy_yx_printSltzs")
	public void zfwsajlydjbPrintIndex(HttpServletRequest request, @Param("..") ZfwsajlydjbDTO dto)
			throws Exception {
		ZfwsajlydjbDTO v_ZfwsajlydjbDTO=(ZfwsajlydjbDTO)wsgldyService.queryZfwsajlydjbObj(request, dto);
		request.setAttribute("printbean", v_ZfwsajlydjbDTO);		
	}
	/**
	 * 
	 * zfwssxfzlaysspbIndex的中文名称：执法文书：4涉嫌犯罪案件移送审批表
	 * 
	 * zfwssxfzlaysspbIndex的概要说明：	查询文书数据
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/4tyzfwssxfzajysspb")
	public void zfwssxfzlaysspbIndex(HttpServletRequest request,@Param("..")Zfwssxfzajysspb4DTO dto) throws Exception{
		Zfwssxfzajysspb4DTO v_dto = (Zfwssxfzajysspb4DTO)wsgldyService.queryZfwssxfzlaysspbObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * savezfwssxfzlaysspb的中文名称：4保存涉嫌犯罪案件移送审批表
	 * 
	 * savezfwssxfzlaysspb的概要说明：保存
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object savezfwssxfzlaysspb(HttpServletRequest request,
			@Param("..") Zfwssxfzajysspb4DTO dto) {
		
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String fzysspid = wsgldyService.saveZfwssxfzlaysspb(request,dto);
			if (fzysspid != null) {
				result.put("fzysspid", fzysspid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null); 
	}
	
	/**
	 * 
	 * zfwssxfzajysspbPrintIndex的中文名称：执法文书：4保存涉嫌犯罪案件移送审批表
	 * 
	 * zfwssxfzajysspbPrintIndex的概要说明： 打印预览
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/4tyzfwssxfzajysspbPrint")
	public void zfwssxfzajysspbPrintIndex(HttpServletRequest request, @Param("..") Zfwssxfzajysspb4DTO dto)
			throws Exception {
		Zfwssxfzajysspb4DTO v_ZfwsajlydjbDTO=(Zfwssxfzajysspb4DTO)wsgldyService.queryZfwssxfzlaysspbObj(request, dto);
		request.setAttribute("printbean", v_ZfwsajlydjbDTO);		
	}
	
	
	
	
	/**
	 * 
	 * ZfwssxfzajyssIndex的中文名称：执法文书：涉嫌犯罪案件移送书5
	 * 
	 * ZfwssxfzajyssIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/5tyzfwssxfzajyss")
	public void ZfwssxfzajyssIndex(HttpServletRequest request,@Param("..")Zfwssxfzajyss5DTO dto) throws Exception{
		Zfwssxfzajyss5DTO v_dto = (Zfwssxfzajyss5DTO)wsgldyService.queryZfwssxfzajyssObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	
	
	/**
	 * 
	 * saveZfwssxfzajyss的中文名称：保存涉嫌犯罪案件移送书5
	 * 
	 * saveZfwssxfzajyss的概要说明：
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwssxfzajyss(HttpServletRequest request,
			@Param("..")Zfwssxfzajyss5DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String sxfzysid = wsgldyService.saveZfwssxfzajyss(request,dto);
			if (sxfzysid != null) {
				result.put("sxfzysid", sxfzysid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwssxfzajyss5Print的中文名称：执法文书：保存涉嫌犯罪案件移送书5
	 * 
	 * zfwssxfzajyss5Print的概要说明： 打印预览
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/5tyzfwssxfzajyssPrint")
	public void zfwssxfzajyss5PrintIndex(HttpServletRequest request, @Param("..") Zfwssxfzajyss5DTO dto)
			throws Exception {
		Zfwssxfzajyss5DTO v_ZfwsajlydjbDTO=(Zfwssxfzajyss5DTO)wsgldyService.queryZfwssxfzajyssObj(request, dto);
		request.setAttribute("printbean", v_ZfwsajlydjbDTO);		
	}
	
	
	
	
	/**
	 * 
	 * Zfwsajdczjbg9Index的中文名称：执法文书：案件调查终结报告9
	 * 
	 * Zfwsajdczjbg9Index的概要说明：    主页查询
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	//@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsajdczjbg9")
	public String Zfwsajdczjbg9Index(HttpServletRequest request,@Param("..")Zfwsajdczjbg9DTO dto) throws Exception{
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwsajdczjbg9DTO v_dto = (Zfwsajdczjbg9DTO)wsgldyService.queryZfwsajdczjbg9Obj(request, dto);
		request.setAttribute("mybean", v_dto);
		return "jsp:/jsp/pub/zfba/zfbaws/9tyzfwsajdczjbg";
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsajdczjbg9";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsajdczjbg9";
//		}
	}
	
	/**
	 * 
	 * saveZfwsajdczjbg9的中文名称：案件调查终结报告9
	 * 
	 * saveZfwsajdczjbg9的概要说明： 保存案件调查终结报告9
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsajdczjbg9(HttpServletRequest request,
			@Param("..")Zfwsajdczjbg9DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String zjbgid=wsgldyService.saveZfwsajdczjbg9(request,dto);
			if (zjbgid != null) {
				result.put("ajdczjbgid", zjbgid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	
	/**
	 * 
	 * zfwsajdczjbg9Print的中文名称：执法文书：保存案件调查终结报告9
	 * 
	 * zfwsajdczjbg9Print的概要说明： 打印预览
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	//@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsajdczjbg9Print")
	public String zfwsajdczjbg9PrintIndex(HttpServletRequest request, @Param("..") Zfwsajdczjbg9DTO dto)
			throws Exception {
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwsajdczjbg9DTO v_ZfwsajlydjbDTO=(Zfwsajdczjbg9DTO)wsgldyService.queryZfwsajdczjbg9Obj(request, dto);
		request.setAttribute("printbean", v_ZfwsajlydjbDTO);
		return "jsp:/jsp/pub/zfba/zfbaws/9tyzfwsajdczjbgPrint";
		/*if (user.getAaa027().startsWith("4117")) {
			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsajdczjbg9Print";
		} else {
			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsajdczjbg9Print";
		}*/
	}
	
	/**
	 * 
	 * ZfwsxxdjbcwptzsIndex的中文名称：执法文书：先行登记保存物品通知书10
	 * 
	 * zfsxfzlaysspbIndex的概要说明：    主页查询
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/10tyzfwsxxdjbcwptzs")
	public void ZfwsxxdjbcwptzsIndex(HttpServletRequest request,@Param("..")Zfwsxxdjbcwptzs10DTO dto) throws Exception{
		Zfwsxxdjbcwptzs10DTO v_dto = (Zfwsxxdjbcwptzs10DTO)wsgldyService.queryZfwsxxdjbcwptzs10Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsxxdjbcwptzs的中文名称：先行登记保存物品通知书10
	 * 
	 * saveZfwsxxdjbcwptzs的概要说明： 保存或修改先行登记保存物品通知书10
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsxxdjbcwptzs(HttpServletRequest request,
			@Param("..")Zfwsxxdjbcwptzs10DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xxdjbcwptzsid = wsgldyService.saveZfwsxxdjbcwptzs10(request, dto);
			if (xxdjbcwptzsid != null) {
				result.put("xxdjbcwptzsid", xxdjbcwptzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * ZfwsxxdjbcwptzsIndex的中文名称：执法文书：先行登记保存物品通知书10 
	 * 
	 * zfsxfzlaysspbIndex的概要说明：    主页查询打   打印预览
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/10tyzfwsxxdjbcwptzsPrint")
	public void zfwsxxdjbcwptzs10PrintIndex(HttpServletRequest request,@Param("..")Zfwsxxdjbcwptzs10DTO dto) throws Exception{
		Zfwsxxdjbcwptzs10DTO v_dto = (Zfwsxxdjbcwptzs10DTO)wsgldyService.queryZfwsxxdjbcwptzs10Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * ZfwsxxdjbcwpcljdsIndex的中文名称：执法文书：先行登记保存物品处理决定书11
	 * 
	 * zfsxfzlaysspbIndex的概要说明：      查询对象
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/11tyzfwsxxdjbcwpcljds")
	public void ZfwsxxdjbcwpcljdsIndex(HttpServletRequest request,@Param("..")Zfwsxxdjbcwpcljds11DTO dto) throws Exception{
		Zfwsxxdjbcwpcljds11DTO v_dto = (Zfwsxxdjbcwpcljds11DTO)wsgldyService.queryZfwsxxdjbcwpcljds11Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsxxdjbcwpcljds11的中文名称：先行登记保存物品处理决定书11
	 * 
	 * saveZfwsxxdjbcwpcljds11的概要说明：保存或修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsxxdjbcwpcljds11(HttpServletRequest request,
			@Param("..")Zfwsxxdjbcwpcljds11DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xxcljdsid = wsgldyService.saveZfwsxxdjbcwpcljds11(request, dto);
			if (xxcljdsid != null) {
				result.put("xxcljdsid", xxcljdsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * ZfwsxxdjbcwpcljdsIndexPrint的中文名称：执法文书：先行登记保存物品处理决定书11
	 * 
	 * ZfwsxxdjbcwpcljdsIndexPrint的概要说明：      查询对象
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/11tyzfwsxxdjbcwpcljdsPrint")
	public void ZfwsxxdjbcwpcljdsIndexPrint(HttpServletRequest request,@Param("..")Zfwsxxdjbcwpcljds11DTO dto) throws Exception{
		Zfwsxxdjbcwpcljds11DTO v_dto = (Zfwsxxdjbcwpcljds11DTO)wsgldyService.queryZfwsxxdjbcwpcljds11Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * ZfwsftIndex的中文名称：执法文书：封条 13
	 * 
	 * ZfwsftIndex的概要说明：      查询对象跳转到封条页面
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/13tyzfwsft")
	public void ZfwsftIndex(HttpServletRequest request,@Param("..")Zfwsft13DTO dto) throws Exception{
		Zfwsft13DTO v_dto = (Zfwsft13DTO)wsgldyService.queryZfwsft13Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsft13的中文名称：封条 13
	 * 
	 * saveZfwsft13的概要说明：保存或修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsft13(HttpServletRequest request,
			@Param("..")Zfwsft13DTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsft13(request, dto));
	}
	
	/**
	 * 
	 * ZfwsftIndexPrint的中文名称：执法文书：封条 13
	 * 
//	 * ZfwsftIndexPrint的概要说明：打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/13tyzfwsftPrint")
	public void ZfwsftIndexPrint(HttpServletRequest request,@Param("..")Zfwsft13DTO dto) throws Exception{
		Zfwsft13DTO v_dto = (Zfwsft13DTO)wsgldyService.queryZfwsft13Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	/**
	 * 
	 * Zfwsjccfkyjds17Index的中文名称：执法文书：解除查封（扣押）决定书17
	 * 
	 * Zfwsjccfkyjds17Index的概要说明：      查询对象跳转到解除查封（扣押）决定书17
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/17tyzfwsjccfkyjds")
	public void Zfwsjccfkyjds17Index(HttpServletRequest request,@Param("..")Zfwsjccfkyjds17DTO dto) throws Exception{
		Zfwsjccfkyjds17DTO v_dto = (Zfwsjccfkyjds17DTO)wsgldyService.queryZfwsjccfkyjds17bj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	
	
	/**
	 * 
	 * saveZfwsjccfkyjds17的中文名称：解除查封（扣押）决定书17
	 * 
	 * saveZfwsjccfkyjds17的概要说明：保存或者修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsjccfkyjds17(HttpServletRequest request,
			@Param("..")Zfwsjccfkyjds17DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String jccfkyjdsid = wsgldyService.saveZfwsjccfkyjds17(request, dto);
			if (jccfkyjdsid != null) {
				result.put("jccfkyjdsid", jccfkyjdsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * Zfwsjccfkyjds17IndexPrint的中文名称：执法文书：解除查封（扣押）决定书17 
	 * 
	 * Zfwsjccfkyjds17IndexPrint的概要说明：  打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/17tyzfwsjccfkyjdsPrint")
	public void Zfwsjccfkyjds17IndexPrint(HttpServletRequest request,@Param("..")Zfwsjccfkyjds17DTO dto) throws Exception{
		Zfwsjccfkyjds17DTO v_dto = (Zfwsjccfkyjds17DTO)wsgldyService.queryZfwsjccfkyjds17bj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	
	/**
	 * 
	 * Zfwstzgzs22Index的中文名称：执法文书：听证告知书 22
	 * 
	 * Zfwstzgzs22Index的概要说明：      查询对象跳转到 主页面
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */ 
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzgzs22")
	public void Zfwstzgzs22Index(HttpServletRequest request,@Param("..")Zfwstzgzs22DTO dto) throws Exception{
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwstzgzs22DTO v_dto = (Zfwstzgzs22DTO)wsgldyService.queryZfwstzgzs22Obj(request, dto);
		request.setAttribute("mybean", v_dto);
//		// 驻马店文书页面
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwstzgzs22";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwstzgzs22";
//		}
	}
	
	/**
	 * 
	 * saveZfwstzgzs22的中文名称：听证告知书22
	 * 
	 * saveZfwstzgzs22的概要说明：保存或者修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwstzgzs22(HttpServletRequest request,
			@Param("..")Zfwstzgzs22DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String tzgzsid = wsgldyService.saveZfwstzgzs22(request, dto);
			if (tzgzsid != null) {
				result.put("tzgzsid", tzgzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	
	/**
	 * 
	 * Zfwstzgzs22IndexPrint的中文名称：执法文书：听证告知书 22
	 * 
	 * Zfwstzgzs22IndexPrint的概要说明：     打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzgzs22Print")
	public void Zfwstzgzs22IndexPrint(HttpServletRequest request, @Param("..")Zfwstzgzs22DTO dto) throws Exception{
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwstzgzs22DTO v_dto = (Zfwstzgzs22DTO)wsgldyService.queryZfwstzgzs22Obj(request, dto);
		request.setAttribute("mybean", v_dto);
//		// 驻马店文书页面
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwstzgzs22Print";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwstzgzs22Print";
//		}
	}
	
	
	/**
	 * 
	 * Zfwstzyjs25Index的中文名称：执法文书：听证意见书 25
	 * 
	 * Zfwstzyjs25Index的概要说明：      查询对象跳转到 主页面
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzyjs25")
	public void Zfwstzyjs25Index(HttpServletRequest request,@Param("..")Zfwstzyjs25DTO dto) throws Exception{
		Zfwstzyjs25DTO v_dto = (Zfwstzyjs25DTO)wsgldyService.queryZfwstzyjs25Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwstzyjs25的中文名称：听证意见书25
	 * 
	 * saveZfwstzyjs25的概要说明：保存或者修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwstzyjs25(HttpServletRequest request,
			@Param("..")Zfwstzyjs25DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String tzyjsid = wsgldyService.saveZfwstzyjs25(request, dto);
			if (tzyjsid != null) {
				result.put("tzyjsid", tzyjsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * Zfwstzyjs25IndexPrint的中文名称：执法文书：听证意见书 25
	 * 
	 * Zfwstzyjs25IndexPrint的概要说明：      查询对象跳转到 主页面
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzyjs25Print")
	public void Zfwstzyjs25IndexPrint(HttpServletRequest request,@Param("..")Zfwstzyjs25DTO dto) throws Exception{
		Zfwstzyjs25DTO v_dto = (Zfwstzyjs25DTO)wsgldyService.queryZfwstzyjs25Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	/**
	 * 
	 * Zfwsxzcfsxgzs26Index的中文名称：执法文书：行政处罚事先告知书 26
	 * 
	 * Zfwsxzcfsxgzs26Index的概要说明：      查询对象跳转到 主页面
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfsxgzs26")
	public void Zfwsxzcfsxgzs26Index(HttpServletRequest request,@Param("..")Zfwsxzcfsxgzs26DTO dto) throws Exception{
		Zfwsxzcfsxgzs26DTO v_dto = (Zfwsxzcfsxgzs26DTO)wsgldyService.queryZfwsxzcfsxgzs26Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsxzcfsxgzs26的中文名称：行政处罚事先告知书 26
	 * 
	 * saveZfwsxzcfsxgzs26的概要说明：保存或者修改 行政处罚事先告知书 26
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfsxgzs26(HttpServletRequest request,
			@Param("..")Zfwsxzcfsxgzs26DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfsxgzsid = wsgldyService.saveZfwsxzcfsxgzs26(request, dto);
			if (xzcfsxgzsid != null) {
				result.put("xzcfsxgzsid", xzcfsxgzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	
	/**
	 * 
	 * zfwsxzcfsxgzs26Print的中文名称：执法文书：行政处罚事先告知书 26
	 * 
	 * zfwsxzcfsxgzs26Print的概要说明：      打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfsxgzs26Print")
	public void Zfwsxzcfsxgzs26IndexPrint(HttpServletRequest request,@Param("..")Zfwsxzcfsxgzs26DTO dto) throws Exception{
		Zfwsxzcfsxgzs26DTO v_dto = (Zfwsxzcfsxgzs26DTO)wsgldyService.queryZfwsxzcfsxgzs26Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	/**
	 * 
	 * Zfwsdcxzcfjds29DTOIndex的中文名称：执法文书：当场行政处罚决定书 29
	 * 
	 * Zfwsdcxzcfjds29DTOIndex的概要说明：      查询对象跳转到 当场行政处罚决定书29
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/dcxzcfjds29")
	public void Zfwsdcxzcfjds29Index(HttpServletRequest request,@Param("..")Zfwsdcxzcfjds29DTO dto) throws Exception{
		Zfwsdcxzcfjds29DTO v_dto = (Zfwsdcxzcfjds29DTO)wsgldyService.queryZfwsdcxzcfjds29Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsdcxzcfjds29的中文名称：当场行政处罚决定书 29
	 * 
	 * saveZfwsdcxzcfjds29的概要说明：保存或者修改 行政处罚事先告知书 29
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsdcxzcfjds29(HttpServletRequest request,
			@Param("..")Zfwsdcxzcfjds29DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String dcxzcfjdsid = wsgldyService.saveZfwsdcxzcfjds29(request, dto);
			if (dcxzcfjdsid != null) {
				result.put("dcxzcfjdsid", dcxzcfjdsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * Zfwsdcxzcfjds29DTOIndex的中文名称：执法文书：当场行政处罚决定书 29
	 * 
	 * Zfwsdcxzcfjds29DTOIndex的概要说明：      打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/dcxzcfjds29Print")
	public void Zfwsdcxzcfjds29IndexPrint(HttpServletRequest request,@Param("..")Zfwsdcxzcfjds29DTO dto) throws Exception{
		Zfwsdcxzcfjds29DTO v_dto = (Zfwsdcxzcfjds29DTO)wsgldyService.queryZfwsdcxzcfjds29Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * Zfwslxxzcfjdcgs32Index的中文名称：执法文书：履行行政处罚决定催告书  32
	 * 
	 * Zfwslxxzcfjdcgs32Index的概要说明：      查询对象跳转到 履行行政处罚决定催告书 32
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwslxxzcfjdcgs32")
	public void Zfwslxxzcfjdcgs32Index(HttpServletRequest request,@Param("..")Zfwslxxzcfjdcgs32DTO dto) throws Exception{
		Zfwslxxzcfjdcgs32DTO v_dto = (Zfwslxxzcfjdcgs32DTO)wsgldyService.queryZfwslxxzcfjdcgs32Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	} 
	/**
	 * 
	 * saveZfwslxxzcfjdcgs32的中文名称： 履行行政处罚决定催告书 32
	 * 
	 * saveZfwslxxzcfjdcgs32的概要说明：履行行政处罚决定催告书 32
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwslxxzcfjdcgs32(HttpServletRequest request,
			@Param("..")Zfwslxxzcfjdcgs32DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String lxxzcfjdcgsid = wsgldyService.saveZfwslxxzcfjdcgs32(request, dto);
			if (lxxzcfjdcgsid != null) {
				result.put("lxxzcfjdcgsid", lxxzcfjdcgsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * Zfwslxxzcfjdcgs32Index的中文名称：执法文书：履行行政处罚决定催告书  32
	 * 
	 * Zfwslxxzcfjdcgs32IndexPrint的概要说明：    打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwslxxzcfjdcgs32Print")
	public void Zfwslxxzcfjdcgs32IndexPrint(HttpServletRequest request,@Param("..")Zfwslxxzcfjdcgs32DTO dto) throws Exception{
		Zfwslxxzcfjdcgs32DTO v_dto = (Zfwslxxzcfjdcgs32DTO)wsgldyService.queryZfwslxxzcfjdcgs32Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	/**
	 * 
	 * Zfwscssbbl34Index的中文名称：执法文书：陈述申辩笔录 34
	 * 
	 * Zfwscssbbl34Index的概要说明：      查询对象跳转到 陈述申辩笔录 34
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscssbbl34")
	public void Zfwscssbbl34Index(HttpServletRequest request,@Param("..")Zfwscssbbl34DTO dto) throws Exception{
		Zfwscssbbl34DTO v_dto = (Zfwscssbbl34DTO)wsgldyService.queryZfwscssbbl34Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	
	
	/**
	 * 
	 * saveZfwscssbbl34的中文名称： 陈述申辩笔录 34
	 * 
	 * saveZfwscssbbl34的概要说明：陈述申辩笔录 34 保存或者修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwscssbbl34(HttpServletRequest request,
			@Param("..")Zfwscssbbl34DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String cssbblid = wsgldyService.saveZfwscssbbl34(request, dto);
			if (cssbblid != null) {
				result.put("cssbblid", cssbblid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	
	/**
	 * 
	 * Zfwscssbbl34IndexPrint的中文名称：执法文书：陈述申辩笔录 34
	 * 
	 * Zfwscssbbl34IndexPrint的概要说明：      打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscssbbl34Print")
	public void Zfwscssbbl34IndexPrint(HttpServletRequest request,@Param("..")Zfwscssbbl34DTO dto) throws Exception{
		Zfwscssbbl34DTO v_dto = (Zfwscssbbl34DTO)wsgldyService.queryZfwscssbbl34Obj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	
	/**
	 * 
	 * Zfwscssbbl34Index的中文名称：执法文书：送达回执 38
	 * 
	 * Zfwscssbbl34Index的概要说明：      查询对象跳转到送达回执 38
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
	//@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsdshz38")
	@Ok("jsp:/jsp/pub/zfba/zfbaws/sdshz38")
	public void Zfwsdshz38Index(HttpServletRequest request,@Param("..")Zfwsdshz38DTO dto) throws Exception{
		Zfwsdshz38DTO v_dto = (Zfwsdshz38DTO)wsgldyService.queryZfwsdshz38(request, dto);
//		Sysuser user = SysmanageUtil.getSysuser();
		request.setAttribute("mybean", v_dto);
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsdshz38";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsdshz38";
//		}
	}
	
	
	
	
	/**
	 * 
	 * saveZfwsdshz38的中文名称：执法文书送达回执 38
	 * 
	 * saveZfwsdshz38的概要说明： 保存或者修改
	 * 
	 * @param dto
	 * @return Written by : wanghao
	 */
	@At
	@Ok("json")
	public Object saveZfwsdshz38(HttpServletRequest request,@Param("..")Zfwsdshz38DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String sdhzid =wsgldyService.saveZfwsdshz38(request, dto);
			if (sdhzid != null) {
				result.put("sdhzid", sdhzid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回; 
	}
	
	
	/**
	 * 
	 * zfwsdshz38Print的中文名称：执法文书：送达回执 38
	 * 
	 * zfwsdshz38Print的概要说明：     打印
	 * 
	 * @param request
	 *            Written by : wanghao
	 * @throws Exception
	 * 
	 */
	@At
//	@Ok("re:jsp:/jsp/error/error")
	@Ok("jsp:/jsp/pub/zfba/zfbaws/sdshz38Print")
	public void Zfwsdshz38IndexPrint(HttpServletRequest request,@Param("..")Zfwsdshz38DTO dto) throws Exception{
		Zfwsdshz38DTO v_dto = (Zfwsdshz38DTO)wsgldyService.queryZfwsdshz38(request, dto);
//		Sysuser user = SysmanageUtil.getSysuser();
		request.setAttribute("mybean", v_dto);
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsdshz38Print";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsdshz38Print";
//		} 
	}
	
	/**
	 * 
	 * zfwsajyssIndex的中文名称： 查询案件移送书
	 * 
	 * zfwsajyssIndex的概要说明：将查询案件移送书内容显示到页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/3tyzfwsajyss")
	public void zfwsajyss3Index(HttpServletRequest request, @Param("..") Zfwsajyss3DTO dto)
			throws Exception {
		// 查询案件移送书内容
		Zfwsajyss3DTO v_zfwsajyss3DTO = (Zfwsajyss3DTO)wsgldyService.queryZfwsajyssObj(request, dto);
		request.setAttribute("mybean", v_zfwsajyss3DTO);
	}
	
	/**
	 * 
	 * saveZfwsajyss的中文名称：保存执法文书案件移送书
	 * 
	 * saveZfwsajyss的概要说明：对修改内容进行修改
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object saveZfwsajyss(HttpServletRequest request,
			@Param("..") Zfwsajyss3DTO dto) {
		String v_retstr=wsgldyService.saveZfwsajyss(request,dto);
		Map v_map=SysmanageUtil.execAjaxResult(v_retstr);
		v_map.put("zfwszhujianid", dto.getAjysid());
		return v_map;		
//		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsajyss(request,
//				dto));
	}
	
	/**
	 * 
	 * zfwsajyssPrintIndex的中文名称：打印案件移送书
	 * 
	 * zfwsajyssPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/3tyzfwsajyssPrint")
	public void zfwsajyss3PrintIndex(HttpServletRequest request, @Param("..") Zfwsajyss3DTO dto)
			throws Exception {
		
		Zfwsajyss3DTO v_zfwsajyss3DTO = (Zfwsajyss3DTO)wsgldyService.queryZfwsajyssObj(request, dto);
		request.setAttribute("printbean", v_zfwsajyss3DTO);		
	}
	
	/**
	 * 
	 * zfwscfkywpyjtzs6Index的中文名称：查封扣押物品移交通知书
	 * 
	 * zfwscfkywpyjtzs6Index的概要说明：查询扣押物品移交通知书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/6tyzfwscfkywpyjtzs")
	public void zfwscfkywpyjtzs6Index(HttpServletRequest request, @Param("..") Zfwscfkywpyjtzs6DTO dto)
			throws Exception {
		// 查封扣押物品通知书
		Zfwscfkywpyjtzs6DTO v_zfwscfkywpyjtzs6DTO = (Zfwscfkywpyjtzs6DTO)wsgldyService.queryZfwscfkywpyjtzsObj(request, dto);
		request.setAttribute("mybean", v_zfwscfkywpyjtzs6DTO);
	}
	
	/**
	 * 
	 * saveZfwscfkywpyjtzs的中文名称：保存执法文书查封扣押物品移交通知书
	 * 
	 * saveZfwscfkywpyjtzs的概要说明：对修改内容进行打印
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwscfkywpyjtzs(HttpServletRequest request,
			@Param("..") Zfwscfkywpyjtzs6DTO dto) { 
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String cfkyyjid =wsgldyService.saveZfwscfkywpyjtzs(request, dto);
			if (cfkyyjid != null) {
				result.put("cfkyyjid", cfkyyjid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * zfwscfkywpyjtzs6PrintIndex的中文名称：打印查封扣押物品通知书
	 * 
	 * zfwscfkywpyjtzs6PrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/6tyzfwscfkywpyjtzsPrint")
	public void zfwscfkywpyjtzs6PrintIndex(HttpServletRequest request, @Param("..") Zfwscfkywpyjtzs6DTO dto)
			throws Exception {
		// 查封扣押物品通知书
		Zfwscfkywpyjtzs6DTO v_zfwscfkywpyjtzs6DTO = (Zfwscfkywpyjtzs6DTO)wsgldyService.queryZfwscfkywpyjtzsObj(request, dto);
		request.setAttribute("printbean", v_zfwscfkywpyjtzs6DTO);
	}
	
	/**
	 * 
	 * zfwsxcjcblIndex的中文名称：现场检查笔录
	 * 
	 * zfwsxcjcblIndex的概要说明：查询现场检查笔录内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/8tyzfwsxcjcbl")
	public void zfwsxcjcblIndex(HttpServletRequest request, @Param("..") Zfwsxcjcbl8DTO dto)
			throws Exception {
		// 现场见长笔录内容
		Zfwsxcjcbl8DTO v_zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO)wsgldyService.queryZfwsxcjcblObj(request, dto);
		request.setAttribute("mybean", v_zfwsxcjcbl8DTO);
	}
	
	/**
	 * 
	 * saveZfwsxcjcbl的中文名称：现场检查笔录
	 * 
	 * saveZfwsxcjcbl的概要说明：对修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsxcjcbl(HttpServletRequest request,
			@Param("..") Zfwsxcjcbl8DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xcjcblid = wsgldyService.saveZfwsxcjcbl(request, dto);
			if (xcjcblid != null) {
				result.put("xcjcblid", xcjcblid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}/*
	return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsxcjcbl(request,
				dto));
	}*/
	
	/**
	 * 
	 * zfwsxcjcblPrintIndex的中文名称：打印现场检查笔录
	 * 
	 * zfwsxcjcblPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/8tyzfwsxcjcblPrint")
	public void zfwsxcjcblPrintIndex(HttpServletRequest request, @Param("..") Zfwsxcjcbl8DTO dto)
			throws Exception {
		
		Zfwsxcjcbl8DTO v_zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO)wsgldyService.queryZfwsxcjcblObj(request, dto);
		request.setAttribute("printbean", v_zfwsxcjcbl8DTO);		
	}
	
	/**
	 * 
	 * zfwsjygzsIndex的中文名称：查询检验（检测、检疫、鉴定）告知书
	 * 
	 * zfwsjygzsIndex的概要说明：查询执法文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/14tyzfwsjygzs")
	public void zfwsjygzsIndex(HttpServletRequest request, @Param("..") Zfwsjyjcjyjdgzs14DTO dto)
			throws Exception {
		// 执法文书：检验（检测、检疫、鉴定）告知书内容
		Zfwsjyjcjyjdgzs14DTO v_zfwsjyjcjyjdgzs14DTO = (Zfwsjyjcjyjdgzs14DTO)wsgldyService.queryZfwsjygzsObj(request, dto);
		request.setAttribute("mybean", v_zfwsjyjcjyjdgzs14DTO);
	}
	
	/**
	 * 
	 * saveZfwsjygzs的中文名称：保存检验（检测、检疫、鉴定）告知书
	 * 
	 * saveZfwsjygzs的概要说明：对修改或添加内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsjygzs(HttpServletRequest request,
			@Param("..") Zfwsjyjcjyjdgzs14DTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsjygzs(request,
				dto));
	}
	
	/**
	 * 
	 * zfwsjygzsPrintIndex的中文名称：检验告知书打印
	 * 
	 * zfwsjygzsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/14tyzfwsjygzsPrint")
	public void zfwsjygzsPrintIndex(HttpServletRequest request, @Param("..") Zfwsjyjcjyjdgzs14DTO dto)
			throws Exception {
		
		Zfwsjyjcjyjdgzs14DTO v_zfwsjyjcjyjdgzs14DTO = (Zfwsjyjcjyjdgzs14DTO)wsgldyService.queryZfwsjygzsObj(request, dto);
		request.setAttribute("printbean", v_zfwsjyjcjyjdgzs14DTO);		
	}
	
	/**
	 * 
	 * zfwsxxclwptzsIndex的中文名称：查询先行处理物品通知书
	 * 
	 * zfwsxxclwptzsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/16tyzfwsxxclwptzs")
	public void zfwsxxclwptzsIndex(HttpServletRequest request, @Param("..") Zfwsxxclwptzs16DTO dto)
			throws Exception {
		// 先行处理物品通知书内容
		Zfwsxxclwptzs16DTO v_zfwsxxclwptzs16DTO = (Zfwsxxclwptzs16DTO)wsgldyService.queryZfwsxxclwptzsObj(request, dto);
		request.setAttribute("mybean", v_zfwsxxclwptzs16DTO);
	}
	
	/**
	 * 
	 * saveZfwsxxclwptzs的中文名称：保存先行处理物品通知书
	 * 
	 * saveZfwsxxclwptzs的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy 
	 */ 
	@At
	@Ok("json")
	public Object saveZfwsxxclwptzs(HttpServletRequest request,
			@Param("..") Zfwsxxclwptzs16DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xxclwptzsid = wsgldyService.saveZfwsxxclwptzs(request, dto);
			if (xxclwptzsid != null) {
				result.put("xxclwptzsid", xxclwptzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	
	/**
	 * 
	 * zfwsxxclwptzsPrintIndex的中文名称：先行处理物品通知书打印
	 * 
	 * zfwsxxclwptzsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/16tyzfwsxxclwptzsPrint")
	public void zfwsxxclwptzsPrintIndex(HttpServletRequest request, @Param("..") Zfwsxxclwptzs16DTO dto)
			throws Exception {
		
		Zfwsxxclwptzs16DTO v_zfwsxxclwptzs16DTO = (Zfwsxxclwptzs16DTO)wsgldyService.queryZfwsxxclwptzsObj(request, dto);
		request.setAttribute("printbean", v_zfwsxxclwptzs16DTO);		
	}
	
	/**
	 * 
	 * zfwscaspbIndex的中文名称：撤案审批表
	 * 
	 * zfwscaspbIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscaspb21")
	public void zfwscaspbIndex(HttpServletRequest request, @Param("..") Zfwscaspb21DTO dto)
			throws Exception {
		// 查询撤案审批表内容
		Zfwscaspb21DTO v_zfwscaspb21DTO = (Zfwscaspb21DTO)wsgldyService.queryZfwscaspbObj(request, dto);
		request.setAttribute("mybean", v_zfwscaspb21DTO);
	}
	
	/**
	 * 
	 * saveZfwscaspb的中文名称：保存撤案审批表
	 * 
	 * saveZfwscaspb的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwscaspb(HttpServletRequest request,
			@Param("..") Zfwscaspb21DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String caspbid = wsgldyService.saveZfwscaspb(request,dto);
			if (caspbid != null) {
				result.put("caspbid", caspbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwscaspbPrintIndex的中文名称：打印撤案审批表
	 * 
	 * zfwscaspbPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscaspb21Print")
	public void zfwscaspbPrintIndex(HttpServletRequest request, @Param("..") Zfwscaspb21DTO dto)
			throws Exception {
		
		Zfwscaspb21DTO v_zfwscaspb21DTO = (Zfwscaspb21DTO)wsgldyService.queryZfwscaspbObj(request, dto);
		request.setAttribute("printbean", v_zfwscaspb21DTO);		
	}
	
	/**
	 * 
	 * zfwstzblIndex的中文名称：听证笔录
	 * 
	 * zfwstzblIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzbl24")
	public void zfwstzblIndex(HttpServletRequest request, @Param("..") Zfwstzbl24DTO dto)
			throws Exception {
		// 听证笔录内容
		Zfwstzbl24DTO v_zfwstzbl24DTO = (Zfwstzbl24DTO)wsgldyService.queryZfwstzblObj(request, dto);
		request.setAttribute("mybean", v_zfwstzbl24DTO);
	}
	
	/**
	 * 
	 * saveZfwstzbl的中文名称：保存听证笔录
	 * 
	 * saveZfwstzbl的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwstzbl(HttpServletRequest request,
			@Param("..") Zfwstzbl24DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String tzblid =wsgldyService.saveZfwstzbl(request,dto);
			if (tzblid != null) {
				result.put("tzblid", tzblid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null); 
	}
	
	/**
	 * 
	 * zfwstzblPrintIndex的中文名称：打印听证笔录
	 * 
	 * zfwstzblPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstzbl24Print")
	public void zfwstzblPrintIndex(HttpServletRequest request, @Param("..") Zfwstzbl24DTO dto)
			throws Exception {
		
		Zfwstzbl24DTO v_zfwstzbl24DTO = (Zfwstzbl24DTO)wsgldyService.queryZfwstzblObj(request, dto);
		request.setAttribute("printbean", v_zfwstzbl24DTO);		
	}
	
	/**
	 * 
	 * zfwsxzcfjdsIndex的中文名称：行政处罚决定书
	 * 
	 * zfwsxzcfjdsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
//	@Ok("re:jsp:/jsp/error/error")
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfjds28")
	public void zfwsxzcfjdsIndex(HttpServletRequest request, @Param("..") Zfwsxzcfjds28DTO dto)
			throws Exception {
//		// 行政处罚决定书内容
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwsxzcfjds28DTO v_zfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO)wsgldyService.queryZfwsxzcfjdsObj(request, dto);
		request.setAttribute("mybean", v_zfwsxzcfjds28DTO);
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsxzcfjds28";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsxzcfjds28";
//		}
	}

	/**
	 * 
	 * saveZfwsxzcfjds的中文名称：保存行政处罚决定书
	 * 
	 * saveZfwsxzcfjds的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfjds(HttpServletRequest request,
			@Param("..") Zfwsxzcfjds28DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfjdsid = wsgldyService.saveZfwsxzcfjds(request,dto);
			if (xzcfjdsid != null) {
				result.put("xzcfjdsid", xzcfjdsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwsxzcfjdsPrintIndex的中文名称：打印行政处罚决定书
	 * 
	 * zfwsxzcfjdsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
//	@Ok("re:jsp:/jsp/error/error")
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfjds28Print")
	public void zfwsxzcfjdsPrintIndex(HttpServletRequest request, @Param("..") Zfwsxzcfjds28DTO dto)
			throws Exception {
		
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwsxzcfjds28DTO v_zfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO)wsgldyService.queryZfwsxzcfjdsObj(request, dto);
		request.setAttribute("printbean", v_zfwsxzcfjds28DTO);
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsxzcfjds28Print";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsxzcfjds28Print";
//		}
	}
	
	/**
	 * 
	 * zfwsmswpclqdIndex的中文名称：没收物品处理清单
	 * 
	 * zfwsmswpclqdIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmswpclqd31")
	public void zfwsmswpclqdIndex(HttpServletRequest request, @Param("..") Zfwsmswpclqd31DTO dto)
			throws Exception {
		// 没收物品处理清单内容
		Zfwsmswpclqd31DTO v_zfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO)wsgldyService.queryZfwsmswpclqdObj(request, dto);
		request.setAttribute("mybean", v_zfwsmswpclqd31DTO);
	}

	/**
	 * 
	 * saveZfwsmswpclqd的中文名称：保存没收物品处理清单
	 * 
	 * saveZfwsmswpclqd的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsmswpclqd(HttpServletRequest request,
			@Param("..") Zfwsmswpclqd31DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String mswpclqdid =wsgldyService.saveZfwsmswpclqd(request,dto);
			if (mswpclqdid != null) {
				result.put("mswpclqdid", mswpclqdid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null); 
	}

	/**
	 * 
	 * zfwsmswpclqdPrintIndex的中文名称：打印没收物品处理清单
	 * 
	 * zfwsmswpclqdPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmswpclqd31Print")
	public void zfwsmswpclqdPrintIndex(HttpServletRequest request, @Param("..") Zfwsmswpclqd31DTO dto)
			throws Exception {
		
		Zfwsmswpclqd31DTO v_zfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO)wsgldyService.queryZfwsmswpclqdObj(request, dto);
		request.setAttribute("printbean", v_zfwsmswpclqd31DTO);		
	}
	
	/**
	 * 
	 * queryZfwsmswpclqdmx的中文名称：查询没收物品处理清单明细
	 * 
	 * queryZfwsmswpclqdmx的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryZfwsmswpclqdmx(@Param("..") Zfwsmswpclqd31DTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		System.out.println(wsgldyService.queryZfwsmswpclqdmx(dto, pd));
		return wsgldyService.queryZfwsmswpclqdmx(dto, pd);
	}
	
	/**
	 * 
	 * zfwsxzcfqzzxsqsIndex的中文名称：行政处罚强制执行申请书
	 * 
	 * zfwsxzcfqzzxsqsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsxzcfqzzxsqs33")
	public void zfwsxzcfqzzxsqsIndex(HttpServletRequest request, @Param("..") Zfwsxzcfqzzxsqs33DTO dto)
			throws Exception {
		// 
		Zfwsxzcfqzzxsqs33DTO v_zfwsxzcfqzzxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO)wsgldyService.queryZfwsxzcfqzzxsqsObj(request, dto);
		request.setAttribute("mybean", v_zfwsxzcfqzzxsqs33DTO);
	}

	/**
	 * 
	 * saveZfwsxzcfqzzxsqs的中文名称：保存行政处罚强制执行申请书
	 * 
	 * saveZfwsxzcfqzzxsqs的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfqzzxsqs(HttpServletRequest request,
			@Param("..") Zfwsxzcfqzzxsqs33DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfqzzxsqsid = wsgldyService.saveZfwsxzcfqzzxsqs(request,dto);
			if (xzcfqzzxsqsid != null) {
				result.put("xzcfqzzxsqsid", xzcfqzzxsqsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回; 
	}
	
	/**
	 * 
	 * zfwsxzcfqzzxsqsPrintIndex的中文名称：打印行政处罚强制执行申请书
	 * 
	 * zfwsxzcfqzzxsqsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsxzcfqzzxsqs33Print")
	public void zfwsxzcfqzzxsqsPrintIndex(HttpServletRequest request, @Param("..") Zfwsxzcfqzzxsqs33DTO dto)
			throws Exception {
		
		Zfwsxzcfqzzxsqs33DTO v_zfwsxzcfqzzxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO)wsgldyService.queryZfwsxzcfqzzxsqsObj(request, dto);
		request.setAttribute("printbean", v_zfwsxzcfqzzxsqs33DTO);		
	}
	
	/**
	 * 
	 * zfwscssbfhyjsIndex的中文名称：陈述申辩复核意见书
	 * 
	 * zfwscssbfhyjsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscssbfhyjs35")
	public void zfwscssbfhyjsIndex(HttpServletRequest request, @Param("..") Zfwscssbfhyjs35DTO dto)
			throws Exception {
		// 陈述申辩复核意见书内容
		Zfwscssbfhyjs35DTO v_zfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO)wsgldyService.queryZfwscssbfhyjsObj(request, dto);
		request.setAttribute("mybean", v_zfwscssbfhyjs35DTO);
	}
	
	/**
	 * 
	 * saveZfwscssbfhyjs的中文名称：保存陈述申辩复核意见书
	 * 
	 * saveZfwscssbfhyjs的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwscssbfhyjs(HttpServletRequest request,
			@Param("..") Zfwscssbfhyjs35DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String cssbfhyjsid = wsgldyService.saveZfwscssbfhyjs(request,dto);
			if (cssbfhyjsid != null) {
				result.put("cssbfhyjsid", cssbfhyjsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回; 
	}

	/**
	 * 
	 * zfwscssbfhyjsPrintIndex的中文名称：打印陈述申辩复核意见书
	 * 
	 * zfwscssbfhyjsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwscssbfhyjs35Print")
	public void zfwscssbfhyjsPrintIndex(HttpServletRequest request, @Param("..") Zfwscssbfhyjs35DTO dto)
			throws Exception {
		
		Zfwscssbfhyjs35DTO v_zfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO)wsgldyService.queryZfwscssbfhyjsObj(request, dto);
		request.setAttribute("printbean", v_zfwscssbfhyjs35DTO);		
	}
	
	/**
	 * 
	 * zfwsspbIndex的中文名称：通用审批表
	 * 
	 * zfwsspbIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsspb39")
	public void zfwsspbIndex(HttpServletRequest request, @Param("..") Zfwsspb39DTO dto)
			throws Exception {
		// 通用审批表内容
		Zfwsspb39DTO v_zfwsspb39DTO = (Zfwsspb39DTO)wsgldyService.queryZfwsspbObj(request, dto);
		request.setAttribute("mybean", v_zfwsspb39DTO);
	}
	
	/**
	 * 
	 * saveZfwsspb的中文名称：保存通用审批表
	 * 
	 * saveZfwsspb的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsspb(HttpServletRequest request,
			@Param("..") Zfwsspb39DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String tyspbid = wsgldyService.saveZfwsspb(request,dto);
			if (tyspbid != null) {
				result.put("tyspbid", tyspbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回; 
	}

	/**
	 * 
	 * zfwsspbPrintIndex的中文名称：打印通用审批表
	 * 
	 * zfwsspbPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsspb39Print")
	public void zfwsspbPrintIndex(HttpServletRequest request, @Param("..") Zfwsspb39DTO dto)
			throws Exception {
		
		Zfwsspb39DTO v_zfwsspb39DTO = (Zfwsspb39DTO)wsgldyService.queryZfwsspbObj(request, dto);
		request.setAttribute("printbean", v_zfwsspb39DTO);		
	}
	
	 /**
	  * 
	  *  ajhyjlIndex的中文名称：跳转案件合议文书页面
	  *  ajhyjlIndex的概要说明：
	  *  @param request
	  *  @param dto
	  *  @throws Exception
	  *  Written by:ly
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/18tyzfwsajhyjl")
	public void ajhyjlIndex(HttpServletRequest request, @Param("..")  Zfwsajhyjl18DTO dto)
			throws Exception{
		Zfwsajhyjl18DTO v_zfwsajhyjl18DTO = (Zfwsajhyjl18DTO)wsgldyService.ajhyjl (request, dto);
		request.setAttribute("mybean", v_zfwsajhyjl18DTO);
		
	}
	/**
	 * 
	 *  savezfws的中文名称：保存案件合议内容
	 *  ZfwsajhyjlModule的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  Written by:ly 
	 */
	@At
	@Ok("json")
	public Object savezfws (HttpServletRequest request,
			@Param("..") Zfwsajhyjl18DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String ajhyjlid = wsgldyService.saveAjhyjl(request, dto);
			if (ajhyjlid != null) {
				result.put("ajhyjlid", ajhyjlid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	 /**
	  * 
	  *  printAjhyIndex的中文名称：打印案件合议文书
	  *  ZfwsajhyjlModule的概要说明：
	  *  @param request
	  *  @param dto
	  *  @throws Exception
	  *  Written by:ly
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/18tyzfwsajhyjlPrint")
	public void  printAjhyIndex(HttpServletRequest request, @Param("..") Zfwsajhyjl18DTO  dto)
			throws Exception {
		Zfwsajhyjl18DTO  v_ZfwsajlydjbDTO=(Zfwsajhyjl18DTO )wsgldyService.ajhyjl(request, dto);
		request.setAttribute("printbean", v_ZfwsajlydjbDTO);		
	}
	/////////////////////////////行政处罚结案报告///////////////////////////
	/**
	 * 
	 *  xzcfjabgIndex的中文名称：跳转到行政处罚结案报告文书页面
	 *  xzcfjabgIndex的概要说明：
	 *  @param request
	 *  @param dto
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsxzcfjabg40")
	public void  xzcfjabgIndex(HttpServletRequest request, @Param("..")  Zfwsxzcfjabg40DTO dto)
			throws Exception{
		Zfwsxzcfjabg40DTO v_zfwsxzcfjabg40DTO=(Zfwsxzcfjabg40DTO)wsgldyService.xzcfjabg (request, dto);
		request.setAttribute("mybean", v_zfwsxzcfjabg40DTO);
		
	}
	/**
	 * 
	 *  saveXzcfjabg的中文名称：保存
	 *  saveXzcfjabg的概要说明：
	 *  @param request
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	@At
	@Ok("json")
	public Object  saveXzcfjabg (HttpServletRequest request,
			@Param("..") Zfwsxzcfjabg40DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfjabgid = wsgldyService.saveXzcfjabg(request, dto);
			if (xzcfjabgid != null) {
				result.put("xzcfjabgid", xzcfjabgid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}
	/**
	 * 
	 *  printXzcfjabgIndex的中文名称：打印
	 *  printXzcfjabgIndex的概要说明：
	 *  @param request
	 *  @param dto
	 *  @throws Exception
	 *  Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwszcfjabg40Print")
	public void  printXzcfjabgIndex(HttpServletRequest request, @Param("..") Zfwsxzcfjabg40DTO  dto)
			throws Exception {
		Zfwsxzcfjabg40DTO  v_Zfwsxzcfjabg40DTO=(Zfwsxzcfjabg40DTO )wsgldyService.xzcfjabg(request, dto);
		request.setAttribute("printbean", v_Zfwsxzcfjabg40DTO);		
	}		
		
	   /**********物品清单(第37张文书)**************Created by CatchU on 2016/3/30.****************/

    /**
     * 执法文书（物品清单）页面初始化
     * @param request
     * @param dto
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/zfwswpqd37")
    public void zfwswpqdIndex(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto)
            throws Exception {
        // 物品清单内容
        Zfwswpqd37DTO v_zfwswpqd37DTO = (Zfwswpqd37DTO)wsgldyService.queryZfwswpqdObj(request,dto);
        request.setAttribute("mybean", v_zfwswpqd37DTO);
    }

    /**
     * 保存物品清单
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwswpqd(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto) {
    	Map<String, String> result = new HashMap<String, String>();
		try {		
			String wpqdid = wsgldyService.saveZfwswpqd(request, dto);
			if (wpqdid != null) {
				result.put("wpqdid", wpqdid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }

    /**
     * 打印执法文书物品清单
     * @param request
     * @param dto
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/zfwswpqd37Print")
    public void zfwswpqdPrintIndex(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto)
            throws Exception {
        Zfwswpqd37DTO v_zfwswpqd37DTO = (Zfwswpqd37DTO)wsgldyService.queryZfwswpqdObj(request, dto);
        request.setAttribute("printbean", v_zfwswpqd37DTO);
    }

    /**
     * 查询物品清单明细
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryZfwswpqdmx(@Param("..") Zfwswpqd37DTO dto,
                                      @Param("..") PagesDTO pd) throws Exception {
        return wsgldyService.queryZfwswpqdmx(dto, pd);
    }
    
    /**********没收物品凭证 (第30张文书)**************Created by CatchU on 2016/3/30.****************/
    
    /**
	 * 首页初始化
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmswppz30")
	public void zfwsmswppzIndex(HttpServletRequest request,@Param("..")Zfwsmswppz30DTO dto) 
			throws Exception{
		Zfwsmswppz30DTO zfwsmswppz30DTO = 
				(Zfwsmswppz30DTO) wsgldyService.queryZfwsmswppzObj(request, dto);
		request.setAttribute("mybean", zfwsmswppz30DTO);
	}
	
	/**
	 * 保存执法文书没收物品凭证文书
	 */
	@At
	@Ok("json")
	public Object saveZfwsmswppz(HttpServletRequest request,
			@Param("..") Zfwsmswppz30DTO dto) throws Exception{
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String mswppzid = wsgldyService.saveZfwsmswppz(request, dto);
			if (mswppzid != null) {
				result.put("mswppzid", mswppzid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
	}
	
	/**
	 * 
	 * zfwsmswppzPrintIndex的中文名称:执法文书 没收物品凭证（打印）
	 *
	 * zfwsmswppzPrintIndex的概要说明:执法文书 没收物品凭证（打印）
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * Written by CatchU 2016年3月21日下午5:34:00
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmswppzPrint30")
	public void zfwsmswppzPrintIndex(HttpServletRequest request, @Param("..") Zfwsmswppz30DTO dto)
			throws Exception {
		Zfwsmswppz30DTO zfwsmswppz30DTO = (Zfwsmswppz30DTO) wsgldyService.queryZfwsmswppzObj(request, dto);
		request.setAttribute("printbean", zfwsmswppz30DTO);		
	}
	
	 /**********责令改正通知书 (第20张文书)**************Created by CatchU on 2016/3/20.****************/
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/20tyzfwszlgztzs")
	public void zfwszlgztzsIndex(HttpServletRequest request,
			@Param("..") Zfwszlgztzs20DTO dto) throws Exception {
		// 页面初始化
		Zfwszlgztzs20DTO v_Zfwszlgztzs20DTO=
				(Zfwszlgztzs20DTO)wsgldyService.queryZfwszlgztzsObj(request, dto);
		request.setAttribute("mybean", v_Zfwszlgztzs20DTO);
	}
	/**
	 * 保存责令改正通知书
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object saveZfwszlgztzs(HttpServletRequest request,
			@Param("..") Zfwszlgztzs20DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String zlgztzsid = wsgldyService.saveZfwszlgztzs(request, dto);
			if (zlgztzsid != null) {
				result.put("zlgztzsid", zlgztzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;

	}	
	
	/**
	 * 
	 * zfwszlgztzsPrintIndex的中文名称：执法文书：责令改正通知书 打印
	 * 
	 * 
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/20tyzfwszlgztzsPrint")
	public void zfwszlgztzsPrintIndex(HttpServletRequest request, @Param("..") Zfwszlgztzs20DTO dto)
			throws Exception {
		Zfwszlgztzs20DTO zfwszlgztzs20dto = (Zfwszlgztzs20DTO) wsgldyService.queryZfwszlgztzsObj(request, dto);
		request.setAttribute("printbean", zfwszlgztzs20dto);		
	}	
	
	/**
	 * 初始化页面
	 *ZfwsxwdcblIndex的中文名称:
	 *ZfwsxwdcblIndex的概要描述:
	 *
	 *Wirtten by : lfy
	 *update by ： zy 根据用户统筹区进入不同文书页面
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	public String ZfwsxwdcblIndex(HttpServletRequest request,
			@Param("..") Zfwsxwdcbl7DTO dto, ViewModel model) throws Exception {
		// 获取当前用户
//		Sysuser user = SysmanageUtil.getSysuser();
		// 页面初始化
		Zfwsxwdcbl7DTO v_Zfwsxwdcbl7DTO = (Zfwsxwdcbl7DTO)wsgldyService.queryZfwxwdcblObj(request, dto);
		request.setAttribute("mybean", v_Zfwsxwdcbl7DTO);
		// 若登录用户统筹区编码前四为是4117,则转向驻马店文书页面，否则转向汤阴文书页面
		return "jsp:/jsp/pub/zfba/zfbaws/7tyzfwsxwdcbl";
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsxwdcbl7";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsxwdcbl7";
//		}
	}
	/**
	 * 保存或者更新询问调查表信息
	 *savezfwsxwdcbl的中文名称:
	 *savezfwsxwdcbl的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object savezfwsxwdcbl(HttpServletRequest request,
			@Param("..") Zfwsxwdcbl7DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xwdcblid = wsgldyService.saveZfwsxwdcbl(request, dto);
			if (xwdcblid != null) {
				result.put("xwdcblid", xwdcblid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}	
	 /**
	  * 第36个文书——执法文书附页
	  * 页面初始化
	  *zfwsspypxzcfwsfyIndex的中文名称:
	  *zfwsspypxzcfwsfyIndex的概要描述:
	  *
	  *Wirtten by : lfy
	  */
	
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsspypxzcfwsfy")
	public void zfwsspypxzcfwsfyIndex (HttpServletRequest request,@Param("..") Zfwsspypxzcfwsfy36DTO dto) throws Exception {
		// 页面初始化
		Zfwsspypxzcfwsfy36DTO v_Zfwsspypxzcfwsfy36DTO=(Zfwsspypxzcfwsfy36DTO)wsgldyService.queryZfwxfylist(request, dto);
		request.setAttribute("mybean", v_Zfwsspypxzcfwsfy36DTO);
	}
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsspypxzcfwsfy_zhongmou")
	public void zfwsFyZhongmouIndex (HttpServletRequest request,@Param("..") Zfwsspypxzcfwsfy36DTO dto) throws Exception {
		// 页面初始化
		Zfwsspypxzcfwsfy36DTO v_Zfwsspypxzcfwsfy36DTO=(Zfwsspypxzcfwsfy36DTO)wsgldyService.queryZfwxfylist(request, dto);
		request.setAttribute("mybean", v_Zfwsspypxzcfwsfy36DTO);
	}
	/**
	 * 保存或者更新执法文书附页信息
	 *savezfwsfyInfo的中文名称:
	 *savezfwsfyInfo的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object savezfwsfyInfo(HttpServletRequest request,
			@Param("..") Zfwsspypxzcfwsfy36DTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsfy(request, dto));
	}	
	
	
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsspypxzcfwsfyPrint_zhongmou")
	public void zfwsspypxzcfwsfyPrintIndex (HttpServletRequest request,@Param("..") Zfwsspypxzcfwsfy36DTO dto) throws Exception {
		// 页面初始化
		Zfwsspypxzcfwsfy36DTO v_Zfwsspypxzcfwsfy36DTO=(Zfwsspypxzcfwsfy36DTO)wsgldyService.queryZfwxfylist(request, dto);
		request.setAttribute("printbean", v_Zfwsspypxzcfwsfy36DTO);
	}
	 
	 /**
	  * 
	  * zfwsxwdcblPrintIndex的中文名称：打印页面
	  * zfwsxwdcblPrintIndex的概要描述：
	  * @param request
	  * @param dto 
	  * @throws Exception
	  * written  by ： lfy
	  * update by : zy 根据用户统筹区进入不同打印页面
	  */
	@At
	@Ok("re:jsp:/jsp/error/error")
	public String zfwsxwdcblPrintIndex(HttpServletRequest request,
			@Param("..") Zfwsxwdcbl7DTO dto, ViewModel model) throws Exception {
		// 获取当前用户
//		Sysuser user = SysmanageUtil.getSysuser();
		// 页面初始化
		Zfwsxwdcbl7DTO v_Zfwsxwdcbl7DTO = (Zfwsxwdcbl7DTO)wsgldyService.queryZfwxwdcblObj(request, dto);
		request.setAttribute("printbean", v_Zfwsxwdcbl7DTO);
		// 若登录用户统筹区编码前四为是4117,则转向驻马店文书页面，否则转向汤阴文书页面
		return "jsp:/jsp/pub/zfba/zfbaws/7tyzfwsxwdcblPrint";
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwsxwdcblPrint";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwsxwdcblPrint";
//		}
		
	}
	
	/**
	 * 
	 * zfwsxzcfjdspbIndex的中文名称：行政处罚决定审批表初始化页面
	 * zfwsxzcfjdspbIndex的概要描述：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * written  by ： lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfjdspb27")
	public void zfwsxzcfjdspbIndex(HttpServletRequest request,
			@Param("..") Zfwsxzcfjdspb27DTO dto) throws Exception {
		// 页面初始化
		Zfwsxzcfjdspb27DTO v_Zfwsxzcfjdspb27DTO=
				(Zfwsxzcfjdspb27DTO)wsgldyService.queryZfwsxzcfjdspblist(request, dto);
		request.setAttribute("mybean", v_Zfwsxzcfjdspb27DTO);
	}
	/**
	 * 
	 * saveAjdj的中文名称：保存行政处罚决定审批表
	 * 
	 * saveAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfjdspb(HttpServletRequest request,
			@Param("..") Zfwsxzcfjdspb27DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfjdspbid = wsgldyService.saveZfwsxzcfjdspb(request, dto);
			if (xzcfjdspbid != null) {
				result.put("xzcfjdspbid", xzcfjdspbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}	
	 /**
	  * 
	  * zfwsxzcfjdspbPrintIndex的中文名称：打印页面
	  * zfwsxzcfjdspbPrintIndex的概要描述：
	  * @param request
	  * @param dto
	  * @throws Exception
	  * written  by ： lfy
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfjdspb27Print")
	public void zfwsxzcfjdspbPrintIndex(HttpServletRequest request,
			@Param("..") Zfwsxzcfjdspb27DTO dto) throws Exception {
		// 页面初始化
		Zfwsxzcfjdspb27DTO v_Zfwsxzcfjdspb27DTO=
				(Zfwsxzcfjdspb27DTO)wsgldyService.queryZfwsxzcfjdspblist(request, dto);
		request.setAttribute("printbean", v_Zfwsxzcfjdspb27DTO);
	}
	
	/**
	 * 初始化页面
	 *ZfwstztzsIndex的中文名称:
	 *ZfwstztzsIndex的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
//	@Ok("jsp:/jsp/pub/zfba/zfbaws/Zfwstztzs23")
	@Ok("jsp:/jsp/pub/zfba/zfbaws/tztzs23")
	public void zfwstztzsIndex(HttpServletRequest request,@Param("..") Zfwstztzs23DTO dto) throws Exception {
		// 页面初始化
		Zfwstztzs23DTO v_Zfwstztzs23DTO = (Zfwstztzs23DTO)wsgldyService.queryZfwstztzslist(request, dto);
		request.setAttribute("mybean", v_Zfwstztzs23DTO);
	}
	
	/**
	 * 添加更新听证通知书信息
	 *savezfwstztzs的中文名称:
	 *savezfwstztzs的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object savezfwstztzs(HttpServletRequest request,
			@Param("..") Zfwstztzs23DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String tztzsid = wsgldyService.saveZfwstztzs(request, dto);
			if (tztzsid != null) {
				result.put("tztzsid", tztzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}	
	/**
	 * 
	 * zfwstztzsPrintIndex的中文名称：听证通知书打印界面
	 * zfwstztzsPrintIndex的概要描述：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * written  by ： lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/tztzs23Print")
//	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwstztzs23Print")
	public void zfwstztzsPrintIndex(HttpServletRequest request,@Param("..") Zfwstztzs23DTO dto) throws Exception {
		// 页面初始化
		Zfwstztzs23DTO v_Zfwstztzs23DTO=(Zfwstztzs23DTO)wsgldyService.queryZfwstztzslist(request, dto);
		request.setAttribute("printbean", v_Zfwstztzs23DTO);
	} 
	
	/**
	 * 查询立案审批表的信息
	 *zfwslaspbIndex的中文名称:
	 *zfwslaspbIndex的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	public String zfwslaspbIndex(HttpServletRequest request,@Param("..") Zfwslaspb2DTO dto) throws Exception {
		// 页面初始化
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwslaspb2DTO v_Zfwslaspb2DTO=(Zfwslaspb2DTO)wsgldyService.queryZfwslaspblist(request, dto);
		request.setAttribute("mybean", v_Zfwslaspb2DTO);
		return "jsp:/jsp/pub/zfba/zfbaws/2tyzfwslaspb";
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwslaspb2";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwslaspb2";
//		}
	}
	/**
	 * 保存或者更新执法文书立案审批表
	 *savezfwslaspb的中文名称:
	 *savezfwslaspb的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object savezfwslaspb(HttpServletRequest request,
			@Param("..") Zfwslaspb2DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String laspid = wsgldyService.saveZfwslaspb(request,dto);
			if (laspid != null) {
				result.put("laspid", laspid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	/**
	 * 
	 * zfwslaspbPrintIndex的中文名称：立案审批打印页面
	 * zfwslaspbPrintIndex的概要描述：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * written  by ： lfy
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	//@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwslaspb2Print")
	public String  zfwslaspbPrintIndex(HttpServletRequest request,@Param("..") Zfwslaspb2DTO dto) throws Exception {
		// 页面初始化
//		Sysuser user = SysmanageUtil.getSysuser();
		Zfwslaspb2DTO v_Zfwslaspb2DTO=(Zfwslaspb2DTO)wsgldyService.queryZfwslaspblist(request, dto);
		request.setAttribute("printbean", v_Zfwslaspb2DTO);
			return "jsp:/jsp/pub/zfba/zfbaws/2tyzfwslaspbPrint";
//		if (user.getAaa027().startsWith("4117")) {
//			return "jsp:/jsp/pub/zfba/zfbaws/zmdzfwslaspb2Print";
//		} else {
//			return "jsp:/jsp/pub/zfba/zfbaws/tyzfwslaspb2Print";
//		}
	}
	
	/**
	 * 初始化页面
	 *zfwscfkyyqtzsIndex的中文名称:
	 *zfwscfkyyqtzsIndex的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/15tyzfwscfkyyqtzs")
	public void zfwscfkyyqtzsIndex(HttpServletRequest request,
			@Param("..") Zfwscfkyyqtzs15DTO dto) throws Exception {
		// 页面初始化
		Zfwscfkyyqtzs15DTO v_Zfwscfkyyqtzs15DTO=
				(Zfwscfkyyqtzs15DTO)wsgldyService.queryZfwscfkyyqtzslist(request, dto);
		request.setAttribute("mybean", v_Zfwscfkyyqtzs15DTO);
	}
	/**
	 * 保存更新通知书的信息
	 *saveZfwscfkyyqtzs的中文名称:
	 *saveZfwscfkyyqtzs的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object saveZfwscfkyyqtzs(HttpServletRequest request,
			@Param("..") Zfwscfkyyqtzs15DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String cfkyyqtzsid = wsgldyService.saveZfwscfkyyqtzs(request,dto);
			if (cfkyyqtzsid != null) {
				result.put("cfkyyqtzsid", cfkyyqtzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}	
	 
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/15tyzfwscfkyyqtzsPrint")
	public void zfwscfkyyqtzsPrintIndex(HttpServletRequest request,
			@Param("..") Zfwscfkyyqtzs15DTO dto) throws Exception {
		// 页面初始化
		Zfwscfkyyqtzs15DTO v_Zfwscfkyyqtzs15DTO=
				(Zfwscfkyyqtzs15DTO)wsgldyService.queryZfwscfkyyqtzslist(request, dto);
		request.setAttribute("printbean", v_Zfwscfkyyqtzs15DTO);
	} 
	 
	/**
	 * 
	 *ZfwscfkyjdsIndex的中文名称:初始化页面
	 *ZfwscfkyjdsIndex的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/12tyzfwscfkyjds")
	public void ZfwscfkyjdsIndex(HttpServletRequest request,@Param("..") Zfwscfkyjds12DTO dto) throws Exception {
		// 页面初始化
		Zfwscfkyjds12DTO v_Zfwscfkyjds12DTO=(Zfwscfkyjds12DTO)wsgldyService.queryZfwscfkyjdslist(request, dto);
		request.setAttribute("mybean", v_Zfwscfkyjds12DTO);
	}
	/**
	 * 保存或者更新查封（扣押）决定书的信息
	 *savezfwscfkyjds的中文名称:
	 *savezfwscfkyjds的概要描述:
	 *
	 *Wirtten by : lfy
	 */
	@At
	@Ok("json")
	public Object savezfwscfkyjds(HttpServletRequest request,
			@Param("..") Zfwscfkyjds12DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String cfkyjdsid = wsgldyService.saveZfwscfkyjds(request, dto);
			if (cfkyjdsid != null) {
				result.put("cfkyjdsid", cfkyjdsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}	
	 /**
	  * 
	  * zfwscfkyjdsPrintIndex的中文名称：查封扣押决定书打印
	  * zfwscfkyjdsPrintIndex的概要描述：
	  * @param request
	  * @param dto
	  * @throws Exception
	  * written  by ： lfy
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/12tyzfwscfkyjdsPrint")
	public void zfwscfkyjdsPrintIndex(HttpServletRequest request,@Param("..") Zfwscfkyjds12DTO dto) throws Exception {
		// 页面初始化
		Zfwscfkyjds12DTO v_Zfwscfkyjds12DTO=(Zfwscfkyjds12DTO)wsgldyService.queryZfwscfkyjdslist(request, dto);
		request.setAttribute("printbean", v_Zfwscfkyjds12DTO);
	}
	 /**
	  * 初始化页面
	  *zfwsajjttljlIndex的中文名称:
	  *zfwsajjttljlIndex的概要描述:
	  *
	  *Wirtten by : lfy
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/19tyzfwsajjttljl")
	public void zfwsajjttljlIndex(HttpServletRequest request,@Param("..") Zfwsajjttljl19DTO dto) throws Exception {
		// 页面初始化
		Zfwsajjttljl19DTO v_Zfwsajjttljl19DTO=
				(Zfwsajjttljl19DTO)wsgldyService.queryZfwsajjttljlObj(request, dto);
		request.setAttribute("mybean", v_Zfwsajjttljl19DTO);
	}
	 /**
	  * 保存更新讨论记录的信息
	  *saveZfwsajjttljl的中文名称:
	  *saveZfwsajjttljl的概要描述:
	  *
	  *Wirtten by : lfy
	  */
	@At
	@Ok("json")
	public Object saveZfwsajjttljl(HttpServletRequest request,
			@Param("..") Zfwsajjttljl19DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String ajjttljlid = wsgldyService.saveZfwsajjttljl(request, dto);
			if (ajjttljlid != null) {
				result.put("ajjttljlid", ajjttljlid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}	
	/**
	 * 
	 * zfwscfkyjdsPrintIndex的中文名称：案件讨论记录打印页面
	 * zfwscfkyjdsPrintIndex的概要描述：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * written  by ： lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/19tyzfwsajjttljlPrint")
	public void zfwsajjttljlPrintIndex(HttpServletRequest request,@Param("..") Zfwsajjttljl19DTO dto) throws Exception {
		// 页面初始化
		Zfwsajjttljl19DTO v_Zfwsajjttljl19DTO=
				(Zfwsajjttljl19DTO)wsgldyService.queryZfwsajjttljlObj(request, dto);
		request.setAttribute("printbean", v_Zfwsajjttljl19DTO);
	}
	 
	
	/**
	  * 初始化页面
	  *zfwsxwdctzsIndex的中文名称:询问调查通知书
	  *zfwsxwdctzsIndex的概要描述:
	  *
	  *Wirtten by : ly
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/44zfwsxwdctzs")
	public void zfwsxwdctzsIndex(HttpServletRequest request,@Param("..") ZfwsxwdctzsDTO dto) throws Exception {
		// 页面初始化
		ZfwsxwdctzsDTO v_ZfwsxwdctzsDTO=
				(ZfwsxwdctzsDTO)wsgldyService.queryZfwsxwdctzsObj(request, dto);
		request.setAttribute("mybean", v_ZfwsxwdctzsDTO);
	}
	
	 /**
	  * 保存更新讨论记录的信息
	  *savexwdctzs的中文名称:保存询问调查通知书
	  *savexwdctzs的概要描述:
	  *
	  *Wirtten by : ly
	  */
	@At
	@Ok("json")
	public Object savexwdctzs(HttpServletRequest request,
			@Param("..") ZfwsxwdctzsDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xwdctzsid = wsgldyService.saveXwdctzs(request, dto);
			if (xwdctzsid != null) {
				result.put("xwdctzsid", xwdctzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
	}	
	/**
	 * 
	 * zfwsxwdctzsPrintIndex的中文名称：案件讨论记录打印页面
	 * zfwsxwdctzsPrintIndex的概要描述：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * written  by ： ly
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/44zfwsxwdctzsPrint")
	public void zfwsxwdctzsPrintIndex(HttpServletRequest request,@Param("..") ZfwsxwdctzsDTO dto) throws Exception {
		// 页面初始化
		ZfwsxwdctzsDTO v_ZfwsxwdctzsDTO=
				(ZfwsxwdctzsDTO)wsgldyService.queryZfwsxwdctzsObj(request, dto);
		request.setAttribute("printbean", v_ZfwsxwdctzsDTO);
	}
	
	/**
	 * 
	 * zfwsxzcfsxtzgzspbIndex的中文名称：行政处罚事先（听证）告知审批表
	 * 
	 * zfwsxzcfsxtzgzspbIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto 
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfsxtzgzspb41")
	public void zfwsxzcfsxtzgzspbIndex(HttpServletRequest request, @Param("..") Zfwsxzcfsxtzgzspb41DTO dto)
			throws Exception {
		// 行政处罚事先（听证）告知审批表内容
		Zfwsxzcfsxtzgzspb41DTO v_dto = (Zfwsxzcfsxtzgzspb41DTO)wsgldyService.queryZfwssxgzspbObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsxzcfsxtzgzspb的中文名称：保存行政处罚事先（听证）告知审批表
	 * 
	 * saveZfwsxzcfsxtzgzspb的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfsxtzgzspb(HttpServletRequest request,
			@Param("..") Zfwsxzcfsxtzgzspb41DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String sxtzgzspbid = wsgldyService.saveZfwsxzcfsxtzgzspb(request,dto);
			if (sxtzgzspbid != null) {
				result.put("sxtzgzspbid", sxtzgzspbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwsxzcfsxtzgzspbPrintIndex的中文名称：打印行政处罚事先（听证）告知审批表
	 * 
	 * zfwsxzcfsxtzgzspbPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfsxtzgzspb41Print")
	public void zfwsxzcfsxtzgzspbPrintIndex(HttpServletRequest request, @Param("..") Zfwsxzcfsxtzgzspb41DTO dto)
			throws Exception {
		
		Zfwsxzcfsxtzgzspb41DTO v_dto = (Zfwsxzcfsxtzgzspb41DTO)wsgldyService.queryZfwssxgzspbObj(request, dto);
		request.setAttribute("printbean", v_dto);		
	}
	
	/**
	 * 
	 * zfwszdgxtzsIndex的中文名称：指定管辖通知书
	 * 
	 * zfwszdgxtzsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto 
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zdgxtzs43")
	public void zfwszdgxtzsIndex(HttpServletRequest request, @Param("..") Zfwszdgxtzs43DTO dto)
			throws Exception {
		// 指定管辖通知书
		Zfwszdgxtzs43DTO v_dto = (Zfwszdgxtzs43DTO)wsgldyService.queryZfwszdgxtzsObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwszdgxtzs的中文名称：保存指定管辖通知书
	 * 
	 * saveZfwszdgxtzs的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwszdgxtzs(HttpServletRequest request,
			@Param("..") Zfwszdgxtzs43DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String zdgxtzsid = wsgldyService.saveZfwszdgxtzs(request,dto);
			if (zdgxtzsid != null) {
				result.put("zdgxtzsid", zdgxtzsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwszdgxtzsPrintIndex的中文名称：打印指定管辖通知书
	 * 
	 * zfwszdgxtzsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zdgxtzs43Print")
	public void zfwszdgxtzsPrintIndex(HttpServletRequest request, @Param("..") Zfwszdgxtzs43DTO dto)
			throws Exception {
		
		Zfwszdgxtzs43DTO v_dto = (Zfwszdgxtzs43DTO)wsgldyService.queryZfwszdgxtzsObj(request, dto);
		request.setAttribute("printbean", v_dto);		
	}
	
	/**
	 * 
	 * zfwsxzcfwtsIndex的中文名称：行政处罚委托书
	 * 
	 * zfwsxzcfwtsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto 
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfwts42")
	public void zfwsxzcfwtsIndex(HttpServletRequest request, @Param("..") Zfwsxzcfwts42DTO dto)
			throws Exception {
		// 行政处罚委托书
		Zfwsxzcfwts42DTO v_dto = (Zfwsxzcfwts42DTO)wsgldyService.queryZfwsxzcfwtsObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsxzcfwts的中文名称：保存行政处罚委托书
	 * 
	 * saveZfwsxzcfwts的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsxzcfwts(HttpServletRequest request,
			@Param("..") Zfwsxzcfwts42DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String xzcfwtsid = wsgldyService.saveZfwsxzcfwts(request,dto);
			if (xzcfwtsid != null) {
				result.put("xzcfwtsid", xzcfwtsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwsxzcfwtsPrintIndex的中文名称：打印行政处罚委托书
	 * 
	 * zfwsxzcfwtsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto 
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/xzcfwts42Print")
	public void zfwsxzcfwtsPrintIndex(HttpServletRequest request, @Param("..") Zfwsxzcfwts42DTO dto)
			throws Exception {
		
		Zfwsxzcfwts42DTO v_dto = (Zfwsxzcfwts42DTO)wsgldyService.queryZfwsxzcfwtsObj(request, dto);
		request.setAttribute("printbean", v_dto);		
	}
	
	/**
	 * 
	 * zfwsfzjgshyjsIndex的中文名称：法制机构审核意见书
	 * 
	 * zfwsfzjgshyjsIndex的概要说明：查询文书内容
	 * @param request
	 * @param dto 
	 * @throws Exception
	 *        Written by : zy TODO
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/fzjgshyjs47")
	public void zfwsfzjgshyjsIndex(HttpServletRequest request, @Param("..") Zfwsfzjgshyjs47DTO dto)
			throws Exception {
		// 法制机构审核意见书
		Zfwsfzjgshyjs47DTO v_dto = (Zfwsfzjgshyjs47DTO)wsgldyService.queryZfwsfzjgshyjsObj(request, dto);
		request.setAttribute("mybean", v_dto);
	}
	
	/**
	 * 
	 * saveZfwsfzjgshyjs的中文名称：保存法制机构审核意见书
	 * 
	 * saveZfwsfzjgshyjs的概要说明：对添加或修改内容进行保存
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveZfwsfzjgshyjs(HttpServletRequest request,
			@Param("..") Zfwsfzjgshyjs47DTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String fzjgshyjsid = wsgldyService.saveZfwsfzjgshyjs(request,dto);
			if (fzjgshyjsid != null) {
				result.put("fzjgshyjsid", fzjgshyjsid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * zfwszdgxtzsPrintIndex的中文名称：打印法制机构审核意见书
	 * 
	 * zfwszdgxtzsPrintIndex的概要说明：跳转到打印页面
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/fzjgshyjs47Print")
	public void zfwsfzjgshyjsPrintIndex(HttpServletRequest request, @Param("..") Zfwsfzjgshyjs47DTO dto)
			throws Exception {
		
		Zfwsfzjgshyjs47DTO v_dto = (Zfwsfzjgshyjs47DTO)wsgldyService.queryZfwsfzjgshyjsObj(request, dto);
		request.setAttribute("printbean", v_dto);		
	}
	
	/**
	  * 初始化页面
	  *zfwsjbdjbIndex的中文名称:举报登记表 
	  *
	  *Wirtten by : ly
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/45zfwsjbdjb")
	public void zfwsjbdjbIndex(HttpServletRequest request,@Param("..") zfwsjbdjb45DTO dto) throws Exception {
		// 页面初始化  
		zfwsjbdjb45DTO v_zfwsjbdjb45DTO=(zfwsjbdjb45DTO)wsgldyService.queryzfwsjbdjb45Obj(request, dto);
		request.setAttribute("mybean", v_zfwsjbdjb45DTO);
	}
	/**
	 * zfwsjbdjb45PrintIndex：举报登记表打印页
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/45zfwsjbdjbPrint")
	public void zfwsjbdjb45PrintIndex(HttpServletRequest request,@Param("..") zfwsjbdjb45DTO dto) throws Exception {
		// 页面初始化  
		zfwsjbdjb45DTO v_zfwsjbdjb45DTO=(zfwsjbdjb45DTO)wsgldyService.queryzfwsjbdjb45Obj(request, dto);
		request.setAttribute("printbean", v_zfwsjbdjb45DTO);
	}
	/**
	 * savejbdjb45 : 保存举报登记表
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object savejbdjb45(HttpServletRequest request,@Param("..") zfwsjbdjb45DTO dto){
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String jbdjbid = wsgldyService.savejbdjb45(request,dto);
			if (jbdjbid != null) {
				result.put("jbdjbid", jbdjbid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null); 
	}
	/**
	  * 初始化页面
	  *Zfwsjcdwjclj46Index的中文名称:稽查队文件处理笺（jian）
	  *
	  *Wirtten by : ly
	  */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/46zfwsjcdwjclj")
	public void Zfwsjcdwjclj46Index(HttpServletRequest request,@Param("..") Zfwsjcdwjclj46DTO dto) throws Exception {
		// 页面初始化  
		Zfwsjcdwjclj46DTO v_Zfwsjcdwjclj46DTO=(Zfwsjcdwjclj46DTO)wsgldyService.queryZfwsjcdwjclj46Obj(request, dto);
		request.setAttribute("mybean", v_Zfwsjcdwjclj46DTO);
	}
	
	/**
	 * savejcdwjcl46 : 保存稽查队文件处理笺（jian）
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object savejcdwjcl46(HttpServletRequest request,@Param("..") Zfwsjcdwjclj46DTO dto){
		Map<String, String> result = new HashMap<String, String>();
		try {		
			String jcdwjclid = wsgldyService.savejcdwjcl46(request,dto);
			if (jcdwjclid != null) {
				result.put("jcdwjclid", jcdwjclid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		
		return SysmanageUtil.execAjaxResult(result, null); 
	}
	/**
	 * zfwsjbdjb46PrintIndex：举报稽查队文件处理笺（jian）
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/46zfwsjcdwjcljPrint")
	public void zfwsjbdjb46PrintIndex(HttpServletRequest request,@Param("..") Zfwsjcdwjclj46DTO dto) throws Exception {
		// 页面初始化  
		Zfwsjcdwjclj46DTO v_Zfwsjcdwjc=(Zfwsjcdwjclj46DTO)wsgldyService.queryZfwsjcdwjclj46Obj(request, dto);
		request.setAttribute("printbean", v_Zfwsjcdwjc);
	}
	/**
	 * 
	 * zfwsmobanIndex的中文名称：执法办案文书另存为模板
	 * zfwsmobanIndex的概要描述：执法办案文书另存为模板
	 * @param request
	 * written  by ： gjf
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmoban")
	public void zfwsmobanIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * saveZfwsmoban的中文名称：执法文书保存为模板
	 * 
	 * saveZfwsmoban的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveZfwsmoban(HttpServletRequest request,
			@Param("..") ZfajzfwsmbDTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.saveZfwsmoban(request,
				dto));
	}
	
	/**
	 * 
	 * zfwsmobantqIndex的中文名称：执法办案文书从模板中提取
	 * zfwsmobantqIndex的概要描述：执法办案文书从模板中提取
	 * @param request
	 * written  by ： gjf
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsmobantq")
	public void zfwsmobantqIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 *  
	 * queryAjwslist的中文名称：查询执法文书模板列表
	 * 
	 * queryAjwslist的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryZfwsmobanlist(@Param("..") ZfajzfwsmbDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return SysmanageUtil.execAjaxResult(wsgldyService.queryZfwsmobanlist(dto, pd),null);
	}
	/**
	 * 
	 * queryZfwsmobanmclist的中文名称：查询同一地区的模板名称
	 * queryZfwsmobanmclist的概要说明：
	 * Written  by : lfy
	 */
	@At
	@Ok("json")
	public Object queryZfwsmobanmclist(@Param("..") ZfajzfwsmbDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return wsgldyService.queryZfwsmobanmclist(dto, pd);
		 
	}
	
	/**
	 * 
	 * queryAjwslist的中文名称：查询执法文书模板列表
	 * 
	 * queryAjwslist的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryZfwsmobanObj(HttpServletRequest request,@Param("..") ZfajzfwsmbDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {		
			 
			String v_sql = "select a.* from Zfajzfwsmb a where a.zfwsmbid='"+dto.getZfwsmbid()+"'";
			List<Zfajzfwsmb> v_ls = (List<Zfajzfwsmb>) DbUtils.getDataList(v_sql, Zfajzfwsmb.class);			
			Zfajzfwsmb v_Zfajzfwsmb=null;
			if (v_ls!=null && v_ls.size()>0){
				v_Zfajzfwsmb=v_ls.get(0);
			}else{
				throw new BusinessException("根据"+dto.getZfwsmbid()+"没获取模板数据！");				
			}
			String v_zfwsdmz=v_Zfajzfwsmb.getZfwsdmz();
			String v_ajdjid=v_Zfajzfwsmb.getAjdjid();
			
			if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS01")){//1案件来源登记表
				ZfwsajlydjbDTO v_ZfwsajlydjbDTO=new ZfwsajlydjbDTO();
				v_ZfwsajlydjbDTO.setAjdjid(v_ajdjid);
			    v_ZfwsajlydjbDTO=(ZfwsajlydjbDTO)wsgldyService.queryZfwsajlydjbObj(request, v_ZfwsajlydjbDTO);
			    v_ZfwsajlydjbDTO=(ZfwsajlydjbDTO)SysmanageUtil.ggzfwsmbzFromsz(v_ZfwsajlydjbDTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_ZfwsajlydjbDTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS30")){//30没收物品凭证
				Zfwsmswppz30DTO v_Zfwsmswppz30DTO=new Zfwsmswppz30DTO();
				v_Zfwsmswppz30DTO.setAjdjid(v_ajdjid);
				v_Zfwsmswppz30DTO=(Zfwsmswppz30DTO)wsgldyService.queryZfwsmswppzObj(request, v_Zfwsmswppz30DTO);
				v_Zfwsmswppz30DTO=(Zfwsmswppz30DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsmswppz30DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsmswppz30DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS20")){//20责令改正通知书
				Zfwszlgztzs20DTO v_Zfwszlgztzs20DTO=new Zfwszlgztzs20DTO();
				v_Zfwszlgztzs20DTO.setAjdjid(v_ajdjid);
				v_Zfwszlgztzs20DTO=(Zfwszlgztzs20DTO)wsgldyService.queryZfwszlgztzsObj(request, v_Zfwszlgztzs20DTO);
				v_Zfwszlgztzs20DTO=(Zfwszlgztzs20DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwszlgztzs20DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwszlgztzs20DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if(v_zfwsdmz.startsWith("ZFAJZFWS37")){//37物品清单
				Zfwswpqd37DTO v_Zfwswpqd37DTO=new Zfwswpqd37DTO();
				v_Zfwswpqd37DTO.setAjdjid(v_ajdjid);
				v_Zfwswpqd37DTO.setZfwsdmz(v_zfwsdmz);
				v_Zfwswpqd37DTO=(Zfwswpqd37DTO)wsgldyService.queryZfwswpqdObj(request, v_Zfwswpqd37DTO);
				v_Zfwswpqd37DTO=(Zfwswpqd37DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwswpqd37DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwswpqd37DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS18")){//18案件合议记录
				Zfwsajhyjl18DTO v_Zfwsajhyjl18DTO=new Zfwsajhyjl18DTO();
				v_Zfwsajhyjl18DTO.setAjdjid(v_ajdjid );
				v_Zfwsajhyjl18DTO=(Zfwsajhyjl18DTO)wsgldyService.ajhyjl(request, v_Zfwsajhyjl18DTO);
				v_Zfwsajhyjl18DTO=(Zfwsajhyjl18DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsajhyjl18DTO);
				// v_ZfwsajlydjbDTO.setAjdjclyj(null);
				String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsajhyjl18DTO, "yyyy-MM-dd HH:mm:ss");
				//JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
				map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS40")){//40行政处罚结案报告
				Zfwsxzcfjabg40DTO v_Zfwsxzcfjabg40DTO=new Zfwsxzcfjabg40DTO();
				v_Zfwsxzcfjabg40DTO.setAjdjid(v_ajdjid);
				v_Zfwsxzcfjabg40DTO=(Zfwsxzcfjabg40DTO)wsgldyService.xzcfjabg(request, v_Zfwsxzcfjabg40DTO);
				v_Zfwsxzcfjabg40DTO=(Zfwsxzcfjabg40DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxzcfjabg40DTO);
				// v_ZfwsajlydjbDTO.setAjdjclyj(null);
				String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxzcfjabg40DTO, "yyyy-MM-dd HH:mm:ss");
				//JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
				map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS02")){//2.立案审批表
				Zfwslaspb2DTO v_Zfwslaspb2DTO=new Zfwslaspb2DTO();
				v_Zfwslaspb2DTO.setAjdjid(v_ajdjid);
			    v_Zfwslaspb2DTO=(Zfwslaspb2DTO)wsgldyService.queryZfwslaspblist(request, v_Zfwslaspb2DTO);
			    v_Zfwslaspb2DTO=(Zfwslaspb2DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwslaspb2DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwslaspb2DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS07")){//7.询问调查表
				Zfwsxwdcbl7DTO v_Zfwsxwdcbl7DTO=new Zfwsxwdcbl7DTO();
				v_Zfwsxwdcbl7DTO.setAjdjid(v_ajdjid);
				v_Zfwsxwdcbl7DTO.setXwdcblid(request.getParameter("xwdcblid")); // 询问调查笔录id
			    v_Zfwsxwdcbl7DTO=(Zfwsxwdcbl7DTO)wsgldyService.queryZfwxwdcblObj(request, v_Zfwsxwdcbl7DTO);
			    v_Zfwsxwdcbl7DTO=(Zfwsxwdcbl7DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxwdcbl7DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxwdcbl7DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS12")){//12.查封扣押决定书
				Zfwscfkyjds12DTO v_Zfwscfkyjds12DTO=new Zfwscfkyjds12DTO();
				v_Zfwscfkyjds12DTO.setAjdjid(v_ajdjid);
			    v_Zfwscfkyjds12DTO=(Zfwscfkyjds12DTO)wsgldyService.queryZfwscfkyjdslist(request, v_Zfwscfkyjds12DTO);
			    v_Zfwscfkyjds12DTO=(Zfwscfkyjds12DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwscfkyjds12DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwscfkyjds12DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS15")){//12.查封扣押延期决定书
				Zfwscfkyyqtzs15DTO v_Zfwscfkyyqtzs15DTO=new Zfwscfkyyqtzs15DTO();
				v_Zfwscfkyyqtzs15DTO.setAjdjid(v_ajdjid);
			    v_Zfwscfkyyqtzs15DTO=(Zfwscfkyyqtzs15DTO)wsgldyService.queryZfwscfkyyqtzslist(request, v_Zfwscfkyyqtzs15DTO);
			    v_Zfwscfkyyqtzs15DTO=(Zfwscfkyyqtzs15DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwscfkyyqtzs15DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwscfkyyqtzs15DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS19")){//19.案件讨论记录
				Zfwsajjttljl19DTO v_Zfwsajjttljl19DTO=new Zfwsajjttljl19DTO();
				v_Zfwsajjttljl19DTO.setAjdjid(v_ajdjid);
			    v_Zfwsajjttljl19DTO=(Zfwsajjttljl19DTO)wsgldyService.queryZfwsajjttljlObj(request, v_Zfwsajjttljl19DTO);
			    v_Zfwsajjttljl19DTO=(Zfwsajjttljl19DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsajjttljl19DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsajjttljl19DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS23")){//23.听证通知书
				Zfwstztzs23DTO v_Zfwstztzs23DTO=new Zfwstztzs23DTO();
				v_Zfwstztzs23DTO.setAjdjid(v_ajdjid);
			    v_Zfwstztzs23DTO=(Zfwstztzs23DTO)wsgldyService.queryZfwstztzslist(request, v_Zfwstztzs23DTO);
			    v_Zfwstztzs23DTO=(Zfwstztzs23DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwstztzs23DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwstztzs23DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS27")){//27.行政处罚决定审批表
				Zfwsxzcfjdspb27DTO v_Zfwsxzcfjdspb27DTO=new Zfwsxzcfjdspb27DTO();
				v_Zfwsxzcfjdspb27DTO.setAjdjid(v_ajdjid);
			    v_Zfwsxzcfjdspb27DTO=(Zfwsxzcfjdspb27DTO)wsgldyService.queryZfwsxzcfjdspblist(request, v_Zfwsxzcfjdspb27DTO);
			    v_Zfwsxzcfjdspb27DTO=(Zfwsxzcfjdspb27DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxzcfjdspb27DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxzcfjdspb27DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS36")){//36.附页
				Zfwsspypxzcfwsfy36DTO v_Zfwsspypxzcfwsfy36DTO=new Zfwsspypxzcfwsfy36DTO();
				v_Zfwsspypxzcfwsfy36DTO.setAjdjid(v_ajdjid);
				v_Zfwsspypxzcfwsfy36DTO=(Zfwsspypxzcfwsfy36DTO)wsgldyService.queryZfwxfylist(request, v_Zfwsspypxzcfwsfy36DTO);
				v_Zfwsspypxzcfwsfy36DTO=(Zfwsspypxzcfwsfy36DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsspypxzcfwsfy36DTO);
			   // v_ZfwsajlydjbDTO.setAjdjclyj(null);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsspypxzcfwsfy36DTO, "yyyy-MM-dd HH:mm:ss");
			    //JSONObject v_jsonObject=JSONObject.fromObject(v_ZfwsajlydjbDTO);
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS03")){//3.案件移送书
				Zfwsajyss3DTO v_Zfwsajyss3DTO = new Zfwsajyss3DTO();
				v_Zfwsajyss3DTO.setAjdjid(v_ajdjid);
				v_Zfwsajyss3DTO = (Zfwsajyss3DTO)wsgldyService.queryZfwsajyssObj(request, v_Zfwsajyss3DTO);
				v_Zfwsajyss3DTO = (Zfwsajyss3DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsajyss3DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsajyss3DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS06")){//6.查封扣押物品移交通知书
				Zfwscfkywpyjtzs6DTO v_Zfwscfkywpyjtzs6DTO = new Zfwscfkywpyjtzs6DTO();
				v_Zfwscfkywpyjtzs6DTO.setAjdjid(v_ajdjid);
				v_Zfwscfkywpyjtzs6DTO = (Zfwscfkywpyjtzs6DTO)wsgldyService.queryZfwscfkywpyjtzsObj(request, v_Zfwscfkywpyjtzs6DTO);
				v_Zfwscfkywpyjtzs6DTO = (Zfwscfkywpyjtzs6DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwscfkywpyjtzs6DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwscfkywpyjtzs6DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS08")){//8.现场检查笔录
				Zfwsxcjcbl8DTO v_Zfwsxcjcbl8DTO = new Zfwsxcjcbl8DTO();
				v_Zfwsxcjcbl8DTO.setAjdjid(v_ajdjid);
				v_Zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO)wsgldyService.queryZfwsxcjcblObj(request, v_Zfwsxcjcbl8DTO);
				v_Zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxcjcbl8DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxcjcbl8DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS14")){//14.检验告知书
				Zfwsjyjcjyjdgzs14DTO v_Zfwsjyjcjyjdgzs14DTO = new Zfwsjyjcjyjdgzs14DTO();
				v_Zfwsjyjcjyjdgzs14DTO.setAjdjid(v_ajdjid);
				v_Zfwsjyjcjyjdgzs14DTO = (Zfwsjyjcjyjdgzs14DTO)wsgldyService.queryZfwsjygzsObj(request, v_Zfwsjyjcjyjdgzs14DTO);
				v_Zfwsjyjcjyjdgzs14DTO = (Zfwsjyjcjyjdgzs14DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsjyjcjyjdgzs14DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsjyjcjyjdgzs14DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS16")){//16.先行处理物品通知书
				Zfwsxxclwptzs16DTO v_Zfwsxxclwptzs16DTO = new Zfwsxxclwptzs16DTO();
				v_Zfwsxxclwptzs16DTO.setAjdjid(v_ajdjid);
				v_Zfwsxxclwptzs16DTO = (Zfwsxxclwptzs16DTO)wsgldyService.queryZfwsxxclwptzsObj(request, v_Zfwsxxclwptzs16DTO);
				v_Zfwsxxclwptzs16DTO = (Zfwsxxclwptzs16DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxxclwptzs16DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxxclwptzs16DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS21")){//21.撤案审批表
				Zfwscaspb21DTO v_Zfwscaspb21DTO = new Zfwscaspb21DTO();
				v_Zfwscaspb21DTO.setAjdjid(v_ajdjid);
				v_Zfwscaspb21DTO = (Zfwscaspb21DTO)wsgldyService.queryZfwscaspbObj(request, v_Zfwscaspb21DTO);
				v_Zfwscaspb21DTO = (Zfwscaspb21DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwscaspb21DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwscaspb21DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS24")){//24.听证笔录
				Zfwstzbl24DTO v_Zfwstzbl24DTO = new Zfwstzbl24DTO();
				v_Zfwstzbl24DTO.setAjdjid(v_ajdjid);
				v_Zfwstzbl24DTO = (Zfwstzbl24DTO)wsgldyService.queryZfwstzblObj(request, v_Zfwstzbl24DTO);
				v_Zfwstzbl24DTO = (Zfwstzbl24DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwstzbl24DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwstzbl24DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS28")){//28.行政处罚决定书
				Zfwsxzcfjds28DTO v_Zfwsxzcfjds28DTO = new Zfwsxzcfjds28DTO();
				v_Zfwsxzcfjds28DTO.setAjdjid(v_ajdjid);
				v_Zfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO)wsgldyService.queryZfwsxzcfjdsObj(request, v_Zfwsxzcfjds28DTO);
				v_Zfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxzcfjds28DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxzcfjds28DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS31")){//31.没收物品处理清单
				Zfwsmswpclqd31DTO v_Zfwsmswpclqd31DTO = new Zfwsmswpclqd31DTO();
				v_Zfwsmswpclqd31DTO.setAjdjid(v_ajdjid);
				v_Zfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO)wsgldyService.queryZfwsmswpclqdObj(request, v_Zfwsmswpclqd31DTO);
				v_Zfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsmswpclqd31DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsmswpclqd31DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS33")){//33.行政处罚强制执行申请书
				Zfwsxzcfqzzxsqs33DTO v_Zfwsxzcfqzzxsqs33DTO = new Zfwsxzcfqzzxsqs33DTO();
				v_Zfwsxzcfqzzxsqs33DTO.setAjdjid(v_ajdjid);
				v_Zfwsxzcfqzzxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO)wsgldyService.queryZfwsxzcfqzzxsqsObj(request, v_Zfwsxzcfqzzxsqs33DTO);
				v_Zfwsxzcfqzzxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsxzcfqzzxsqs33DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsxzcfqzzxsqs33DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS35")){//35.陈述申辩复核意见书
				Zfwscssbfhyjs35DTO v_Zfwscssbfhyjs35DTO = new Zfwscssbfhyjs35DTO();
				v_Zfwscssbfhyjs35DTO.setAjdjid(v_ajdjid);
				v_Zfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO)wsgldyService.queryZfwscssbfhyjsObj(request, v_Zfwscssbfhyjs35DTO);
				v_Zfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwscssbfhyjs35DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwscssbfhyjs35DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			} else if (v_zfwsdmz.startsWith("ZFAJZFWS39")){//39.通用审批表
				Zfwsspb39DTO v_Zfwsspb39DTO = new Zfwsspb39DTO();
				v_Zfwsspb39DTO.setAjdjid(v_ajdjid);
				v_Zfwsspb39DTO.setZfwsdmz(v_zfwsdmz);
				v_Zfwsspb39DTO = (Zfwsspb39DTO)wsgldyService.queryZfwsspbObj(request, v_Zfwsspb39DTO);
				v_Zfwsspb39DTO = (Zfwsspb39DTO)SysmanageUtil.ggzfwsmbzFromsz(v_Zfwsspb39DTO);
			    String myretjson = JSON.toJSONStringWithDateFormat(v_Zfwsspb39DTO, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS04")){
				Zfwssxfzajysspb4DTO zfws4 = new Zfwssxfzajysspb4DTO();
				zfws4.setAjdjid(v_ajdjid);
				zfws4 = (Zfwssxfzajysspb4DTO)wsgldyService.queryZfwssxfzlaysspbObj(request, zfws4);
				zfws4 = (Zfwssxfzajysspb4DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws4);
			    String myretjson = JSON.toJSONStringWithDateFormat(zfws4, "yyyy-MM-dd HH:mm:ss");
			    map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS05")){
				Zfwssxfzajyss5DTO zfws5 = new Zfwssxfzajyss5DTO();
				zfws5.setAjdjid(v_ajdjid);
				zfws5 = (Zfwssxfzajyss5DTO)wsgldyService.queryZfwssxfzajyssObj(request, zfws5);
				zfws5 = (Zfwssxfzajyss5DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws5);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws5, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if (v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS09")) {
				Zfwsajdczjbg9DTO zfws9 = new Zfwsajdczjbg9DTO();
				zfws9.setAjdjid(v_ajdjid);
				zfws9 = (Zfwsajdczjbg9DTO)wsgldyService.queryZfwsajdczjbg9Obj(request, zfws9);
				zfws9 = (Zfwsajdczjbg9DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws9);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws9, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS10")){
				Zfwsxxdjbcwptzs10DTO zfws10 = new Zfwsxxdjbcwptzs10DTO();
				zfws10.setAjdjid(v_ajdjid);
				zfws10 = (Zfwsxxdjbcwptzs10DTO)wsgldyService.queryZfwsxxdjbcwptzs10Obj(request, zfws10);
				zfws10 = (Zfwsxxdjbcwptzs10DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws10);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws10, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS11")){
				Zfwsxxdjbcwpcljds11DTO zfws11 = new Zfwsxxdjbcwpcljds11DTO();
				zfws11.setAjdjid(v_ajdjid);
				zfws11 = (Zfwsxxdjbcwpcljds11DTO)wsgldyService.queryZfwsxxdjbcwpcljds11Obj(request, zfws11);
				zfws11 = (Zfwsxxdjbcwpcljds11DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws11);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws11, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS17")){
				Zfwsjccfkyjds17DTO zfws17 = new Zfwsjccfkyjds17DTO();
				zfws17.setAjdjid(v_ajdjid);
				zfws17 = (Zfwsjccfkyjds17DTO)wsgldyService.queryZfwsjccfkyjds17bj(request, zfws17);
				zfws17 = (Zfwsjccfkyjds17DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws17);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws17, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS22")){
				Zfwstzgzs22DTO zfws22 = new Zfwstzgzs22DTO();
				zfws22.setAjdjid(v_ajdjid);
				zfws22 = (Zfwstzgzs22DTO)wsgldyService.queryZfwstzgzs22Obj(request, zfws22);
				zfws22 = (Zfwstzgzs22DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws22);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws22, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS25")){
				Zfwstzyjs25DTO zfws25 = new Zfwstzyjs25DTO();
				zfws25.setAjdjid(v_ajdjid);
				zfws25 = (Zfwstzyjs25DTO)wsgldyService.queryZfwstzyjs25Obj(request, zfws25);
				zfws25 = (Zfwstzyjs25DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws25);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws25, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS26")){
				Zfwsxzcfsxgzs26DTO zfws26 = new Zfwsxzcfsxgzs26DTO();
				zfws26.setAjdjid(v_ajdjid);
				zfws26 = (Zfwsxzcfsxgzs26DTO)wsgldyService.queryZfwsxzcfsxgzs26Obj(request, zfws26);
				zfws26 = (Zfwsxzcfsxgzs26DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws26);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws26, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS29")){
				Zfwsdcxzcfjds29DTO zfws29 = new Zfwsdcxzcfjds29DTO();
				zfws29.setAjdjid(v_ajdjid);
				zfws29 = (Zfwsdcxzcfjds29DTO)wsgldyService.queryZfwsdcxzcfjds29Obj(request, zfws29);
				zfws29 = (Zfwsdcxzcfjds29DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws29);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws29, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS32")){
				Zfwslxxzcfjdcgs32DTO zfws32 = new Zfwslxxzcfjdcgs32DTO();
				zfws32.setAjdjid(v_ajdjid);
				zfws32 = (Zfwslxxzcfjdcgs32DTO)wsgldyService.queryZfwslxxzcfjdcgs32Obj(request, zfws32);
				zfws32 = (Zfwslxxzcfjdcgs32DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws32);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws32, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS34")){
				Zfwscssbbl34DTO zfws34 = new Zfwscssbbl34DTO();
				zfws34.setAjdjid(v_ajdjid);
				zfws34 = (Zfwscssbbl34DTO)wsgldyService.queryZfwscssbbl34Obj(request, zfws34);
				zfws34 = (Zfwscssbbl34DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws34);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws34, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS38")){
				Zfwsdshz38DTO zfws38 = new Zfwsdshz38DTO();
				zfws38.setAjdjid(v_ajdjid);
				zfws38 = (Zfwsdshz38DTO)wsgldyService.queryZfwsdshz38(request, zfws38);
				zfws38 = (Zfwsdshz38DTO)SysmanageUtil.ggzfwsmbzFromsz(zfws38);
				String myretjson = JSON.toJSONStringWithDateFormat(zfws38, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS44")){
				ZfwsxwdctzsDTO zfwstzs = new ZfwsxwdctzsDTO();
				zfwstzs.setAjdjid(v_ajdjid);
				zfwstzs = (ZfwsxwdctzsDTO)wsgldyService.queryZfwsxwdctzsObj(request, zfwstzs);
				zfwstzs = (ZfwsxwdctzsDTO)SysmanageUtil.ggzfwsmbzFromsz(zfwstzs);
				String myretjson = JSON.toJSONStringWithDateFormat(zfwstzs, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS45")){
				zfwsjbdjb45DTO jbdj = new zfwsjbdjb45DTO();
				jbdj.setAjdjid(v_ajdjid);
				jbdj = (zfwsjbdjb45DTO)wsgldyService.queryzfwsjbdjb45Obj(request, jbdj);
				jbdj = (zfwsjbdjb45DTO)SysmanageUtil.ggzfwsmbzFromsz(jbdj);
				String myretjson = JSON.toJSONStringWithDateFormat(jbdj, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS41")){
				Zfwsxzcfsxtzgzspb41DTO v_dto = new Zfwsxzcfsxtzgzspb41DTO();
				v_dto.setAjdjid(v_ajdjid);
				v_dto = (Zfwsxzcfsxtzgzspb41DTO)wsgldyService.queryZfwssxgzspbObj(request, v_dto);
				v_dto = (Zfwsxzcfsxtzgzspb41DTO)SysmanageUtil.ggzfwsmbzFromsz(v_dto);
				String myretjson = JSON.toJSONStringWithDateFormat(v_dto, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS43")){
				Zfwszdgxtzs43DTO v_dto = new Zfwszdgxtzs43DTO();
				v_dto.setAjdjid(v_ajdjid);
				v_dto = (Zfwszdgxtzs43DTO)wsgldyService.queryZfwszdgxtzsObj(request, v_dto);
				v_dto = (Zfwszdgxtzs43DTO)SysmanageUtil.ggzfwsmbzFromsz(v_dto);
				String myretjson = JSON.toJSONStringWithDateFormat(v_dto, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}else if(v_zfwsdmz.equalsIgnoreCase("ZFAJZFWS42")){
				Zfwsxzcfwts42DTO v_dto = new Zfwsxzcfwts42DTO();
				v_dto.setAjdjid(v_ajdjid);
				v_dto = (Zfwsxzcfwts42DTO)wsgldyService.queryZfwsxzcfwtsObj(request, v_dto);
				v_dto = (Zfwsxzcfwts42DTO)SysmanageUtil.ggzfwsmbzFromsz(v_dto);
				String myretjson = JSON.toJSONStringWithDateFormat(v_dto, "yyyy-MM-dd HH:mm:ss");
				map.put("data", myretjson);
			}
			
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
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
	public Object wsgldyDel(HttpServletRequest request, @Param("..") ZfajzfwsDTO dto) {
		return SysmanageUtil.execAjaxResult(wsgldyService.wsgldyDel(request, dto));
	}	
	
    /**
     * 保存物品清单
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwsOrder(HttpServletRequest request, @Param("..") ViewzfajzfwsDTO dto) {
    	Map<String, String> result = new HashMap<String, String>();
		try {		
			wsgldyService.saveZfwsOrder(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }	
	
	/**
	 * 
	 * pubUploadFjList的中文名称：附件列表页面增加初始化
	 * 
	 * pubUploadFjList的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/zfba/zfbaws/pubWsglAddOrder")
	public void pubWsglAddOrderIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 电子签名请求
	 * @return
	 */
	@At
	@Ok("json")
	public Object dzqz(String userpwd)throws Exception{
		Map map= new HashMap();
		boolean v_pwok=wsgldyService.dzqm(userpwd);
		if( !v_pwok){  
			map.put("code","-1");
			map.put("data","密码不正确");
		}else{
			  map.put("code","0");
			  map.put("data","");
		}
		return map;
	} 
}
