package com.askj.baseinfo.module.pub;

import com.askj.baseinfo.dto.*;
import com.askj.baseinfo.entity.Pcyzdszmain;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.jyjc.dto.JyjcjgDTO;
import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.tmsyj.tmsyj.dto.HjgztkhgxDTO;
import com.askj.zfba.dto.ZfajdjDTO;
import com.zzhdsoft.siweb.dto.*;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.service.sysmanager.SysorgService;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 公共选择案件
 * @author lfy
 * 
 *
 */
@At("/pub/pub")
@IocBean
@Fail("jsp:/jsp/error/error")
public class pubModule {
	protected final Logger logger = Logger.getLogger(pubModule.class);

	@Inject
	protected PubService pubService;
	@Inject
	protected SysorgService sysorgService;	
	
	
	/**
	 * 
	 * selectcomIndex的中文名称：选择单位信息
	 * 
	 * selectcomIndex的概要说明：初始化选择企业页面
	 * 
	 * @param request 访问请求
	 * @author : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectcom")
	public void selectcomIndex(HttpServletRequest request,@Param("querytype")String querytype) {
		// 页面初始化
	}
	/**
	 *
	 * selectcomIndex的中文名称：选择单位信息
	 *
	 * selectcomIndex的概要说明：初始化选择企业页面
	 *
	 * @param request 访问请求
	 * @author : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp1.0/pub/pub/selectcom")
	public void selectcomIndexEasyui(HttpServletRequest request,@Param("querytype")String querytype) {
		// 页面初始化
	}

	/**
	 *
	 * selectcomIndex的中文名称：选择任务页面
	 * selectcomIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectcjrw")
	public void selectcjrwIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * 
	 *  selectcomhviewjgztIndex的中文名称：
	 * 
	 *  selectcomhviewjgztIndex的概要说明：
	 *
	 * @param request 访问请求
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectcomhviewjgzt")
	public void selectcomhviewjgztIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * selectareaIndex的中文名称：选择地区下拉树
	 * 
	 * selectareaIndex的概要说明： 
	 * 
	 * @param request 访问请求
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectarea")
	public void selectareaIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * selectayIndex的中文名称：选择案由信息
	 * 
	 * selectayIndex的概要说明：
	 * 
	 * @param request 访问请求
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectay")
	public void selectayIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySelectcom的中文名称：查询企业
	 * 
	 * querySelectcom的概要说明：
	 * 
	 * @param dto 企业参数
	 * @param pd 分页参数
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySelectcom(@Param("..") PcompanyDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc =  pubService.querySelectcom(dto, pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	/**
	 * queryHviewjgzt的中文名称：查询监管主体
	 * @param dto 主体参数
	 * @param pd 分页参数
	 * @return 主体列表信息
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryHviewjgzt(@Param("..") HviewjgztDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.queryHviewjgzt(dto, pd);
	}	
	
	/**
	 * 
	 * querySelectay的中文名称：查询违法行为参数记录
	 * 
	 * querySelectay的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySelectay(@Param("..") PwfxwcsDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try{
			map = pubService.querySelectay(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * selectajIndex的中文名称：选取案件登记页面初始化
	 * 
	 * selectajIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectaj")
	public void selectajIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySelectaj的中文名称：查询案件登记记录
	 * 
	 * querySelectaj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySelectaj(@Param("..") ZfajdjDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.queryAjla(dto, pd);
	}

	/**
	 * 
	 * selectjyjcypIndex的中文名称：检验检测样品
	 * selectjyjcypIndex的概要描述：querySelectjyjcyp
	 * @param request
	 * Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectjyjcyp")
	public void selectjyjcypIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySelectjyjcyp的中文名称：查询检验检测样品
	 * querySelectjyjcyp的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by : lfy
	 */
	@At
	@Ok("json")
	public Object querySelectjyjcyp(@Param("..") JyjcjgDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			System.out.println(pd);
			map = pubService.querySelectjyjcyp(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * selectjyjcxmIndex的中文名称：检验检测项目
	 * selectjyjcxmIndex的概要描述：
	 * @param request
	 * Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectjyjcxm")
	public void selectjyjcxmIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * querySelectjyjcxm的中文名称：查询检验检测项目
	 * querySelectjyjcxm的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by : lfy
	 */
	@At
	@Ok("json")
	public Object querySelectjyjcxm(@Param("..") JyjcjgDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = pubService.querySelectjyjcxm(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	
	
	/**
	 * 
	 * pcyzdszmainIndex的中文名称：常用字段值设置
	 * pcyzdszmainIndex的概要描述：
	 * @param request
	 * Written by : gjf
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pcyzdszmain")
	public void pcyzdszmainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryPcyzdszmain的中文名称：查询常用字段设置主表
	 * 
	 * queryPcyzdszmain的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPcyzdszmain(@Param("..") PcyzdszmainDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = pubService.queryPcyzdszmain(dto, pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
//		return pubService.queryPcyzdszmain(dto, pd);
	}	
	
	/**
	 * 
	 * queryPcyzdszdetail的中文名称：查询常用字段设置明细表
	 * 
	 * queryPcyzdszdetail的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPcyzdszdetail(@Param("..") PcyzdszmainDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = pubService.queryPcyzdszdetail(dto, pd);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
//		return pubService.queryPcyzdszdetail(dto, pd);
	}	
	
	/**
	 * 
	 * queryPcyzdszdetailObj的中文名称：查询常用字段设置明细表单个
	 * 
	 * queryPcyzdszdetailObj的概要说明：
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
	public Object queryPcyzdszdetailObj(HttpServletRequest request,
			@Param("..") PcyzdszmainDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = pubService.queryPcyzdszdetail(dto, pd);
			List ls = (List) map.get("rows");
			PcyzdszmainDTO zPcyzdszmainDTO = null;
			if (ls != null && ls.size() > 0) {
				zPcyzdszmainDTO = (PcyzdszmainDTO) ls.get(0);
			}
			map.put("data", zPcyzdszmainDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	
	
	/**
	 * 
	 * pcyzdszAddIndex的中文名称：常用字段值设置明细添加页面
	 * pcyzdszAddIndex的概要描述：
	 * @param request
	 * Written by : gjf
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pcyzdszAdd")
	public void pcyzdszAddIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * pcyzdszMainAddIndex的中文名称：主表字段值设置添加页面
	 * pcyzdszMainAddIndex的概要描述：
	 * @param request
	 * Written by : zy TODO
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pcyzdszMainAdd")
	public void pcyzdszMainAddIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * savePcyzdszMain的中文名称：保存主表字段值设置
	 * 
	 * savePcyzdszMain的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object savePcyzdszMain(HttpServletRequest request, @Param("..") PcyzdszmainDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.savePcyzdszMain(request, dto));
	}
	
	/**
	 * 
	 * delPcyzdszMain的中文名称：删除主表字段值设置
	 * 
	 * delPcyzdszMain的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object delPcyzdszMain(HttpServletRequest request, @Param("..") PcyzdszmainDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.delPcyzdszMain(request, dto));
	}
	
	/**
	 * 
	 * queryPcyzdszmainObj的中文名称：查询主表字段设置
	 * 
	 * queryPcyzdszmainObj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPcyzdszmainObj(@Param("..") PcyzdszmainDTO dto, @Param("..") PagesDTO pd) {
		
		Map map = new HashMap();
		try {		
			Pcyzdszmain main = (Pcyzdszmain) pubService.queryPcyzdszmainObj(dto, pd);
			map.put("data", main);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	
	/**
	 * 
	 * savePcyzdszAdd的中文名称：保存常用字段值设置明细
	 * 
	 * savePcyzdszAdd的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object savePcyzdszAdd(HttpServletRequest request, @Param("..") PcyzdszmainDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.savePcyzdszAdd(request, dto));
	}
	
	/**
	 * 
	 * delPcyzdsz的中文名称：删除常用字段值设置明细
	 * 
	 * delPcyzdsz的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delPcyzdsz(HttpServletRequest request, @Param("..") PcyzdszmainDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.delPcyzdsz(request, dto));
	}
	
	/**
	 * 
	 * queryPcyzdsz的中文名称：查询常用字段设置
	 * 
	 * queryPcyzdsz的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPcyzdsz(@Param("..") PcyzdszmainDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map=pubService.queryPcyzdsz(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);//无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);//异常返回
		}
	}
	/**
	 * 
	 * selectuserIndex中文含义:选择用户
	 * selectuserIndex描述:
	 * @param request
	 * written  by  ：  lfy
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectuser")
	public void selectuserIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * TAS的中文名称：第三方应用接入
	 *
	 * TAS的概要说明：
	 *
	 * @param request
	 * @return Written by :sunyifeng
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/thirdApp")
	public void TAS(HttpServletRequest request) {

	}

	/**
	 * 
	 * getComxiaoleiFromComdalei的中文名称：删除小类
	 * 
	 * getComxiaoleiFromComdalei的概要说明：通用
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public List getComxiaoleiFromComdalei(HttpServletRequest request, @Param("..") Aa10DTO dto) throws Exception {
		List resLs = new ArrayList();
		List ls = SysmanageUtil.getComxiaoleiFromComdalei(dto);
		for (int i = 0; i < ls.size(); i++) {
			Aa10DTO s = (Aa10DTO) ls.get(i);
			Map cm = new HashMap();
			cm.put("id", s.getId());
			cm.put("text", s.getText());
			resLs.add(cm);
		}
		return resLs;	
	}	
	
	/**
	 * 
	 * queryJieshouren的中文名称：查询待办事项 接收人
	 * 
	 * queryJieshouren的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJieshouren(@Param("..") PdbsxDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = pubService.queryJieshouren(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return pubService.queryJieshouren(dto, pd);
	}
	
    /**
     * 保存 待办事项接收人
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveJieshouren(HttpServletRequest request, @Param("..") PdbsxDTO dto) {
    	Map<String, String> result = new HashMap<String, String>();
		try {		
			pubService.saveJieshouren(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }
    
	/**
	 * 
	 * queryJieshourenDTO的中文名称：查询案件登记DTO
	 * 
	 * queryJieshourenDTO的概要说明：
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
	public Object queryJieshourenDTO(HttpServletRequest request,
			@Param("..") PdbsxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = pubService.queryPdbsx(dto, pd);
			List ls = (List) map.get("rows");
			PdbsxDTO v_PdbsxDTO = null;
			if (ls != null && ls.size() > 0) {
				v_PdbsxDTO = (PdbsxDTO) ls.get(0);
			}
			map.put("data", v_PdbsxDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryJieshourenDTO的中文名称：查询案件登记DTO
	 * 
	 * queryJieshourenDTO的概要说明：
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
	public Object queryDaibanshixiang(HttpServletRequest request,
			@Param("..") DaibanshixiangDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			DaibanshixiangDTO v_DaibanshixiangDTO = pubService.queryDaibanshixiang(dto, pd);
//			List ls = (List) map.get("rows");
//			DaibanshixiangDTO v_DaibanshixiangDTO = null;
//			if (ls != null && ls.size() > 0) {
//				v_DaibanshixiangDTO = (DaibanshixiangDTO) ls.get(0);
//			}
			map.put("data", v_DaibanshixiangDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	
	
	/**
	 * 
	 * queryChayueWei的中文名称：查询查阅的内容
	 * 
	 * queryChayueWei的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryChayueWei(@Param("..") PdbsxDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map =  pubService.queryChayueWei(dto, pd);
			List ls = (List) map.get("rows");
			PdbsxDTO PdbsxDTO = null;
			if (ls != null && ls.size() > 0) {
				PdbsxDTO = (PdbsxDTO) ls.get(0);
			}
			map.put("data", PdbsxDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return pubService.queryChayueWei(dto, pd);
	}	
	
	/**
	 * 
	 * baoqingchuliIndex的中文名称：报请处理页面初始化
	 * 
	 * baoqingchuliIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/baoqingchuli")
	public void baoqingchuliIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
    /**
     * 保存 
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveBaoqingchulido(HttpServletRequest request, @Param("..") PdbsxDTO dto) {
    	Map<String, String> result = new HashMap<String, String>();
		try {		
			pubService.saveBaoqingchulido(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);//异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }
    
	/**
	 * 
	 * baoqingchulidoIndex的中文名称：报请处理页面
	 * 
	 * baoqingchulidoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/baoqingchulido")
	public void baoqingchulidoIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * queryCheckplan的中文名称：查询检查计划
	 * 
	 * queryCheckplan的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryCheckplan(@Param("..") BscheckplanDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.queryCheckplan(dto, pd);
	}	
	
	/**
	 * 
	 * newComUserRegIndex的中文名称：
	 * 
	 * newComUserRegIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/baseinfo/pcompany/newComUserReg")
	public void newComUserRegIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * queryComfeileiZTree的中文名称：企业分类树
	 * 
	 * queryComfeileiZTree的概要说明：
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryComfeileiZTree(HttpServletRequest request) {
		try {
			List comfeileiList = (List) pubService.queryComfeileiZTree(request);
			String comfeileiData = Json.toJson(comfeileiList, JsonFormat.compact());
			comfeileiData = comfeileiData.replace("isparent", "isParent");
			comfeileiData = comfeileiData.replace("isopen", "open");
			Map m = new HashMap();
			m.put("comfeileiData", comfeileiData);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}	
	
	/**
	 * 
	 * selectComfenleiIndex的中文名称：选择企业分类页面初始化
	 * 
	 * selectComfenleiIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectComfenlei")
	public void selectComfenleiIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 添加企业基本信息 完成的是注册功能
	 */
	@At
	@Ok("json")
	public Object savePcompanyReg(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pubService.savePcompanyReg(request, dto);
			String qyid = dto.getComid();
			if (qyid != null) {
				result.put("qyid", qyid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}
	
	/**
	 * 
	 * querySystcqZTreeAsyncPub的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySystcqZTreeAsyncPub的概要说明：异步加载（传入父节点ID）
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object querySystcqZTreeAsyncPub(HttpServletRequest request) {
		try {			
			List aaa027List = (List) sysorgService.querySystcqZTreeAsync(request);
			String aaa027Data = Json.toJson(aaa027List, JsonFormat.compact());
			aaa027Data = aaa027Data.replace("isparent", "isParent");
			aaa027Data = aaa027Data.replace("isopen", "open");
			Map m = new HashMap();
			m.put("aaa027Data", aaa027Data);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}	

	/**
	 * 
	 * queryJiBieCanShuZTree的中文名称：按Ztree插件格式构造 通用级别参数
	 * 
	 * queryJiBieCanShuZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJiBieCanShuZTree(HttpServletRequest request,@Param("..") Aa10DTO dto) {
		try {
			List newscateList = (List) pubService.queryJiBieCanShuZTree(request,dto);
			String mydata = Json.toJson(newscateList, JsonFormat.compact());
			mydata = mydata.replace("isparent", "isParent");
			mydata = mydata.replace("isopen", "open");
			Map m = new HashMap();
			m.put("mydata", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		} 
	}

	/**
	 *
	 * queryJiBieCanShuTree的中文名称：按easyui tree格式构造新闻分类树
	 *
	 * queryJiBieCanShuTree的概要说明:
	 *
	 * @return Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryJiBieCanShuTree(HttpServletRequest request,@Param("..") Aa10DTO dto){
		try {
			return pubService.queryJiBieCanShuTree(request,dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}
	
	/**
	 * 
	 * pjiBieCanShuIndex的中文名称：通用父子级别参数页面
	 * 
	 * pjiBieCanShuIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pjiBieCanShu")
	public void pjiBieCanShuIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * saveJiBieCanShu的中文名称：保存级别参数
	 * 
	 * saveJiBieCanShu的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveJiBieCanShu(@Param("..") Aa10DTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.saveJiBieCanShu(dto));
	}
	
	/**
	 * 
	 * delJiBieCanShu的中文名称：删除级别参数
	 * 
	 * delJiBieCanShu的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJiBieCanShu(@Param("..") Aa10DTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.delJiBieCanShu(dto));
	}

	@At
	@Ok("jsp:/jsp/pub/pub/pubParentChild")
	public void parentchildIndex(HttpServletRequest request){
		//通用父子关系表页面初始化
	}
	/**
	 *
	 * queryJiBieCanShuZTree的中文名称：按Ztree插件格式构造 通用级别参数
	 *
	 * queryJiBieCanShuZTree的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryParentchildZTree(HttpServletRequest request,@Param("..") PubParentChildDto dto) {
		try {
			List jyjcxmList = (List) pubService.queryParentchildZTree(request, dto);
			String mydata = Json.toJson(jyjcxmList, JsonFormat.compact());
			mydata = mydata.replace("isparent", "isParent");
			mydata = mydata.replace("isopen", "open");
			Map m = new HashMap();
			m.put("mydata", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	@At
	@Ok("json")
	public Object queryParentchildTree(HttpServletRequest request,@Param("..") PubParentChildDto dto){
		try {
			return pubService.queryParentchildTree(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	@At
	@Ok("json")
	public Object saveParentchild(@Param("..") PubParentChildDto dto) {
		return SysmanageUtil.execAjaxResult(pubService.saveParentchild(dto));
	}
	@At
	@Ok("json")
	public Object delParentchild(@Param("..") PubParentChildDto dto) {
		return SysmanageUtil.execAjaxResult(pubService.delParentchild(dto));
	}
	/**
	 * 
	 * querySelectShangpin的中文名称：查询商品信息
	 * 
	 * querySelectShangpin的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySelectShangpin(@Param("..") JyjcypDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.querySelectShangpin(dto, pd);
	}	
	
	/**
	 * 
	 * selectShangpinIndex的中文名称：选择商品
	 * 
	 * selectShangpinIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectShangpin")
	public void selectShangpinIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *
	 * selectShangpinIndex的中文名称：选择商品
	 *
	 * selectShangpinIndex的概要说明：
	 *
	 * @param request
	 *            Written by : gjf
	 *
	 */
	@At
	@Ok("jsp:/jsp1.0/pub/pub/selectShangpin")
	public void selectShangpinIndexEasyui(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * selectGongyingshangIndex的中文名称：选择供应商，生产商，经销商
	 * 
	 * selectGongyingshangIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectGongyingshang")
	public void selectGongyingshangIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * querySelectGongyingshang的中文名称：查询供应商
	 * 
	 * querySelectGongyingshang的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object querySelectGongyingshang(@Param("..") HjgztkhgxDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.querySelectGongyingshang(dto, pd);
	}	

	/**
	 * 
	 * selectJianGuanZhuTiIndex的中文名称：选择监管主体
	 * 
	 * selectJianGuanZhuTiIndex的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectJianGuanZhuTi")
	public void selectJianGuanZhuTiIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	/**
	 * 
	 * queryJianGuanZhuTi的中文名称：查询监管主体信息
	 * 
	 * queryJianGuanZhuTi的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryJianGuanZhuTi(@Param("..") HviewjgztDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return pubService.queryJianGuanZhuTi(dto, pd);
	}

	/**
	 * 用户注册功能（依据政融宝）
	 * @param request 访问请求
	 * @param dto 用户信息
	 * @return zy
	 */
	@At
	@Ok("json")
	public Object saveNetuserReg(HttpServletRequest request, @Param("..") SysuserDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pubService.saveNetuserReg(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}

	/**
	 * 用户找回密码功能（依据政融宝）
	 * @param request
	 * @param dto
	 * @return zy
	 */
	@At
	@Ok("json")
	public Object findpwtijiao(HttpServletRequest request, @Param("..") SysuserDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pubService.findpwtijiao(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}

	/**
	 * 用户重置密码功能（依据政融宝）
	 * @param request
	 * @param dto
	 * @return zy
	 */
	@At
	@Ok("json")
	public Object chongzhipw(HttpServletRequest request, @Param("..") SysuserDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pubService.chongzhipw(request, dto);
			return "已成功将密码重置为123456";
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
	}

	/**
	 *
	 * pubUploadFjList的中文名称：附件列表页面初始化
	 *
	 * pubUploadFjList的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pubUploadFjList")
	public void pubUploadFjListIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * pubUploadFjViewIndex的中文名称：删除附件页面
	 *
	 * pubUploadFjViewIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/pubUploadFjView")
	public void pubUploadFjViewIndex(HttpServletRequest request, @Param("..") UploadfjDTO dto)
			throws Exception {
		// 页面初始化
		List fjList = pubService.queryUploadFjList(request, dto);
		if (fjList != null && fjList.size() > 0) {
			request.setAttribute("fjList", fjList);
		} else {
			request.setAttribute("fjList", null);
		}
	}

	/**
	 *
	 * uploadFjViewIndex的中文名称：上传图片到服务器页面
	 *
	 * uploadFjViewIndex的概要说明：通用
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/uploadFjView")
	public void uploadFjViewIndex(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		// 页面初始化
	}
	/**
	 *
	 * uploadFjViewIndex的中文名称：上传图片到服务器页面
	 *
	 * uploadFjViewIndex的概要说明：通用
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp1.0/pub/pub/uploadFjView")
	public void uploadFjViewIndexEasyui(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		// 页面初始化
	}

	/**
	 *
	 * queryFjlist的中文名称：查询附件列表
	 *
	 * queryFjlist的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object queryFjlist(@Param("..") UploadfjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = pubService.queryFjlist(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * querySCFjListDetail的中文名称：单个附件类别已上传附件明细
	 *
	 * querySCFjListDetail的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object querySCFjListDetail(@Param("..") UploadfjDTO dto,
									  @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = pubService.querySCFjListDetail(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return pubService.querySCFjListDetail(dto, pd);
	}

	/**
	 *
	 * uploadFjsave的中文名称：上传附件【保存】
	 *
	 * uploadFjsave的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object uploadFjsave(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.uploadFjsave(request, dto));
	}

	/**
	 *
	 * uploadFjdel的中文名称：删除附件【保存】
	 *
	 * uploadFjdel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object uploadFjdel(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.uploadFjdel(request, dto));
	}

	/**
	 *
	 * getProductFjPicture的中文名称：单个附件类别已上传附件明细
	 *
	 * getProductFjPicture的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("json")
	public Object getProductFjPicture(HttpServletRequest request,@Param("..") UploadfjDTO dto)
			throws Exception {
		return pubService.getProductFjPicture(request,dto);
	}

	/**
	 *
	 * uploadFj的中文名称：上传附件到服务器
	 *
	 * uploadFj的概要说明：
	 *
	 * @param request
	 * @return Written by : zjf
	 */
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(pubService.uploadFj(request));
	}

	/**
	 *
	 * uploadCszp的中文名称：上传厨师照片
	 *
	 * uploadCszp的概要说明：
	 *
	 * @param request
	 * @return Written by : zjf
	 */
	@At
	@Ok("json")
	public Object uploadCszp(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(pubService.uploadCszp(request));
	}

	/**
	 *
	 * saveFj的中文名称：上传图片附件到服务器后【保存记录到附件表】
	 *
	 * saveFj的概要说明：通用
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object saveFj(HttpServletRequest request, @Param("..") FjDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.saveFj(request, dto));
	}

	/**
	 *
	 * queryFjViewList的中文名称：查询附件表【fj】
	 *
	 * queryFjViewList的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryFjViewList(HttpServletRequest request, @Param("..") FjDTO dto) {
		Map map = new HashMap();
		try {
			List fjList = null;
			fjList = pubService.queryFjViewList(request, dto);
			map.put("data", fjList);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryFjViewMap的中文名称：查询附件表【fj】
	 *
	 * queryFjViewMap的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	@At
	@Ok("json")
	public Object queryFjViewMap(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		return pubService.queryFjViewMap(request, dto);
	}

	/**
	 *
	 * delFjViewIndex的中文名称：删除图片附件页面
	 *
	 * delFjViewIndex的概要说明：通用
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/delFjView")
	public void delFjViewIndex(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		// 页面初始化
		String str=request.getParameter("url");
		List fjList = pubService.queryFjViewList(request, dto);
		if (fjList != null && fjList.size() > 0) {
			request.setAttribute("fjList", fjList);
		} else {
			request.setAttribute("fjList", null);
			request.setAttribute("url", str);
		}
	}
	/**
	 *
	 * delFjViewIndex的中文名称：删除图片附件页面
	 *
	 * delFjViewIndex的概要说明：通用
	 *
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp1.0/pub/pub/delFjView")
	public void delFjViewIndexEasyui(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		// 页面初始化
		List fjList = pubService.queryFjViewList(request, dto);
		if (fjList != null && fjList.size() > 0) {
			request.setAttribute("fjList", fjList);
		} else {
			request.setAttribute("fjList", null);
		}
	}

	/**
	 *
	 * delFjVideoIndex的中文名称：删除视频附件页面
	 *
	 * delFjVideoIndex的概要说明：通用
	 *
	 * @param request
	 *            Written by : gjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/delFjVideo")
	public void delFjVideoIndex(HttpServletRequest request, @Param("..") FjDTO dto) throws Exception {
		// 页面初始化
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
		return SysmanageUtil.execAjaxResult(pubService.delFj(request, dto));
	}

	/**
	 *
	 * saveFjWuzhuti的中文名称：上传图片附件到服务器后【保存记录到附件表】 无主体
	 *
	 * saveFjWuzhuti的概要说明：通用
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object saveFjWuzhuti(HttpServletRequest request,@Param("..") FjDTO dto) {
		return SysmanageUtil.execAjaxResult(pubService.saveFjWuzhuti(request,dto));
	}

	@At
	@Ok("json")
	public Object queryCount(HttpServletRequest request,@Param("flag") String flag) {
		Map mapc = new HashMap();
		try {
			String count = "0";
			if("11".equals(flag)||"12".equals(flag)||"13".equals(flag)){
				return SysmanageUtil.execAjaxResult(pubService.queryMapCount(request,flag),null);
			}else{
				count = pubService.queryCount(request, flag);
				mapc.put("count",count);
			}

			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	@At
	@Ok("json")
	public Object queryCount1(HttpServletRequest request,@Param("flag") String flag) {
		Map mapc = new HashMap();
		try {
			String count = "0";
			if("11".equals(flag)||"12".equals(flag)||"13".equals(flag)){
				mapc = pubService.queryMapCount1(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else{
				count = pubService.queryCount(request, flag);
				mapc.put("count",count);
			}

			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	@At
	@Ok("json")
	public Object queryCount2(HttpServletRequest request,@Param("flag") String flag) {
		Map mapc = new HashMap();
		try {
			String count = "0";
			if("食品生产".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("食品流通".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("餐饮服务".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("药品".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("化妆品".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("保健品".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("医疗器械".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else if("小作坊".equals(flag)){
				mapc = pubService.queryMapCount2(request, flag);
				return SysmanageUtil.execAjaxResult(mapc, null);
			}else {
				count = pubService.queryCount(request, flag);
				mapc.put("count",count);
			}

			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}

	/**
	 *
	 * selectcomIndex的中文名称：选择任务页面
	 * selectcomIndex的概要描述：
	 * @param request
	 * written  by ： zy
	 */
	@At
	@Ok("jsp:/jsp/pub/pub/selectajdjid")
	public void selectajdjidIndex(HttpServletRequest request) {
		// 页面初始化
	}
}
