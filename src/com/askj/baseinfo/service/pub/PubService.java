package com.askj.baseinfo.service.pub;

import com.alibaba.druid.util.StringUtils;
import com.askj.baseinfo.dto.*;
import com.askj.baseinfo.entity.*;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.jyjc.dto.JyjcjgDTO;
import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.tmsyj.tmsyj.dto.HjgztkhgxDTO;
import com.askj.zfba.dto.ZfajdjDTO;
import com.lbs.commons.GlobalNameS;
import com.lbs.commons.StringHelper;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.*;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.Aa09;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.PubParentChild;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserrole;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import com.zzhdsoft.utils.printword.AWordPrint;
import com.zzhdsoft.utils.printword.PDFUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.annotation.Param;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.*;

/**
 *
 * PubService的中文名称：公共管理service
 *
 * PubService的描述：
 *
 * Written by : zjf
 */
public class PubService extends BaseService {
	protected final Logger logger = Logger.getLogger(PubService.class);
	@Inject
	private Dao dao;

	private static PropertiesProxy pp;

	@Inject
	private PcompanyService pcompanyService;

	/**
	 *
	 * querySelectcom的中文名称：查询单位信息
	 *
	 * querySelectcom的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map querySelectcom(PcompanyDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		if (vSysUser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
			vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
		}
		String aaa027 = SysmanageUtil.getSysuserAaa027(vSysUser.getAaa027());
		dto.setAaa027(aaa027);
		Pcompany pcom=null;
		if(vSysUser.getUsercomid()!=null && !"".equals(vSysUser.getUsercomid())){
			pcom=dao.fetch(Pcompany.class,vSysUser.getUsercomid());
		}


		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* , ");
		sb.append(" (SELECT aa.AAA103  FROM aa10 aa WHERE aa.AAA100 ='comdalei' AND aa.AAA102 =a.comdalei) comdaleistr, ");
		sb.append("(select GROUP_CONCAT(t.comxkzbh) from pcompanyxkz t where comid=a.comid and t.comxkzlx='1') as yyzzh ");
		sb.append(" from pcompany a ");
		sb.append(" where 1=1 ");
		sb.append("  and aaa027 like :aaa027");
		sb.append("  and comdm = :comdm");
		if (dto.getCommc()!=null && !dto.getCommc().equals("")){
			//sb.append("  and commc like :commc");
			//dto.setCommc('%'+dto.getCommc()+'%');
			sb.append(" and (a.commc like :commc or a.commcjc like :commc or a.comid like :commc or a.comfrhyz like :commc or a.comfzr like :commc)");
		}
//		sb.append("  and comjyjcbz = :comjyjcbz");
		sb.append("  and comdalei = :comdalei");

		if(pcom==null || !"106001".equals(pcom.getComdalei())){
			if ("6".equals(vSysUser.getUserkind())){ //6企业虚拟用户
				sb.append(" and a.comid='"+vSysUser.getAaz001()+"' ");
			};
		}

		String sql = sb.toString();
		String[] ParaName = new String[] {"aaa027","comdm","commc","comjyjcbz","comdalei"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsqlsql "+sql);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	public Map queryHviewjgzt(HviewjgztDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
		String aaa027 = SysmanageUtil.getSysuserAaa027(vSysUser.getAaa027());
		dto.setAaa027(aaa027);
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*  ");
		sb.append(" from hviewjgzt a ");
		sb.append(" where 1=1 ");
		sb.append("  and aaa027 like :aaa027");
		sb.append("  and jgztbh = :jgztbh");
		if (dto.getJgztmc()!=null && !dto.getJgztmc().equals("")){
			sb.append("  and jgztmc like :jgztmc");
			dto.setJgztmc('%'+dto.getJgztmc()+'%');
		}
		String sql = sb.toString();
		String[] ParaName = new String[] {"aaa027","jgztbh","jgztmc" };
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HviewjgztDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * querySelectcom的中文名称：查询单位信息
	 *
	 * querySelectcom的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map querySelectay(PwfxwcsDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from pwfxwcs a ");
		sb.append(" where 1=1 ");
		sb.append(" AND ajdjajdl=:ajdjajdl ");
		sb.append(" AND wfxwwftk like :wfxwwftk ");
		sb.append(" AND wfxwbh like :wfxwbh ");
		sb.append(" AND wfxwms like :wfxwms ");

		/*if ((dto.getWfxwbh() != null) && !("".equals(dto.getWfxwbh()))) {
			sb.append("  and wfxwbh like :wfxwbh");
			dto.setWfxwbh("%" + dto.getWfxwbh()+"%");
		}
		if ((dto.getWfxwms() != null) && !("".equals(dto.getWfxwms()))) {
			sb.append("  and wfxwms like :wfxwms");
			dto.setWfxwms("%" + dto.getWfxwms()+"%");
		} */
		sb.append("  ORDER BY  wfxwbh  ");
		String sql = sb.toString();
		String[] ParaName = new String[] {"ajdjajdl","wfxwbh","wfxwms","wfxwwftk"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PwfxwcsDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}


