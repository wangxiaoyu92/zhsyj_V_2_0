package com.askj.ncjtjc.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.zzhdsoft.siweb.entity.Fj;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.ValidateData;
import com.lbs.leaf.validate.ValidateData.ErrorItem;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.CsDTO;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.ncjtjc.entity.Cs;
import com.askj.ncjtjc.entity.Csfj;
import com.askj.ncjtjc.entity.Cszp;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.PinYinUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * CsglService的中文名称：厨师管理service
 * 
 * CsglService的描述：
 * 
 * Written by : zjf
 */
public class CsglService extends BaseService {
	protected final Logger logger = Logger.getLogger(CsglService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryCs的中文名称：查询厨师
	 * 
	 * queryCs的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCs(CsDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select csid,csbh,csxm,cspym,csxb,cscsrq,cssjh,");
		sb.append(" cssfzjlx,cssfzjhm,cswhcd,csjtzz,cshkszd,csyx,csqq,cswx,");
		sb.append(" cscynx,csjkzm,csjkzyxq,csjktjdd,cspxqk,cspxhgzyxq,cssflx,csfwdbh,csfwqy,");
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,");
		sb.append(" comxianmc,comxiangdm,comxiangmc,comcundm,comcunmc,aab301,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100  ='AAC011' AND AAA102=a.cswhcd) cswhcdstr,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100  ='AAC058' AND AAA102=a.cssfzjlx) cssfzjlxstr,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100  ='JKZM' AND AAA102=a.csjkzm) csjkzmstr,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100  ='RYPXQK' AND AAA102=a.cspxqk) cspxqkstr,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100  ='CYNX' AND AAA102=a.cscynx) cscynxstr,");
		sb.append(" aaa027,(select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" orgid,(select orgname from Sysorg where orgid = a.orgid) orgname,");
		sb.append(" (select username from Sysuser where userid = a.aae011) as aae011,aae036,aae013");
		sb.append("  from Cs a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.csid = :csid ");
		sb.append("  and  a.csbh = :csbh ");
		sb.append("  and  a.csxm = :csxm ");
		sb.append("  and  a.cspym = :cspym ");
		sb.append("  and  a.cssfzjhm = :cssfzjhm ");
		if (Strings.isNotBlank(dto.getJcsbid())) {
			sb.append("  and NOT EXISTS (select b.csid from jcsbcs b where a.csid=b.csid and b.jcsbid= :jcsbid ) ");
		}
		sb.append("  and  a.aaa027 like :aaa027");
		sb.append("  order by a.csid ");
		String[] ParaName = new String[] { "csid", "csbh", "csxm", "cspym", "cssfzjhm", "jcsbid", "aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		System.out.println("sql " + sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, CsDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	@SuppressWarnings({ "rawtypes" })
	public String getCszp(HttpServletRequest request, CsDTO dto) throws Exception {
		String filePath = null;
		try {
			String sql = "select cszp from Cszp where csid = :csid";
			String[] ParaName = new String[] { "csid" };
			int[] ParaType = new int[] { Types.LONGVARCHAR };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, CsDTO.class);
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);

			if (ls != null && ls.size() > 0) {
				CsDTO pdto = (CsDTO) ls.get(0);
				String cszp = pdto.getCszp();
				if (!Strings.isBlank(cszp)) {
					byte b[] = Base64.base64ToByteArray(cszp);
					String rootPath = request.getSession().getServletContext().getRealPath(GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH);
					FileUtil.createFolder(rootPath);

					String fileName = String.valueOf(dto.getCsid());
					filePath = rootPath + File.separator + fileName + ".jpg";

					File file = new File(filePath);
					FileOutputStream fos = new FileOutputStream(file);
					fos.write(b);
					fos.close();
				}
			}

			return filePath;
		} catch (Exception e) {
			throw new BusinessException("获取照片信息失败：" + e.getMessage());
		}
	}

	/**
	 * 
	 * queryCszp的中文名称：查询厨师照片信息
	 * 
	 * queryCszp的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public Cszp queryCszp(HttpServletRequest request, CsDTO dto) {
		Condition cnd = Cnd.where("csid", "=", dto.getCsid());
		List<Cszp> ls = dao.query(Cszp.class, cnd);
		if (ls != null && ls.size() > 0) {
			return ls.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 
	 * isExistsCs的中文名称：校验证件号码是否已经登记过
	 * 
	 * isExistsCs的概要说明：身份证号唯一
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public String isExistsCs(CsDTO dto) throws Exception {
		// 校验厨师身份证号是否已经存在
		PagesDTO pd = new PagesDTO();
		CsDTO csDTO = new CsDTO();
		csDTO.setCssfzjhm(dto.getCssfzjhm());
		Map m = queryCs(csDTO, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			CsDTO pdto = (CsDTO) ls.get(0);
			final StringBuffer sb = new StringBuffer();
			sb.append("您登记的厨师信息：证件号码【");
			sb.append(pdto.getCssfzjhm());
			sb.append("】姓名【");
			sb.append(pdto.getCsxm());
			sb.append("】已登记过，请勿重复登记！");
			return sb.toString();
		}
		return null;
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
	public String addCs(HttpServletRequest request, CsDTO dto) {
		String csid="";
		try {
			String flag;
			flag = isExistsCs(dto);
			if (flag != null) {
				return flag;
			}
			csid = addCsImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return csid;
	}

	@Aop( { "trans" })
	public String addCsImp(HttpServletRequest request, CsDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String csid="";
		Cs cs = new Cs();
		BeanHelper.copyProperties(dto, cs);
		cs.setCsid(DbUtils.getSequenceStr());
		cs.setCsbh(DbUtils.getOneValue(dao, "select getCsbh() from dual"));
		//cs.setAae011(SysmanageUtil.getSysuser().getUserid());
		cs.setAae036(startTime);
		dao.insert(cs);
		csid=cs.getCsid();
		dto.setCsid(cs.getCsid());

		// 将照片保存至数据库
		String filePath = dto.getFilepath();
		if (!Strings.isBlank(filePath)) {
			String rootPath = request.getSession().getServletContext().getRealPath(GlobalNameS.CAMERA_UPLOAD_FILE_PATH);
			int pfindex = filePath.lastIndexOf("/");
			String fileName = filePath.substring(pfindex + 1);
			dto.setFilepath(rootPath + File.separator + fileName);

			File file = new File(dto.getFilepath());
			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);

			Cszp cszp = queryCszp(request, dto);
			if (cszp == null) {
				cszp = new Cszp();
				cszp.setCszpid(DbUtils.getSequenceStr());
				cszp.setCsid(dto.getCsid());
				cszp.setCszp(fis);
				dao.insert(cszp);
			} else {
				cszp.setCszp(fis);
				dao.update(cszp);
			}

			fis.close();
			// 删除服务器端的照片信息
			if (file.exists()) {
				file.delete();
			}
		}

		// 自动生成系统用户
		Sysuser sysuser = new Sysuser();
		String userid = DbUtils.getSequenceStr();
		String password = MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase();
		sysuser.setUserid(userid);
		sysuser.setPasswd(password);
		sysuser.setLockstate("0");
		sysuser.setUserkind("11");
		sysuser.setAaa027(cs.getAaa027());//
		sysuser.setOrgid(cs.getOrgid());//
		sysuser.setDescription("厨师：" + cs.getCsxm());
		sysuser.setUsername(cs.getCsbh());
		sysuser.setMobile(cs.getCssjh());
		sysuser.setAac002(cs.getCssfzjhm());
		sysuser.setAac003(cs.getCsxm());
		sysuser.setAaz010(cs.getCsid());
		dao.insert(sysuser);

//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
		return csid;
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
	public String updateCs(HttpServletRequest request, CsDTO dto) {
		try {
			String flag;
			Cs cs = dao.fetch(Cs.class, dto.getCsid());
			if (!(cs.getCssfzjhm()).equalsIgnoreCase(dto.getCssfzjhm())) {
				flag = isExistsCs(dto);
				if (flag != null) {
					return flag;
				}
			}

			updateCsImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@SuppressWarnings({ "rawtypes" })
	@Aop( { "trans" })
	public void updateCsImp(HttpServletRequest request, CsDTO dto) throws Exception {
//		Timestamp startTime = SysmanageUtil.currentTime();

		Cs cs = dao.fetch(Cs.class, dto.getCsid());
		BeanHelper.copyProperties(dto, cs);
		dao.update(cs);

		// 将照片保存至数据库
		String filePath = dto.getFilepath();
		if (!Strings.isBlank(filePath)) {
			String rootPath = request.getSession().getServletContext().getRealPath(GlobalNameS.CAMERA_UPLOAD_FILE_PATH);
			int pfindex = filePath.lastIndexOf("/");
			String fileName = filePath.substring(pfindex + 1);
			dto.setFilepath(rootPath + File.separator + fileName);

			File file = new File(dto.getFilepath());
			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);

			Cszp cszp = queryCszp(request, dto);
			if (cszp == null) {
				cszp = new Cszp();
				cszp.setCszpid(DbUtils.getSequenceStr());
				cszp.setCsid(dto.getCsid());
				cszp.setCszp(fis);
				dao.insert(cszp);
			} else {
				cszp.setCszp(fis);
				dao.update(cszp);
			}

			fis.close();
			// 删除服务器端的照片信息
			if (file.exists()) {
				file.delete();
			}
		}

		// 自动更新系统用户
		List sysuserList = dao.query(Sysuser.class, Cnd.where("username", "=", dto.getCsbh()));
		if (sysuserList != null && sysuserList.size() > 0) {
			Sysuser sysuser = (Sysuser) sysuserList.get(0);
			sysuser.setAaa027(cs.getAaa027());
			sysuser.setOrgid(cs.getOrgid());
			sysuser.setMobile(cs.getCssjh());
			sysuser.setAac002(cs.getCssfzjhm());
			sysuser.setAac003(cs.getCsxm());
			dao.update(sysuser);
		}

//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public String delCs(HttpServletRequest request, final CsDTO dto) {
		try {
			if (null != dto.getCsid()) {
				// 检查是否可删除
				delCsImp(request, dto);
			} else {
				return "没有接收到要删除的厨师ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@SuppressWarnings({ "rawtypes" })
	@Aop( { "trans" })
	public void delCsImp(HttpServletRequest request, final CsDTO dto) {
		// 删除厨师
		dao.clear(Cs.class, Cnd.where("csid", "=", dto.getCsid()));
		// 删除厨师照片
		dao.clear(Cszp.class, Cnd.where("csid", "=", dto.getCsid()));
		// 删除厨师附件		
		List fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getCsid()).and("fjcsdmz", "like", "CSDJBAFJ%"));
		if (fjList != null && fjList.size() > 0) {
			for (int i = 0; i < fjList.size(); i++) {
				Fj fj = (Fj) fjList.get(i);
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				fj.setFjpath(rootPath + File.separator + fj.getFjpath());
				File file = new File(fj.getFjpath());
				if (file.exists()) {
					file.delete();
				}
				dao.delete(fj);
			}
		}
		// 自动删除系统用户
		List sysuserList = dao.query(Sysuser.class, Cnd.where("username", "=", dto.getCsbh()));
		if (sysuserList != null && sysuserList.size() > 0) {
			Sysuser sysuser = (Sysuser) sysuserList.get(0);
			dao.delete(sysuser);
		}
	}

	/**
	 * 
	 * checkUpLoadXls的中文名称：对上传的excel进行数据逻辑校验
	 * 
	 * checkUpLoadXls的概要说明:
	 * 
	 * @param vali
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ValidateData checkUpLoadXls(HttpServletRequest request, ValidateData vali, CsDTO dto) throws Exception {
		// 处理正确数据
		if (vali.getCorrectData().size() > 0) {
			int i = 0;
			// 遍历文件记录
			while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
				final CsDTO wdto = (CsDTO) vali.getCorrectData().get(i);
				wdto.setCspym(PinYinUtil.GetChineseSpell(wdto.getCsxm()));
				wdto.setCscsrq(DateUtil.getBirtday(wdto.getCssfzjhm()));
				wdto.setCsxb(DateUtil.getGender(wdto.getCssfzjhm()));
				wdto.setCssfzjlx("1");

				// 校验代码
				BeanHelper.copyProperties(wdto, dto);
				String errorMsg = isExistsCs(dto);
				if (errorMsg != null) {
					ErrorItem item = new ErrorItem();
					item.setErrorData(wdto);
					item.addErrorMsg("cssfzjhm", errorMsg);
					vali.addErrorItem(item);
					vali.getCorrectData().remove(i);// 移除不匹配的记录
				} else {
					i++;
					// 校验是否有重复记录
					for (int j = i; j < vali.getCorrectData().size(); j++) {
						final CsDTO wdto2 = (CsDTO) vali.getCorrectData().get(j);
						if (wdto2.getCssfzjhm().equals(wdto.getCssfzjhm())) {
							throw new BusinessException("上传文件记录中存在重复的厨师信息，重复的身份证号为【" + wdto2.getCssfzjhm() + "】");
						}
					}
				}
			}
		}

		// 处理错误数据
		if (vali.getErrData().size() > 0) {
			final List errorList = new ArrayList();
			for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
				final ErrorItem itm = (ErrorItem) it.next();
				final CsDTO wdto = (CsDTO) itm.getErrorData();
				wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
				errorList.add(wdto);
			}
			vali.setErrData(errorList);
		}
		return vali;
	}

	/**
	 * 
	 * saveCsdr的中文名称：保存厨师导入信息
	 * 
	 * saveCsdr的概要说明:
	 * 
	 * @param succJsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String saveCsdr(HttpServletRequest request, String succJsonStr) {
		try {
			saveCsdrImp(request, succJsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveCsdrImp(HttpServletRequest request, String succJsonStr) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String aaa027 = SysmanageUtil.getSysuser().getAaa027();
		String orgid = SysmanageUtil.getSysuser().getOrgid();

		List<CsDTO> lst = Json.fromJsonAsList(CsDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			CsDTO dto = (CsDTO) lst.get(i);
			Cs cs = new Cs();
			BeanHelper.copyProperties(dto, cs);
			cs.setCsid(DbUtils.getSequenceStr());
			cs.setCsbh(DbUtils.getOneValue(dao, "select getCsbh() from dual"));
			cs.setAae011(SysmanageUtil.getSysuser().getUserid());
			cs.setAae036(startTime);
			dao.insert(cs);

			// 自动生成系统用户
			Sysuser sysuser = new Sysuser();
			String userid = DbUtils.getSequenceStr();
			String password = MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase();
			sysuser.setUserid(userid);
			sysuser.setPasswd(password);
			sysuser.setLockstate("0");
			sysuser.setUserkind("11");
			sysuser.setAaa027(aaa027);
			sysuser.setOrgid(orgid);
			sysuser.setDescription("厨师：" + cs.getCsxm());
			sysuser.setUsername(cs.getCsbh());
			sysuser.setMobile(cs.getCssjh());
			sysuser.setAac002(cs.getCssfzjhm());
			sysuser.setAac003(cs.getCsxm());
			sysuser.setAaz010(cs.getCsid());
			dao.insert(sysuser);
		}
//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
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
	public String uploadFj(HttpServletRequest request, final Csfj dto) {
		try {
			uploadFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjImp(HttpServletRequest request, Csfj dto) throws Exception {
		String csid = StringHelper.showNull2Empty(request.getParameter("csid"));
		if ("".equals(csid)) {
			throw new BusinessException("入参厨师ID不能为空！");
		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Csfj fj = new Csfj();
			fj.setFjpath(a[i]);
			fj.setFjname(b[i]);

			String fjtype = PubFunc.getFileExt(b[i]);
			if (!"".equals(fjtype)) {
				if (fjtype.equalsIgnoreCase("jpg") || fjtype.equalsIgnoreCase("jpeg") || fjtype.equalsIgnoreCase("png")
						|| fjtype.equalsIgnoreCase("gif")) {
					fj.setFjtype("1");
				} else {
					fj.setFjtype("2");
				}
			}
			fj.setCsid(csid);
			final Long fjid = DbUtils.getSequenceL("sq_fjid");
			fj.setFjid(fjid);
			dao.insert(fj);

			// 将图片保存至数据库
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			File file = new File(rootPath + File.separator + fj.getFjpath());

			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);
			fj.setFjcontent(fis);// ???
			dao.update(fj);
			fis.close();
		}
	}

	/**
	 * 
	 * queryFjList的中文名称：查询附件
	 * 
	 * queryFjList的概要说明：判断应用服务器上是否存在附件副本【如果不存在，自动根据数据库记录生成附件副本！】
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List queryFjList(HttpServletRequest request, Csfj dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjpath,fjcontent,fjname,fjtype,csid ");
		sb.append("  from Csfj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and csid = :csid");
		String[] ParaName = new String[] { "fjid", "csid" };
		int[] ParaType = new int[] { Types.LONGVARCHAR, Types.LONGVARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, CsDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				CsDTO pdto = (CsDTO) ls.get(i);
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				String fjpath = rootPath + File.separator + pdto.getFjpath();
				if (!FileUtil.checkFile(fjpath)) {
					String fjcontent = pdto.getFjcontent();
					if (!Strings.isBlank(fjcontent)) {
						byte b[] = Base64.base64ToByteArray(fjcontent);

						File file = new File(fjpath);
						FileOutputStream fos = new FileOutputStream(file);
						fos.write(b);
						fos.close();
					}
				}
			}
		}

		return ls;
	}

	/**
	 * 
	 * delFj的中文名称：删除附件
	 * 
	 * delFj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delFj(HttpServletRequest request, final Csfj dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final Csfj dto) {
		String fjidStr = dto.getFjname();
		String[] a = PubFunc.split(fjidStr, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件
			Csfj fj = dao.fetch(Csfj.class, Cnd.where("fjid", "=", a[i]));

			String rootPath = request.getSession().getServletContext().getRealPath("/");
			fj.setFjpath(rootPath + File.separator + fj.getFjpath());
			File file = new File(fj.getFjpath());
			if (file.exists()) {
				file.delete();
			}
			dao.delete(fj);
		}
	}

	/**
	 * 
	 * getCsRecord的中文名称：查询备案明细表
	 * 
	 * getCsRecord的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception 
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getCsRecord(HttpServletRequest request, final CsDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		Map map = new HashMap();
		sb.append(" select csid,csbh,csxm,cspym,cscsrq,cssjh,cssfzjlx,cssfzjhm, ");
		sb.append("  getAa10_aaa103('AAC004',csxb) csxb,");
		sb.append(" getAa10_aaa103('AAC011',cswhcd) cswhcd,");
		sb.append("  getAa10_aaa103('JKZM',csjkzm) csjkzm,");
		sb.append(" getAa10_aaa103('CYNX',cscynx) cscynx,");
		sb.append(" getAa10_aaa103('PXQK',cspxqk) cspxqk,");
		sb.append("  csjtzz,cshkszd,csyx,csqq,cswx,csjkzyxq,csjktjdd,cspxhgzyxq,cssflx,csfwdbh,csfwqy,");
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,comxianmc,");
		sb.append("  comxiangdm,comxiangmc,comcundm,comcunmc,");
		sb.append("  (select username from Sysuser where userid = a.aae011) as aae011,");
		sb.append("  date_format(aae036,'%Y-%m-%d') aae036,aae013 ");
		sb.append("  from Cs a where 1=1 and  a.csid = :csid ");
		String[] ParaName = new String[] {"csid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, CsDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		if(ls.size()>0){
			CsDTO csbean = (CsDTO) ls.get(0);
			String contextPath = request.getContextPath();
			String basePath = request.getScheme() + "://"
			    + request.getServerName() + ":" + request.getServerPort()
			    + contextPath + "/";
			String fileCtxPath = basePath + "/images/default.jpg";
			String filePath = getCszp(request, dto);
			if (!Strings.isBlank(filePath)) {
				int pfindex = filePath.lastIndexOf("\\");
				String fileName = filePath.substring(pfindex + 1);
				fileCtxPath = basePath + GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH + File.separator + fileName;
			}
			csbean.setFilepath(fileCtxPath);
				//获取页面
			String html = setCsValue(csbean, "csRecord", "1");
			map.put("data", html);
		}else {
			map.put("data", "");
		}
		return map;
	
}
	public String  setCsValue(CsDTO dto,String tbodytype ,String tbodycode) throws Exception{
		BsTbodyInfoDTo bodydto = new BsTbodyInfoDTo();
		String  html ="";
		bodydto.setTbodycode(tbodycode);
		bodydto.setTbodytype(tbodytype);
		bodydto = getTbodyInfoHtml(bodydto);
		if(bodydto!=null){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String aaa036 = "";
			if(dto.getAae036()!=null&&!"".equals(dto.getAae036())){
				 aaa036= formatter.format(dto.getAae036());
			}
			
//			String img = "<img style='height=:119px;width=:115px' src='http://127.0.0.1:8080/syjzhpt/images/default.jpg'  />";
			String img = "<img style='height=:119px;width=:115px' src='"+dto.getFilepath()+"'  />";
			
			html = bodydto.getTbodyinfo().replaceFirst("csbh", dto.getCsbh()==null?"":dto.getCsbh())
					.replaceFirst("comxianmc", dto.getComxianmc()==null?"":dto.getComxianmc())
					.replaceFirst("comxiangmc", dto.getComxiangmc()==null?"":dto.getComxiangmc())
					.replaceFirst("comcunmc", dto.getComcunmc()==null?"":dto.getComcunmc())
					.replaceFirst("csxm", dto.getCsxm()==null?"":dto.getCsxm())
					.replaceFirst("csxb", dto.getCsxb()==null?"":dto.getCsxb())
					.replaceFirst("cscsrq", dto.getCscsrq()==null?"":DateUtil.getYear("yyyyMMdd", dto.getCscsrq()))
					.replaceFirst("cssjh", dto.getCssjh()==null?"":dto.getCssjh())
					.replace("csimg", img)
					.replaceFirst("cssfzjhm", dto.getCssfzjhm()==null?"":dto.getCssfzjhm())
					.replaceFirst("csjtzz", dto.getCsjtzz()==null?"":dto.getCsjtzz())
					.replaceFirst("csfwqy", dto.getCsfwqy()==null?"":dto.getCsfwqy())
					.replaceFirst("cswhcd", dto.getCswhcd()==null?"":dto.getCswhcd())
					.replaceFirst("cspxqk", dto.getCspxqk()==null?"":dto.getCspxqk())
					.replaceFirst("cscynx", dto.getCscynx()==null?"":dto.getCscynx())
					.replaceFirst("csjkzm", dto.getCsjkzm()==null?"":dto.getCsjkzm())
					.replaceFirst("csjkzyxq", dto.getCsjkzyxq()==null?"":dto.getCsjkzyxq())
					.replaceFirst("csjktjdd", dto.getCsjktjdd()==null?"":dto.getCsjktjdd())
					.replaceFirst("aae036", aaa036)
					.replaceFirst("aae011", dto.getAae011()==null?"":dto.getAae011());
					return html;
		}
		return null;
	}
	
	/**
	 * 得到表头信息，
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public  static BsTbodyInfoDTo getTbodyInfoHtml(BsTbodyInfoDTo dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.tbodyinfo,a.tfootinfo ,a.tbody from bstbodyinfo a ");
		sb.append("  where 1=1 ");
		sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"tbodytype","tbodycode"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
		List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
		return list.get(0);
	}
	
	
}
