<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,java.util.*" %>
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
<jsp:include page="head.jsp"></jsp:include>
<link href="process_images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="clear"></div>
<div class="mid_bg">
    <div class="top_4">
	  <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;查询中心&nbsp;&gt;&nbsp;许可审批进度查询</div>      
	  <div class="top_4c fr">
	  	<div class="top_4c_1 fl"><img src="images/bg13.gif" width="19" height="19" /></div>
	    <div class="top_4c_2 fl"><input type="text" name="textfield" id="textfield" class="txt_1" /></div>
	    <div class="top_4c_3 fl"><a href="#" class="btn_1">搜索</a></div>
	  </div>    
    </div>
  	<div id="main">
  	 	<iframe src='http://as.hda.gov.cn/progress_zhai.jsp' frameborder="0" scrolling="no"  width="970" height="800"></iframe>
  	</div>

	<div class="h40 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>