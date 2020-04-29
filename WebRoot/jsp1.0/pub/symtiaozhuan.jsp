<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	String v_symurl = StringHelper.showNull2Empty(request.getAttribute("symurl"));  //选项
%>

<html>
<head>
<meta http-equiv="refresh" content="0;url=<%=v_symurl %>">

</head>
<body>
</body>

</html>
