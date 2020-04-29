package com.askj.supervision.module;

import java.util.ArrayList;
import java.util.Date;
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
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.BschecklhfjDTO;
import com.askj.supervision.dto.util.EchartData;
import com.askj.supervision.dto.util.Label;
import com.askj.supervision.dto.util.Normal;
import com.askj.supervision.dto.util.Series;
import com.zzhdsoft.siweb.entity.Aa10;
import com.askj.supervision.service.CheckHandlerService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 检查结果报表类
 * @author tmm
 *
 */
@IocBean
@At("/supervision/checkPalnresultReport/")
public class CheckPalnResultReportModule {
	protected final Logger logger = Logger.getLogger(CheckPalnResultReportModule.class);
	@Inject
	private CheckHandlerService checkHandlerService;

	/**
	 * 
	 * toreportindex的中文名称：检查结果统计页面
	 * 
	 * toreportindex的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/report/reportPlan.jsp")
	public void toreportindex(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		
	}
	
	/**
	 * 
	 * getEcharts的中文名称：获取检查结果统计表
	 * 
	 * getEcharts的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getEcharts(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto ) {
		// 页面初始化
		List<String> legends = new ArrayList<String>();
		List<Series> seriesList = new ArrayList<Series>();
		Map map = new HashMap();
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		if(dto.getYear()==null||"".equals(dto.getYear())){
			dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		}
		if(dto.getComdalei()==null||"".equals(dto.getComdalei())){
			dto.setComdalei("SPSC");
		}
		try {
			//获取食品大类
			List<Aa10> comdaleis = checkHandlerService.getAa10ListByaaa101("comdalei", dto.getComdalei());//数组
			List<String> categoryList = checkHandlerService.querya207Strlist(request, dto);//
			
			for(Aa10 aa10 : comdaleis){
				legends.add(aa10.getAaa103());
				dto.setComdalei(aa10.getAaa102());
				List<Integer> serieslist = checkHandlerService.queryPcomPlanResultNumBycomdalei(request, dto);//
				Series series = new Series(aa10.getAaa103(), "bar", serieslist,new Label(new Normal(true, "top")));
				seriesList.add(series);
			}
			
			EchartData echarts = new EchartData(legends, categoryList,  seriesList);
			map.put("data", echarts);
			map.put("year", String.valueOf(DateUtil.convertDateToYear(new Date())));
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getAAa027list的中文名称：
	 * 
	 * getAAa027list的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("json")
	public Object getAAa027list(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto ) {
		// 页面初始化
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		if(dto.getYear()==null||"".equals(dto.getYear())){
			dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		}
					
		Map map = new HashMap();
		try {
			map=checkHandlerService.queryaaa207list(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		
	}
	
	/**
	 * 
	 * areaReportindex的中文名称：区域检查统计
	 * 
	 * areaReportindex的概要说明：
	 * 
	 * @param request
	 *          
	 * 
	 */
	@At
	@Ok("jsp:/jsp/supervision/report/areaReportPlan.jsp")
	public void areaReportindex(HttpServletRequest request,@Param("..") BsCheckMasterDTO dto) {
		
	}
	
	/**
	 * 
	 * getAreaReportPlanEcharts的中文名称：获取区域检查统计结果
	 * 
	 * getAreaReportPlanEcharts的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getAreaReportPlanEcharts(HttpServletRequest request, @Param("..") BschecklhfjDTO dto ) {
		// 页面初始化
		List<String> legends = new ArrayList<String>();
		legends.add("应检查次数");
		legends.add("还应检查次数");
		List<Series> seriesList = new ArrayList<Series>();
		Map map = new HashMap();
		if (dto.getCheckyear() == null || "".equals(dto.getCheckyear())) {
			dto.setCheckyear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		}
		try {
			List<BschecklhfjDTO> list = checkHandlerService.queryLhfjtj(request, dto); // 查询结果
			List<Integer> seriesList1 = new ArrayList<Integer>(); // 应检查次数
			List<Integer> seriesList2 = new ArrayList<Integer>(); // 还应检查次数
			List<String> categoryList = new ArrayList<String>(); // 统筹区
			for (int i = 0; i < list.size(); i++) {
				BschecklhfjDTO v_dto = list.get(i);
				seriesList1.add(Integer.parseInt(v_dto.getLhfjpdndyjccs())); // 应检查次数
				seriesList2.add(Integer.parseInt(v_dto.getHyjccs())); // 还应检查次数
				categoryList.add(v_dto.getAaa027str()); // 统筹区
			}
			Series series1 = new Series("应检查次数", "bar", seriesList1, new Label(new Normal(true, "top")));
			Series series2 = new Series("还应检查次数", "bar", seriesList2, new Label(new Normal(true, "top")));
			seriesList.add(series1);
			seriesList.add(series2);
			
			EchartData echarts = new EchartData(legends, categoryList,  seriesList);
			map.put("data", echarts);
			map.put("year", String.valueOf(DateUtil.convertDateToYear(new Date())));
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
}
