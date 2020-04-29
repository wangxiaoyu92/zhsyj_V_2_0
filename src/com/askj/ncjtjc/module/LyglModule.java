package com.askj.ncjtjc.module;

import com.askj.ncjtjc.service.LyglService;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.util.ExcelUtil;
import com.lbs.leaf.validate.ValidateData;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.LyDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.ncjtjc.entity.Lyfj;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * LyglModule的中文名称：两员管理
 * 
 * LyglModule的描述：
 * 
 * Written by : sunyifeng
 */
@At("/ncjtjc/lygl")
@IocBean
public class LyglModule {
	protected final Logger logger = Logger.getLogger(LyglModule.class);

	@Inject
	protected LyglService lyglService;

	/**
	 * 
	 * lyglIndex的中文名称：两员管理页面
	 * 
	 * lyglIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/lygl")
	public void lyglIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryLy的中文名称：查询两员
	 * 
	 * queryLy的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryLy(HttpServletRequest request, @Param("..") LyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
		dto.setAaa027(aaa027);
		return lyglService.queryLy(dto, pd);
	}

	/**
	 * 
	 * lyglFormIndex的中文名称：两员编辑页面
	 * 
	 * lyglFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/lyglForm")
	public void lyglFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryLyDTO的中文名称：查询两员DTO
	 * 
	 * queryLyDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object queryLyDTO(HttpServletRequest request, @Param("..") LyDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = lyglService.queryLy(dto, pd);
			List ls = (List) map.get("rows");
			LyDTO lyDTO = null;
			if (ls != null && ls.size() > 0) {
				lyDTO = (LyDTO) ls.get(0);
			}
			map.put("data", lyDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * getLyzp的中文名称：获取数据库存储的两员照片信息
	 * 
	 * getLyzp的概要说明: 创建照片，并返回服务器端路径
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getLyzp(HttpServletRequest request, @Param("..") LyDTO dto) throws Exception {
		Map map = new HashMap();
		String contextPath = request.getContextPath();
		String fileCtxPath = contextPath + "/images/default.jpg";
		try {
			String filePath = lyglService.getLyzp(request, dto);
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
	 * isExistsLy的中文名称：校验证件号码是否已经登记过
	 * 
	 * isExistsLy的概要说明：身份证号唯一
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object isExistsLy(HttpServletRequest request, @Param("..") LyDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(lyglService.isExistsLy(dto));
	}

	/**
	 * 
	 * addLy的中文名称：新增两员
	 * 
	 * addLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object addLy(HttpServletRequest request, @Param("..") LyDTO dto) {
		return SysmanageUtil.execAjaxResult(lyglService.addLy(request, dto));
	}

	/**
	 * 
	 * updateLy的中文名称：修改两员
	 * 
	 * updateLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object updateLy(HttpServletRequest request, @Param("..") LyDTO dto) {
		return SysmanageUtil.execAjaxResult(lyglService.updateLy(request, dto));
	}

	/**
	 * 
	 * delLy的中文名称：删除两员
	 * 
	 * delLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object delLy(HttpServletRequest request, @Param("..") LyDTO dto) {
		return SysmanageUtil.execAjaxResult(lyglService.delLy(request, dto));
	}

	/**
	 * 
	 * lydrIndex的中文名称：两员导入页面
	 * 
	 * lydrIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/lydr")
	public void lydrIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * saveLydr的中文名称：保存两员导入信息
	 * 
	 * saveLydr的概要说明:
	 * 
	 * @param jsonStr
	 * @return Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object saveLydr(HttpServletRequest request,@Param("data") String succJsonStr) {
		try {
			succJsonStr = URLDecoder.decode(succJsonStr, "utf-8");
			succJsonStr = URLDecoder.decode(succJsonStr, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return SysmanageUtil.execAjaxResult(lyglService.saveLydr(request, succJsonStr));
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
	 *             Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("raw:stream")
	public File downLoadExcel(HttpServletRequest request, @Param("..") LyDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "两员基本信息模板";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			LyDTO lydto = new LyDTO();
			List<LyDTO> lst = new ArrayList<LyDTO>();
			lst.add(lydto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("两员基本信息", "LyDTO", lst, false);
			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("aac058");
			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheet("aac004");// 性别
			ExportedExcelDataInfo exd3 = SysmanageUtil.createExcelWorkSheet("aac011");// 学历
			ExportedExcelDataInfo exd4 = SysmanageUtil.createExcelWorkSheet("ZZMM");// 政治面貌
			ExportedExcelDataInfo exd5 = SysmanageUtil.createExcelWorkSheet("PXQK");
			ExportedExcelDataInfo exd6 = SysmanageUtil.createExcelWorkSheet("LYLX");// 两员类型
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
	@AdaptBy(type = UploadAdaptor.class,args = {  "${app.root}/WEB-INF/tmp" })
	public Object upLoadExcel(HttpServletRequest request, @Param("..") LyDTO dto,@Param("filepath") TempFile
			 f) throws Exception {
		try {
			ValidateData vali;
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(f.getInputStream(), "LyDTO");

			// 数据逻辑校验
			vali = lyglService.checkUpLoadXls(request, vali, dto);

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
	 *             Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("raw")
	public File exportToExcel(HttpServletRequest request, @Param("..") LyDTO cldto) throws Exception {
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
			List<LyDTO> lst = Json.fromJsonAsList(LyDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("两员基本信息", "LyDTO", lst, true);
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
	 *            Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/uploadFj")
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
	 * @return Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("json")
	public Object uploadFj(HttpServletRequest request, @Param("..") Lyfj dto) {
		return SysmanageUtil.execAjaxResult(lyglService.uploadFj(request, dto));
	}

	/**
	 * 
	 * delFjIndex的中文名称：删除附件页面
	 * 
	 * delFjIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/delFj")
	@SuppressWarnings({ "rawtypes" })
	public void delFjIndex(HttpServletRequest request, @Param("..") Lyfj dto) throws Exception {
		// 页面初始化
		List fjList = lyglService.queryFjList(request, dto);
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
	 * @return Written by : sunyifeng
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object delFj(HttpServletRequest request, @Param("..") Lyfj dto) {
		return SysmanageUtil.execAjaxResult(lyglService.delFj(request, dto));
	}

	/**
	 * 
	 * lylhkhIndex的中文名称：两员量化考核页面
	 * 
	 * lylhkhIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : sunyifeng
	 * 
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lhkh/lylhkh")
	public void lylhkhIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *printLybadj的中文名称：两员备案表打印
	 * 
	 * printLybadj的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 */
	@At
	@Ok("jsp:/jsp/ncjtjc/lygl/printLybadj")
	@SuppressWarnings({ "rawtypes" })
	public Object printLybadj(HttpServletRequest request,@Param("..")LyDTO dto) {
		// 页面初始化
		Map map = new HashMap();
		try {
		map = lyglService.getLyRecord(request, dto);
		return SysmanageUtil.execAjaxResult(map, null);
	} catch (Exception e) {
		return SysmanageUtil.execAjaxResult(null, e);
	}
	}
	
}
