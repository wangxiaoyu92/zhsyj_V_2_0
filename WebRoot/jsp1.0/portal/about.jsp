<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%		
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String ls_userid = "";
	String ls_username = "";
	String ls_description = "";
	String ls_userkind = "";
	String ls_now = new Date().toLocaleString();
	if(sysuser!=null){
		ls_userid = sysuser.getUserid()==null?null:sysuser.getUserid().toString();
		ls_username = sysuser.getUsername();
		ls_description = sysuser.getDescription();
		ls_userkind = sysuser.getUserkind();	  
	}

	String datetime = "今天是" + DateUtil.getChineseDate(DateUtil.getCurrentDate()) + " " + DateUtil.getChineseWeek();
%>
<!DOCTYPE html>
<html>
<head>
<title>平台介绍</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
</head>
<body>
	<br/>
	<ul>
		<li>欢迎使用骏化物流信息系统平台！</li>
	</ul>
	<ul>
		<li>
			<%
				out.print(StringHelper.formateString("欢迎您，{0}！",ls_username));
			%>
		</li>
	</ul>
	<ul>
		<li>
			<%
				out.print(StringHelper.formateString("{0}",datetime));
			%>
		</li>
	</ul>
</body>
</html>