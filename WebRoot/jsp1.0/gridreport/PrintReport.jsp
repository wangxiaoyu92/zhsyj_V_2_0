﻿<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>web报表(b/s报表)演示, 用报表打印显示器插件展现报表 - <%=request.getParameter("report")%></title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<script src="../../jslib/gridreport/CreateControl.js" type="text/javascript"></script>
    <style type="text/css">
        html,body {
            margin:0;
            height:100%;
        }
    </style>
</head>
    
<body style="margin:0">
	<script type="text/javascript">	
	    var v_report="<%=basePath%>jsp/gridreport/operatelog.grf";
	    var v_report2="<%=basePath%>jsp/gridreport/1a.grf";
	    var v_url="http://127.0.0.1:8080/syjzhpt/sysmanager/sysoperatelog/querySysoperatelogPrint?time="+new Date().getMilliseconds();
	    var v_url2="http://127.0.0.1:8080/jsp/data/xmlCustomer.jsp";
	    var v_url3="http://127.0.0.1:8080/syjzhpt/jsp/gridreport/test.txt";
	     CreateReport("Report");
	    
	    //CreatePrintViewerEx("100%", "100%", v_report, v_url, true, "");
    	//var Report = ReportViewer.Report;
    	//ReportViewer.Stop();
    	Report.LoadFromURL(v_report);
    	
    	Report.LoadDataFromURL(v_url);
    	//ReportViewer.Start();
    	Report.PrintPreview(true);
	</script>
</body>

</html>
 