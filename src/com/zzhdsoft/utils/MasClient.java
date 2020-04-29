/**
 *  @Written by    : zjf
 *  @version       : v1.00
 *  @Description   :  
 *   
 **/
package com.zzhdsoft.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.SimpleHttpConnectionManager;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpClientParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.jdom.Attribute;

import com.lbs.commons.GlobalNameS;
import com.sun.istack.FinalArrayList;
import com.zzhdsoft.GlobalNames;

/**
 * MasInterfaceClient的中文名称：手机短信信箱接口
 * 
 * MasInterfaceClient的描述：
 * 
 * Written by : zjf
 */
public class MasClient {
	// MAS服务器地址
	private static final String serverUrl = "http://218.206.201.28:10657/SMS";
	private static String urlCharset = "UTF-8";

	/**
	 * 
	 * SendSms的中文名称：发送短信
	 * 
	 * SendSms的概要说明：
	 * 
	 * @param UserName
	 *            用户名
	 * @param PWD
	 *            密码
	 * @param CorpCode
	 *            信箱号
	 * @param Message
	 *            要发送的信息
	 * @param Dest
	 *            发送的目标号码
	 * @param String
	 *            服务器返回的信息
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public static boolean SendSms(String UserName, String PWD, String CorpCode,
			String Message, String Dest) throws Exception {
		boolean ReturnValue = false;
		Map map = new HashMap();

		// 生成发送的报文，xml字符串【Base64加密】
		String poketXml = EncryptBase64(CreateSendPuk(UserName, PWD, CorpCode,
				Message, Dest));
		try {
			// 1.连接服务器
			// 2.向服务器发送POST请求
			// 3.读取服务器返回值
			String contentType = "application/x-www-form-urlencoded";
			map = HttpUtil.postXmlRequest(serverUrl, poketXml, contentType,
					urlCharset);

			String statusCode = map.get("statusCode").toString();
			if ("200".equals(statusCode)) {
				// 服务器返回xml字符串信息【Base64解密】
				String bodyContent = DecryptBase64(map.get("bodyContent")
						.toString());

				// 打印服务器返回的状态
				System.out.println(statusCode);
				// 打印返回的信息
				System.out.println(bodyContent);

				// 解析返回的xml字符串
				InputStream in_withcode = new ByteArrayInputStream(bodyContent
						.getBytes("UTF-8"));
				Map returnMap = parseXml(in_withcode);
				// 短信服务器回复信息
				statusCode = returnMap.get("State").toString();
				bodyContent = DecryptBase64(returnMap.get("Return").toString());
				// 打印解密后的返回信息
				System.out.println(bodyContent);

				if ("0".equals(statusCode)) {
					ReturnValue = true;
				}
			}
		} catch (Exception e) {
			return false;
		}
		return ReturnValue;
	}

	/**
	 * 
	 * CreateSendPuk的中文名称：生成发送数据包
	 * 
	 * CreateSendPuk的概要说明：
	 * 
	 * @param UserName
	 *            用户名
	 * @param PWD
	 *            密码
	 * @param CorpCode
	 *            信箱号
	 * @param Message
	 *            待发送的消息体
	 * @param Dest
	 *            发送的目标号码
	 * @return 生成的发送数据包 Written by : zjf
	 * @throws Exception
	 * 
	 */
	private static String CreateSendPuk(String UserName, String PWD,
			String CorpCode, String Message, String Dest) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<Root Version=\"2.0\" ");
		sb.append("User=\"").append(UserName).append("\" ");
		sb.append("PWD=\"").append(PWD).append("\" ");
		sb.append("UserType=\"").append("8").append("\" ");
		sb.append("CorpCode=\"").append(CorpCode).append("\" >");
		sb.append("<SMS>");
		sb.append("<M>");
		sb.append(EncryptBase64(Message));
		sb.append("</M>");
		sb.append("<H ");
		sb.append("M=\"").append(Dest).append("\" />");
		sb.append("</SMS>");
		sb.append("</Root>");
		return sb.toString();
	}

	/**
	 * 
	 * EncryptBase64的中文名称：对数据进行Base64加密
	 * 
	 * EncryptBase64的概要说明：
	 * 
	 * @param Data
	 *            待加密数据
	 * @return 加密后数据 Written by : zjf
	 * @throws Exception
	 * 
	 */
	private static String EncryptBase64(final String Data) throws Exception {
		return CryptTool.encodeBase64(Data);
	}

	/**
	 * 
	 * DecryptBase64的中文名称：解密Base64数据
	 * 
	 * DecryptBase64的概要说明：
	 * 
	 * @param Data
	 *            待解密数据
	 * @return 解密后的数据 Written by : zjf
	 * @throws Exception
	 * 
	 */
	private static String DecryptBase64(final String Data) throws Exception {
		return CryptTool.decodeBase64(Data);
	}

	/**
	 * 
	 * parseXml的中文名称：解析【xml数据】
	 * 
	 * parseXml的概要说明:
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static Map<String, String> parseXml(InputStream inputStream)
			throws Exception {
		// 将解析结果存储在HashMap中
		Map<String, String> map = new HashMap<String, String>();

		// 读取输入流
		SAXReader reader = new SAXReader();
		Document document = reader.read(inputStream);

		// 得到xml根元素
		Element root = document.getRootElement();
		// 获取根节点下的子节点Return
		Element smsElement = root.element("SMS");
		Element reElement = smsElement.element("Return");
		// 拿到Return节点属性值
		String stateString = reElement.attributeValue("State");
		map.put("State", stateString);
		System.out.println(stateString);

		// 拿到Return节点值
		String returnString = reElement.getTextTrim();
		map.put("Return", returnString);
		System.out.println(returnString);

		// 释放资源
		inputStream.close();
		inputStream = null;
		return map;
	}

	/**
	 * 测试方法
	 * 
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		String UserName = "Q005J002738";
		String PWD = Encrypt.decrypt("B55C2060A9D7812319508C2E2573D2A2");
		String CorpCode = "10657006031546";
		String Message = "测试短信：短信接口开发测试数据，请勿回复！";
		// String Dest = "13849614404";
		String Dest = "13838052297";
		SendSms(UserName, PWD, CorpCode, Message, Dest);
	}
}
