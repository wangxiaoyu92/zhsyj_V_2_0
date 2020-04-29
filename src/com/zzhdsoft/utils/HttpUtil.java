/**
 *  @Written by    : zjf
 *  @version       : v1.00
 *  @Description   :  
 *   
 **/
package com.zzhdsoft.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.*;

import com.lbs.leaf.exception.BusinessException;

/**
 * HttpUtil的中文名称：http请求工具类
 * 
 * HttpUtil的描述：可以提交key-value形式的， 或提交xml流，或文件。
 * 
 * 
 * Written by : zjf
 */
public class HttpUtil {

	/**
	 * 
	 * httpGet的中文名称：http发送get请求
	 * 
	 * httpGet的概要说明：
	 * 
	 * @param requestUrl
	 * @return Written by : zjf
	 * 
	 */
	public static String httpGet(String requestUrl, String charset) {
		String jsonStr = null;
		StringBuilder builder = new StringBuilder();
		try {
			URL url = new URL(requestUrl);
			HttpURLConnection httpConn = (HttpURLConnection) url
					.openConnection();
			httpConn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");//gu20180705
			httpConn.setDoInput(true);
			httpConn.setDoOutput(true);
			httpConn.setRequestMethod("GET");
			httpConn.setRequestProperty("Content-Type",
					"application/json;charset=utf-8");

			httpConn.connect();
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					httpConn.getInputStream(), charset));

			String s = null;
			while ((s = reader.readLine()) != null) {
				builder.append(s);
			}

			reader.close();
			// 断开连接
			httpConn.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("HTTP请求失败，失败原因：" + e.getMessage());
		}

		jsonStr = builder.toString();
		return jsonStr;
	}

	/**
	 *
	 * httpGet的中文名称：http发送get请求
	 *
	 * httpGet的概要说明：
	 *
	 * @param requestUrl
	 * @return Written by : zjf
	 *
	 */
	public static Map httpDeleteWithHeader(String requestUrl,Header header ,String contentType, String charset) {
		Map map = new HashMap();
		// init PostMethod object.
		DeleteMethod delete = new DeleteMethod(requestUrl);

		try {
			// wrape the request entity.
			RequestEntity requestEntity = new StringRequestEntity("{}",

					contentType, charset);
			if (header!=null){
				delete.setRequestHeader(header);
			}
			HttpClient httpClient = new HttpClient();
			// send the post http request and return status code.
			int statusCode = httpClient.executeMethod(delete);
			// get reture content from server side.
			String bodyContent = delete.getResponseBodyAsString();
			// 打印服务器返回的状态
			// System.out.println(statusCode);
			// 打印返回的信息
			// System.out.println(bodyContent);

			// populate the reture values to vo.
			map.put("statusCode", statusCode);
			map.put("bodyContent", bodyContent);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// close the connection.
			delete.releaseConnection();
		}

		return map;
	}

	/**
	 * 
	 * httpPost的中文名称：http发送post请求
	 * 
	 * httpPost的概要说明：
	 * 
	 * @param requestUrl
	 * @param charset
	 * @return Written by : zjf
	 * 
	 */
	public static String httpPost(String requestUrl, String charset) {
		StringBuilder builder = new StringBuilder();
		try {
			URL url = new URL(requestUrl);
			HttpURLConnection httpConn = (HttpURLConnection) url
					.openConnection();
			httpConn.setDoInput(true);
			httpConn.setDoOutput(true);
			httpConn.setRequestMethod("POST");
			// httpConn.setRequestProperty("Content-Type",
			// "application/json;");

			httpConn.connect();
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					httpConn.getInputStream(), charset));

			String s = null;
			while ((s = reader.readLine()) != null) {
				builder.append(s);
			}

			reader.close();
			// 断开连接
			httpConn.disconnect();
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String jsonStr = builder.toString();
		return jsonStr;
	}

	/**
	 * 
	 * postXmlRequest的中文名称：Java发送http请求【post方式】
	 * 
	 * postXmlRequest的概要说明：提交xml流
	 * 
	 * @param requestUrl
	 * @param xmlData
	 * @param contentType
	 * @param charset
	 * @return Written by : zjf
	 * 
	 */
	public static Map postXmlRequest(String requestUrl, String xmlData,
			String contentType, String charset) {
		return postXmlRequestWithHeader(requestUrl,null, xmlData,contentType, charset);
	}

	/**
	 *
	 * postXmlRequest的中文名称：Java发送http请求【post方式】
	 *
	 * postXmlRequest的概要说明：提交xml流
	 *
	 * @param requestUrl
	 * @param xmlData
	 * @param contentType
	 * @param charset
	 * @return Written by : zjf
	 *
	 */
	public static Map postXmlRequestWithHeader(String requestUrl, Header header, String xmlData,
											   String contentType, String charset) {
		Map map = new HashMap();
		// init PostMethod object.
		PostMethod post = new PostMethod(requestUrl);

		try {
			// wrape the request entity.
			RequestEntity requestEntity = new StringRequestEntity(xmlData,

					contentType, charset);
			post.setRequestEntity(requestEntity);
			if (header!=null){
				post.setRequestHeader(header);
			}
			HttpClient httpClient = new HttpClient();
			// send the post http request and return status code.
			int statusCode = httpClient.executeMethod(post);
			// get reture content from server side.
			String bodyContent = post.getResponseBodyAsString();
			// 打印服务器返回的状态
			// System.out.println(statusCode);
			// 打印返回的信息
			// System.out.println(bodyContent);

			// populate the reture values to vo.
			map.put("statusCode", statusCode);
			map.put("bodyContent", bodyContent);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// close the connection.
			post.releaseConnection();
		}

		return map;
	}

	/**
	 * 测试方法
	 * 
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		String requestUrl = "http://www.shejian360.com/cameraAction!getUrlByCmaId.action?camId=41052311001310000084";
		String xmlData = "<?xml version="
				+ "\"1.0\""
				+ " encoding="
				+ "\"UTF-8\""
				+ "?><SDRequest><TransactionName>CreateDataFileComplete</TransactionName><IdentityInfo><Code>"
				+ 1 + "</Code><Description></Description><Timestamp>"
				+ "20100315140542" + "</Timestamp></IdentityInfo></SDRequest>";
		String contentType = "application/x-www-form-urlencoded";
		String charset = "UTF-8";
		//Map map = postXmlRequest(requestUrl, xmlData, contentType, charset);
		String xxString = httpPost(requestUrl,charset);
		// 打印服务器返回的状态
		//System.out.println(map.get("statusCode").toString());
		// 打印返回的信息
		System.out.println(xxString);
	}

}
