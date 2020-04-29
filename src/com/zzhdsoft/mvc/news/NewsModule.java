package com.zzhdsoft.mvc.news;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Bord;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.service.news.NewsService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.PubFunc;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * NewsModule的中文名称：新闻管理
 * 
 * NewsModule的描述：
 * 
 * Written by : zjf
 */
@At("/news")
@IocBean
public class NewsModule {
	protected final Logger logger = Logger.getLogger(NewsModule.class);

	@Inject
	protected NewsService newsService;

	/**
	 * 
	 * newsIndex的中文名称：新闻管理页面初始化
	 * 
	 * newsIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/news/news")
	public void newsIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * addNews的中文名称：添加新闻页面
	 * 
	 * addNews的概要说明：
	 * 
	 * @param request
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/news/newsadd")
	public void addNews(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * editNews的中文名称：编辑新闻页面
	 * 
	 * editNews的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/news/newsedit")
	public void editNews(HttpServletRequest request, @Param("..") News dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = newsService.queryNews(dto, pd);
		List newsList = (List) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);
	}
	
	/**
     * 
	 * flfgnewsIndex的中文名称：法律法规管理页面
	 * 
	 * flfgnewsIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : ly
	 */
	@At
	@Ok("jsp:/jsp/flfg/news")
	public void flfgnewsIndex(HttpServletRequest request) {
		// 页面初始化
	}
	
	/**
	 * 
	 * addFlfg的中文名称：添加法律法规页面 
	 * 
	 * addFlfg的概要说明：
	 * 
	 * @param request
	 *            Written by : ly
	 */
	@At
	@Ok("jsp:/jsp/flfg/newsadd")
	public void addFlfg(HttpServletRequest request) {
		// 页面初始化
	} 


