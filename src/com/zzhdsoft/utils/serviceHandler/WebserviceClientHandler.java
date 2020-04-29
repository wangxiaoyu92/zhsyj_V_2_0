package com.zzhdsoft.utils.serviceHandler;

import org.apache.log4j.Logger;
import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.handler.AbstractHandler;
import org.jdom.Element;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.mvc.Mvcs;

/**
 * 客户端授权信息类
 * 
 * @author Administrator
 * 
 */
public class WebserviceClientHandler extends AbstractHandler {

	private static final Logger log = Logger
			.getLogger(WebserviceClientHandler.class);
	private String username = "";
	private String password = "";

	public WebserviceClientHandler() {
		PropertiesProxy proxy = Mvcs.ctx.getDefaultIoc().get(
				PropertiesProxy.class, "config");
		log.info(proxy.get("sis.username") + ":" + proxy.get("sis.password"));
		this.username = proxy.get("sis.username");
		this.password = proxy.get("sis.password");
	}

	public WebserviceClientHandler(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public void invoke(MessageContext context) throws Exception {
		Element el = new Element(WebserviceConstant.HEADER);
		context.getOutMessage().setHeader(el);
		Element auth = new Element(WebserviceConstant.TOKEN);
		Element username_el = new Element(WebserviceConstant.USERNAME);
		username_el.addContent(username);
		Element password_el = new Element(WebserviceConstant.PASSWORD);
		password_el.addContent(password);
		auth.addContent(username_el);
		auth.addContent(password_el);
		el.addContent(auth);
	}

}
