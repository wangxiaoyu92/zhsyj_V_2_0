<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				 + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE HTML>
<html>
<head>
<title>食药监局综合监管信息平台</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<style>
body{background:#f5f5f5 url(images/bg.jpg) repeat-x;}
.home_page{text-align:center;margin:0 auto;padding:0;width:1000px;}
.zhpt{width:100%;font-weight:bold;font-size:40px;margin-top:35px;color:#fff;}
.menu_content ul{list-style:none;width:1000px;margin-top:45px;}
.menu_content ul li{
	border:1px solid #9c9ba0;text-align:center;background:#efefef;
	display:block;width:290px;height:100px;line-height:30px;
	float:left;margin:10px 15px;padding:5px;margin-left: 120px;
}
.menu_content ul li a{
	font-size:14px;width:290px;height:100px;display:block
}
.menu_content ul li:hover{background:#f9f94d;}
</style>
</head>
<body>
<div class="home_page">
    <br/>
	<div class="top_img">
      	<img src="images/all/logo.png">
    </div>
	<h1 class="zhpt">汤阴食药监局种养殖追溯管理系统</h1>
	<%--<div class="top_img">
      	<img src="images/indexall/top_ty.png">
    </div>--%>
	<div class="menu_content">
		<ul>
			<li><a href="index.jsp" target="_blank">
				<img src="images/indexall/zsjg.jpg"/><br/>主系统</a> </li>
			<li><a href="index.jsp?systemcode=zzzsglxt" target="_blank">
				<img src="images/indexall/zsjg.jpg"/><br/>种植追溯管理系统</a> </li>
			<li><a href="index.jsp?systemcode=yzzsglxt" target="_blank">
				<img src="images/indexall/zsjg.jpg"/><br/>养殖追溯管理系统</a> </li>
			<li><a href="index_zhsyj_ty.jsp" target="_blank">
				<img src="images/indexall/zsjg.jpg"/><br/>汤阴智慧食药监公众平台展示</a> </li>
		</ul>
  	</div>
</div>

</body>
</html>