<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String clcph = StringHelper.showNull2Empty(request.getParameter("clcph"));
%>
<!DOCTYPE html>
<html>
<head>
<title>平台接口文档</title>
	<script src="<%=contextPath%>/jslib/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
	<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=contextPath%>/jslib/bootstrap-3.3.5/css/bootstrap.min.css" type="text/css">

	<script type="text/javascript" src="<%=contextPath%>/jslib/bootstrap-3.3.5/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#all").click(function(){
				if($(".list-group .collapse").size()==0){

					$(".in").each(function(){
						$(this).toggleClass("list-group collapse");
					});
				}else{
					$(".list-group .collapse").each(function(){
						$(this).toggleClass("in");
					});
				}

			});
			$("[data-toggle=collapse]").each(function(){
				$(this).click(function(){
					$(this).next().toggleClass("in");
				})
			});

		});
	</script>
	<style type="text/css">
		.title{
			width: 100%;
			text-align: left;
		}
	</style>
</head>
<body>
	<div class="alert btn-primary" role="alert" id="all"><center>安盛科技食药监综合平台对外接口文档v1.0.0</center></div>
	<div style="width: 100%;height: 900px;">
		<ul class="list-group">
			${doc}
		</ul>
	</div>
</body>
</html>