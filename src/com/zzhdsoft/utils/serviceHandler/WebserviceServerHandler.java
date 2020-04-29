package com.zzhdsoft.utils.serviceHandler;

import org.apache.log4j.Logger;
import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.fault.XFireFault;
import org.codehaus.xfire.handler.AbstractHandler;
import org.jdom.Element;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.mvc.Mvcs;

/**
 * 服务端验证类
 * 
 * @author Administrator
 * 
 */
public class WebserviceServerHandler extends AbstractHandler {
	private static final Logger log = Logger.getLogger(WebserviceServerHandler.class);
	private String username = "";
	private String password = "";

	public WebserviceServerHandler() {
		PropertiesProxy proxy = Mvcs.ctx.getDefaultIoc().get(
				PropertiesProxy.class, "config");
		log.info(proxy.get("sis.username") + ":" + proxy.get("sis.password"));
		this.username = proxy.get("sis.username");
		this.password = proxy.get("sis.password");
	}


	public void invoke(MessageContext context) throws Exception {
		if (context.getInMessage().getHeader() == null) {
			throw new XFireFault("----------请求必须包含身份验证信息！----------", XFireFault.SENDER);
		}

		Element token = context.getInMessage().getHeader().getChild(WebserviceConstant.TOKEN);
		if (token == null) {
			throw new XFireFault("----------请求必须包含身份验证信息！----------", XFireFault.SENDER);
		}

		String token_username = token.getChild(WebserviceConstant.USERNAME).getValue();
		String token_password = token.getChild(WebserviceConstant.PASSWORD).getValue();
		try {
			if (username.equals(token_username) && password.equals(token_password)) {
				System.out.println("----------身份验证通过！----------");
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			throw new XFireFault("----------非法的用户名或密码！----------", XFireFault.SENDER);
		}
	}

}
