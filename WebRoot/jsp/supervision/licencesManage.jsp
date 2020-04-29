<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>许可管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

	var itemtypeData = "<%=SysmanageUtil.getAa01("LICENSEMANAGEURI").getAaa005()%>";

	$(function() {
		jump();
	});

	function jump(){
		showModalDialog(itemtypeData,null,"help:no;status:no;center:yes;dialogWidth:"+(screen.width-40)+";dialogHeight:"+(screen.height-40));
	};
</script>
</head>
<body>
<p>
	<span style="color:#FF0000;">
		<u>注：由于许可管理属于省平台强制执行的，下面链接是强制跳转至省平台的。</u>
	</span>
	<br>
</p>
<p>
	<br>
</p>
<p style="text-align: center;">
	<u>
		<a href="javascript:void(0)" onclick="jump()">
			<span style="color:#0000CD;"><span style="font-size: 72px;">
				<strong>河南省食药监局行政审批系统</strong>
			</span>
			</span>
		</a>
	</u><br>
</p>
</body>
</html>