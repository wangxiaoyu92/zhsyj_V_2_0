<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>行政审批</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
  </head>
  
  <body>
   <script>
$(function() {
var url1 = "http://as.hda.gov.cn/"; 
//  window.location.href = url1;
window.open(url1);
});
</SCRIPT>
  </body>
<!--   <a href="http://as.hda.gov.cn/"  target="_blank">Welcome</a> -->
  
</html>
