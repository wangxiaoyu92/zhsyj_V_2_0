package com.zzhdsoft.utils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.Locale;
import com.zzhdsoft.GlobalNames;

/**
 * 
 * DateUtil的中文名称：日期时间工具类
 * 
 * DateUtil的描述：
 * 
 * Written by : zjf
 */
public class DateUtil {
	/**
	 * 日期紧凑格式
	 */
	public static final String COMPACT_DATE_FORMAT = "yyyyMMdd";

	/**
	 * 日期普通格式
	 */
	public static final String NORMAL_DATE_FORMAT = "yyyy-MM-dd";

	/**
	 * 日期格式 年月日 时分秒
	 */
	public static final String NORMAL_DATE_FORMAT_NEW = "yyyy-mm-dd hh24:mi:ss";
	
	public static int calBetweenTwoMonth(String s, String s1) {
		int i = 0;
		if (s.length() != 6 || s1.length() != 6) {
			i = -1;
		} else {
			int j = Integer.parseInt(s);
			int k = Integer.parseInt(s1);
			if (j < k) {
				i = -2;
			} else {
				int l = Integer.parseInt(s.substring(0, 4));
				int i1 = Integer.parseInt(s.substring(4, 6));
				int j1 = Integer.parseInt(s1.substring(0, 4));
				int k1 = Integer.parseInt(s1.substring(4, 6));
				i = (l - j1) * 12 + (i1 - k1);
			}
		}
		return i;
	}

