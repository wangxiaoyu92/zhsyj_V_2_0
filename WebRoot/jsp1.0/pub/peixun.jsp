<%@page import="com.zzhdsoft.siweb.dto.news.NewsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,com.zzhdsoft.siweb.entity.Fj,java.util.*" %>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
	// 产品信息
	//News news = request.getAttribute("news")==null?null:(News)request.getAttribute("news");
%>
<!DOCTYPE html>
<html data-dpr="1" style="font-size: 54px;">
<head>
<meta name="viewport" content="initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=yes"> 
<title>溯源信息</title>
<link rel="stylesheet" href="<%=contextPath%>/jsp/pub/spsy/css/index.css">
<script src="<%=contextPath%>/jsp/pub/spsy/js/flexible.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/jquery-1.11.3.min.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/openimg.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/pinchzoom.min.js"></script>
</head>
<body style="font-size: 12px;">
    	    	<div class="about_nr clearfix">
    		${courseware.wareDes}
    	</div>
</body>
</html>
