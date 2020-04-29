package com.zzhdsoft.utils;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * 
 * MD5Util的中文名称：MD5加解密工具类
 * 
 * MD5Util的描述：
 * 
 * Written by : zjf
 */
public class MD5Util {
	private final static String[] hexDigits = { "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", "A", "B", "C", "D", "E", "F" };

	/**
	 * 转换字节数组为16进制字串
	 * 
	 * @param b
	 *            字节数组
	 * @return 16进制字串
	 */

	public static String byteArrayToHexString(byte[] b) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			resultSb.append(byteToHexString(b[i]));
		}
		return resultSb.toString();
	}

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0) {
			n = 256 + n;
		}
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];
	}

	public static String MD5Encode(String encodeStr) {
		String resultStr = null;
		try {
			// 获得MD5摘要算法的 MessageDigest对象
			MessageDigest md = MessageDigest.getInstance("MD5");
			// 获得密文
			byte[] mdb = md.digest(encodeStr.getBytes());
			// 把密文转换成十六进制的字符串形式
			resultStr = byteArrayToHexString(mdb);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return resultStr;
	}

	public final static String MD5(String encodeStr) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = encodeStr.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static void main(String[] args) {
		String aa = "123456";
		String bb = MD5Util.MD5(aa).toLowerCase();
		System.out.println(bb);
		String bb1 = MD5Util.MD5Encode(aa).toLowerCase();
		System.out.println(bb1);

		String timestamp = DateUtil.convertDateToYearMonthDay(SysmanageUtil
				.currentTime());
		System.out.print(timestamp);

		int[] arr = { 5, 1, 6, 4, 2, 8, 9 };
		Arrays.sort(arr);
		System.out.print(Arrays.toString(arr));
		
		String[] arr2 = {"vss","acv","acf","bc","ba" };
		Arrays.sort(arr2);
		System.out.print(Arrays.toString(arr2));
		
		// MD5签名验证
		String appid = "abc";
		String appkey = "123456";
		timestamp = "2015-10-13 11:35:53.796";
		String signStr = appid + "|" + appkey + "|" + timestamp;
		String MD5Str = MD5Util.MD5Encode(signStr).toUpperCase();
		System.out.print(MD5Str);
	}
}