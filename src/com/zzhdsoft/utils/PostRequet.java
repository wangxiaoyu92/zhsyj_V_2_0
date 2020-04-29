/**
 *  @Written by    : zjf
 *  @version       : v1.00
 *  @Description   :  
 *   
 **/
package com.zzhdsoft.utils;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 * PostRequet的中文名称：Java发送http请求 (get与post方法请求)
 * 
 * PostRequet的描述：通过BufferedReader 读取远程返回的数据时，必须设置读取编码，否则中文会乱码！
 * 
 * Written by : zjf
 */

public class PostRequet {
	public static final String GET_URL = "http://127.0.0.1:8080/zmdsiweb/servlet/CodeServlet?key=zjftest";

	public static final String POST_URL = "http://127.0.0.1:8080/zmdsiweb/servlet/CodeServlet";
	
	public static final String Bank_URL = "https://ibsbjstar.ccb.com.cn/app/ccbMain";

	/**
	 * 
	 * readContentFromGet的中文名称：Java发送http请求 (get方法请求)
	 * 
	 * readContentFromGet的概要说明：
	 * 
	 * @throws IOException
	 *             Written by : zjf
	 * 
	 */
	public static void readContentFromGet() throws IOException {
		// 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码
		String getURL = GET_URL + "&activatecode="
				+ URLEncoder.encode("久酷博客", "utf-8");
		URL getUrl = new URL(getURL);
		// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
		// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
		HttpURLConnection connection = (HttpURLConnection) getUrl
				.openConnection();
		// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到服务器
		connection.connect();
		// 取得输入流，并使用Reader读取
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "utf-8"));// 设置编码,否则中文乱码
		System.out.println("=============================");
		System.out.println("Contents of get request");
		System.out.println("=============================");
		String lines;
		while ((lines = reader.readLine()) != null) {
			// lines = new String(lines.getBytes(), "utf-8");
			System.out.println(lines);
		}
		reader.close();
		// 断开连接
		connection.disconnect();
		System.out.println("=============================");
		System.out.println("Contents of get request ends");
		System.out.println("=============================");
	}

	/**
	 * 
	 * readContentFromPost的中文名称：Java发送http请求 (post方法请求)
	 * 
	 * readContentFromPost的概要说明：
	 * 
	 * @throws IOException
	 *             Written by : zjf
	 * 
	 */
	public static void readContentFromPost() throws IOException {
		// Post请求的url，与get不同的是不需要带参数
		URL postUrl = new URL(Bank_URL);
		// 打开连接
		HttpURLConnection connection = (HttpURLConnection) postUrl
				.openConnection();
		// Output to the connection. Default is
		// false, set to true because post
		// method must write something to the
		// connection
		// 设置是否向connection输出，因为这个是post请求，参数要放在
		// http正文内，因此需要设为true
		connection.setDoOutput(true);
		// Read from the connection. Default is true.
		connection.setDoInput(true);
		// Set the post method. Default is GET
		connection.setRequestMethod("POST");
		// Post cannot use caches
		// Post 请求不能使用缓存
		connection.setUseCaches(false);
		// This method takes effects to
		// every instances of this class.
		// URLConnection.setFollowRedirects是static函数，作用于所有的URLConnection对象。
		// connection.setFollowRedirects(true);

		// This methods only
		// takes effacts to this
		// instance.
		// URLConnection.setInstanceFollowRedirects是成员函数，仅作用于当前函数
		connection.setInstanceFollowRedirects(true);
		// Set the content type to urlencoded,
		// because we will write
		// some URL-encoded content to the
		// connection. Settings above must be set before connect!
		// 配置本次连接的Content-type，配置为application/x-www-form-urlencoded的
		// 意思是正文是urlencoded编码过的form参数，下面我们可以看到我们对正文内容使用URLEncoder.encode
		// 进行编码
		connection.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		// 连接，从postUrl.openConnection()至此的配置必须要在connect之前完成，
		// 要注意的是connection.getOutputStream会隐含的进行connect。
		connection.connect();
		DataOutputStream out = new DataOutputStream(connection
				.getOutputStream());
		// The URL-encoded contend
		// 正文，正文内容其实跟get的URL中'?'后的参数字符串一致
		String content = "MERCHANTID=105411793990039&POSID=857081260&BRANCHID=410000000&ORDERID=2014082500000001&PAYMENT=0.01&CURCODE=01&TXCODE=520100&REMARK1=&REMARK2=&MAC=cbb47e70d4a88c3108d7a787ed75c141";
		// DataOutputStream.writeBytes将字符串中16位的unicode字符以8位的字符形式写入流里面
		out.writeBytes(content);
		out.flush();
		out.close(); // flush and close
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "utf-8"));// 设置编码,否则中文乱码
		String line = "";
		System.out.println("=============================");
		System.out.println("Contents of post request");
		System.out.println("=============================");
		while ((line = reader.readLine()) != null) {
			// line = new String(line.getBytes(), "utf-8");
			System.out.println(line);
		}
		System.out.println("=============================");
		System.out.println("Contents of post request ends");
		System.out.println("=============================");
		reader.close();
		connection.disconnect();
	}

	/**
	 * 测试方法
	 * 
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		/**
		 * HttpURLConnection.connect函数，实际上只是建立了一个与服务器的tcp连接，并没有实际发送http请求。
		 * 无论是post还是get
		 * ，http请求实际上直到HttpURLConnection.getInputStream()这个函数里面才正式发送出去。
		 * 在readContentFromPost()
		 * 中，顺序是重中之重，对connection对象的一切配置（那一堆set函数）都必须要在connect()函数执行之前完成。而对
		 * outputStream的写操作，又必须要在inputStream的读操作之前。这些顺序实际上是由http请求的格式决定的。 http
		 * 请求实际上由两部分组成，一个是http头，所有关于此次http请求的配置都在http头里面定义，一个是正文content，
		 * 在connect()函数里面，会根据HttpURLConnection对象的配置值生成http头，因此在调用connect函数之前，
		 * 就必须把所有的配置准备好。
		 * 紧接着http头的是http请求的正文，正文的内容通过outputStream写入，实际上outputStream不是一个网络流
		 * ，充其量是个字符串流， 往里面写入的东西不会立即发送到网络，而是在流关闭后，根据输入的内容生成http正文。
		 * 至此，http请求的东西已经准备就绪。在getInputStream()函数调用的时候，就会把准备好的http请求正式发送到服务器了，
		 * 然后返回一个输入流，用于读取服务器对于此次http请求的返回信息。
		 * 由于http请求在getInputStream的时候已经发送出去了（包括http头和正文），
		 * 因此在getInputStream()函数之后对connection对象进行设置（对http头的信息进行修改）或者写入
		 * outputStream（对正文进行修改）都是没有意义的了，执行这些操作会导致异常的发生。
		 */
		//readContentFromGet();
		readContentFromPost();

	}
}