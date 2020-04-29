package com.zzhdsoft.utils.gifyzm;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.Random;
import java.util.ResourceBundle;

public class GifCodeUtil {
	// 定义验证码字符。去除了O和I等容易混淆的字母（也可写成）
	// String s[] = { "A", "B", "C", "D", "E", "F", "G", "H", "G", "K", "M",
	// "N",
	// "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b",
	// "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q",
	// "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3",
	// "4", "o", "5", "I", "6", "7", "8", "9", "O", "i" };
	
	// 定义生成的验证码的宽度和高度
	int width = 120;
	int height = 30;

	public void makeGifCode(OutputStream os, String yzm) {
		// OutputStream os=null;
		// 生成字符
		// AlphaComposite ac =
		// AlphaComposite.getInstance(AlphaComposite.SRC_OVER,
		// 1);
		AnimatedGifEncoder agf = new AnimatedGifEncoder();
		agf.start(os);
		agf.setQuality(10);

		agf.setDelay(100);
		agf.setRepeat(0);
		BufferedImage frame = null;
		// Graphics2D teg = null;
		// String rands[] = new String[6];
		// for (int i = 0; i < 6; i++) {
		// rands[i] = s[this.randomInt(0, s.length)];
		// }
		
		// 验证码
		String rands[] = new String[4];//6->4
		for (int i = 0; i < yzm.length(); i++) {
			rands[i] = yzm.charAt(i) + "";
		}

		// 生成字体
		Font font[] = new Font[4];
		for (int i = 0; i < 4; i++) {
			font[i] = this.getFont();
		}
		// 生成背景颜色
		Color bgcolor = getRandColor(160, 200);
		Color linecolor = getRandColor(200, 250);
		Color fontcolor[] = new Color[4];
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			fontcolor[i] = new Color(20 + random.nextInt(110), 20 + random
					.nextInt(110), 20 + random.nextInt(110));
		}
		for (int i = 0; i < 4; i++) {
			frame = this
					.getImage(bgcolor, linecolor, fontcolor, rands, font, i);
			agf.addFrame(frame);
			frame.flush();
		}
		agf.finish();
	}

	private BufferedImage getImage(Color bgcolor, Color linecolor,
			Color[] fontcolor, String str[], Font[] font, int flag) {
		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		// 或得图形上下文
		Graphics2D g2d = image.createGraphics();
		// 利用指定颜色填充背景
		bgcolor = new Color(204, 211, 190);
		g2d.setColor(bgcolor);
		g2d.fillRect(0, 0, width, height);
		// 画背景线 4*4
		linecolor = Color.white;
		linecolor = new Color(215, 221, 104);
		g2d.setColor(linecolor);
		for (int i = 0; i < height / 8 + 2; i++) {
			g2d.drawLine(0, i * 7, width, i * 7);
		}
		for (int i = 0; i < width / 8 + 2; i++) {
			g2d.drawLine(i * 8, 0, i * 8, height);
		}
		AlphaComposite ac = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,
				0.2f);
		// 以下生成验证码 //透明度从0 循环到1 步长为0.2 。一共4个字母
		AlphaComposite ac3 = null;
		for (int i = 0; i < str.length; i++) {
			g2d.setFont(font[i]);
			// ac3 = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,
			// getAlpha(flag, i));
			// g2d.setComposite(ac3);
			g2d.setColor(fontcolor[i]);
			g2d.drawString(str[i], 25 * i + 15, 25);
			// g2d.drawString(str[i], 25 * i + 20, 30);
		}

		g2d.setComposite(ac);
		g2d.setFont(new Font("方正舒体,隶书", Font.ITALIC + Font.BOLD, 14));
		g2d.setColor(Color.RED);
		
		final ResourceBundle bundle = ResourceBundle.getBundle("config");// 读取属性文件
		String yzm_text = bundle.getString("yzm_text");
		
		g2d.drawString(yzm_text, 0, 22);
//		g2d.setFont(new Font("隶书", Font.ITALIC + Font.BOLD, 16));
//		g2d.drawString("www.hdsoft.com", 4, 40);

		g2d.dispose();
		return image;
	}

	/**
	 * 
	 * @参数：
	 * @返回值:
	 * @描述:获得随机字体
	 */
	private Font getFont() {
		// 获得随机字体;
		// 设置font :字体名称:Monotype Corsiva 华文彩云 方正舒体 华文行楷,隶书
		// Random s = new Random();
		int i = 7;
		if (i % 2 == 0) {
			return new Font("Monotype Corsiva", Font.BOLD, 28);
		} else if (i % 3 == 0) {
			return new Font("方正舒体", Font.BOLD, 28);
		} else if (i % 7 == 0) {
			return new Font("隶书", Font.BOLD, 28);
		} else {
			return new Font("方正舒体", Font.BOLD, 28);
		}
	}

	/**
	 * 
	 * @参数：
	 * @返回值:
	 * @描述:获得循环透明度，从0到1 步长为0.2
	 */
	private float getAlpha(int i, int j) {
		if ((i + j) > 5) {
			return ((i + j) * 0.2f - 1.2f);
		} else {
			return (i + j) * 0.2f;
		}
	}

	/**
	 * 
	 * @参数：
	 * @返回值:
	 * @描述:获得随机色
	 */
	private Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
		Random random = new Random();
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}

	/**
	 * 返回[from,to)之间的一个随机整数
	 * 
	 * @param from
	 *            起始值
	 * @param to
	 *            结束值
	 * @return [from,to)之间的一个随机整数
	 */
	private int randomInt(int from, int to) {
		Random r = new Random();
		return from + r.nextInt(to - from);
	}
}
