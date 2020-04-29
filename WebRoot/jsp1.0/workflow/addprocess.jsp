<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml">
<style>
vml\:* {
behavior: url(#default#VML);display:inline-block
}
</style>
<head>
	<title>添加一个新的工作流</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<jsp:include page="${basePath}/inc_wf.jsp"></jsp:include>
	<script charset="UTF-8" src="<%=basePath%>/jsp/XiorkFlow/js/XiorkFlowWorkSpace.js" language="javascript"></script>
	<script charset="UTF-8" src="<%=basePath%>/jsp/workflow/addprocess.js" language="javascript"></script>
<script>
//关闭并刷新父窗口
function closeAndRefreshWindow(){
	var s = new Object();
	s.type = "ok";
	sy.setWinRet(s);
	parent.$("#"+sy.getDialogId()).dialog("close");
}
</script>
</head>
<body onload="init()" onunload="closeAndRefreshWindow()" onselectstart="return false;" style="margin: 0px;overflow: hidden;">
	<div id="designer" style="width: 100%;height: 100%;border: #e0e0e0 1px solid;"></div>
	<div id="message"></div>
</body>
</html>
