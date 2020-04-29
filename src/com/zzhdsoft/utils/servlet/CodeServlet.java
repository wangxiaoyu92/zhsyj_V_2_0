package com.zzhdsoft.utils.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.RandomStringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.utils.gifyzm.GifCodeUtil;

public class CodeServlet extends HttpServlet {

	/**
	 * serialVersionUID:TODO
	 * 
	 * @since Ver 1.00
	 */

	private static final long serialVersionUID = -8418881247578835231L;

	public CodeServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 生成4位随机字符串，去除O和I等容易混淆的字母
		// String yzmStr = RandomStringUtils.random(4, true, true);
		String yzmStr = RandomStringUtils.random(4, new char[] { 'A', 'B', 'C',
				'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'P', 'Q', 'R',
				'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
				'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z', '2', '3', '4', '5', '6',
				'7', '8', '9' });
//		yzmStr = "AAAA";
		HttpSession session = request.getSession(true);
		session.setAttribute(GlobalNames.VERIFYCODE, yzmStr.toLowerCase());

		response.setContentType("image/gif");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		// 生成GIF验证码图片
		new GifCodeUtil().makeGifCode(response.getOutputStream(), yzmStr);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
