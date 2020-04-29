package com.askj.exam.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * ExamApiService的中文名称：【考试系统】api接口service
 * 
 * ExamApiService的描述：
 * 
 * @author ：zy
 * @version ：V1.0
 */
public class ExamApiService extends BaseService {
	public static final Log log = Logs.get();
	@Inject
	public Dao dao;
	
	/**
	 * 
	 * uploadFj的中文名称：附件上传
	 * 
	 * uploadFj的概要说明：
	 * 
	 * @param request
	 * @return 
	 * @author : zy
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	public Map uploadFj(HttpServletRequest request,UploadfjDTO dto) throws Exception {
		return uploadFjImp(request,dto);
	}

	/**
	 * 
	 * uploadFjImp的中文名称：附件上传实现
	 * 
	 * uploadFjImp的概要说明：
	 * 
	 * @param request
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Aop({ "trans" })
	public Map uploadFjImp(HttpServletRequest request,UploadfjDTO dto) throws Exception {
		// 附件上传保存目录
		String uplodaFileFolder = StringHelper.showNull2Empty(request.getParameter("folderName"));
		if ("".equals(uplodaFileFolder)) {
			uplodaFileFolder = "/upload/"; // 默认上传目录
		} else {
			uplodaFileFolder = "/upload/" + uplodaFileFolder + "/";
		}
		// 获取附件所属表id
		String v_id = StringHelper.showNull2Empty(dto.getFjwid());
		if ("".equals(v_id)) {
			v_id = "wuzhuti"; // 如果所属表id为空，定义为wuzhuti
			uplodaFileFolder = "/upload/linshi/"; // 将文件首先上传到临时文件夹
		}
		// 附件类别
		String v_fjType = StringHelper.showNull2Empty(dto.getFjtype());
		if ("".equals(v_fjType)) {
			v_fjType = "1"; // 默认为图片上传
		}
		
		// 上传文件路径
		String uploadPath = request.getSession().getServletContext().getRealPath(uplodaFileFolder);
		// 文件夹判断
		File path = new File(uploadPath);
		if (!path.exists()) {
			path.mkdirs();
        }
		// 读取上传附件
		Integer chunk = 0; // 分割块数
		Integer chunks = 1; // 总分割数
		// 支持多个附件同时上传
		List<String> fileName = new ArrayList<String>(); // 文件名
		List<String> tempFileName = new ArrayList<String>(); // 临时文件名
		List<String> newFileName = new ArrayList<String>(); // 最后合并后的新文件名
		BufferedOutputStream outputStream = null;
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				factory.setSizeThreshold(1024);
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setHeaderEncoding("UTF-8");
				List<FileItem> items = upload.parseRequest(request);
				// 区分表单域
				for (int i = 0; i < items.size(); i++) {
					FileItem fi = items.get(i);
					// 获取文件名
					tempFileName.add(fi.getName());
					if (tempFileName != null) {
						String chunkName = tempFileName.get(i);
						fileName.add(tempFileName.get(i));
						if (chunk != null) {
							chunkName = chunk + "_" + tempFileName.get(i);
						}
						File savedFile = new File(uploadPath, chunkName);
						fi.write(savedFile);
					}
				}
				for (int i = 0; i < tempFileName.size(); i++) {
					newFileName.add(UUID.randomUUID().toString().replace("-", "")
							.concat(".")
							.concat(FilenameUtils.getExtension(tempFileName.get(i))));
				}
				if (chunk != null && chunk + 1 == chunks) {
					for (int j = 0; j < newFileName.size(); j++) {
						outputStream = new BufferedOutputStream(
								new FileOutputStream(new File(uploadPath, newFileName.get(j))));
						// 遍历文件合并
						File tempFile = new File(uploadPath, "0_" + tempFileName.get(j));
						byte[] bytes = FileUtils.readFileToByteArray(tempFile);
						outputStream.write(bytes);
						outputStream.flush();
						tempFile.delete();
						outputStream.close();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (outputStream != null)
						outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		Map retMap = new HashMap(); // 返回数据
		List fjInfoList = new ArrayList(); // 附件信息
		for (int j = 0; j < newFileName.size(); j++) {
			// 将附件保存进数据库
			String fjpathString = uplodaFileFolder + newFileName.get(j);
			String fjnameString = fileName.get(j);
			String[] a = PubFunc.split(fjpathString, ",");
			String[] b = PubFunc.split(fjnameString, ",");
			
			for (int i = 0; i < a.length; i++) {
				List<Fj> fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", v_id)
						.and("FJTYPE", "=", v_fjType));
				// 获取aaa105字段（0：可以上传多张  1：只能上传一张）
				String flag = dao.query(Aa10.class, Cnd.where("AAA100", "=", "FJTYPE")
						.and("AAA102", "=", v_fjType)).get(0).getAaa105();
				// 根据附件类型，只能上传一张的，再次上传时更新
				if (fjList != null && fjList.size() > 0 && !"wuzhuti".equals(v_id) &&
						"1".equals(flag)) {
					Fj fj = fjList.get(0);
					fj.setFjpath(a[i]); // 附件保存路径
					fj.setFjname(b[i]); // 附件名称
					dao.update(fj); // 更新
					fjInfoList.add(fj);
				} else {
					Fj fj = new Fj();
					fj.setFjpath(a[i]); // 附件保存路径
					fj.setFjname(b[i]); // 附件名称
					// 附件类别
					String fjtype = PubFunc.getFileExt(b[i]);
					if ("1".equals(v_fjType) && !"".equals(fjtype)) {
						// 图片
						if (fjtype.equalsIgnoreCase("jpg")
								|| fjtype.equalsIgnoreCase("jpeg")
								|| fjtype.equalsIgnoreCase("png")
								|| fjtype.equalsIgnoreCase("gif")) {
							fj.setFjtype("1");
							// 视频
						} else if (fjtype.equalsIgnoreCase("mp4")
								|| fjtype.equalsIgnoreCase("avi")
								|| fjtype.equalsIgnoreCase("rm")
								|| fjtype.equalsIgnoreCase("rmvb")) {
							fj.setFjtype("3");
							// 文档
						} else {
							fj.setFjtype("2");
						}
					} else {
						fj.setFjtype(v_fjType);
					}
					fj.setFjwid(v_id); // 附件所属表id
					fj.setFjid(DbUtils.getSequenceStr()); // 附件id
					dao.insert(fj);
					fjInfoList.add(fj);
				}
			}
		}
		retMap.put("fjinfo", fjInfoList);
		return retMap;
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
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getFjList(HttpServletRequest request, FjDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjwid,fjpath,fjname,fjtype ");
		sb.append(" from Fj  ");
		sb.append(" where 1=1");
		sb.append(" and fjwid = :fjwid ");
		if(!"".equals(StringHelper.showNull2Empty(dto.getFjtype()))){
			sb.append(" and fjtype in (").append(dto.getFjtype()).append(")");
		}
		
		String sql = sb.toString();
		String[] paramName = new String[] { "fjwid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}
	
}
