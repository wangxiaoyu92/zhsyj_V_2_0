package com.zzhdsoft.mvc;

import java.lang.reflect.Proxy;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.zzhdsoft.siweb.dto.ParamDTO;
import org.apache.log4j.Logger;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import com.zzhdsoft.siweb.service.DataServiceImpl;
import com.zzhdsoft.siweb.service.IPubService;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * DataModule的中文名称：数据查询Module
 * 
 * DataModule的描述：
 * 
 * Written by : zjf
 */
@At("/common/dataModule")
@IocBean
public class DataModule {
	private static final Logger log = Logger.getLogger(DataModule.class);

	@Inject
	private DataServiceImpl dataServiceImpl;

	/**
	 * 
	 * query的中文名称：数据通用查询
	 * 
	 * query的概要说明：
	 * 
	 * @param request
	 * @param response
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object query(HttpServletRequest request,
			HttpServletResponse response, @Param("..") ParamDTO dto) {
		log.debug(dto.getT() + "/" + dto.getSql());
		return dataServiceImpl.query(dto);
	}

	/**
	 * 
	 * wlService的中文名称：webService接口测试
	 * 
	 * wlService的概要说明：
	 * 
	 * @param request
	 * @param response
	 * @param dto
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object wlService(HttpServletRequest request,
			HttpServletResponse response, @Param("..") ParamDTO dto) throws Exception {
		String timestamp = SysmanageUtil.currentTime().toString();
		String signature = "abc|123456|" + timestamp;
		signature = MD5Util.MD5Encode(signature).toUpperCase();
		String ywdm = dto.getSql();
		String inParams = dto.getParam();
		if ("001".equals(ywdm)) {
			// 无入参
		}
		if ("002".equals(ywdm)) {
			//
		}

		// 创建WebService客户端
		String serviceUrl = GlobalConfig.getWebServiceUrl();
		Service serviceModel = new ObjectServiceFactory()
				.create(IPubService.class);
		XFireProxyFactory factory = new XFireProxyFactory();
		IPubService ips = (IPubService) factory
				.create(serviceModel, serviceUrl);
		Client client = ((XFireProxy) Proxy.getInvocationHandler(ips))
				.getClient();
		// 添加安全认证
		// client.addOutHandler(new WebserviceClientHandler());
		// 调用WebService的服务
		String res = ips.wlService(signature, timestamp, ywdm, inParams);
		// 组装返回对象
		Map resultMap = (Map) Json.fromJson(res);
		return resultMap;
	}

}