	/**
	 * 
	 * editflfg的中文名称：编辑法律法规页面
	 * 
	 * editflfg的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : ly
	 * 
	 */
	@At
	@Ok("jsp:/jsp/flfg/newsedit")
	public void editflfg(HttpServletRequest request, @Param("..") News dto,
			@Param("..") PagesDTO pd) throws Exception {
		Map map = newsService.queryNews(dto, pd);
		List newsList = (List) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);
	}

	/**
	 * 
	 * queryNews的中文名称：查询新闻
	 * 
	 * queryNews的概要说明：
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
	public Object queryNews(@Param("..") News dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = newsService.queryNews(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
//		return newsService.queryNews(dto, pd);
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
	@At
	@Ok("json")
	public Object saveNews(HttpServletRequest request, @Param("..") News dto) {
		return SysmanageUtil.execAjaxResult(newsService.saveNews(request, dto));
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
	@At
	@Ok("json")
	public Object delNews(HttpServletRequest request, @Param("..") News dto) {
		return SysmanageUtil.execAjaxResult(newsService.delNews(request, dto));
	}

	/**
	 * 
	 * queryNewsDetail的中文名称：新闻内容预览
	 * 
	 * queryNewsDetail的概要说明：
	 * 
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/news/newsdetail")
	public void queryNewsDetail(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = newsService.queryNews(dto, pd);
		List newsList = (List) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);

		News preNews = null;
		preNews = newsService.queryPreNews(dto);
		request.setAttribute("preNews", preNews);
		News nextNews = null;
		nextNews = newsService.queryNextNews(dto);
		request.setAttribute("nextNews", nextNews);
	}
	
	/**
	 * 
	 * queryWxNewsDetail的中文名称：微信新闻内容预览
	 * 
	 * queryWxNewsDetail的概要说明：
	 * 
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("jsp:/jsp/asfoodsafe/news_wx_detail.jsp")
	public void queryWxNewsDetail(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = newsService.queryNews(dto, pd);
		List newsList = (List) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);

		News preNews = null;
		preNews = newsService.queryPreNews(dto);
		request.setAttribute("preNews", preNews);
		News nextNews = null;
		nextNews = newsService.queryNextNews(dto);
		request.setAttribute("nextNews", nextNews);
	}	

	/**
	 * 
	 * queryNewsList的中文名称：新闻列表
	 * 
	 * queryNewsList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("re:jsp:/jsp/gzfw/announcement")
	public String queryNewsList(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		int pageSize = 20;// 默认每页20条记录
		int currPage = 1;// 当前第几页
		int totalCount = 0;// 总共记录数
		int totalPage = 1;// 总共页数
		if (request.getParameter("pageSize") != null
				&& !"".equals(request.getParameter("pageSize"))) {
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		if (request.getParameter("page") != null
				&& !"".equals(request.getParameter("page"))) {
			currPage = Integer.parseInt(request.getParameter("page"));
		}
		String retPageStr = StringHelper.showNull2Empty(request
				.getParameter("retPageStr"));//跳转页面
		String cateJc = StringHelper.showNull2Empty(request
				.getParameter("cateJc"));//新闻类别名简称

		dto.setCatejc(cateJc);
		pd.setPage(currPage);
		pd.setRows(pageSize);
		Map map = newsService.queryNews(dto, pd);
		List<News> ls = (List) map.get("rows");
		totalCount = PubFunc.parseInt(map.get("total"));
		totalPage = totalCount % pageSize == 0 ? totalCount / pageSize
				: totalCount / pageSize + 1;

		request.setAttribute("currPage", currPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("retPageStr", retPageStr);
		request.setAttribute("cateJc", cateJc);
		request.setAttribute("newslist", ls);

		return "jsp:/jsp/gzfw/" + retPageStr;
	}
	
	/**
	 * 
	 * queryNewsList的中文名称：新闻列表
	 * 
	 * queryNewsList的概要说明：
	 * 
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("re:jsp:/jsp/asfoodsafe/news_wx_list.jsp")
	public void queryWxNewsList(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		int pageSize = 5;// 默认每页20条记录
		int currPage = 1;// 当前第几页
		int totalCount = 0;// 总共记录数
		int totalPage = 1;// 总共页数
		if (request.getParameter("pageSize") != null
				&& !"".equals(request.getParameter("pageSize"))) {
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		if (request.getParameter("page") != null
				&& !"".equals(request.getParameter("page"))) {
			currPage = Integer.parseInt(request.getParameter("page"));
		}
//		String retPageStr = StringHelper.showNull2Empty(request
//				.getParameter("retPageStr"));//跳转页面
//		String cateJc = StringHelper.showNull2Empty(request
//				.getParameter("cateJc"));//新闻类别名简称
		String v_cate_id = StringHelper.showNull2Empty(request
		.getParameter("cateid"));//新闻类别名简称		

//		dto.setCatejc(cateJc);
		pd.setPage(currPage);
		pd.setRows(pageSize);
		dto.setCateid(v_cate_id);
		Map map = newsService.queryNews(dto, pd);
		List<News> ls = (List) map.get("rows");
		totalCount = PubFunc.parseInt(map.get("total"));
		totalPage = totalCount % pageSize == 0 ? totalCount / pageSize
				: totalCount / pageSize + 1;
		
		request.setAttribute("cate_id", v_cate_id);
		request.setAttribute("page", currPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalPage", totalPage);
		//request.setAttribute("cateJc", cateJc);
		request.setAttribute("newslist", ls);		

		//return "jsp:/jsp/gzfw/" + retPageStr;
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
	@Ok("jsp:/jsp/plupload/uploadFj")
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
	public Object uploadFj(HttpServletRequest request, @Param("..") Fj dto) {
		return SysmanageUtil.execAjaxResult(newsService.uploadFj(request, dto));
	}

	/**
	 *
	 * uploadnewsTp的中文名称：layui富文本编辑器上传图片
	 *
	 * uploadnewsTp的概要说明：
	 *
	 * @param request
	 * @param
	 * @return Written by : zk
	 *
	 */
	@At
	@Ok("json")
	public Object uploadnewsTp(HttpServletRequest request) throws Exception{
		return newsService.uploadnewsTp(request);
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
	@Ok("jsp:/jsp/plupload/delFj")
	public void delFjIndex(HttpServletRequest request, @Param("..") Fj dto)
			throws Exception {
		// 页面初始化
		List fjList = newsService.queryFjList(request, dto);
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
	public Object delFj(HttpServletRequest request, @Param("..") Fj dto) {
		return SysmanageUtil.execAjaxResult(newsService.delFj(request, dto));
	}

	/**
	 *
	 * queryNewsList的中文名称：新闻列表
	 *
	 * queryNewsList的概要说明：
	 *
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 *
	 */
	@At
	@Ok("re:jsp:/jsp/gzfw/announcement")
	public String queryBordList(HttpServletRequest request,
								@Param("..") Bord dto, @Param("..") PagesDTO pd) throws Exception {
		int pageSize = 10;// 默认每页10条记录
		int currPage = 1;// 当前第几页
		int totalCount = 0;// 总共记录数
		int totalPage = 1;// 总共页数
		if (request.getParameter("pageSize") != null
				&& !"".equals(request.getParameter("pageSize"))) {
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		if (request.getParameter("page") != null
				&& !"".equals(request.getParameter("page"))) {
			currPage = Integer.parseInt(request.getParameter("page"));
		}
		String retPageStr = StringHelper.showNull2Empty(request
				.getParameter("retPageStr"));//跳转页面
		String cateJc = StringHelper.showNull2Empty(request
				.getParameter("cateJc"));//新闻类别名简称

		dto.setCatejc(cateJc);
		pd.setPage(currPage);
		pd.setRows(pageSize);
		Map map = newsService.queryBordList(dto, pd);
		List<Bord> ls = (List) map.get("rows");
		totalCount = PubFunc.parseInt(map.get("total"));
		totalPage = totalCount % pageSize == 0 ? totalCount / pageSize
				: totalCount / pageSize + 1;

		request.setAttribute("currPage", currPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("retPageStr", retPageStr);
		request.setAttribute("cateJc", cateJc);
		request.setAttribute("newslist", ls);

		return "jsp:/jsp/gzfw/" + retPageStr;
	}

	/**
	 *
	 * queryNewsDetail的中文名称：新闻内容预览
	 *
	 * queryNewsDetail的概要说明：
	 *
	 * @param request
	 * @param dto
	 *            Written by : zjf
	 * @throws Exception
	 *
	 */
	@At
	@Ok("jsp:/jsp/news/virtualdetail")
	public void queryBordDetail(HttpServletRequest request,
								@Param("..") Bord dto, @Param("..") PagesDTO pd) throws Exception {

		Map map = newsService.queryBordDetail(dto, pd);
		List<Bord> ls = (List) map.get("rows");
		Bord bord = new Bord();
		bord.setCateid("检查结果依据暂同步");
		if(ls.size()!=0){
			bord = ls.get(0);
		}

		request.setAttribute("news", bord );
		request.setAttribute("preNews", bord);
		request.setAttribute("nextNews", bord);
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
	@At
	@Ok("json")
	public Object getNewsList(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = newsService.getNewsList(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getPreNews的中文名称：获取上一条新闻
	 *
	 * getPreNews的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getPreNews(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = newsService.getPreNews(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * getNextNews的中文名称：获取下一条新闻
	 *
	 * getNextNews的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object getNextNews(HttpServletRequest request,
			@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = newsService.getNextNews(request, dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}


}
