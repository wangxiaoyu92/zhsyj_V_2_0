<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>


<%String version = "20131206";%>

<%-- 引入jQuery --%>
<script src="<%=contextPath%>/jslib/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<script src="<%=contextPath %>/jslib/storage.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<script src="<%=contextPath%>/jslib/syExtJquery.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>
<%-- 引入easyui扩展--%>
<script src="<%=contextPath%>/jslib/syExtEasyUI.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>







