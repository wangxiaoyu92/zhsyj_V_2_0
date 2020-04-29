package com.askj.tmsyj.tmsyj.module;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PcompanyXkzDTO;
import com.askj.baseinfo.dto.PcomryDTO;
import com.askj.baseinfo.dto.PgzpjDTO;
import com.askj.baseinfo.service.PcomryService;
import com.askj.jk.dto.JkDTO;
import com.askj.jk.service.JkglService;
import com.askj.jyjc.dto.JyjcndwjDTO;
import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.jyjc.entity.Jyjcndwjmx;
import com.askj.jyjc.service.JyjcService;
import com.askj.spsy.dto.QproductDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.PcompanynddtpjDTO;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.tmsyj.tmspsc.service.KhgxService;
import com.askj.tmsyj.tmsyj.dto.*;
import com.askj.tmsyj.tmsyj.entity.Hjyjcmxb;
import com.askj.tmsyj.tmsyj.entity.Hjyjczb;
import com.askj.tmsyj.tmsyj.entity.Pcomtousu;
import com.askj.tmsyj.tmsyj.service.TmsyjApiService;
import com.askj.tmsyj.tmsyj.service.TmsyjService;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.PubParentChildDto;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * TmsyjApiModule的中文名称：【透明食药监】api接口module
 *
 * TmsyjApiModule的描述：
 *
 * @author ：zjf
 * @version ：V1.0
 */
@At("api/tmsyj/")
@IocBean
public class TmsyjApiModule extends BaseModule {
	@Inject
	protected TmsyjApiService tmsyjApiService;

	@Inject
	private PcomryService pcomryService; // 用于调用企业人员操作

	@Inject
	private KhgxService khgxService; // 用户供销关系操作

	@Inject
	protected JyjcService jyjcService; // 用户商品管理

	@Inject
	protected TmsyjService tmsyjService; // 进销货管理

	@Inject
	protected JkglService jkglService; // 监控管理

