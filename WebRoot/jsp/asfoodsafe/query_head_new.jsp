<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
String query_sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();
%>
<!-- 
<div data-role="header" data-position="fixed" data-tap-toggle="false">
 <a href="#link" data-role="button" data-icon="back" data-iconpos="notext">返回</a>
  <h1>欢迎访问郑州安盛计食品溯源</h1>
 </div>
  -->
  <!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <!--添加手机支持-->
	<meta content="initial-scale=1.0,user-scalable=yes,maximum-scale=1,minimum-scale=1,width=device-width" name="viewport"/>
	<meta content="yes" name="apple-mobile-web-app-capable"/>
	<meta content="black" name="apple-mobile-web-app-status-bar-style"/>
	<meta content="telephone=no" name="format-detection"/>
  <title>安盛追溯码查询</title> 
  <link rel="stylesheet" href="<%=basePath %>jslib/swipe/main2.css"/>  
  <link rel="stylesheet" href="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery.mobile-1.3.2.css"/>
   <!-- jQuery and jQuery Mobile -->
  <script src="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery-1.9.1.min.js"></script>
  <script src="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script> 
  
<style>
.page-swipe{background:#fff;}
.swipe {
	overflow: hidden;
	visibility: hidden;
	position: relative;
}
.swipe-wrap {
	overflow: hidden;
	position: relative;
}
.swipe-wrap > figure {
	float: left;
	width: 100%;
	position: relative;
}

 .mytable{
  width:100%;border:1px solid #ddd;border-collapse: collapse;
  }
  #tip{color:#545454;font-size:12px;}
  .mytable th{background:#fff;font-size:13px;}
  .mytable tr td{font-size:12px;background:#fff;}
  .block{border-bottom:1px solid #ddd;background:#fff;}
  .left_info{color:#808080;font-size:12px;}
  .right_info{float:right;color:#545454;font-size:12px;}
  .width4{width:25%;color:#2f3e46;font-weight:bold;background:#fff;}
  </style>