	public static int convertDateToYear(Date date) {
		SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy",
				new DateFormatSymbols());
		return Integer.parseInt(simpledateformat.format(date));
	}

	public static String convertDateToYearMonth(Date date) {
		SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyyMM",
				new DateFormatSymbols());
		return simpledateformat.format(date);
	}

	public static String convertDateToYearMonthDay(Date date) {
		SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyyMMdd",
				new DateFormatSymbols());
		return simpledateformat.format(date);
	}

	public static String dateToString(Date date, String s) {
		if (date == null)
			return "";
		Hashtable hashtable = new Hashtable();
		String s1 = "";
		String s2 = s.toLowerCase();
		if (s2.indexOf("yyyy") != -1)
			hashtable.put(new Integer(s2.indexOf("yyyy")), "yyyy");
		else if (s2.indexOf("yy") != -1)
			hashtable.put(new Integer(s2.indexOf("yy")), "yy");
		if (s2.indexOf("mm") != -1)
			hashtable.put(new Integer(s2.indexOf("mm")), "MM");
		if (s2.indexOf("dd") != -1)
			hashtable.put(new Integer(s2.indexOf("dd")), "dd");
		if (s2.indexOf("hh24") != -1)
			hashtable.put(new Integer(s2.indexOf("hh24")), "HH");
		if (s2.indexOf("mi") != -1)
			hashtable.put(new Integer(s2.indexOf("mi")), "mm");
		if (s2.indexOf("ss") != -1)
			hashtable.put(new Integer(s2.indexOf("ss")), "ss");
		for (int i = 0; s2.indexOf("-", i) != -1; i++) {
			i = s2.indexOf("-", i);
			hashtable.put(new Integer(i), "-");
		}

		for (int j = 0; s2.indexOf("/", j) != -1; j++) {
			j = s2.indexOf("/", j);
			hashtable.put(new Integer(j), "/");
		}

		for (int k = 0; s2.indexOf(" ", k) != -1; k++) {
			k = s2.indexOf(" ", k);
			hashtable.put(new Integer(k), " ");
		}

		for (int l = 0; s2.indexOf(":", l) != -1; l++) {
			l = s2.indexOf(":", l);
			hashtable.put(new Integer(l), ":");
		}

		if (s2.indexOf("\u5E74") != -1)
			hashtable.put(new Integer(s2.indexOf("\u5E74")), "\u5E74");
		if (s2.indexOf("\u6708") != -1)
			hashtable.put(new Integer(s2.indexOf("\u6708")), "\u6708");
		if (s2.indexOf("\u65E5") != -1)
			hashtable.put(new Integer(s2.indexOf("\u65E5")), "\u65E5");
		if (s2.indexOf("\u65F6") != -1)
			hashtable.put(new Integer(s2.indexOf("\u65F6")), "\u65F6");
		if (s2.indexOf("\u5206") != -1)
			hashtable.put(new Integer(s2.indexOf("\u5206")), "\u5206");
		if (s2.indexOf("\u79D2") != -1)
			hashtable.put(new Integer(s2.indexOf("\u79D2")), "\u79D2");
		boolean flag = false;
		while (hashtable.size() != 0) {
			Enumeration enumeration = hashtable.keys();
			int j1 = 0;
			while (enumeration.hasMoreElements()) {
				int i1 = ((Integer) enumeration.nextElement()).intValue();
				if (i1 >= j1)
					j1 = i1;
			}
			String s3 = (String) hashtable.get(new Integer(j1));
			hashtable.remove(new Integer(j1));
			s1 = s3 + s1;
		}
		SimpleDateFormat simpledateformat = new SimpleDateFormat(s1,
				new DateFormatSymbols());
		return simpledateformat.format(date);
	}

	public static int daysBetweenDates(Date date, Date date1) {
		int i = 0;
		Calendar calendar = Calendar.getInstance();
		Calendar calendar1 = Calendar.getInstance();
		calendar.setTime(date1);
		calendar1.setTime(date);
		int j = calendar.get(6);
		int k = calendar1.get(1);
		for (int l = calendar.get(1); k > l;) {
			calendar.set(2, 11);
			calendar.set(5, 31);
			i += calendar.get(6);
			l++;
			calendar.set(1, l);
		}

		int i1 = calendar1.get(6);
		i = (i + i1) - j;
		return i;
	}

	public static String descreaseYearMonth(String s) {
		int i = (new Integer(s.substring(0, 4))).intValue();
		int j = (new Integer(s.substring(4, 6))).intValue();
		if (--j >= 10)
			return s.substring(0, 4) + (new Integer(j)).toString();
		if (j > 0 && j < 10)
			return s.substring(0, 4) + "0" + (new Integer(j)).toString();
		else
			return (new Integer(i - 1)).toString()
					+ (new Integer(j + 12)).toString();
	}

	public static String getAddIssue(String s, int i) {
		String s1 = s;
		int j = i;
		int k = Integer.parseInt(s1) / 100;
		int l = Integer.parseInt(s1) % 100;
		int i1 = j / 12;
		int j1 = j % 12;
		k += i1;
		l += j1;
		if (l > 12) {
			k++;
			l -= 12;
		}
		if (l < 0) {
			k--;
			l += 12;
		}
		if (l < 10)
			s1 = Integer.toString(k).trim() + '0' + Integer.toString(l).trim();
		else
			s1 = Integer.toString(k).trim() + Integer.toString(l).trim();
		return s1;
	}

	public static int getAge(Date date, Date date1) throws Exception {
		String s = getStrDate(date);
		String s1 = getStrDate(date1);
		int i = getIntervalMonth(s, s1);
		int j = i / 12;
		if (i % 12 == 0) {
			String s2 = s.substring(6);
			String s3 = s1.substring(6);
			if (s2.compareTo(s3) > 0)
				j--;
		}
		return j;
	}

	public static int getAge(String s) throws Exception {
		int i = -1;
		int j = s.length();
		String s1 = "";
		if (j == 15) {
			s1 = s.substring(6, 8);
			s1 = "19" + s1;
		} else if (j == 18)
			s1 = s.substring(6, 10);
		else
			throw new Exception("\u9519\u8BEF\u7684\u8EAB\u4EFD\u8BC1\u53F7");
		int k = Calendar.getInstance().get(1);
		i = k - (new Integer(s1)).intValue();
		return i;
	}

	public static String getBirtday(String s) throws Exception {
		String s1 = "";
		int i = s.length();
		String s3 = "";
		int j = 0;
		String s4 = "";
		int k = 0;
		String s5 = "";
		int l = 0;
		boolean flag = false;
		String s6 = dateToString(new Date(), "yyyy-mm-dd");
		if (i == 15) {
			s3 = "19" + s.substring(6, 8);
			s4 = s.substring(8, 10);
			s5 = s.substring(10, 12);
		} else if (i == 18) {
			s3 = s.substring(6, 10);
			s4 = s.substring(10, 12);
			s5 = s.substring(12, 14);
		} else {
			return dateToString(new Date(), "yyyy-mm-dd");
		}
		j = (new Integer(s3)).intValue();
		k = (new Integer(s4)).intValue();
		l = (new Integer(s5)).intValue();
		if (j < 1900 || j > 2200)
			return s6;
		if (j % 4 != 0 && j % 100 != 0)
			flag = false;
		else
			flag = true;
		if (k == 2)
			if (flag) {
				if (l < 1 || l > 29)
					return s6;
			} else if (l < 1 || l > 28)
				return s6;
		if ((k == 1 || k == 3 || k == 5 || k == 7 || k == 8 || k == 10 || k == 12)
				&& (l < 1 || l > 31))
			return s6;
		if ((k == 4 || k == 6 || k == 9 || k == 11) && (l < 1 || l > 30)) {
			return s6;
		} else {
			String s2 = s3 + "-" + s4 + "-" + s5;
			return s2;
		}
	}

	public static String getChineseDate(Date date) {
		if (date == null) {
			return "";
		} else {
			SimpleDateFormat simpledateformat = new SimpleDateFormat(
					"yyyyMMdd", new DateFormatSymbols());
			String s = simpledateformat.format(date);
			return s.substring(0, 4) + "\u5E74"
					+ Integer.parseInt(s.substring(4, 6)) + "\u6708"
					+ Integer.parseInt(s.substring(6, 8)) + "\u65E5";
		}
	}

	public static String getChineseWeek() {
		int i = java.util.Calendar.getInstance().get(
				java.util.Calendar.DAY_OF_WEEK);
		switch (i) {
		case 1:
			return "星期日";
		case 2:
			return "星期一";
		case 3:
			return "星期二";
		case 4:
			return "星期三";
		case 5:
			return "星期四";
		case 6:
			return "星期五";
		case 7:
			return "星期六";
		default:
			return "星期日";
		}
	}

	public static Date getCurrentDate() {
		Calendar calendar = Calendar.getInstance();
		Date date = calendar.getTime();
		return date;
	}

	public static String getCurrentDate_String() {
		Calendar calendar = Calendar.getInstance();
		String s = null;
		String s1 = (new Integer(calendar.get(1))).toString();
		String s2 = null;
		String s3 = null;
		if (calendar.get(2) < 9)
			s2 = "0" + (new Integer(calendar.get(2) + 1)).toString();
		else
			s2 = (new Integer(calendar.get(2) + 1)).toString();
		if (calendar.get(5) < 10)
			s3 = "0" + (new Integer(calendar.get(5))).toString();
		else
			s3 = (new Integer(calendar.get(5))).toString();
		s = s1 + s2 + s3;
		return s;
	}

	public static String getCurrentDate_String(String s) {
		Calendar calendar = Calendar.getInstance();
		Date date = calendar.getTime();
		return getDate(date, s);
	}

	public static int getCurrentYear() {
		Calendar calendar = Calendar.getInstance();
		int i = calendar.get(1);
		return i;
	}

	public static String getCurrentYearMonth() {
		Calendar calendar = Calendar.getInstance();
		String s = (new Integer(calendar.get(1))).toString();
		String s1 = null;
		if (calendar.get(2) < 9)
			s1 = "0" + (new Integer(calendar.get(2) + 1)).toString();
		else
			s1 = (new Integer(calendar.get(2) + 1)).toString();
		return s + s1;
	}

	public static int getCurYearMonth() {
		Date date = new Date(System.currentTimeMillis());
		return getYearMonth(date);
	}

	public static java.sql.Date getDate() {
		return new java.sql.Date(System.currentTimeMillis());
	}

	public static java.sql.Date getSqlDate(int i, int j, int k) {
		return new java.sql.Date((new GregorianCalendar(i, j, k))
				.getTimeInMillis());
	}

	public static Date getUtilDate(int i, int j, int k) {
		return (new GregorianCalendar(i, j, k)).getTime();
	}

	public static String getDate(Date date, String s) {
		if (date == null)
			return "";
		Hashtable hashtable = new Hashtable();
		String s1 = "";
		String s2 = s.toLowerCase();
		if (s2.indexOf("yyyy") != -1)
			hashtable.put(new Integer(s2.indexOf("yyyy")), "yyyy");
		else if (s2.indexOf("yy") != -1)
			hashtable.put(new Integer(s2.indexOf("yy")), "yy");
		if (s2.indexOf("mm") != -1)
			hashtable.put(new Integer(s2.indexOf("mm")), "MM");
		if (s2.indexOf("dd") != -1)
			hashtable.put(new Integer(s2.indexOf("dd")), "dd");
		if (s2.indexOf("hh24") != -1)
			hashtable.put(new Integer(s2.indexOf("hh24")), "HH");
		if (s2.indexOf("mi") != -1)
			hashtable.put(new Integer(s2.indexOf("mi")), "mm");
		if (s2.indexOf("ss") != -1)
			hashtable.put(new Integer(s2.indexOf("ss")), "ss");
		for (int i = 0; s2.indexOf("-", i) != -1; i++) {
			i = s2.indexOf("-", i);
			hashtable.put(new Integer(i), "-");
		}

		for (int j = 0; s2.indexOf("/", j) != -1; j++) {
			j = s2.indexOf("/", j);
			hashtable.put(new Integer(j), "/");
		}

		for (int k = 0; s2.indexOf(" ", k) != -1; k++) {
			k = s2.indexOf(" ", k);
			hashtable.put(new Integer(k), " ");
		}

		for (int l = 0; s2.indexOf(":", l) != -1; l++) {
			l = s2.indexOf(":", l);
			hashtable.put(new Integer(l), ":");
		}

		if (s2.indexOf("\u5E74") != -1)
			hashtable.put(new Integer(s2.indexOf("\u5E74")), "\u5E74");
		if (s2.indexOf("\u6708") != -1)
			hashtable.put(new Integer(s2.indexOf("\u6708")), "\u6708");
		if (s2.indexOf("\u65E5") != -1)
			hashtable.put(new Integer(s2.indexOf("\u65E5")), "\u65E5");
		if (s2.indexOf("\u65F6") != -1)
			hashtable.put(new Integer(s2.indexOf("\u65F6")), "\u65F6");
		if (s2.indexOf("\u5206") != -1)
			hashtable.put(new Integer(s2.indexOf("\u5206")), "\u5206");
		if (s2.indexOf("\u79D2") != -1)
			hashtable.put(new Integer(s2.indexOf("\u79D2")), "\u79D2");
		boolean flag = false;
		while (hashtable.size() != 0) {
			Enumeration enumeration = hashtable.keys();
			int j1 = 0;
			while (enumeration.hasMoreElements()) {
				int i1 = ((Integer) enumeration.nextElement()).intValue();
				if (i1 >= j1)
					j1 = i1;
			}
			String s3 = (String) hashtable.get(new Integer(j1));
			hashtable.remove(new Integer(j1));
			s1 = s3 + s1;
		}
		SimpleDateFormat simpledateformat = new SimpleDateFormat(s1,
				new DateFormatSymbols());
		return simpledateformat.format(date);
	}

	public static Date getDateBetween(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(5, i);
		return calendar.getTime();
	}

	public static String getDateBetween_String(Date date, int i, String s) {
		Date date1 = getDateBetween(date, i);
		return getDate(date1, s);
	}

	public static java.sql.Date getDateByAge(int i) {
		Calendar calendar = Calendar.getInstance(Locale.CHINESE);
		calendar.set(calendar.get(1) - i, calendar.get(2), calendar.get(5));
		return new java.sql.Date(calendar.getTimeInMillis());
	}

	public static String getFirstDayOfNextMonth() {
		String s = getCurrentDate_String();
		return increaseYearMonth(s.substring(0, 6)) + "01";
	}

	public static String getGender(String s) {
		int i = 3;
		System.out.print(s);
		if (s.length() == 15)
			i = (new Integer(s.substring(14, 15))).intValue() % 2;
		else if (s.length() == 18) {
			int j = (new Integer(s.substring(16, 17))).intValue();
			i = j % 2;
		}
		if (i == 1)
			return "1";
		if (i == 0)
			return "2";
		else
			return "";
	}

	public static int getIntervalDay(java.sql.Date date, java.sql.Date date1) {
		long l = date.getTime();
		long l1 = date1.getTime();
		long l2 = l1 - l;
		int i = (int) l2 / 0x5265c00;
		return i;
	}

	public static int getIntervalMonth(String s, String s1) {
		int i = Integer.parseInt(s.substring(0, 4));
		int j = 0;
		if (s.substring(4, 5).equals("0"))
			j = Integer.parseInt(s.substring(5));
		j = Integer.parseInt(s.substring(4, 6));
		int k = Integer.parseInt(s1.substring(0, 4));
		int l = 0;
		if (s1.substring(4, 5).equals("0"))
			l = Integer.parseInt(s1.substring(5));
		l = Integer.parseInt(s1.substring(4, 6));
		int i1 = (k * 12 + l) - (i * 12 + j);
		return i1;
	}

	public static String getLastDay(String s) {
		String y = s.substring(0, 4);
		String m = s.substring(4, 6);

		int i = Integer.parseInt(y);
		int j = Integer.parseInt(m);
		String s1 = "";
		if (j == 2) {
			if (i % 4 == 0 && i % 100 != 0 || i % 400 == 0)
				s1 = "29";
			else
				s1 = "28";
		} else if (j == 4 || j == 6 || j == 9 || j == 11)
			s1 = "30";
		else
			s1 = "31";
		// return String.valueOf(i) + "\u5E74" + String.valueOf(j) + "\u6708" +
		// s1 + "\u65E5";

		// wxs modify 20120201 直接使用变量i,j会产生类似2012121的错误,现修改为直接使用字符串联合
		// return String.valueOf(i)+ String.valueOf(j)+s1;
		return y + m + s1;

	}

	public static String getMonthBetween(String s, String s1) {
		try {
			String s2;
			if (s.equals("") || s1.equals("") || s.length() != 6
					|| s1.length() != 6) {
				s2 = "";
			} else {
				int i = Integer.parseInt(s.substring(0, 4)) * 12
						+ Integer.parseInt(s.substring(4, 6));
				int j = Integer.parseInt(s1.substring(0, 4)) * 12
						+ Integer.parseInt(s1.substring(4, 6));
				s2 = String.valueOf(i - j);
			}
			return s2;
		} catch (Exception _ex) {
			return "0";
		}
	}

	public static String getOracleFormatDateStr(Date date) {
		return getDate(date, "YYYY-MM-DD HH24:MI:SS");
	}

	public static java.sql.Date getStepDay(java.sql.Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(6, i);
		return new java.sql.Date(calendar.getTime().getTime());
	}

	public static java.sql.Date getStepMonth(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(2, i);
		return new java.sql.Date(calendar.getTime().getTime());
	}

	public static java.sql.Date getStepYear(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(1, i);
		return new java.sql.Date(calendar.getTime().getTime());
	}

	public static String getStrDate(Date date) throws Exception {
		Date date1 = date;
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(date1);
		int i = calendar.get(1);
		if (i < 1000 || i > 9999)
			throw new Exception("\u9519\u8BEF\u7684\u5E74\uFF01");
		int j = calendar.get(2) + 1;
		String s = String.valueOf(j);
		if (j < 10)
			s = "0" + j;
		int k = calendar.get(5);
		String s1 = String.valueOf(k);
		if (k < 10)
			s1 = "0" + k;
		return i + s + s1;
	}

	public static String getCurrYearMonthDay(String s) {
		return s.substring(0, 4) + "-" + s.substring(5, 7) + "-"
				+ s.substring(8, 10);
	}

	public static String getCurYearMonthDay() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDateFormat.format(System.currentTimeMillis());
		return today;
	}

	public static String getYearAndMonth(String s) {
		if (s == null)
			return "";
		String s1 = s.trim();
		if (6 != s1.length()) {
			return s1;
		} else {
			String s2 = s1.substring(0, 4);
			String s3 = s1.substring(4);
			return s2 + s3;
			// return s2 + "\u5E74" + s3 + "\u6708";
		}
	}

	public static String getYearMonth(java.sql.Date date) {
		if (date == null) {
			return null;
		} else {
			String s = date.toString();
			return s.substring(0, 4) + "-" + s.substring(5, 7);
		}
	}

	public static int getYearMonth(Date date) {
		GregorianCalendar gregoriancalendar = new GregorianCalendar();
		gregoriancalendar.setTime(date);
		return gregoriancalendar.get(1) * 100 + gregoriancalendar.get(2);
	}

	public static String getYearMonthByMonth(String s) {
		if (s == null)
			return null;
		String s1 = s.trim();
		if (6 != s1.length()) {
			return s1;
		} else {
			String s2 = s1.substring(0, 4);
			return s2 + "\u5E74" + s + "\u6708";
		}
	}

	public static String getYearMonthReduceOneMonth(java.sql.Date date) {
		if (date == null) {
			return null;
		} else {
			String s = date.toString();
			String s1 = s.substring(0, 4) + s.substring(5, 7);
			s1 = descreaseYearMonth(s1);
			return s1.substring(0, 4) + "-" + s1.substring(4, 6);
		}
	}

	public static Date increaseMonth(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(2, i);
		return calendar.getTime();
	}

	public static Date increaseYear(Date date, int i) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(1, i);
		return calendar.getTime();
	}

	public static String increaseYearMonth(String s) {
		int i = (new Integer(s.substring(0, 4))).intValue();
		int j = (new Integer(s.substring(4, 6))).intValue();
		if (++j <= 12 && j >= 10)
			return s.substring(0, 4) + (new Integer(j)).toString();
		if (j < 10)
			return s.substring(0, 4) + "0" + (new Integer(j)).toString();
		else
			return (new Integer(i + 1)).toString() + "0"
					+ (new Integer(j - 12)).toString();
	}

	/**** 年月任意增减任意月数*********modified by zhaichunlei*******原逻辑不严谨 ********************/
	public static String increaseYearMonth(String s, int i) {
		int j = (new Integer(s.substring(0, 4))).intValue();
		int k = (new Integer(s.substring(4, 6))).intValue();
		// １。把年＊１２　＋　月，　换成月数
		int ym = j * 12 + k + i;
		// ２。月数换算成年数
		int y = ym / 12;
		// 3.取月数
		int m = ym % 12;
		// 4.计算年与月。若月＝＝０则减一年且月换成12
		y = m == 0 ? y - 1 : y;
		m = m == 0 ? 12 : m;
		// ５。月补0
		String ms = m < 10 ? "0" + m : m + "";
		String yemo = y + ms;
		return yemo;
		/*
		 * int j = (new Integer(s.substring(0, 4))).intValue(); int k = (new
		 * Integer(s.substring(4, 6))).intValue(); k += i; j += k / 13; k %= 13;
		 * if(k == 0) k = 1; if(k <= 12 && k >= 10) return j + (new
		 * Integer(k)).toString(); else return j + "0" + (new
		 * Integer(k)).toString();
		 */
	}

	public static String month2YearMonth(String s) {
		String s1 = "";
		int i = 0;
		int j = 0;
		int k = 0;
		if (s == null || "0".equals(s) || "".equals(s.trim()))
			return "0\u6708";
		i = Integer.parseInt(s);
		j = i / 12;
		k = i % 12;
		if (j > 0)
			s1 = j + "\u5E74";
		if (k > 0)
			s1 = s1 + k + "\u4E2A\u6708";
		return s1;
	}

	public static synchronized java.sql.Date stringToDate(String s) {
		SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpledateformat.parse(s, new ParsePosition(0));
		return new java.sql.Date(date.getTime());
	}

	public static Date stringToDate(String s, String s1) {
		if (s == null)
			return null;
		Hashtable hashtable = new Hashtable();
		String s2 = "";
		String s3 = s1.toLowerCase();
		if (s3.indexOf("yyyy") != -1)
			hashtable.put(new Integer(s3.indexOf("yyyy")), "yyyy");
		else if (s3.indexOf("yy") != -1)
			hashtable.put(new Integer(s3.indexOf("yy")), "yy");
		if (s3.indexOf("mm") != -1)
			hashtable.put(new Integer(s3.indexOf("mm")), "MM");
		if (s3.indexOf("dd") != -1)
			hashtable.put(new Integer(s3.indexOf("dd")), "dd");
		if (s3.indexOf("hh24") != -1)
			hashtable.put(new Integer(s3.indexOf("hh24")), "HH");
		if (s3.indexOf("mi") != -1)
			hashtable.put(new Integer(s3.indexOf("mi")), "mm");
		if (s3.indexOf("ss") != -1)
			hashtable.put(new Integer(s3.indexOf("ss")), "ss");
		for (int i = 0; s3.indexOf("-", i) != -1; i++) {
			i = s3.indexOf("-", i);
			hashtable.put(new Integer(i), "-");
		}

		for (int j = 0; s3.indexOf("/", j) != -1; j++) {
			j = s3.indexOf("/", j);
			hashtable.put(new Integer(j), "/");
		}

		for (int k = 0; s3.indexOf(" ", k) != -1; k++) {
			k = s3.indexOf(" ", k);
			hashtable.put(new Integer(k), " ");
		}

		for (int l = 0; s3.indexOf(":", l) != -1; l++) {
			l = s3.indexOf(":", l);
			hashtable.put(new Integer(l), ":");
		}

		if (s3.indexOf("\u5E74") != -1)
			hashtable.put(new Integer(s3.indexOf("\u5E74")), "\u5E74");
		if (s3.indexOf("\u6708") != -1)
			hashtable.put(new Integer(s3.indexOf("\u6708")), "\u6708");
		if (s3.indexOf("\u65E5") != -1)
			hashtable.put(new Integer(s3.indexOf("\u65E5")), "\u65E5");
		if (s3.indexOf("\u65F6") != -1)
			hashtable.put(new Integer(s3.indexOf("\u65F6")), "\u65F6");
		if (s3.indexOf("\u5206") != -1)
			hashtable.put(new Integer(s3.indexOf("\u5206")), "\u5206");
		if (s3.indexOf("\u79D2") != -1)
			hashtable.put(new Integer(s3.indexOf("\u79D2")), "\u79D2");
		boolean flag = false;
		while (hashtable.size() != 0) {
			Enumeration enumeration = hashtable.keys();
			int j1 = 0;
			while (enumeration.hasMoreElements()) {
				int i1 = ((Integer) enumeration.nextElement()).intValue();
				if (i1 >= j1)
					j1 = i1;
			}
			String s4 = (String) hashtable.get(new Integer(j1));
			hashtable.remove(new Integer(j1));
			s2 = s4 + s2;
		}
		SimpleDateFormat simpledateformat = new SimpleDateFormat(s2);
		Date date;
		try {
			date = simpledateformat.parse(s);
		} catch (Exception _ex) {
			return null;
		}
		return date;
	}

	public static Integer stringToNum(String s) {
		if (s == null || "".equals(s)) {
			return null;
		} else {
			String s1 = s.replaceAll("-", "");
			Integer integer = new Integer(Integer.parseInt(s1));
			return integer;
		}
	}

	public static java.sql.Date stringToSqlDate(String s, String s1) {
		Date date = stringToDate(s, s1);
		return new java.sql.Date(date.getTime());
	}

	public static boolean verityDate(int i, int j, int k) {
		boolean flag = false;
		if (j >= 1 && j <= 12 && k >= 1 && k <= 31)
			if (j == 4 || j == 6 || j == 9 || j == 11) {
				if (k <= 30)
					flag = true;
			} else if (j == 2) {
				if (i % 100 != 0 && i % 4 == 0 || i % 400 == 0) {
					if (k <= 29)
						flag = true;
				} else if (k <= 28)
					flag = true;
			} else {
				flag = true;
			}
		return flag;
	}

	public static boolean yearMonthGreatEqual(String s, String s1) {
		String s2 = s.substring(0, 4);
		String s3 = s1.substring(0, 4);
		String s4 = s.substring(4, 6);
		String s5 = s1.substring(4, 6);
		if (Integer.parseInt(s2) > Integer.parseInt(s3))
			return true;
		if (Integer.parseInt(s2) == Integer.parseInt(s3))
			return Integer.parseInt(s4) >= Integer.parseInt(s5);
		else
			return false;
	}

	public static boolean yearMonthGreater(String s, String s1) {
		String s2 = s.substring(0, 4);
		String s3 = s1.substring(0, 4);
		String s4 = s.substring(4, 6);
		String s5 = s1.substring(4, 6);
		if (Integer.parseInt(s2) > Integer.parseInt(s3))
			return true;
		if (Integer.parseInt(s2) == Integer.parseInt(s3))
			return Integer.parseInt(s4) > Integer.parseInt(s5);
		else
			return false;
	}

	/**
	 * 
	 * getTimeDifference的中文名称：计算两个Timestamp日期时间的时间差
	 * 
	 * getTimeDifference的概要说明：
	 * 
	 * @param formatTime1
	 * @param formatTime2
	 * @return Written by : zjf
	 * 
	 */
	public static String getTimeDifference(Timestamp formatTime1,
			Timestamp formatTime2) {
		SimpleDateFormat timeformat = new SimpleDateFormat(
				"yyyy-MM-dd,HH:mm:ss");
		long t1 = 0L;
		long t2 = 0L;
		try {
			t1 = timeformat.parse(getTimeStampNumberFormat(formatTime1))
					.getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		try {
			t2 = timeformat.parse(getTimeStampNumberFormat(formatTime2))
					.getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		// 因为t1-t2得到的是毫秒级,所以要除3600000得出小时.算天数或秒同理
		int hours = (int) ((t1 - t2) / 3600000);
		int minutes = (int) (((t1 - t2) / 1000 - hours * 3600) / 60);
		int second = (int) ((t1 - t2) / 1000 - hours * 3600 - minutes * 60);
		// return "" + hours + "小时" + minutes + "分" + second + "秒";

		int difSecond = (int) ((t1 - t2) / 1000);
		return String.valueOf(difSecond);
	}

	/**
	 * 格式化时间 Locale是设置语言敏感操作
	 * 
	 * @param formatTime
	 * @return
	 */
	public static String getTimeStampNumberFormat(Timestamp formatTime) {
		SimpleDateFormat m_format = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss",
				new Locale("zh", "cn"));
		return m_format.format(formatTime);
	}

	/**
	 * 时间差计算
	 */
	public static String costTime(long time1, long time2) {
		long sub = time1 - time2;
		// yyyy-MM-dd HH:mm:ss
		String time = "";
		// 多少小时
		long remainder = sub % (3600 * 1000);
		long result = sub / (3600 * 1000);
		if (result < 10) {
			time += "00" + result;
		} else if (result < 100) {
			time += "0" + result;
		} else {
			time += "" + result;
		}
		// 多少分钟
		sub = remainder;
		remainder = sub % (60 * 1000);
		result = sub / (60 * 1000);
		if (result < 10) {
			time += ":0" + result;
		} else {
			time += ":" + result;
		}
		// 多少秒
		sub = remainder;
		result = sub / (1000);
		if (result < 10) {
			time += ":0" + result;
		} else {
			time += ":" + result;
		}

		return time;
	}

	/**
	 * 时间差计算
	 * 
	 * @param startTime
	 *            开始时间
	 * @param minute
	 *            限制时间
	 * @return 剩余毫秒数
	 */
	public static long costTime(String startTime, String minute)
			throws ParseException {
		Date date = getDateFormat(GlobalNames.YYYY_MM_DD_HH_MM_SS).parse(
				startTime);
		long originalTimeMillis = date.getTime();
		long currentTimeMillis = System.currentTimeMillis();
		long minuteTimeMillis = Long.parseLong(minute) * 60 * 1000;

		return minuteTimeMillis - (currentTimeMillis - originalTimeMillis);
	}

	/**
	 * 时间差计算
	 * 
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @param minute
	 *            限制时间
	 * @return 剩余毫秒数
	 */
	public static long costTime(String startTime, String endTime, String minute)
			throws Exception {
		long originalTimeMillis = convertTimeMillis(startTime);
		long currentTimeMillis = convertTimeMillis(endTime);
		long minuteTimeMillis = Long.parseLong(minute) * 60 * 1000;
		return minuteTimeMillis - (currentTimeMillis - originalTimeMillis);
	}

	/**
	 * 将指定时间转换为毫秒数
	 * 
	 * @param time
	 *            指定时间
	 */
	public static long convertTimeMillis(String time) throws Exception {
		try {
			return getDateFormat(GlobalNames.YYYY_MM_DD_HH_MM_SS).parse(time)
					.getTime();
		} catch (Exception e) {
			return getDateFormat(getDefaultDateFormat()).parse(time).getTime();
		}
	}

	/**
	 * 默认日期格式
	 */
	protected static String getDefaultDateFormat() {
		return GlobalNames.YYYY_MM_DD_HH_MM;
	}

	/**
	 * 获得默认日期格式
	 */
	protected static DateFormat getDateFormat() {
		return new SimpleDateFormat(getDefaultDateFormat());
	}

	/**
	 * 获得指定日期格式
	 */
	protected static DateFormat getDateFormat(String format) {
		return new SimpleDateFormat(format);
	}

	/**
	 * 根据日期格式格式化时间
	 */
	protected static String format(String format, Date date) {
		return getDateFormat(format).format(date);
	}

	/**
	 * 将字符串日期转换成yyyyMMdd的形式，strDate格式必须"yyyy-MM-dd"。
	 * 将字符串日期转换成yyyyMM的形式，strDate格式必须"yyyy-MM"。
	 * 
	 * @param strDate
	 * @return
	 * @throws Exception
	 */
	public static Long strDateToNum(String strDate) {
		if (strDate == null) {
			return null;
		}
		String[] date = null;
		String newDate = "";
		if (strDate.indexOf("-") >= 0) {
			date = strDate.split("-");
			for (int i = 0; i < date.length; i++) {
				newDate = newDate + date[i];
			}
			return Long.parseLong(newDate);
		}

		return Long.parseLong(strDate);
	}
/**
 * 根据时间字符串返回想要的时间格式字符串
 * @param berforeDate 本身的时间格式
 * @param afterDate   要转换的时间格式
 * @param str     时间字符串
 * @return
 * @throws ParseException
 */
	public static String getDateString(String berforeDate ,String afterDate,String str) throws ParseException{
		//为空
		if(str==null || "".equals(str)){
		return "";	
		}else{
			SimpleDateFormat formatter = new SimpleDateFormat(berforeDate);
			SimpleDateFormat date = new SimpleDateFormat(afterDate);
			return date.format(formatter.parse(str));
		}
	}
	
	/**
	 * 根据时间字符串返回想要的时间格式字符串
	 * @param berforeDate 本身的时间格式
	 * @param afterDate   要转换的时间格式
	 * @param str     时间字符串
	 * @return
	 * @throws ParseException
	 */
		public static String getYear(String format ,String str) throws ParseException{
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat formatDate = new SimpleDateFormat(format);
			String currentTime = formatDate.format(calendar.getTime());
				Date today = formatDate.parse(currentTime);
				Date brithDay = formatDate.parse(str);
				int year = today.getYear() - brithDay.getYear();
				return String.valueOf(year);
		}
	
	
	public static void main(String args[]) {
		try {
			System.out.println(increaseYearMonth("201401", -1));
			System.out.println(increaseYearMonth("201401", 1));
			System.out.println(getStepMonth(getDate(), 11));
			System.out.println(getStepYear(getDate(), 2).toString());
			System.out.println(stringToNum(getBirtday("411323198112060011")));
			System.out.println(getGender("411323198112060011"));
			System.out.println(getChineseDate(getCurrentDate()));
			System.out.println(getChineseWeek());
			System.out.println(increaseYear(getDate(), -1));
		} catch (Exception exception) {
			exception.printStackTrace();
		}
	}
}
