<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>404错误</title>
<meta http-equiv="Refresh" content="3;url=<%=basePath %>index.html"/> 
<style>
body {
	margin:0 auto;padding:0;font-size:12px;text-align:center;
}
p{text-align:center;color:#d04d1f;line-height:25px;font-size:14px;}
p span{font-weight:800;font-size:18px;}
</style>
</head>
<body>
<p>
<span>亲，对不起，您访问的网页发生不可预知的问题。 </span><br/>
我们已经将此错误信息记录下来，并将尽快处理，为此造成您的不便请多见谅。<br/>
3秒后将自动跳转到网站首页,<a href="<%=basePath %>index.html" target="_self">返回首页</a>
</p>
<img src="<%=basePath %>images/404.jpg">
</body>
</html>