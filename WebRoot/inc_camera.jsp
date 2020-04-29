<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.DateUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + DateUtil.getChineseWeek();
%>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';	
	var sy = sy || {};
	sy.basePath = '<%=basePath%>';
	sy.contextPath = '<%=contextPath%>';
</script>


<script src="<%=contextPath%>/jslib/Globals.js" type="text/javascript" charset="utf-8"></script> 
<%-- 引入jQuery --%>
<script src="<%=contextPath%>/jslib/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>

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