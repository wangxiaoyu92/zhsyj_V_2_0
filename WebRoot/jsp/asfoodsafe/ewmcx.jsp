<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="head.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>二维码溯源查询</title>
  </head>
<body>
<div class="mainbody">
     <div class="query">
     <form>
     <h3>二维码溯源查询</h3>
	     <p>感谢使用，正在开发中。。。</p>
     </form>
      </div>
 </div>   
<%@ include file="footer.jsp"%>
</body>
</html>