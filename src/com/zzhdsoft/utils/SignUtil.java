package com.zzhdsoft.utils;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.apache.log4j.Logger;
import org.codehaus.xfire.client.Client;
import org.nutz.json.Json;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.utils.db.PubFunc;

/**
 * 
 * SignUtil的中文名称: 司机宝请求校验工具类
 * 
 * SignUtil的描述:
 * 
 * Written by : zjf
 */
public class SignUtil {
	protected final Logger logger = Logger.getLogger(SignUtil.class);

	// 司机宝服务平台,调度员帐号、密码【测试版】
	// public static final String app = "100004";
	// public static final String appCode = "200091";
	// public static final String appSecret =
	// "7775ea31406640cba7ad64b3ab0c3b57";
	// public static final String appUrl =
	// "http://120.24.157.236:8101/ropservice/router";
	// public static final String ddyAccount = "13838052297";
	// public static final String ddyAccount = "123456";
	// public static final String serverUrl = "http://hhwl2.nat123.net/hhwl";

	// 司机宝服务平台,调度员帐号、密码【正式版】
	public static final String app = "100002";
	public static final String appCode = "200058";
	public static final String appSecret = "f5d358945d1b44ff9641fde9ab016b8c";
	public static final String appUrl = "http://ropservice-service.ipnavi.cn/ropservice/router";
	public static final String ddyAccount = "15239601929";
	public static final String ddyPassword = "123456";
	public static final String serverUrl = "http://61.158.232.27/hhwl/";
	// 条码系统服务器地址
	public static final String tmserverUrl = "http://218.28.99.242:9100/JHQwebService.asmx?wsdl";

	/**
	 * 
	 * getApiUrl的中文名称：获取包含签名的ApiUrl
	 * 
	 * getApiUrl的概要说明：
	 * 
	 * @param signMap
	 * @param paramsMap
	 * @return Written by : zjf
	 * 
	 */
	public static String getApiUrl(Map signMap, Map paramsMap) {
		String apiUrl = "";
		List<String> paramNames = new ArrayList(signMap.size());
		Iterator<Entry<String, String>> iterator = signMap.entrySet()
				.iterator();
		Entry<String, String> entry = null;
		while (iterator.hasNext()) {
			entry = iterator.next();
			if (entry.getValue() != null) {
				paramNames.add(entry.getKey());
			}
		}
		// 将参数名进行字典序排序
		Collections.sort(paramNames);
		// 1.拼装签名串
		StringBuffer sb = new StringBuffer();
		sb.append(appSecret);
		for (String paramName : paramNames) {
			sb.append(paramName).append(signMap.get(paramName));
		}
		sb.append(appSecret);

		MessageDigest md = null;
		String signStr = null;
		try {
			md = MessageDigest.getInstance("SHA1"); // 不可逆的加密算法 (安全哈希算法)
			// 2.将签名串进行SHA-1签名运算
			byte[] digest = md.digest(sb.toString().getBytes("UTF-8"));
			// 将签名转换为十六进制的编码串
			signStr = byteToStr(digest);

			// 3.拼装请求URL
			StringBuffer sbf = new StringBuffer();
			sbf.append(appUrl).append("?appcode=").append(appCode);
			// 拼接URL参数
			iterator = paramsMap.entrySet().iterator();
			while (iterator.hasNext()) {
				entry = iterator.next();
				if (entry.getValue() != null) {
					sbf.append("&").append(entry.getKey()).append("=").append(
							URLEncoder.encode(String.valueOf(entry.getValue()),
									"utf-8"));
				}
			}
			sbf.append("&sign=").append(signStr);
			apiUrl = sbf.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return apiUrl;
	}

	/**
	 * 将字节数组转换为十六进制字符串
	 * 
	 * @param byteArray
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}

	/**
	 * 将字节转换为十六进制字符串
	 * 
	 * @param mByte
	 * @return
	 */
	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A',
				'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];
		String s = new String(tempArr);
		return s;
	}

