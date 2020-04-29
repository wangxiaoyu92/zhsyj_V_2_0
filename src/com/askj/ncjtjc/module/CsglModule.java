package com.askj.ncjtjc.module;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.upload.UploadAdaptor;
import com.askj.ncjtjc.service.CsglService;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.util.ExcelUtil;
import com.lbs.leaf.validate.ValidateData;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.CsDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.ncjtjc.entity.Csfj;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * CsglModule的中文名称：厨师管理
 * 
 * CsglModule的描述：
 * 
 * Written by : zjf
 */
@At("/ncjtjc/csgl")
@IocBean
public class CsglModule {
	protected final Logger logger = Logger.getLogger(CsglModule.class);

	@Inject
	protected CsglService csglService;

	/**
	 * 
	 * csglIndex的中文名称：厨师管理页面
	 * 
	 * csglIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/csgl")
	public void csglIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryCs的中文名称：查询厨师
	 * 
	 * queryCs的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryCs(HttpServletRequest request, @Param("..") CsDTO dto, @Param("..") PagesDTO pd) throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		return csglService.queryCs(dto, pd);
	}

	/**
	 * 
	 * csglFormIndex的中文名称：厨师编辑页面
	 * 
	 * csglFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/csglForm")
	public void csglFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryCsDTO的中文名称：查询厨师DTO
	 * 
	 * queryCsDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryCsDTO(HttpServletRequest request, @Param("..") CsDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = csglService.queryCs(dto, pd);
			List ls = (List) map.get("rows");
			CsDTO csDTO = null;
			if (ls != null && ls.size() > 0) {
				csDTO = (CsDTO) ls.get(0);
			}
			map.put("data", csDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * getCszp的中文名称：获取数据库存储的厨师照片信息
	 * 
	 * getCszp的概要说明: 创建照片，并返回服务器端路径
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getCszp(HttpServletRequest request, @Param("..") CsDTO dto) throws Exception {
		Map map = new HashMap();
		String contextPath = request.getContextPath();
		String fileCtxPath = contextPath + "/images/default.jpg";
		try {
			String filePath = csglService.getCszp(request, dto);
			if (!Strings.isBlank(filePath)) {
				int pfindex = filePath.lastIndexOf("\\");
				String fileName = filePath.substring(pfindex + 1);
				fileCtxPath = contextPath + GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH + File.separator + fileName;
			}

			map.put("fileCtxPath", fileCtxPath);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			map.put("fileCtxPath", fileCtxPath);
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * isExistsCs的中文名称：校验证件号码是否已经登记过
	 * 
	 * isExistsCs的概要说明：身份证号唯一
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object isExistsCs(HttpServletRequest request, @Param("..") CsDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(csglService.isExistsCs(dto));
	}

	/**
	 * 
	 * addCs的中文名称：新增厨师
	 * 
	 * addCs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object addCs(HttpServletRequest request, @Param("..") CsDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String csid = csglService.addCs(request, dto);
			if (csid != null) {
				result.put("csid", csid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}

	/**
	 * 
	 * updateCs的中文名称：修改厨师
	 * 
	 * updateCs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object updateCs(HttpServletRequest request, @Param("..") CsDTO dto) {
		return SysmanageUtil.execAjaxResult(csglService.updateCs(request, dto));
	}

	/**
	 * 
	 * delCs的中文名称：删除厨师
	 * 
	 * delCs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object delCs(HttpServletRequest request, @Param("..") CsDTO dto) {
		return SysmanageUtil.execAjaxResult(csglService.delCs(request, dto));
	}

	/**
	 * 
	 * csdrIndex的中文名称：厨师导入页面
	 * 
	 * csdrIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/csdr")
	public void csdrIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * saveCsdr的中文名称：保存厨师导入信息
	 * 
	 * saveCsdr的概要说明:
	 * 
	 * @param jsonStr
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object saveCsdr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");
		return SysmanageUtil.execAjaxResult(csglService.saveCsdr(request, succJsonStr));
	}

	/**
	 * 
	 * downLoadExcel的中文名称：下载生成Excel模版文件
	 * 
	 * downLoadExcel的概要说明：1、设置excel文件的格式；2、插入数据
	 * 
	 * @param dto
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("raw")
	public File downLoadExcel(HttpServletRequest request, @Param("..") CsDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "厨师基本信息导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			CsDTO csdto = new CsDTO();
			List<CsDTO> lst = new ArrayList<CsDTO>();
			lst.add(csdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("厨师基本信息", "CsDTO", lst, false);
			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("aac058");
			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheet("aac004");// 性别
			ExportedExcelDataInfo exd3 = SysmanageUtil.createExcelWorkSheet("aac011");// 学历
			ExportedExcelDataInfo exd4 = SysmanageUtil.createExcelWorkSheet("JKZM");
			ExportedExcelDataInfo exd5 = SysmanageUtil.createExcelWorkSheet("PXQK");
			ExportedExcelDataInfo exd6 = SysmanageUtil.createExcelWorkSheet("CYNX");

			lstExd.add(exd);
			lstExd.add(exd1);
			lstExd.add(exd2);
			lstExd.add(exd3);
			lstExd.add(exd4);
			lstExd.add(exd5);
			lstExd.add(exd6);

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
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/WEB-INF/tmp" })
	public Object upLoadExcel(HttpServletRequest request, @Param("..") CsDTO dto,@Param("filepath") File f) throws Exception {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "CsDTO");

			// 数据逻辑校验
			vali = csglService.checkUpLoadXls(request, vali, dto);

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
	 * exportToExcel的中文名称：导出数据到excel
	 * 
	 * exportToExcel的概要说明：1、设置excel文件的格式；2、插入数据
	 * 
	 * @param dto
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("raw")
	public File exportToExcel(HttpServletRequest request, @Param("..") CsDTO cldto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = request.getParameter("filename");
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;

		try {
			String errorJsonStr = request.getParameter("errorJsonStr");
			List<CsDTO> lst = Json.fromJsonAsList(CsDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("厨师基本信息", "CsDTO", lst, true);
			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("aac058");
			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheet("aac004");
			ExportedExcelDataInfo exd3 = SysmanageUtil.createExcelWorkSheet("aac011");
			ExportedExcelDataInfo exd4 = SysmanageUtil.createExcelWorkSheet("JKZM");
			ExportedExcelDataInfo exd5 = SysmanageUtil.createExcelWorkSheet("PXQK");
			ExportedExcelDataInfo exd6 = SysmanageUtil.createExcelWorkSheet("CYNX");

			lstExd.add(exd);
			lstExd.add(exd1);
			lstExd.add(exd2);
			lstExd.add(exd3);
			lstExd.add(exd4);
			lstExd.add(exd5);
			lstExd.add(exd6);

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
	 * 
	 * uploadFjIndex的中文名称：上传附件页面
	 * 
	 * uploadFjIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/uploadFj")
	public void uploadFjIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * uploadFj的中文名称：上传附件【保存】
	 * 
	 * uploadFj的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request, @Param("..") Csfj dto) {
		return SysmanageUtil.execAjaxResult(csglService.uploadFj(request, dto));
	}

	/**
	 * 
	 * delFjIndex的中文名称：删除附件页面
	 * 
	 * delFjIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/delFj")
	@SuppressWarnings({ "rawtypes" })
	public void delFjIndex(HttpServletRequest request, @Param("..") Csfj dto) throws Exception {
		// 页面初始化
		List fjList = csglService.queryFjList(request, dto);
		if (fjList != null && fjList.size() > 0) {
			request.setAttribute("fjList", fjList);
		} else {
			request.setAttribute("fjList", null);
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
	public Object delFj(HttpServletRequest request, @Param("..") Csfj dto) {
		return SysmanageUtil.execAjaxResult(csglService.delFj(request, dto));
	}

	/**
	 * 
	 * cslhkhIndex的中文名称：厨师量化考核页面
	 * 
	 * cslhkhIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lhkh/cslhkh")
	public void cslhkhIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *printCsbadj的中文名称：厨师备案表打印
	 * 
	 * printCsbadj的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/csgl/printCsbadj")
	@SuppressWarnings({ "rawtypes" })
	public Object printCsbadj(HttpServletRequest request,@Param("..")CsDTO dto) {
		// 页面初始化
		Map map = new HashMap();
		try {
		map = csglService.getCsRecord(request, dto);
		return SysmanageUtil.execAjaxResult(map, null);
	} catch (Exception e) {
		return SysmanageUtil.execAjaxResult(null, e);
	}
	}
	
}
