<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01,com.zzhdsoft.utils.SysmanageUtil"%>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	String v_sym = StringHelper.showNull2Empty(request.getParameter("sym"));  //选项
	Aa01 v_aa01=SysmanageUtil.getAa01("SYMQZ");
	String v_symqz=v_aa01.getAaa005();
	String v_symurl = v_symqz+v_sym;  //选项
	System.out.println("v_symurl "+v_sym);
%>

<html>
<head>
<meta http-equiv="refresh" content="0;url=<%=v_symurl %>">

</head>
<body>
</body>

</html>
