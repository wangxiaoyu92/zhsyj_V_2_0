<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=9,IE=10">
<title>智慧食药监-公众服务平台</title>
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/jquery-1.12.0.min.js"></script>
<link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/bootstrap.min.js"></script>
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/business.js"></script>
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/common.js"></script>
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/custom.js"></script>
<link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/bootstrap-combined.min.css" rel="stylesheet">
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/bootstrap-paginator.js"></script>
<link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/style.css" rel="stylesheet">
<link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/indexzh.css" rel="stylesheet">
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/jquery.jslides.js"></script>
</head>
<body>
<div id="top"></div>
<!--banner 开始-->
<div id="full-screen-slider">
	<div style="position:relative;z-index:999;float:right;">
		<p><a href="<%=contextPath %>/index.jsp" target="_blank">
			<img src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/qyrk.jpg" style="width: 175px;height: 50px;"/></a>
		</p>
		<p><a href="<%=contextPath %>/indexAll_new.jsp" target="_blank">
			<img src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/jgrk.jpg" style="width: 175px;height: 50px;"/></a>
		</p>
		<p><a href="http://as.hda.gov.cn" target="_blank">
			<img src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/xzsprk.jpg" style="width: 175px;height: 50px;"/></a>
		</p>
	</div>
	<ul id="slides">
	 	<li style="background:url('<%=contextPath %>/jsp/tmsyj/tmsyj/images/pic07.jpg') no-repeat center top"></li>
	    <li style="background:url('<%=contextPath %>/jsp/tmsyj/tmsyj/images/pic08.jpg') no-repeat center top"></li>
	    <li style="background:url('<%=contextPath %>/jsp/tmsyj/tmsyj/images/pic10.jpg') no-repeat center top"></li>
<!-- 		<li style="background:url('<%=contextPath %>/jsp/tmsyj/tmsyj/images/pic11.jpg') no-repeat center top"></li>	 -->
<!-- 	    <li style="background:url('<%=contextPath %>/jsp/tmsyj/tmsyj/images/pic12.jpg') no-repeat center top"></li> -->
	</ul>	
</div>
<!--banner 结束 -->

<!-- <div id="banner"> -->
<!-- 	<object width="980px" height="302px" data="images/banner3.swf"> -->
<!-- 	</object> -->
<!-- 	<div style="float: right"> -->
<!-- 		<p style="text-align:center;"><a href="<%=contextPath %>/index.jsp" target="_blank">
				<img src="images/qyrk.jpg" /></a></p> -->
<!-- 		<p style="text-align:center;"><a href="<%=contextPath %>/indexAll.jsp" target="_blank">
				<img src="images/jgrk.jpg" /></a></p> -->
<!-- 		<p style="text-align:center;"><a href="http://as.hda.gov.cn" target="_blank">
				<img src="images/xzsprk.jpg" /></a></p> -->
<!-- 	</table>  -->
<!-- </div>	 -->
<div class="container" style="width:100%;margin-top:10px;min-width:1130px;">
	<div id="content" style="display: block;">
	    <div class="layout1">
	   		<ul>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmlsnt/enterprise_list.jsp?comdalei=101501&currlocation=绿色农产品');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmlsnt.png"></a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcsc/enterprise_list.jsp?comdalei=101401&currlocation=放心菜市场');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmcsc.png"></a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmspsc/enterprise_list.jsp?comdalei=101101&currlocation=透明生产');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmsc.png"></a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmsplt/enterprise_list.jsp?comdalei=101302&currlocation=流通销售');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmlt.png"></a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcy/enterprise_list.jsp?comdalei=101202&currlocation=透明餐饮');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmcy.png"></a></li>
				<%--<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmyp/enterprise_list.jsp?comdalei=102101&currlocation=透明药品');">
					<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmyp.png"></a></li> --%>
	   			<%--<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmzf/enterprise_list.jsp?currlocation=监管执法');">
	   				<img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmzf.png"></a></li>-->--%>
	   		</ul>
	   		<ul>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmlsnt/enterprise_list.jsp?comdalei=101501&currlocation=绿色农产品');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">绿色农产品</a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcsc/enterprise_list.jsp?comdalei=101401&currlocation=放心菜市场');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">放心菜市场</a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmspsc/enterprise_list.jsp?comdalei=101101&currlocation=透明生产');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">透明生产</a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmsplt/enterprise_list.jsp?comdalei=101302&currlocation=流通销售');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">流通销售</a></li>
	   			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcy/enterprise_list.jsp?comdalei=101202&currlocation=透明餐饮');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">透明餐饮</a></li>
				<%--<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmyp/enterprise_list.jsp?comdalei=102101&currlocation=透明药品');"
					style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:5px;cursor:pointer;">透明药品</a></li>--%>
	   			<%--<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmzf/enterprise_list.jsp?currlocation=监管执法');"
	   				style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:5px;cursor:pointer;">监管执法</a></li>--%>
	   		</ul>
	   	</div>
	</div>
</div>
<div id="foot"></div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	
	$(function () {
	    $('#top').load(basePath + 'jsp/tmsyj/tmsyj/template/top.html');
	    $('#foot').load(basePath + 'jsp/tmsyj/tmsyj/template/foot.html');
	});
</script>		
</body>
</html>