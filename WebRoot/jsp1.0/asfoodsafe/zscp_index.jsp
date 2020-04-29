<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";	
%>
<%
	String ver = (null==request.getParameter("ver"))?"zzb":request.getParameter("ver").toString();
%> 
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-溯源系统</title>
<jsp:include page="head.jsp"></jsp:include>
<link href="images/nav.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.nav.js" ></script>
<script>
function closediv(domid){
	document.getElementById(domid).style.display='none';
}
</script>
</head>
<body>
<div class="zscp_left">
	<h2><span>追溯产品</span>Ascend Products</h2>
	<ul>
		<!--<li><a href="zst.jsp" target="_blank">安盛追溯通</a></li>-->
		<li><a href="zzb.html" target="right">安盛食品安全管理系统(种植版)</a></li>
		<li><a href="yzb.html" target="right">安盛食品安全管理系统(养殖版)</a></li>
		<li><a href="ltb.html" target="right">安盛食品安全管理系统(流通版)</a></li>
		<li><a href="cyb.html" target="right">安盛食品安全管理系统(餐饮版)</a></li>
		<li><a href="rp.html"  target="right">安盛乳品安全管理系统</a></li>
	</ul>
</div>

<div class="zscp_right">
	<iframe id="iframepage" name="right" marginWidth="0" marginHeight="0" src="<%=ver %>.html" frameBorder="0" scrolling="no" width="725px" onLoad="iFrameHeight()" ></iframe>
	<script type="text/javascript" language="javascript">
		function iFrameHeight() {
		    var ifm = document.getElementById("iframepage");
		    var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;
		    if(ifm != null && subWeb != null) {
		    	ifm.height = subWeb.body.scrollHeight;
		    }
		}
	</script>  
</div>

<%@ include file="footer.jsp"%>
</body>
</html>