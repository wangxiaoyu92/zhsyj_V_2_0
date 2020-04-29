package com.askj.ncjtjc.service;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.ValidateData;
import com.lbs.leaf.validate.ValidateData.ErrorItem;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.LyDTO;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.ncjtjc.entity.Ly;
import com.askj.ncjtjc.entity.Lyfj;
import com.askj.ncjtjc.entity.Lyzp;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * LyglService的中文名称：两员管理service
 * 
 * LyglService的描述：
 * 
 * Written by : zjf
 */
public class LyglService extends BaseService {
	protected final Logger logger = Logger.getLogger(LyglService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryLy的中文名称：查询两员
	 * 
	 * queryLy的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryLy(LyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select lyid,lybh,lyxm,lypym,lyxb,lylyrq,lysjh,");
		sb.append(" lysfzjlx,lysfzjhm,lywhcd,lyjtzz,lyhkszd,lyyx,lyqq,lywx,");
		sb.append(" lycynx,lyjkzm,lyjkzyxq,lyjktjdd,lypxqk,lypxhgzyxq,lysflx,lyfwdbh,lyfwqy,");
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,");
		sb.append(" comxianmc,comxiangdm,comxiangmc,comcundm,comcunmc,aab301,");
		sb.append(" aaa027,(select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" orgid,(select orgname from Sysorg where orgid = a.orgid) orgname,");
		sb.append(" (select username from Sysuser where userid = a.aae011) as aae011,aae036,aae013");
		sb.append("  from Ly a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.lyid = :lyid ");
		sb.append("  and  a.lybh = :lybh ");
		sb.append("  and  a.lyxm = :lyxm ");
		sb.append("  and  a.lypym = :lypym ");
		sb.append("  and  a.lysfzjhm = :lysfzjhm ");
		if (Strings.isNotBlank(dto.getJlybid())) {
			sb.append("  and NOT EXISTS (select b.lyid from jlybly b where a.lyid=b.lyid and b.jlybid= :jlybid ) ");
		}
		sb.append("  and  a.aaa027 like :aaa027");
		sb.append("  order by a.lyid ");
		String[] ParaName = new String[] { "lyid", "lybh", "lyxm", "lypym", "lysfzjhm", "jlybid", "aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		System.out.println("sql " + sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, LyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
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
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public String getLyzp(HttpServletRequest request, LyDTO dto) throws Exception {
		String filePath = null;
		try {
			String sql = "select lyzp from Lyzp where lyid = :lyid";
			String[] ParaName = new String[] { "lyid" };
			int[] ParaType = new int[] { Types.LONGVARCHAR };
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, LyDTO.class);
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);

			if (ls != null && ls.size() > 0) {
				LyDTO pdto = (LyDTO) ls.get(0);
				String lyzp = pdto.getLyzp();
				if (!Strings.isBlank(lyzp)) {
					byte b[] = Base64.base64ToByteArray(lyzp);
					String rootPath = request.getSession().getServletContext().getRealPath(GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH);
					FileUtil.createFolder(rootPath);

					String fileName = String.valueOf(dto.getLyid());
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
	 * queryLyzp的中文名称：查询两员照片信息
	 * 
	 * queryLyzp的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public Lyzp queryLyzp(HttpServletRequest request, LyDTO dto) {
		Condition cnd = Cnd.where("lyid", "=", dto.getLyid());
		List<Lyzp> ls = dao.query(Lyzp.class, cnd);
		if (ls != null && ls.size() > 0) {
			return ls.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 
	 * isExistsLy的中文名称：校验证件号码是否已经登记过
	 * 
	 * isExistsLy的概要说明：身份证号唯一
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public String isExistsLy(LyDTO dto) throws Exception {
		// 校验两员身份证号是否已经存在
		PagesDTO pd = new PagesDTO();
		LyDTO lyDTO = new LyDTO();
		lyDTO.setLysfzjhm(dto.getLysfzjhm());
		Map m = queryLy(lyDTO, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			LyDTO pdto = (LyDTO) ls.get(0);
			final StringBuffer sb = new StringBuffer();
			sb.append("您登记的两员信息：证件号码【");
			sb.append(pdto.getLysfzjhm());
			sb.append("】姓名【");
			sb.append(pdto.getLyxm());
			sb.append("】已登记过，请勿重复登记！");
			return sb.toString();
		}
		return null;
	}

	/**
	 * 
	 * addLy的中文名称：新增两员
	 * 
	 * addLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addLy(HttpServletRequest request, LyDTO dto) {
		String lyid = "";
		try {
			String flag;
			flag = isExistsLy(dto);
			if (flag != null) {
				return flag;
			}
			lyid = addLyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return lyid;
	}

	@Aop( { "trans" })
	public String addLyImp(HttpServletRequest request, LyDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String lyid = "";
		Ly ly = new Ly();
		BeanHelper.copyProperties(dto, ly);
		ly.setLyid(DbUtils.getSequenceStr());
		ly.setLybh(DbUtils.getOneValue(dao, "select getLybh() from dual"));
		// ly.setAae011(SysmanageUtil.getSysuser().getUserid());
		ly.setAae036(startTime);
		dao.insert(ly);
		lyid = ly.getLyid();
		dto.setLyid(ly.getLyid());

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

			Lyzp lyzp = queryLyzp(request, dto);
			if (lyzp == null) {
				lyzp = new Lyzp();
				lyzp.setLyzpid(DbUtils.getSequenceStr());
				lyzp.setLyid(dto.getLyid());
				lyzp.setLyzp(fis);
				dao.insert(lyzp);
			} else {
				lyzp.setLyzp(fis);
				dao.update(lyzp);
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
		sysuser.setAaa027(ly.getAaa027());//
		sysuser.setOrgid(ly.getOrgid());//
		sysuser.setDescription("两员：" + ly.getLyxm());
		sysuser.setUsername(ly.getLybh());
		sysuser.setMobile(ly.getLysjh());
		sysuser.setAac002(ly.getLysfzjhm());
		sysuser.setAac003(ly.getLyxm());
		sysuser.setAaz010(ly.getLyid());
		dao.insert(sysuser);

//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
		return lyid;
	}

	/**
	 * 
	 * updateLy的中文名称：修改两员
	 * 
	 * updateLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateLy(HttpServletRequest request, LyDTO dto) {
		try {
			String flag;
			Ly ly = dao.fetch(Ly.class, dto.getLyid());
			if (!(ly.getLysfzjhm()).equalsIgnoreCase(dto.getLysfzjhm())) {
				flag = isExistsLy(dto);
				if (flag != null) {
					return flag;
				}
			}

			updateLyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@SuppressWarnings({ "rawtypes" })
	@Aop( { "trans" })
	public void updateLyImp(HttpServletRequest request, LyDTO dto) throws Exception {
//		Timestamp startTime = SysmanageUtil.currentTime();

		Ly ly = dao.fetch(Ly.class, dto.getLyid());
		BeanHelper.copyProperties(dto, ly);
		dao.update(ly);

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

			Lyzp lyzp = queryLyzp(request, dto);
			if (lyzp == null) {
				lyzp = new Lyzp();
				lyzp.setLyzpid(DbUtils.getSequenceStr());
				lyzp.setLyid(dto.getLyid());
				lyzp.setLyzp(fis);
				dao.insert(lyzp);
			} else {
				lyzp.setLyzp(fis);
				dao.update(lyzp);
			}

			fis.close();
			// 删除服务器端的照片信息
			if (file.exists()) {
				file.delete();
			}
		}

		// 自动更新系统用户
		List sysuserList = dao.query(Sysuser.class, Cnd.where("username", "=", dto.getLybh()));
		if (sysuserList != null && sysuserList.size() > 0) {
			Sysuser sysuser = (Sysuser) sysuserList.get(0);
			sysuser.setAaa027(ly.getAaa027());
			sysuser.setOrgid(ly.getOrgid());
			sysuser.setMobile(ly.getLysjh());
			sysuser.setAac002(ly.getLysfzjhm());
			sysuser.setAac003(ly.getLyxm());
			dao.update(sysuser);
		}

//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delLy的中文名称：删除两员
	 * 
	 * delLy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delLy(HttpServletRequest request, final LyDTO dto) {
		try {
			if (null != dto.getLyid()) {
				// 检查是否可删除
				delLyImp(request, dto);
			} else {
				return "没有接收到要删除的两员ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@SuppressWarnings({ "rawtypes" })
	@Aop( { "trans" })
	public void delLyImp(HttpServletRequest request, final LyDTO dto) {
		// 删除两员
		dao.clear(Ly.class, Cnd.where("lyid", "=", dto.getLyid()));
		// 删除两员照片
		dao.clear(Lyzp.class, Cnd.where("lyid", "=", dto.getLyid()));
		// 删除两员附件		
		List fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getLyid()).and("fjcsdmz", "like", "CSDJBAFJ%"));
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
		List sysuserList = dao.query(Sysuser.class, Cnd.where("username", "=", dto.getLybh()));
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
	public ValidateData checkUpLoadXls(HttpServletRequest request, ValidateData vali, LyDTO dto) throws Exception {
		// 处理正确数据
		if (vali.getCorrectData().size() > 0) {
			int i = 0;
			// 遍历文件记录
			while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
				final LyDTO wdto = (LyDTO) vali.getCorrectData().get(i);
				wdto.setLypym(PinYinUtil.GetChineseSpell(wdto.getLyxm()));
				wdto.setLylyrq(DateUtil.getBirtday(wdto.getLysfzjhm()));
				wdto.setLyxb(DateUtil.getGender(wdto.getLysfzjhm()));
				wdto.setLysfzjlx("1");

				// 校验代码
				BeanHelper.copyProperties(wdto, dto);
				String errorMsg = isExistsLy(dto);
				if (errorMsg != null) {
					ErrorItem item = new ErrorItem();
					item.setErrorData(wdto);
					item.addErrorMsg("lysfzjhm", errorMsg);
					vali.addErrorItem(item);
					vali.getCorrectData().remove(i);// 移除不匹配的记录
				} else {
					i++;
					// 校验是否有重复记录
					for (int j = i; j < vali.getCorrectData().size(); j++) {
						final LyDTO wdto2 = (LyDTO) vali.getCorrectData().get(j);
						if (wdto2.getLysfzjhm().equals(wdto.getLysfzjhm())) {
							throw new BusinessException("上传文件记录中存在重复的两员信息，重复的身份证号为【" + wdto2.getLysfzjhm() + "】");
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
				final LyDTO wdto = (LyDTO) itm.getErrorData();
				wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
				errorList.add(wdto);
			}
			vali.setErrData(errorList);
		}
		return vali;
	}

	/**
	 * 
	 * saveLydr的中文名称：保存两员导入信息
	 * 
	 * saveLydr的概要说明:
	 * 
	 * @param succJsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String saveLydr(HttpServletRequest request, String succJsonStr) {
		try {
			saveLydrImp(request, succJsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveLydrImp(HttpServletRequest request, String succJsonStr) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String aaa027 = SysmanageUtil.getSysuser().getAaa027();
		String orgid = SysmanageUtil.getSysuser().getOrgid();

		List<LyDTO> lst = Json.fromJsonAsList(LyDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			LyDTO dto = (LyDTO) lst.get(i);
			Ly ly = new Ly();
			BeanHelper.copyProperties(dto, ly);
			ly.setLyid(DbUtils.getSequenceStr());
			ly.setLybh(DbUtils.getOneValue(dao, "select getLybh() from dual"));
			ly.setAae011(SysmanageUtil.getSysuser().getUserid());
			ly.setAae036(startTime);
			dao.insert(ly);

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
			sysuser.setDescription("两员：" + ly.getLyxm());
			sysuser.setUsername(ly.getLybh());
			sysuser.setMobile(ly.getLysjh());
			sysuser.setAac002(ly.getLysfzjhm());
			sysuser.setAac003(ly.getLyxm());
			sysuser.setAaz010(ly.getLyid());
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
	public String uploadFj(HttpServletRequest request, final Lyfj dto) {
		try {
			uploadFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjImp(HttpServletRequest request, Lyfj dto) throws Exception {
		String lyid = StringHelper.showNull2Empty(request.getParameter("lyid"));
		if ("".equals(lyid)) {
			throw new BusinessException("入参两员ID不能为空！");
		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Lyfj fj = new Lyfj();
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
			fj.setLyid(lyid);
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
	public List queryFjList(HttpServletRequest request, Lyfj dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjpath,fjcontent,fjname,fjtype,lyid ");
		sb.append("  from Lyfj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and lyid = :lyid");
		String[] ParaName = new String[] { "fjid", "lyid" };
		int[] ParaType = new int[] { Types.LONGVARCHAR, Types.LONGVARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, LyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				LyDTO pdto = (LyDTO) ls.get(i);
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
	public String delFj(HttpServletRequest request, final Lyfj dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final Lyfj dto) {
		String fjidStr = dto.getFjname();
		String[] a = PubFunc.split(fjidStr, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件
			Lyfj fj = dao.fetch(Lyfj.class, Cnd.where("fjid", "=", a[i]));

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
	 * getLyRecord的中文名称：查询备案明细表
	 * 
	 * getLyRecord的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception 
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getLyRecord(HttpServletRequest request, final LyDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		Map map = new HashMap();
		sb.append(" select lyid,lybh,lyxm,lypym,lylyrq,lysjh,lysfzjlx,lysfzjhm, ");
		sb.append("  getAa10_aaa103('AAC004',lyxb) lyxb,");
		sb.append(" getAa10_aaa103('AAC011',lywhcd) lywhcd,");
		sb.append("  getAa10_aaa103('JKZM',lyjkzm) lyjkzm,");
		sb.append(" getAa10_aaa103('CYNX',lycynx) lycynx,");
		sb.append(" getAa10_aaa103('PXQK',lypxqk) lypxqk,");
		sb.append("  lyjtzz,lyhkszd,lyyx,lyqq,lywx,lyjkzyxq,lyjktjdd,lypxhgzyxq,lysflx,lyfwdbh,lyfwqy,");
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,comxianmc,");
		sb.append("  comxiangdm,comxiangmc,comcundm,comcunmc,");
		sb.append("  (select username from Sysuser where userid = a.aae011) as aae011,");
		sb.append("  date_format(aae036,'%Y-%m-%d') aae036,aae013 ");
		sb.append("  from Ly a where 1=1 and  a.lyid = :lyid ");
		String[] ParaName = new String[] {"lyid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, LyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		if(ls.size()>0){
			LyDTO lybean = (LyDTO) ls.get(0);
			String contextPath = request.getContextPath();
			  String basePath = request.getScheme() + "://"
			    + request.getServerName() + ":" + request.getServerPort()
			    + contextPath + "/";
			String fileCtxPath = basePath + "/images/default.jpg";
				String filePath = getLyzp(request, dto);
				if (!Strings.isBlank(filePath)) {
					int pfindex = filePath.lastIndexOf("\\");
					String fileName = filePath.substring(pfindex + 1);
					fileCtxPath = basePath + GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH + File.separator + fileName;
				}
				lybean.setFilepath(fileCtxPath);
				//获取页面
			String html = setLyValue(lybean, "lyRecord", "1");
			map.put("data", html);
		}else {
			map.put("data", "");
		}
		return map;
	
}
	public String  setLyValue(LyDTO dto,String tbodytype ,String tbodycode) throws Exception{
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
			
//			String img = "<img style='height=:119px;width=:115px' src='http://c.cksource.com/a/1/img/sample.jpg'  />";
			String img = "<img style='height=:119px;width=:115px' src='"+dto.getFilepath()+"'  />";
			
			html = bodydto.getTbodyinfo().replaceFirst("lybh", dto.getLybh()==null?"":dto.getLybh())
					.replaceFirst("comxianmc", dto.getComxianmc()==null?"":dto.getComxianmc())
					.replaceFirst("comxiangmc", dto.getComxiangmc()==null?"":dto.getComxiangmc())
					.replaceFirst("comcunmc", dto.getComcunmc()==null?"":dto.getComcunmc())
					.replaceFirst("lyxm", dto.getLyxm()==null?"":dto.getLyxm())
					.replaceFirst("lyxb", dto.getLyxb()==null?"":dto.getLyxb())
					.replaceFirst("lylyrq", dto.getLylyrq()==null?"":DateUtil.getYear("yyyyMMdd", dto.getLylyrq()))
					.replaceFirst("lysjh", dto.getLysjh()==null?"":dto.getLysjh())
					.replace("lyimg", img)
					.replaceFirst("lysfzjhm", dto.getLysfzjhm()==null?"":dto.getLysfzjhm())
					.replaceFirst("lyjtzz", dto.getLyjtzz()==null?"":dto.getLyjtzz())
					.replaceFirst("lyfwqy", dto.getLyfwqy()==null?"":dto.getLyfwqy())
					.replaceFirst("lywhcd", dto.getLywhcd()==null?"":dto.getLywhcd())
					.replaceFirst("lypxqk", dto.getLypxqk()==null?"":dto.getLypxqk())
					.replaceFirst("lycynx", dto.getLycynx()==null?"":dto.getLycynx())
					.replaceFirst("lyjkzm", dto.getLyjkzm()==null?"":dto.getLyjkzm())
					.replaceFirst("lyjkzyxq", dto.getLyjkzyxq()==null?"":dto.getLyjkzyxq())
					.replaceFirst("lyjktjdd", dto.getLyjktjdd()==null?"":dto.getLyjktjdd())
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
