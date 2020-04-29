<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>监控摄像头列表【点击播放】</title>
<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
<script type="text/javascript">
	var BasePath = '<%=basePath%>';
	//企业id
	var jkqybh = '2016072011014674884485429';
	//var jkqybh = '<%=comid%>';
	
	$(function() {
		loadCameraPlayer();
		loadCameraList();
	});
	
		// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
</script>
</script>
</head>
<body>
	<div class="mclzPlayer"></div>
</body>
</html>