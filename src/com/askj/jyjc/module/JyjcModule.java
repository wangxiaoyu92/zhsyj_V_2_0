package com.askj.jyjc.module;


import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.jyjc.dto.*;
import com.askj.jyjc.service.JyjcService;
import com.askj.supervision.dto.pubkeyDTO;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.util.ExcelUtil;
import com.lbs.leaf.validate.ValidateData;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysoperatelogDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.*;
import org.nutz.mvc.upload.UploadAdaptor;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.util.*;

/**
 * JyjcModule的中文名称：检验检测控制层（包括检验检测项目、检验检测样品、检验检测结果）
 * <p/>
 * JyjcModule的描述
 * <p/>
 * Written by CatchU 2016年5月5日上午9:48:02
 */
@IocBean
@At("/jyjc")
@Fail("jsp:/jsp/error/error")
public class JyjcModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(JyjcModule.class);

	//注入
	@Inject
	protected JyjcService jyjcService;

	/************************检验检测项目start****************************/

	/**
	 * jyjcxmIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcxmIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcxmOld")
	public void jyjcxmIndex(HttpServletRequest request) {
		//检验检测项目页面初始化
	}

	/**
	 * jycjcpflIndex的中文名称:抽检实施细则产品分类页面初始化
	 * <p/>
	 * jycjcpflIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jycjcpfl")
	public void jycjcpflIndex(HttpServletRequest request) {
		//检验检测项目页面初始化
	}

	/**
	 * jycjssxzIndex的中文名称:抽检实施细则管理页面初始化
	 * <p/>
	 * jycjssxzIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jycjssxz")
	public void jycjssxzIndex(HttpServletRequest request) {
		//抽检实施细则管理页面初始化
	}

	/**
	 * jycjssxzFormIndex的中文名称:抽检实施细则管理表单页面初始化
	 * <p/>
	 * jycjssxzFormIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jycjssxzForm")
	public void jycjssxzFormIndex(HttpServletRequest request) {
		//抽检实施细则管理页面初始化
	}

	/**
	 * jycjssxzFormIndex的中文名称:抽检实施细则管理表单页面初始化
	 * <p/>
	 * jycjssxzFormIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/hjyjcmxbForm")
	public void hjyjcmxbForm(HttpServletRequest request) {
		//抽检实施细则管理页面初始化
	}

	/**
	 * jyjcxmIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcxmIndex的概要说明:
	 *
	 * @param request Written by wxy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcxm")
	public void jyjcxmIndex2(HttpServletRequest request) {
		//检验检测项目页面初始化
	}

	/**
	 * jyjcxmIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcxmIndex的概要说明:
	 *
	 * @param request Written by wxy 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcjcbzb")
	public void jyjcjcbzbIndex(HttpServletRequest request) {
		//'检验检测检测标准页面初始化
	}

	/**
	 * queryJiBieCanShuZTree的中文名称：按Ztree插件格式构造 通用级别参数
	 * <p/>
	 * queryJiBieCanShuZTree的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception Written by : gjf
	 */
	@At
	@Ok("json")
	public Object queryJyjcxmZTree(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		try {
			List jyjcxmList = (List) jyjcService.queryJyjcxmZTree(request, dto);
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
	public Object querySystcqZTree(HttpServletRequest request) {
		try {
			List jyjcxmList = (List) jyjcService.querySystcqZTree(request);
			String mydata = Json.toJson(jyjcxmList, JsonFormat.compact());
			Map m = new HashMap();
			m.put("aaa027Data", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	@At
	@Ok("json")
	public Object querySystcqJxmZTree(HttpServletRequest request) {
		try {
			List jyjcxmList = (List) jyjcService.querySystcqJxmZTree(request);
			String mydata = Json.toJson(jyjcxmList, JsonFormat.compact());
			Map m = new HashMap();
			m.put("aaa027Data", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}


	@At
	@Ok("json")
	public Object queryJyjcxmTree(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		try {
			return jyjcService.queryJyjcxmTree(request, dto);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	@At
	@Ok("json")
	public Object saveJyjcxm2(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcxm2(request, dto));
	}

	@At
	@Ok("json")
	public Object savejycjssxz(HttpServletRequest request, @Param("..") JycjssxzDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.savejycjssxz(request, dto));
	}

	@At
	@Ok("json")
	public Object delJyjcxm2(@Param("..") JyjcxmDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcxm2(dto));
	}

	/**
	 * jyjcxmFormIndex的中文名称:检验检测详情页面初始化
	 * <p/>
	 * jyjcxmFormIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日下午12:02:05
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcxmForm")
	public void jyjcxmFormIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * cjrwFormIndex的中文名称:抽检任务详情页面初始化
	 * <p/>
	 * cjrwFormIndex的概要说明:
	 *
	 * @param request Written by wxy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/cjrwForm")
	public void cjrwFormIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * queryCjrw:查询所有抽检任务并分页
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryCjrw(HttpServletRequest request, @Param("..") JyjccjrwbDTO dto,
							@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryCjrw(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询检验检测标准
	 *
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@At
	@Ok("json")
	public Object queryCjrwDTO(HttpServletRequest request, @Param("..") JyjccjrwbDTO dto,
							   @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryCjrw(request, dto, pd);
			List list = (List) map.get("rows");
			JyjccjrwbDTO cjrwDto = null;
			if (list != null && list.size() > 0) {
				cjrwDto = (JyjccjrwbDTO) list.get(0);
			}
			map.put("data", cjrwDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询抽检实施细则
	 *
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@At
	@Ok("json")
	public Object queryjycjssxzDTO(HttpServletRequest request, @Param("..") JycjssxzDTO dto,
								   @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryjycjssxz(request, dto, pd);
			List list = (List) map.get("rows");
			JycjssxzDTO cjrwDto = null;
			if (list != null && list.size() > 0) {
				cjrwDto = (JycjssxzDTO) list.get(0);
				if (cjrwDto.getJyxmdesc() != null && !"".equals(cjrwDto.getJyxmdesc())) {
					String s = jyjcService.queryjycjssxzDesc(request, cjrwDto);
					String s2 = jyjcService.queryjycjssxzDescnew(request, cjrwDto);
					map.put("jcxmdesc", s);
					map.put("jcxmmc", s2);
				}
			}
			map.put("data", cjrwDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveCjrw:保存抽检任务
	 *
	 * @param request
	 * @param dto
	 * @return Written by wxy
	 */
	@At
	@Ok("json")
	public Object saveCjrw(HttpServletRequest request, @Param("..") JyjccjrwbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveCjrw(request, dto));
	}

	/**
	 * saveCjrw:处理抽检任务
	 *
	 * @param request
	 * @param dto
	 * @return Written by wxy
	 */
	@At
	@Ok("json")
	public Object handleCjrw(HttpServletRequest request, @Param("..") JyjccjrwbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.handleCjrw(request, dto));
	}

	/**
	 * queryJyjcjcbzb:查询所有检验检测检验标准并分页
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delCjrw(HttpServletRequest request, @Param("..") JyjccjrwbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delCjrw(request, dto));
	}

	@At
	@Ok("json")
	public Object queryJyjcjcbzb(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto,
								 @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcjcbzb(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询安全监督抽检实施细则并分页
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryjycjssxz(HttpServletRequest request, @Param("..") JycjssxzDTO dto,
								@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryjycjssxz(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveJyjcbz:保存检验检测标准
	 *
	 * @param request
	 * @param dto
	 * @return Written by wxy
	 */
	@At
	@Ok("json")
	public Object saveJyjcbz(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcbz(request, dto));
	}

	/**
	 * delJyjcbz的中文名称:删除检验检测标准
	 * <p/>
	 * delJyjcbz的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return Written by Wxy
	 */
	@At
	@Ok("json")
	public Object delJyjcbz(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcbz(request, dto));
	}

	/**
	 * 查询检验检测标准
	 *
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@At
	@Ok("json")
	public Object queryJyjcjcbzbDTO(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto,
									@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcjcbzb(request, dto, pd);
			List list = (List) map.get("rows");
			JyjcjcbzbDTO jcbzDto = null;
			if (list != null && list.size() > 0) {
				jcbzDto = (JyjcjcbzbDTO) list.get(0);
			}
			map.put("data", jcbzDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 跳转到检验检测标准页面详情
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcbzForm")
	public void jyjcbzFormIndex(HttpServletRequest request) {
		// 用于页面跳转
	}

	/**
	 * queryJyjcxm的中文名称:查询检验检测项目并分页
	 * <p/>
	 * queryJyjcxm的概要说明:
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by CatchU 2016年5月5日下午12:01:41
	 */
	@At
	@Ok("json")
	public Object queryJyjcxm(@Param("..") JyjcxmDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcxm(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * queryJyjcxmDTO的中文名称:查询检验检测项目DTO
	 * <p/>
	 * queryJyjcxmDTO的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by CatchU 2016年5月5日下午1:15:30
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjcxmDTO(HttpServletRequest request,
								 @Param("..") JyjcxmDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcxm(dto, pd);
			List list = (List) map.get("rows");
			JyjcxmDTO jcxmDto = null;
			if (list != null && list.size() > 0) {
				jcxmDto = (JyjcxmDTO) list.get(0);
			}
			map.put("data", jcxmDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveJyjcxm的中文名称:保存检验检测项目
	 * <p/>
	 * saveJyjcxm的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return Written by CatchU 2016年5月5日下午1:16:37
	 */
	@At
	@Ok("json")
	public Object saveJyjcxm(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcxm(request, dto));
	}

	/**
	 * delJyjcxm的中文名称:删除检验检测项目
	 * <p/>
	 * delJyjcxm的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return Written by CatchU 2016年5月5日下午1:17:06
	 */
	@At
	@Ok("json")
	public Object delJyjcxm(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcxm(request, dto));
	}

	/**
	 * *********************检验检测项目end***************************
	 */


	@At
	@Ok("json")
	public Object delJycjssxz(HttpServletRequest request, @Param("..") JycjssxzDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJycjssxz(request, dto));
	}


	/*******检验检测结果start***************/
	/**
	 * jyjcjgIndex的中文名称：检验检测结果初始化页面
	 * jyjcjgIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcjg")
	public void jyjcjgIndex(HttpServletRequest request) {
		//检验检测结果页面初始化
	}

	/**
	 * queryJyjcjg的中文名称：查询检验检测结果
	 * queryJyjcjg的概要描述：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by : lfy
	 */
	@At
	@Ok("json")
	public Object queryJyjcjg(@Param("..") JyjcjgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcjg(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jyjcjgFormIndex的中文名称：检验检测结果添加界面
	 * jyjcjgFormIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcjgForm")
	public void jyjcjgFormIndex(HttpServletRequest request) {
		//检验检测结果页面初始化
	}

	/**
	 * saveJyjcjg的中文名称：添加检验检测结果
	 * saveJyjcjg的概要描述：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : lfy
	 */
	@At
	@Ok("json")
	public Object saveJyjcjg(HttpServletRequest request, @Param("..") JyjcjgDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcjg(request, dto));
	}

	/**
	 * delJyjcjg的中文名称：删除检验检测结果
	 * delJyjcjg的概要描述：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : lfy
	 */
	@At
	@Ok("json")
	public Object delJyjcjg(HttpServletRequest request, @Param("..") JyjcjgDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcjg(request, dto));
	}

	/**
	 * queryJyjcjgDTO的中文名称：查询检验检测结果
	 * queryJyjcjgDTO的概要描述：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by : lfy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjcjgDTO(HttpServletRequest request,
								 @Param("..") JyjcjgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcjg(dto, pd);
			List list = (List) map.get("rows");
			JyjcjgDTO jcjgDto = null;
			if (list != null && list.size() > 0) {
				jcjgDto = (JyjcjgDTO) list.get(0);
			}
			map.put("data", jcjgDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/*******检验检测结果end***************/
	/***********************检验检测结果审核start*************************/
	/**
	 * jyjcjgshIndex的中文名称：检验检测审核
	 * jyjcjgshIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcjgsh")
	public void jyjcjgshIndex(HttpServletRequest request) {
		//检验检测结果页面初始化
	}

	/**
	 * jyjcjgshFormIndex的中文名称：审核处理
	 * jyjcjgshFormIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcjgshForm")
	public void jyjcjgshFormIndex(HttpServletRequest request) {
		//检验检测结果页面初始化
	}

	/**
	 * jyjcsjcxIndex的中文名称：检验检测数据查询
	 * jyjcsjcxIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcsjcx")
	public void jyjcsjcxIndex(HttpServletRequest request) {
		//检验检测结果页面初始化
	}


	/***********************检验检测结果审核end**************************/


	/********检验检测品种start*********/
	/**
	 * jyjcpzIndex的中文名称：检验检测品种
	 * jyjcpzIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcpz")
	public void jyjcpzIndex(HttpServletRequest request) {
		//检验检测品种页面初始化
	}

	/**
	 * queryJyjcpzDTO的中文名称：查询检验检测品种
	 * queryJyjcpzDTO的概要描述：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by : lfy
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes"})
	public Object queryJyjcpzDTO(HttpServletRequest request,
								 @Param("..") JyjcypDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcyp(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jyjcpzFormIndex的中文名称：检验检测品种根据品种名称查询
	 * jyjcpzFormIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcpzForm")
	public void jyjcpzFormIndex(HttpServletRequest request) {
		//检验检测品种页面初始化
	}


	/********检验检测品种end*********/

	/************************检验检测样品start****************************/

	/**
	 * jyjcypIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcypIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcyp")
	public void jyjcypIndex(HttpServletRequest request) {
		//检验检测样品页面初始化
	}

	/**
	 * jyjcypFormIndex的中文名称:检验检测详情页面初始化
	 * <p/>
	 * jyjcypFormIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日下午12:02:05
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcypForm")
	public void jyjcypFormIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}
	/**
	 * jyjcypFormIndex的中文名称:检验检测详情页面初始化
	 * <p/>
	 * jyjcypFormIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日下午12:02:05
	 */
	@At
	@Ok("jsp:/jsp1.0/jyjc/jyjcypForm")
	public void jyjcypFormIndexEasyui(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * queryJyjcyp的中文名称:查询检验检测样品并分页
	 * <p/>
	 * queryJyjcyp的概要说明:
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by CatchU 2016年5月5日下午12:01:41
	 */
	@At
	@Ok("json")
	public Object queryJyjcyp(HttpServletRequest request,
							  @Param("..") JyjcypDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcyp(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * queryJyjcypDTO的中文名称:查询检验检测样品DTO
	 * <p/>
	 * queryJyjcypDTO的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by CatchU 2016年5月5日下午1:15:30
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjcypDTO(HttpServletRequest request,
								 @Param("..") JyjcypDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcyp(request, dto, pd);
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				map.put("data", list.get(0));
			}
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveJyjcyp的中文名称:保存检验检测样品
	 * <p/>
	 * saveJyjcyp的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return Written by CatchU 2016年5月5日下午1:16:37
	 */
	@At
	@Ok("json")
	public Object saveJyjcyp(HttpServletRequest request, @Param("..") JyjcypDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcyp(request, dto));
	}

	/**
	 * uploadJyjcypTp的中文名称:上传检验检测样品图片
	 * <p/>
	 * uploadJyjcypTp的概要说明:
	 *
	 * @param request
	 * @return Written by zy
	 */
	@At
	@Ok("json")
	public Object uploadJyjcypTp(HttpServletRequest request) {
		return SysmanageUtil.execAjaxResult(jyjcService.uploadJyjcypTp(request));
	}

	/**
	 * delJyjcyp的中文名称:删除检验检测样品
	 * <p/>
	 * delJyjcyp的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return Written by CatchU 2016年5月5日下午1:17:06
	 */
	@At
	@Ok("json")
	public Object delJyjcyp(HttpServletRequest request, @Param("..") JyjcypDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcyp(request, dto));
	}

	public Object uploadTpSave() {
		return null;
	}
	/************************检验检测样品end****************************/

	/************************检验检测统计图表start****************************/

	/**
	 * jyjctjtbIndex的中文名称:检验检测统计图表页面初始化
	 * <p/>
	 * jyjctjtbIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月12日上午10:07:29
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjctjtb")
	public void jyjctjtbIndex(HttpServletRequest request) {
		//检验检测统计图表页面初始化
	}

	/**
	 * queryJyjctjtb的中文名称:查询检验检测统计图表
	 * <p/>
	 * queryJyjctjtb的概要说明:
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception Written by CatchU 2016年5月12日上午10:49:29
	 */
	@At
	@Ok("json")
	public Object queryJyjctjtb(HttpServletRequest request, @Param("..") JyjctjtbDTO dto) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjctjtb(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/************************检验检测统计图表end****************************/


	/************************检验检测统计分析start****************************/

	/**
	 * jyjcfxIndex的中文名称：检验检测统计分析初始化页面
	 * jyjcfxIndex的概要说明：
	 *
	 * @param request Written by:ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjctjfx")
	public void jyjctjfxIndex(HttpServletRequest request) {
		//检验检测结果页面初始化	
	}

	/**
	 * queryJyjctjfx的中文名称：查询统计分析
	 * queryJyjctjfx的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception Written by:ly
	 */
	@At
	@Ok("json")
	public Object queryJyjctjfx(@Param("..") JyjctjfxDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjctjfx(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/************************检验检测统计分析end****************************/

	/************************检验检测单位start****************************/
	/**
	 * jyjcCompanyIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcCompanyIndex的概要说明:
	 *
	 * @param request Written by zy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccompany")
	public void jyjcCompanyIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * 查询检验检测单位信息并分页显示
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJyjcCompany(HttpServletRequest request, @Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcCompany(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jyjccompanyjcjgIndex的中文名称：企业检验检测结果页面
	 * jyjccompanyjcjgIndex的概要描述：
	 *
	 * @param request Written by : lfy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccompanyjcjg")
	public void jyjccompanyjcjgIndex(HttpServletRequest request) {
		// 企业检验检测结果页面
	}

	/************************检验检测单位end****************************/
	/**
	 * jyjccydjIndex的中文名称:检验检测抽样登记页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccydj")
	public void jyjccydjIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * jyjccydjFormIndex的中文名称:检验检测抽样登记增加修改页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccydjForm")
	public void jyjccydjFormIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * queryJyjccydj的中文名称:查询检验检测抽样登记
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjccydj(@Param("..") JyjccydjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjccydj(dto, pd);
			JyjccydjDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (JyjccydjDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveJyjccydj ：保存
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object saveJyjccydj(HttpServletRequest request, @Param("..") JyjccydjDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.saveJyjccydj(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * @return
	 */
	@At
	@Ok("json")
	public Object deljyjccydj(String id) {
		return SysmanageUtil.execAjaxResult(jyjcService.deljyjccydj(id));
	}


	/**
	 * jyjcUpLoadExcel的中文名称：检验检测excel数据上传
	 * <p/>
	 * jyjcUpLoadExcel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param f
	 * @return
	 * @throws Exception Written  by  : gjf
	 */
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = {"${app.root}/WEB-INF/tmp"})
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object jyjcUpLoadExcel(HttpServletRequest request, @Param("..") JyjcjgDTO dto,
								  @Param("filepath") File f) {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "JyjcjgDTO");

			// 数据逻辑校验
			//vali = jyjcService.checkJyjcUpLoadXls(request, vali, dto);

			String succList = Json.toJson(vali.getCorrectData());
			String errorList = Json.toJson(vali.getErrData());
			Integer succTotal = vali.getCorrectData().size();
			Integer errorTotal = vali.getErrData().size();
			succList = "{\"total\":" + succTotal + ",\"rows\":" + succList + "}";
			errorList = "{\"total\":" + errorTotal + ",\"rows\":" + errorList + "}";

			Map map = new HashMap();
			map.put("succList", succList);
			map.put("errorList", errorList);

			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * jyjcCompanyIndex的中文名称:检验检测页面初始化
	 * <p/>
	 * jyjcCompanyIndex的概要说明:
	 *
	 * @param request Written by zy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcUploadExcelData")
	public void jyjcUploadExcelDataIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * savePcompanydr的中文名称：保存导入的企业信息
	 * <p/>
	 * savePcompanydr的概要说明：
	 *
	 * @param request
	 * @return Written  by  : zjf
	 */
	@At
	@Ok("json")
	public Object saveJyjcUploadExcel(HttpServletRequest request, @Param("..") JyjcjgDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcUploadExcel(request, dto));
	}

	/**
	 * jyjcDownLoadExcel的中文名称：检验检测信息导入模板下载
	 * <p/>
	 * jyjcDownLoadExcel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception Written  by  : gjf
	 */
	@At
	@Ok("raw")
	public File jyjcDownLoadExcel(HttpServletRequest request, @Param("..") JyjcjgDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "检验检测结果导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			JyjcjgDTO pcdto = new JyjcjgDTO();
			List<JyjcjgDTO> lst = new ArrayList<JyjcjgDTO>();
			lst.add(pcdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("检验检测结果", "JyjcjgDTO", lst, false);
//			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("COMDALEI");// 企业大类
//			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheetOfTcq(sysuser.getAaa027());// 企业统筹区

			lstExd.add(exd);
//			lstExd.add(exd1);
//			lstExd.add(exd2);
			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_下载模版时的异常信息" + System.currentTimeMillis() + ".txt");
			FileWriter fw = new FileWriter(file);
			fw.write(e.getMessage());
			fw.close();
			return file;
		} finally {
			// 删除服务器上的临时文件
			// if (file.exists()) {
			// file.delete();
			// }
		}
	}

	/**
	 * queryJyjcUploadData 查询上传的检验检测数据
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJyjcUploadData(HttpServletRequest request,
									  @Param("..") JyjcjgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcUploadData(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


	/**
	 * jyjcUploadQueryIndex的中文名称:检验检测上传数据查询页面
	 * <p/>
	 * jyjcUploadQueryIndex的概要说明:
	 *
	 * @param request Written by gjf
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcUploadQuery")
	public void jyjcUploadQueryIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}


	/********************************************************************/
	/**
	 * jyjcdrIndex ：抽样登记导入初始页
	 *
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jyjc/cydjdr")
	public void cydjdrIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * downLoadExcel的中文名称：抽样导入模板下载
	 * <p/>
	 * downLoadExcel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception Written  by  : ly
	 */
	@At
	@Ok("raw")
	public File downLoadExcel(HttpServletRequest request, @Param("..") JyjccydjDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "检验检测抽样信息导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();
			JyjccydjDTO pcdto = new JyjccydjDTO();
			List<JyjccydjDTO> lst = new ArrayList<JyjccydjDTO>();
			lst.add(pcdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("抽样登记基本信息", "JyjccydjDTO", lst, false);
//			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("COMDALEI");// 企业大类
//			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheetOfTcq(sysuser.getAaa027());// 企业统筹区

			lstExd.add(exd);
//			lstExd.add(exd1);
//			lstExd.add(exd2);
			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_下载模版时的异常信息" + System.currentTimeMillis() + ".txt");
			FileWriter fw = new FileWriter(file);
			fw.write(e.getMessage());
			fw.close();
			return file;
		} finally {
			// 删除服务器上的临时文件
			// if (file.exists()) {
			// file.delete();
			// }
		}
	}

	/**
	 * upLoadExcel的中文名称：上传抽样登记导入信息
	 * <p/>
	 * upLoadExcel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param f
	 * @return
	 * @throws Exception Written  by  : ly
	 */
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = {"${app.root}/WEB-INF/tmp"})
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object upLoadExcel(HttpServletRequest request, @Param("..") JyjccydjDTO dto,
							  @Param("filepath") File f) {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "JyjccydjDTO");

			// 数据逻辑校验
			vali = jyjcService.checkUpLoadXls(request, vali, dto);

			String succList = Json.toJson(vali.getCorrectData());
			String errorList = Json.toJson(vali.getErrData());
			Integer succTotal = vali.getCorrectData().size();
			Integer errorTotal = vali.getErrData().size();
			succList = "{\"total\":" + succTotal + ",\"rows\":" + succList + "}";
			errorList = "{\"total\":" + errorTotal + ",\"rows\":" + errorList + "}";

			Map map = new HashMap();
			map.put("succList", succList);
			map.put("errorList", errorList);

			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * savejyjcdr的中文名称：保存导入的企业信息
	 *
	 * @param request
	 * @return Written  by  : ly
	 */
	@At
	@Ok("json")
	public Object savejyjcdr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");
		return SysmanageUtil.execAjaxResult(jyjcService.savecydjdr(request, succJsonStr));
	}

	/**
	 * exportToExcel的中文名称：导出错误信息
	 * <p/>
	 * exportToExcel的概要说明：
	 *
	 * @param request
	 * @param cldto
	 * @return
	 * @throws Exception Written  by  : ly
	 */
	@At
	@Ok("raw")
	public File exportToExcel(HttpServletRequest request, @Param("..") JyjccydjDTO cldto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = request.getParameter("filename");
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		System.out.println(fileFolderName);
		File file;

		try {
			String errorJsonStr = request.getParameter("errorJsonStr");
			errorJsonStr = new String(errorJsonStr.getBytes("ISO-8859-1"), "UTF-8"); // 编码转换
			List<JyjccydjDTO> lst = Json.fromJsonAsList(JyjccydjDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("抽样登记基本信息", "JyjccydjDTO", lst, false);
			//ExportedExcelDataInfo exd6 = SysmanageUtil.createExcelWorkSheet("COMDALEI");

			lstExd.add(exd);

			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_导出时的异常信息" + System.currentTimeMillis() + ".txt");
			FileWriter fw = new FileWriter(file);
			fw.write(e.getMessage());
			fw.close();
			return file;
		} finally {
			// 删除服务器上的临时文件
			// if (file.exists()) {
			// file.delete();
			// }
		}
	}

	/**
	 * queryJyjcUploadData 查询上传的检验检测数据
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJyjcUploadDataMain(HttpServletRequest request,
										  @Param("..") JyjcjgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcUploadDataMain(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * queryJyjcUploadCom 查询上传检验检测数据的企业
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryJyjcUploadCom(HttpServletRequest request,
									 @Param("..") JyjcjgDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcUploadCom(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jyjcUploadQueryIndex的中文名称:检验检测上传数据查询页面
	 * <p/>
	 * jyjcUploadQueryIndex的概要说明:
	 *
	 * @param request Written by gjf
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcUploadQueryCom")
	public void jyjcUploadQueryComIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * jyjcUploadQueryComDetailIndex的中文名称:局端查询上传数据明细
	 * <p/>
	 * jyjcUploadQueryComDetailIndex的概要说明:
	 *
	 * @param request Written by gjf
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjcUploadQueryComDetail")
	public void jyjcUploadQueryComDetailIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * jyjccyxmhbgIndex的中文名称:检验检查项目和结果页初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccyxmhbg")
	public void jyjccyxmhbgIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	@At
	@Ok("jsp:/jsp/jyjc/jyjcBgDr")
	public void jyjcBgDrIndex(HttpServletRequest request) {
		// 检验检测抽样结果导入压面
	}

	/**
	 * downLoadJyjcbgExcel的中文名称：下载检验检测报告模板
	 * <p/>
	 * downLoadJyjcbgExcel的概要说明：
	 *
	 * @param request
	 * @return
	 * @throws Exception Written by : zy
	 */
	@At
	@Ok("raw")
	public File downLoadJyjcbgExcel(HttpServletRequest request) throws Exception {
		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "检验检测报告导入";
		String fileFolderName = filepath + File.separator + UUID.randomUUID().toString().replace("-", "")
				+ File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();
			JyjccybgDTO pcdto = new JyjccybgDTO();
			List<JyjccybgDTO> lst = new ArrayList<JyjccybgDTO>();
			lst.add(pcdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("检验检测报告", "JyjccybgDTO", lst, false);

			lstExd.add(exd);
			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_下载模版时的异常信息" + System.currentTimeMillis() + ".txt");
			FileWriter fw = new FileWriter(file);
			fw.write(e.getMessage());
			fw.close();
			return file;
		}
	}

	/**
	 * queryjcxm : 查出检验检测抽样检测项目
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryjcxm(HttpServletRequest request, @Param("..") JyjccybgxmbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryjcxm(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * savejcxm  : 保存检查项目
	 *
	 * @param succJsonStr ： 添加的json数据
	 * @param cydjid      ： 抽样登记id
	 * @return
	 */
	@At
	@Ok("json")
	public Object savejcxm(String succJsonStr, String cydjid) {
		return SysmanageUtil.execAjaxResult(jyjcService.savejcxm(succJsonStr, cydjid));

	}

	/**
	 * deljyjcxm的中文名称：删除检测项目
	 * deljyjcxm的概要描述：
	 *
	 * @param dto
	 * @return Written by : ly
	 */
	@At
	@Ok("json")
	public Object deljcxm(@Param("..") JyjccybgxmbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.deljcxm(dto));
	}

	/**
	 * queryjcxm : 查出检验检测抽样检测项目
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@At
	@Ok("json")
	public Object queryjcbg(@Param("..") JyjccybgbDTO dto) {
		Map map = new HashMap();
		try {
			map = jyjcService.querybg(dto);
			List list = (List) map.get("rows");
			JyjccybgbDTO bg = null;
			if (list != null && list.size() > 0) {
				bg = (JyjccybgbDTO) list.get(0);
			}
			map.put("data", bg);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}

	}

	/**
	 * savejcbg : 检验检测抽样报告
	 *
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	public Object savejcbg(HttpServletRequest request,@Param("..") JyjccybgbDTO dto) {

		return SysmanageUtil.execAjaxResult(jyjcService.savejcbg(request,dto));

	}

	/**
	 * upLoadJyjcbgExcel的中文名称：检验检测报告上传
	 * <p/>
	 * upLoadJyjcbgExcel的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param f
	 * @return
	 * @throws Exception Written by : zy
	 */
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = {"${app.root}/WEB-INF/tmp"})
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object upLoadJyjcbgExcel(HttpServletRequest request, @Param("..") JyjccybgDTO dto,
									@Param("filepath") File f) throws Exception {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "JyjccybgDTO");

			// 数据逻辑校验
			vali = jyjcService.checkUpLoadJyjcXls(vali, dto);

			String succList = Json.toJson(vali.getCorrectData());
			String errorList = Json.toJson(vali.getErrData());
			Integer succTotal = vali.getCorrectData().size();
			Integer errorTotal = vali.getErrData().size();
			succList = "{\"total\":" + succTotal + ",\"rows\":" + succList + "}";
			errorList = "{\"total\":" + errorTotal + ",\"rows\":" + errorList + "}";

			Map map = new HashMap();
			map.put("succList", succList);
			map.put("errorList", errorList);

			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * saveJyjcbgDr的中文名称：检验检测报告导入保存
	 * <p/>
	 * saveJyjcbgDr的概要说明：
	 *
	 * @param request
	 * @return Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveJyjcbgDr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");
		return SysmanageUtil.execAjaxResult(jyjcService.saveJyjcbgDr(request, succJsonStr));
	}

	/**
	 * exportToJyjcbgExcel的中文名称：导出检验检测报告文件
	 * <p/>
	 * exportToJyjcbgExcel的概要说明：
	 *
	 * @param request
	 * @param cldto
	 * @return
	 * @throws Exception Written by : zy
	 */
	@At
	@Ok("raw")
	public File exportToJyjcbgExcel(HttpServletRequest request, @Param("..") JyjccybgDTO cldto) throws Exception {

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = request.getParameter("filename");
		String fileFolderName = filepath + File.separator + UUID.randomUUID().toString().replace("-", "")
				+ File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;

		try {
			String errorJsonStr = request.getParameter("errorJsonStr");
			errorJsonStr = new String(errorJsonStr.getBytes("ISO-8859-1"), "UTF-8"); // 编码转换
			List<JyjccybgDTO> lst = Json.fromJsonAsList(JyjccybgDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("抽验报告信息", "JyjccybgDTO", lst, false);

			lstExd.add(exd);

			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_导出时的异常信息" + System.currentTimeMillis() + ".txt");
			FileWriter fw = new FileWriter(file);
			fw.write(e.getMessage());
			fw.close();
			return file;
		}
	}

	/**
	 * jyjgglIndex:检验机构页面初始化
	 *
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjggl")
	public void jyjgglIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * jyjgglIndex:检测机构人员页面初始化
	 *
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jcjgrygl")
	public void jcjgryglIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/************************检测方法管理start****************************/

	/**
	 * jcffglIndex的中文名称:检测方法页面初始化
	 * <p/>
	 * jcffglIndex的概要说明:
	 *
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jcffgl")
	public void jcffglIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * queryJcffgl的中文名称:查询检测方法并分页
	 * <p/>
	 * queryJcffgl的概要说明:
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by CatchU 2016年5月5日下午12:01:41
	 */
	@At
	@Ok("json")
	public Object queryJcffgl(@Param("..") JyjcffbzbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJcffgl(dto, pd);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * jcffglFormIndex的中文名称:检测方法详情页面初始化
	 * <p/>
	 * jcffglFormIndex的概要说明:
	 *
	 * @param request
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jcffglForm")
	public void jcffglFormIndex(HttpServletRequest request) {
		//检验检测详情页面初始化
	}

	/**
	 * jcffglForm的中文名称:检测方法添加
	 * <p/>
	 * jcffglForm的概要说明
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object jcffglForm(HttpServletRequest request, @Param("..") JyjcffbzbDTO dto, @Param("..") PagesDTO pd) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			jyjcService.jcffglForm(request, dto);
			String jcffid = dto.getJyjcffbzbid();
			System.out.println(jcffid);
			if (jcffid != null) {
				result.put("jcffid", jcffid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}

	/**
	 * queryJyjcffbzbDto的中文名称:检测方法查询dto
	 * <p/>
	 * queryJyjcffbzbDto的概要说明
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@At
	@Ok("json")
	public Object queryJyjcffbzbDto(HttpServletRequest request, @Param("..") JyjcffbzbDTO dto,
									@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjcffbzbDto(request, dto, pd);
			List list = (List) map.get("rows");
			JyjcffbzbDTO jcffDto = null;
			if (list != null && list.size() > 0) {
				jcffDto = (JyjcffbzbDTO) list.get(0);
			}
			map.put("data", jcffDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 删除检测方法
	 */
	@At
	@Ok("json")
	public Object delPcompany(HttpServletRequest request, @Param("..") JyjcffbzbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delJyjcffbzb(request, dto));
	}

	/************************检测方法管理 end****************************/


	/************************抽样登记 start****************************/
	/**
	 * jyjccydjIndex_zm 的中文名称:抽样登记页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccydj_zm")
	public void jyjccydjIndex_zm(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * queryJyjccydj_zm 的中文名称:查询检验检测抽样登记
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjccydj_zm(@Param("..") JyjccydjDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjccydj_zm(dto, pd);
			JyjccydjDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (JyjccydjDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jyjccydjFormIndex_zm 的中文名称:检验检测抽样登记增加修改页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccydjForm_zm")
	public void jyjccydjFormIndex_zm(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * jyjccydjFormIndex_zm 的中文名称:检验检测抽样登记增加修改页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccydForm_zm")
	public void jyjccydFormIndex_zm(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * saveJyjccydj_zm ：保存抽样登记
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object saveJyjccydj_zm(HttpServletRequest request, @Param("..") JyjccydjDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.saveJyjccydj_zm(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * 删除抽样登记
	 *
	 * @param id
	 * @return
	 */
	@At
	@Ok("json")
	public Object deljyjccydj_zm(String id) {
		return SysmanageUtil.execAjaxResult(jyjcService.deljyjccydj_zm(id));
	}
	/************************抽样登记 end****************************/


	/************************抽样单 start****************************/
	/**
	 * jyjccyxmhbgIndex的中文名称:检验检测抽样单初始化页面
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jyjccyd_zm")
	public void jyjccydIndex(HttpServletRequest request) {
		// 检验检测单位初始化
	}

	/**
	 * queryJyjccyd_zm 的中文名称:查询检验检测抽样单
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryJyjccyd_zm(@Param("..") JyjccydDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryJyjccyd_zm(dto, pd);
			JyjccydDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (JyjccydDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveJyjccyd_zm ：保存抽样单
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object saveJyjccyd_zm(HttpServletRequest request, @Param("..") JyjccydDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.saveJyjccyd_zm(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * delJyjccyd_zm ：删除抽样单
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object delJyjccyd_zm(HttpServletRequest request, @Param("..") JyjccydDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.delJyjccyd_zm(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/************************抽样单 end****************************/

	/************************检测结果 start****************************/
	/**
	 * jyjccyxmhbgIndex的中文名称:检验检测主表初始化页面
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/hjyjczb_zm")
	public void jyjcjcIndex(HttpServletRequest request) {
		// 检验检测结果初始化
	}

	/**
	 * jyjccyxmhbgIndex的中文名称:检验检测主表页面初始化
	 *
	 * @param request Written by ly
	 */
	@At
	@Ok("jsp:/jsp/jyjc/hjyjczbForm_zm")
	public void hjyjczbForm_zm(HttpServletRequest request) {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// 检验检测结果详情页面初始化
	}

	/**
	 * queryHjyjczb_zm 的中文名称:查询检验检测主表
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryHjyjczb_zm(@Param("..") HjyjczbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryHjyjczb_zm(dto, pd);
			HjyjczbDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (HjyjczbDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveHjyjczb_zm ：保存检测报告主表
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object saveHjyjczb_zm(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.saveHjyjczb_zm(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * delHjyjczb_zm ：删除结果主表
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object delHjyjczb_zm(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.delHjyjczb_zm(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * queryHjyjcmxb_zm 的中文名称:查询检验检测明细表
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object queryHjyjcmxb_zm(@Param("..") HjyjcmxbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryHjyjcmxb_zm(dto, pd);
			HjyjcmxbDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (HjyjcmxbDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * saveHjyjcxb的中文名称：添加检测明细表
	 * saveHjyjcxb的概要描述：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : lfy
	 */
	@At
	@Ok("json")
	public Object saveHjyjcxb(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveHjyjcxb(request, dto));
	}

	/**
	 * queryHjyjcmxb 的中文名称:查询检验检测明细表
	 *
	 * @param dto
	 * @param pd
	 * @throws Exception Written by ly
	 */
	@At
	@Ok("json")
	public Object queryHjyjcmxb(@Param("..") HjyjcmxbDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryHjyjcmxb(dto, pd);
			HjyjcmxbDTO jcDto = null;
			List list = (List) map.get("rows");
			if (list != null && list.size() > 0) {
				jcDto = (HjyjcmxbDTO) list.get(0);
			}
			map.put("data", jcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * delHjyjcmxb ：删除结果明细表
	 *
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("json")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object delHjyjcmxb(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto) {
		Map map = new HashMap();
		try {
			String id = jyjcService.delHjyjcmxb(request, dto);
			if (id != null) {
				map.put("id", id);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}


	/************************检测结果 end****************************/
	@At
	@Ok("jsp:/jsp/jyjc/sqjctj")
	public void sqjctjIndex(HttpServletRequest request) {
		//申请检测统计
	}

	/**
	 * jcsjlrFormIndex的中文名称:检验检测数据录入初始化
	 * <p/>
	 * jcsjlrFormIndex的概要说明:
	 *
	 * @param request Written by wxy
	 */
	@At
	@Ok("jsp:/jsp/jyjc/jcsjlr")
	public void jcsjlrIndex(HttpServletRequest request) {
		//检验检测数据录入
	}

	@At
	@Ok("jsp:/jsp/jyjc/jcsjlrForm")
	public void jcsjlrForm(HttpServletRequest request) {
		//检验检测数据录入
	}

	@At
	@Ok("jsp:/jsp/jyjc/wssj")
	public void wssjIndex(HttpServletRequest request) {
		//检验检测数据录入
	}

	@At
	@Ok("jsp:/jsp/jyjc/wssjForm")
	public void wssjFormIndex(HttpServletRequest request) {
		//检验检测数据录入
	}

	@At
	@Ok("json")
	public Object queryWssj(HttpServletRequest request, @Param("..") JyjcwssjDTO dto,
							@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryWssj(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryWssjDTO(HttpServletRequest request, @Param("..") JyjcwssjDTO dto,
							   @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryWssj(request, dto, pd);
			List list = (List) map.get("rows");
			JyjcwssjDTO jcwssjDto = null;
			if (list != null && list.size() > 0) {
				jcwssjDto = (JyjcwssjDTO) list.get(0);
			}
			map.put("data", jcwssjDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object saveWssj(HttpServletRequest request, @Param("..") JyjcwssjDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.saveWssj(request, dto));
	}

	@At
	@Ok("json")
	public Object delWssj(HttpServletRequest request, @Param("..") JyjcwssjDTO dto) {
		return SysmanageUtil.execAjaxResult(jyjcService.delWssj(request, dto));
	}

	/**
	 * 查询检测标准编号唯一性
	 *
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object checkCode(HttpServletRequest request, @Param("..") JyjcffbzbDTO dto) {
		Map map = new HashMap();
		try {
			map = jyjcService.checkCode(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object checkBzbh(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto) {
		Map map = new HashMap();
		try {
			map = jyjcService.checkBzbh(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object checkJcxmmc(HttpServletRequest request, @Param("..") JyjcxmDTO dto) {
		Map map = new HashMap();
		try {
			map = jyjcService.checkJcxmmc(request, dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * jycjcpflIndex的中文名称:抽检实施细则产品分类页面初始化
	 * <p/>
	 * jycjcpflIndex的概要说明:
	 *
	 * @param request Written by CatchU 2016年5月5日上午9:52:32
	 */
	@At
	@Ok("jsp:/jsp/jyjc/ndwjyp")
	public void ndwjypIndex(HttpServletRequest request) {
		//检验检测项目页面初始化
	}

	/**
	 * aqjgCount中文名称:查询你点我检样品统计数量
	 * aqjgCount概要描述:查询你点我检样品统计数量
	 * written by  :  wxy
	 */
	@At
	@Ok("json")
	public Object ndwjypCount(HttpServletRequest request, @Param("..") pubkeyDTO dto) {
		Map mapc = new HashMap();
		try {
			mapc = jyjcService.ndwjypCount(request, dto);
			return SysmanageUtil.execAjaxResult(mapc, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(mapc, e);
		}
	}
	@At
	@Ok("json")
	public Object queryQyyyrz(HttpServletRequest request, @Param("..") SysoperatelogDTO dto,
								@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = jyjcService.queryQyyyrz(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	@At
	@Ok("json")
	public String getPY(@Param("..") JyjcxmDTO dto) {
		return jyjcService.getPY(dto);
	}
}
