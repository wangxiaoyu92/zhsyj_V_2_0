<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=9,IE=10"> 
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/business.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<link href="./css/bootstrap-combined.min.css" rel="stylesheet">
<script src="./js/bootstrap-paginator.js"></script>
<link href="./css/style.css" rel="stylesheet">
<link href="./css/indexzh.css" rel="stylesheet">
<script src="./js/jquery.jslides.js"></script>
</head>
<body>
<div id="top"></div>
<!--banner 开始-->
<div id="full-screen-slider">
	<div style="position:relative;z-index:999;float:right;">
		<p><a href="<%=contextPath %>/index.jsp" target="self"><img src="images/qyrk.jpg" style="width: 175px;height: 50px;"/></a></p>
		<p><a href="<%=contextPath %>/indexAll.jsp" target="self"><img src="images/jgrk.jpg" style="width: 175px;height: 50px;"/></a></p>
		<p><a href="http://as.hda.gov.cn" target="self"><img src="images/xzsprk.jpg" style="width: 175px;height: 50px;"/></a></p>
	</div>
	<ul id="slides">
	 	<li style="background:url('images/pic07.jpg') no-repeat center top"></li>
	    <li style="background:url('images/pic08.jpg') no-repeat center top"></li>   
	    <li style="background:url('images/pic10.jpg') no-repeat center top"></li>
<!-- 		<li style="background:url('images/pic11.jpg') no-repeat center top"></li>	 -->
<!-- 	    <li style="background:url('images/pic12.jpg') no-repeat center top"></li> -->
	</ul>	
</div>
<!--banner 结束 -->

<!-- <div id="banner"> -->
<!-- 	<object width="980px" height="302px" data="images/banner3.swf"> -->
<!-- 	</object> -->
<!-- 	<div style="float: right"> -->
<!-- 		<p style="text-align:center;"><a href="<%=contextPath %>/index.jsp" target="self"><img src="images/qyrk.jpg" /></a></p> -->
<!-- 		<p style="text-align:center;"><a href="<%=contextPath %>/indexAll.jsp" target="self"><img src="images/jgrk.jpg" /></a></p> -->
<!-- 		<p style="text-align:center;"><a href="http://as.hda.gov.cn" target="self"><img src="images/xzsprk.jpg" /></a></p> -->
<!-- 	</table>  -->
<!-- </div>	 -->
<div class="container" style="width:100%;margin-top:10px;min-width:1130px;">
	<div id="content" style="display: block;">
		<div class="layout1">
			<ul>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmlsnt/tjdt_ykyzc.jsp?currlocation=绿色农产品');"><img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmlsnt.png"></a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcsc/enterprise_list.jsp?comdalei=101401&currlocation=放心菜市场');"><img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmcsc.png"></a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmspsc/enterprise_list.jsp?comdalei=101101&currlocation=透明生产');"><img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmsc.png"></a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmsplt/enterprise_list.jsp?comdalei=101302&currlocation=流通销售');"><img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmlt.png"></a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcy/enterprise_list.jsp?comdalei=101202&currlocation=透明餐饮');"><img style="height: 155px;" src="<%=contextPath %>/jsp/tmsyj/tmsyj/images/tmcy.png"></a></li>
			</ul>
			<ul>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmlsnt/tjdt_ykyzc.jsp?currlocation=绿色农产品');" style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">绿色农产品</a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcsc/enterprise_list.jsp?comdalei=101401&currlocation=放心菜市场');" style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">放心菜市场</a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmspsc/enterprise_list.jsp?comdalei=101101&currlocation=透明生产');" style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">透明生产</a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmsplt/enterprise_list.jsp?comdalei=101302&currlocation=流通销售');" style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">流通销售</a></li>
				<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/tmsyj/tmcy/enterprise_list.jsp?comdalei=101202&currlocation=透明餐饮');" style="background:#FFFFFF;font-size:20px;font-weight:bold;color:#0076c5;padding:25px;cursor:pointer;">透明餐饮</a></li>
			</ul>
		</div>
	</div>
</div>
<div id="foot"></div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
</script>		
</body>
</html>