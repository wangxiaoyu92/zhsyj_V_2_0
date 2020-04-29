package com.askj.tmsyj.tmsyj.module;

import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.tmsyj.tmsyj.dto.*;
import com.askj.tmsyj.tmsyj.entity.Pcomtousu;
import com.askj.tmsyj.tmsyj.service.TmsyjService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
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
 * TmsyjModule的中文名称：【透明食药监】module
 * 
 * TmsyjModule的描述：
 * 
 * @author ：gjf
 * @version ：V1.0
 */
@At("/tmsyjhtgl")
@IocBean
public class TmsyjModule extends BaseModule {
	@Inject
	protected TmsyjService tmsyjService;

	/**
	 * 
	 * jinhuoIndex的中文名称：进货管理
	 * 
	 * newsIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jinhuo")
	public void jinhuoIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * queryJinhuo 查询进货信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJinhuo(HttpServletRequest request, @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJinhuo(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	/**
	 * 查询进货信息
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryJinhuoDTO(HttpServletRequest request,
			@Param("..") HjhbDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = tmsyjService.queryJinhuo(request,dto, pd);
			List list = (List) map.get("rows");
			HjhbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HjhbDTO)list.get(0);
				//map.put("data", list.get(0)); 
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	
	/**
	 * 
	 * jinhuoFormIndex的中文名称：进货信息
	 * 
	 * jinhuoFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jinhuoForm")
	public void jinhuoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 保存进货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveJinhuo(HttpServletRequest request,@Param("..")HjhbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveJinhuo(request, dto));
	}	
	
	/**
	 * 删除进货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delJinhuo(HttpServletRequest request,@Param("..")HjhbDTO dto ) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delJinhuo(request, dto));
	}
	
	/**
	 * 
	 * xiaohuoFormIndex的中文名称：销货信息编辑窗体
	 * 
	 * xiaohuoFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/xiaohuoForm")
	public void xiaohuoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * xiaohuoIndex的中文名称：销货管理
	 * 
	 * xiaohuoIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/xiaohuo")
	public void xiaohuoIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * selectJinhuoIndex的中文名称：选择进货信息
	 * 
	 * selectJinhuoIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/selectJinhuo")
	public void selectJinhuoIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 保存销货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveXiaohuo(HttpServletRequest request, @Param("..")HxhbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveXiaohuo(request, dto));
	}	
	
	/**
	 * queryXiaohuo 查询销货信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryXiaohuo(HttpServletRequest request, @Param("..") HxhbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryXiaohuo(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}	

	/**
	 * 查询进货信息
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryXiaohuoDTO(HttpServletRequest request,
			@Param("..") HxhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryXiaohuo(request,dto, pd);
			List list = (List) map.get("rows");
			HxhbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HxhbDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	
	/**
	 * 删除销货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delXiaohuo(HttpServletRequest request,@Param("..")HxhbDTO dto ) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delXiaohuo(request, dto));
	}	
	
	/**
	 * 
	 * jianceIndex的中文名称：检测信息
	 * 
	 * jianceIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jiance")
	public void jianceIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jianceFormIndex的中文名称：检测信息编辑窗体
	 * 
	 * jianceFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jianceForm")
	public void jianceFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * queryJiancemx 查询检测明细
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJiancemx(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJiancemx(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}	
	
	/**
	 * queryJiancezb 查询检测主表
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJiancezb(HttpServletRequest request, @Param("..") HjyjczbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJiancezb(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}	
	
	/**
	 *  queryJiancezbDTO 查询检测主表
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryJiancezbDTO(HttpServletRequest request,
			@Param("..") HjyjczbDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = tmsyjService.queryJiancezb(request,dto, pd);
			List list = (List) map.get("rows");
			HjyjczbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HjyjczbDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}	
	
	/**
	 * 保存检测信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveJiance(HttpServletRequest request, @Param("..")HjyjczbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveJiance(request, dto));
	}	
	
	/**
	 * 删除进货检测信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delJiance(HttpServletRequest request, @Param("..")HjhbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delJiance(request, dto));
	}	
	
	/**
	 * 
	 * scpcIndex的中文名称：生产批次
	 * 
	 * scpcIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/scpc")
	public void scpcIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * scpcFormIndex的中文名称：生产批次编辑界面
	 * 
	 * scpcFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/scpcForm")
	public void scpcFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 查询进货信息
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryScpcDTO(HttpServletRequest request,
			@Param("..") HscpcbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryScpc(request,dto, pd);
			List list = (List) map.get("rows");
			HscpcbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HscpcbDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}	
	/**
	 * queryScpc 查询生产批次信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryScpc(HttpServletRequest request, @Param("..") HscpcbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryScpc(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	/**
	 * 保存生产批次信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveScpc(HttpServletRequest request, @Param("..")HscpcbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveScpc(request, dto));
	}
	
	/**
	 * 删除生产批次信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delScpc(HttpServletRequest request,@Param("..")HscpcbDTO dto ) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delScpc(request, dto));
	}
	
	/**
	 * queryScpc 查询生产批次信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryScxh(HttpServletRequest request, @Param("..") HscxhbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryScxh(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	/**
	 * 查询生产销货信息
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryScxhDTO(HttpServletRequest request,
			@Param("..") HscxhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryScxh(request,dto, pd);
			List list = (List) map.get("rows");
			HscxhbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HscxhbDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	
	/**
	 * 保存生产销货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveScxh(HttpServletRequest request,@Param("..")HscxhbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveScxh(request, dto));
	}	
	
	
	/**
	 * 删除生产销货信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delScxh(HttpServletRequest request, @Param("..")HscxhbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delScxh(request, dto));
	}
	
	/**
	 * 
	 * scpcIndex的中文名称：生产批次
	 * 
	 * scpcIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/scxh")
	public void scxhIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * scxhFormIndex的中文名称：生产销货编辑界面
	 * 
	 * scxhFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/scxhForm")
	public void scxhFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * selectScpcIndex的中文名称：选择生产批次信息
	 * 
	 * selectScpcIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/selectScpc")
	public void selectScpcIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * 
	 *  qyhylIndex的中文名称：产品和原料
	 * 
	 *  qyhylIndex的概要说明：
	 * 
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/cpycl")
	public void cpyclIndex(HttpServletRequest request) {
		// 页面初始化
	} 
	/**
	 * 
	 * 
	 *  delCpycl的中文名称：删除产品的原料
	 * 
	 *  delCpycl的概要说明：
	 * 
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object delCpycl(HttpServletRequest request, @Param("..") HcphycldybDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delCpycl(request, dto));
	}
	/**
	 * 
	 * 
	 *  saveQyhyl的中文名称：保存产品和原料
	 * 
	 *  saveQyhyl的概要说明：
	 * 
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object saveCphycl(HttpServletRequest request,@Param("..")HcphycldybDTO dto) {
		return SysmanageUtil .execAjaxResult(tmsyjService.saveCphycl(request,dto));
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object QueryCphycl(HttpServletRequest request, @Param("..")JyjcypDTO dto) {
		try {
			List proList = (List) tmsyjService.queryCphycl(request,dto);
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
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/cpyclAdd")
	public void cpyclAddIndex(HttpServletRequest request) {
		//页面跳转
	}
	@At
	@Ok("json")
	public Object queryComCl(HttpServletRequest request,
			@Param("..") HcphycldybDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryComCl(dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	
	@At
	@Ok("json")
	public Object queryCpycl(HttpServletRequest request,
			@Param("..") HcphycldybDTO dto, @Param("..") PagesDTO pd) throws Exception {
		return  tmsyjService.queryCpycl(request,dto,pd) ;

	}

	/**
	 * 
	 * choujianbaogaoIndex的中文名称：监督检查抽检报告
	 * 
	 * choujianbaogaoIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/chouyangbaogao")
	public void chouyangbaogaoIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * chouyangbaogaoFormIndex的中文名称：监督检查抽样报告
	 * 
	 * chouyangbaogaoFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/chouyangbaogaoForm")
	public void chouyangbaogaoFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * queryChoujianbaogao 查询监督检查抽检报告信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryChouyangbaogao(HttpServletRequest request, 
			@Param("..") HjdjccybgDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryChouyangbaogao(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	/**
	 * 查询进货信息
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryChouyangbaogaoDTO(HttpServletRequest request,
			@Param("..") HjdjccybgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryChouyangbaogao(request,dto, pd);
			List list = (List) map.get("rows");
			HjdjccybgDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HjdjccybgDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}

	/**
	 * 保存监督检查抽样报告信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveChouyangbaogao(HttpServletRequest request, @Param("..")HjdjccybgDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveChouyangbaogao(request, dto));
	}	
	
	/**
	 * 删除监督检查抽样报告信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delChouyangbaogao(HttpServletRequest request, @Param("..")HjdjccybgDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delChouyangbaogao(request, dto));
	}	
	
	/**
	 * 
	 * jianceyiqiIndex的中文名称：检测仪器
	 * 
	 * jianceyiqiIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jianceyiqi")
	public void jianceyiqiIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * jianceyiqiFormIndex的中文名称：检测仪器编辑窗体
	 * 
	 * jianceyiqiFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jianceyiqiForm")
	public void jianceyiqiFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	
	/**
	 * queryJianceyiqiDTO查询检测仪器
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryJianceyiqiDTO(HttpServletRequest request,
			@Param("..") HjcjgjcyqbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryJianceyiqi(request,dto, pd);
			List list = (List) map.get("rows");
			HjcjgjcyqbDTO pcDto = null;
			if(list!=null && list.size()>0){
				pcDto = (HjcjgjcyqbDTO)list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}

	/**
	 * saveJianceyiqi 保存检测仪器
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object saveJianceyiqi(HttpServletRequest request, @Param("..")HjcjgjcyqbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveJianceyiqi(request, dto));
	}	
	
	/**
	 *delJianceyiqi 删除检测仪器
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delJianceyiqi(HttpServletRequest request, @Param("..")HjcjgjcyqbDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delJianceyiqi(request, dto));
	}	
	
	/**
	 * queryJianceyiqi 查询检测仪器
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJianceyiqi(HttpServletRequest request,
								  @Param("..") HjcjgjcyqbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJianceyiqi(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	/**
	 * 
	 * selectJianceyiqiIndex的中文名称：选择检测仪器
	 * 
	 * selectJianceyiqiIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/selectJianceyiqi")
	public void selectJianceyiqiIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *
	 * selectJianceyiqiIndex的中文名称：选择检测仪器
	 *
	 * selectJianceyiqiIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp1.0/tmsyj/tmsyj/htgl/selectJianceyiqi")
	public void selectJianceyiqiIndexEasyui(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jinhuobatchIndex的中文名称：批量进货管理
	 * 
	 * jinhuobatchIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jinhuobatch")
	public void jinhuobatchIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
    /**
     * 批量进货新增保存
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveBatchjinhuo(HttpServletRequest request, @Param("..") HjhbDTO dto) {
    	Map<String, String> result = new HashMap<String, String>();
		try {		
			tmsyjService.saveBatchjinhuo(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }
   
	/**
	 * queryJinhuo 查询进货批量信息
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJinhuoBatchMain(HttpServletRequest request,
									   @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJinhuoBatchMain(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		}
	}
	
	/**
	 * 
	 * 
	 *  queryJgztpicList的中文名称 ：查询监管主体先关图片
	 * 
	 *  queryJgztpicList的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryJgztpicList(HttpServletRequest request, 
			@Param("..") HjgztxgpicDTO dto, @Param("..") PagesDTO pd) {
		Map m = new HashMap();
		try {
			m = tmsyjService.queryJgztpicList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(m, e);
		} 
	}	
    
	/**
	 * 
	 * 
	 *  saveKhgx的中文名称：添加客户关系
	 * 
	 *  saveKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object saveJgztpic(HttpServletRequest request, @Param("..") HjgztxgpicDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.saveJgztpic(request, dto));
	}
	
	/**
	 * 
	 * zcbUploadIndex的中文名称：生产企业自查表图片上传
	 * 
	 * zcbUploadIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/zcbUpload")
	public void zcbUploadIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * zcbUploadFormIndex的中文名称：生产企业自查表图片上传
	 * 
	 * zcbUploadFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/zcbUploadForm")
	public void zcbUploadFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * jyjcbgUploadIndex的中文名称：生产企业检验检测图片上传
	 * 
	 * jyjcbgUploadIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jyjcbgUpload")
	public void jyjcbgUploadIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jyjcbgUploadFormIndex的中文名称：生产企业检验检测图片上传
	 * 
	 * jyjcbgUploadFormIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmsyj/htgl/jyjcbgUploadForm")
	public void jyjcbgUploadFormIndex(HttpServletRequest request) {
		// 页面初始化
	}		
	
	/**
	 * 
	 * 
	 *  delKhgx的中文名称：删除客户关系
	 * 
	 *  delKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object delJgztpic(HttpServletRequest request, @Param("..") HjgztxgpicDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjService.delJgztpic(request,dto));
	}

	/**
	 *  createJinHuoSpQRcode：创建进货商品二维码
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object createJinHuoSpQRcode(HttpServletRequest request) {
		Map map = new HashMap();
		try {
			tmsyjService.createJinHuoSpQRcode(request);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("jsp:/jsp/jyjc/wyts")
	public void wytsIndex(HttpServletRequest request){
		//申请检测查询
	}

	/**
	 * 我要投诉分页查询
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 */
	@At
	@Ok("json")
	public Object queryAqjgWyts(HttpServletRequest request, @Param("..") PcomtousuDTO dto,
								@Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = tmsyjService.queryAqjgWyts(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * addAqjgWyts : 我要投诉受理
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object addAqjgWyts(HttpServletRequest request,
							  @Param("..") PcomtousuDTO dto) {
		Map map = new HashMap();
		try {
			Object obj=tmsyjService.updateAqjgWyts(request, dto);
			if(!"1".equals(obj.toString())){
				map.put("code","-1");
				map.put("msg","提交失败");
				return map;
			}
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}

}
