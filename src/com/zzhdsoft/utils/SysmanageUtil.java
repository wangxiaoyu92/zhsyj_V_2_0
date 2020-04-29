package com.zzhdsoft.utils;

import com.askj.baseinfo.entity.Pflfglb;
import com.askj.zfba.entity.Zfajzfwsmbfgcs;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.cache.LeafCache;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.internal.ValidateConf;
import com.lbs.leaf.validate.internal.ValidateRule;
import com.swetake.util.Qrcode;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.IPublished;
import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.dto.ComboboxDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SyscheckDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa09;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.news.Newscate;
import com.zzhdsoft.siweb.entity.sysmanager.*;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Dao;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.Mvcs;

import javax.imageio.ImageIO;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;
import java.util.Map.Entry;
import java.util.regex.Pattern;

/**
 * 
 * SysmanageUtil的中文名称：系统常用功能操作类
 * 
 * SysmanageUtil的描述：
 * 
 * Written by : zjf
 */
public class SysmanageUtil implements IPublished {
	protected final static Logger logger = Logger.getLogger(SysmanageUtil.class);
	private static PropertiesProxy pp;
	// 代码表,缓存，为前台页面服务
	public static HashMap aa10_map;
	public static HashMap zfwsmbcs_map;// gu20160413f
	public static List<Sysuser> globalsysuser_list;//gu20170915
	public static HashMap aa13_map;
	public static String g_UseAaa027Grant;//启用行政区划限制
	public static String g_UseAae140Grant;//启用四品一械大类限制
	public static String g_UseUserOrgGrant;//启用机构限制 
	public static String g_ZFWSQZMS;//执法文书签字模式(0或空目前模式，1图片模式) 
	public static String g_ADDCOMCREATEUSER;//添加企业时是否生成用户信息0不生成1生成
	public static String g_WSPRINTTYPE;//文书打印类型0正常打印1套打
	public static String g_wheresys;//标志哪里的系统 例如 zhongmou

	public static String SYSAAA027 = "";//当前系统平台统筹区
//	public static String g_wanxiang_url="http://www.paogener.com:9095/fs-circulation/app/detailJson?";
	public static String g_wanxiang_url="http://sa.wanxiangbd.cn:8080/fs-circulation/app/detailJson?";

	//餐饮接口
//	public static String g_wanxiang_cy_url="http://www.paogener.com:9095/fs-circulation/app/detailComJson?";
	public static String g_wanxiang_cy_url="http://sa.wanxiangbd.cn:8080/fs-circulation/app/detailComJson?";

	//gu20180402begin
	//看参数LHFJNDPDDJ 9	未知
	//0	整改中
	//A	A优秀
	//B	B良好
	//C	C一般
	//1	A级风险
	//2	B级风险
	//3	C级风险
	//4	D级风险
	public static String g_lhfjndpddj_0="0";
	public static String g_lhfjndpddj_a="a";
	public static String g_lhfjndpddj_b="b";
	public static String g_lhfjndpddj_c="c";
	public static String g_lhfjndpddj_1="1";
	public static String g_lhfjndpddj_2="2";
	public static String g_lhfjndpddj_3="3";
	public static String g_lhfjndpddj_4="4";

	//public static String g_planid_foodRiskLevelConfirm="2018040315500872759514728"; //2018040315500872759514728 食品生产经营者风险等级确认表【系统内置，不要删】
	public static String g_planid_spxs_dtfxlh="2018032917155363292834815"; //食品销售环节动态风险因素量化分值表【系统内置，不要删】
	public static String g_planid_spxs_jtfxlh="2018041217155363292834818"; //食品销售企业静态风险因素量化分值表【系统内置，不要删】
	public static String g_planchecktype_fjbz="'4'"; //企业是否做过风险或量化分级标志 格式"'4','5'"; 4食品生产经营者风险等级确认表【系统内置，不要删】
	public static String g_planid_sptjj_jtfxlh="2018041217155363292834898"; //食品、食品添加剂生产者静态风险因素量化分值表【系统内置，不要删】
	public static String g_planid_spcyfw_jtfxlh="2018041412144320967916418"; //餐饮服务提供者静态风险因素量化分值表【系统内置，不要删】
	public static String g_planid_spcyfw_nddjpd="2018041418144823536038600"; //餐饮服务食品安全监督年度等级评定表【系统内置，不要删】
	public static String g_planid_spscjy_fxdjqdb="2018041513002833245981700"; //食品生产经营者风险等级确定表【系统内置，不要删】


	//gu20180402end

	private static HashMap<String,String[]> sessionContext = new HashMap<String, String[]>();

	private static HashMap<String,String[]> platformSessionContext = new HashMap<String, String[]>();
	// 数据库
	private static Dao dao;

