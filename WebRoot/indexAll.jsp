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
	display:block;width:140px;height:100px;line-height:30px;
	float:left;margin:10px 15px;padding:5px;
}
.menu_content ul li a{
	font-size:14px;width:140px;height:100px;display:block
}
.menu_content ul li:hover{background:#f9f94d;}
</style>
</head>
<body class="LoginBgStyle">
<div class="home_page">
    <br/>
<%--	<h1 class="zhpt">食药监局综合监管信息平台</h1>--%>
	<div class="top_img">
      	<img src="images/indexall/top_ty.png">
    </div>
	<div class="menu_content">
		<ul>
			<li><a href="index.jsp?systemcode=jgxt" target="_blank"><img src="images/indexall/zsjg.jpg"/><br/>食品安全监管系统</a> </li>
			<li><a href="index.jsp?systemcode=zsxt" target="_blank"><img src="images/indexall/cyfw.jpg"/><br/>食品安全追溯系统</a> </li>
			<li><a href="index.jsp?systemcode=zfbaxt" target="_blank"><img src="images/indexall/zfba.jpg"/><br/>执法办案系统</a> </li>
			<li><a href="index.jsp?systemcode=zxxt" target="_blank"><img src="images/indexall/zxgl.jpg"/><br/>食品安全诚信系统</a> </li>
			<li><a href="jsp/gzfw/index.jsp" target="_blank"><img src="images/indexall/ggfb.jpg"/><br/>食品安全公众服务系统</a> </li>
			<li><a href="index.jsp?systemcode=dzzwxt" target="_blank"><img src="images/indexall/oa.jpg"/><br/>电子政务系统</a> </li>
		  	<li><a href="index.jsp?systemcode=yjzhxt" target="_blank"><img src="images/indexall/yjzh.jpg"/><br/>应急指挥系统</a> </li>
			<li><a href="index.jsp?systemcode=jyjcxt" target="_blank"><img src="images/indexall/spsc.jpg"/><br/>食品安全检验检测系统</a> </li>
			<li><a href="index.jsp?systemcode=spjkxt" target="_blank"><img src="images/indexall/xzsp.jpg"/><br/>远程视频监控系统</a></li>
			<li><a href="index.jsp?systemcode=xxzyjsxt" target="_blank"><img src="images/indexall/zhxx.jpg"/><br/>大数据分析系统</a> </li>
		</ul>
  	</div>
</div>
</body>
</html>