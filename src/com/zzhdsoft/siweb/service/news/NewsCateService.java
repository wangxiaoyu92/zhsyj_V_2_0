package com.zzhdsoft.siweb.service.news;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.entity.news.Newscate;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;

/**
 * 
 * NewsCateService的中文名称：新闻分类管理service
 * 
 * NewsCateService的描述：
 * 
 * Written by : zjf
 */
public class NewsCateService extends BaseService {
	protected final Logger logger = Logger.getLogger(NewsCateService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryNewsCateByCatename的中文名称：查询新闻分类
	 * 
	 * queryNewsCateByCatename的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map queryNewsCateByCatename(Newscate dto, PagesDTO pd)
			throws Exception {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		c.and("lower(catename)", "=", dto.getCatename().toLowerCase());

		Map r = new HashMap();
		r.put("rows", dao.query(Newscate.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Newscate.class, c));
		return r;
	}

	/**
	 * 
	 * queryNewsCate的中文名称：查询新闻分类
	 * 
	 * queryNewsCate的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	public Map queryNewsCate(Newscate dto, PagesDTO pd) {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		if (!Strings.isEmpty(dto.getCatename())) {
			c.and("catename", "like", "%" + dto.getCatename() + "%");
		}
		if (!Strings.isEmpty(dto.getCatejc())) {
			c.and("catejc", "like", "%" + dto.getCatejc() + "%");
		}
		c.asc("cateid");

		Map r = new HashMap();
		r.put("rows", dao.query(Newscate.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Newscate.class, c));
		return r;
	}

	/**
	 * 
	 * isExistsCatename的中文名称：校验新闻分类名称是否存在
	 * 
	 * isExistsCatename的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String isExistsCatename(Newscate dto) throws Exception {
		// 校验新闻分类名称是否已经存在
		PagesDTO pd = new PagesDTO();
		Map m = queryNewsCateByCatename(dto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			return "该新闻分类已存在，新闻分类名称不能重复！";
		}
		return null;
	}

	/**
	 * 
	 * saveNewsCate的中文名称：保存新闻分类
	 * 
	 * saveNewsCate的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */

	public String saveNewsCate(final Newscate dto) {
		try {
			String flag;
			if (!Strings.isBlank(dto.getCateid())) {
				Newscate se = dao.fetch(Newscate.class, dto.getCateid());
				if (!(se.getCatename()).equals(dto.getCatename())) {
					flag = isExistsCatename(dto);
					if (flag != null) {
						return flag;
					}
				}
			} else {
				flag = isExistsCatename(dto);
				if (flag != null) {
					return flag;
				}
			}
			saveNewsCateImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveNewsCateImp(Newscate dto) throws Exception {
		// 特殊处理一级分类的父分类ID
		if ("0".equals(dto.getCateparentid())) {
			dto.setCateparentid(null);
		}
		if (!Strings.isBlank(dto.getCateid())) {
			Newscate se = dao.fetch(Newscate.class, dto.getCateid());
			BeanHelper.copyProperties(dto, se);
			dao.update(se);
		} else {
			Newscate se = new Newscate();
			String cateid = DbUtils.getSequenceStr();
			dto.setCateid(cateid);
			Timestamp aae036 = new Timestamp(System.currentTimeMillis());
			dto.setCateadddate(aae036);
			BeanHelper.copyProperties(dto, se);
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
	public String delNewsCate(final Newscate dto) {
		try {
			if (!Strings.isBlank(dto.getCateid())) {
				// 检查是否可删除
				List newsList = null;
				newsList = dao.query(News.class, Cnd.where("cateid", "=", dto
						.getCateid()));
				if (newsList != null && newsList.size() > 0) {
					return "该新闻分类下存在【" + newsList.size() + "】条新闻，不能删除！";
				}
				delNewsCateImp(dto);
			} else {
				return "没有接收到要删除的新闻分类ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delNewsCateImp(final Newscate dto) {
		// 删除新闻分类
		dao.clear(Newscate.class, Cnd.where("cateid", "=", dto.getCateid()));
	}

	/**
	 * 
	 * queryNewcateZTree的中文名称：按Ztree插件格式构造新闻分类树
	 * 
	 * queryNewcateZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List queryNewcateZTree(HttpServletRequest request) throws Exception {
		String sb = "";
		sb += " select cateid,cateparentid,catename,catejc,catelevel,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen ";
		sb += " from(";
		sb += " select t.cateid,t.cateparentid,t.catename,t.catejc,t.catelevel,";
		sb += " (select count(t1.cateid) from Newscate t1 ";
		sb += "  where t1.cateparentid = t.cateid) childnum ";
		sb += " from Newscate t ";
		sb += " ) h";// mysql
		// sb +=
		// " start with  t.cateparentid is null connect by prior t.cateid=t.cateparentid) h";//oracle

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				Newscate.class);
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
	public List queryNewscateTree(HttpServletRequest request) throws Exception {
		List resLs = new ArrayList();
		List ls = queryNewcateZTree(request);
		for (int i = 0; i < ls.size(); i++) {
			Newscate s = (Newscate) ls.get(i);
			if ("0".equals(s.getCateparentid())) {
				Map cm = new HashMap();
				cm.put("id", s.getCateid());
				cm.put("text", s.getCatename());
				cm.put("children", getOrgChild(ls, s.getCateid().toString()));
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
	 * @param orglist
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getOrgChild(List ls, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < ls.size(); i++) {
			Newscate s = (Newscate) ls.get(i);
			if (s.getCateparentid() != null
					&& parentid.equals(s.getCateparentid().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getCateid());
				cm.put("text", s.getCatename());
				if (s.getChildnum() > 0) {
					cm.put("children",
							getOrgChild(ls, s.getCateid().toString()));
				}
				resLs.add(cm);

			}
		}
		return resLs;
	}
}
