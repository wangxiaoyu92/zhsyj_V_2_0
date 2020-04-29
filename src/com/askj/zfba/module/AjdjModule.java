package com.askj.zfba.module;

import java.util.ArrayList;
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

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.pubkeyDTO;
import com.askj.supervision.dto.util.EchartData;
import com.askj.supervision.dto.util.Label;
import com.askj.supervision.dto.util.Normal;
import com.askj.supervision.dto.util.Series;
import com.askj.baseinfo.dto.ViewzfryDTO;
import com.askj.zfba.dto.ZfajcbrDTO;
import com.askj.zfba.dto.ZfajdjDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.askj.zfba.service.AjdjService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * AjdjModule的中文名称：案件登记管理
 * 
 * AjdjModule的描述：
 * 
 * Written by : zjf
 */
@At("/zfba/ajdj")
@IocBean
public class AjdjModule {
	
	protected final Logger logger = Logger.getLogger(AjdjModule.class);
	
	@Inject
	protected AjdjService ajdjService;

	/**
	 * 
	 * ajdjCbrFormIndex的中文名称：案件登记选择承办人
	 * ajdjCbrFormIndex的概要描述：判断是否已经存在案件承办人，如果存在就
	 * 显示，也可以进行选择，不存在便进行选择
	 * @param request
	 * written  by ： lfy
	 */
	@At
	@Ok("jsp:/jsp/zfba/ajdjCbrForm")
	public void ajdjCbrFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * ajdjMain的中文名称：案件登记页面初始化
	 * 
	 * ajdjMainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zfba/ajdjMain")
	public void ajdjMainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * ajdjForm的中文名称：案件登记
	 * 
	 * ajdjFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zfba/ajdjForm")
	public void ajdjFormIndex(HttpServletRequest request) {
		// 页面初始化
	}	

	/**
	 * 
	 * queryAjdj的中文名称：查询案件登记记录
	 * 
	 * queryAjdj的概要说明：
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
	public Object queryAjdj(@Param("..") ZfajdjDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = ajdjService.queryAjdj(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryAjdjObj的中文名称：查询案件登记obj
	 * 
	 * queryAjdjObj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Object queryAjdjObj(String prm_ajdjid) throws Exception {
		return ajdjService.queryAjdjObj(prm_ajdjid);
	}	
	
	/**
	 * 
	 * saveAjdj的中文名称：保存案件登记
	 * 
	 * saveAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveAjdj(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto)throws Exception {
		return SysmanageUtil.execAjaxResult(ajdjService.saveAjdj(request,
				dto));
	}	
	
	/**
	 * 
	 * delAjdj的中文名称：删除案件登记信息
	 * 
	 * delAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delAjdj(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto) {
		return SysmanageUtil.execAjaxResult(ajdjService.delAjdj(request,
				dto));
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
	@SuppressWarnings({ "rawtypes", "unchecked"})
	public Object queryAjdjDTO(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = ajdjService.queryAjdj(dto, pd);
			List ls = (List) map.get("rows");
			ZfajdjDTO zfajdjDTO = null;
			if (ls != null && ls.size() > 0) {
				zfajdjDTO = (ZfajdjDTO) ls.get(0);
			}
			map.put("data", zfajdjDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryAjcbr的中文名称：查询案件承办人
	 * queryAjcbr的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by ： lfy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked"})
	public Object queryAjcbr(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			ZfajdjDTO zfajdjDTO = null;
			zfajdjDTO = (ZfajdjDTO) ajdjService.queryAjcbr(request,dto);
			map.put("data", zfajdjDTO);
			return  SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return  SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveAjcbr的中文名称：删除保存案件承办人
	 * saveAjcbr的概要描述：
	 * @param request
	 * @param dto
	 * @return
	 * written  by ： lfy
	 */
	@At
	@Ok("json")
	public Object saveAjcbr(HttpServletRequest request,
			@Param("..") ZfajdjDTO dto) {
		
		return SysmanageUtil.execAjaxResult(ajdjService.saveAjcbr(request,
				dto));
	}	
	
	/**
	 * 
	 * ajbllogMainIndex的中文名称：案件办理日志
	 * 
	 * ajbllogMainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/zfba/ajbllogMain")
	public void ajbllogMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * xzcbrIndex的中文名称：承办人选择页面
	 * xzcbrIndex的概要描述：
	 * @param request
	 * written  by ： lfy
	 */
	@At
	@Ok("jsp:/jsp/zfba/xzcbr")
	public void xzcbrIndex(HttpServletRequest request) {
		// 页面初始化
	}	
	
