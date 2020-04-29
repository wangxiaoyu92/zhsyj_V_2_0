<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全溯源平台</title>
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="images/nav.css" rel="stylesheet" />
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="./js/jquery.jslides.js"></script>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
</head>
<body>
<div id="full">
	<div class="w_top">
		<img src="images/closeBtn.png" style="padding-right:6px; cursor:pointer;" onclick="javascript:closediv('full')">
	</div>
	<div class="w_tit">安盛食品安全追溯平台微信</div>
	<div class="w_pic">
		<img src="images/weixin.jpg" style=" width:124px; height:124px; padding-left:6px;">
	</div>
</div>
<!--banner 开始-->
<div id="full-screen-slider">
	<ul id="slides">
	 	<li style="background:url('images/1.jpg') no-repeat center top"></li>
	    <li style="background:url('images/2.jpg') no-repeat center top"></li>   
	    <li style="background:url('images/3.jpg') no-repeat center top"></li>
		<li style="background:url('images/4.jpg') no-repeat center top"></li>	
	    <li style="background:url('images/5.jpg') no-repeat center top"></li>
	</ul>	
</div>
<!--banner 结束 -->
<div class="mainbody">
<!--地图容器-->
<div id="mapContainer" style="margin:0 auto;border:#ccc 1px solid;width:1000px;height:350px;text-align:center;">
     &nbsp;
</div>
<script language="javascript" type="text/javascript">
	var jdzb = '113.606102';
	var wdzb = '34.800042';
	var address = "";
	var title = "安盛食品安全追溯平台服务中心";
	var icon = "images/marker_red.png";
	var content = [];
	content.push("<div style='text-align:left;'>安盛食品安全追溯平台服务中心<br/>电话：400-888-6785<br/>传真：0371-65997333<br/>地址：郑州高新区河南省国家大学科技园东区12号楼18层 </div>");         
	function initMap() { 
		mapInit("mapContainer", jdzb,wdzb, 10);
		mapObj.clearMap();  // 清除地图覆盖物
		//addMarker_tantiao(jdzb, wdzb, title, title, content,icon);	
		addMarker_tantiao_no(jdzb, wdzb, title, title, content,icon);
		//addMarker_infowindow(jdzb, wdzb, address, title, content, icon);		
	}	    
 
    $(function() {
		initMap();
	});
</script>
</div>
<%@ include file="footer.jsp"%>
</body>
</html>