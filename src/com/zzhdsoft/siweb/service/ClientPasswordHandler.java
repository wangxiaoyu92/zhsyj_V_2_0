package com.zzhdsoft.siweb.service;

import java.io.IOException;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.UnsupportedCallbackException;
import org.apache.log4j.Logger;
import org.apache.ws.security.WSPasswordCallback;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.lang.Streams;
import org.nutz.mvc.Mvcs;

/**
 * 
 *  ClientPasswordHandler的中文名称：客户端访问权限验证类
 *
 *  ClientPasswordHandler的描述：
 *
 *  Written  by  : zjf
 */
public class ClientPasswordHandler implements CallbackHandler {
	private static final Logger log = Logger
			.getLogger(ClientPasswordHandler.class);
	private String username = "";
	private String password = "";

	public ClientPasswordHandler() {
		PropertiesProxy proxy = Mvcs.ctx.getDefaultIoc().get(
				PropertiesProxy.class, "config");
		log.info(proxy.get("sis.username") + ":" + proxy.get("sis.password"));
		this.username = proxy.get("sis.username");
		this.password = proxy.get("sis.password");		
	}

	public void handle(Callback[] callbacks) throws IOException,
			UnsupportedCallbackException {
		log.info("客户端发送包含有加密认证信息的SOAP消息给服务端......");
		WSPasswordCallback pc = (WSPasswordCallback) callbacks[0];
		String id = pc.getIdentifer();
		if (username.equals(id)) {
			pc.setPassword(password);
		}
		else{
			log.info("验证用户失败，原因：您没有访问权限,用户名错误！");
			throw new UnsupportedCallbackException(pc, "您没有访问权限,用户名错误！");
		}
	}

}
