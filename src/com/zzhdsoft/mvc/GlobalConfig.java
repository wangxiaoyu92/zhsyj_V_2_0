package com.zzhdsoft.mvc;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import org.apache.log4j.Logger;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.lang.Lang;
import org.nutz.lang.Streams;
import org.nutz.lang.Strings;
import org.nutz.mvc.Mvcs;
import org.nutz.resource.NutResource;
import org.nutz.resource.Scans;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;

/**
 * 
 * GlobalConfig的中文名称：全局配置初始化类
 * 
 * GlobalConfig的描述：
 * 
 * Written by : zjf
 */
public class GlobalConfig {
	private static final Logger log = Logger.getLogger(GlobalConfig.class);
	private static PropertiesProxy pp;
	private static Map sqlconf;

	/**
	 * 
	 * getWebServiceUrl的中文名称：WebService数据服务地址
	 * 
	 * getWebServiceUrl的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getWebServiceUrl() {
		init();
		return pp.get("SidataServiceUrl");
	}

	/**
	 * 
	 * getAppPath的中文名称：获取应用映射路径
	 * 
	 * getAppPath的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getAppPath() {
		if (Strings.isEmpty(pp.get("apppath"))) {
			return null;
		} else {
			return pp.get("apppath");
		}
	}

	/**
	 * 
	 * getAppConfig的中文名称：获取config.properties的属性值
	 * 
	 * getAppConfig的概要说明：
	 * 
	 * @param key
	 * @return Written by : zjf
	 * 
	 */
	public static String getAppConfig(final String key) {
		init();
		return pp.get(key);
	}

	/**
	 * 
	 * init的中文名称：读取属性文件config.properties
	 * 
	 * init的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	public static void init() {
		if (null == pp) {
			pp = Mvcs.ctx.getDefaultIoc().get(PropertiesProxy.class, "config");
		}
	}

	/**
	 * 
	 * getSqlByID的中文名称：根据SQL配置ID,获得SQL语句
	 * 
	 * getSqlByID的概要说明：
	 * 
	 * @param id
	 * @return Written by : zjf
	 * 
	 */
	public static String getSqlByID(final String id) {
		initSqlConf();// 开发测试阶段每次调用getSqlByID都初始化sql，可以防止修改sql配置文件需要重启服务器才能生效。
		if (null == sqlconf)
			return "";
		Object obj = sqlconf.get(id);
		if (null == obj)
			return "";
		else
			return obj.toString();
	}

	/**
	 * 
	 * initSqlConf的中文名称：初始化SQL配置文件
	 * 
	 * initSqlConf的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	public static void initSqlConf() {
		log.info("-----Start Loading SQL Config XML File ......");
		String sqlpath = getAppConfig("sqlpath");
		sqlconf = new HashMap();
		// 扫描资源
		List<NutResource> list = new ArrayList<NutResource>();
		try {
			List<NutResource> resources = Scans.me().loadResource("^.+[.]xml$",
					sqlpath);
			list.addAll(resources);
			for (NutResource nr : list) {
				InputStream ins = nr.getInputStream();
				DocumentBuilder builder = Lang.xmls();
				Document document;
				document = builder.parse(ins);
				document.normalizeDocument();
				NodeList nodeListZ = ((Element) document.getDocumentElement())
						.getChildNodes();
				for (int i = 0; i < nodeListZ.getLength(); i++) {
					if (nodeListZ.item(i) instanceof Element) {
						if ("sql".equalsIgnoreCase(nodeListZ.item(i)
								.getNodeName())) {
							NamedNodeMap nnm = nodeListZ.item(i)
									.getAttributes();

							String n_id = nnm.getNamedItem("id").getNodeValue();
							String val = nodeListZ.item(i).getFirstChild()
									.getNodeValue();
							val = val.replaceAll("\n", " ");
							val = val.replaceAll("\r", " ");
							val = val.replaceAll("\t", " ");
							log.info(n_id + ":" + val);
							sqlconf.put(n_id, val);
						}
					}
					// paserBean((Element) nodeListZ.item(i), false);
				}
				Streams.safeClose(ins);
			}
			log.info("-----SQL Config XML File Load OK!");

		} catch (Exception e) {
			log.warn("Could not load SQL resource from " + sqlpath + ": "
					+ e.getMessage());
			throw Lang.wrapThrow(e);
		}

	}
}
