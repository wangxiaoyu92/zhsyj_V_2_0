package com.askj.baseinfo.module;

import static com.lbs.leaf.util.ExcelUtil.exportMultiDataAsExcel;

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
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.upload.UploadAdaptor;

import com.askj.baseinfo.dto.ApprovePcompanyDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PcompanyXkzDTO;
import com.askj.baseinfo.dto.PcomqrcodeDTO;
import com.askj.baseinfo.service.PcompanyService;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.util.ExcelUtil;
import com.lbs.leaf.validate.ValidateData;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 企业基本信息 控制层
 * 
 * @author CatchU
 * 
 */
@IocBean
@At("/pcompany")
public class PcompanyModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(PcompanyModule.class);

	@Inject
	private PcompanyService pcompanyService;

	/**
	 * 跳转到用户管理信息页
	 */
	@At
	@Ok("jsp:/jsp/baseinfo/pcompany/pcompany")
	public void pcompanyIndex(HttpServletRequest request) {
		// 用户管理页面初始化
	}

	/**
	 * 跳转到企业信息管理页面详情
	 */
	@At
	@Ok("re:jsp:/jsp/baseinfo/pcompany/pcompanyForm")
//	@Ok("jsp:/jsp/baseinfo/pcompany/pcompanyForm")
	public String pcompanyFormIndex(HttpServletRequest request,@Param("querytype")String querytype) {
		if("jyjc".equals(querytype)){
			return "jsp:/jsp/jyjc/jyjgglForm";
		}else{
			return "jsp:/jsp/baseinfo/pcompany/pcompanyForm";
		}
		// 用于页面跳转
	}

	/**
	 * 企业导入
	 * @param request
     */
	@At
	@Ok("jsp:/jsp/baseinfo/pcompany/qydr")
	public void qydrIndex(HttpServletRequest request) {
		// 用于页面跳转
	}
	
	/**
	 * 查询所有企业信息并分页显示
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryCompany(HttpServletRequest request, @Param("..") PcompanyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = pcompanyService.queryCompany(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 查询企业信息
	 *
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryPcompanyDTO(HttpServletRequest request, @Param("..") PcompanyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = pcompanyService.queryCompany(request, dto, pd);
			List list = (List) map.get("rows");
			PcompanyDTO pcDto = null;
			if (list != null && list.size() > 0) {
				pcDto = (PcompanyDTO) list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 添加企业基本信息 完成的是注册功能
	 */
	@At
	@Ok("json")
	public Object savePcompany(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pcompanyService.savePcompany(request, dto);
			String qyid = dto.getComid();
			System.out.println(qyid);
			if (qyid != null) {
				result.put("qyid", qyid);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);
	}

	/**
	 * 企业排序置顶
	 */
	@At
	@Ok("json")
	public Object sort(HttpServletRequest request, @Param("..") PcompanyDTO dto,String i) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String str=pcompanyService.sort(request, dto, i);
			result.put("data",str);
			result.put("code","0");
			return result;
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
	}

	/**
	 * 企业排序置底
	 */
	@At
	@Ok("json")
	public Object bottom(HttpServletRequest request, @Param("..") PcompanyDTO dto,String i) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String str=pcompanyService.bottom(request, dto, i);
			result.put("data",str);
			result.put("code","0");
			return result;
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
	}

	/**
	 * 删除企业信息
	 * 
	 */
	@At
	@Ok("json")
	public Object delPcompany(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		return SysmanageUtil.execAjaxResult(pcompanyService.delPcompany(request, dto));
	}

	/**
	 * 企业信息审核通过
	 */
	@At
	@Ok("json")
	public Object examPass(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
		return SysmanageUtil.execAjaxResult(pcompanyService.examPass(request, dto));
	}

	/**
	 * 
	 * queryPcomdqTree的中文名称：按easyui tree格式查询地区树
	 * 
	 * queryPcomdqTree的概要说明:
	 * 
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryPcomdqTree(HttpServletRequest request) throws Exception {
		try {
			return pcompanyService.queryPcomdqTree(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
	}

	/**
	 * 
	 * MakeCompanyLngLat的中文名称：批量自动生成企业经纬度坐标
	 * 
	 * MakeCompanyLngLat的概要说明：    
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object MakeCompanyLngLat(HttpServletRequest request, @Param("..") PcompanyDTO dto, 
			@Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = pcompanyService.queryCompany(request, dto, pd);
			List ls = (List) map.get("rows");
			if (ls != null && ls.size() > 0) {
				for (int i = 0; i < ls.size(); i++) {
					PcompanyDTO pcompanyDTO = (PcompanyDTO) ls.get(i);
					pcompanyService.MakeCompanyLngLat(pcompanyDTO);
				}
			}
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * MakeCompanyLngLatBatch的中文名称：批量自动生成企业经纬度坐标  有地址 但经纬度为空的
	 * 
	 * MakeCompanyLngLatBatch的概要说明：    
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object MakeCompanyLngLatBatch() {
		Map map = new HashMap();
		try {
			pcompanyService.MakeCompanyLngLatBatch();
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}	

	/**
	 * 
	 *  downLoadExcel的中文名称：企业信息导入模板下载
	 *
	 *  downLoadExcel的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written  by  : zjf
	 *
	 */
	@At
	@Ok("raw")
	public File downLoadExcel(HttpServletRequest request, @Param("..") PcompanyDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();

		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "企业基本信息导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			PcompanyDTO pcdto = new PcompanyDTO();
			List<PcompanyDTO> lst = new ArrayList<PcompanyDTO>();
			lst.add(pcdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("企业基本信息", "PcompanyDTO", lst, false);
			ExportedExcelDataInfo exd1 = SysmanageUtil.createExcelWorkSheet("COMDALEI");// 企业大类
			ExportedExcelDataInfo exd2 = SysmanageUtil.createExcelWorkSheetOfTcq(sysuser.getAaa027());// 企业统筹区
			ExportedExcelDataInfo exd3 = SysmanageUtil.createExcelWorkSheet("COMZZZM");// 资质证明类型
			ExportedExcelDataInfo exd4 = SysmanageUtil.createExcelWorkSheet("COMDRTXSM");//单位导入填写说明

			lstExd.add(exd);
			lstExd.add(exd1);
			lstExd.add(exd2);
			lstExd.add(exd3);
			lstExd.add(exd4);
			file = exportMultiDataAsExcel(lstExd, fileFolderName + File.separator + filename + System.currentTimeMillis() + ".xls", true);

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
	 *  upLoadExcel的中文名称：上传企业导入信息
	 *
	 *  upLoadExcel的概要说明：
	 *
	 *  @param request
	 *  @param dto
	 *  @param f
	 *  @return
	 *  @throws Exception
	 *  Written  by  : zjf
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/WEB-INF/tmp" })
	public Object upLoadExcel(HttpServletRequest request, @Param("..")PcompanyDTO dto,
			@Param("filepath") File f) throws Exception {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcelConvertCode(inputStream, "PcompanyDTO");
			//vali = ExcelUtil.getDataFromExcel(inputStream, "lingbaoDTO");

			// 数据逻辑校验
			vali = pcompanyService.checkUpLoadXls(request, vali, dto);

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
	 * 
	 *  savePcompanydr的中文名称：保存导入的企业信息
	 *
	 *  savePcompanydr的概要说明：
	 *
	 *  @param request
	 *  @return
	 *  Written  by  : zjf
	 *
	 */
	@At
	@Ok("json")
	public Object savePcompanydr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");

		System.out.println("succJsonStr "+succJsonStr);
		return SysmanageUtil.execAjaxResult(pcompanyService.savePcompanydr(request, succJsonStr));
	}
	
	/**
	 * 
	 *  exportToExcel的中文名称：导出错误信息
	 *
	 *  exportToExcel的概要说明：
	 *
	 *  @param request
	 *  @param cldto
	 *  @return
	 *  @throws Exception
	 *  Written  by  : zjf
	 *
	 */
	@SuppressWarnings("unused")
	@At
	@Ok("raw")
	public File exportToExcel(HttpServletRequest request, @Param("..") PcompanyDTO cldto) throws Exception {
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
			errorJsonStr = new String(errorJsonStr.getBytes("ISO-8859-1"), "UTF-8"); // 编码转换
			List<PcompanyDTO> lst = Json.fromJsonAsList(PcompanyDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("企业基本信息", "PcompanyDTO", lst, true);
			ExportedExcelDataInfo exd6 = SysmanageUtil.createExcelWorkSheet("COMDALEI");

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
	 * 查询企业资质证件信息
	 *
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryPcompanyXkzDTO(HttpServletRequest request, 
			@Param("..")PcompanyXkzDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			map = pcompanyService.queryPcompanyXkz(dto,pd);
			List list = (List) map.get("rows");
			PcompanyXkzDTO pcDto = null;
			if (list != null && list.size() > 0) {
				pcDto = (PcompanyXkzDTO) list.get(0);
			}
			map.put("data", pcDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		
	}

	/**
	 * 保存企业资质证件信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object savePcompanyXkzDTO(HttpServletRequest request, 
			@Param("succJsonStr")String succJsonStr, @Param("comid") String comid ) {

		Map map = new HashMap();
		try {
			List xkzList = pcompanyService.addXkz(succJsonStr, comid);
			map.put("xkzList", xkzList);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 保存企业资质证件信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object savePcompanyXkzSingle(HttpServletRequest request,@Param("..")PcompanyXkzDTO dto) throws Exception {
		return SysmanageUtil
				.execAjaxResult(pcompanyService.savePcompanyXkzSingle(request, dto));
	}	

	/**
	 * 保存企业资质证件信息
	 *
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object delPcompanyXkzDTO(HttpServletRequest request,@Param("..")PcompanyXkzDTO dto ) throws Exception {
		return SysmanageUtil
				.execAjaxResult(pcompanyService.delXkz(request,dto));
	}
	
	/**
	 * 
	 * queryCompanyQRcode的中文名称：查询企业二维码
	 * 
	 * queryCompanyQRcode的概要说明：
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	public Object queryCompanyQRcode(HttpServletRequest request, @Param("..")PcomqrcodeDTO dto) {
		Map map = new HashMap();
		try {
			map = pcompanyService.queryCompanyQRcode(request, dto);
			List list = (List) map.get("rows");
			PcomqrcodeDTO v_dto = null;
			if (list != null && list.size() > 0) {
				v_dto = (PcomqrcodeDTO) list.get(0);
			}
			map.put("data", v_dto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object createComQRcode(HttpServletRequest request) {
		Map map = new HashMap();
		try {
			pcompanyService.createComQRcode(request);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			e.printStackTrace();
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * savePcompanyQRcode的中文名称：保存企业二维码
	 * 
	 * savePcompanyQRcode的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	public Object savePcompanyQRcode(HttpServletRequest request, @Param("..")PcomqrcodeDTO dto) {
		return SysmanageUtil.execAjaxResult(pcompanyService.savePcompanyQRcode(request, dto));
	}
	
	/**
	 * 
	 * createCompanyQRcodes的中文名称：批量生成企业二维码
	 * 
	 * createCompanyQRcodes的概要说明：
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@At
	@Ok("json")
	@SuppressWarnings("rawtypes")
	public Object createCompanyQRcodes(HttpServletRequest request, 
			@Param("..") PcompanyDTO dto, @Param("..") PagesDTO pd) {
		Map map = new HashMap();
		try {
			// 获取到权限范围内可以操作的企业
			dto.setQuerytype("createComQrcode");
			map = pcompanyService.queryCompany(request, dto, pd);
			List ls = (List) map.get("rows");
			if (ls != null && ls.size() > 0) {
				for (int i = 0; i < ls.size(); i++) {
					PcompanyDTO pcompanyDTO = (PcompanyDTO) ls.get(i);
					pcompanyService.createCompanyQRcodes(request, pcompanyDTO);
				}
			}
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 跳转到资质证明界面
	 */
	@At
	@Ok("jsp:/jsp/baseinfo/pcompany/pcomZzzmForm")
	public void pcomZzzmFormIndex(HttpServletRequest request) {

	}
	
	/**
	 * 
	 * importApproveComIndex的中文名称：审批企业导入页面初始化
	 * 
	 * importApproveComIndex的概要说明：
	 *
	 * @param request
	 * @author : zy
	 */
	@At
	@Ok("jsp:/jsp/baseinfo/pcompany/importApproveCom")
	public void importApproveComIndex(HttpServletRequest request) {
		// 用于页面跳转
	}
	
	/**
	 * 
	 * downLoadApproveExcel的中文名称：下载导入模板
	 * 
	 * downLoadApproveExcel的概要说明：行政审批企业模板
	 *
	 * @param request
	 * @param dto 行政审批企业
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("raw")
	public File downLoadApproveExcel(HttpServletRequest request, @Param("..") ApprovePcompanyDTO dto) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		// excel文件在服务器上的临时存储目录
		String filepath = request.getSession().getServletContext().getRealPath(GlobalNameS.DOWNLOAD_FILE_PATH);
		FileUtil.createFolder(filepath);
		String filename = "行政审批企业基本信息导入";
		String fileFolderName = filepath + File.separator + sysuser.getUserid() + File.separator + "[" + filename + "]";
		FileUtil.createFolder(fileFolderName);
		File file;
		try {
			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ApprovePcompanyDTO pcdto = new ApprovePcompanyDTO();
			List<ApprovePcompanyDTO> lst = new ArrayList<ApprovePcompanyDTO>();
			lst.add(pcdto);
			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("企业基本信息", "ApprovePcompanyDTO", lst, false);

			lstExd.add(exd);
			file = exportMultiDataAsExcel(lstExd, fileFolderName + File.separator 
					+ filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename 
					+ "_下载模版时的异常信息" + System.currentTimeMillis() + ".txt");
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
	 * upLoadApproveComExcel的中文名称：上传导入企业信息
	 * 
	 * upLoadApproveComExcel的概要说明：行政审批企业信息
	 *
	 * @param request
	 * @param dto
	 * @param f
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@At
	@Ok("json")
	@AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/WEB-INF/tmp" })
	public Object upLoadApproveComExcel(HttpServletRequest request, @Param("..")ApprovePcompanyDTO dto,
			@Param("filepath") File f) {
		try {
			ValidateData vali;
			final String filepath = f.getPath();

			// 定义数据流对象
			final InputStream inputStream = new FileInputStream(filepath);
			// 数据格式校验
			vali = ExcelUtil.getDataFromExcel(inputStream, "ApprovePcompanyDTO");

			// 数据逻辑校验
			vali = pcompanyService.checkApproveUpLoadXls(request, vali, dto);

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
	 * 
	 * exportApproveToExcel的中文名称：导出错误数据
	 * 
	 * exportApproveToExcel的概要说明：审批企业数据导出
	 *
	 * @param request
	 * @param cldto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@At
	@Ok("raw")
	public File exportApproveToExcel(HttpServletRequest request, @Param("..") ApprovePcompanyDTO cldto) throws Exception {
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
			errorJsonStr = new String(errorJsonStr.getBytes("ISO-8859-1"), "UTF-8"); // 编码转换
			List<ApprovePcompanyDTO> lst = Json.fromJsonAsList(ApprovePcompanyDTO.class, errorJsonStr);

			// excel数据源
			final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();

			ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("企业基本信息", "ApprovePcompanyDTO", lst, true);

			lstExd.add(exd);

			file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileFolderName + File.separator 
					+ filename + System.currentTimeMillis() + ".xls", true);

			return file;
		} catch (Exception e) {
			file = new File(fileFolderName + File.separator + filename + "_导出时的异常信息" 
					+ System.currentTimeMillis() + ".txt");
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
	 * saveApprovePcompanydr的中文名称：保存导入企业
	 * 
	 * saveApprovePcompanydr的概要说明：审批企业
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	@At
	@Ok("json")
	public Object saveApprovePcompanydr(HttpServletRequest request) {
		String succJsonStr = request.getParameter("succJsonStr");
		return SysmanageUtil.execAjaxResult(pcompanyService.saveApprovePcompanydr(request, succJsonStr));
	}
	
	/**
	 * 汝州企业数据入库
	 */
	@At
	@Ok("json")
	public void RuZhouComDataRuku(HttpServletRequest request)  {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pcompanyService.RuZhouComDataRuku(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	/**
	 * 灵宝企业数据入库
	 */
	@At
	@Ok("json")
	public void LingBaoComDataRuku(HttpServletRequest request)  {
		Map<String, String> result = new HashMap<String, String>();
		try {
			pcompanyService.LingBaoComDataRuku(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}



	
	/**
	 * 获取省局企业数据
	 * request需要传入6位的省局库中的地区编码aaa027参数
	 */
	@At
	@Ok("json")
	public void getComDataFromSJ(HttpServletRequest request)  {
		try {
			pcompanyService.getComDataFromSJ(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	
	/**
	 * 获取省局许可证数据
	 * request需要传入6位的省局库中的地区编码aaa027参数
	 */
	@At
	@Ok("json")
	public void getXkzDataFromSJ(HttpServletRequest request)  {
		try {
			pcompanyService.getXkzDataFromSJ(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	};
	
	/**
	 * 根据获取的省局数据，插入或更新本地企业信息和许可证信息
	 * prm_orgid,机构编码，在根据日常监督管理员，产生操作员信息时用到,传入相应的食药监下的一个机构id
	 * prm_aaa027 是我们系统中的12位地区编码，在自动产生操作员时用到
	 * prm_orgid 是在我们系统中新增的该地区的机构编码，在自动产生操作员时用到
	 */
	@At
	@Ok("json")
	public void sjdateToLocalData(HttpServletRequest request,
			 @Param("aaa027")String prm_aaa027
			,@Param("orgid")String prm_orgid)  {
		try {
			pcompanyService.sjdateToLocalData(request,prm_aaa027,prm_orgid);
		} catch (Exception e) {
			e.printStackTrace();
		}
	};

	
}
