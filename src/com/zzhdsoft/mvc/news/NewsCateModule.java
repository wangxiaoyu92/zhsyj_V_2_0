package com.zzhdsoft.mvc.news;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.news.Newscate;
import com.zzhdsoft.siweb.service.news.NewsCateService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * NewsCateModule的中文名称：新闻分类管理
 * 
 * NewsCateModule的描述：
 * 
 * Written by : zjf
 */
@At("/newscate")
@IocBean
public class NewsCateModule {
	protected final Logger logger = Logger.getLogger(NewsCateModule.class);

	@Inject
	protected NewsCateService newsCateService;

	/**
	 * 
	 *  newscateIndex的中文名称：新闻分类管理页面初始化
	 *
	 *  newscateIndex的概要说明：
	 *
	 *  @param request
	 *  Written  by  : zjf
	 *
	 */
	@At
	@Ok("jsp:/jsp/news/newscate")
	public void newscateIndex(HttpServletRequest request) {
		// 页面初始化
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
	@At
	@Ok("json")
	public Object queryNewsCate(@Param("..") Newscate dto,
			@Param("..") PagesDTO pd) {
		return newsCateService.queryNewsCate(dto, pd);
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
	@At
	@Ok("json")
	public Object queryNewcateZTree(HttpServletRequest request) throws Exception {
		try {
			List newscateList = (List) newsCateService.queryNewcateZTree(request);
			String mydata = Json.toJson(newscateList, JsonFormat.compact());
			mydata = mydata.replace("isparent", "isParent");
			mydata = mydata.replace("isopen", "open");
			Map m = new HashMap();
			m.put("mydata", mydata);
			return SysmanageUtil.execAjaxResult(m, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		} 
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
	@At
	@Ok("json")
	public Object queryNewscateTree(HttpServletRequest request) throws Exception {
		try {
			return newsCateService.queryNewscateTree(request);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(null, e);
		}
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
	@At
	@Ok("json")
	public Object saveNewsCate(@Param("..") Newscate dto) {
		return SysmanageUtil.execAjaxResult(newsCateService.saveNewsCate(dto));
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
	@At
	@Ok("json")
	public Object delNewsCate(@Param("..") Newscate dto) {
		return SysmanageUtil.execAjaxResult(newsCateService.delNewsCate(dto));
	}

}
