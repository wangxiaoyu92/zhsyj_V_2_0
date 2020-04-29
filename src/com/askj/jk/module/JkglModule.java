package com.askj.jk.module;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.util.ExcelUtil;
import com.lbs.leaf.validate.ValidateData;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.jk.dto.JkDTO;
import com.askj.jk.dto.JkqyfzrDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.jk.service.JkglService;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * JkglModule的中文名称：监控管理Module
 * 
 * JkglModule的描述：
 * 
 * Written by : zjf
 */
@At("/jk/jkgl")
@IocBean
public class JkglModule extends BaseModule {
	@Inject
	protected JkglService jkglService;

	/**
	 * 
	 * jkyglIndex的中文名称：监控源管理页面
	 * 
	 * jkyglIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkygl")
	public void jkyglIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jkqyjgyIndex的中文名称：监控企业监管源页面
	 * 
	 * jkqyjgyIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkqyjgy")
	public void jkqyjgyIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * jkyglFormIndex的中文名称：监控源编辑页面
	 * 
	 * jkyglFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkyglForm")
	public void jkyglFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryJkqy的中文名称：查询监控企业
	 * 
	 * queryJkqy的概要说明：
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryJkqy(@Param("..") JkDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = jkglService.queryJkqy(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * queryJkcomList 查询监控企业
	 * 
	 * queryJkcomList 查询监控企业
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryJkcomList(@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = jkglService.queryJkcomList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * queryJkfzrList 查询监控企业负责人
	 * 
	 * queryJkfzrList 查询监控企业负责人
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryJkfzrList(@Param("..") JkqyfzrDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = jkglService.queryJkfzrList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * saveJkFzr 保存企业负责人
	 * 
	 * saveJkFzr 
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object saveJkFzr(HttpServletRequest request, @Param("..") JkqyfzrDTO dto) {
		return SysmanageUtil.execAjaxResult(jkglService.saveJkFzr(request, dto));
	}
	
	/**
	 * 
	 * delJkqyFzr 删除监控企业负责人
	 * 
	 * delJkqyFzr 
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object delJkqyFzr(HttpServletRequest request, @Param("..") JkqyfzrDTO dto) {
		return SysmanageUtil.execAjaxResult(jkglService.delJkqyFzr(request, dto));
	}

	/**
	 *
	 * queryJky的中文名称：获取监控源列表
	 *
	 * queryJky的概要说明：获取本地同步的监控源数据
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
	public Object queryJky(HttpServletRequest request,
						   @Param("..") JkDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = jkglService.queryJky(dto, pd);
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
	public Object getJkyList(HttpServletRequest request,
							 @Param("..") JkDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			com.alibaba.fastjson.JSONArray jsonArray = jkglService.getComJkyFromMCLZ(dto.getCamorgid());
			map.put("rows", jsonArray);
			map.put("total", jsonArray.size());
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
	public Object getJkyDetail(@Param("..") JkDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			com.alibaba.fastjson.JSONObject jsonObject = jkglService.getComJkyDetailFromMCLZ(dto.getJkid());
			return SysmanageUtil.execAjaxResult(jsonObject, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * queryJkyDTO的中文名称：查询监控源DTO
	 * 
	 * querySjDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryJkyDTO(HttpServletRequest request, @Param("..") JkDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = jkglService.queryJky(dto, pd);
			List ls = (List) map.get("rows");
			JkDTO jkDTO = null;
			if (ls != null && ls.size() > 0) {
				jkDTO = (JkDTO) ls.get(0);
			}
			map.put("data", jkDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addJky的中文名称：新增监控源
	 * 
	 * addJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addJky(HttpServletRequest request, @Param("..") JkDTO dto) {
		return SysmanageUtil.execAjaxResult(jkglService.addJky(request, dto));
	}

	/**
	 * 
	 * updateJky的中文名称：修改监控源
	 * 
	 * updateJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateJky(HttpServletRequest request, @Param("..") JkDTO dto) {
		return SysmanageUtil.execAjaxResult(jkglService.updateJky(request, dto));
	}

	/**
	 * 
	 * delJky的中文名称：删除监控源
	 * 
	 * delJky的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delJky(HttpServletRequest request, @Param("..") JkDTO dto) {
		return SysmanageUtil.execAjaxResult(jkglService.delJky(request, dto));
	}

	/**
	 * 
	 * jkydrIndex的中文名称：监控源导入页面
	 * 
	 * jkydrIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkydr")
	public void jkydrIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * saveJkydr的中文名称：保存监控源导入信息
	 * 
	 * saveJkydr的概要说明:
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveJkydr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");
		return SysmanageUtil.execAjaxResult(jkglService.saveJkydr(request, succJsonStr));
	}

	/**
	 * 
	 * downLoadExcel的中文名称：下载、生成Excel文件
	 * 
	 * downLoadExcel的概要说明：1、设置excel文件的格式；2、插入数据
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("raw")
	public File downLoadExcel(HttpServletRequest request, @Param("..") JkDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "监控源信息导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			JkDTO jkdto = new JkDTO();
			List<JkDTO> lst = new ArrayList<JkDTO>();
			lst.add(jkdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("监控源基本信息", "JkDTO", lst, false);
			lstExd.add(exd);

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
	 * 
	 * upLoadExcel的中文名称：上传、读取Excel文件
	 * 
	 * upLoadExcel的概要说明:
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object upLoadExcel(HttpServletRequest request, @Param("..") JkDTO dto) throws Exception {
		try {
			ValidateData vali;
			final String filepath = request.getParameter("filepath");

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "JkDTO");

			// 数据逻辑校验
			vali = jkglService.checkUpLoadXls(request, vali, dto);

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
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 *
	 * saveOrUpdatePcompanyImport的中文名称：保存或更新明厨亮灶企业数据
	 *
	 * saveOrUpdatePcompanyImport的概要说明:保存或更新明厨亮灶企业数据
	 * @return
	 * @throws Exception
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object saveOrUpdatePcompanyImport(HttpServletRequest request) throws Exception {
		try {
			String res = jkglService.saveOrUpdatePcompanyImport(request);
			Map map = new HashMap();
			map.put("data", res);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * jcjkmainIndex的中文名称：聚餐监控主页面
	 * 
	 * jcjkmainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcjk/main")
	public void jcjkmainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * jcjkmonitorIndex的中文名称：聚餐监控子页面
	 * 
	 * jcjkmonitorIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/jcjk/monitor")
	public void jcjkmonitorIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * jkmainIndex的中文名称：视频监控主页面
	 * 
	 * jkmainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/main")
	public void jkmainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * jkmonitorIndex的中文名称：视频监控子页面
	 * 
	 * jkmonitorIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/monitor")
	public void jkmonitorIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * qydtjkmainIndex的中文名称：企业地图监控主页面
	 * 
	 * qydtjkmainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/qydtjk/main")
	public void qydtjkmainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * qydtjkmonitorIndex的中文名称：企业地图监控子页面
	 * 
	 * qydtjkmonitorIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/qydtjk/monitor")
	public void qydtjkmonitorIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * qydtjkmainIndex的中文名称：企业地图监控主页面
	 *
	 * qydtjkmainIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/jk/qydtjkforgis/main")
	public void qydtjkmainIndexForGIS(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * qydtjkmonitorIndex的中文名称：企业地图监控子页面
	 *
	 * qydtjkmonitorIndex的概要说明：
	 *
	 * @param request
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/jk/qydtjkforgis/monitor")
	public void qydtjkmonitorIndexForGIS(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryQysl的中文名称：按企业大类统计企业数量
	 * 
	 * queryQysl的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryQysl(@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		Map map = new HashMap();
		try {
			map =  jkglService.queryQysl(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * jkmainIndex的中文名称：视频监控企业页面
	 * 
	 * jkmainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkqyList")
	public void jkqyListIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jkyAllListIndex的中文名称：视频监控页面【在线视频】
	 * 
	 * jkyAllListIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkyAllList")
	public void jkyAllListIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * jkyAllListLxIndex的中文名称：视频监控页面【离线视频】
	 * 
	 * jkyAllListLxIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/jk/jkyAllListLx")
	public void jkyAllListLxIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * sdhqqylb   手动获取带有摄像头的企业列表
	 * @param request 
	 * @param flg
	 * @return
	 */
	@At
	@Ok("json")
	public Object sdhqqylb(HttpServletRequest request,@Param("flg") int flg) {
		if(flg == 1 ){ 
			return SysmanageUtil.execAjaxResult(jkglService.saveOrUpdatePcompanyImport(request));
		}else{ 
			return SysmanageUtil.execAjaxResult(jkglService.sdhqqylb(request));
		}
	}
	/**
	 * sdhqqysxt  手动获取企业摄像头列表
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object shouDongHuoQuSheXiangTou(HttpServletRequest request) throws Exception {
		return SysmanageUtil.execAjaxResult(jkglService.shouDongHuoQuSheXiangTou(request));
	}

	/**
	 *
	 * @param request
	 * @return
	 * @throws Exception
     */
	@At
	@Ok("json")
	public Object sdtbqysxt(HttpServletRequest request) throws Exception {
		try {
			jkglService.saveOrUpdatePcompanyImport(null);
			int[] flag = new int[]{1, 1};
			jkglService.updatePcompanyImportComid(flag);
			return SysmanageUtil.execAjaxResult("");
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult("error!!!!!!!");
		}
	}
	/**
	 * 添加领导打卡   默认在定时器里
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public void addlddk(String userid) throws Exception {
		jkglService.addlddk(userid);
	}

	/**
	 *  自动打卡
	 * @param date
	 * @throws Exception
     */
	@At
	@Ok("json")
	public void zidongqiandaoAll(String date) throws Exception {
		jkglService.zidongqiandaoAll(date);
	}
}
