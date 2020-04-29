<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> <!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <title>安盛科技免费WIFI</title>   
  <link rel="stylesheet" href="jquery.mobile-1.3.2/jquery.mobile-1.3.2.css"/>
   <!-- jQuery and jQuery Mobile -->
  <script src="jquery.mobile-1.3.2/jquery-1.9.1.min.js"></script>
  <script src="jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script> 
  </head>
<body>
<div data-role="page" id="page1">
<!-- 
<div data-theme="b" data-role="header" data-position="fixed">
        <h3>安盛科技免费WIFI</h3>
    </div>
  -->   
	<div role="main" class="ui-content"> 
       <div data-role="content">
		  <ul data-role="listview"  data-inset="true">
		    <li><a href="#">名称：askj000   密码：askj8888</a></li>
		    <li><a href="#">名称：askj001   密码：askj8888</a></li>
		    <li><a href="#">名称：askj002   密码：askj8888</a></li>
		  </ul>
		</div>
	</div>
	 
<%@ include file="query_footer.jsp"%>
</body>
</html>