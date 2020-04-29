<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String menuData = (String)SysmanageUtil.getMenuData();		
	String menuDataAll = (String)SysmanageUtil.getMenuDataAll();		
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_now = new Date().toLocaleString();
	if(sysuser!=null){
		ls_userid = StringHelper.showNull2Empty(sysuser.getUserid());
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
		ls_description = StringHelper.showNull2Empty(sysuser.getDescription());
		ls_userkind = StringHelper.showNull2Empty(sysuser.getUserkind());	  	  
	}

	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + DateUtil.getChineseWeek();
%>
<%
	Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
	Cookie[] cookies = request.getCookies();
	if (null != cookies) {
		for (Cookie cookie : cookies) {
			cookieMap.put(cookie.getName(), cookie);
		}
	}
	
	String easyuiTheme = "metro-blue";//如果用户未选择样式，那么初始化一个默认样式。
	if (cookieMap.containsKey("easyuiTheme")) {
		Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
		easyuiTheme = cookie.getValue();
	}
	
	
	//String easyuiMenu = "tree";//如果用户未选择菜单风格，那么初始化一个默认风格。
	String easyuiMenu = "accordion";//如果用户未选择菜单风格，那么初始化一个默认风格。
	if (cookieMap.containsKey("easyuiMenu")) {
		Cookie cookie = (Cookie) cookieMap.get("easyuiMenu");
		easyuiMenu = cookie.getValue();
	}
%>
<%String version = "20131206";%>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var easyuiTheme = '<%=easyuiTheme%>';
	var easyuiMenu = '<%=easyuiMenu%>';
	
	var sy = sy || {};
	sy.basePath = '<%=basePath%>';
	sy.contextPath = '<%=contextPath%>';
	sy.version = '<%=version%>';
	sy.pixel_0 = '<%=contextPath%>/style/images/pixel_0.gif';//0像素的背景，一般用于占位

	var menus = <%=menuData%>;//<!-- 菜单权限数据【菜单级】 -->	
	var menusAll = <%=menuDataAll%>;//<!-- 菜单权限数据【按钮级】 -->	
</script>

<%-- 引入hdsiweb样式 --%>
<link rel="stylesheet" href="<%=contextPath%>/css/default.css?version=<%=version%>" type="text/css">
<link rel="stylesheet" href="<%=contextPath%>/css/style.css?version=<%=version%>" type="text/css">
<script src="<%=contextPath%>/pages.js/common/error.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/Globals.js" type="text/javascript" charset="utf-8"></script> 
<script src="<%=contextPath%>/jslib/quanju.js" type="text/javascript" charset="utf-8"></script> 

<%-- 引入jQuery --%>
<script src="http://libs.baidu.com/jquery/1.8.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<%-- 引入EasyUI --%>
<link id="easyuiTheme" rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.3.4/themes/<%=easyuiTheme%>/easyui.css" type="text/css">
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.3.4/themes/icon.css" type="text/css"> 
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<%-- 引入扩展图标 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/syExtIcon.css?version=<%=version%>" type="text/css">
<%-- 引入自定义样式 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/syExtCss.css?version=<%=version%>" type="text/css">
<%-- 引入jquery扩展 --%>
<script src="<%=contextPath%>/jslib/syExtJquery.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>
<%-- 引入easyui扩展--%>
<script src="<%=contextPath%>/jslib/syExtEasyUI.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/syExtLayUI.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>
<%-- 引入javascript扩展 --%>
<script src="<%=contextPath%>/jslib/syExtJavascript.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>
<%-- 引入jqueryEasyui扩展 --%>
<script src="<%=contextPath%>/jslib/release/jquery.jdirk.min.js" type="text/javascript" charset="utf-8"></script>

<%-- easyui portal插件 --%> 
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-portal/portal.css" type="text/css"></link>
<script src="<%=contextPath%>/jslib/jquery-easyui-portal/jquery.portal.js" type="text/javascript" charset="utf-8"></script>

<%-- 引入my97日期时间控件 --%>
<script src="<%=contextPath%>/jslib/My97DatePicker4.8Beta3/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>

<%-- 引入jQueryValidationEngine插件 --%>
<link rel="stylesheet" href="<%=contextPath%>/jslib/jQueryValidationEngine/css/validationEngine.jquery.css">
<script src="<%=contextPath%>/jslib/jQueryValidationEngine/js/jquery.validationEngine-zh_CN.js"></script>
<script src="<%=contextPath%>/jslib/jQueryValidationEngine/js/jquery.validationEngine.js"></script>

<%-- 引入layui --%>
<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/layui-v2.2.5/css/layui.css" media="all" />
<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/kit_admin/plugins/font-awesome/css/font-awesome.min.css" media="all" />
<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/kit_admin/build/css/alibaba_iconfont.css" media="all" />
<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/kit_admin/build/css/app.css" media="all" />
<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/kit_admin/build/css/themes/default.css" media="all" id="skin" kit-skin />
<script src="<%=contextPath%>/jslib/plib/layui-v2.2.5/layui.js" charset="utf-8"></script>

<%-- 按钮权限过滤 --%>
<%--<script src="<%=contextPath %>/jslib/right.js" type="text/javascript" charset="utf-8"></script>--%>

<%-- flowplayer --%>
<%--<script src="<%=contextPath %>/jslib/flowplayer/flowplayer-3.2.11.min.js" type="text/javascript" charset="utf-8"></script>--%>
