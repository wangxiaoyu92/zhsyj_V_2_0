package com.zzhdsoft.siweb.service.sysmanager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;

import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.Aa26;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;

/**
 * 
 * SysCommonFunService的中文名称：系统公用服务
 * 
 * SysCommonFunService的描述：
 * 
 * Written by : zjf
 */
@IocBean
public class SysCommonFunService extends BaseService {
	protected final Logger logger = Logger.getLogger(SysCommonFunService.class);
	@Inject
	protected Dao dao;

	/**
	 * 
	 * queryRegionZTree的中文名称：根据Ztree插件的树格式，组装行政区划树。
	 * 
	 * queryRegionZTree的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List queryRegionZTree(HttpServletRequest request) throws Exception {
		String aaa027flag = StringHelper.showNull2Empty(request
				.getParameter("aaa027flag"));
		String aaa027lev = StringHelper.showNull2Empty(request
				.getParameter("aaa027lev"));
		String aaa027 = StringHelper.showNull2Empty(SysmanageUtil.getSysuser()
				.getAaa027());
		if ("".equals(aaa027)) {
			throw new BusinessException("操作员所属统筹区编码不能为空！");
		}
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		aaa027 = SysmanageUtil.getSysuserAaa027(aaa027);

		String sb = "";
		sb += " select aab301,aaa146,aaa148,baz002,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 and baz002 = 1 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.aab301,t.aaa146,t.aaa148,t.baz002,";
		sb += " (select count(t1.aab301) from aa26 t1 where t1.aaa148 = t.aab301) childnum ";
		sb += " from aa26 t ";
		sb += " where 1=1 ";
		if (!Strings.isBlank(aaa027flag)) {// 过滤操作员统筹区
			sb += " and t.aab301 like '" + aaa027 + "%'";
		}
		if (!Strings.isBlank(aaa027lev)) {// 过滤行政区划级别
			sb += " and t.aae383 <= " + aaa027lev;
		}
		sb += " ) h";// mysql
		// sb +=
		// " start with t.aaa148 = 0 connect by prior t.aab301 = t.aaa148) h";
		sb += " order by baz002 desc";

		Map m = DbUtils.DataQuery("sql", sb, null, Aa26.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * queryRegionTree的中文名称：按easyui tree格式构造行政区划树
	 * 
	 * queryRegionTree的概要说明:
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public List queryRegionTree(HttpServletRequest request) {
		List resLs = new ArrayList();
		List ls = null;
		try {
			ls = queryRegionZTree(request);
		} catch (Exception e) {
			logger.error("获取行政区划树异常", e);
			e.printStackTrace();
			return null;
		}
		for (int i = 0; i < ls.size(); i++) {
			Aa26 s = (Aa26) ls.get(i);
			if ("0".equals(s.getAaa148())) {
				Map cm = new HashMap();
				cm.put("id", s.getAab301());
				cm.put("text", s.getAaa146());
				cm.put("children", getRegionChild(ls, s.getAab301()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 * 
	 * getRegionChild的中文名称：递归调用
	 * 
	 * getRegionChild的概要说明：
	 * 
	 * @param orglist
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getRegionChild(List orglist, final String parentid) {
		List rl = new ArrayList();
		Iterator it = orglist.iterator();
		while (it.hasNext()) {
			Aa26 s = (Aa26) it.next();
			if (s.getAaa148() != null && parentid.equals(s.getAaa148())) {
				Map cm = new HashMap();
				cm.put("id", s.getAab301());
				cm.put("text", s.getAaa146());
				if (s.getChildnum() > 0) {
					cm.put("children", getRegionChild(orglist, s.getAab301()));
				}
				rl.add(cm);

			}
		}
		return rl;
	}

	/**
	 * 
	 * queryRegionZTreeAsync的中文名称：根据Ztree插件的树格式，组装行政区划树。
	 * 
	 * queryRegionZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List queryRegionZTreeAsync(HttpServletRequest request)
			throws Exception {
		String aaa027flag = StringHelper.showNull2Empty(request
				.getParameter("aaa027flag"));
		String aaa027lev = StringHelper.showNull2Empty(request
				.getParameter("aaa027lev"));
		String aaa027 = StringHelper.showNull2Empty(SysmanageUtil.getSysuser()
				.getAaa027());
		if ("".equals(aaa027)) {
			throw new BusinessException("操作员所属统筹区编码不能为空！");
		}

		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		aaa027 = SysmanageUtil.getSysuserAaa027(aaa027);

		String aab301 = StringHelper.showNull2Empty(request
				.getParameter("aab301"));
		String aaa148 = "";
		if ("".equals(aab301)) {
			if (!Strings.isBlank(aaa027flag)) {// 过滤操作员统筹区
				aaa148 = PubFunc.strLen2(aaa027, 12);
			} else {
				aaa148 = "0";
			}
		}

		String sb = "";
		sb += " select aab301,aaa146,aaa148,baz002,aae383,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 and baz002 = 1 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.aab301,t.aaa146,t.aaa148,t.baz002,t.aae383,";
		sb += " (select count(t1.aab301) from aa26 t1 where t1.aaa148 = t.aab301) childnum ";
		sb += " from aa26 t ";
		sb += " where 1=1 ";

		if (!Strings.isBlank(aab301)) {
			sb += " and t.aaa148 = '" + aab301 + "'";
		} else {
			if (!Strings.isBlank(aaa027flag)) {// 过滤操作员统筹区
				sb += " and t.aab301 = '" + aaa148 + "'";
			} else {
				sb += " and t.aaa148 = '0'";
			}
		}

		if (!Strings.isBlank(aaa027lev)) {// 过滤行政区划级别
			sb += " and t.aae383 <= " + aaa027lev;
		}
		sb += " ) h ";// mysql

		// sb +=
		// " start with t.aaa148 = 0 connect by prior t.aab301 = t.aaa148) h";
		sb += " order by baz002 desc";

		System.out.println("selectarea "+sb.toString());
		
		Map m = DbUtils.DataQuery("sql", sb, null, Aa26.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
}
