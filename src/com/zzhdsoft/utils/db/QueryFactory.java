package com.zzhdsoft.utils.db;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;

import org.apache.commons.beanutils.PropertyUtils;

import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.StringHelper;

import java.sql.Types;

/**
 * 
 * QueryFactory的中文名称：组装处理SQL语句工具类
 * 
 * QueryFactory的描述：
 * 
 * Written by : zjf
 */
public class QueryFactory {
	/**
	 * 
	 * getSQL的中文名称：构造sql语句(不分页)
	 * 
	 * getSQL的概要说明:
	 * 
	 * @param sql
	 * @param paraName
	 * @param ParaType
	 * @param obj
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	public static synchronized String getSQL(String sql, String paraName[],
			int ParaType[], Object obj) throws Exception {
		if (paraName.length != ParaType.length) {
			throw new Exception("参数与类型个数不匹配!");
		}
		sql = StringHelper.dealOrderBy(sql);
		String s1 = "";
		if (sql.indexOf(GlobalNames.ORDER_BY) > -1) {
			s1 = sql.substring(sql.lastIndexOf(GlobalNames.ORDER_BY));
			sql = sql.substring(0, sql.lastIndexOf(GlobalNames.ORDER_BY));
		}
		String pn[] = NoNullvalueParamName(obj, paraName);
		int atype1[] = NoNullvalueParamType(pn, paraName, ParaType);
		String s2 = replaceNull(sql, obj, paraName);
		String as2[] = getParamValue(s2, obj, pn, atype1);
		String s3 = fillValue(s2, pn, as2);

		return s3 + " " + s1;
	}

	/**
	 * 
	 * getSQL的中文名称：构造sql语句（支持分页）
	 * 
	 * getSQL的概要说明:
	 * 
	 * @param sql
	 * @param paraName
	 * @param ParaType
	 * @param obj
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	public static synchronized String getSQL(String sql, String paraName[],
			int ParaType[], Object obj, int pageNum, int pageSize)
			throws Exception {
		String s3 = getSQL(sql, paraName, ParaType, obj);

		if (pageNum > 0 && pageSize > 0) {// 有分页需求
			String ls_sql = DbUtils.packageSql(pageNum, pageSize, s3);
			return ls_sql;
		}
		return s3;
	}

	/**
	 *
	 * getSQL的中文名称：构造sql语句（不分页，支持easyui datagrid排序）
	 *
	 * getSQL的概要说明:
	 *
	 * @param sql
	 * @param paraName
	 * @param ParaType
	 * @param obj
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	public static synchronized String getSQL(String sql, String paraName[],
			int ParaType[], Object obj, PagesDTO pd) throws Exception {
		if (paraName.length != ParaType.length) {
			throw new Exception("参数与类型个数不匹配!");
		}
		sql = StringHelper.dealOrderBy(sql);
		String s1 = "";
		if (sql.indexOf(GlobalNames.ORDER_BY) > -1) {
			s1 = sql.substring(sql.lastIndexOf(GlobalNames.ORDER_BY));
			sql = sql.substring(0, sql.lastIndexOf(GlobalNames.ORDER_BY));
		}
		String pn[] = NoNullvalueParamName(obj, paraName);
		int atype1[] = NoNullvalueParamType(pn, paraName, ParaType);
		String s2 = replaceNull(sql, obj, paraName);
		String as2[] = getParamValue(s2, obj, pn, atype1);
		String s3 = fillValue(s2, pn, as2);

		// 适用于easyui datagrid排序
		String sort = pd.getSort();
		String order = pd.getOrder();
		if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
			return s3 + " order by " + sort + " " + order + " ";// 添加排序信息
		} else {
			return s3 + " " + s1;
		}
	}

	/**
	 * 
	 * NoNullvalueParamName的中文名称：筛选非空值参数名
	 * 
	 * NoNullvalueParamName的概要说明:
	 * 
	 * @param obj
	 * @param paraName
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	private static String[] NoNullvalueParamName(Object obj, String paraName[])
			throws Exception {
		ArrayList ArrayList = new ArrayList();
		if (paraName == null)
			return null;
		for (int i = 0; i < paraName.length; i++) {
			String s = paraName[i];
			if (!"".equals(getPropertyVal(obj, s, i)))
				ArrayList.add(s);
		}

		String as1[] = new String[ArrayList.size()];
		ArrayList.toArray(as1);
		return as1;
	}

	/**
	 * 
	 * NoNullvalueParamType的中文名称：筛选非空值参数类型
	 * 
	 * NoNullvalueParamType的概要说明:
	 * 
	 * @param as
	 * @param as1
	 * @param atype
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	private static int[] NoNullvalueParamType(String as[], String as1[],
			int atype[]) throws Exception {
		ArrayList al = new ArrayList();
		if (as1 == null)
			return null;
		for (int i = 0; i < as.length; i++) {
			String s = as[i];
			for (int j = 0; j < as1.length; j++) {
				if (!s.equals(as1[j]))
					continue;
				al.add(String.valueOf(atype[j]));
				break;
			}

		}

		int atype1[] = new int[al.size()];
		Iterator it = al.iterator();
		int i = 0;
		while (it.hasNext()) {
			atype1[i++] = Integer.valueOf((String) it.next()).intValue();
		}

		return atype1;
	}

	private static Object[] getParamValue_old(String s, Object obj,
			String as[], int atype[]) throws Exception {
		ArrayList ArrayList = new ArrayList();
		if (as == null)
			return null;
		for (int i = 0; i < as.length; i++) {
			String s1 = as[i];
			int type = atype[i];
			Object obj1 = getPropertyVal(obj, s1, i);
			if (Types.VARCHAR == type) {
				StringBuffer stringbuffer = new StringBuffer((String) obj1);
				String s2 = "like\\s*:" + s1 + "(\\s*[+]+\\s*['%']+)+";
				String s3 = "like\\s*(['%']+\\s*[+]+\\s*)+:" + s1;
				String s4 = "like\\s*:" + s1;
				if (StringHelper.exist(s2, s)) {
					stringbuffer.insert(0, "").append("%");
					ArrayList.add(stringbuffer.toString());
				} else if (StringHelper.exist(s3, s)) {
					stringbuffer.insert(0, "%").append("");
					ArrayList.add(stringbuffer.toString());
				} else if (StringHelper.exist(s4, s)) {
					if (StringHelper.exist("%", stringbuffer.toString())) {
						ArrayList.add(stringbuffer.toString());
					} else {
						stringbuffer.insert(0, "%").append("%");
						ArrayList.add(stringbuffer.toString());
					}
				} else {
					stringbuffer.insert(0, "").append("");
					ArrayList.add(stringbuffer.toString());
				}
			} else {
				ArrayList.add(obj1);
			}
		}

		return ArrayList.toArray();
	}

	/**
	 * 
	 * getParamValue的中文名称：获取非空参数值
	 * 
	 * getParamValue的概要说明:
	 * 
	 * @param s
	 * @param obj
	 * @param as
	 * @param atype
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	private static String[] getParamValue(String s, Object obj, String as[],
			int atype[]) throws Exception {
		ArrayList ArrayList = new ArrayList();
		if (as == null)
			return null;
		for (int i = 0; i < as.length; i++) {
			String s1 = as[i];
			int type = atype[i];
			Object obj1 = getPropertyVal(obj, s1, i);
			if (Types.VARCHAR == type) {
				StringBuffer stringbuffer = new StringBuffer((String) obj1);
				String s2 = "like\\s*:" + s1 + "(\\s*[+]+\\s*['%']+)+";
				String s3 = "like\\s*(['%']+\\s*[+]+\\s*)+:" + s1;
				String s4 = "like\\s*:" + s1;
				if (StringHelper.exist(s2, s)) {
					stringbuffer.insert(0, "'").append("%'");
					ArrayList.add(stringbuffer.toString());
				} else if (StringHelper.exist(s3, s)) {
					stringbuffer.insert(0, "'%").append("'");
					ArrayList.add(stringbuffer.toString());
				} else if (StringHelper.exist(s4, s)) {
					if (StringHelper.exist("%", stringbuffer.toString())) {
						stringbuffer.insert(0, "'").append("'");
						ArrayList.add(stringbuffer.toString());
					} else {
						stringbuffer.insert(0, "'%").append("%'");
						ArrayList.add(stringbuffer.toString());
					}
				} else {
					stringbuffer.insert(0, "'").append("'");
					ArrayList.add(stringbuffer.toString());
				}
			} else if (Types.DATE == type) {
				StringBuffer stringbuffer1 = new StringBuffer("to_date('");
				stringbuffer1.append(DateUtil.dateToString(new Date(
						((java.sql.Date) obj1).getTime()), "YYYY-MM-DD"));
				stringbuffer1.append("','YYYY-MM-DD')");
				ArrayList.add(i, stringbuffer1.toString());
			} else if (Types.TIMESTAMP == type) {
				StringBuffer stringbuffer1 = new StringBuffer("to_date('");
				stringbuffer1.append(DateUtil.dateToString(new Date(
						((java.sql.Date) obj1).getTime()),
						"YYYY-MM-DD HH24:mi:ss"));
				stringbuffer1.append("','YYYY-MM-DD HH24:mi:ss')");
				ArrayList.add(i, stringbuffer1.toString());
			} else {
				ArrayList.add(obj1.toString());
			}
		}

		String as1[] = new String[ArrayList.size()];
		ArrayList.toArray(as1);
		return as1;
	}

	/**
	 * 
	 * fillValue的中文名称：填充非空参数值
	 * 
	 * fillValue的概要说明:
	 * 
	 * @param s
	 * @param as
	 * @param as1
	 * @return
	 * @throws Exception
	 *             Written by : wxs
	 * 
	 */
	private static String fillValue(String s, String as[], String as1[])
			throws Exception {
		Object obj = null;
		Object obj1 = null;
		String s3 = s;
		for (int i = 0; i < as.length; i++) {
			String s1 = as[i];
			String s2 = as1[i];
			try {
				s3 = StringHelper.regexReplace("(['%']+\\s*[+]+\\s*)?:" + s1
						+ "(\\s*[+]+\\s*['%']+)?", s2, s3);
			} catch (Exception exception) {
				exception.printStackTrace();
				throw new Exception(exception);
			}
		}

		return s3;
	}

