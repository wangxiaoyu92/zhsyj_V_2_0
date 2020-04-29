<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
String contextPath = request.getContextPath();
String basePath = GlobalConfig.getAppConfig("apppath");
if (null==basePath || "".equals(basePath)){
	 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
}

%>
