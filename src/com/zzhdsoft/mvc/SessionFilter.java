package com.zzhdsoft.mvc;

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

/**
 * 
 *  SessionFilter的中文名称：会话过滤器
 *
 *  SessionFilter的描述：
 *
 *  Written  by  : zjf
 */
public class SessionFilter implements ActionFilter {
	protected final Logger logger = Logger.getLogger(SessionFilter.class);
	private static final String IGNORE = "^.+\\.(jsp|png|gif|jpg|js|css|jspx|jpeg|swf|ico|xls|doc)$";// 无需拦截的请求文件格式
	private String CONFIG_IGNORE = "";

	public SessionFilter() {
		CONFIG_IGNORE = GlobalConfig.getAppConfig("ignoreUrlPattens");// 全局配置的无需拦截的请求路径
		CONFIG_IGNORE = Pattern.compile(",+").matcher(CONFIG_IGNORE)
				.replaceAll("|");
	}

	/**
	 * 拦截思路： 1、转发通用请求。 2、拦截所有的应用请求，判断是否存在合适的权限 3、其他请求返回登录界面
	 */
	public View match(ActionContext actionContext) {		
		HttpSession session = Mvcs.getHttpSession();
		if (session == null) {
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
		return null;
	}

}
