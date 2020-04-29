package com.zzhdsoft.utils.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.RandomStringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.push.JPushAllUtil;

public class PhoneCodeServlet extends HttpServlet {

	/**
	 * serialVersionUID:TODO
	 * 
	 * @since Ver 1.00
	 */

	private static final long serialVersionUID = -8418881247578835231L;

	public PhoneCodeServlet() {
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
		HttpSession session = request.getSession(true);
		session.setAttribute(GlobalNames.VERIFYCODE, yzmStr.toLowerCase());
		/**
		 * 验证码登陆系统
		 */
		String mobile = request.getParameter("username");
//极光推送验证码
		String v_sql = "select userid from Sysuser a where a.mobile='" + mobile + "' or a.mobile2 = '" + mobile + "'";
		try {
			//获取id
			List<Sysuser> ls  = DbUtils.getDataList(v_sql, Sysuser.class);
			
			List<String> str=new ArrayList<String>();
			if(ls.size()>0){
				Sysuser user  = ls.get(0);
				String yzm = "你的后台验证码是: "+ yzmStr.toLowerCase()+",请在五分钟内登陆使用";
				str.add(user.getUserid());
//				str.add("0");
				//推送验证码
				JPushAllUtil.androidSendPushByalias(str, "1", yzm, "验证码");
			}else {
				//解决乱码问题，必须放在最前面
				response.setCharacterEncoding("utf-8");
				PrintWriter out=response.getWriter();
				 String content="输入用户名不存在,请重新输入正确的用户名";
				out.write(content);
				out.flush();
				out.close();
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
