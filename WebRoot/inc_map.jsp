<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>

<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>

<%-- 车辆地图监控 --%>
<link rel="stylesheet" href="<%=contextPath%>/jslib/map/css/style.css" type="text/css">
<script src="http://webapi.amap.com/maps?v=1.4.6&key=242ac779e3b541ba8bcf5990601e3768"></script>
<!-- <script src="http://webapi.amap.com/maps?v=1.3&key=01c92562c4bca3b8bfdd0a539e24825a"></script> -->
<script src="<%=contextPath %>/jslib/map/Trank.js" type="text/javascript"></script>
<script src="<%=contextPath %>/jslib/map/MapService.js" type="text/javascript"></script>
<script src="<%=contextPath %>/jslib/map/mapUil.js" type="text/javascript"></script>
<script src="<%=contextPath %>/jslib/map/markSettings.js" type="text/javascript"></script>