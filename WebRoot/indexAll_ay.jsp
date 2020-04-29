<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
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
	float:left;margin:10px 15px;padding:5px;
}
.menu_content ul li a{
	font-size:14px;width:290px;height:100px;display:block
}
.menu_content ul li:hover{background:#f9f94d;}
</style>
</head>
<body class="LoginBgStyle">
<div class="home_page">
    <br/>
<%--	<h1 class="zhpt">食药监局综合监管信息平台</h1>--%>
	<div class="top_img">
      	<img src="images/indexall/top_anyang.png">
    </div>
	<div class="menu_content">
		<ul>
			<li><a href="index.jsp?systemcode=zxxt" target="_blank"><img src="images/indexall/zxgl.jpg"/><br/>食品安全信用档案管理系统</a> </li>
			<li><a href="index.jsp?systemcode=jgxt" target="_blank"><img src="images/indexall/zsjg.jpg"/><br/>网格化监管系统系统</a> </li>
			<li><a href="index.jsp?systemcode=jgxt" target="_blank"><img src="images/indexall/zsjg.jpg"/><br/>日常监管市级平台</a> </li>
			<li><a href="index.jsp?systemcode=zfbaxt" target="_blank"><img src="images/indexall/zfba.jpg"/><br/>执法办案市级平台</a> </li>

			<%--<li><a href="jsp/gzfw/index.jsp" target="_blank"><img src="images/indexall/ggfb.jpg"/><br/>食品安全公众服务系统</a> </li>--%>
		  	<li><a href="index.jsp?systemcode=yjzhxt" target="_blank"><img src="images/indexall/yjzh.jpg"/><br/>食品安全视频会商系统</a> </li>
			<li><a href="index.jsp?systemcode=xxzyjsxt" target="_blank"><img src="images/indexall/spsc.jpg"/><br/>内容发布与科普宣传系统</a> </li>

		</ul>
  	</div>
</div>
</body>
</html>