	 /**
	  * 
	  * queryViewzfry的中文名称：查询执法人员视图信息
	  * queryViewzfry的概要描述：
	  * @param dto
	  * @param pd
	  * @return
	  * @throws Exception
	  * written  by ： lfy
	  */
	@At
	@Ok("json")
	public Object queryViewzfry(@Param("..") ViewzfryDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		return ajdjService.queryViewzfry(dto, pd);
	}	
	
	/**
	 * 
	 * queryAjdjCbr的中文名称：查询案件登记承办人
	 * 
	 * queryAjdjCbr的概要说明：
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
	public Object queryAjdjCbr(@Param("..") ZfajcbrDTO dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = ajdjService.queryAjdjCbr(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * queryAjdjCbr的中文名称：查询案件登记承办人
	 *
	 * queryAjdjCbr的概要说明：
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
	public Object queryAjdjCbrMiaoshu(@Param("..") ZfajcbrDTO dto,
							   @Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			String v_zfryxm = ajdjService.queryAjdjCbrMiaoshu(dto, pd);
			map.put("ajcbr",v_zfryxm);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
    /**
     * 保存案件登记承办人
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveAjdjCbr(HttpServletRequest request, @Param("..") ZfajcbrDTO dto) {
		return SysmanageUtil.execAjaxResult(ajdjService.saveAjdjCbr(request, dto));//无异常信息返回
    }
    
    /**
     * 
     * zfbafxtjMainIndex的中文名称：执法办案案件分析统计
     * 
     * zfbafxtjMainIndex的概要说明：
     * @param request
     *        Written by : zy
     */
    @At
	@Ok("jsp:/jsp/zfba/zfbafxtjMain")
	public void zfbafxtjMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
    
    /**
	 * 
	 * ajdjtjCount中文名称:案件登记统计
	 * ajdjtjCount概要描述:
	 * written by  :  zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object ajdjtjCount(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = ajdjService.queryAjdjtjCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
	 * 
	 * ajdjtjByDaleiCount中文名称:案件登记统计
	 * ajdjtjByDaleiCount概要描述:根据案件登记大类分类
	 * written by  :  zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object ajdjtjByDaleiCount(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = ajdjService.ajdjtjByDaleiCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
	 * 
	 * ajdjtjByComDaleiCount的中文名称：案件登记统计
	 * 
	 * ajdjtjByComDaleiCount的概要说明：根据企业大类统计
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object ajdjtjByComDaleiCount(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = ajdjService.ajdjtjByComDaleiCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
	 * 
	 * ajdjtjByComDaleiCount的中文名称：案件登记统计
	 * 
	 * ajdjtjByComDaleiCount的概要说明：根据统筹区统计
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object ajdjtjByAaa027Count(HttpServletRequest request,
			@Param("..") pubkeyDTO dto) throws Exception {
		Map mapc = new HashMap();
		try {
			mapc = ajdjService.ajdjtjByAaa027Count(request, dto); 
			return SysmanageUtil.execAjaxResult(mapc,null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	
	/**
     * 
     * zfajReportIndex的中文名称：执法办案分析统计
     * 
     * zfajReportIndex的概要说明：
     * @param request
     *        Written by : zy
     */
    @At
	@Ok("jsp:/jsp/zfba/report/zfajReport")
	public void zfajReportIndex(HttpServletRequest request) {
		// 页面初始化
	}
    
    /**
     * 
     * getEcharts的中文名称：获取图标数据
     * 
     * getEcharts的概要说明：
     * @param request
     *        Written by : zy
     */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getEcharts(HttpServletRequest request,@Param("..") ZfajdjDTO dto ) {
		// 页面初始化
		List<String> legends = new ArrayList<String>();
		List<Series> seriesList = new ArrayList<Series>(); // 纵坐标显示内容（案件统计情况）
		Map map = new HashMap();
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		try {
			// 获取案件大类
			List<Aa10> ajdls = ajdjService.getAa10List("aae140"); // 
			// 横坐标显示内容（统筹区划分）
			List<String> categoryList = ajdjService.queryaaa207Strlist(request, dto);
		
			for(Aa10 aa10 : ajdls){
				legends.add(aa10.getAaa103()); // 案件大类
				dto.setAae140(aa10.getAaa102()); // 案件统筹区 
				List<Integer> serieslist = ajdjService.queryZfajNumByAaa027(request, dto); // 案件登记数
				Series series = new Series(aa10.getAaa103(), "bar", 
						serieslist, new Label(new Normal(true, "top")));
				seriesList.add(series);
			}
			EchartData echarts = new EchartData(legends, categoryList,  seriesList);
			map.put("data", echarts);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

}
