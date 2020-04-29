package com.zzhdsoft.mvc.news;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.news.NewsDTO;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.service.news.NewsService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * NewsApiModule的中文名称：新闻管理手机端接口
 * 
 * NewsApiModule的描述：
 * 
 * Written by : zy
 */
@At("/api/news")
@IocBean
public class NewsApiModule {
	protected final Logger logger = Logger.getLogger(NewsApiModule.class);

	@Inject
	protected NewsService newsService;
	
	/**
	 * 
	 * queryLaws的中文名称：查询法律法规
	 * 
	 * queryLaws的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("json")
	public Object queryLaws(@Param("..") NewsDTO dto, @Param("..") PagesDTO pd){
		Map map = new HashMap();
		try {
			map = newsService.queryLaws(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
	/**
	 * 
	 * showLawInfo的中文名称：展示新闻内容
	 * 
	 * showLawInfo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings("rawtypes")
	@At
	@Ok("jsp:/jsp/news/showLawInfo")
	public void showLawInfo(HttpServletRequest request, @Param("..") NewsDTO dto, 
			@Param("..") PagesDTO pd) throws Exception{
		Map map = newsService.queryLaws(dto, pd);
		List newsList = (List) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);
	}

}