	/**
	 * 查询立案信息
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Map queryAjla(ZfajdjDTO dto,PagesDTO pd) throws Exception{
		StringBuffer sb=new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from zfajdj a ");
		sb.append(" where 1=1 ");
		sb.append(" and a.comfrhyz= :comfrhyz");
		if (dto.getCommc()!=null && !dto.getCommc().equals("")){
			sb.append("  and a.commc like :commc");
			dto.setCommc('%'+dto.getCommc()+'%');
		}


		String sql=sb.toString();
		String[] ParaName = new String[] {"comfrhyz","commc"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};


		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajdjDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;

	}


	/**
	 *
	 * queryFjlist的中文名称：查询案件登记
	 *
	 * queryFjlist的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map queryFjlist(UploadfjDTO dto, PagesDTO pd) throws Exception {

		if (dto.getFjcsdmlb()!=null && dto.getFjcsdmlb().equalsIgnoreCase("undefined")){
			dto.setFjcsdmlb(null);
		}

		if (dto.getFjcsdlbh()!=null && dto.getFjcsdlbh().equalsIgnoreCase("undefined")){
			dto.setFjcsdlbh(null);
		}

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*, ");
		sb.append(" (select count(b.fjid) from Fj b  ");
		sb.append(" where 1 = 1 and b.fjcsdmz = a.fjcsdmz ");
		if (dto.getFjwid() != null && !"".equals(dto.getFjwid())) {
			sb.append(" and b.fjwid = '").append(dto.getFjwid()).append("' ");
		}
		sb.append(" ) as ycfjcount ");
		sb.append(" from pfjcs a ");
		sb.append(" where 1=1 ");
		sb.append("  and a.fjcsdlbh = :fjcsdlbh");
		sb.append("  and a.fjcsdmlb = :fjcsdmlb");


		String sql = sb.toString();
		String[] ParaName = new String[] {"fjwid","fjcsdmlb","fjcsdlbh"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, UploadfjDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * querySCFjListDetail的中文名称：单个附件类别已上传附件明细
	 *
	 * querySCFjListDetail的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map querySCFjListDetail(UploadfjDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();

		sb.append("SELECT a.fjid,a.fjwid,a.fjpath,a.fjname,a.fjuserid,a.fjczyxm,a.fjczsj,b.fjcsdmlb,b.fjcsdmlbmc,b.fjcsdmz,b.fjcsdmmc ");
		sb.append("FROM Fj a,pfjcs b ");
		sb.append("WHERE a.fjcsdmz=b.fjcsdmz ");
		sb.append("AND a.fjwid=:ajdjid ");
		sb.append("AND a.fjcsdmz=:fjcsdmz ");


		String sql = sb.toString();
		String[] ParaName = new String[] {"ajdjid","fjcsdmz"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, UploadfjDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * uploadFjsave的中文名称：上传附件【保存】
	 *
	 * uploadFjsave的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String uploadFjsave(HttpServletRequest request, final UploadfjDTO dto) {
		try {
			uploadFjsaveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjsaveImp(HttpServletRequest request, UploadfjDTO dto)
			throws Exception {
		String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
		if ("".equals(v_ajdjid)) {
			throw new BusinessException("案件登记ID不能为空！");
		}

		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();

		String v_fjcsdmlb = request.getParameter("fjcsdmlb");
		String v_fjcsdmz = request.getParameter("fjcsdmz");

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Fj fj = new Fj();
			fj.setFjpath(a[i]);
			fj.setFjname(b[i]);
			fj.setFjcsdmz(v_fjcsdmz);
			fj.setFjuserid(vSysUser.getUserid());
			fj.setFjczyxm(vSysUser.getDescription());
			fj.setFjczsj(SysmanageUtil.getDbtimeYmdHnsTimestamp());

			String fjtype = PubFunc.getFileExt(b[i]);
			if (!"".equals(fjtype)) {
				if (fjtype.equalsIgnoreCase("jpg")
						|| fjtype.equalsIgnoreCase("jpeg")
						|| fjtype.equalsIgnoreCase("png")
						|| fjtype.equalsIgnoreCase("gif")) {
					fj.setFjtype("1");
				} else {
					fj.setFjtype("2");
				}
			}
			fj.setFjwid(v_ajdjid);
			final String fjid = DbUtils.getSequenceStr();
			fj.setFjid(fjid);
			dao.insert(fj);

			// 将图片保存至数据库
			//gu20160802 暂改为不往数据库存储
			/*
			String rootPath = request.getSession().getServletContext()
					.getRealPath("/");
			rootPath=rootPath+v_fjcsdmlb;
			File file = new File(rootPath + File.separator + fj.getFjpath());

			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);
			fj.setFjcontent(fis);// ???
			dao.update(fj);
			fis.close();*/
		}
	}

	/**
	 *
	 * uploadFjdel的中文名称：删除附件
	 *
	 * delFj的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String uploadFjdel(HttpServletRequest request, final UploadfjDTO dto) {
		try {
			uploadFjdelImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjdelImp(HttpServletRequest request, final UploadfjDTO dto) {
		String v_fjid = dto.getFjid().toString();

		// 删除附件表
		Fj fj = dao.fetch(Fj.class, Cnd.where("fjid", "=", v_fjid));
		// 刪除服務器上的附件
		String rootPath = request.getSession().getServletContext()
				.getRealPath("/");
		fj.setFjpath(rootPath + File.separator + fj.getFjpath());
		File file = new File(fj.getFjpath());
		if (file.exists()) {
			file.delete();
		}
		dao.delete(fj);
	}


	/**
	 * 获取某企业产品图片的数量
	 * **/
	public int getProductFjCount(String prm_fjwid,String prm_fjcsdmz,String prm_fjid){
		String v_sql="select count(fjid) as totalCount from Fj where 1=1 ";

		if (prm_fjwid!=null && !prm_fjwid.equals("") && !prm_fjwid.equals("0")){
			v_sql+=" and fjwid='"+prm_fjwid+"'";
		};

		if (prm_fjcsdmz!=null && !prm_fjcsdmz.equals("")){
			v_sql+=" and fjcsdmz='"+prm_fjcsdmz+"'";
		};

		if (prm_fjid!=null && !prm_fjid.equals("") && !prm_fjid.equals("0") ){
			v_sql+=" and fjid='"+prm_fjid+"'";
		};
		int li_count= dao.count(v_sql);

		return li_count;
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
	public List queryUploadFjList(HttpServletRequest request, UploadfjDTO dto)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjcsdmz,fjwid,fjpath,fjcontent,fjtype,fjname ");
		sb.append("  from Fj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and fjwid = :fjwid");
		sb.append("   and fjcsdmz = :fjcsdmz");

		String[] ParaName = new String[] { "fjid", "fjwid","fjcsdmz" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR ,Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, UploadfjDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				UploadfjDTO pdto = (UploadfjDTO) ls.get(i);
				String rootPath = request.getSession().getServletContext()
						.getRealPath("/");
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
	 * 生成打印文件prm_moBanFileName打印模板名称，prm_bianLiangMap模板中的参数变量map
	 */
	public void createPrintfile(HttpServletRequest request,String prm_moBanFileName,String prm_fjwid,Map prm_bianLiangMap )
	     throws Exception{
		// 首先判断文件是否存在，存在删除  例如 prm_moBanFileName 现场检查笔录.docx
		delFjFromFjwid(request,prm_fjwid);
       //rootPath   F:\ideawork\zhsyj_V_2_0\WebRoot\
		String rootPath = request.getSession()
								 .getServletContext()
								 .getRealPath("/");
		String yuanFullFile = rootPath  + "jsp\\printmb\\" + prm_moBanFileName;
		String yuanExt = prm_moBanFileName.substring(prm_moBanFileName.indexOf("."));//.docx
		String yuanName = prm_moBanFileName.substring(0, prm_moBanFileName.indexOf("."));//现场检查笔录
		String v_ymd = SysmanageUtil.getSystemYMD();//20180320
		String destFile = "upload\\printfile\\" + v_ymd + "\\" + yuanName + prm_fjwid + yuanExt;
		String destFullFile = rootPath + destFile;
		String destFullPdf=rootPath+"upload\\printfile\\" + v_ymd + "\\" + yuanName + prm_fjwid+".pdf";
		String destPdf="upload\\printfile\\" + v_ymd + "\\" + yuanName + prm_fjwid+".pdf";

		if (!AWordPrint.replaceAndGenerateWord(yuanFullFile, destFullFile, prm_bianLiangMap)) {
			throw new BusinessException("替换模板变量失败！");
		};
		if (!PDFUtil.word2PDF(destFullFile,destFullPdf)){
			throw new BusinessException("转换为pdf文件失败！");
		};
		Fj v_newFj = new Fj();
		String v_fjid = DbUtils.getSequenceStr();
		v_newFj.setFjid(v_fjid);
		v_newFj.setFjtype("21");//打印文件
		v_newFj.setFjwid(prm_fjwid);
		v_newFj.setFjpath(destPdf);
		dao.insert(v_newFj);
	}

	/**
	 *
	 * querySelectcom的中文名称：查询案件登记
	 *
	 * querySelectcom的概要说明：
	 *
	 * @param dto
	 * @param request
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map getProductFjPicture(HttpServletRequest request,UploadfjDTO dto) throws Exception {
		Map r = new HashMap();
		if(getProductFjCount(dto.getFjwid().toString(),dto.getFjcsdmz(),dto.getFjid().toString())>0){//有附件
			StringBuffer sb = new StringBuffer();
			sb.append("select fjid,fjpath ");
			sb.append("from Fj ");
			sb.append(" where 1=1 ");
			sb.append("  and a.fjwid = :fjwid");
			sb.append("  and a.fjcsdmz = :fjcsdmz");
			sb.append("  and a.fjid = :fjid");

			String sql = sb.toString();
			String[] ParaName = new String[] {"fjwid","fjcsdmz","fjid"};
			int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);

			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, UploadfjDTO.class);
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);

			String v_picFilePathAndName;

			if (null!=ls && ls.size()>0){
				//String picturePath="";
				//String projectPath=System.getProperty("user.dir");

				for (int i=0;i<ls.size();i++){
					UploadfjDTO mybean=(UploadfjDTO)ls.get(i);
					//picturePath=mybean.getFjpath();

					String rootPath = request.getSession().getServletContext().getRealPath("upload");
					v_picFilePathAndName=rootPath+mybean.getFjname();
					makePictureFromBlobByFjId(v_picFilePathAndName,dto.getFjid().toString());
					mybean.setPicFilePathAndName(v_picFilePathAndName);

				}

			}
			r.put("rows", ls);
			r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		}


		return r;
	}

	 /**
	  * 根据附件表ID 从blob字段生成图片到指定目录下
	  * @param prm_picFilePathAndName
	  * @param prm_fjid
	  */

	public String makePictureFromBlobByFjId(String prm_picFilePathAndName,String prm_fjid)
	throws Exception {
	String filePath = null;
	try {
		String sql = "select FJCONTENT from Fj where fjid ='"+prm_fjid+"'";
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Fj.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		if (ls != null && ls.size() > 0) {
			UploadfjDTO v_UploadfjDTO = (UploadfjDTO) ls.get(0);
			String v_FJCONTENT = v_UploadfjDTO.getFjcontent();
			if (!Strings.isBlank(v_FJCONTENT)) {
				byte b[] = Base64.base64ToByteArray(v_FJCONTENT);
//				String rootPath = request.getSession().getServletContext()
//						.getRealPath(GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH);
//				FileUtil.createFolder(rootPath);

//				String fileName = String.valueOf(dto.getSjsfzh());
//				filePath = rootPath + File.separator + fileName + ".jpg";

				File file = new File(prm_picFilePathAndName);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(b);
				fos.close();
			}
		}

		return filePath;
	} catch (Exception e) {
		throw new BusinessException("获取附件信息失败：" + e.getMessage());
	}
	}
	/**
	 *
	 * querySelectjyjcyp的中文名称：查询检验检测样品
	 * querySelectjyjcyp的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by : lfy
	 */
	public Map querySelectjyjcyp(JyjcjgDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select * ");
		sb.append(" from jyjcyp ");
		sb.append(" where 1=1 ");
		sb.append("  and (jcypmc like :jcypmc or jcypjc like :jcypmc)");
		String sql = sb.toString();
		String[] ParaName = new String[] {"jcypmc"};
		int[] ParaType = new int[] {Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 *
	 * querySelectjyjcxm的中文名称：查询检验检测项目
	 * querySelectjyjcxm的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by : lfy
	 */
	public Map querySelectjyjcxm(JyjcjgDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,(select group_concat(t2.bzbh) from jyjcxmjcbz t1,jyjcjcbzb t2 where t1.jyjcjcbzbid=t2.jyjcjcbzbid and t1.jyjcxmid=a.jyjcxmid) as jcxmbz,");
		sb.append("(select group_concat(t4.jcffbzbh)  from jyjcxmjcffbz t3, jyjcffbzb t4 where t3.jyjcffbzbid=t4.jyjcffbzbid and t3.jyjcxmid=a.jyjcxmid) as jcxmff ");
		sb.append(" from jyjcxm a ");
		sb.append(" where 1=1 ");
		sb.append("  and jcxmmc like :jcxmmc or jcxmmcjc like :jcxmmc");
		String sql = sb.toString();
		String[] ParaName = new String[] {"jcxmmc"};
		int[] ParaType = new int[] {Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return  r;
	}


//	 public void makePictureFromBlobByFjId2(String picSavePath,String fileName,String fj_id){
//
//
//			//ResultSet rs= null;
//			//Statement stmt= null;
//			//Connection conn=null;
//
//	        BufferedInputStream imageStream = null;
//	        BufferedImage image = null;
//	        JPEGImageEncoder encoder = null;
//			String ls_sql = null;
//	        try {
//				//获取数据库连接
//				//conn =DBManager.getConnection();
//	            //conn.setAutoCommit(false);
//	            //stmt = conn.createStatement();
//
//				StringBuffer sb = new StringBuffer();
//				sb.append("select FJCONTENT where fjid=").append(fj_id);
//
//				dao.
//
//				String sql = sb.toString();
//				String[] ParaName = new String[] {};
//				int[] ParaType = new int[] {};
//
//				sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
//
//				Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, UploadfjDTO.class, pd
//						.getPage(), pd.getRows());
//				List ls = (List) m.get(GlobalNames.SI_RESULTSET);
//
//
//	            ls_sql = "select fj_tp from bs_spfj where fj_id= "+fj_id;
//	            rs = stmt.executeQuery(ls_sql);
//	            while(rs.next()){
//	                imageStream = new BufferedInputStream(((Blob)rs.getBlob(1)).getBinaryStream());
//	                try {
////	                    System.out.println("正在生成"+picSavePath+fileName );
//	                    File picturePath = new File(picSavePath+fileName);
//	                    if(!picturePath.exists()){//文件不存在时，再生成图片到目录下
////	                        ServletOutputStream sos =  res.getOutputStream();
//	                        OutputStream ostream = new FileOutputStream(picturePath);
//	                        image = ImageIO.read(imageStream);
//	                        encoder =  JPEGCodec.createJPEGEncoder(ostream);
//	                        encoder.encode(image);
//	                        imageStream.close();
//	                        ostream.flush();
//	                        ostream.close();
//	                    }
//	                } catch (IOException e) {
//	                    e.printStackTrace();
//	                }
//	            }
//
//	        } catch (SQLException e) {
//				e.printStackTrace();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally{
//	        	if(rs!=null)
//					try {
//						rs.close();
//					} catch (SQLException e3) {
//						e3.printStackTrace();
//					}
//	           if(stmt!=null)
//				try {
//					stmt.close();
//				} catch (SQLException e2) {
//					e2.printStackTrace();
//				}
//	           if(conn!=null)
//				try {
//					conn.close();
//				} catch (SQLException e1) {
//					e1.printStackTrace();
//				}
//			}
//	    }

	/**
	 *
	 * queryPcyzdszmain的中文名称：查询常用字段设置主表
	 *
	 * queryPcyzdszmain的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryPcyzdszmain(PcyzdszmainDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.pcyzdszmainid,a.tabname,a.tabnamedesc,a.colname,a.colnamedesc ");
		sb.append(" from pcyzdszmain a");
		sb.append(" where 1=1 ");
		sb.append("  order by a.pcyzdszmainid desc ");

		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsqlsql "+sql);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcyzdszmainDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryPcyzdszdetail的中文名称：查询常用字段设置明细表
	 *
	 * queryPcyzdszdetail的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryPcyzdszdetail(PcyzdszmainDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.pcyzdszmainid,a.pcyzdszdetailid,a.avalue,a.aae140 ");
		sb.append(" from pcyzdszdetail a");
		sb.append(" where 1=1 ");
		sb.append("  and pcyzdszmainid=:pcyzdszmainid ");
		sb.append("  and pcyzdszdetailid=:pcyzdszdetailid ");
		sb.append("  order by a.pcyzdszdetailid desc ");

		String sql = sb.toString();
		String[] ParaName = new String[] {"pcyzdszmainid","pcyzdszdetailid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsqlsql "+sql);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcyzdszmainDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * savePcyzdszMain的中文名称：主表字段设置
	 *
	 * savePcyzdszMain的概要说明：
	 *
	 * @param dto
	 * @return Written by : zy TODO
	 *
	 */

	public String savePcyzdszMain(HttpServletRequest request, PcyzdszmainDTO dto) {
		try {
			savePcyzdszMainImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void savePcyzdszMainImp(HttpServletRequest request, PcyzdszmainDTO dto)
			throws Exception {
		if (null != dto.getPcyzdszmainid() && !"".equals(dto.getPcyzdszmainid())) {
			Pcyzdszmain se = dao.fetch(Pcyzdszmain.class, dto.getPcyzdszmainid());
			se.setTabname(dto.getTabname());
			se.setColname(dto.getColname());
			se.setColnamedesc(dto.getColnamedesc());
			se.setTabnamedesc(dto.getTabnamedesc());
			dao.update(se);
		} else {
			String v_pcyzdszmainid = DbUtils.getSequenceStr();

			Pcyzdszmain v_se = new Pcyzdszmain();
			BeanHelper.copyProperties(dto, v_se);
			v_se.setPcyzdszmainid(v_pcyzdszmainid);;
			dao.insert(v_se);
		}
	}

	/**
	 *
	 * delPcyzdszMain的中文名称：删除主表字段设置
	 *
	 * delPcyzdszMain的概要说明：
	 *
	 * @param dto
	 * @return Written by : zy
	 *
	 */
	public String delPcyzdszMain(HttpServletRequest request, PcyzdszmainDTO dto) {
		try {
			if (null != dto.getPcyzdszmainid()) {
				delPcyzdszMainImp(request, dto);
			} else {
				return "没有接收到要删除的信息记录！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delPcyzdszMainImp(HttpServletRequest request, PcyzdszmainDTO dto) {
		// 删除
		dao.clear(Pcyzdszmain.class, Cnd.where("pcyzdszmainid", "=", dto.getPcyzdszmainid()));
	}

	/**
	 *
	 * queryPcyzdszmainObj的中文名称：查询主表信息
	 *
	 * queryPcyzdszmainObj的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Object queryPcyzdszmainObj(PcyzdszmainDTO dto, PagesDTO pd) throws Exception {

		Pcyzdszmain se = new Pcyzdszmain();
		se = dao.fetch(Pcyzdszmain.class, dto.getPcyzdszmainid());
		return se;
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

	public String savePcyzdszAdd(HttpServletRequest request, PcyzdszmainDTO dto) {
		try {
			savePcyzdszAddImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void savePcyzdszAddImp(HttpServletRequest request, PcyzdszmainDTO dto)
			throws Exception {
		if (null != dto.getPcyzdszdetailid()&&!"".equals(dto.getPcyzdszdetailid())) {
			Pcyzdszdetail se = dao.fetch(Pcyzdszdetail.class, dto.getPcyzdszdetailid());
			se.setAae140(dto.getAae140());
			se.setAvalue(dto.getAvalue());
			dao.update(se);
		} else {
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
			String v_pcyzdszdetailid = DbUtils.getSequenceStr();

			Pcyzdszdetail v_Pcyzdszdetail=new Pcyzdszdetail();
			BeanHelper.copyProperties(dto, v_Pcyzdszdetail);
			v_Pcyzdszdetail.setPcyzdszdetailid(v_pcyzdszdetailid);
			v_Pcyzdszdetail.setCzyxm(vSysUser.getDescription());
			v_Pcyzdszdetail.setCzsj(v_dbDatetime);
			dao.insert(v_Pcyzdszdetail);
		}
	}

	/**
	 *
	 * delAjdj的中文名称：删除案件登记
	 *
	 * delAjdj的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String delPcyzdsz(HttpServletRequest request, PcyzdszmainDTO dto) {
		try {
			if (null != dto.getPcyzdszdetailid()) {
				delPcyzdszImp(request, dto);
			} else {
				return "没有接收到要删除的案件登记ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delPcyzdszImp(HttpServletRequest request, PcyzdszmainDTO dto) {
		// 删除案件登记
		dao.clear(Pcyzdszdetail.class, Cnd.where("pcyzdszdetailid", "=", dto.getPcyzdszdetailid()));
	}

	/**
	 *
	 * querySelectcom的中文名称：查询单位信息
	 *
	 * querySelectcom的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryPcyzdsz(PcyzdszmainDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
//		dto.setAaa027(vSysUser.getAaa027());

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from pcyzdszdetail a,pcyzdszmain b ");
		sb.append(" where a.pcyzdszmainid=b.pcyzdszmainid ");
		sb.append("  and b.tabname = :tabname");
		sb.append("  and b.colname = :colname");

		String sql = sb.toString();
		String[] ParaName = new String[] {"tabname","colname"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsqlsql "+sql);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcyzdszmainDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * uploadFj的中文名称：上传附件
	 *
	 * uploadFj的概要说明：
	 *
	 * @param request
	 * @return Written by : zjf
	 */
	public String uploadFj(HttpServletRequest request) {
		try {
			uploadFjImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjImp(HttpServletRequest request) throws Exception {
		//上传文件路径
		String uploadPath = request.getSession().getServletContext().getRealPath(GlobalNameS.UPLOAD_FILE_PATH);
		//上传文件存放的目标文件夹名称
		String folderName = StringHelper.showNull2Empty(request.getParameter("folderName"));
		if(!"".equals(folderName)){
			uploadPath = uploadPath + "/" + folderName;
			File up = new File(uploadPath);
			if (!up.exists()) {
				up.mkdir();
			}
		}

		// 读取上传附件
		String fileName = null; // 文件名
		BufferedOutputStream outputStream = null;
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setHeaderEncoding("UTF-8");
				List<FileItem> items = upload.parseRequest(request);
				// 区分表单域
				for (int i = 0; i < items.size(); i++) {
					FileItem fi = items.get(i);
					// 获取文件名
					fileName = fi.getName();
					if (fileName != null) {
						File savedFile = new File(uploadPath, fileName);
						fi.write(savedFile);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (outputStream != null){
						outputStream.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 *
	 * uploadCszp的中文名称：上传厨师照片
	 *
	 * uploadCszp的概要说明：
	 *
	 * @param request
	 * @return Written by : zjf
	 */
	public String uploadCszp(HttpServletRequest request) {
		try {
			uploadCszpImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadCszpImp(HttpServletRequest request) throws Exception {
		//上传文件路径
		String uploadPath = request.getSession().getServletContext().getRealPath(GlobalNameS.CAMERA_UPLOAD_FILE_PATH);

		// 读取上传附件
		String fileName = null; // 文件名
		BufferedOutputStream outputStream = null;
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setHeaderEncoding("UTF-8");
				List<FileItem> items = upload.parseRequest(request);
				// 区分表单域
				for (int i = 0; i < items.size(); i++) {
					FileItem fi = items.get(i);
					// 获取文件名
					fileName = fi.getName();
					if (fileName != null) {
						File savedFile = new File(uploadPath, fileName);
						fi.write(savedFile);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (outputStream != null){
						outputStream.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}


	/**
	 *
	 * saveFj的中文名称：上传附件到服务器后【保存记录到fj表】
	 *
	 * saveFj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String saveFj(HttpServletRequest request, final FjDTO dto) {
		try {
			saveFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveFjImp(HttpServletRequest request, FjDTO dto) throws Exception {
		String fjwid = StringHelper.showNull2Empty(request.getParameter("fjwid"));
		if ("".equals(fjwid)) {
			throw new BusinessException("附件所属表主键id不能为空！");
		}
        //gu20170330add
		boolean v_haveZhuti=true;
		if ("nohave".equalsIgnoreCase(fjwid)){
			v_haveZhuti=false;
		}
		String v_uploadOne = dto.getUploadone();
		if ("yes".equalsIgnoreCase(v_uploadOne)&&v_haveZhuti){
			String v_sql="delete from fj where fjwid='"+fjwid+"' and fjtype='"+
		          dto.getFjtype()+"'";
			Sql v_execsql=Sqls.create(v_sql);
		    dao.execute(v_execsql);
		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Fj fj = new Fj();
			fj.setFjpath(a[i]);
			fj.setFjname(b[i]);

//			String fjtype = PubFunc.getFileExt(b[i]);
//			if (!"".equals(fjtype)) {
//				if (fjtype.equalsIgnoreCase("jpg") || fjtype.equalsIgnoreCase("jpeg") || fjtype.equalsIgnoreCase("png")
//						|| fjtype.equalsIgnoreCase("gif")) {
//					fj.setFjtype("1");
//				} else {
//					fj.setFjtype("2");
//				}
//			}
			String v_fjtype="1";
			if (dto.getFjtype()!=null && !"".equals(dto.getFjtype())){
				v_fjtype=dto.getFjtype();
				if("GWZWFJ".equals(dto.getFjtype())){
					dao.clear(Fj.class, Cnd.where("fjwid", "=", dto.getFjwid()).and("fjtype", "=", "GWZWFJ"));
					/*Fj fjgw=new Fj();
					fjgw.setFjwid(dto.getFjwid());
					fjgw.setFjtype("GWZWFJ");
                    Sql sql = Sqls.create("delete from  fj where fjtype='GWZWFJ'");
					dao.delete(fjgw);*/
				}else if("GWQTFJ".equals(dto.getFjtype())){
					Sysuser sysuser = SysmanageUtil.getSysuser();
					fj.setFjuserid(sysuser.getUserid());
				}
			}
			fj.setFjtype(v_fjtype);
			fj.setFjwid(fjwid);
			final String fjid = DbUtils.getSequenceStr();
			fj.setFjid(fjid);
			dao.insert(fj);

			// gjf压缩处理图片
			String v_fjpath = fj.getFjpath();
			String v_chuliOldFilename = request.getSession()
					.getServletContext().getRealPath(v_fjpath);

			//System.out.print("原路径" + v_chuliOldFilename);
			String v_suiji = DbUtils.getSequenceStr();
			String v_chuliNewFilename = v_fjpath.substring(0,
					v_fjpath.lastIndexOf("/"))
					+ "/" + v_suiji + fj.getFjname();
			v_chuliNewFilename = request.getSession().getServletContext()
					.getRealPath(v_chuliNewFilename);
			//System.out.print("新路径" + v_chuliOldFilename);

			//gu20170624 视频不能这样处理
			if (!"14".equals(v_fjtype)&&!"GWZWFJ".equals(v_fjtype)&&!"GWQTFJ".equals(v_fjtype)){
				Boolean delflag = ImageCompressUtil.saveMinPhoto(
						v_chuliOldFilename, v_chuliNewFilename, 2048, 1d);
				if (delflag) {
					FileUtil.delFile(v_chuliOldFilename);
					FileUtil.reNameFile(v_chuliNewFilename, v_chuliOldFilename);
				}
			}
		}
	}

	/**
	 *
	 * queryFjViewList的中文名称：查询附件表【fj】
	 *
	 * queryFjViewList的概要说明：判断应用服务器上是否存在附件副本【如果不存在，自动根据数据库记录生成附件副本！】
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	public List queryFjViewList(HttpServletRequest request, FjDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjwid,fjpath,fjcontent,fjname,fjtype ");
		sb.append("  from Fj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and fjwid = :fjwid");
		sb.append("   and fjtype = :fjtype");
		sb.append("   and fjcsdmz = :fjcsdmz");
		String[] ParaName = new String[] { "fjid", "fjwid", "fjtype", "fjcsdmz" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, FjDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
//		if (ls != null && ls.size() > 0) {
//			for (int i = 0; i < ls.size(); i++) {
//				CsDTO pdto = (CsDTO) ls.get(i);
//				String rootPath = request.getSession().getServletContext().getRealPath("/");
//				String fjpath = rootPath + File.separator + pdto.getFjpath();
//				if (!FileUtil.checkFile(fjpath)) {
//					String fjcontent = pdto.getFjcontent();
//					if (!Strings.isBlank(fjcontent)) {
//						byte b[] = Base64.base64ToByteArray(fjcontent);
//
//						File file = new File(fjpath);
//						FileOutputStream fos = new FileOutputStream(file);
//						fos.write(b);
//						fos.close();
//					}
//				}
//			}
//		}

		return ls;
	}

	/**
	 *
	 * queryFjViewList的中文名称：查询附件表【fj】
	 *
	 * queryFjViewList的概要说明：判断应用服务器上是否存在附件副本【如果不存在，自动根据数据库记录生成附件副本！】
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	public Map queryFjViewMap(HttpServletRequest request, FjDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjwid,fjpath,fjcontent,fjname,fjtype ");
		sb.append("  from Fj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and fjwid = :fjwid");
		sb.append("   and fjtype = :fjtype");
		String[] ParaName = new String[] { "fjid", "fjwid", "fjtype" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, FjDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * delFj的中文名称：删除附件表
	 *
	 * delFj的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String delFj(HttpServletRequest request, final FjDTO dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final FjDTO dto) {
		String fjidStr = dto.getFjid();
		String[] a = PubFunc.split(fjidStr, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件表
			Fj fj = dao.fetch(Fj.class, Cnd.where("fjid", "=", a[i]));
			// 刪除服務器上的附件
			String rootPath = request.getSession().getServletContext()
					.getRealPath("/");
			fj.setFjpath(rootPath + File.separator + fj.getFjpath());
			File file = new File(fj.getFjpath());
			if (file.exists()) {
				file.delete();
			}
			dao.delete(fj);
		}
	}

	public void delFjFromFjwid(HttpServletRequest request,final String prm_fjwid) throws Exception  {
		String v_sql="select a.fjid,a.fjwid,a.fjpath,a.fjtype,a.fjname from fj a where fjwid='"+prm_fjwid+"'";
		List<Fj> v_listFj=(List<Fj>)DbUtils.getDataList(v_sql, Fj.class);
		for (Fj v_fj:v_listFj){
			// 删除附件表
			//Fj fj = dao.fetch(Fj.class, Cnd.where("fjid", "=", v_fjid));
			// 刪除服務器上的附件
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			v_fj.setFjpath(rootPath + File.separator + v_fj.getFjpath());
			File file = new File(v_fj.getFjpath());
			if (file.exists()) {
				file.delete();
			}
			dao.delete(v_fj);
		}
	}


	/**
	 *
	 * uploadAndSaveFj的中文名称：上传并保存到服务器文件下并保存记录到fj表
	 *
	 * uploadAndSaveFj的概要说明：
	 *
	 * @param request
	 * @return Written by : tmm
	 */
	public String uploadAndSaveFj(HttpServletRequest request,final FjDTO dto) {
		try {
			uploadAndSaveFjImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void uploadAndSaveFjImp(HttpServletRequest request, final FjDTO dto) throws Exception {
		String fjwid = StringHelper.showNull2Empty(request.getParameter("fjwid"));
		if ("".equals(fjwid)) {
			throw new BusinessException("附件所属表主键id不能为空！");
		}
		String uplodafilepath = dto.getFjpath();
		if(uplodafilepath==null || "".equals(uplodafilepath)){
			uplodafilepath="/upload/";
		}else{
			uplodafilepath="/upload/"+uplodafilepath+"/";
		}
		// 上传文件路径
		String uploadPath = request.getSession().getServletContext()
				.getRealPath(uplodafilepath);
		//文件夹判断
		File path = new File(uploadPath);
		if(!path.exists()){
			path.mkdirs();//一级目录
		}
		// 读取上传附件
		Integer chunk = 0;// 分割块数
		Integer chunks = 1;// 总分割数
		String fileName = null; // 文件名
		String tempFileName = null;// 临时文件名
		String newFileName = null;// 最后合并后的新文件名
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
					tempFileName = fi.getName();
					if (tempFileName != null) {
						String chunkName = tempFileName;
						fileName = tempFileName;
						if (chunk != null) {
							chunkName = chunk + "_" + tempFileName;
						}
						File savedFile = new File(uploadPath, chunkName);
						fi.write(savedFile);
					}
				}
				newFileName = UUID.randomUUID().toString().replace("-", "")
						.concat(".")
						.concat(FilenameUtils.getExtension(tempFileName));
				if (chunk != null && chunk + 1 == chunks) {
					outputStream = new BufferedOutputStream(
							new FileOutputStream(new File(uploadPath,
									newFileName)));
					// 遍历文件合并
					for (int i = 0; i < chunks; i++) {
						File tempFile = new File(uploadPath, i + "_"
								+ tempFileName);
						byte[] bytes = FileUtils.readFileToByteArray(tempFile);
						outputStream.write(bytes);
						outputStream.flush();
						tempFile.delete();
					}
					outputStream.flush();
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
		// 将附件保存进数据库
		String fjpathString = uplodafilepath + newFileName;
		String fjnameString = fileName;
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");

		for (int i = 0; i < a.length; i++) {
			Fj fj = new Fj();
			fj.setFjpath(a[i]); // 附件保存路径
			fj.setFjname(b[i]); // 附件名称
			String fjtype = PubFunc.getFileExt(b[i]);
			if (!"".equals(fjtype)) {
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
			}
			fj.setFjwid(fjwid); // 关联id
			final String fjid = DbUtils.getSequenceStr();
			fj.setFjid(fjid); // 附件id
//			fj.setFjczsj(SysmanageUtil.getDbtimeYmdHns()); // 操作时间
			dao.insert(fj);


		/*	// 将图片保存至数据库
			String rootPath = request.getSession().getServletContext()
					.getRealPath("/");
			File file = new File(rootPath + File.separator + fj.getFjpath());

			// 将图片读进输入流
			InputStream fis = new FileInputStream(file);
			fj.setFjcontent(fis);
			dao.update(fj);
			fis.close();*/
		}
	}

	/**
	 *
	 * queryJieshouren的中文名称：查询待办事项 接收人
	 *
	 * queryJieshouren的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryJieshouren(PdbsxDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,b.* ");
		sb.append(" from pdbsx a,pdbsxjsr b ");
		sb.append(" where a.pdbsxid=b.pdbsxid ");
		sb.append("  and a.qtbid=:qtbid");
		sb.append(" order by b.pdbsxjsrid asc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "qtbid"};
		int[] ParaType = new int[] { Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PdbsxDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * saveAjdjCbr的中文名称：保存 待办事项接收人
	 *
	 * saveAjdjCbr的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception
	 */
	public void saveJieshouren(HttpServletRequest request, PdbsxDTO dto) throws Exception {
		saveJieshourenImp(request, dto);
	}

	/**
	 * @Description: 保存 待办事项接收人实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void saveJieshourenImp(HttpServletRequest request, PdbsxDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		String v_pdbsxid=dto.getPdbsxid();

		if (null != dto.getPdbsxid()&&!"".equals(dto.getPdbsxid())) {
			Pdbsx v_Pdbsx = dao.fetch(Pdbsx.class, dto.getPdbsxid());
			v_Pdbsx.setFsnr(dto.getFsnr());
			dao.update(v_Pdbsx);
		}else{
			Pdbsx v_newPdbsx =new Pdbsx();
			v_pdbsxid = DbUtils.getSequenceStr();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();

			v_newPdbsx.setPdbsxid(v_pdbsxid);
			v_newPdbsx.setQtbid(dto.getQtbid());
			v_newPdbsx.setFsuserid(vSysUser.getUserid());
			v_newPdbsx.setFsusername(vSysUser.getDescription());
			v_newPdbsx.setFssj(v_dbDatetime);
			v_newPdbsx.setFsnr(dto.getFsnr().trim());
			v_newPdbsx.setFsxtbz(dto.getFsxtbz());
			v_newPdbsx.setHfid(v_pdbsxid);//回复id
			dao.insert(v_newPdbsx);
		}

		//插入接收人 先删除，再插入
		String v_sql="delete from pdbsxjsr where pdbsxid='"+v_pdbsxid+"'";
		Sql sql = Sqls.create(v_sql);
		dao.execute(sql);

		JSONArray v_array = null;
		Object[]  v_objArray = null;
		// 承办人
		v_array = JSONArray.fromObject(dto.getJieshouren_table_rows());
		v_objArray = v_array.toArray();
		String v_pdbsxjsrid = "";
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			PdbsxjsrDTO v_PdbsxjsrDTO = (PdbsxjsrDTO) JSONObject.toBean(
					v_obj, PdbsxjsrDTO.class);

			Pdbsxjsr v_Pdbsxjsr=new Pdbsxjsr();
			v_pdbsxjsrid = DbUtils.getSequenceStr();
			v_Pdbsxjsr.setPdbsxjsrid(v_pdbsxjsrid);
			v_Pdbsxjsr.setPdbsxid(v_pdbsxid);
			v_Pdbsxjsr.setJsuserid(v_PdbsxjsrDTO.getJsuserid());
			v_Pdbsxjsr.setJsusername(v_PdbsxjsrDTO.getJsusername());
			//v_Pdbsxjsr.setJsclyj();
			v_Pdbsxjsr.setJsorgid(v_PdbsxjsrDTO.getJsorgid());
			v_Pdbsxjsr.setJsorgname(v_PdbsxjsrDTO.getJsorgname());
			v_Pdbsxjsr.setJsbz("0");
			dao.insert(v_Pdbsxjsr);
		}
	}


	/**
	 *
	 * queryJieshouren的中文名称：查询待办事项 接收人 主表
	 *
	 * queryJieshouren的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryPdbsx(PdbsxDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from pdbsx a ");
		sb.append(" where 1=1 ");
		sb.append("  and a.qtbid=:qtbid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "qtbid"};
		int[] ParaType = new int[] { Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PdbsxDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryDaibanshixiang的中文名称：查询待办事项 接收人 主表
	 *
	 * queryDaibanshixiang的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public DaibanshixiangDTO queryDaibanshixiang(DaibanshixiangDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		StringBuffer sb = new StringBuffer();
		sb.append(" select (select count(a.jsuserid) from pdbsxjsr a where ifnull(a.jsbz,'0')='0' and a.jsuserid='"+vSysUser.getUserid()+"') as baoqingsx");
		sb.append(" from dual ");

		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, DaibanshixiangDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return (DaibanshixiangDTO)ls.get(0);
		//Map r = new HashMap();
		//r.put("rows", ls);
		//r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		//return r;
	}

	/**
	 *
	 * queryJieshouren的中文名称：查询待办事项 接收人
	 *
	 * queryJieshouren的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryChayueWei(PdbsxDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.pdbsxid,a.qtbid,a.fsuserid,a.fsusername,a.fssj, ");
		sb.append("a.fsnr,a.fsxtbz,b.pdbsxjsrid,b.jsuserid,b.jsusername,b.jsclyj,");
		sb.append("b.jssj,b.jsorgid,b.jsorgname,b.jsbz,c.ORGNAME AS fsorgname ");
		sb.append(" from pdbsx a,pdbsxjsr b,sysorg c,sysuser d ");
		sb.append(" where a.pdbsxid=b.pdbsxid ");
		sb.append(" AND a.fsuserid=d.USERID ");
		sb.append(" AND c.ORGID=d.ORGID ");
		sb.append("  and b.jsuserid='"+vSysUser.getUserid()+"' ");
		sb.append(" and b.jsbz='"+dto.getJsbz()+"' ");
		sb.append(" order by b.pdbsxjsrid asc ");
		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PdbsxDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * saveAjdjCbr的中文名称：保存 待办事项 已阅
	 *
	 * saveAjdjCbr的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception
	 */
	public void saveBaoqingchulido(HttpServletRequest request, PdbsxDTO dto) throws Exception {
		saveBaoqingchulidoImp(request, dto);
	}

	/**
	 * @Description: 保存 待办事项接收人实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void saveBaoqingchulidoImp(HttpServletRequest request, PdbsxDTO dto)
			throws Exception {
		//Sysuser vSysUser = SysmanageUtil.getSysuser();
		String v_pdbsxjsrid=dto.getPdbsxjsrid();
		String v_dokind=dto.getDokind();

		String v_sql="update pdbsxjsr set jsclyj='"+dto.getJsclyj().trim()+
				"',jssj=now(),jsbz='1' where pdbsxjsrid='"+v_pdbsxjsrid+"'";
		Sql sql = Sqls.create(v_sql);
		dao.execute(sql);

		if (v_dokind!=null && v_dokind.equalsIgnoreCase("huifu")){ //回复
			Pdbsxjsr v_oldPdbsxjsr=new Pdbsxjsr();
			v_oldPdbsxjsr=(Pdbsxjsr)dao.fetch(Pdbsxjsr.class, Cnd.where("pdbsxjsrid", "=", v_pdbsxjsrid));
			Pdbsx v_oldPdbsx=new Pdbsx();
			v_oldPdbsx=dao.fetch(Pdbsx.class, Cnd.where("pdbsxid", "=", v_oldPdbsxjsr.getPdbsxid()));
			v_sql="select a.orgid,a.orgname from sysorg a,sysuser b where a.orgid=b.orgid and b.userid='"+v_oldPdbsx.getFsuserid()+"'";
			List<Sysorg> v_listsysorg=DbUtils.getDataList(v_sql, Sysorg.class);
			Sysorg v_sysorg=new Sysorg();
			if (v_listsysorg!=null && v_listsysorg.size()>0){
				v_sysorg=v_listsysorg.get(0);
			}


			Pdbsxjsr v_newPdbsxjsr=new Pdbsxjsr();
			Pdbsx v_newPdbsx=new Pdbsx();
			String v_newpdbsxid = DbUtils.getSequenceStr();
			String v_newpdbsxjsrid = DbUtils.getSequenceStr();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();

			v_newPdbsx.setPdbsxid(v_newpdbsxid);
			v_newPdbsx.setQtbid(v_oldPdbsx.getPdbsxid());
			v_newPdbsx.setFsuserid(v_oldPdbsxjsr.getJsuserid());
			v_newPdbsx.setFsusername(v_oldPdbsxjsr.getJsusername());
			v_newPdbsx.setFssj(v_dbDatetime);
			v_newPdbsx.setFsnr(dto.getJsclyj().trim());
			v_newPdbsx.setFsxtbz(v_oldPdbsx.getPdbsxid()+"的回复");
			v_newPdbsx.setHfid(v_oldPdbsx.getHfid());

			v_newPdbsxjsr.setPdbsxjsrid(v_newpdbsxjsrid);
			v_newPdbsxjsr.setPdbsxid(v_newpdbsxid);
			v_newPdbsxjsr.setJsuserid(v_oldPdbsx.getFsuserid());
			v_newPdbsxjsr.setJsusername(v_oldPdbsx.getFsusername());
			//v_newPdbsxjsr.setJsclyj("");
			//v_newPdbsxjsr.setJssj(jssj);
			v_newPdbsxjsr.setJsorgid(v_sysorg.getOrgid());
			v_newPdbsxjsr.setJsorgname(v_sysorg.getOrgname());
			v_newPdbsxjsr.setJsbz("0");

			dao.insert(v_newPdbsx);
			dao.insert(v_newPdbsxjsr);
		}
	}

	/**
	 *
	 * querySelectcom的中文名称：查询单位信息
	 *
	 * querySelectcom的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	public Map queryCheckplan(BscheckplanDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());

//		String aaa027 = SysmanageUtil.getSysuserAaa027(vSysUser.getAaa027());
//		dto.setAaa027(aaa027);

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from bscheckplan a ");
		sb.append(" order by planid desc ");

		String sql = sb.toString();
//		String[] ParaName = new String[] {};
//		int[] ParaType = new int[] {};
//
//		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BscheckplanDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryComfeileiZTree的中文名称：按Ztree插件格式构造企业大类树
	 *
	 * queryComfeileiZTree的概要说明：
	 *
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 *
	 */
	public List queryComfeileiZTree(HttpServletRequest request) throws Exception {

		String sb = "";
		sb= "SELECT u.*,"+
		 "(CASE WHEN u.childnum > 0 THEN 'true' ELSE 'false' END) isparent,"+
		 "(CASE WHEN u.childnum > 0 THEN 'true' ELSE 'false' END) isopen "+
		 " FROM ("+
		 "SELECT "+
		 "a.aaa102,"+
         "a.aaa103,"+
         "a.aaa104,"+
         "a.treejibie,"+
         "(SELECT COUNT(t.aaa102)  FROM viewcomfenlei t WHERE t.aaa104=a.aaa102) AS childnum,"+
         "(SELECT max(t.aaa103) FROM viewcomfenlei t WHERE t.aaa102=a.aaa104) AS aaa104name "+
         "FROM viewcomfenlei a "+
         ") u ";

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Aa10DTO.class);
		System.out.println("queryComfeileiZTree "+sb.toString());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 添加企业信息 完成的是注册功能
	 * @throws Exception
	 */
	public void savePcompanyReg(HttpServletRequest request, final PcompanyDTO dto) throws Exception {
		//String qyid=null;
		//try {
			//qyid=savePcompanyImpl(request, dto);
		savePcompanyRegImpl(request, dto);
		//} catch (Exception e) {
		//	return Lang.wrapThrow(e).getMessage();
		//}
		//return qyid;
	}

	/**
	 * 保存企业信息的实现方法 使用事务控制
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Aop( { "trans" })
	public void  savePcompanyRegImpl(HttpServletRequest request, PcompanyDTO dto) throws Exception {
		//验证手机号 是否在用 从操作员表和企业表判断
		String v_sql="";
		v_sql="select commc from pcompany where comyddh='"+dto.getComyddh()+
				"' or comgddh='"+dto.getComyddh()+"'";
		List<Pcompany> v_comlist=DbUtils.getDataList(v_sql, Pcompany.class);
		if (v_comlist!=null && v_comlist.size()>0){
			Pcompany v_com=(Pcompany)v_comlist.get(0);
			throw new BusinessException("该手机号已经被企业“"+v_com.getCommc()+"”使用");
		}

		v_sql="select DESCRIPTION from sysuser where MOBILE='"+dto.getComyddh()+
				"' or MOBILE2='"+dto.getComyddh()+"' or telephone='"+
				dto.getComyddh()+"' or username='"+dto.getComyddh()+"'";
		List<Sysuser> v_userlist=DbUtils.getDataList(v_sql, Sysuser.class);
		if (v_userlist!=null && v_userlist.size()>0){
			Sysuser v_user=(Sysuser)v_userlist.get(0);
			throw new BusinessException("该手机号已经被人员“"+v_user.getDescription()+"”使用");
		}

		//根据企业名称 判断企业是否存在
		v_sql="select comdm from pcompany where commc='"+dto.getCommc() +"'";
	    v_comlist=DbUtils.getDataList(v_sql,Pcompany.class);
	    if (v_comlist!=null && v_comlist.size()>0){
	    	throw new BusinessException("该单位名称已经存在！");
	    }

	    Sysuser v_sysuser= SysmanageUtil.getSysuser();

		// 声明企业代码是全局变量,因为企业表和企业附件表均用到了
		//String qyid=null;
		String v_orgid ="";
		if(dto.getOrgid()!=null && !"".equals(dto.getOrgid())){
			 v_orgid = dto.getOrgid();//gu20160823 手机传的有
		}else{
			if (v_sysuser!=null){
				v_orgid = v_sysuser.getOrgid();//gu20160823
			}
		}

		String v_comdm = SysmanageUtil.getComdm();
		String v_syqylx=SysmanageUtil.getComsyqylx(dto.getComdalei());



			String comid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			Pcompany pcompany = new Pcompany();
			BeanHelper.copyProperties(dto, pcompany); // 拷贝对应的从前台传来的数据
			pcompany.setComid(comid);
			pcompany.setComdm(v_comdm);
			pcompany.setComshbz("1"); // 先默认为已审核
			pcompany.setComdzcsj(v_dbtime);
//			// 厨房面积
//			if ("".equals(dto.getComcfmj()) || dto.getComcfmj() == null) {
//				pcompany.setComcfmj(null);
//			}else{
//				pcompany.setComcfmj(dto.getComcfmj());
//			}
//			// 餐厅面积
//			if ("".equals(dto.getComctmj()) || dto.getComctmj() == null) {
//				pcompany.setComctmj(null);
//			}else{
//				pcompany.setComctmj(dto.getComctmj());
//			}
			// 总面积
//			if ("".equals(dto.getComzmj()) || dto.getComzmj() == null) {
//				pcompany.setComzmj(null);
//			}else{
//				pcompany.setComzmj(dto.getComzmj());
//			}

			// 许可有效期始
//			if ("".equals(dto.getComxkyxqq()) || dto.getComxkyxqq() == null) {
//				pcompany.setComxkyxqq(null);
//			}else{
//				pcompany.setComxkyxqq(dto.getComxkyxqq());
//			}
			// 许可有效期止
//			if ("".equals(dto.getComxkyxqz()) || dto.getComxkyxqz() == null) {
//				pcompany.setComxkyxqz(null);
//			}else{
//				pcompany.setComxkyxqz(dto.getComxkyxqz());
//			}
//			// 企业成立日期
//			if ("".equals(dto.getComclrq()) || dto.getComclrq() == null) {
//				pcompany.setComclrq(null);
//			}else{
//				pcompany.setComclrq(dto.getComclrq());
//			}

			pcompany.setComsyqylx(v_syqylx);
			pcompany.setComfwnfww("0");//0:范围内，1:范围外
			pcompany.setOrgid(v_orgid);
			//企业名称拼音
			pcompany.setCommcjc(PinYinUtil.GetChineseSpell(pcompany.getCommc()));
			dao.insert(pcompany);
			//qyid=comid;
			dto.setComid(comid);

			// gu20160621企业新增后往sysuser表插入一条
			Sysuser v_newSysuser = new Sysuser();
			v_newSysuser.setUserid(comid);
			v_newSysuser.setUsername(dto.getComyddh());
			//v_newSysuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
			v_newSysuser.setPasswd(MD5Util.MD5(dto.getPasswd()).toLowerCase());
			v_newSysuser.setUserkind("6");//6单位参保虚拟用户
			v_newSysuser.setDescription(pcompany.getCommc());
			v_newSysuser.setAaa027(dto.getAaa027());
			v_newSysuser.setOrgid("2016062217255064055994870");
			v_newSysuser.setMobile(dto.getComyddh());//gu20161020add
			v_newSysuser.setTelephone(dto.getComgddh());
			v_newSysuser.setAaz001(comid);

			Sysuserrole v_Sysuserrole=new Sysuserrole();
			String v_USERROLEID = DbUtils.getSequenceStr();
			v_Sysuserrole.setUserroleid(v_USERROLEID);
			v_Sysuserrole.setUserid(comid);
			v_Sysuserrole.setRoleid("2017032318004929759887711");
			//如果检验检测标志位1
			if (dto.getComjyjcbz()!=null && !"".equals(dto.getComjyjcbz())
					&& "1".equals(dto.getComjyjcbz())){
				v_Sysuserrole.setRoleid("2016102114210245464588122");
			}
			dao.insert(v_newSysuser);
			dao.insert(v_Sysuserrole);
			pcompanyService.saveComdalei(dto.getComdalei(),dto.getComid());
			pcompanyService.saveComxiaolei(dto.getComxiaolei(),dto.getComid());
//			if(null!=dto.getComxkzbh() && !"".equals(dto.getComxkzbh())) {
//				String comXkzJson = "[{'comxkzid':'" + DbUtils.getSequenceStr() + "','comid':'" + dto.getComid() + "','comxkzbh':'" + dto.getComxkzbh() + "','comxkfw':'" + dto.getComxkfw() + "','comxkyxqq':'" + dto.getComxkyxqq() + "','comxkyxqz':'" + dto.getComxkyxqz() + "'}]";
//				addXkz(comXkzJson, dto.getComid());
//			}
			//qyid=comid;
		}

		//gu20161020add 单位资质证明
//		if (dto.getSjordnbz()!=null && "2".equals(dto.getSjordnbz())){
//			addXkz(dto.getComzzzmlist(), dto.getComid()); // 插入许可证
//		}

	/**
	 *
	 * saveFjWuzhuti的中文名称：上传附件到服务器后【保存记录到fj表】 无主体
	 *
	 * saveFjWuzhuti的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String saveFjWuzhuti(HttpServletRequest request,final FjDTO dto) {
		try {
			saveFjWuzhutiImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveFjWuzhutiImp(HttpServletRequest request,FjDTO dto) throws Exception {
        //gu20170330add
//		boolean v_haveZhuti=true;
//		if ("nohave".equalsIgnoreCase(dto.getFjwid())){
//			v_haveZhuti=false;
//		}
//		String v_uploadOne = dto.getUploadone();
//		if ("yes".equalsIgnoreCase(v_uploadOne)&&v_haveZhuti){
//			String v_sql="delete from fj where fjwid='"+dto.getFjwid()+"'";
//			Sql v_execsql=Sqls.create(v_sql);
//		    dao.execute(v_execsql);
//		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] oldpathArray = PubFunc.split(fjpathString, ",");
		String v_oldpath="";
		String v_folderName=dto.getFolderName();

		fjpathString=fjpathString.replaceAll("linshi", v_folderName);
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");


		for (int i = 0; i < a.length; i++) {
			Fj fj = new Fj();
			fj.setFjpath(a[i]);
			fj.setFjname(b[i]);

//			String fjtype = PubFunc.getFileExt(b[i]);
//			if (!"".equals(fjtype)) {
//				if (fjtype.equalsIgnoreCase("jpg") || fjtype.equalsIgnoreCase("jpeg") || fjtype.equalsIgnoreCase("png")
//						|| fjtype.equalsIgnoreCase("gif")) {
//					fj.setFjtype("1");
//				} else {
//					fj.setFjtype("2");
//				}
//			}
			String v_fjtype="1";
			if (dto.getFjtype()!=null && !"".equals(dto.getFjtype())){
				v_fjtype=dto.getFjtype();
			}
			fj.setFjtype(v_fjtype);
			fj.setFjwid(dto.getFjwid());
			final String fjid = DbUtils.getSequenceStr();
			fj.setFjid(fjid);
			dao.insert(fj);

			v_oldpath=oldpathArray[i];
			String v_oldpathReal=request.getSession()
					.getServletContext().getRealPath(v_oldpath);
			String v_newpathReal=v_oldpathReal.replaceAll("linshi", v_folderName);
			SysmanageUtil.copyFile(v_oldpathReal, v_newpathReal);
			FileUtil.delFile(v_oldpathReal);

			// gjf压缩处理图片
			String v_fjpath = fj.getFjpath();
			String v_chuliOldFilename = request.getSession()
					.getServletContext().getRealPath(v_fjpath);

			//System.out.print("原路径" + v_chuliOldFilename);
			String v_suiji = DbUtils.getSequenceStr();
			String v_chuliNewFilename = v_fjpath.substring(0,
					v_fjpath.lastIndexOf("/"))
					+ "/" + v_suiji + fj.getFjname();
			v_chuliNewFilename = request.getSession().getServletContext()
					.getRealPath(v_chuliNewFilename);
			//System.out.print("新路径" + v_chuliOldFilename);
			Boolean delflag = ImageCompressUtil.saveMinPhoto(
					v_chuliOldFilename, v_chuliNewFilename, 2048, 1d);
			if (delflag) {
				FileUtil.delFile(v_chuliOldFilename);
				FileUtil.reNameFile(v_chuliNewFilename, v_chuliOldFilename);
			}

		}
	}

	/**
	 *
	 * queryJiBieCanShuZTree的中文名称：按Ztree插件格式构造 通用级别参数
	 *
	 * queryJiBieCanShuZTree的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	public List queryJiBieCanShuZTree(HttpServletRequest request,Aa10DTO dto) throws Exception {
		String sb = "";
		sb += "SELECT h.aaz093,h.aaa100,h.aaa101,h.aaa102,h.aaa103,h.aaa106,h.aaa104,h.aaa105,h.aaa107,h.aae011,h.aae036,h.childnum,";
		sb+="(select aaa103 from aa10 a where a.aaa102=h.aaa104 and aaa100='"+dto.getAaa100()+"') as parentname,";
		sb += "(case when childnum > 0 then 'true' else 'false' end) AS isparent,";
		sb += "(case when childnum > 0 then 'true' else 'false' end) AS isopen ";
		sb += "FROM ( ";
		sb += "SELECT t.aaz093,t.aaa100,t.aaa101,t.aaa102,t.aaa103,t.aaa106,t.aaa104,t.aaa105,t.aaa107,t.aae011,t.aae036,";
		sb += "(select count(t1.aaa102) from aa10 t1 where t1.aaa104 = t.aaa102 and t1.aaa100='"+
				dto.getAaa100()+"') childnum ";
		sb += "FROM aa10 t ";
		sb += "WHERE 1=1 ";
		//if (!StringUtils.isEmpty(dto.getAaa100())){
		sb += " and aaa100='"+dto.getAaa100()+"'";
		//}
		sb += ") h ";

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				Aa10DTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 *
	 * queryNewscateTree的中文名称：按easyui tree格式构造新闻分类树
	 *
	 * queryNewscateTree的概要说明:
	 *
	 * @return Written by : zjf
	 *
	 */
	public List queryJiBieCanShuTree(HttpServletRequest request,@Param("..") Aa10DTO dto) throws Exception {
		List resLs = new ArrayList();
		List ls = queryJiBieCanShuZTree(request,dto);
		for (int i = 0; i < ls.size(); i++) {
			Aa10DTO s = (Aa10DTO) ls.get(i);
			if ("0".equals(s.getAaa104())) {
				Map cm = new HashMap();
				cm.put("id", s.getAaa102());
				cm.put("text", s.getAaa103());
				cm.put("children", getOrgChild(ls, s.getAaa102().toString()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 *
	 * getOrgChild的中文名称：递归调用
	 *
	 * getOrgChild的概要说明：
	 *
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getOrgChild(List ls, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < ls.size(); i++) {
			Aa10DTO s = (Aa10DTO) ls.get(i);
			if (s.getAaa104() != null
					&& parentid.equals(s.getAaa104().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getAaa102());
				cm.put("text", s.getAaa103());
				if (s.getChildnum() > 0) {
					cm.put("children",
							getOrgChild(ls, s.getAaa102().toString()));
				}
				resLs.add(cm);

			}
		}
		return resLs;
	}	
	
	/**
	 * 
	 * saveJiBieCanShu的中文名称：保存级别参数
	 * 
	 * saveJiBieCanShu的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception 
	 * 
	 */

	public String saveJiBieCanShu(final Aa10DTO dto) {
		try {
		String v_sql="";
		
		if (!Strings.isBlank(dto.getAaz093())) {
			//判断级别编码是否存在
			v_sql="select aaa100 from aa10 where aaa100='"+dto.getAaa100()+
					"' and aaa102='"+dto.getAaa102()+"' and aaz093<>'"+dto.getAaz093()+"'";
			List<Aa10DTO> v_aa10list=(List<Aa10DTO>)DbUtils.getDataList(v_sql, Aa10DTO.class);
			if (v_aa10list!=null && v_aa10list.size()>0){
				throw new BusinessException("级别参数编码  已经存在");
			}
			//判断级别参数名称是否存在
			v_sql="select aaa100 from aa10 where aaa100='"+dto.getAaa100()+
					"' and aaa103='"+dto.getAaa103()+"' and aaz093<>'"+dto.getAaz093()+"'";
			List<Aa10DTO> v_aa10list2=(List<Aa10DTO>)DbUtils.getDataList(v_sql, Aa10DTO.class);
			if (v_aa10list2!=null && v_aa10list2.size()>0){
				throw new BusinessException("级别参数名称  已经存在");
			}	
		}
		
		saveJiBieCanShuImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;		
		
	}

	@Aop( { "trans" })
	public void saveJiBieCanShuImp(Aa10DTO dto) throws Exception {
		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
		//获取节点父级别 根据父级别的级别数 获取本级别的级别数
		String v_aaa107="";//级别level值
		Aa10 v_aa10Parent=dao.fetch(Aa10.class, Cnd.where("aaa100", "=", dto.getAaa100()).and("aaa102", "=", dto.getAaa104()));
		if (v_aa10Parent!=null){
			v_aaa107=String.valueOf(Integer.valueOf(v_aa10Parent.getAaa107())+1);
		}
		
		if (!Strings.isBlank(dto.getAaz093())) {
			Aa10 se = dao.fetch(Aa10.class, dto.getAaz093());
			BeanHelper.copyProperties(dto, se);
			se.setAaa106(PinYinUtil.GetChineseSpell(dto.getAaa103()));
			se.setAaa107(v_aaa107);
			dao.update(se);
		} else {
			Aa09 v_Aa09;
			String v_sql="select * from aa09 where aaa100='"+dto.getAaa100()+"'";
			List<Aa09> v_listAa09=(List<Aa09>)DbUtils.getDataList(v_sql, Aa09.class);
			if (v_listAa09==null || v_listAa09.size()==0){
				throw new BusinessException("没找到该参数的根数据");
			}else{
				v_Aa09=v_listAa09.get(0);
			}
			
			Aa10 se = new Aa10();
			BeanHelper.copyProperties(dto, se);
			String v_aaz093 = DbUtils.getSequenceStr();
			se.setAaz093(v_aaz093);
			Timestamp aae036 = new Timestamp(System.currentTimeMillis());
			se.setAae011(vSysUser.getDescription());
			se.setAae036(aae036);
			se.setAaz094(v_Aa09.getAaz094());
			se.setAaa101(v_Aa09.getAaa101());
			se.setAaa106(PinYinUtil.GetChineseSpell(dto.getAaa103()));
			se.setAaa107(v_aaa107);
			dao.insert(se);
		}
	}
	
	/**
	 * 
	 * delNewsCate的中文名称：删除新闻分类
	 * 
	 * delNewsCate的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJiBieCanShu(final Aa10DTO dto) {
		try {
			if (!Strings.isBlank(dto.getAaz093())) {
				// 检查是否可删除
				if ("PJCS".equalsIgnoreCase(dto.getAaa100())){
					Aa10 v_aa10=dao.fetch(Aa10.class, Cnd.where("aaz093", "=", dto.getAaz093()));
					String v_aaa102=v_aa10.getAaa102();
					List PgzpjmxList= null;
					PgzpjmxList = dao.query(Pgzpjmx.class, Cnd.where("pjcs", "=", v_aaa102));
					if (PgzpjmxList != null && PgzpjmxList.size() > 0) {
						//return "该分类下存在【" + PgzpjmxList.size() + "】条记录，不能删除！";
						String v_errmsg="该分类下存在【" + PgzpjmxList.size() + "】条记录，不能删除！";
						throw new BusinessException(v_errmsg);
					}					
				}

				delJiBieCanShuImp(dto);
			} else {
				return "没有接收到要删除的新闻分类ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delJiBieCanShuImp(final Aa10DTO dto) {
		// 删除新闻分类
		dao.clear(Aa10.class, Cnd.where("aaz093", "=", dto.getAaz093()));
	}	
	
	/**
	 * 
	 * querySelectcom的中文名称：查询单位信息
	 * 
	 * querySelectcom的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */

		/*
	 *queryParentchildZTree:通用父子关系表树的生成.
	 * Written by wxy
	 */
	public List queryParentchildZTree(HttpServletRequest request,PubParentChildDto dto) throws Exception {
		String sb = "";
		sb += "SELECT h.parentchildid,h.parentchildlb,h.parentchildlbmc," +
				"h.parentid,h.czsj,h.bh,h.mc,h.userid,h.username,h.sfyx," +
				"h.sx1,h.sx2,h.sx3,h.sx4,h.sx5,h.sx6,h.sx7,h.sx8,h.sx9,h.sx10,h.childnum,";
		sb+="(select mc from parentchild p where p.parentchildid=h.parentid and parentchildlb='"+dto.getParentchildlb().trim()+"') as parentname,";
		sb += "(case when childnum > 0 then 'true' else 'false' end) AS isparent,";
		sb += "(case when childnum > 0 then 'true' else 'false' end) AS isopen ";
		sb += "FROM ( ";
		sb += "SELECT t.parentchildid,t.parentchildlb,t.parentchildlbmc,t.parentid," +
				"t.czsj,t.bh,t.mc,t.userid,t.username,t.sfyx," +
				"t.sx1,t.sx2,t.sx3,t.sx4,t.sx5,t.sx6,t.sx7,t.sx8,t.sx9,t.sx10,";
		sb += "(select count(t1.parentchildid) from parentchild t1 where t1.parentid = t.parentchildid "+") childnum ";
		sb += "FROM parentchild t ";
		sb += "WHERE 1=1 ";
		sb += " and parentchildlb='"+dto.getParentchildlb().trim()+"'";
		//" 'and parentchildlbmc='"+dto.getParentchildlbmc()+"'";
		sb += ") h ";

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				PubParentChildDto.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	/**
	 *
	 * queryParentchildTree的中文名称：按easyui tree格式构造机构树
	 *
	 * queryParentchildTree的概要说明:
	 *
	 * @return Written by : wxy
	 * @throws Exception
	 *
	 */
	public List queryParentchildTree(HttpServletRequest request,@Param("..") PubParentChildDto dto) throws Exception {
		List resLs = new ArrayList();
		List ls = queryParentchildZTree(request, dto);
		for (int i = 0; i < ls.size(); i++) {
			PubParentChildDto s = (PubParentChildDto) ls.get(i);
			if ("0".equals(s.getParentid()) || s.getParentid() == null || "".equals(s.getParentid())) {
				Map cm = new HashMap();
				cm.put("id", s.getParentchildid());
				cm.put("text", s.getMc());
				cm.put("children", getGeneralChild(ls, s.getParentchildid().toString()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 *
	 * getGeneralChild的中文名称：递归调用
	 *
	 * getGeneralChild的概要说明：
	 *
	 * @param parentid
	 * @return Written by : wxy
	 *
	 */
	private List getGeneralChild(List ls, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < ls.size(); i++) {
			PubParentChildDto s = (PubParentChildDto) ls.get(i);
			if (s.getParentid() != null
					&& parentid.equals(s.getParentid().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getParentchildid());
				cm.put("text", s.getMc());
				if (s.getChildnum() > 0) {
					cm.put("children",
							getGeneralChild(ls, s.getParentchildid().toString()));
				}
				resLs.add(cm);

			}
		}
		return resLs;
	}
	/**
	 *
	 * saveParentchild的中文名称：保存
	 *
	 * saveParentchild的概要说明：
	 *
	 * @param dto
	 * @return Written by : wxy
	 *
	 */
	public String saveParentchild(final PubParentChildDto dto) {
		try {
			String v_sql="";

			if (!Strings.isBlank(dto.getParentchildid())) {
				//判断级别编码是否存在
				v_sql="select bh from parentchild where bh='"+dto.getBh()+"' and parentchildid<>'"+dto.getParentchildid()+"'";
				List<PubParentChildDto> parentchild=(List<PubParentChildDto>)DbUtils.getDataList(v_sql, PubParentChildDto.class);
				if (parentchild!=null && parentchild.size()>0){
					throw new BusinessException("编码已经存在");
				}
				//判断级别参数名称是否存在
				v_sql="select mc from parentchild where mc='"+dto.getMc()+"' and parentchildlb='"+dto.getParentchildlb()+
						"' and parentchildid<>'"+dto.getParentchildid()+"'";
				List<PubParentChildDto> parentchild2=(List<PubParentChildDto>)DbUtils.getDataList(v_sql, PubParentChildDto.class);
				if (parentchild2!=null && parentchild2.size()>0){
					throw new BusinessException("名称已经存在");
				}
			}
			saveParentchildImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop( { "trans" })
	public void saveParentchildImp(PubParentChildDto dto) throws Exception {
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		// 特殊处理一级菜单的父菜单ID
		if ("0".equals(dto.getParentid())) {
			dto.setParentid("");
		}
		if (Strings.isNotBlank(dto.getParentchildid())) {
			PubParentChild parentchild = dao.fetch(PubParentChild.class, dto.getParentchildid());
			BeanHelper.copyProperties(dto, parentchild);
			parentchild.setUsername(sysuser.getUsername());
			parentchild.setCzsj(datetime);
			dao.update(parentchild);
		} else {
			PubParentChild parentchild = new PubParentChild();
			String parentchildid = DbUtils.getSequenceStr();
			dto.setParentchildid(parentchildid);
			BeanHelper.copyProperties(dto, parentchild);
			parentchild.setUsername(sysuser.getUsername());
			parentchild.setCzsj(datetime);
			dao.insert(parentchild);
		}
	}
	/**
	 *
	 * delParentchild的中文名称：删除
	 *
	 * delParentchild的概要说明：
	 *
	 * @param dto
	 * @return Written by : wxy
	 *
	 */
	public String delParentchild(final PubParentChildDto dto) {
		try {
			if (!Strings.isBlank(dto.getParentchildid())) {
				// 检查是否可删除
				List parentChildList = null;
				parentChildList = dao.query(PubParentChild.class, Cnd.where("parentid", "=", dto
						.getParentchildid()));
				if (parentChildList != null && parentChildList.size() > 0) {
					return "该分类下存在【" + parentChildList.size() + "】条项目，不能删除！";
				}
				delParentchildImp(dto);
			} else {
				return "没有接收到要删除的项目ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop( { "trans" })
	public void delParentchildImp(final PubParentChildDto dto) {
		// 删除机构
		dao.clear(PubParentChild.class, Cnd.where("parentchildid", "=", dto.getParentchildid()));
	}
	public Map querySelectShangpin(JyjcypDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from jyjcyp a ");
		sb.append(" where 1=1 ");
		sb.append("  and jcypmc like :jcypmc");
		sb.append("  and jcypjc like :jcypjc");
		sb.append("  and spsjlx = :spsjlx");
		//querykind 的中文含义是：querykind 查询数据类型 空或0 不加其他条件 为1 加只查本企业商品
		if (!StringUtils.isEmpty(dto.getQuerykind()) && "1".equals(dto.getQuerykind())){
			sb.append("and a.hviewjgztid='"+vSysUser.getAaz001()+"' ");
		}
		
		String sql = sb.toString();
		String[] ParaName = new String[] {"jcypmc","jcypjc","spsjlx"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcypDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * querySelectcom的中文名称：查询单位信息
	 * 
	 * querySelectcom的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Map querySelectGongyingshang(HjgztkhgxDTO dto, PagesDTO pd) throws Exception {
		Sysuser v_sysuser=SysmanageUtil.getSysuser();
		String v_aaz001="no";
		if (v_aaz001!=null){
			v_aaz001=v_sysuser.getAaz001();
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from hjgztkhgx a ");
		sb.append(" where 1=1 ");
		sb.append("  and hviewjgztid = '"+v_aaz001+"'");
		sb.append("  and jgztkhgx=:jgztkhgx");
		if (!StringUtils.isEmpty(dto.getJgztkhmc())){
			sb.append(" and a.jgztkhmc like '%"+dto.getJgztkhmc()+"%'");
		}
		if (!StringUtils.isEmpty(dto.getJgztkhmcjc())){
			sb.append(" and a.jgztkhmcjc like '%"+dto.getJgztkhmcjc()+"%'");
		}		
		
		String sql = sb.toString();
		String[] ParaName = new String[] {"jgztkhgx"};
		int[] ParaType = new int[] {Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjgztkhgxDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}		
	

	
	/**
	 * 
	 * queryJianGuanZhuTi的中文名称：查询监管主体信息
	 * 
	 * queryJianGuanZhuTi的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Map queryJianGuanZhuTi(HviewjgztDTO dto, PagesDTO pd) throws Exception {
		Sysuser v_sysuser=SysmanageUtil.getSysuser();
		String v_aaz001="no";
		if (v_sysuser!=null){
			v_aaz001=v_sysuser.getAaz001();
		}
		
		String v_jgztfwnfww=dto.getJgztfwnfww();
		
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from hviewjgzt a ");
		sb.append(" where 1=1 ");
		if ("1".equals(v_jgztfwnfww)){//范围内
			sb.append(" and a.jgztfwnfww='1' ");
		}else if ("2".equals(v_jgztfwnfww)) {//范围外
			sb.append(" and a.jgztfwnfww='2' ");
			sb.append(" and a.jgztgsztid='"+v_aaz001+"' ");
			if (!StringUtils.isEmpty(dto.getJgztlx())){
				sb.append(" and a.jgztlx = '"+dto.getJgztlx()+"'");
			}				
		}
		
		if (!StringUtils.isEmpty(dto.getJgztmc())){
			sb.append(" and a.jgztmc like '%"+dto.getJgztmc()+"%'");
		}
		if (!StringUtils.isEmpty(dto.getJgztmcjc())){
			sb.append(" and a.jgztmcjc like '%"+dto.getJgztmcjc()+"%'");
		}
	
		
		String sql = sb.toString();
		//String[] ParaName = new String[] {"jgztkhgx"};
		//int[] ParaType = new int[] {Types.VARCHAR};

		//sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HviewjgztDTO.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 用户注册（依据政融宝）
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	public void saveNetuserReg(HttpServletRequest request, final SysuserDTO dto) throws Exception {
		saveNetuserRegImpl(request, dto);
	}

	/**
	 * 用户注册方法实现
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked" })
	@Aop( { "trans" })
	public void  saveNetuserRegImpl(HttpServletRequest request, SysuserDTO dto) throws Exception {
		//验证登陆帐号是否在用
		String v_sql = "select username from sysuser where username='" + dto.getUsername() + "'";
		List<Sysuser> v_userlist = DbUtils.getDataList(v_sql, Sysuser.class);
		if (v_userlist != null && v_userlist.size() > 0){
			throw new BusinessException("该登陆帐号已被其他用户使用，请更换!");
		}

		// 往sysuser表插入一条
		String v_userid = DbUtils.getSequenceStr();
		Sysuser v_newSysuser = new Sysuser();
		v_newSysuser.setUserid(v_userid);
		v_newSysuser.setUsername(dto.getUsername());
		v_newSysuser.setDescription(dto.getDescription());
		v_newSysuser.setPasswd(MD5Util.MD5(dto.getPasswd()).toLowerCase());
		v_newSysuser.setUserkind("30");//30网络注册用户
		v_newSysuser.setAaa027(dto.getAaa027());
		v_newSysuser.setOrgid("2018052810200772993032647"); // 公众网上注册虚拟机构
		v_newSysuser.setMobile(dto.getMobile());//
		v_newSysuser.setUserdwmc(dto.getUserdwmc());
		v_newSysuser.setUserlxdz(dto.getUserlxdz());
		v_newSysuser.setUseremail(dto.getUseremail());
		// 用户角色对应
		Sysuserrole v_Sysuserrole = new Sysuserrole();
		String v_USERROLEID = DbUtils.getSequenceStr();
		v_Sysuserrole.setUserroleid(v_USERROLEID);
		v_Sysuserrole.setUserid(v_userid);
		v_Sysuserrole.setRoleid("2018052810274279673168566"); // 公众网上注册虚拟机构角色
		dao.insert(v_newSysuser);
		dao.insert(v_Sysuserrole);
	}

	/**
	 * 用户找回密码功能（依据政融宝）
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author zy
	 */
	public void findpwtijiao(HttpServletRequest request, final SysuserDTO dto) throws Exception {
		findpwtijiaoImpl(request, dto);
	}

	/**
	 * 找回密码提交
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Aop( { "trans" })
	public void  findpwtijiaoImpl(HttpServletRequest request, SysuserDTO dto)
			throws Exception {
		//验证登陆帐号是否存在
		String v_sql = "select * from sysuser where username='"+dto.getUsername()+"'";
		String v_findpwsn ="";

		List<Sysuser> v_userlist = DbUtils.getDataList(v_sql, Sysuser.class);
		if (v_userlist == null || v_userlist.size() == 0){
			throw new BusinessException("该登陆帐号不存在!");
		}else{
			//验证邮箱
			Sysuser olduser = (Sysuser)v_userlist.get(0);
			if (olduser.getUseremail() == null || "".equals(olduser.getUseremail())){
				throw new BusinessException("注册时未填写邮箱，不能找回密码!");
			}else{
				if (!olduser.getUseremail().equalsIgnoreCase(dto.getUseremail())){
					throw new BusinessException("请输入注册时的邮箱!");
				}
			}
			v_findpwsn = DbUtils.getSequenceStr();
			//olduser.setFindpwsn(v_findpwsn);
			Sysuser suser = dao.fetch(Sysuser.class, olduser.getUserid());
			suser.setFindpwsn(v_findpwsn);
			dao.update(suser);
		};

		// 发送注册邮件
//		MailService mailService = new MailService();
//		mailService.sendRegisterMailZrb(dto.getUseremail(),
//				v_findpwsn);
		Boolean b_ok = sendMail(request,dto.getUseremail(), v_findpwsn);
		if (!b_ok){
			throw new BusinessException("发送邮件时失败!");
		}
	}

	/**
	 *
	 * @param request
	 * @param toUerEmail 收件人邮箱地址
	 * @param findpwsn 激活码
	 * @return
	 */
	public static boolean sendMail(HttpServletRequest request, String toUerEmail, String findpwsn) {

		try {
			if (null == pp) {
				pp = Mvcs.ctx.getDefaultIoc().get(PropertiesProxy.class, "config");
			}

			String v_fromEmail = pp.get("fromEmail");
			String v_sendFromNickName = pp.get("sendFromNickName");
			String v_fromEmailUserName = pp.get("fromEmailUserName");
			String v_fromEmailUserPwd = pp.get("fromEmailUserPwd");
			String v_fromEmailSmtp = pp.get("fromEmailSmtp");

			Properties props = new Properties();
			props.put("username", v_fromEmailUserName);
			props.put("password", v_fromEmailUserPwd);
			props.put("mail.transport.protocol", "smtp" );
			props.put("mail.smtp.host", v_fromEmailSmtp);
			props.put("mail.smtp.port", "25" );

			Session mailSession = Session.getDefaultInstance(props);
			String basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
					+ request.getServerPort() + request.getContextPath() + "/";

			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(v_fromEmail));
			msg.addRecipients(Message.RecipientType.TO, InternetAddress.parse(toUerEmail));
			msg.setSubject("用户重置密码");
			msg.setContent("<h1>请点击下面链接完成重置操作！</h1><h3><a href='"
					+basePath+"pub/pub/chongzhipw?findpwsn="
					+findpwsn+"'>点击重置密码</a></h3>","text/html;charset=UTF-8");
			msg.saveChanges();

			Transport transport = mailSession.getTransport("smtp");
			transport.connect(props.getProperty("mail.smtp.host"), props
					.getProperty("username"), props.getProperty("password"));
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
			return false;
		}
		return true;
	}

	/**
	 * 重置密码
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	public void chongzhipw(HttpServletRequest request, final SysuserDTO dto) throws Exception {
		chongzhipwImpl(request, dto);
	}

	/**
	 * 找回密码提交
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Aop( { "trans" })
	public void  chongzhipwImpl(HttpServletRequest request, SysuserDTO dto)
			throws Exception {
		//验证登陆帐号是否存在
		String v_sql = "select * from sysuser where findpwsn='" + dto.getFindpwsn()+"'";
		List<Sysuser> v_userlist = DbUtils.getDataList(v_sql, Sysuser.class);
		if (v_userlist==null || v_userlist.size()==0){
			throw new BusinessException("重置密码失败：重置链接不合法!");
		}else{
			Sysuser v_olduser = v_userlist.get(0);
			Sysuser upuser = dao.fetch(Sysuser.class,v_olduser.getUserid());
			upuser.setFindpwsn("");
			upuser.setPasswd("e10adc3949ba59abbe56e057f20f883e");
			dao.update(upuser);
		};
	}

	/**
	 *
	 * queryJiBieCanShuZTree的中文名称：按Ztree插件格式构造 通用级别参数
	 *
	 * queryJiBieCanShuZTree的概要说明：
	 *
	 * @param flag
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 *
	 */
	public String queryCount(HttpServletRequest request,String flag) throws Exception {
		String sb = "select count(1) count from pcompany";
		String sb1 = "SELECT\n" +
				"  COUNT(1) count\n" +
				"FROM pcompany cy,pcompanyxkz ck\n" +
				"WHERE cy.comid = ck.comid and ck.comxkyxqz<=date_add(now(),interval 30 day) and ck.comxkzlx<>'1' and ck.comxkyxqz is not null and ck.comxkyxqz<>'';";
		String sbLiangHuaJZ="SELECT count(1) count FROM bscheckplan b WHERE b.planchecktype = 0 AND b.planeddate>DATE_ADD(NOW(),interval -10 day)";

		String sbRichangAllCount="select count(1) count from bscheckmaster where planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 1)";
		String sbZhuanXiangAllCount="select count(1) count from bscheckmaster where planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 2)";
		String sbRichangCheckedCount="select count(1) count from bscheckmaster where resultstate=4 and  planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 1)";
		String sbRichangUncheckedCount="select count(1) count from bscheckmaster where  resultstate<>4  planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 1)";
		String sbLianghuaCheckedCount="select count(1) count from bscheckmaster where resultstate=4 and planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 0)";
		String sbLianghuaUncheckedCount="select count(1) count from bscheckmaster where resultstate<>4 and  planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 0)";
		String sbZhuanXiangCheckedCount="select count(1) count from bscheckmaster where resultstate=4 and planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 2)";
		String sbZhuanXiangUncheckedCount="select count(1) count from bscheckmaster where resultstate<>4 and  planid in(SELECT planid FROM bscheckplan b WHERE b.planchecktype = 2)";
		String sbZhuTiFuGaiLv = "SELECT ROUND(SUM(bs.rn)/COUNT(1)*100,2) count" +
				"  FROM aa13 a, (SELECT DISTINCT b.comid,case when b1.comid is null then 0 else 1 end rn,b.aaa027 FROM pcompany b LEFT JOIN bscheckmaster b1 ON b.comid = b1.comid) bs\n" +
				"  WHERE a.AAA027=bs.aaa027";
		if("1".equals(flag)){
			sb = sb1;
		}
		if("2".equals(flag)){
			sb = sbLiangHuaJZ;
		}
		if("3".equals(flag)){
			sb = sbRichangAllCount;
		}
		if("4".equals(flag)){
			sb = sbLianghuaCheckedCount;
		}
		if("5".equals(flag)){
			sb = sbLianghuaUncheckedCount;
		}
		if("4".equals(flag)){
			sb = sbLianghuaCheckedCount;
		}
		if("5".equals(flag)){
			sb = sbLianghuaUncheckedCount;
		}
		if("6".equals(flag)){
			sb = sbRichangCheckedCount;
		}
		if("7".equals(flag)){
			sb = sbRichangUncheckedCount;
		}
		if("8".equals(flag)){
			sb = sbZhuanXiangCheckedCount;
		}
		if("9".equals(flag)){
			sb = sbZhuanXiangUncheckedCount;
		}
		if("10".equals(flag)){
			sb = sbZhuanXiangAllCount;
		}
		if("14".equals(flag)){
			sb = sbZhuTiFuGaiLv;
		}

		String count = DbUtils.getOneValue(dao,sb);
		return count;
	}

	public Map queryMapCount(HttpServletRequest request,String flag) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		String v_aaa027 = vSysUser.getAaa027().replaceAll("0*$", "");
		String sb = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6  "+
				"  and p.aaa027 like '%"+v_aaa027+"%'  "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		String sb2 = "SELECT a.AAA129 name,ROUND(SUM(bs.rn)/COUNT(1)*100,2) value\n" +
				"  FROM aa13 a, (SELECT DISTINCT b.comid,case when b1.comid is null then 0 else 1 end rn,b.aaa027 FROM pcompany b LEFT JOIN bscheckmaster b1 ON b.comid = b1.comid) bs\n" +
				"  WHERE a.AAA027=bs.aaa027\n" +
				"  GROUP BY a.AAA129";

		String sb3 = "SELECT '食品小作坊' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101102',p.comdalei)\n" +
				"UNION\n" +
				"SELECT '微型餐饮' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101204',p.comdalei)\n" +
				"UNION\n" +
				"SELECT '小摊贩' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101203',p.comdalei)";
		String sql = sb;
		if("12".equals(flag)){
			sql = sb2;
		}
		if("13".equals(flag)){
			sql = sb3;
		}
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("data", ls);
		return r;
	}

	public Map queryMapCount1(HttpServletRequest request,String flag) throws Exception {
		String aaa129="";
		String aaa027="";
		List list= new ArrayList();
		String sb = " SELECT case when a.AAA103 is not null then '餐饮服务' end name ,COUNT(1) value \n "+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n"+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('101201','101202','101203','101204','101205','101206','101207')  \n"+
				" union "+
				" SELECT case when a.AAA103 is not null then '食品生产' end name ,COUNT(1) value  \n"+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n"+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('101101','101102','101103')  \n"+
				" union  \n" +
				" SELECT case when a.AAA103 is not null then '小作坊' end name ,COUNT(1) value " +
				" FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a " +
				" WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102 " +
				" and length(a.aaa102)=6  and  a.aaa102 in ('101102') " +
				" union  \n"+
				" SELECT case when a.AAA103 is not null then '食品流通' end name ,COUNT(1) value  \n"+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102  \n "+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('101301','101302','101401')  \n"+
				" union  \n"+
				" SELECT case when a.AAA103 is not null then '药品' end name ,COUNT(1) value  \n"+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n"+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('102101','102301','102302') \n "+
				" union  "+
				" SELECT case when a.AAA103 is not null then '医疗器械' end name ,COUNT(1) value  "+
				" FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a  "+
				" WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102    "+
				" and length(a.aaa102)=6  and  a.aaa102 in ('105201')  "+
				" union  \n"+
				" SELECT case when a.AAA103 is not null then '化妆品' end name ,COUNT(1) value \n "+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102  \n "+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('103201')  \n "+
				" union \n "+
				" SELECT case when a.AAA103 is not null then '保健品' end name ,COUNT(1) value \n "+
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n"+
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102  \n "+
				"  and length(a.aaa102)=6  and  a.aaa102 in ('104101','104201') ";

		String sb3 = "SELECT '食品小作坊' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101102',p.comdalei)\n" +
				"UNION\n" +
				"SELECT '微型餐饮' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101204',p.comdalei)\n" +
				"UNION\n" +
				"SELECT '小摊贩' name,COUNT(1) value FROM   pcompany p WHERE  FIND_IN_SET('101203',p.comdalei)";
		String sql = sb;
		if("12".equals(flag)){
//			sql=" select AAA129 name , aaa027 value from aa13 where aae383=4 order by aaa027 ";
			sql=" SELECT AAA129 name , aaa027 value FROM aa13 WHERE aae383='4' AND aae007='1' ORDER BY AAA013 ";
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
			List<Map> ls = (List) m.get(GlobalNames.SI_RESULTSET);

			for(int i=0;i<ls.size();i++){
				aaa129=ls.get(i).get("name").toString();
				aaa027=ls.get(i).get("value").toString();
				//GU20180804 String sb2 = " select case when c.aaa129 is not null then '"+aaa129+"' end name  ,ROUND(SUM(c.rn) / COUNT(1) * 100, 2) value from ( "+
				String sb2 = " select  '"+aaa129+"' as name  ,ROUND(SUM(c.rn) / COUNT(1) * 100, 2) value from ( "+
						" select a.aaa027,a.aaa129,a.aaa148,bs.rn from aa13 a ,( "+
						" select DISTINCT b.comid , b.commc, b.AAA027,CASE WHEN b1.comid IS NULL THEN 0 ELSE 1 END rn "+
						" from pcompany b LEFT JOIN bscheckmaster b1 on b.comid =b1.comid "+
						" )bs where a.aaa027 = bs. AAA027 "+
						" ) c where c.aaa027= '"+aaa027+"' or c.aaa148= '"+aaa027+"' ";
				sql = sb2;
				 Map m1 = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
				 List<Map> ls1 = (List) m1.get(GlobalNames.SI_RESULTSET);
					//if(ls1.get(0).size()!=0){ gu20180804
						list.addAll(ls1);
					//}
			}
			Map r = new HashMap();
			r.put("data", list);
			return r;
		}
		if("13".equals(flag)){
			sql = sb3;
		}
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("data", ls);
		return r;
	}

	public Map queryMapCount2(HttpServletRequest request,String flag) throws Exception {
		//食品生产
		String sb1 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('101101','101103')   "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//食品流通
		String sb2 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('101301','101302','101401')   "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//餐饮服务
		String sb3 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('101201','101202','101203','101204','101205','101206','101207')  "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//药品
		String sb4 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('102101','102301','102302')  "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//化妆品
		String sb5 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('103201')   "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//保健品
		String sb6 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('104101','104201') "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//医疗器械
		String sb7 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('105201')  "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";
		//小作坊
		String sb8 = "SELECT a.AAA103 name ,COUNT(1) value \n" +
				"  FROM pcompany p,pcompanycomdalei p1,viewcomfenlei a \n" +
				"  WHERE p.comid=p1.comid AND p1.comdalei=a.AAA102   \n" +
				"  and length(a.aaa102)=6 and  a.aaa102 in ('101102') "+
				"  GROUP BY a.AAA102 having count(1)>0 order by a.aaa102 ";

		String sql = sb1;
		if("食品生产".equals(flag)){
			sql = sb1;
		}else if("食品流通".equals(flag)){
			sql = sb2;
		}else if("餐饮服务".equals(flag)){
			sql = sb3;
		}else if("药品".equals(flag)){
			sql = sb4;
		}else if("化妆品".equals(flag)){
			sql = sb5;
		}else if("保健品".equals(flag)){
			sql = sb6;
		}else if("医疗器械".equals(flag)){
			sql = sb7;
		}else if("小作坊".equals(flag)){
			sql = sb8;
		}
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("data", ls);
		return r;
	}


}