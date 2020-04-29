package com.zzhdsoft.siweb.service.news;

import com.alibaba.fastjson.JSONObject;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.news.NewsDTO;
import com.zzhdsoft.siweb.entity.Bord;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * NewsService的中文名称：新闻管理service
 * 
 * NewsService的描述：
 * 
 * Written by : zjf
 */
public class NewsService extends BaseService {
	protected final Logger logger = Logger.getLogger(NewsService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryNews的中文名称：查询新闻
	 * 
	 * queryNews的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map queryNews(News dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,b.cateid,newstitle,newsauthor,newsfrom, ");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx, ");
		sb.append(" (select max(fjpath)  from fj t where t.fjwid=a.newsid)  as newsfjpath ");
		sb.append("  from news a,newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.cateid = b.cateid ");
		sb.append("   and b.cateid = :cateid ");
		sb.append("   and b.catejc like :catejc ");
		sb.append("   and a.newsid = :newsid");
		if (!StringUtils.isEmpty(dto.getNewstitle())){
			sb.append("   and (a.newstitle like '%"+dto.getNewstitle()+"%' or b.catejc like '%"+dto.getNewstitle()+"%')");
		}

		sb.append("   order by a.newstjsj desc");
		String[] ParaName = new String[] { "cateid", "catejc", "newsid",
				"newstitle" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * queryNewsList的中文名称：新闻列表
	 * 
	 * queryNewsList的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List queryNewsList(News dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,b.cateid,newstitle,newsauthor,newsfrom, ");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx ");
		sb.append("  from news a,newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.cateid = b.cateid ");
		sb.append("   and b.cateid = :cateid ");
		sb.append("   and b.catejc = :catejc ");
		sb.append("   and a.newsid = :newsid");
		sb.append("   order by a.newstjsj desc");

		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			// sb.append("   and rownum <= :newscount ");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			// sb.append("   and limit :newscount ");
		}

		String[] ParaName = new String[] { "cateid", "catejc", "newsid",
				"newscount" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * queryPreNews的中文名称：查询上一条新闻
	 * 
	 * queryPreNews的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public News queryPreNews(News dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid < :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid desc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		News news = null;
		if (ls != null && ls.size() > 0) {
			news = (News) ls.get(0);
		}
		return news;
	}

	/**
	 * 
	 * queryNextNews的中文名称：查询下一条新闻
	 * 
	 * queryNextNews的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public News queryNextNews(News dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid > :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid asc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		News news = null;
		if (ls != null && ls.size() > 0) {
			news = (News) ls.get(0);
		}
		return news;
	}

	/**
	 * 
	 * saveNews的中文名称：保存新闻
	 * 
	 * saveNews的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String saveNews(HttpServletRequest request, final News dto) {
		try {
			saveNewsImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveNewsImp(HttpServletRequest request, News dto)
			throws Exception {
		if (!Strings.isBlank(dto.getNewsid())) {
			News se = dao.fetch(News.class, dto.getNewsid());
			BeanHelper.copyProperties(dto, se);
			dao.update(se);
		} else {
			News se = new News();
			String newsid = DbUtils.getSequenceStr();
			dto.setNewsid(newsid);
			Sysuser sysuser = SysmanageUtil.getSysuser();
			String aae011 = sysuser.getUserid().toString();
			dto.setNewsauthor(aae011);
			Timestamp aae036 = new Timestamp(System.currentTimeMillis());
			dto.setNewstjsj(aae036);
			BeanHelper.copyProperties(dto, se);
			dao.insert(se);
		}
	}

	/**
	 * 
	 * delNews的中文名称：删除新闻
	 * 
	 * delNews的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delNews(HttpServletRequest request, final News dto) {
		try {
			if (!Strings.isBlank(dto.getNewsid())) {
				delNewsImp(request, dto);
			} else {
				return "没有接收到要删除的新闻ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delNewsImp(HttpServletRequest request, final News dto) {
		// 删除新闻
		dao.clear(News.class, Cnd.where("newsid", "=", dto.getNewsid()));
		// 删除新闻附件
		List fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", dto
				.getNewsid()));
		if (fjList != null && fjList.size() > 0) {
			for (int i = 0; i < fjList.size(); i++) {
				Fj fj = (Fj) fjList.get(i);
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
	public String uploadFj(HttpServletRequest request, final Fj dto) {
		try {
			uploadFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadFjImp(HttpServletRequest request, Fj dto)
			throws Exception {
		String newsid = StringHelper.showNull2Empty(request
				.getParameter("newsid"));
		if ("".equals(newsid)) {
			throw new BusinessException("入参新闻ID不能为空！");
		}

		String fjpathString = dto.getFjpath();
		String fjnameString = dto.getFjname();
		String[] a = PubFunc.split(fjpathString, ",");
		String[] b = PubFunc.split(fjnameString, ",");
		for (int i = 0; i < a.length; i++) {
			Fj fj = new Fj();
			fj.setFjpath(a[i]);
			fj.setFjname(b[i]);

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
			fj.setFjwid(newsid);
			final String fjid = DbUtils.getSequenceStr();
			fj.setFjid(fjid);
			dao.insert(fj);

//			// 将图片保存至数据库
//			String rootPath = request.getSession().getServletContext()
//					.getRealPath("/");
//			File file = new File(rootPath + File.separator + fj.getFjpath());
//
//			// 将图片读进输入流
//			InputStream fis = new FileInputStream(file);
//			fj.setFjcontent(String.valueOf(fis));// ???
//			dao.update(fj);
//			fis.close();
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
	public List queryFjList(HttpServletRequest request, Fj dto)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select fjid,fjpath,fjcontent,fjname,fjtype,newsid ");
		sb.append("  from fj ");
		sb.append(" where 1 = 1 ");
		sb.append("   and fjid = :fjid ");
		sb.append("   and newsid = :newsid");
		String[] ParaName = new String[] { "fjid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, NewsDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		// 判断应用服务器上是否存在附件副本
		if (ls != null && ls.size() > 0) {
			for (int i = 0; i < ls.size(); i++) {
				NewsDTO pdto = (NewsDTO) ls.get(i);
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
	 * 
	 * delFj的中文名称：删除附件
	 * 
	 * delFj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delFj(HttpServletRequest request, final Fj dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final Fj dto) {
		String fjidString = dto.getFjname();
		String[] a = PubFunc.split(fjidString, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件
			Fj fj = dao.fetch(Fj.class, Cnd.where("fjid", "=", a[i]));

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

	/**
	 *
	 * queryNews的中文名称：查询新闻
	 *
	 * queryNews的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map queryBordList(Bord dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
//		select b.djcsmc,niandu,pdjgscfs,commc,a.djcshh
//		from zxpdjg a,zxpddjcs b
//		WHERE a.djcsbm = b.djcsbm
		if("ggtz_sp".equals(dto.getCatejc())){
			//dto.setCatejc("%食品%");
			dto.setAaa104("100");
		}else if ("ggtz_yp".equals(dto.getCatejc())){
			dto.setAaa104("200");
		}else{
			dto.setAaa104("99999");
		}
//		sb.append(" select p.comdm newsid,a.commc newstitle,CONCAT(b.djcsmc,'[',c.aaa103,']') newsauthor ");
//		sb.append("  from zxpdjg a,zxpddjcs b,pcompany p, (SELECT AAA102,AAA103 FROM aa10  WHERE AAA100 = 'DJCSHH') c,(SELECT AAA102,AAA103 FROM aa10 WHERE AAA100 = 'COMDALEI') d ");
//		sb.append(" where a.djcsbm = b.djcsbm and a.djcshh=c.aaa102 AND a.comdm = p.comdm AND p.comdalei = d.AAA102");
//		sb.append(" AND d.AAA103 LIKE :catejc");
		
		sb.append(" select p.comdm newsid,a.commc newstitle,2 as sfxsmxflag,");
		sb.append("CONCAT(b.djcsmc,'[',c.aaa103,']') newsauthor ");
		sb.append("  from zxpdjg a,zxpddjcs b,pcompany p, ");
		sb.append("(SELECT AAA102,AAA103 FROM aa10  WHERE AAA100 = 'DJCSHH') c,");
		sb.append("(SELECT AAA102,AAA103,aaa104 FROM aa10 WHERE AAA100 = 'COMDALEI') d ");
		sb.append(" where a.djcsbm = b.djcsbm and a.djcshh=c.aaa102 ");
		sb.append("AND a.comid = p.comid AND p.comdalei = d.AAA102");
		sb.append(" AND d.AAA104 = :aaa104");
		
		String[] ParaName = new String[] { "aaa104" };
		int[] ParaType = new int[] {Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Bord.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryNews的中文名称：查询新闻
	 *
	 * queryNews的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map queryBordDetail(Bord dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT b.detailinfo cateid FROM bscheckmaster b ,pcompany p WHERE b.comid = p.comid and b.detailinfo is not null AND p.comdm = :newsid");
		String[] ParaName = new String[] { "newsid" };
		int[] ParaType = new int[] {Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Bord.class, pd
				.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * getNewsList的中文名称：获取新闻列表
	 *
	 * getNewsList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getNewsList(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,newstitle,newsauthor,newsfrom, ");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx, ");
		sb.append(" b.cateid,b.catejc,catename ");
		sb.append(" from News a,Newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.cateid = b.cateid ");
		sb.append("   and b.cateid = :cateid ");
		sb.append("   and b.catejc like :catejc ");
		sb.append("   and a.newsid = :newsid");
		sb.append("   order by a.newstjsj desc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "cateid", "catejc", "newsid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };		
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}
	
	/**
	 * 
	 * getPreNews的中文名称：获取上一条新闻
	 * 
	 * getPreNews的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map getPreNews(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid < :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid desc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);		
		return m;
	}

	/**
	 * 
	 * getNextNews的中文名称：获取下一条新闻
	 * 
	 * getNextNews的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map getNextNews(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid > :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid asc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);
		return m;
	}
	
	/**
	 * 
	 * queryLaws的中文名称：查询法律法规
	 * 
	 * queryLaws的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryLaws(NewsDTO dto, PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid, newstitle, newsauthor, newsfrom, ");
		sb.append(" newstjsj, sfyx ");
		if(dto.getNewsid()!=null&&!"".equals(dto.getNewsid())){
			sb.append(" ,newscontent ");
		}
		sb.append(" from news a, newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append(" and a.cateid = b.cateid ");
		sb.append(" and b.catejc like :catejc ");
		sb.append(" and a.newsid = :newsid");
		sb.append(" and a.newstitle like :newstitle");
		sb.append(" order by a.newstjsj desc");
		String[] ParaName = new String[] { "catejc", "newsid", "newstitle" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * uploadnewsTp的中文名称:layui富文本编辑器上传图片
	 *
	 * uploadnewsTp的概要说明:
	 *
	 * @param request
	 * Written by zhangkun 2018年5月4日上午9:43:07
	 */
	public String uploadnewsTp(HttpServletRequest request) {
		//利用上传路径和上传文件名构建文件对象 File  file = new File(path,fileName);
		//上传路径
		String realPath = request.getSession().getServletContext()
				.getRealPath("/upload/NEWSFJ");
		//上传文件名
		String fileName = null;
		BufferedOutputStream bos = null; //缓冲输出字节流
		File dirFile = new File(realPath);
		String result=null;
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		//判断是否是上传文件表单
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
					char indexChar = '\\';
					String Name = fileName.substring(fileName.lastIndexOf(indexChar) + 1,
							fileName.length());
					if (fileName != null) {
						File savedFile = new File(dirFile, Name);
						fi.write(savedFile);
						String path="/upload/NEWSFJ/"+Name;
						String end="{\"code\":0,\"msg\":\"成功\",\"data\":{\"src\":\""+path+"\",\"title\":\""+Name+"\"}}";
						result=JSONObject.toJSON(end).toString();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (bos != null)
						bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}

}
