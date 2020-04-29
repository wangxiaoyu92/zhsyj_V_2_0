package com.zzhdsoft.utils.servlet;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.swetake.util.Qrcode;
import com.zzhdsoft.utils.Encrypt;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;

public class QRCodeServlet extends HttpServlet {

	/**
	 * serialVersionUID:
	 * 
	 * @since Ver 1.00
	 */

	private static final long serialVersionUID = -8418881247578835231L;

	public QRCodeServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		createLoginQrcode(request, response); // 二维码加密(登录使用)
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		// Put your code here
	}
	
	/**
	 * 
	 * createLoginQrcode的中文名称：
	 * 
	 * createLoginQrcode的概要说明：
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 *        Written by : zy
	 */
	public void createLoginQrcode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取sessionid
		String sessionId = request.getSession().getId();
		try {
			// 获取授权码
			String grantCode = StringHelper.genUUID().replaceAll("-", "")
					.toUpperCase();
			String code = sessionId + "." + grantCode;
			// 获取key
			String key = grantCode.substring(grantCode.length() / 4 * 3);
			SysmanageUtil.getSessionContext().put(
					sessionId,
					new String[] {
							grantCode,
							Long.toString(Calendar.getInstance()
									.getTimeInMillis()), "100", "", "" });

			String codeSt = key.substring(key.length() / 2);
			String codeEd = key.substring(0, key.length() / 2);
			String encryptCode = Encrypt.encrypt(code, key);
			BufferedImage bfi = generateQRCode("asln://"+codeSt + encryptCode + codeEd);
			OutputStream out = response.getOutputStream();
			response.setContentType("image/gif");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			ImageIO.write(bfi, "gif", out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * generateQRCode的中文名称：生成二维码
	 * 
	 * generateQRCode的概要说明：加密
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 */
	public BufferedImage generateQRCode(String code) throws Exception {
		Qrcode qrcode = new Qrcode();
		// 设置二维码排错率，可选L(7%)、M(15%)、Q(25%)、H(30%)，排错率越高可存储的信息越少，但对二维码清晰度的要求越小
		qrcode.setQrcodeErrorCorrect('L');
		//
		qrcode.setQrcodeEncodeMode('B');
		// 这个值最大40，值越大可以容纳的信息越多，够用就行了
		qrcode.setQrcodeVersion(8);

		byte[] contentBytes = code.getBytes("UTF-8");
		int size = 150;
		BufferedImage bfi = new BufferedImage(size, size,
				BufferedImage.TYPE_INT_RGB);

		Graphics2D gs = bfi.createGraphics();

		gs.setBackground(Color.WHITE);
		gs.clearRect(0, 0, size, size);
		// 设置图像颜色
		gs.setColor(Color.BLACK);
		// 设置图像偏移量，不设置可能导致解析出错
		int pixoff = 2;
		// 输出内容，二维码
		if (contentBytes.length > 0 && contentBytes.length < 200) {
			boolean[][] codeOut = qrcode.calQrcode(contentBytes);
			for (int i = 0; i < codeOut.length; i++) {
				for (int j = 0; j < codeOut.length; j++) {
					if (codeOut[j][i]) {
						gs.fillRect(j * 3 + pixoff, i * 3 + pixoff, 3, 3);
					}
				}
			}
		}
		gs.dispose();
		bfi.flush();
		return bfi;
	}

}