	/**
	 * 
	 * replaceNull的中文名称：筛选非空值的查询条件
	 * 
	 * replaceNull的概要说明:
	 * 
	 * @param s
	 * @param obj
	 * @param as
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	private static String replaceNull(String s, Object obj, String as[])
			throws Exception {
		String s1 = s;
		if (as == null)
			return s;
		for (int i = 0; i < as.length; i++) {
			String s2 = as[i];
			String s3 = "[(]?([a-zA-Z]+[[_]*[a-zA-Z0-9]*]*)[.]?"
					+ "([a-zA-Z]+[[_]*[a-zA-Z0-9]*]*)"
					+ "\\s*(([L,l][I,i][K,k][E,e])|=|(>)|(<)|(>=)|(<=)|(!=))\\s*:"
					+ s2 + "[)]?" + "\\s*(([A,a][N,n][D,d])|([O,o][R,r]))?\\s*";
			if ("".equals(getPropertyVal(obj, s2, i))){
				s1 = StringHelper.regexReplace(s3, "", s1);
			}
		}

		s1 = s1
				.replaceFirst(
						"(\\s+(([W,w][H,h][E,e][R,r][E,e])|([A,a][N,n][D,d])|([O,o][R,r]))\\s*)+\\z",
						"");

		return s1;
	}

	/**
	 * 
	 * @Enclosing_Method : getPropertyVal
	 * @Written by : WangXueShu
	 * @Creation Date : 2013-11-27 下午02:32:34
	 * @version : v1.00
	 * @Description : 得到属性值
	 * 
	 * @param obj
	 * @param s
	 * @param i
	 * @return
	 * @throws Exception
	 * 
	 */
	private static Object getPropertyVal(Object obj, String s, int i)
			throws Exception {
		Object obj1 = null;
		try {
			if (obj instanceof Object[])
				obj1 = ((Object[]) obj)[i];
			else
				obj1 = PropertyUtils.getProperty(obj, s);
		} catch (NoSuchMethodException nosuchmethodexception) {
			throw new Exception(nosuchmethodexception);
		} catch (InvocationTargetException invocationtargetexception) {
			throw new Exception(invocationtargetexception);
		} catch (IllegalAccessException illegalaccessexception) {
			throw new Exception(illegalaccessexception);
		}
		if (obj1 == null)
			obj1 = "";
		return obj1;
	}

	/**
	 * 
	 * @Enclosing_Method : getParamMap
	 * @Written by : WangXueShu
	 * @Creation Date : 2013-12-27 下午03:24:09
	 * @version : v1.00
	 * @Description : 组合生成参数MAP
	 * 
	 * @param name
	 * @param val
	 * @return
	 * 
	 */
	public static LinkedHashMap getParamMap(ArrayList name, ArrayList val) {
		LinkedHashMap mp = new LinkedHashMap();
		Iterator it = name.iterator();
		Iterator it2 = val.iterator();
		while (it.hasNext()) {
			if (val.size() >= name.size()) {
				mp.put(it.next(), it2.next());
			}
		}
		return mp;
	}

	protected QueryFactory() {
	}

	static final String baseExp = "\\s*(([L,l][I,i][K,k][E,e])|=|(>)|(<)|(>=)|(<=)|(!=))\\s*:";
	static final String baseAnd = "\\s*(([A,a][N,n][D,d])|([O,o][R,r]))?\\s*";
}