	/**
	 * 
	 * sjbLogon的中文名称：司机宝用户单点登录
	 * 
	 * sjbLogon的概要说明：获取会话id
	 * 
	 * @param account
	 * @param password
	 * @return Written by : zjf
	 * 
	 */
	public static String sjbLogon(String account, String password)
			throws Exception {
		String method = "user.logon";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("force", "1");
		map.put("devicetype", "3");
		map.put("account", account);

		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("appcode", SignUtil.appCode);
		map2.put("method", method);
		map2.put("v", "1.0");
		map2.put("format", "json");
		map2.put("force", "1");
		map2.put("devicetype", "3");
		map2.put("account", account);
		map2.put("password", password);

		String apiUrl = SignUtil.getApiUrl(map, map2);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("司机宝用户登录失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		String session = StringHelper.showNull2Empty(resultMap.get("session"));
		return session;
	}

	/**
	 * 
	 * sjbLogout的中文名称：司机宝用户单点登出
	 * 
	 * sjbLogout的概要说明：释放会话id
	 * 
	 * @param sessionId
	 * @return Written by : zjf
	 * 
	 */
	public static String sjbLogout(String sessionId) throws Exception {
		String method = "user.logout";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", sessionId);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("司机宝用户退出失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		String state = StringHelper.showNull2Empty(resultMap.get("state"));
		return state;
	}

	/**
	 * 
	 * getSjbUserInfo的中文名称：获取司机宝登录用户信息
	 * 
	 * getSjbUserInfo的概要说明：
	 * 
	 * @param sessionId
	 * @return Written by : zjf
	 * 
	 */
	public static Map getSjbUserInfo(String ddySessionId, String sjSessionId)
			throws Exception {
		String method = "user_open.query_xcsession";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("xcssession", sjSessionId);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取司机宝登录用户信息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		return resultMap;
	}

	/**
	 * 
	 * getSjbUserList的中文名称：获取群组成员列表
	 * 
	 * getSjbUserList的概要说明：
	 * 
	 * @param sessionId
	 * @param groupCode
	 * @return Written by : zjf
	 * 
	 */
	public static List getSjbUserList(String ddySessionId) throws Exception {
		String method = "group_open.group_member.query";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("member_type", "1");

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取群组成员列表失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		List ls = (List) resultMap.get("list");
		return ls;
	}

	/**
	 * 
	 * getSjbSjInfo的中文名称：获取司机宝登录用户注册的【司机】信息
	 * 
	 * getSjbSjInfo的概要说明：
	 * 
	 * @param sessionId
	 * @return Written by : zjf
	 * 
	 */
	public static Map getSjbSjInfo(String ddySessionId, String open_id)
			throws Exception {
		String method = "driver_open.query";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("open_id", open_id);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取司机信息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		return resultMap;
	}

	/**
	 * 
	 * getSjbClInfo的中文名称：获取司机宝登录用户注册的【车辆】信息
	 * 
	 * getSjbClInfo的概要说明：
	 * 
	 * @param sessionId
	 * @return Written by : zjf
	 * 
	 */
	public static Map getSjbClInfo(String ddySessionId, String open_id)
			throws Exception {
		String method = "vehicle_open.query";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("open_id", open_id);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取司机车辆信息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		return resultMap;
	}

	/**
	 * 
	 * makeCardMsg的中文名称：创建卡片消息
	 * 
	 * makeCardMsg的概要说明：
	 * 
	 * @param sessionId
	 * @param title
	 * @param content
	 * @param linkurl
	 * @return Written by : zjf
	 * 
	 */
	public static String makeCardMsg(String ddySessionId, String title,
			String content, String linkurl) throws Exception {
		String method = "message_open.cardmsg.simplecreate";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("title", title);
		map.put("content", content);
		map.put("linkurl", linkurl);
		map.put("category", "1");
		map.put("tel", "13838052297");

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("创建卡片消息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		String cardmsgcode = StringHelper.showNull2Empty(resultMap
				.get("cardmsgcode"));
		return cardmsgcode;
	}

	/**
	 * 
	 * pushCardMsg的中文名称：发送卡片消息给指定的司机用户
	 * 
	 * pushCardMsg的概要说明：
	 * 
	 * @param sessionId
	 * @param toUserCode
	 * @param cardMsgCode
	 * @param toAppcode
	 *            司机宝服务平台注册的应用编码
	 * @return Written by : zjf
	 * 
	 */
	public static String pushCardMsg(String ddySessionId, String open_ids,
			String cardMsgCode, String toAppcode) throws Exception {
		String method = "message_open.cardmsg.sent_syn";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("open_ids", open_ids);
		map.put("cardmsgcode", cardMsgCode);
		map.put("toappcode", toAppcode);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("发送卡片消息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		String state = StringHelper.showNull2Empty(resultMap.get("state"));
		return state;
	}

	/**
	 * 
	 * sendCardMsgToSj的中文名称：调度员发送调度通知给司机
	 * 
	 * sendCardMsgToSj的概要说明：
	 * 
	 * @param open_ids
	 * @param title
	 * @param content
	 * @param linkurl
	 * @return Written by : zjf
	 * 
	 */
	public static String sendCardMsgToSj(String open_ids, String title,
			String content, String linkurl) throws Exception {
		// 调度员登录
		String sessionId = sjbLogon(ddyAccount, ddyPassword);
		String cardmsgcode = makeCardMsg(sessionId, title, content, linkurl);
		String state = pushCardMsg(sessionId, open_ids, cardmsgcode, app);
		return state;
	}

	/**
	 * 
	 * getSjbUserLocation的中文名称：获取司机宝用户的位置信息
	 * 
	 * getSjbUserLocation的概要说明：获取经纬度、详细地址
	 * 
	 * @param sessionId
	 * @param holderCode
	 * @return Written by : zjf
	 * 
	 */
	public static Map getSjbUserLocation(String ddySessionId, String open_id)
			throws Exception {
		String method = "user_open.query.location";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("open_id", open_id);

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取司机位置信息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		return resultMap;
	}

	/**
	 * 
	 * getSjbUserLocationInfo的中文名称：获取司机宝用户的位置信息
	 * 
	 * getSjbUserLocationInfo的概要说明：根据经纬度解析获取详细地址
	 * 
	 * @param sessionId
	 * @param holderCode
	 * @return Written by : zjf
	 * 
	 */
	public static Map getSjbUserLocationInfo(String longitude, String latitude)
			throws Exception {
		String method = "cloadlbs.parserlocation";

		Map<String, String> map = new HashMap<String, String>();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("longitude", longitude);
		map.put("latitude", latitude);
		map.put("geotype", "2");

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("司机宝接口" + method + "调用异常，异常信息："
					+ message);
		}

		return resultMap;
	}

	/**
	 * 
	 * getSjlsgj的中文名称：获取司机历史轨迹
	 * 
	 * getSjlsgj的概要说明：司机宝APP用户历史轨迹查询接口
	 * 
	 * @param sessionId
	 * @param toUserCode
	 * @param cardMsgCode
	 * @param toAppcode
	 * @return Written by : zjf
	 * 
	 */
	public static List getSjlsgj(String ddySessionId, String open_id,
			Long begindate, Long enddate) throws Exception {
		String method = "user_open.query.location_his";

		Map map = new HashMap();
		map.put("appcode", SignUtil.appCode);
		map.put("method", method);
		map.put("v", "1.0");
		map.put("format", "json");
		map.put("session", ddySessionId);
		map.put("open_id", open_id);
		map.put("begindate", begindate);
		map.put("enddate", enddate);
		map.put("limit", "10");

		String apiUrl = SignUtil.getApiUrl(map, map);
		String resultJson = HttpUtil.httpGet(apiUrl, "utf-8");

		Map resultMap = (Map) Json.fromJson(resultJson);
		// 处理接口调用异常信息
		String code = StringHelper.showNull2Empty(resultMap.get("code"));
		if (!"".equals(code)) {
			String message = StringHelper.showNull2Empty(resultMap
					.get("message"));
			throw new BusinessException("获取司机历史位置信息失败！司机宝接口【" + method
					+ "】调用异常，异常信息：" + message);
		}

		List ls = (List) resultMap.get("list");
		return ls;
	}

	/**
	 * 
	 * setSjzt的中文名称：设置司机状态
	 * 
	 * setSjzt的概要说明：调用条码系统接口
	 * 
	 * @param ydbh
	 * @param qdid
	 * @param sjzt
	 * @return Written by : zjf
	 * 
	 */
	public static String setSjzt(String ydbh, String qdid, String sjzt) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", "-1");
		try {
			// xfire方式调用
			// Client client = new Client(new URL(tmserverUrl));
			// Object[] results = client.invoke("QRDdzt", new String[] { ydbh,
			// qdid, sjzt });
			// Document d = (Document) results[0];
			// NodeList nl = d.getElementsByTagName("QRDdztResponse");
			// NodeList n2 = nl.item(0).getChildNodes();
			// for (int i = 0; i < n2.getLength(); i++) {
			// System.out.println("条码系统接口返回结果：" + n2.item(i).getNodeName()
			// + "::" + n2.item(i).getTextContent());
			// map = (Map) Json.fromJson(n2.item(i).getTextContent());
			// }

			// axis方式调用
			Service service = new Service();
			Call call = null;
			call = (Call) service.createCall();// 定义service对象
			call.setTargetEndpointAddress(new URL(SignUtil.tmserverUrl));
			call.setOperationName(new QName("http://tempuri.org/", "QRDdzt"));// 接口方法：QRDdzt
			call.addParameter(new QName("http://tempuri.org/", "yhbh"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.addParameter(new QName("http://tempuri.org/", "qdid"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.addParameter(new QName("http://tempuri.org/", "sjzt"),
					XMLType.SOAP_STRING, ParameterMode.IN);// 接口入参
			call.setReturnType(XMLType.SOAP_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI("http://tempuri.org/QRDdzt");

			String retStr = PubFunc.toString(call.invoke(new Object[] { ydbh,
					qdid, sjzt }));
			System.out.println("条码系统接口返回结果：" + retStr);
			map = (Map) Json.fromJson(retStr);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map.get("code");
	}

	public static void main(String[] args) {
		try {
			// 司机宝用户登录
			String sjAccount = "13838052297";// 100000033573
			String sjPassword = "123456";
			String sjSessionId = sjbLogon(sjAccount, sjPassword);
			String ddySessionId = sjbLogon(ddyAccount, ddyPassword);
			Map sjbUserInfoMap = getSjbUserInfo(ddySessionId, sjSessionId);// 登录用户
			String open_id = StringHelper.showNull2Empty(sjbUserInfoMap
					.get("open_id"));
			String user_mobile = StringHelper.showNull2Empty(sjbUserInfoMap
					.get("user_mobile"));
			String user_name = StringHelper.showNull2Empty(sjbUserInfoMap
					.get("user_name"));

			// 获取司机信息
			Map sjbSjInfoMap = getSjbSjInfo(ddySessionId, open_id);
			String sjsjh = StringHelper.showNull2Empty(sjbUserInfoMap
					.get("user_mobile"));
			String sjname = StringHelper.showNull2Empty(sjbUserInfoMap
					.get("user_name"));
			String sjsfzh = StringHelper.showNull2Empty(sjbSjInfoMap
					.get("idcode"));

			// 获取司机车辆信息
			Map sjbClInfoMap = getSjbClInfo(ddySessionId, open_id);
			String user_mobile2 = StringHelper.showNull2Empty(sjbClInfoMap
					.get("user_mobile"));
			String user_name2 = StringHelper.showNull2Empty(sjbClInfoMap
					.get("user_name"));
			String clcph = StringHelper.showNull2Empty(sjbClInfoMap
					.get("plate_code"));
			String cllx = StringHelper.showNull2Empty(sjbClInfoMap
					.get("construct"));
			String clcd = StringHelper.showNull2Empty(sjbClInfoMap
					.get("length"));
			String clzz = StringHelper.showNull2Empty(sjbClInfoMap
					.get("tonnage"));

			// 获取群组成员列表
//			List sjbUserList = getSjbUserList(ddySessionId);

			// 获取司机位置信息
			Map sjbUserLocationMap = getSjbUserLocation(ddySessionId, open_id);
			String longitude = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("longitude"));
			String latitude = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("latitude"));
			String address = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("address"));
			String province = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("province"));
			String city = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("city"));
			String county = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("county"));
			String uploadtime = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("uploadtime"));
			String locatetime = StringHelper.showNull2Empty(sjbUserLocationMap
					.get("locatetime"));
			Timestamp ss = new Timestamp(PubFunc.parseLong(uploadtime));
			Timestamp ss2 = new Timestamp(PubFunc.parseLong(locatetime));

			// 获取司机历史轨迹
			Long begindate = PubFunc.getTime("2015-12-07" + " 00:00:00");
			Long enddate = System.currentTimeMillis();
			List sjlsgjList = getSjlsgj(ddySessionId, open_id, begindate,
					enddate);

			// 发送调度通知
			// String ydbh = "yd0003";
			// String ydhwmc = "尿素";
			// String ydhwzl = "20";
			// String title = "调度通知";
			// String content = ydhwmc + ydhwzl + "吨,运单号" + ydbh + ",请尽快提货！";
			// String linkurl = SignUtil.serverUrl +
			// "hhwlh5/Home/sjdd.html?ydbh="
			// + ydbh;
			// String result = SignUtil.sendCardMsgToSj(open_id, title, content,
			// linkurl);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