	/**
	 *
	 * getAa01的中文名称：获取系统参数表Aa01
	 *
	 * getAa01的概要说明：
	 *
	 * @param request
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getAa01List(HttpServletRequest request, @Param("..") Aa01 dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			String aaa001 = StringHelper.showNull2Empty(dto.getAaa001());
			if("".equals(aaa001)){
				throw new BusinessException("入参aaa001不能为空！");
			}
			map = tmsyjApiService.getAa01List(request,dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getAa10List的中文名称：获取系统代码表Aa10
	 *
	 * getAa10List的概要说明：
	 *
	 * @param request
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getAa10List(HttpServletRequest request, @Param("..") Aa10 dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			String aaa100 = StringHelper.showNull2Empty(dto.getAaa100());
			if("".equals(aaa100)){
				throw new BusinessException("入参aaa100不能为空！");
			}
			map = tmsyjApiService.getAa10List(request,dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getAa13List的中文名称：获取统筹区列表
	 *
	 * getAa13List的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getAa13List(HttpServletRequest request, @Param("..") Aa13 dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getAa13List(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getAreaTabList的中文名称：获取公众端统筹区tab列表
	 *
	 * getAreaTabList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getAreaTabList(HttpServletRequest request, @Param("..") Aa13 dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getAreaTabList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getNewsList的中文名称：获取新闻列表
	 *
	 * getNewsList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getNewsList(HttpServletRequest request, @Param("..") News dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getNewsList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getPreNews的中文名称：获取上一条新闻
	 *
	 * getPreNews的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPreNews(HttpServletRequest request, @Param("..") News dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPreNews(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getNextNews的中文名称：获取下一条新闻
	 *
	 * getNextNews的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getNextNews(HttpServletRequest request, @Param("..") News dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getNextNews(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getPcompanyList的中文名称：获取企业列表
	 *
	 * getPcompanyList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyList(HttpServletRequest request, @Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPcompanyList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getPcompanyRcjdglryList的中文名称：获取企业日常监督管理人员列表
	 *
	 * getPcompanyRcjdglryList的概要说明：日常监督管理员
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyRcjdglryList(HttpServletRequest request,  @Param("..") PcomryDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPcompanyRcjdglryList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getPcompanyXkzList ： 获取企业资质证明信息
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @user : zy 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyXkzList(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPcompanyXkzList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanyXkz : 保存企业许可证信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanyXkz(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjApiService.savePcompanyXkz(request, dto));
	}

	/**
	 *
	 * delPcompanyXkz ： 删除企业许可证信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcompanyXkz(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjApiService.delPcompanyXkz(request, dto));
	}

	/**
	 *
	 * getPcompanyXkzFjList的中文名称：获取企业相关许可证附件
	 *
	 * getPcompanyXkzFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyXkzFjList(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPcompanyXkzFjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getPcomryList的中文名称：获取企业人员列表
	 *
	 * getPcomryList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcomryList(HttpServletRequest request, @Param("..") PcomryDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPcomryList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcomry ： 添加企业人员基本信息
	 * savePcomry 的概要说明： 调用的是pcomryService的方法
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcomry(HttpServletRequest request, @Param("..") PcomryDTO dto){
		return SysmanageUtil.execAjaxResult(pcomryService.savePcomry(request, dto));
	}

	/**
	 *
	 * delPcomry： 删除企业人员
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcomry(HttpServletRequest request, @Param("..") PcomryDTO dto){
		return SysmanageUtil.execAjaxResult(pcomryService.delPcomry(request, dto));
	}

	/**
	 *
	 * getPcompanyGxList : 企业供销管理列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyGxList(HttpServletRequest request, @Param("..") HjgztkhgxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = khgxService.queryKhgxList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanyGx : 保存客户关系
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanyGx(HttpServletRequest request, @Param("..") HjgztkhgxDTO dto){
		return SysmanageUtil.execAjaxResult(khgxService.saveKhgx(request, dto));
	}

	/**
	 *
	 * delPcompanyGx ： 删除企业客户关系信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcompanyGx(HttpServletRequest request, @Param("..") HjgztkhgxDTO dto){
		return SysmanageUtil.execAjaxResult(khgxService.delKhgx(dto));
	}

	/**
	 *
	 * getPcompanyGoodList ： 获取企业商品列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPcompanyGoodList(HttpServletRequest request, @Param("..") JyjcypDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcyp(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanyGood : 保存企业商品
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanyGood(HttpServletRequest request, @Param("..") JyjcypDTO dto){
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcyp(request, dto));
	}

	/**
	 *
	 * delPcompanyGood ： 删除企业商品
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy 
	 */
	@At
	@Ok("json")
	public Object delPcompanyGood(HttpServletRequest request, @Param("..") JyjcypDTO dto){
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcyp(request, dto));
	}

	/**
	 *
	 * getFjList的中文名称：获取附件列表
	 *
	 * getFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getFjList(HttpServletRequest request, @Param("..") FjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getFjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getPfjList的中文名称：获取pfj表中的附件列表
	 *
	 * getPfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPfjList(HttpServletRequest request, @Param("..") FjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPfjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * delFj的中文名称：删除附件表
	 *
	 * delFj的概要说明：通用
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object delFj(HttpServletRequest request, @Param("..") FjDTO dto) {
		return SysmanageUtil.execAjaxResult(tmsyjApiService.delFj(request, dto));
	}

	/**
	 *
	 * getJkyList_bak的中文名称：获取监控源列表
	 *
	 * getJkyList_bak的概要说明：获取本地同步的监控源数据
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJkyList_bak(HttpServletRequest request, @Param("..") JkDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getJkyList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getJkyList的中文名称：获取监控源列表
	 *
	 * getJkyList的概要说明：直接调用明厨亮灶接口
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJkyList(HttpServletRequest request, @Param("..") JkDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		map.put("total", "0");
		try {
			Map tempMap = jkglService.queryJkqy(dto,pd);
			List ls = (List) tempMap.get(GlobalNames.SI_RESULTSET);
			if(ls!=null&&ls.size()>0) {
				net.sf.json.JSONObject json = net.sf.json.JSONObject.fromObject(ls.get(0));
				if(json.has("camorgid")){
					dto.setCamorgid(json.getString("camorgid"));
				}else{
					dto.setCamorgid("");
				}

				if (!"".equals(StringHelper.showNull2Empty(dto.getCamorgid()))) {
					com.alibaba.fastjson.JSONArray jsonArray = jkglService.getComJkyFromMCLZ(dto.getCamorgid());
					map.put("rows", jsonArray);
					map.put("total", jsonArray.size());
				}
			}
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getJkyDetail的中文名称：获取监控源详细信息
	 *
	 * getJkyDetail的概要说明：直接调用明厨亮灶接口
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJkyDetail(@Param("..") JkDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			com.alibaba.fastjson.JSONObject jsonObject = jkglService.getComJkyDetailFromMCLZ(dto.getJkid());
			return SysmanageUtil.execAjaxResult(jsonObject, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	//获取监控企业列表
	@At
	@Ok("json")
	public Object queryJkqy(@Param("..") JkDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jkglService.queryJkqy(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getTygcList的中文名称：获取天眼工程离线视频列表
	 *
	 * getTygcList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getTygcList(HttpServletRequest request, @Param("..") JkDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getTygcList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * addPgzpj的中文名称：新增公众评价信息
	 *
	 * addPgzpj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author ：zjf
	 */
	@At
	@Ok("json")
	public Object addPgzpj(HttpServletRequest request,@Param("..") PgzpjDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjApiService.addPgzpj(request, dto));
	}

	/**
	 *
	 * getPgzpjList的中文名称：获取公众评价列表
	 *
	 * getPgzpjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPgzpjList(HttpServletRequest request, @Param("..") PgzpjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPgzpjList(request,dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getPgzpjmxList的中文名称：获取公众评价明细信息
	 *
	 * getPgzpjmxList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPgzpjmxList(HttpServletRequest request, @Param("..") PgzpjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPgzpjmxList(request,dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getJyjcjgList的中文名称：获取检验检测结果列表
	 *
	 * getJyjcjgList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJyjcjgList(HttpServletRequest request, @Param("..") HjyjczbmxbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getJyjcjgList(request,dto,pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
/**
	 *
	 * getJyjcjgList的中文名称：获取检验检测结果列表
	 *
	 * getJyjcjgList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJcbgList(HttpServletRequest request, @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getJcbgList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getJdjcResultList的中文名称：获取监督检查结果列表
	 *
	 * getJdjcResultList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getJdjcResultList(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getJdjcResultList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getJdjcResultDetail的中文名称：获取监督检查结果明细
	 *
	 * getJdjcResultDetail的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@At
	@Ok("raw:htm")
	public Object getJdjcResultDetail(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) {
		try {
			BsCheckMaster bsCheckMaster = tmsyjApiService.getJdjcResultDetail(request, dto, pd);
			return bsCheckMaster.getDetailinfo();
		} catch (Exception e) {
			return "暂无数据";
		}
	}

	/**
	 *
	 * getSpxxtmList的中文名称：获取商品信息透明
	 *
	 * getSpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSpxxtmList(HttpServletRequest request, @Param("..") HsptmDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSpxxtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getSpxxtmList的中文名称：获取商品信息透明
	 *
	 * getSpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSpxxtmList_zm(HttpServletRequest request, @Param("..") HsptmDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSpxxtmList_zm(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * getYlcgtmList的中文名称：获取原料采购透明
	 *
	 * getYlcgtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getYlcgtmList(HttpServletRequest request, @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getYlcgtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getYlcgtmList的中文名称：获取原料采购透明
	 *
	 * getYlcgtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getYlcgtmList_zm(HttpServletRequest request, @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getYlcgtmList_zm(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCpxxtmList的中文名称：获取产品信息透明
	 *
	 * getCpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCpxxtmList(HttpServletRequest request, @Param("..") HscpcbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getCpxxtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getXsqxtmList的中文名称：获取销售去向透明
	 *
	 * getXsqxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getXsqxtmList(HttpServletRequest request, @Param("..") HscxhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getXsqxtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getKjfjList的中文名称：获取食品快检附件信息
	 *
	 * getKjfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getKjfjList(HttpServletRequest request,  @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getKjfjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCpxxtmJyjcFjList的中文名称：获取生产企业产品的检验报告附件列表
	 *
	 * getCpxxtmJyjcFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCpxxtmJyjcFjList(HttpServletRequest request, @Param("..") HscpcbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getCpxxtmJyjcFjList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCpxxtmplList的中文名称：获取生产企业产品的配料表
	 *
	 * getCpxxtmplList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCpxxtmplList(HttpServletRequest request, @Param("..") HscpcbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getCpxxtmplList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getLsdjtmList的中文名称：获取历史等级透明
	 *
	 * getLsdjtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getLsdjtmList(HttpServletRequest request, @Param("..") PcompanynddtpjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getLsdjtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getSpsyList的中文名称：获取食品溯源信息
	 *
	 * getSpsyList的概要说明：追溯
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSpsyList(HttpServletRequest request, @Param("..") HsptmDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSpsyList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * uploadFj的中文名称：附件上传
	 *
	 * uploadFj的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.uploadFj(request,dto);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCompanyStockList : 获取企业进货列表信息
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCompanyStockList(HttpServletRequest request, @Param("..") HjhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryJinhuo(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanyStock : 保存企业进货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanyStock(HttpServletRequest request, @Param("..") HjhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.saveJinhuo(request, dto));
	}

	/**
	 *
	 * delPcompanyStock : 删除企业进货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcompanyStock(HttpServletRequest request, @Param("..") HjhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.delJinhuo(request, dto));
	}

	/**
	 *
	 * getCompanySalesList ： 获取企业销货信息列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCompanySalesList(HttpServletRequest request, @Param("..") HxhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryXiaohuo(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanySales : 保存企业销货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanySales(HttpServletRequest request, @Param("..") HxhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.saveXiaohuo(request, dto));
	}

	/**
	 *
	 * delPcompanySales ： 删除企业销货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcompanySales(HttpServletRequest request, @Param("..") HxhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.delXiaohuo(request, dto));
	}

	/**
	 *
	 * getCompanySalesListOfProduct ： 获取生产企业销货信息列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCompanySalesListOfProduct(HttpServletRequest request, @Param("..") HscxhbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjService.queryScxh(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * savePcompanySalesOfProduct : 保存生产企业销货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanySalesOfProduct(HttpServletRequest request, @Param("..") HscxhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.saveScxh(request, dto));
	}

	/**
	 *
	 * delPcompanySalesOfProduct ： 删除生产企业销货信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object delPcompanySalesOfProduct(HttpServletRequest request, @Param("..") HscxhbDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjService.delScxh(request, dto));
	}

	/**
	 *
	 * getPublicSupervisionList : 获取监督信息列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPublicSupervisionList(HttpServletRequest request, @Param("..") PgzjdDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getPublicSupervisionList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}

	/**
	 *
	 * addPublicSupervision : 添加公众监督
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@At
	@Ok("json")
	public Object addPublicSupervision(HttpServletRequest request, @Param("..") PgzjdDTO dto){
		return SysmanageUtil.execAjaxResult(tmsyjApiService.addPublicSupervision(request, dto));
	}

	/**
	 *
	 * getZcbList的中文名称：获取生产企业自查表
	 *
	 * getZcbList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getZcbList(HttpServletRequest request, @Param("..") HjgztxgpicDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getZcbList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * querySymOfLt ：查询流通企业产品溯源码
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/pub/spsy/querySymOfLt")
	public void querySymOfLt(HttpServletRequest request) throws Exception {
		// 页面初始化
		String v_hjhbid = request.getParameter("hjhbid"); // 进货表id
		Map map =  (Map) tmsyjApiService.querySymOfLt(v_hjhbid);

		// 产品信息
		JyjcypDTO v_productInfo = (JyjcypDTO)map.get("ypInfo");
		request.setAttribute("ypInfo", v_productInfo);

		// 产品检测主表信息
		Hjyjczb v_jcZbInfo = (Hjyjczb)map.get("jcZbInfo");
		request.setAttribute("jcZbInfo", v_jcZbInfo);

		// 检测明细信息
		List<Hjyjcmxb> v_mxList = (List<Hjyjcmxb>)map.get("jcMxList");
		request.setAttribute("jcMxList", v_mxList);

	}

	/**
	 *
	 * addJyjcyp : 添加你点我检
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object addJyjcyp(HttpServletRequest request, @Param("..") JyjcndwjDTO dto) {
		Map map = new HashMap();
		try {
			Jyjcndwjmx ndwj=tmsyjApiService.addJyjcyp(request, dto);
			if(ndwj == null){
				map.put("code","-1");
				map.put("msg","提交失败");
				return map;
			}
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}

	@At
	@Ok("jsp:/jsp/jyjc/sqjccx")
	public void sqjccxIndex(HttpServletRequest request){
		//申请检测查询
	}

	/**
	 * 你点我检分页查询
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 */
	@At
	@Ok("json")
	public Object querySqjccx(HttpServletRequest request, @Param("..") JyjcndwjDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = jyjcService.querySqjccx(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询常见食品
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 */
	@At
	@Ok("json")
	public Object queryparentchild (HttpServletRequest request, @Param("..") PubParentChildDto dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = tmsyjApiService.queryparentchild(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * addAqjgWyts : 我要投诉
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object addAqjgWyts(HttpServletRequest request, @Param("..") PcomtousuDTO dto) {
		Map map = new HashMap();
		try {
			Pcomtousu wyts = tmsyjApiService.addAqjgWyts(request, dto);
			if(wyts == null){
				map.put("code","-1");
				map.put("msg","提交失败");
				return map;
			}
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}

	/**
	 *
	 * getSycptmList的中文名称：获取产品透明
	 *
	 * getSycptmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSycptmList(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSycptmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCpsctmList的中文名称：获取产品生长信息
	 *
	 * getCpsctmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCpsctmList(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getCpsctmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getCpjcjytmList的中文名称：获取检验检疫信息
	 *
	 * getCpjcjytmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getCpjcjytmList(HttpServletRequest request, @Param("..") QproductDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getCpjcjytmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getSycpxsqxtmList的中文名称：获取溯源产品销售去向透明
	 *
	 * getSycpxsqxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSycpxsqxtmList(HttpServletRequest request, @Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSycpxsqxtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}

	/**
	 *
	 * getSycpcgxxtmList的中文名称：获取溯源产品采购信息透明
	 *
	 * getSycpcgxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getSycpcgxxtmList(HttpServletRequest request, @Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = tmsyjApiService.getSycpcgxxtmList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);// 异常返回
		}
	}
}
