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
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.zzhdsoft.siweb.entity.Fj;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.Param;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.ncjtjc.dto.JcsbDTO;
import com.askj.ncjtjc.dto.ZyDTO;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.ncjtjc.entity.Jcsb;
import com.askj.ncjtjc.entity.Jcsbcd;
import com.askj.ncjtjc.entity.Jcsbcs;
import com.askj.ncjtjc.entity.Jcsbfj;
import com.askj.ncjtjc.entity.Jcsbjgy;
import com.askj.ncjtjc.entity.Jcsbpswp;
import com.askj.baseinfo.entity.Pdbsx;
import com.askj.baseinfo.entity.Pdbsxjsr;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import com.zzhdsoft.utils.push.JPushAllUtil;

/**
 * 
 * JcglService的中文名称：聚餐管理service
 * 
 * JcglService的描述：
 * 
 * Written by : zjf
 */
public class JcglService extends BaseService {
	protected final Logger logger = Logger.getLogger(JcglService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryJcsb的中文名称：查询聚餐申报
	 * 
	 * queryJcsb的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcsb(ZyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select jcsbid,jcsbbh,jcsbjbrxm,jcsbjbrsjh,jcsbjclx,jcsbjcdd,jcsbjdzb,jcsbwdzb,jcsbbjzt,");
		sb.append(" jcsbjcsj1,jcsbjccc1,jcsbjcsj2,jcsbjccc2,jcsbjcsj3,jcsbjccc3,");
		sb.append(" jcsbjcrs,jcsbjcgm,jcsbylly,jcsbcsly,jcsbcyjly,jgyxcjcbz,");
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,");
		sb.append(" comxianmc,comxiangdm,comxiangmc,comcundm,comcunmc,aab301,");
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbjccc' AND AAA102=a.jcsbjccc1) jcsbjccc1str,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbjccc' AND AAA102=a.jcsbjccc2) jcsbjccc2str,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbjccc' AND AAA102=a.jcsbjccc3) jcsbjccc3str,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbylly' AND AAA102=a.jcsbylly) jcsbyllystr,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbcyjly' AND AAA102=a.jcsbcyjly) jcsbcyjlystr,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbcsly' AND AAA102=a.jcsbcsly) jcsbcslystr,"); 
		sb.append(" (SELECT AAA103 FROM aa10 WHERE AAA100 ='jcsbjclx' AND AAA102=a.jcsbjclx) jcsbjclxstr,"); 
		sb.append(" aaa027,(select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" orgid,(select orgname from Sysorg where orgid = a.orgid) orgname,");
		sb.append(" (select username from Sysuser where userid = a.aae011) as aae011,aae036,aae013");
		sb.append("  from Jcsb a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.jcsbid = :jcsbid ");
		sb.append("  and  a.jcsbbh = :jcsbbh ");
		sb.append("  and  a.jcsbjbrxm = :jcsbjbrxm ");
		sb.append("  and  a.jcsbjbrsjh = :jcsbjbrsjh ");
		sb.append("  and  a.jcsbjcgm = :jcsbjcgm ");
		sb.append("  and  a.aaa027 like :aaa027 ");

		String[] ParaName = new String[] { "jcsbid", "jcsbbh", "jcsbjbrxm", "jcsbjbrsjh", "jcsbjcgm", "aaa027" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR  };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		System.out.println("sql"+sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, ZyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addJcsb的中文名称：新增聚餐申报
	 * 
	 * addJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJcsb(HttpServletRequest request, ZyDTO dto) {
		String jcsbid = null;
		try {
			jcsbid = addJcsbImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return jcsbid;
	}

	@Aop( { "trans" })
	public String addJcsbImp(HttpServletRequest request, ZyDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Jcsb jcsb = new Jcsb();
		BeanHelper.copyProperties(dto, jcsb);
		String v_jcsbid = DbUtils.getSequenceStr();
		jcsb.setJcsbid(v_jcsbid);
		jcsb.setJcsbbh(DbUtils.getOneValue(dao, "select getJcsbbh() from dual"));
//		jcsb.setAae011(SysmanageUtil.getSysuser().getUserid());
		Integer jcsbjcrs = PubFunc.parseInt(dto.getJcsbjcrs());
		if(jcsbjcrs<100){
			jcsb.setJcsbjcgm("1");
		}else if(jcsbjcrs>=100 && jcsbjcrs<300){
			jcsb.setJcsbjcgm("2");
		}else if(jcsbjcrs>=300){
			jcsb.setJcsbjcgm("3");
		}		
		jcsb.setAae036(startTime);
		dao.insert(jcsb);

//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
		
		return v_jcsbid;
	}

	/**
	 * 
	 * updateJcsb的中文名称：修改聚餐申报
	 * 
	 * updateJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String updateJcsb(HttpServletRequest request, ZyDTO dto) {
		try {
			updateJcsbImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateJcsbImp(HttpServletRequest request, ZyDTO dto) throws Exception {
//		Timestamp startTime = SysmanageUtil.currentTime();

		Jcsb jcsb = dao.fetch(Jcsb.class, dto.getJcsbid());
		BeanHelper.copyProperties(dto, jcsb);
		dao.update(jcsb);
		
//		Timestamp endTime = SysmanageUtil.currentTime();
//		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * delJcsb的中文名称：删除聚餐申报
	 * 
	 * delJcsb的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJcsb(HttpServletRequest request, final ZyDTO dto) {
		try {
			if (null != dto.getJcsbid()) {
				// 检查是否可删除
				delJcsbImp(request, dto);
			} else {
				return "没有接收到要删除的聚餐申报ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Aop( { "trans" })
	public void delJcsbImp(HttpServletRequest request, final ZyDTO dto) {
		// 删除聚餐申报
		dao.clear(Jcsb.class, Cnd.where("jcsbid", "=", dto.getJcsbid()));
		// 删除聚餐申报厨师
		dao.clear(Jcsbcs.class, Cnd.where("jcsbid", "=", dto.getJcsbid()));
		// 删除聚餐申报菜单
		dao.clear(Jcsbcd.class, Cnd.where("jcsbid", "=", dto.getJcsbid()));
		// 删除聚餐申报配送物品
		dao.clear(Jcsbpswp.class, Cnd.where("jcsbid", "=", dto.getJcsbid()));
		// 删除聚餐申报监管员
		dao.clear(Jcsbjgy.class, Cnd.where("jcsbid", "=", dto.getJcsbid()));

		// 删除聚餐申报附件
		List fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getJcsbid()).and("fjcsdmz", "like", "JCSBDJBAFJ%"));
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
	public String uploadFj(HttpServletRequest request, final Jcsbfj dto) {
		try {
			uploadFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjImp(HttpServletRequest request, Jcsbfj dto) throws Exception {
		Integer jcsbid = PubFunc.parseInt(request.getParameter("jcsbid"));
		if (jcsbid == 0) {
			throw new BusinessException("入参聚餐申报ID不能为空！");
		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Jcsbfj fj = new Jcsbfj();
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
			fj.setJcsbid(jcsbid);
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
	@SuppressWarnings("rawtypes")
	public List queryFjList(HttpServletRequest request, Jcsbfj dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjpath,fjcontent,fjname,fjtype,jcsbid ");
		sb.append("  from Jcsbfj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and jcsbid = :jcsbid");
		String[] ParaName = new String[] { "fjid", "jcsbid" };
		int[] ParaType = new int[] { Types.LONGVARCHAR, Types.LONGVARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				ZyDTO pdto = (ZyDTO) ls.get(i);
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
	public String delFj(HttpServletRequest request, final Jcsbfj dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final Jcsbfj dto) {
		String fjidStr = dto.getFjname();
		String[] a = PubFunc.split(fjidStr, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件
			Jcsbfj fj = dao.fetch(Jcsbfj.class, Cnd.where("fjid", "=", a[i]));

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
	 * queryJcsbcs的中文名称：查询聚餐申报厨师
	 * 
	 * queryJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcsbcs(ZyDTO dto, PagesDTO pd) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select jcsbcsid,jcsbid,jcsbcslx,b.csid,b.csxm,csxb,");
		sb.append(" cswhcd,csyx,csqq,cswx,");
		sb.append(" cscynx,csjkzm,csjkzyxq,cspxqk,csfwqy");
		sb.append("  from Jcsbcs a,Cs b ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.csid = b.csid ");
		sb.append("  and  a.jcsbid = :jcsbid ");

		String[] ParaName = new String[] { "jcsbid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, ZyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addJcsbcs的中文名称：聚餐申报厨师【保存】
	 * 
	 * addJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto) {
		try {
			addJcsbcsImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addJcsbcsImp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		String succJsonStr = request.getParameter("succJsonStr");
		List<JcsbDTO> lst = Json.fromJsonAsList(JcsbDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			JcsbDTO jcsbDTO = (JcsbDTO) lst.get(i);
			String jcsbcsid = StringHelper.showNull2Empty(jcsbDTO.getJcsbcsid());
			Jcsbcs jcsbcs_old = dao.fetch(Jcsbcs.class, jcsbcsid);
			if (jcsbcs_old != null) {
				jcsbcs_old.setCsid(jcsbDTO.getCsid());
				jcsbcs_old.setJcsbcslx(jcsbDTO.getJcsbcslx());
				dao.update(jcsbcs_old);
			} else {
				Jcsbcs jcsbcs = new Jcsbcs();
				jcsbcs.setJcsbid(jcsbid);
				jcsbcs.setJcsbcsid(DbUtils.getSequenceStr());
				jcsbcs.setCsid(jcsbDTO.getCsid());
				jcsbcs.setJcsbcslx(jcsbDTO.getJcsbcslx());
				dao.insert(jcsbcs);
			}
		}
	}

	/**
	 * 
	 * delJcsbcs的中文名称：聚餐申报厨师【删除】
	 * 
	 * delJcsbcs的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJcsbcs(HttpServletRequest request, final ZyDTO dto) {
		try {
			if (Strings.isNotBlank(dto.getJcsbcsid())) {
				delJcsbcsImp(request, dto);
			} else {
				return "没有接收到要删除的聚餐申报厨师ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delJcsbcsImp(HttpServletRequest request, final ZyDTO dto) {
		dao.clear(Jcsbcs.class, Cnd.where("jcsbcsid", "=", dto.getJcsbcsid()));
	}

	/**
	 * 
	 * queryJcsbcd的中文名称：查询聚餐申报菜单
	 * 
	 * queryJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcsbcd(ZyDTO dto, PagesDTO pd) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select jcsbcdid,jcsbid,jcsbcdlx,jcsbcdmc");
		sb.append("  from Jcsbcd a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.jcsbid = :jcsbid ");

		String[] ParaName = new String[] { "jcsbid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, Jcsbcd.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addJcsbcd的中文名称：聚餐申报菜单【保存】
	 * 
	 * addJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJcsbcd(HttpServletRequest request, @Param("..") ZyDTO dto) {
		try {
			addJcsbcdImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addJcsbcdImp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		String succJsonStr = request.getParameter("succJsonStr");
		List<JcsbDTO> lst = Json.fromJsonAsList(JcsbDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			JcsbDTO jcsbDTO = (JcsbDTO) lst.get(i);
			String jcsbcdid = StringHelper.showNull2Empty(jcsbDTO.getJcsbcdid());
			Jcsbcd jcsbcd_old = dao.fetch(Jcsbcd.class, jcsbcdid);
			if (jcsbcd_old != null) {
				jcsbcd_old.setJcsbcdlx(jcsbDTO.getJcsbcdlx());
				jcsbcd_old.setJcsbcdmc(jcsbDTO.getJcsbcdmc());
				dao.update(jcsbcd_old);
			} else {
				Jcsbcd jcsbcd = new Jcsbcd();
				jcsbcd.setJcsbid(jcsbid);
				jcsbcd.setJcsbcdid(DbUtils.getSequenceStr());
				jcsbcd.setJcsbcdlx(jcsbDTO.getJcsbcdlx());
				jcsbcd.setJcsbcdmc(jcsbDTO.getJcsbcdmc());
				dao.insert(jcsbcd);
			}
		}
	}

	/**
	 * 
	 * delJcsbcd的中文名称：聚餐申报菜单【删除】
	 * 
	 * delJcsbcd的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJcsbcd(HttpServletRequest request, final ZyDTO dto) {
		try {
			if (Strings.isNotBlank(dto.getJcsbcdid())) {
				delJcsbcdImp(request, dto);
			} else {
				return "没有接收到要删除的聚餐申报菜单ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delJcsbcdImp(HttpServletRequest request, final ZyDTO dto) {
		dao.clear(Jcsbcd.class, Cnd.where("jcsbcdid", "=", dto.getJcsbcdid()));
	}

	/**
	 * 
	 * queryJcsbpswp的中文名称：查询聚餐申报配送物品
	 * 
	 * queryJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcsbpswp(ZyDTO dto, PagesDTO pd) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select jcsbpswpid,jcsbid,jcsbpswplx,jcsbpswpmc,");
		sb.append(" jcsbpswppp,jcsbpswpsl");
		sb.append("  from Jcsbpswp a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.jcsbid = :jcsbid ");

		String[] ParaName = new String[] { "jcsbid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, Jcsbpswp.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addJcsbpswp的中文名称：聚餐申报配送物品【保存】
	 * 
	 * addJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJcsbpswp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		try {
			addJcsbpswpImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addJcsbpswpImp(HttpServletRequest request, @Param("..") ZyDTO dto) {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		String succJsonStr = request.getParameter("succJsonStr");
		List<JcsbDTO> lst = Json.fromJsonAsList(JcsbDTO.class, succJsonStr);
		for (int i = 0; i < lst.size(); i++) {
			JcsbDTO jcsbDTO = (JcsbDTO) lst.get(i);
			String jcsbpswpid = StringHelper.showNull2Empty(jcsbDTO.getJcsbpswpid());
			Jcsbpswp jcsbpswp_old = dao.fetch(Jcsbpswp.class, jcsbpswpid);
			if (jcsbpswp_old != null) {
				jcsbpswp_old.setJcsbpswplx(jcsbDTO.getJcsbpswplx());
				jcsbpswp_old.setJcsbpswpmc(jcsbDTO.getJcsbpswpmc());
				jcsbpswp_old.setJcsbpswppp(jcsbDTO.getJcsbpswppp());
				jcsbpswp_old.setJcsbpswpsl(jcsbDTO.getJcsbpswpsl());
				dao.update(jcsbpswp_old);
			} else {
				Jcsbpswp jcsbpswp = new Jcsbpswp();
				jcsbpswp.setJcsbid(jcsbid);
				jcsbpswp.setJcsbpswpid(DbUtils.getSequenceStr());
				jcsbpswp.setJcsbpswplx(jcsbDTO.getJcsbpswplx());
				jcsbpswp.setJcsbpswpmc(jcsbDTO.getJcsbpswpmc());
				jcsbpswp.setJcsbpswppp(jcsbDTO.getJcsbpswppp());
				jcsbpswp.setJcsbpswpsl(jcsbDTO.getJcsbpswpsl());
				dao.insert(jcsbpswp);
			}
		}
	}

	/**
	 * 
	 * delJcsbpswp的中文名称：聚餐申报配送物品【删除】
	 * 
	 * delJcsbpswp的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delJcsbpswp(HttpServletRequest request, final ZyDTO dto) {
		try {
			if (Strings.isNotBlank(dto.getJcsbpswpid())) {
				delJcsbpswpImp(request, dto);
			} else {
				return "没有接收到要删除的聚餐申报配送物品ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delJcsbpswpImp(HttpServletRequest request, final ZyDTO dto) {
		dao.clear(Jcsbpswp.class, Cnd.where("jcsbpswpid", "=", dto.getJcsbpswpid()));
	}

	/**
	 * 
	 * queryJcjgyNo的中文名称：查询聚餐可指派的现场监管员
	 * 
	 * queryJcjgyNo的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcjgyNo(ZyDTO dto, PagesDTO pd) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}

		Map map = queryJcsb(dto, pd);
		List lst = (List) map.get("rows");
		ZyDTO zyDTO = null;
		if (lst != null && lst.size() > 0) {
			zyDTO = (ZyDTO) lst.get(0);
		} else {
			throw new BusinessException("未查询到符合条件的聚餐申报记录！");
		}
		String jcsbjcgm = zyDTO.getJcsbjcgm();
		String aaa027 = zyDTO.getAaa027();
//		String comshengdm = aaa027.substring(0, 2).concat("0000000000");
//		String comshidm = aaa027.substring(0, 4).concat("00000000");
		String comxiandm = aaa027.substring(0, 6).concat("000000");
		String comxiangdm = aaa027.substring(0, 9).concat("000");
		String comcundm = aaa027;

		String sb = "";
		sb += " select userid,username,userkind,b.orgname,b.orgid ";
		sb += "   from Sysuser a,Sysorg b ";
		sb += "  where a.orgid = b.orgid ";
		sb += "    and a.userkind in('12','13','14','15','16') ";
		if ("1".equals(jcsbjcgm)) {
			sb += "  and a.aaa027 = '" + comcundm + "'";
		}
		if ("2".equals(jcsbjcgm)) {
			sb += "  and (a.aaa027 = '" + comcundm + "' or a.aaa027 = '" + comxiangdm + "')";
		}
		if ("3".equals(jcsbjcgm)) {
			sb += "  and (a.aaa027 = '" + comcundm + "' or a.aaa027 = '" + comxiangdm + "' or a.aaa027 = '" + comxiandm + "')";
		}

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, null, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * queryJcjgy的中文名称：查询聚餐已指派的现场监管员
	 * 
	 * queryJcjgy的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcjgy(ZyDTO dto, PagesDTO pd) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}

		StringBuffer sb = new StringBuffer();
		sb.append("   select a.userid,username,userkind,b.orgname ");
		sb.append("    from Sysuser a,Sysorg b,Jcsbjgy c ");
		sb.append("   where a.orgid = b.orgid ");
		sb.append("     and a.userid = c.userid ");
		sb.append("     and c.jcsbid = '").append(jcsbid).append("'");

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, null, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addJcjgy的中文名称：聚餐指派现场监管员【保存】
	 * 
	 * addJcjgy的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addJcjgy(HttpServletRequest request, @Param("..") ZyDTO dto) {
		try {
			addJcjgyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addJcjgyImp(HttpServletRequest request, @Param("..") ZyDTO dto) throws Exception {
		String jcsbid = StringHelper.showNull2Empty(dto.getJcsbid());
		if ("".equals(jcsbid)) {
			throw new BusinessException("聚餐申报ID不能为空！");
		}
		Jcsb v_jcsb = dao.fetch(Jcsb.class, Cnd.where("jcsbid", "=", jcsbid));
		// 登录用户
		Sysuser v_user = SysmanageUtil.getSysuser();
		// 指派集体聚餐任务备注
		StringBuffer jcinfo = new StringBuffer();
		jcinfo.append("农村集体聚餐任务任务 \n");
		jcinfo.append("举办人：").append(v_jcsb.getJcsbjbrxm()).append("\n");
		jcinfo.append("举办人手机号：").append(v_jcsb.getJcsbjbrsjh()).append("\n");
		jcinfo.append("聚餐时间：").append(v_jcsb.getJcsbjcsj1()).append("\n");
		jcinfo.append("聚餐地点：").append(v_jcsb.getJcsbjcdd()).append("\n");
		// 加入代办事项
		Pdbsx v_newPdbsx = new Pdbsx(); // 代办事项
		String v_pdbsxid = DbUtils.getSequenceStr();
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
		v_newPdbsx.setPdbsxid(v_pdbsxid); // 代办事项id
		v_newPdbsx.setQtbid(jcsbid); // 其他相关表id（聚餐申报id）
		v_newPdbsx.setFsuserid(v_user.getUserid()); // 指派人id
		v_newPdbsx.setFsusername(v_user.getDescription()); // 指派人名字
		v_newPdbsx.setFssj(v_dbDatetime); // 指派时间
		v_newPdbsx.setFsnr(jcinfo.toString()); // 指派内容
		v_newPdbsx.setFsxtbz("农村集体聚餐任务"); // 指派备注
		dao.insert(v_newPdbsx);
		// 先删除，再添加
		dao.clear(Jcsbjgy.class, Cnd.where("jcsbid", "=", jcsbid));
		// 指派监管人员集合
		List<String> useridList = new ArrayList<String>();
		String JsonStr = request.getParameter("JsonStr");
		List<JcsbDTO> lst = Json.fromJsonAsList(JcsbDTO.class, JsonStr);
		for (int i = 0; i < lst.size(); i++) {
			JcsbDTO jcsbDTO = (JcsbDTO) lst.get(i);

			Jcsbjgy jcsbjgy = new Jcsbjgy();
			jcsbjgy.setJcsbjgyid(DbUtils.getSequenceStr());
			jcsbjgy.setJcsbid(jcsbid);
			jcsbjgy.setUserid(jcsbDTO.getUserid());
			Sysuser sysuser = SysmanageUtil.getSysuser();
			String aae011 = sysuser.getUserid();
			Timestamp aae036 = new Timestamp(System.currentTimeMillis());
			jcsbjgy.setAae011(aae011);
			jcsbjgy.setAae036(aae036);
			dao.insert(jcsbjgy);
			
			// 发送任务给指定人员（平台端待办事项）
			Pdbsxjsr v_Pdbsxjsr = new Pdbsxjsr(); // 代办事项人员
			v_Pdbsxjsr.setPdbsxjsrid(DbUtils.getSequenceStr()); // 主键id
			v_Pdbsxjsr.setPdbsxid(v_pdbsxid); // 代办事项id
			v_Pdbsxjsr.setJsuserid(jcsbDTO.getUserid()); // 监管员id
			v_Pdbsxjsr.setJsusername(jcsbDTO.getUsername()); // 接受人用户名
			v_Pdbsxjsr.setJsorgid(jcsbDTO.getOrgid()); // 接受人组织机构id
			v_Pdbsxjsr.setJsorgname(jcsbDTO.getOrgname()); // 接受人部门名称
			v_Pdbsxjsr.setJsbz("0");
			dao.insert(v_Pdbsxjsr);
			
			useridList.add(jcsbDTO.getUserid());
		}
		
		// 发送任务给指定人员（手机端极光推送）
		JPushAllUtil.androidSendPushByalias(useridList, "1",  jcinfo.toString(), "集体聚餐通知" );
	}

	/**
	 * 
	 * queryJcsbByJgy的中文名称：【根据指派的监管员】查询聚餐申报记录
	 * 
	 * queryJcsbByJgy的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJcsbByJgy(ZyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select jcsbid,jcsbbh,jcsbjbrxm,jcsbjbrsjh,jcsbjclx,jcsbjcdd,jcsbjdzb,jcsbwdzb,jcsbbjzt,");
		sb.append(" jcsbjcsj1,jcsbjccc1,jcsbjcsj2,jcsbjccc2,jcsbjcsj3,jcsbjccc3,");
		sb.append(" jcsbjcrs,jcsbjcgm,jcsbylly,jcsbcsly,jcsbcyjly,jgyxcjcbz, ");
		sb.append(" (select distinct c.itemtype from aa10 b , ombasetype c  where  b.AAA100='JCSBJCGM' ");
		sb.append("  and c.basetype = b.AAZ093 and b.AAA102=IFNULL(a.jcsbjcgm,'1')) as itemid, ");//IFNULL(a.jcsbjcgm,'1')
		sb.append(" comshengdm,comshengmc,comshidm,comshimc,comxiandm,");
		sb.append(" comxianmc,comxiangdm,comxiangmc,comcundm,comcunmc,aab301,");
		sb.append(" aaa027,(select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" orgid,(select orgname from Sysorg where orgid = a.orgid) orgname,");
		sb.append(" (select username from Sysuser where userid = a.aae011) as aae011,aae036,aae013");
		sb.append("  from Jcsb a ");
		sb.append(" where 1 = 1 ");
		sb.append("  and  a.jcsbid = :jcsbid ");
		sb.append("  and  a.jcsbbh = :jcsbbh ");
		sb.append("  and  a.jcsbjbrxm like :jcsbjbrxm ");
		sb.append("  and  a.jcsbjbrsjh = :jcsbjbrsjh ");
		sb.append("  and  a.jcsbjcrs = :jcsbjcrs ");
		sb.append("  and  a.jgyxcjcbz = :jgyxcjcbz ");// 监管员现场检查标志
		//（用户的演示数据权限,1不控制）
		if(!"1".equals(dto.getReprole())){
			sb.append("  and  exists(select 1 from Jcsbjgy b where b.jcsbid = a.jcsbid and b.userid = :userid and 1=1) ");
		}
		
		String[] ParaName = new String[] { "jcsbid", "jcsbbh", "jcsbjbrxm", "jcsbjbrsjh", "jcsbjcrs", "jgyxcjcbz", "userid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		System.out.println("sql  " + sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,ZyDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	
	/**
	 * 
	 * getJcsbRecord的中文名称：查询聚餐申报报表信息
	 * 
	 * getJcsbRecord的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception 
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getJcsbRecord(HttpServletRequest request, final ZyDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		Map map = new HashMap();
		sb.append(" select jcsbid,jcsbbh,jcsbjbrxm,jcsbjbrsjh, jcsbjcrs,");
		sb.append("  getAa10_aaa103('JCSBJCLX',jcsbjclx) jcsbjclx,");
		sb.append(" getAa10_aaa103('JCSBJCRS',jcsbjcrs) jcsbjcrs, ");
		sb.append("  getAa10_aaa103('JCSBYLLY',jcsbylly) jcsbylly, ");
		sb.append("  getAa10_aaa103('JCSBCSLY',jcsbcsly) jcsbcsly,");
		sb.append("  jcsbjcdd,jcsbjdzb,jcsbwdzb,jcsbjcsj1,jcsbjcsj2,jcsbjcsj3,");
		sb.append("  aab301, comshengdm,comshengmc,comshidm,comshimc,comxiandm,comxianmc,");
		sb.append("  comxiangdm,comxiangmc,comcundm,comcunmc,");
		sb.append("  (select username from Sysuser where userid = a.aae011) as aae011,");
		sb.append("  date_format(aae036,'%Y-%m-%d') aae036 ,aae013");
		sb.append("  from Jcsb a where 1=1 and  a.jcsbid = :jcsbid ");
		String[] ParaName = new String[] {"jcsbid" };
		int[] ParaType = new int[] {  Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		if(ls.size()>0){
			ZyDTO jscbbean = (ZyDTO) ls.get(0);
				//获取页面
			String html = setJcsbValue(jscbbean, "jcsbRecord", "1");
			map.put("data", html);
		}else {
			map.put("data", "");
		}
		
		return map;
}
	
	public String  setJcsbValue(ZyDTO dto,String tbodytype ,String tbodycode) throws Exception{
		BsTbodyInfoDTo bodydto = new BsTbodyInfoDTo();
		String  html ="";
		bodydto.setTbodycode(tbodycode);
		bodydto.setTbodytype(tbodytype);
		bodydto = CsglService.getTbodyInfoHtml(bodydto);
		if(bodydto!=null){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String aaa036 = "";
			try{
			if(dto.getAae036()!=null&&!"".equals(dto.getAae036())){
				 aaa036= formatter.format(dto.getAae036());
			}
			html = bodydto.getTbodyinfo().replaceFirst("jcsbbh", dto.getJcsbbh()==null?"":dto.getJcsbbh())
					.replaceFirst("comxianmc", dto.getComxianmc()==null?"":dto.getComxianmc())
					.replaceFirst("comxiangmc", dto.getComxiangmc()==null?"":dto.getComxiangmc())
					.replaceFirst("comcunmc", dto.getComcunmc()==null?"":dto.getComcunmc())
					.replaceFirst("jcsbjbrxm", dto.getJcsbjbrxm()==null?"":dto.getJcsbjbrxm())
					.replaceFirst("jcsbjbrsjh", dto.getJcsbjbrsjh()==null?"":dto.getJcsbjbrsjh())
					.replaceFirst("jcsbjclx", dto.getJcsbjclx()==null?"":dto.getJcsbjclx())
					.replaceFirst("aab301", dto.getAab301()==null?"":dto.getAab301())
					.replaceFirst("jcsbjcsj1", dto.getJcsbjcsj1()==null?"":dto.getJcsbjcsj1())
					.replaceFirst("jcsbjcsj2", dto.getJcsbjcsj2()==null?"":dto.getJcsbjcsj2())
					.replaceFirst("jcsbjcsj3", dto.getJcsbjcsj3()==null?"":dto.getJcsbjcsj3())
					.replaceFirst("jcsbjcrs", dto.getJcsbjcrs()==null?"":dto.getJcsbjcrs())
					.replaceFirst("jcsbylly", dto.getJcsbylly()==null?"":dto.getJcsbylly())
					.replaceFirst("jcsbcsly", dto.getJcsbcsly()==null?"":dto.getJcsbcsly())
					.replaceFirst("aae036", aaa036)
					.replaceFirst("aae011", dto.getAae011()==null?"":dto.getAae011());
					return html;
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
}
