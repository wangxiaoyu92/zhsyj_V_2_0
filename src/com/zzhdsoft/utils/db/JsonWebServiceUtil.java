package com.zzhdsoft.utils.db;

import java.lang.reflect.Proxy;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.nutz.json.Json;
import org.nutz.mapl.Mapl;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.IPublished;
import com.zzhdsoft.mvc.GlobalConfig;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.service.IPubService;
import com.zzhdsoft.utils.serviceHandler.WebserviceClientHandler;

/**
 * 
 *  JsonWebServiceUtil的中文名称：WebService数据查询工具类
 *
 *  JsonWebServiceUtil的描述：
 *
 *  Written  by  : zjf
 */
public class JsonWebServiceUtil implements IPublished {

	protected static final Logger logger = Logger
			.getLogger(JsonWebServiceUtil.class);

	/**
	 * 
	 * SiDataQuery的中文名称：核心业务数据库查询接口
	 * 
	 * SiDataQuery的概要说明:
	 * 
	 * @param t
	 *            查询类型：SQL/PROC
	 * @param sql
	 *            查询语句&存储过程名称
	 * @param param
	 *            存储过程的入参map(查询语句此参数为空)
	 * @param clazz
	 *            返回数据集的类型(如果返回结果不是list，此参数为空即可。)
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	public static Map SiDataQuery(final String t, final String sql,
			final Map param, Class clazz) throws Exception {
		try {
			String sp;
			if (null == param) {
				sp = "{}";
			} else {
				sp = Json.toJson(param);
			}

			// 创建WebService客户端
			String serviceUrl = GlobalConfig.getWebServiceUrl();
			Service serviceModel = new ObjectServiceFactory()
					.create(IPubService.class);
			XFireProxyFactory factory = new XFireProxyFactory();
			IPubService ips = (IPubService) factory.create(serviceModel,
					serviceUrl);
			Client client = ((XFireProxy) Proxy.getInvocationHandler(ips))
					.getClient();

			/**
			 * WebService安全认证---> WebService有两种安全机制：
			 * 1.利用WS-Security将签名和加密头加入SOAP消息 2.利用数字证书和数字签名认证
			 */
//			WSS4JOutHandler wsOut = new WSS4JOutHandler();
//			wsOut.setProperty(WSHandlerConstants.ACTION,
//					WSHandlerConstants.USERNAME_TOKEN);// 认证方式
//			wsOut.setProperty(WSHandlerConstants.USER, GlobalConfig
//					.getAppConfig("sis.username"));// 指定用户
//			wsOut.setProperty(WSHandlerConstants.PASSWORD_TYPE,
//					WSConstants.PW_DIGEST);// 密码以加密方式发送
//			wsOut.setProperty(WSHandlerConstants.PW_CALLBACK_CLASS,
//					ClientPasswordHandler.class.getName());// 密码回调类
//			// 添加WSS4JOutHandler，提供认证
//			client.addOutHandler(new DOMOutHandler());
//			client.addOutHandler(wsOut);
			
			//添加安全认证
			client.addOutHandler(new WebserviceClientHandler());

			// 调用WebService的服务
			String res = ips.execSQL(t, sql, sp);

			// 组装返回对象
			ResultDTO dto = Json.fromJson(ResultDTO.class, res);
			List trueObjList = new Vector();
			List list = dto.getResult();

			LinkedHashMap map = (LinkedHashMap) list.get(0);
			if (null != map.get(GlobalNames.SI_RESULTSET) && clazz != null) {
				List al = (List) map.get(GlobalNames.SI_RESULTSET);
				int size = al.size();
				for (int i = 0; i < size; i++) {
					trueObjList.add(Mapl.maplistToObj(al.get(i), clazz));
				}
				map.put(GlobalNames.SI_RESULTSET, trueObjList);
			}
			map.put(GlobalNames.SI_MSG, dto.getMsg());
			map.put(GlobalNames.SI_CODE, dto.getCode());
			map.put(GlobalNames.SI_TOTALROWNUM, dto.getRecnum());

			return map;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new BusinessException("核心数据服务异常!" + e.getMessage());
		}
	}

	/**
	 * 
	 * SiDataQuery的中文名称：核心业务数据库查询接口
	 * 
	 * SiDataQuery的概要说明:
	 * 
	 * @param t
	 *            查询类型：SQL/PROC
	 * @param sql
	 *            查询语句&存储过程名称
	 * @param param
	 *            存储过程的入参map(查询语句此参数为空)
	 * @param clazz
	 *            返回数据集的类型(如果返回结果不是list，此参数为空即可。)
	 * @param pageNum
	 *            分页：页码
	 * @param pageSize
	 *            分页：页记录数
	 * @return 返回Map类型出参
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	public static Map SiDataQuery(final String t, final String sql,
			final Map param, Class clazz, int pageNum, int pageSize)
			throws Exception {
		Map res = null;
		if (pageNum > 0 && pageSize > 0) {// 有分页需求
			// 构造分页语句
			String ls_sql = DbUtils.packageSql(pageNum, pageSize, sql);

			res = SiDataQuery(t, ls_sql, param, clazz);

			// 再计算总记录数
			String sqlrn = "SELECT count(*) as rn FROM(" + sql + ") h";
			Map p = SiDataQuery(t, sqlrn, null, null);
			List ls = (List) p.get(GlobalNames.SI_RESULTSET);
			Map p2 = (Map) ls.get(0);

			res.put(GlobalNames.SI_TOTALROWNUM, p2.get("rn"));

		} else {
			res = SiDataQuery(t, sql, param, clazz);
		}
		return res;
	}

	/**
	 * 
	 *  main的中文名称：webService测试
	 *
	 *  main的概要说明：
	 *
	 *  @param args
	 *  @throws Exception
	 *  Written  by  : zjf
	 *
	 */
	public static void main(String[] args) throws Exception {
		// 1、测试普通查询语句
		Map s = JsonWebServiceUtil.SiDataQuery("sql", "SELECT * FROM AA13",
				null, Aa13.class);
		System.out.print(s.get("recnum"));
		// 2、测试有返回数据集的存储过程
		// JsonWebServiceUtil.SiDataQuery("PROC","PROC_TEST2",null,Aa10.class);
		// 3、测试普通有入参出参的存储过程
		// Map m = new HashMap();
		// m.put("abc", "123");
		// JsonWebServiceUtil.SiDataQuery("PROC", "PROC_TEST", m, null);
		//		
		// String s = Pattern.compile(",+").matcher(
		// "(/soap/*,/test/*,/reports/*,/hdreport/*)").replaceAll("|");
		// System.out.println(s + "\r\n"
		// + Pattern.compile(s).matcher("aaa/test/aaa").find());
		//		
		// System.out.println(String.valueOf((int) Math
		// .floor(Math.random() * 1000000)));
		// System.out.println(Lang.md5("admin"));
		// System.out.println(Lang.md5("a"));

	}
}
