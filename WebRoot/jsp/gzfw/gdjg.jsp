<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>机构概况->各地机构</title>
<jsp:include page="head.jsp"></jsp:include>
</head>
<body>
<div class="clear"></div>
<div class="mid_bg">
   <div class="top_4">
	  <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;机构概况&nbsp;&gt;&nbsp;各地机构</div>      
	  <div class="top_4c fr">
	  	<div class="top_4c_1 fl"><img src="<%=contextPath %>/jsp/gzfw/images/bg13.gif" width="19" height="19" /></div>
	    <div class="top_4c_2 fl"><input type="text" name="textfield" id="textfield" class="txt_1" /></div>
	    <div class="top_4c_3 fl"><a href="#" class="btn_1">搜索</a></div>
	  </div>    
  </div>
  <div class="h20 clear"></div>
  
  <div class="ntit_1">
    <ul>
      <li class="marr10"><a href="<%=contextPath %>/jsp/gzfw/jggk.jsp" >机构概况</a></li>
      <li><a href="<%=contextPath %>/jsp/gzfw/gdjg.jsp" class="curr">各地机构</a></li>
    </ul>
  </div>
  <div class="h20 clear"></div>
  
  <div class="virtual"><img src="images/p10.jpg" width="930" height="436" /></div>
  
  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>