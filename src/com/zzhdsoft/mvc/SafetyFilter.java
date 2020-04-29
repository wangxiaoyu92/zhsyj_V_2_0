package com.zzhdsoft.mvc;

import java.sql.Timestamp;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.view.ServerRedirectView;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *  SafetyFilter的中文名称：安全过滤器
 *
 *  SafetyFilter的描述：
 *
 *  Written  by  : zjf
 */
public class SafetyFilter implements ActionFilter {
	protected final Logger logger = Logger.getLogger(SafetyFilter.class);
	private static final String IGNORE = "^.+\\.(jsp|png|gif|jpg|js|css|jspx|jpeg|swf|ico|xls|doc)$";// 无需拦截的请求文件格式
	private String CONFIG_IGNORE = "";

	public SafetyFilter() {
		CONFIG_IGNORE = GlobalConfig.getAppConfig("ignoreUrlPattens");// 全局配置的无需拦截的请求路径
		CONFIG_IGNORE = Pattern.compile(",+").matcher(CONFIG_IGNORE)
				.replaceAll("|");
	}

	/**
	 * 拦截思路： 1、转发通用请求。 2、拦截所有的应用请求，判断是否存在合适的权限 3、其他请求返回登录界面
	 */
	public View match(ActionContext actionContext) {
		String ctxPath = actionContext.getServletContext().getContextPath();
		String servletPath = actionContext.getPath();
		/* 忽略无需判断权限的请求 */
		if (servletPath.matches(IGNORE) // 无需拦截的请求文件格式
				|| Pattern.compile(CONFIG_IGNORE).matcher(servletPath).find()// 无需拦截的请求路径
		) {
			return null;
		}

		HttpSession session = Mvcs.getHttpSession();
		if (session == null) {
			//超时退出，记录用户退出日志。
			
			logger.error("Session超时!");
			return new ServerRedirectView(GlobalNames.MAIN_PAGE
					+ "?v=Session超时");
		}
		// 检查用户SESSION
		Object o = session.getAttribute("CURRENT_USER");
		if (o == null) {
			if (session != null) {
				session.invalidate();
			}
			return new ServerRedirectView(GlobalNames.MAIN_PAGE
					+ "?v=Session失效&sessionid=" + session.getId());
		}

		// 检查用户是否存在对应的功能权限,如果没有，转向空白页面
		Sysuser su = (Sysuser) o;
		
		//记录用户操作日志
		Timestamp startTime = SysmanageUtil.currentTime();
		Timestamp endTime = SysmanageUtil.currentTime();
		try {
			SysmanageUtil.writeSysoperatelog(actionContext.getRequest(), startTime, endTime);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e);
			e.printStackTrace();
		}

		
//		SysfunctionService ls = Mvcs.ctx().getDefaultIoc().get(
//				SysfunctionService.class);
//		if (!(ls.isExistsFuncByUrl(su.getUserid().toString(), su.getUserkind(),
//				servletPath) > 0)) {
//			logger.error("请求未授权的功能！" + servletPath);
//			return new ForwardView(GlobalNames.BLANK_PAGE);
//		}
		return null;
	}

}