	/**
	 * 
	 * initDAO的中文名称：初始化DAO
	 *
	 * initDAO的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	private static void initDAO() {
		if (dao == null) {
			dao = Mvcs.ctx.getDefaultIoc().get(Dao.class, "dao");
		}
		/**
		 * 局限性，沒有设置注解的不会生成，比如说索引，
		 */
		//自动建立表
//				Daos.createTablesInPackage(dao, "com.zzhdsoft.siweb.entity", false);
		//更新表字段
		//Daos.migration(dao, "com.zzhdsoft.siweb.entity", true, true);
		//	Daos.migration(dao, BsCheckMaster.class, true, false);
	}

	/**
	 * 
	 * setSysuser的中文名称：登录成功后设置登录用户信息
	 * 
	 * setSysuser的概要说明：
	 * 
	 * @param sysuser
	 *            Written by : zjf
	 * 
	 */
	public static void setSysuser(Sysuser sysuser) {
		org.nutz.mvc.Mvcs.getHttpSession().setAttribute("CURRENT_USER", sysuser);
	}

	/**
	 * 
	 * getSysuser的中文名称：获取当前登录用户信息
	 * 
	 * getSysuser的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static Sysuser getSysuser() {
		return (Sysuser) org.nutz.mvc.Mvcs.getHttpSession().getAttribute("CURRENT_USER");
	}

	/**
	 *
	 * getSysuser的中文名称：获取当前登录用户信息
	 *
	 * getSysuser的概要说明：
	 *
	 * @return Written by : zjf
	 *
	 */
	public static Sysuser getSysuser(String userid) {
		return (Sysuser) dao.fetch(Sysuser.class,userid);
	}

	/**
	 * 
	 * getSysuserOrgcode的中文名称：获取当前登录用户所属机构编码
	 * 
	 * getSysuserOrgcode的概要说明：
	 * 
	 * @param
	 * @return Written by : zjf
	 * 
	 */
	public static String getSysuserOrgcode() {
		String orgcode = "";
		Sysuser sysuser = (Sysuser) org.nutz.mvc.Mvcs.getHttpSession().getAttribute("CURRENT_USER");
		if (sysuser.getOrgid() == null) {
			throw new BusinessException("操作员所属机构id不能为空，请联系系统管理员！");
		} else {
			Sysorg se = dao.fetch(Sysorg.class, sysuser.getOrgid());
			orgcode = se.getOrgcode();
		}
		return orgcode;
	}

	/**
	 *
	 * getSysuserOrgcode的中文名称：获取当前登录用户所属机构编码
	 *
	 * getSysuserOrgcode的概要说明：
	 *
	 * @param
	 * @return Written by : zjf
	 *
	 */
	public static String getaaa102FromAaa103(String prm_aaa100,String prm_aaa103) throws Exception {
		String v_sql="select aaa102 from aa10 where aaa100='"+prm_aaa100+"' and aaa103='"+prm_aaa103+"'";
		List<Aa10> v_listaa10=(List<Aa10>)DbUtils.getDataList(v_sql,Aa10.class);
		if (v_listaa10!=null && v_listaa10.size()>0){
			Aa10 v_tempaa10=v_listaa10.get(0);
			return v_tempaa10.getAaa102();
		}

		return "";
	}

	/**
	 * 
	 * getMenuDataBySystemcode的中文名称：得到当前登录用户的权限菜单信息【菜单级】
	 * 
	 * getMenuDataBySystemcode的概要说明：根据子系统编码过滤
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getMenuDataBySystemcode(String menuData, String systemcode) {
		List retList = new ArrayList();
		List ss = Json.fromJsonAsList(Sysfunction.class, menuData);
		for (int i = 0; i < ss.size(); i++) {
			Sysfunction sysfunction = (Sysfunction) ss.get(i);
			String systemcodeStr = StringHelper.showNull2Empty(sysfunction.getSystemcode());
			if (systemcode.equals(systemcodeStr) || "".equals(systemcodeStr)) {
				retList.add(sysfunction);
			}
		}
		String menuDataBySystemcode = Json.toJson(retList);
		return menuDataBySystemcode;
	}

	/**
	 * 
	 * setMenuData的中文名称：登录成功后设置权限菜单信息【菜单级】
	 * 
	 * setMenuData的概要说明：
	 * 
	 * @param menuData
	 *            Written by : zjf
	 * 
	 */
	public static void setMenuData(String menuData) {
		org.nutz.mvc.Mvcs.getHttpSession().setAttribute("menuData", menuData);
	}

	/**
	 * 
	 * getMenuData的中文名称：得到当前登录用户的权限菜单信息【菜单级】
	 * 
	 * getMenuData的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getMenuData() {
		return (String) org.nutz.mvc.Mvcs.getHttpSession().getAttribute("menuData");
	}

	/**
	 * 
	 * setMenuDataAll的中文名称：登录成功后设置权限菜单信息【按钮级】
	 * 
	 * setMenuDataAll的概要说明：
	 * 
	 * @param menuDataAll
	 *            Written by : zjf
	 * 
	 */
	public static void setMenuDataAll(String menuDataAll) {
		org.nutz.mvc.Mvcs.getHttpSession().setAttribute("menuDataAll", menuDataAll);
	}
	
	/**
	 * 
	 * setMenuDataSysAll的中文名称：登录成功后设置权限菜单信息【按钮级】
	 * 
	 * setMenuDataSysAll的概要说明：
	 * 
	 * @param menuDataSysAll
	 * Written by : zjf
	 * 
	 */
	public static void setMenuDataSysAll(String menuDataSysAll) {
		org.nutz.mvc.Mvcs.getHttpSession().setAttribute("menuDataSysAll", menuDataSysAll);
	}	

	/**
	 * 
	 * getMenuDataAll的中文名称：得到当前登录用户的权限菜单信息【按钮级】
	 * 
	 * getMenuDataAll的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getMenuDataAll() {
		return (String) org.nutz.mvc.Mvcs.getHttpSession().getAttribute("menuDataAll");
	}
	
	/**
	 * 
	 * getMenuDataSysAll的中文名称：得到当前登录用户的权限菜单信息【按钮级】
	 * 
	 * getMenuDataSysAll的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getMenuDataSysAll() {
		return (String) org.nutz.mvc.Mvcs.getHttpSession().getAttribute("menuDataSysAll");
	}	

	/**
	 * 
	 * getAa01的中文名称：查询系统综合参数表AA01
	 * 
	 * getAa01的概要说明：
	 * 
	 * @param aaa001
	 * @return Written by : zjf
	 * 
	 */
	public static Aa01 getAa01(String aaa001) {
		String aaa001Str = aaa001.toUpperCase();
		// 查询AA01
		List<Aa01> ls = dao.query(Aa01.class, Cnd.where("aaa001", "=", aaa001Str));
		Aa01 aa01 = new Aa01();
		if (ls != null && ls.size() > 0) {
			aa01 = (Aa01) ls.get(0);
		}
		return aa01;
	}

	/**
	 * 
	 * getAa01Fdq的中文名称：查询系统综合参数表AA01分地区
	 * 
	 * getAa01Fdq的概要说明：
	 * 
	 * @param aaa001
	 * @return Written by : zjf
	 * 
	 */
	public static Aa01 getAa01Fdq(String aaa001) {
//		Sysuser v_sysuser = (Sysuser) getSysuser();

		String aaa001Str = aaa001.toUpperCase();
		// 查询AA01
		List<Aa01> ls = dao.query(Aa01.class, Cnd.where("aaa001", "=", aaa001Str));
		Aa01 aa01 = new Aa01();
		if (ls != null && ls.size() > 0) {
			aa01 = (Aa01) ls.get(0);
		}
		return aa01; // gu20160515暂时改为不分地区

		// return getAa01(aaa001);

	}

	/**
	 * 
	 * getAa10toJSON的中文名称：
	 * 
	 * getAa10toJSON的概要说明：返回一个JSON格式字符串 ，是一个MAP
	 * 
	 * @param aaa100
	 * @return Written by : zjf
	 * 
	 */
	public static String getAa10toJSON(String aaa100) {
		//gu20170520 initAa10Map();
		Map code = (Map) aa10_map.get(aaa100);
		return Json.toJson(code, JsonFormat.compact());
	}

	public static Map getAa10toMap(String aaa100) {
		String aaa100Str = aaa100.toUpperCase();
		//gu20170520 initAa10Map();
		return (Map) aa10_map.get(aaa100Str);
	}

	public static Map getAa09toMap(String aaa100) {
		String aaa100Str = aaa100.toUpperCase();
		// 查询AA09
		List<Aa09> ls09 = dao.query(Aa09.class, Cnd.where("aaa100", "=", aaa100Str));
		Iterator<Aa09> it = ls09.iterator();
		Map m = new HashMap();
		while (it.hasNext()) {
			Aa09 a1 = it.next();
			m.put(a1.getAaa100(), a1.getAaa101());
		}
		return m;
	}

	/**
	 * 
	 * initAa10Map的中文名称：初始化代码表aa10
	 * 
	 * initAa10Map的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	public static void initAa10Map() {
		//gu20170520 begin
//		if (null != aa10_map){
//			aa10_map.clear();
//			aa10_map=null;
//		}
		//gu20170520 end
		if (null == aa10_map) {
			logger.info("缓存系统代码表......");
			initDAO();
			aa10_map = new HashMap();

			// 取本地参数类型AA09
			List<Aa09> ls09 = dao.query(Aa09.class,  null);
			Iterator<Aa09> it = ls09.iterator();
			while (it.hasNext()) {
				Aa09 a = it.next();
				// 查询AA10
				List<Aa10> ls10 = dao.query(Aa10.class, Cnd.where("aaa100", "=", a.getAaa100()).and("yxbz","=","1").asc("paixu").asc("aaa102"));
//				List<Aa10> ls10 = dao.query(Aa10.class, Cnd.where("aaa100", "=", a.getAaa100()).asc("aaa104"));
				Iterator<Aa10> it2 = ls10.iterator();
				NutMap m = new NutMap();
				while (it2.hasNext()) {
					Aa10 a1 = it2.next();
					m.put(a1.getAaa102(), a1.getAaa103());
				}
				aa10_map.put(a.getAaa100(), m);
			}
		}
		
	}
	
	/**
	 * 
	 * refreshAa10MapOnekey的中文名称：初始化代码表aa10 中某个值
	 * 
	 * refreshAa10MapOnekey的概要说明：
	 * 
	 * Written by : gjf
	 * 
	 */
	public static void refreshAa10MapOnekey(String prm_aaa100) {
		aa10_map.remove(prm_aaa100);
		// 查询AA10
		List<Aa10> ls10 = dao.query(Aa10.class, Cnd.where("aaa100", "=", prm_aaa100).asc("aaa104"));
		Iterator<Aa10> it2 = ls10.iterator();
		NutMap m = new NutMap();
		while (it2.hasNext()) {
			Aa10 a1 = it2.next();
			m.put(a1.getAaa102(), a1.getAaa103());
		}
		aa10_map.put(prm_aaa100, m);
	}	

	/**
	 * 
	 * initAa13Map的中文名称：初始化统筹区表aa13
	 * 
	 * initAa13Map的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	public static void initAa13Map() {
		if (null == aa13_map) {
			logger.info("缓存统筹区表......");
			initDAO();
			aa13_map = new HashMap();

			// 查询AA13
			List<Aa13> ls13 = dao.query(Aa13.class, null);
			Iterator<Aa13> it2 = ls13.iterator();
			Map m = new TreeMap();
			while (it2.hasNext()) {
				Aa13 a1 = it2.next();
				m.put(a1.getAaa027(), a1.getAaa129());
			}
			aa13_map.put("AAA027", m);
		}

	}

	/**
	 * 
	 * getAa10toJsonArray的中文名称：参数代码表aa10转换为jsonArray
	 * 
	 * getAa10toJsonArray的概要说明: keyStr可以过滤选项
	 * [{"id":"","text":""},{"id":"","text":""},{"id":"","text":""}]
	 * 
	 * @param aaa100
	 * @return Written by : zjf
	 * 
	 */
	public static String getAa10toJsonArray(String aaa100, String keyStr) {
		//gu20170520 initAa10Map();
		NutMap hm = (NutMap) aa10_map.get(aaa100.toUpperCase());
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (!hm.isEmpty()) {
			Iterator it = hm.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();
				if (keyStr.equalsIgnoreCase(id.substring(0, 2)) && !(id.endsWith("00"))) {
					sb.append("{");
					sb.append("\"id\":\"" + id + "\",");
					sb.append("\"text\":\"" + text + "\"");
					sb.append("}");
					sb.append(",");
				}
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		return sb.toString();
	}

	/**
	 * 取出法律法规大类
	 * 
	 * @return
	 */
	public static String getFlfgDL() {
		initDAO();
		// aa10_map = new HashMap();
		Map m = new TreeMap();
		Condition cnd = Cnd.where("flfglbjb", "=", "0");
		List<Pflfglb> ls_Pflfglb = dao.query(Pflfglb.class, Cnd.where("flfglbjb", "=", "0")); // query(ComboboxBean.class,
																								// null);

		for (int i = 0; i < ls_Pflfglb.size(); i++) {
			Pflfglb a1 = (Pflfglb) ls_Pflfglb.get(i);
			m.put(a1.getFlfglbbm(), a1.getFlfglbmc());
		}

		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (!m.isEmpty()) {
			Iterator it = m.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				sb.append("{");
				sb.append("\"id\":\"" + id + "\",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}

	/**
	 * 取出法律法规小类,用于生成下拉框
	 * 
	 * @return
	 */
	public static String getFlfgXL() {
		initDAO();
		// aa10_map = new HashMap();
		Map m = new TreeMap();
		List<Pflfglb> ls_Pflfglb = dao.query(Pflfglb.class, Cnd.where("flfglbjb", "=", "1"));

		for (int i = 0; i < ls_Pflfglb.size(); i++) {
			Pflfglb a1 = (Pflfglb) ls_Pflfglb.get(i);
			m.put(a1.getFlfglbbm(), a1.getFlfglbmc());
		}

		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (!m.isEmpty()) {
			Iterator it = m.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				sb.append("{");
				sb.append("\"id\":\"" + id + "\",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}

	/**
	 * 通用取下拉列表数据
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String commonGetComboboxValue(String prm_sql) throws Exception {

		List<ComboboxDTO> ls_ComboboxDTO = (List<ComboboxDTO>) DbUtils.getDataList(prm_sql, ComboboxDTO.class);

		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (ls_ComboboxDTO != null && ls_ComboboxDTO.size() > 0) {
			for (ComboboxDTO v_combo : ls_ComboboxDTO) {
				sb.append("{");
				sb.append("\"id\":\"" + v_combo.getCodevalue() + "\",");
				sb.append("\"text\":\"" + v_combo.getCodename() + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	/**
	 * 通用取下拉列表数据
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String commonGetComboboxValueWuDakuohao(String prm_sql) throws Exception {

		List<ComboboxDTO> ls_ComboboxDTO = (List<ComboboxDTO>) DbUtils.getDataList(prm_sql, ComboboxDTO.class);

		StringBuffer sb = new StringBuffer();
//		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (ls_ComboboxDTO != null && ls_ComboboxDTO.size() > 0) {
			for (ComboboxDTO v_combo : ls_ComboboxDTO) {
				sb.append("{");
				sb.append("\"id\":\"" + v_combo.getCodevalue() + "\",");
				sb.append("\"text\":\"" + v_combo.getCodename() + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
//		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}	

	/**
	 * 获取征信项目参数编码
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getComboZxxmcsbm(String prm_systemcode) throws Exception {
		String v_sql = "select a.xmcsbm as codevalue,a.xmcsmc as codename from zxpdxmcs a where a.systemcode='"
				+ prm_systemcode + "'";
		return commonGetComboboxValue(v_sql);
	}
	
	/**
	 * 获取检验检测项目
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getComboJyjcxm() throws Exception {
		String v_sql = "select a.jcxmbh as codevalue,a.jcxmmc as codename from jyjcxm a ";
		return commonGetComboboxValue(v_sql);
	}	
	
	/**
	 * 获取日常监管中年度
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getcheckyearlist() throws Exception {
		String v_sql = "select distinct a.checkyear as codevalue,a.checkyear as codename "+
	                   " from bscheckmaster a "+
				" where length(a.checkyear)>0";
		return commonGetComboboxValue(v_sql);
	}
	
	
	/**
	 * 获取征信项目参数编码
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getAa10ComdaleiGrant(String prm_aaa100,String prm_userid) throws Exception {
		String v_sql = "select a.aaa102 as codevalue,a.aaa103 as codename from aa10 a where a.aaa100='" + 
	            prm_aaa100 + "' ";
		
		//zjf注释：手机接口无法从后台获取sysuser,所以参数userid不能去掉； 
		if("".equals(StringHelper.showNull2Empty(prm_userid))){
			Sysuser userCurrent = SysmanageUtil.getSysuser();			
			if (userCurrent!=null){
				prm_userid = SysmanageUtil.getSysuser().getUserid();
			}else{
				throw new BusinessException("根据权限查询时用户ID不能为空！");
			}
		}
		if ("1".equals(SysmanageUtil.g_UseAae140Grant)){
			v_sql+=" and exists (select 1 from sysuseraae aaa "+
		    " where aaa.aae140=a.aaa102 and aaa.userid='"+prm_userid+"') ";
		};
		
		return commonGetComboboxValue(v_sql);
	}	
	
	/**
	 * 获取征信项目参数编码
	 * 
	 * @return
	 * @throws Exception
	 */
	public static List getComxiaoleiFromComdalei(Aa10DTO dto) throws Exception {
		String v_sql = "select a.aaa102 as id,a.aaa103 as text "+
	           " from aa10 a where a.aaa100='COMXIAOLEI' and aaa104='"+
				dto.getAaa102()+"'";
		return DbUtils.getDataList(v_sql, Aa10DTO.class);
	}	

	/**
	 * 
	 * getAa10toJsonArray的中文名称：参数代码表aa10转换为jsonArray
	 * 
	 * getAa10toJsonArray的概要说明:
	 * [{"id":"","text":""},{"id":"","text":""},{"id":"","text":""}]
	 * 
	 * @param aaa100
	 * @return Written by : zjf
	 * 
	 */
	public static String getAa10toJsonArray(String aaa100) {
		//gu20170520 initAa10Map();
		Map hm = (Map) aa10_map.get(aaa100.toUpperCase());
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (!hm.isEmpty()) {
			Iterator it = hm.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				sb.append("{");
				sb.append("\"id\":\"" + id + "\",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}

	public static String getAa10toJsonArrayXz(String aaa100) {
		//gu20170520 initAa10Map();
		Map hm = (Map) aa10_map.get(aaa100.toUpperCase());
		StringBuffer sb = new StringBuffer();
		sb.append("[");

		if (!hm.isEmpty()) {
			Iterator it = hm.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				sb.append("{");
				sb.append("\"id\":\"" + id + "\",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		System.out.println(sb.toString());
		return sb.toString();
	}

	/**
	 * 
	 * getAa13toJsonArray的中文名称：aa13表转换为jsonArray
	 * 
	 * getAa13toJsonArray的概要说明：[{"id":"","text":""},{"id":"","text":""},{"id":""
	 * ,"text":""}]
	 * 
	 * @param aaa027
	 * @return Written by : zjf
	 * 
	 */
	public static String getAa13toJsonArray(String aaa027) {
		//gu20170520 initAa10Map();
		Map hm = (Map) aa13_map.get(aaa027);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		// 先默认一个空选项
		sb.append("{");
		sb.append("\"id\":" + "\"\"" + ",");
		sb.append("\"text\":\"" + "==请选择==" + "\"");
		sb.append("}");
		sb.append(",");

		if (!hm.isEmpty()) {
			Iterator it = hm.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				sb.append("{");
				sb.append("\"id\":" + id + ",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append("]");
		return sb.toString();
	}

	/**
	 * 
	 * getPager的中文名称：转化easyUI的page参数到nutz的page对象
	 * 
	 * getPager的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public static Pager getPager(PagesDTO dto) {
		if (dto == null)
			return null;
		Pager p = new Pager();
		p.setPageNumber(dto.getPage());
		p.setPageSize(dto.getRows());
		return p;
	}

	/**
	 * 
	 * setW_sysorc的中文名称：生成流程控制表w_sysorc（本系统不用）
	 * 
	 * setW_sysorc的概要说明:
	 * 
	 * @param dto
	 *            Written by : zjf
	 * 
	 */
	public static void setW_sysorc(SyscheckDTO dto) {
		StringBuffer sb = new StringBuffer();
		sb.append("【");
		sb.append("|业务类型编码：").append(dto.getAaa121());
		sb.append("|业务类型名称：").append(dto.getAaa121Name());
		sb.append("|业务日志ID：").append(dto.getAaz002());
		sb.append("|事件对象：").append(dto.getDigest());// 由用户自定义：多个对象逗号分割
		sb.append("|当事人：").append(dto.getAaz010());
		sb.append("|经办人：").append(dto.getAae011());
		sb.append("|经办时间：").append(dto.getAae036());
		sb.append("】");
		String digest = sb.toString();

		Syscheck sysorc = new Syscheck();
		sysorc.setAaa121(dto.getAaa121());
		sysorc.setAaz002(dto.getAaz002());
		sysorc.setDigest(digest);
		sysorc.setAae011(dto.getAae011());
		sysorc.setCae082(dto.getAae036());
		sysorc.setCae083(dto.getAae036());
		sysorc.setCae088(SysmanageUtil.getSysuser().getUserid().toString());
		sysorc.setCae092("0");
		sysorc.setCae093("0");
		sysorc.setCae109("0");
		sysorc.setCae101(dto.getAae002());
		sysorc.setCae110(dto.getCae110());
		sysorc.setAaz010(dto.getAaz010());
		sysorc.setAaa028(dto.getAaa028());
		dao.insert(sysorc);
	}

	/**
	 * 
	 * getBusinessYear的中文名称：获取业务年度（本系统不用）
	 * 
	 * getBusinessYear的概要说明:
	 * 
	 * @param aaa027
	 * @param aae002
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public static Integer getBusinessYear(String aaa027, Integer aae002) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT pkg_A_COMM.fun_a_getywnd('").append(aaa027)
				.append("','").append(aae002).append("') as bussinessyear FROM dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		Integer bussinessYear = Integer.valueOf((String) p.get("bussinessyear"));
		return bussinessYear;
	}

	/**
	 * 
	 * getCurrentBusinessPeriod的中文名称：获取费款所属期（本系统不用）
	 * 
	 * getCurrentBusinessPeriod的概要说明:
	 * 
	 * @param aaa027
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static Integer getCurrentBusinessPeriod(final String aaa027) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select aaa005 as aae002 from aa01 where aaa001='XTJSQ' and aaa027='")
				.append(aaa027).append("'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		Integer aae002 = Integer.valueOf((String) p.get("aae002"));
		return aae002;
	}

	/**
	 * 
	 * getSequenceL的中文名称：获取序列值（本系统不用）
	 * 
	 * getSequenceL的概要说明:
	 * 
	 * @param sequenceName
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static Long getSequenceL(final String sequenceName) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select to_char(").append(sequenceName).append(".nextval) as id from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		Long sqLong = Long.valueOf((String) p.get("id"));
		return sqLong;
	}

	/**
	 * 
	 * getDbtime的中文名称：获取数据库时间
	 * 
	 * getDbtime的概要说明:
	 * 
	 * @param prm_format
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static String getDbtime(String prm_format) throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select DATE_FORMAT(NOW(),'" + prm_format + "') as id from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		String sret = (String) p.get("id");
		return sret;
	}

	/**
	 * 
	 * getDbtime的中文名称：获取数据库时间
	 * 
	 * getDbtime的概要说明:
	 * 
	 * @param prm_format
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static Timestamp getDbtimeDate(String prm_format) throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select DATE_FORMAT(NOW(),'" + prm_format + "') as id from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map p = (Map) ls.get(0);
		String sret = (String) p.get("id");
		//SimpleDateFormat formatter = new SimpleDateFormat(prm_format);
		//Date v_a = formatter.parse(sret);
		Timestamp v_a=Timestamp.valueOf(sret);
		return v_a;
	}	
	public static String getDbtimeYmd() throws Exception {
		return getDbtime("%Y-%m-%d");
	}

	public static String getDbtimeYmdHns() throws Exception {
		return getDbtime("%Y-%m-%d %H:%i:%S");
	}
	
	public static Timestamp getDbtimeYmdHnsTimestamp() throws Exception {
		return getDbtimeDate("%Y-%m-%d %H:%i:%S");
	}	

	/**
	 * 
	 * getAverageSalary的中文名称：获取社平工资（本系统不用）
	 * 
	 * getAverageSalary的概要说明:
	 * 
	 * @param aaa027
	 * @param bussinessYear
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public static String getAverageSalary(String aaa027, Integer bussinessYear) throws Exception {
		final StringBuffer sb = new StringBuffer();
		sb.append(" select aaa015 from aa02");
		sb.append(" where 1=1 ");
		sb.append(" and aa02.aaa027 = ").append(aaa027); // 统筹区
		sb.append(" and aa02.aae001 = ").append(bussinessYear); // 年度
		sb.append(" and aa02.aae100 = '1'"); // 当前有效
		sb.append(" and aa02.aaa021 = '2'");// 工资水平发布级别：地市级
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String aaa015 = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			aaa015 = (String) p.get("aaa015");
		}
		return aaa015;
	}

	/**
	 * 
	 * execAjaxResult的中文名称：通用返回函数
	 * 
	 * execAjaxResult的概要说明：0 执行成功 -1 执行失败【失败消息放入msg中】
	 * 
	 * @param msg
	 * @return Written by : zjf
	 * 
	 */
	public static Map execAjaxResult(final String msg) {
		Map p = new HashMap();
		if (Strings.isBlank(msg)) {
			p.put("code", "0");
			p.put("msg", "");
		} else {
			p.put("code", "-1");
			p.put("msg", msg);
		}
		return p;
	}

	/**
	 * 
	 * execAjaxResult的中文名称：通用返回函数（支持前台抛出异常）
	 * 
	 * execAjaxResult的概要说明: 0 执行成功,-1 执行失败
	 * 
	 * @param p
	 * @param exception
	 * @return Written by : zjf
	 * 
	 */
	public static Map execAjaxResult(Map p, Exception exception) {
		Map map = p;
		if (map == null) {
			map = new HashMap();
		}
		if (exception == null) {
			map.put("code", "0");
			map.put("msg", "");
		} else {
			String as = "";
			if (!"com.lbs.leaf.exception.LeafException".equals(exception.getClass().getName())
					&& !"com.lbs.leaf.exception.BusinessException".equals(exception.getClass().getName())) {
				as = "业务运行时异常";
			} else {
				as = exception.getMessage();
			}

			map.put("code", "-1");
			map.put("msg", as);
		}
		System.out.println(Json.toJson(map));
		return map;
	}

	/**
	 * 
	 * checkWxsiuserSession的中文名称：检查微信登录用户的session
	 * 
	 * checkWxsiuserSession的概要说明：
	 * 
	 * Written by : zjf
	 * 
	 */
	public static String checkWxsiuserSession() {
		HttpSession session = Mvcs.getHttpSession();
		if (session == null) {
			logger.error("Session超时!");
			return "Session超时!";
		}
		// 检查用户SESSION
		Object o = session.getAttribute("Wxsi_user");
		if (o == null) {
			if (session != null) {
				session.invalidate();
			}
			return "Session失效!";
		}
		return null;
	}

	/**
	 * 
	 * getWxsiuser的中文名称：得到当前登录的weixin社保用户信息
	 * 
	 * getWxsiuser的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static Sysuser getWxsiuser() {
		HttpSession session = Mvcs.getHttpSession();
		Sysuser wxsiuser = (Sysuser) session.getAttribute("Wxsi_user");
		return wxsiuser;
	}

	/**
	 * 
	 * getNewsCatetoJsonArray的中文名称：新闻分类下拉列表
	 * 
	 * getNewsCatetoJsonArray的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static String getNewsCatetoJsonArray() {
		List<Newscate> newscateList = dao.query(Newscate.class, null);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (newscateList != null && newscateList.size() > 0) {
			for (int i = 0; i < newscateList.size(); i++) {
				Newscate newscate = (Newscate) newscateList.get(i);
				String id = newscate.getCateid().toString();
				String text = newscate.getCatename().toString();

				sb.append("{");
				sb.append("\"id\":" + id + ",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
		}
		sb.append("]");
		return sb.toString();
	}

	/**
	 * 
	 * getNewsCateOfYjyatoJsonArray的中文名称：应急预案新闻分类下拉列表
	 * 
	 * getNewsCateOfYjyatoJsonArray的概要说明：
	 * 
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public static String getNewsCateOfYjyaToJsonArray() throws Exception {
		List<Newscate> newscateList = dao.query(Newscate.class,
				Cnd.where("cateparentid", "=", "2016052509413171962672484"));

		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (newscateList != null && newscateList.size() > 0) {
			for (int i = 0; i < newscateList.size(); i++) {
				Newscate newscate = (Newscate) newscateList.get(i);
				String id = newscate.getCateid().toString();
				String text = newscate.getCatename().toString();

				sb.append("{");
				sb.append("\"id\":" + "'" + id + "'" + ",");
				sb.append("\"text\":\"" + text + "\"");
				sb.append("}");
				sb.append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
		}
		sb.append("]");
		return sb.toString();
	}

	/**
	 * 
	 * currentTime的中文名称：获得系统当前时间
	 * 
	 * currentTime的概要说明：
	 * 
	 * @return Written by : zjf
	 * 
	 */
	public static Timestamp currentTime() {
		return new Timestamp(System.currentTimeMillis());
	}

	/**
	 * 
	 * getIpAddr的中文名称：获取IP地址
	 * 
	 * getIpAddr的概要说明：
	 * 
	 * @param request
	 * @return Written by : zjf
	 * 
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("http_client_ip");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}

		// 如果是多级代理，那么取第一个ip为客户ip

		if (ip != null && ip.indexOf(",") != -1) {
			ip = ip.substring(ip.lastIndexOf(",") + 1, ip.length()).trim();
		}
		// 检查是否是IP格式，防止虚构IP，并注入数据库
		String reg = "([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";
		if (Pattern.matches(reg, ip)) {
			return ip;
		}
		return "";

	}

	/**
	 * 
	 * findFuncByUrl的中文名称：根据url请求路径获取菜单项
	 * 
	 * findFuncByUrl的概要说明:
	 * 
	 * @param url
	 * @return Written by : zjf
	 * 
	 */
	public static Sysfunction findFuncByUrl(final String url) {
		final List funList = dao.query(Sysfunction.class, Cnd.where("location", "=", url));
		Sysfunction fun = null;
		if (funList != null && funList.size() > 0) {
			fun = (Sysfunction) funList.get(0);
		} else {
			//throw new BusinessException("不存在请求路径为" + url + "的菜单权限!");
		}
		return fun;
	}

	/**
	 * 
	 * writeSysoperatelog的中文名称：记录系统操作日志(自动获得所需日志参数)
	 * 
	 * writeSysoperatelog的概要说明：
	 * 
	 * @param request
	 * @param startTime
	 * @param endTime
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public static void writeSysoperatelog(HttpServletRequest request,
										  final Timestamp startTime, final Timestamp endTime) throws Exception {
		Sysuser sysuser = getSysuser();
		String userid = "";
		if (sysuser != null) {
			userid = sysuser.getUserid();
		}

		String location = request.getServletPath();
		final Sysfunction fun = findFuncByUrl(location);
		String functionid = null;
		String moduleid = null;
		String url = null;
		String desc = null;
		if (fun != null) {
			functionid = fun.getFunctionid();
			moduleid = fun.getParent();
			url = fun.getLocation();
			desc = fun.getTitle();
		}

		final Sysoperatelog log = new Sysoperatelog();
		String operatelogid = DbUtils.getSequenceStr();
		log.setOperatelogid(operatelogid);
		log.setUserid(userid);
		log.setUserip(getIpAddr(request));
		log.setOperate(functionid);
		log.setUrl(url==null?location:url);
		log.setModule(moduleid);
		log.setDescription(desc);
		log.setStarttime(startTime);
		log.setEndtime(endTime);
		dao.insert(log);
	}

	/**
	 *
	 * writeSysoperatelog的中文名称：记录系统操作日志(自动获得所需日志参数)
	 *
	 * writeSysoperatelog的概要说明：
	 *
	 * @param request
	 * @param startTime
	 * @param endTime
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	public static void g_writeSysoperatelog(HttpServletRequest request,
											Sysoperatelog prm_sysoperatelog) throws Exception {
		Sysuser sysuser = getSysuser();
		String userid = "";
		if (sysuser != null) {
			userid = sysuser.getUserid();
		}else{
			userid = prm_sysoperatelog.getUserid();
		};

		Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
		BeanHelper.copyProperties(prm_sysoperatelog,v_newSysoperatelog);
		String v_operatelogid=DbUtils.getSequenceStr();
		v_newSysoperatelog.setUserid(userid);
		v_newSysoperatelog.setOperatelogid(v_operatelogid);
		v_newSysoperatelog.setStarttime(SysmanageUtil.currentTime());

		dao.insert(v_newSysoperatelog);
	}

	public static void doLogonLog(HttpServletRequest request, Sysuser sysuser) {
		Timestamp logontime = new Timestamp(System.currentTimeMillis());
		Syslogonlog syslogonlog = new Syslogonlog();
		syslogonlog.setLogonlogid(DbUtils.getSequenceStr());
		syslogonlog.setUserid(sysuser.getUsername());
		syslogonlog.setUserip(SysmanageUtil.getIpAddr(request));
		syslogonlog.setLogontime(logontime);
		syslogonlog.setLogonflag("");
		dao.insert(syslogonlog);		
	}

	public static void doLogoffLog(HttpServletRequest request, Sysuser sysuser) {
		Timestamp logofftime = new Timestamp(System.currentTimeMillis());
		Syslogonlog syslogonlog = dao.fetch(Syslogonlog.class, sysuser.getUserid());
		syslogonlog.setLogofftime(logofftime);
	}

	public static Integer incSessionOfOneUser(Sysuser user) {
		ServletContext application = LeafCache.getAppContext();
		String userid = PubFunc.toString(user.getUserid());
		Map userMap = (Map) application.getAttribute("usermap");
		Integer counter = null;
		if (userMap == null) {
			userMap = new HashMap();
			counter = new Integer(1);
		} else {
			counter = (Integer) userMap.get(userid);
			if (counter == null)
				counter = new Integer(0);
			counter = new Integer(counter.intValue() + 1);
		}
		userMap.put(userid, counter);
		application.setAttribute("usermap", userMap);
		return counter;
	}

	public static Integer decSessionOfOneUser(Sysuser user) {
		ServletContext application = LeafCache.getAppContext();
		String userid = PubFunc.toString(user.getUserid());
		Map userMap = (Map) application.getAttribute("usermap");
		Integer counter = null;
		if (userMap == null) {
			userMap = new HashMap();
			counter = new Integer(0);
		} else {
			counter = (Integer) userMap.get(userid);
			if (counter == null)
				counter = new Integer(1);
			if (counter.intValue() > 0)
				counter = new Integer(counter.intValue() - 1);
		}
		userMap.put(userid, counter);
		application.setAttribute("usermap", userMap);
		return counter;
	}
	
	/**
	 * 
	 * createExcelMainWorkSheet的中文名称：生成excel主worksheet
	 * 
	 * createExcelMainWorkSheet的概要说明：
	 * 
	 * @param worksheetLabel
	 * @param dtoName
	 * @param excelDataList
	 * @return Written by : zjf
	 * 
	 */
	public static ExportedExcelDataInfo createExcelMainWorkSheet(final String worksheetLabel,
			final String dtoName, List excelDataList, boolean errorMsg) {
		// 生成excel主worksheet
		final ExportedExcelDataInfo exd = new ExportedExcelDataInfo();
		final LinkedHashMap<String, String> lhm = new LinkedHashMap<String, String>();
		final ServletContext servletcontext = LeafCache.getAppContext();
		final Map configMap = (Map) servletcontext.getAttribute(GlobalNameS.VALIDATE_CONFIG);
		final ValidateRule validaterule = (ValidateRule) configMap.get(dtoName);
		final Iterator it = validaterule.getConfs().keySet().iterator();
		while (it.hasNext()) {
			final ValidateConf config = (ValidateConf) validaterule.getConfs().get(it.next());
			lhm.put(config.getPropertyName(), config.getTitle());
		}
		if (errorMsg) {
			lhm.put("message", "错误信息");
		}

		exd.setLabel(worksheetLabel);
		exd.setMap(lhm);
		exd.setData(excelDataList);
		return exd;
	}

	/**
	 * 
	 * createExcelWorkSheet的中文名称：根据代码类别名称生成代码说明（如：AAC058,身份证件类型）
	 * 
	 * createExcelWorkSheet的概要说明：生成excel参数worksheet
	 * 
	 * @param aaa100
	 * @return Written by : zjf
	 * 
	 */
	public static ExportedExcelDataInfo createExcelWorkSheet(String aaa100) {
		// 生成excel参数worksheet
		final ExportedExcelDataInfo exd = new ExportedExcelDataInfo();

		Map aa09Map = SysmanageUtil.getAa09toMap(aaa100);
		if (!aa09Map.isEmpty()) {
			Iterator it = aa09Map.entrySet().iterator();
			if (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				exd.setLabel(text);// 1.
			}
		}

		final LinkedHashMap<String, String> lhm = new LinkedHashMap<String, String>();
		lhm.put("aaa102", "代码值");
		lhm.put("aaa103", "代码名称");
		exd.setMap(lhm);// 2.

		final List<Aa10> excelDataList = new ArrayList<Aa10>();
		Map aa10Map = SysmanageUtil.getAa10toMap(aaa100);
		if (!aa10Map.isEmpty()) {
			Iterator it = aa10Map.entrySet().iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String id = entry.getKey().toString();
				String text = entry.getValue().toString();

				Aa10 aa10 = new Aa10();
				aa10.setAaa102(id);
				aa10.setAaa103(text);
				excelDataList.add(aa10);
			}
		}
		exd.setData(excelDataList);// 3.

		return exd;
	}
	
	/**
	 * 
	 * createExcelWorkSheet的中文名称：excel填写说明
	 * 
	 * createExcelWorkSheet的概要说明：excel填写说明
	 * 
	 * @param prm_lhm
	 * @return Written by : gjf
	 * 
	 */
	public static ExportedExcelDataInfo createExcelWorkSheetShuoming(LinkedHashMap<String, String> prm_lhm) {
		// 生成excel参数worksheet
		final ExportedExcelDataInfo exd = new ExportedExcelDataInfo();
		exd.setLabel("填写说明");

		exd.setMap(prm_lhm);
		return exd;
	}	
	
	/**
	 * 
	 * createExcelWorkSheetOfTcq的中文名称：根据操作员所属统筹区获取管辖统筹区代码
	 * 
	 * createExcelWorkSheetOfTcq的概要说明：生成excel参数worksheet
	 * 
	 * @param aaa027
	 * @return Written by : zy
	 * 
	 */
	public static ExportedExcelDataInfo createExcelWorkSheetOfTcq(String aaa027) {
		// 生成excel参数worksheet
		final ExportedExcelDataInfo exd = new ExportedExcelDataInfo();
        String v_aaa027=aaa027.replaceAll("0*$", "");//gu20170422
		StringBuffer sb = new StringBuffer(); 
		sb.append("select * from aa13 where aaa027 like '%").append(v_aaa027).append("%' ");
		String sql = sb.toString();
		Map map;
		try {
			map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa13.class);
			List ls = (List) map.get(GlobalNames.SI_RESULTSET);
			exd.setData(ls);// 3.
			final List<Aa13> excelDataList = new ArrayList<Aa13>();
			if (ls != null && ls.size() > 0) {
				for (int i = 0; i < ls.size(); i++) {
					Aa13 aa13temp = (Aa13) ls.get(i);
					Aa13 aa13 = new Aa13();
					aa13.setAaa027(aa13temp.getAaa027());
					aa13.setAaa129(aa13temp.getAaa129());
					excelDataList.add(aa13);
				}
			}
			exd.setData(excelDataList);// 3.
			final LinkedHashMap<String, String> lhm = new LinkedHashMap<String, String>();
			lhm.put("aaa027", "统筹区编码");
			lhm.put("aaa129", "统筹区名称");
			exd.setMap(lhm);// 2.
			exd.setLabel("统筹区编码");// 1.
		} catch (Exception e) {
			e.printStackTrace();
		}

		return exd;
	}

	/**
	 * 
	 * ggzfwsmbzFromsz的中文名称：根据文书设置更改文书模板值
	 * 
	 * ggzfwsmbzFromsz的概要说明：根据文书设置更改文书模板值
	 * 
	 * @param v_obj
	 * @return Written by : gjf
	 * 
	 */
	public static Object ggzfwsmbzFromsz(Object v_obj) {
		try {
			Class clas = Class.forName(v_obj.getClass().getName());

			if (!(clas.isInstance(v_obj))) {
				System.out.println("传入的java实例与配置的java对象类型不符！");
				return null;
			}

			String v_tablename = clas.getSimpleName().toUpperCase().toString();
			int v_dtopos = v_tablename.indexOf("DTO");
			v_tablename = v_tablename.substring(0, v_dtopos);

			Field[] fields = clas.getDeclaredFields();
			ArrayList<String> fieldsNameList = new ArrayList<String>();
			int i = 0;
			for (Field field : fields) {
				fieldsNameList.add(field.getName());
			}

			for (Field field : fields) {
				field.setAccessible(true);

				String v_fieldname = field.getName();
				String v_fieldtype = field.getType().getSimpleName();
				if ("0".equalsIgnoreCase(getZfwsmbfgcsFgbz(v_tablename, v_fieldname).toString())) {
					if ("int".equalsIgnoreCase(v_fieldtype)) {
						setBeanValue(v_obj, fields, fieldsNameList, v_fieldname, -1);
					}
					if ("long".equalsIgnoreCase(v_fieldtype)) {
						setBeanValue(v_obj, fields, fieldsNameList, v_fieldname, -1L);
					} else if ("string".equalsIgnoreCase(v_fieldtype)) {
						setBeanValue(v_obj, fields, fieldsNameList, v_fieldname, null);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return v_obj;
	};

	public static void setBeanValue(Object destObj, Field[] fields,
			ArrayList<String> fieldsNameList, String strKey, Object objValue)
			throws IllegalArgumentException, IllegalAccessException {
		int intIndex = fieldsNameList.indexOf(strKey);
		if (intIndex >= 0) {
			// fields[intIndex].setAccessible(true); // 抑制Java对修饰符的检查
			fields[intIndex].set(destObj, objValue);
		}
	}

	/**
	 * 
	 * initZfwsmbfgcsMap的中文名称：初始化代码表zfajzfwsmbfgcs执法文书模板覆盖参数
	 * 
	 * initZfwsmbfgcsMap的概要说明：
	 * 
	 * Written by : gjf
	 * 
	 * @throws Exception
	 * 
	 */
	public static void initZfwsmbfgcsMap() throws Exception {
		if (null == zfwsmbcs_map) {
			logger.info("缓存执法文书模板覆盖参数代码表......");
			initDAO();
			zfwsmbcs_map = new HashMap();

			// 取本地参数类型AA09
			String v_sql = "select distinct upper(atablename) as atablename from zfajzfwsmbfgcs";
			List<Zfajzfwsmbfgcs> v_zfajzfwsmbfgcs = (List<Zfajzfwsmbfgcs>) DbUtils.getDataList(v_sql, Zfajzfwsmbfgcs.class);
			Iterator<Zfajzfwsmbfgcs> it = v_zfajzfwsmbfgcs.iterator();
			while (it.hasNext()) {
				Zfajzfwsmbfgcs a = it.next();
				// 查询AA10
				v_sql = "select upper(acolname) as acolname,fgbz from zfajzfwsmbfgcs where upper(atablename)='"
						+ a.getAtablename().toString() + "'";
				List<Zfajzfwsmbfgcs> lszfajzfwsmbfgcs = (List<Zfajzfwsmbfgcs>) DbUtils.getDataList(v_sql, Zfajzfwsmbfgcs.class);
				Iterator<Zfajzfwsmbfgcs> it2 = lszfajzfwsmbfgcs.iterator();
				Map m = new HashMap();
				while (it2.hasNext()) {
					Zfajzfwsmbfgcs a1 = it2.next();
					m.put(a1.getAcolname(), a1.getFgbz());
				}
				zfwsmbcs_map.put(a.getAtablename(), m);
			}
		}
	}

	public static String getZfwsmbfgcsFgbz(String prm_tablename, String prm_colname) throws Exception {
		String v_ret = "0";
		initZfwsmbfgcsMap();
		Map v_colmap = null;
		v_colmap = (Map) zfwsmbcs_map.get(prm_tablename.toUpperCase());
		if (v_colmap.containsKey(prm_colname.toUpperCase())) {
			v_ret = v_colmap.get(prm_colname.toUpperCase()).toString();
		}
		return v_ret;
	}

	/**
	 * 
	 *  getSysuserAaa027的中文名称：处理操作员统筹区编码通用方法
	 *
	 *  getSysuserAaa027的概要说明：查询数据时，想查411700和他下面的行政区划如411701,411702，这时通过这个函数获取值，用like就可以了
	 *
	 *  @param prm_aaa027
	 *  @return
	 *  Written  by  : zjf
	 *
	 */
	public static String getSysuserAaa027(String prm_aaa027) {
		// 处理统筹区编码
		String aaa027 = StringHelper.showNull2Empty(prm_aaa027);
		String aae383 = "";
		if("".equals(aaa027)){
			aaa027 = SysmanageUtil.getSysuser().getAaa027();
			aae383 = SysmanageUtil.getSysuser().getAae383();
		}else{
			List<Aa13> lsAa13 = dao.query(Aa13.class, Cnd.where("aaa027", "=", aaa027));
			if(lsAa13!=null && lsAa13.size()>0){
				Aa13 aa13 = lsAa13.get(0);
				aae383 = aa13.getAae383();
			}
		}
		
		String v_ret = aaa027;
		if ("4".equals(aae383)) {
			v_ret = aaa027.substring(0, 9);
		} else if ("3".equals(aae383)) {
			v_ret = aaa027.substring(0, 6);
		} else if ("2".equals(aae383)) {
			v_ret = aaa027.substring(0, 4);
		}else if ("1".equals(aae383)) {
			v_ret = aaa027.substring(0, 2);
		}
		return v_ret;
	}

	/**
	 * 
	 * getComdm的中文名称：获取单位编码
	 * 
	 * getComdm的概要说明:
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static String getComdm() throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select fun_获取comdm() as comdm from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String sret = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			sret = (String) p.get("comdm");
		}
		return sret;
	}
	
	/**
	 * 
	 * getComUsername的中文名称：获取单位下添加的操作员
	 * 
	 * getComUsername的概要说明:
	 * 
	 * @param prm_comdm
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static String getComUsername(String prm_comdm) throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select fun_获取企业操作员编号('"+prm_comdm+"') as comdm from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String sret = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			sret = (String) p.get("comdm");
		}
		return sret;
	}	

	/**
	 * 
	 * getComdm的中文名称：获取单位编码
	 * 
	 * getComdm的概要说明:
	 * 
	 * @param prm_aaa027
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static String getYzbhFromAAA027(String prm_aaa027) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select aae007 from aa26 where aab301='" + prm_aaa027).append("'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String sret = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			sret = (String) p.get("aae007");
		}
		return sret;
	}

	/**
	 * 
	 * isExistsFuncByUrl的中文名称：检查用户是否有这个功能模块的操作权限
	 * 
	 * isExistsFuncByUrl的概要说明：
	 * 
	 * @param v_bizid
	 * @return Written by : gjf
	 * 
	 */
	public static boolean isExistsFuncByBizid(String v_bizid) {
		Sysuser sysuser = getSysuser();
		StringBuffer sbsql = new StringBuffer();
		sbsql.append(" SELECT count(a.bizid) FROM sysfunction a,sysuserrole b,sysrolefunction c ");
		sbsql.append(" WHERE a.FUNCTIONID=c.FUNCTIONID ");
		sbsql.append(" AND b.ROLEID=c.ROLEID ");
		sbsql.append(" AND b.USERID='" + sysuser.getUserid() + "' ");
		sbsql.append(" AND a.BIZID='" + v_bizid + "'");
		System.out.println("sbsql.toString()" + sbsql.toString());
		String v = DbUtils.getOneValue(dao, sbsql.toString());
		return Integer.valueOf(v).intValue() > 0;
	}

	/**
	 * 
	 * isExistsFuncByUrl的中文名称：检查用户是否有这个功能模块的操作权限
	 * 
	 * isExistsFuncByUrl的概要说明：
	 * 
	 * @param v_src
	 * @return Written by : gjf
	 * 
	 */
	public static String replaceStrChuLast(String v_src) {
		// System.out.println("v_src"+v_src);
		String v_temp = v_src.replace("\r\n", "<br/>");
		// System.out.println("v_temp"+v_temp);
		while (v_temp.length() > 5 && "<br/>".equalsIgnoreCase(v_temp.substring(v_temp.length() - 5))) {
			v_temp = v_temp.substring(0, v_temp.length() - 5);
		}
		return v_temp.trim();
	}


	
	/**
	 * 获取不同省市代码值
	 * @param aaa027 统筹区 ，aaa038 级别
	 * @return
	 */
	public  static  String getAA027Str(String aaa027,String aaa383){
		String resutl ="";
//		if ("4".equals(aaa038)) {
//			resutl = aaa027.substring(0, 9);
//		} else
		if (aaa383!=null){
			if ("2".equals(aaa383)) {//市
				resutl = aaa027.substring(0, 4);
			}else if ("1".equals(aaa383)) {//省
				resutl = aaa027.substring(0, 2);
			}else {//之外
				resutl = aaa027.substring(0, 6);
			}
		}
		return resutl;
	}
	
	/**
	 * 
	 * getComsyqylx的中文名称：获取溯源企业类型
	 * 
	 * getComsyqylx的概要说明:
	 * 
	 * @param prm_comdalei
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public static String getComsyqylx(String prm_comdalei) throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select fun_comdalei2syqylx('"+prm_comdalei+"') as comqysylx from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String sret = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			sret = (String) p.get("comqysylx");
		}
		return sret;
	}	
	
	/**
	 * 
	 * initGlobalVariable的中文名称：初始化权限控制开关
	 * 
	 * initGlobalVariable的概要说明：
	 * 
	 * Written by : zjf
	 * @throws Exception 
	 * 
	 */
	public static void initGlobalVariable() throws Exception {
		g_UseAaa027Grant="0";//启用行政区划限制
		g_UseAae140Grant="0";//启用四品一械大类限制
		g_UseUserOrgGrant="0";//启用机构限制
		g_ZFWSQZMS="0";//执法文书签字模式(0或空目前模式，1图片模式)
		g_WSPRINTTYPE="0";//
		initDAO();
		String v_sql="select a.* from aa01 a where a.aaa001 in ('UseAaa027Grant','UseAae140Grant'," +
				"'UseUserOrgGrant','ZFWSQZMS','ADDCOMCREATEUSER','SYSAAA027','WSPRINTTYPE')";
		List<Aa01> v_aa01List=DbUtils.getDataList(v_sql, Aa01.class);
		for (Aa01 v_aa01:v_aa01List){
			//System.out.println(v_aa01.getAaa001());
			if (v_aa01.getAaa001().equalsIgnoreCase("UseAaa027Grant")){
				g_UseAaa027Grant=v_aa01.getAaa005();
			}else if (v_aa01.getAaa001().equalsIgnoreCase("UseAae140Grant")){
				g_UseAae140Grant=v_aa01.getAaa005();
			}else if (v_aa01.getAaa001().equalsIgnoreCase("UseUserOrgGrant")){
				g_UseUserOrgGrant=v_aa01.getAaa005();
			}else if (v_aa01.getAaa001().equalsIgnoreCase("ZFWSQZMS")){
				g_ZFWSQZMS=v_aa01.getAaa005();
			}else if (v_aa01.getAaa001().equalsIgnoreCase("ADDCOMCREATEUSER")){
				g_ADDCOMCREATEUSER=StringHelper.strIfNull(v_aa01.getAaa005(), "0");
			}else if (v_aa01.getAaa001().equalsIgnoreCase("SYSAAA027")){
				SYSAAA027=StringHelper.strIfNull(v_aa01.getAaa005(), "");
			}else if (v_aa01.getAaa001().equalsIgnoreCase("WSPRINTTYPE")){
				g_WSPRINTTYPE=StringHelper.strIfNull(v_aa01.getAaa005(), "0");
			}
		}

		//gu20180713
		try {
			if (null == pp) {
				pp = Mvcs.ctx.getDefaultIoc().get(PropertiesProxy.class, "config");
			}

			g_wheresys = pp.get("wheresys");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}	
	
	public static String fun_getOrgCode(String prm_parentorgcode,String prm_parentorgid) throws Exception {
		StringBuffer sb = new StringBuffer();// %Y-%m-%d %H:%i:%S
		sb.append("select fun_getOrgCode('"+prm_parentorgcode+"','"+prm_parentorgid+"') as orgcode from dual");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery("sql", sql, null, null);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String sret = "";
		if (ls != null && ls.size() > 0) {
			Map p = (Map) ls.get(0);
			sret = (String) p.get("orgcode");
		}
		return sret;
	}	
	
	public static HashMap<String, String[]> getSessionContext(){
		return sessionContext;
	}
	
	/**
	 * 文件拷贝
	 * @param sourceFile
	 * @param targetFile
	 * @throws Exception
	 */
	public static void copyFile(String sourceFile, String targetFile)
			throws Exception {
		String v_temp=targetFile.substring(0, targetFile.lastIndexOf("\\"));
		File v_filedir=new File(v_temp);
		if (!v_filedir.exists()){
			v_filedir.mkdir();
		}
		FileUtil.copyFile(sourceFile, targetFile);
	}
	
	/**
	 * 
	 * createQrcode的中文名称：创建二维码
	 * 
	 * createQrcode的概要说明：
	 * @param codePath 二维码保存路径
	 * @param content 二维码内容
	 * @param logoPath 二维码logo路径
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	public static boolean createQrcode(String codePath, String content, String logoPath) throws Exception{
		Qrcode qrcode = new Qrcode();
		// 设置二维码排错率，可选L(7%)、M(15%)、Q(25%)、H(30%)，排错率越高可存储的信息越少，但对二维码清晰度的要求越小
		qrcode.setQrcodeErrorCorrect('L');
		qrcode.setQrcodeEncodeMode('B');
		// 这个值最大40，值越大可以容纳的信息越多，够用就行了
		qrcode.setQrcodeVersion(7);

		byte[] contentBytes = content.getBytes("UTF-8");
		int size = 140;
		BufferedImage bfi = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
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
		// 是否包含logo
		if (!"".equals(logoPath)) {
			// 实例化一个对象
			Image logo = ImageIO.read(new File(logoPath));
			
			int widthLogo = logo.getWidth(null)>bfi.getWidth()*2/10?(bfi.getWidth()*2/10):logo.getWidth(null);   
	        int heightLogo = logo.getHeight(null)>bfi.getHeight()*2/10?(bfi.getHeight()*2/10):logo.getWidth(null); 
	        // 将logo放于二维码中心
	        int x = (bfi.getWidth() - widthLogo) / 2;  
		    int y = (bfi.getHeight() - heightLogo) / 2;  
		    gs.drawImage(logo, x, y, widthLogo, heightLogo, null); 
		}
		gs.dispose();
		bfi.flush();
		File file = new File(codePath);
		ImageIO.write(bfi, "gif", file);
		// 创建成功
		if (file.exists()) {
			return true;
		} else {
			return false;
		} 
	};
	
	/**
	 * 
	 * initGlobalSysUserMap的中文名称：因为手机端传到后台操作员信息只有userid，想获取该操作员其他信息
	 * 不能每次都往数据库查，所以放到内存中
	 * 
	 * initGlobalSysUserMap的概要说明：
	 * 
	 * Written by : gjf 20170915
	 * @throws Exception 
	 * 
	 */
	public static void initGlobalSysUserList() throws Exception {

		if (null == globalsysuser_list) {
			logger.info("缓存系统其他表......");
			initDAO();

			//String v_sql="select a.userid,a.USERNAME,a.DESCRIPTION,a.AAZ001,a.selfcomflag "+
			String v_sql="select a.* "+
			" from sysuser a "+
			" where a.userkind not in ('6','7','8')";//6单位参保虚拟用户 7快检人员8商户
			//+" and a.userid='2017010513444494273385254' ";
			globalsysuser_list=(List<Sysuser>)DbUtils.getDataList(v_sql, Sysuser.class);
		}	
	};	
	
	public static void g_updateGlobalSysUserList(String prm_userid,String prm_kind) throws Exception{
		Sysuser v_tempuser=null;
		if ("update".equals(prm_kind) || "delete".equals(prm_kind) ){
			//先删除
			v_tempuser=g_getGlobalSysUser(prm_userid);
			if (v_tempuser!=null){
				globalsysuser_list.remove(v_tempuser);
			}
		};
		
		if ("add".equals(prm_kind) || "update".equals(prm_kind) ){
			String v_sql="select a.* "+
			" from sysuser a "+
			" where a.userkind not in ('6','7','8') and a.userid='"+
			prm_userid+"'";//6单位参保虚拟用户 7快检人员8商户
			List<Sysuser> templist=(List<Sysuser>)DbUtils.getDataList(v_sql, Sysuser.class);
			if (templist!=null && templist.size()>0){
				v_tempuser=(Sysuser)templist.get(0);
				globalsysuser_list.add(v_tempuser);	
			}
		};
	}
	
	public static Sysuser g_getGlobalSysUser(String prm_userid) throws Exception {
		Sysuser v_newsysuser=null;
		if (!StringUtils.isEmpty(prm_userid)&&globalsysuser_list!=null&&globalsysuser_list.size()>0){
			for (Sysuser tempuser:globalsysuser_list){
				if (prm_userid.equals(tempuser.getUserid())){
					v_newsysuser=tempuser;
					break;
				}
			}			
		};
		//gu20170920 找不到 从取一下
//		if (v_newsysuser==null){
//			String v_sql="select a.* "+
//			" from sysuser a "+
//			" where a.userkind not in ('6','7','8') and a.userid='"+
//			prm_userid+"'";//6单位参保虚拟用户 7快检人员8商户
//			List<Sysuser> templist=(List<Sysuser>)DbUtils.getDataList(v_sql, Sysuser.class);
//			if (templist!=null && templist.size()>0){
//				v_newsysuser=(Sysuser)templist.get(0);
//				globalsysuser_list.add(v_newsysuser);	
//				
//				globalsysuser_list.
//			}
//		}

		return v_newsysuser;
	};

	public static String getSystemYMD(){
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
		Date v_date=new Date();
		return formatter.format(v_date);
	}

	public static String getDateYMD(Date prm_date) throws Exception {
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
		return formatter.format(prm_date);
	}
	public static String getAreaName(){
		try {
			String aaa027=SysmanageUtil.getSysuser().getAaa027();
			String areaName="";
			if(StringUtils.isNotBlank(aaa027)){
				String sql="select AAA129 from aa13 where aaa027='"+aaa027+"'";
				List<Map<String,String>> list=(List)DbUtils.getDataList(sql,null);
				areaName=list.get(0).get("aaa129");
			}
			return areaName;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}

}
