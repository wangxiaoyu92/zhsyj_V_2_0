<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
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
	<title>执法流程简介</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>		
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jslib/fm/base/base.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jslib/fm/base/detail.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jslib/fm/base/page.css">
	<script type="text/javascript" src="<%=basePath %>jslib/fm/base/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>jslib/fm/base/picture_roll.js"></script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >			
	       	<sicp3:groupbox title="执法流程简介">
	       		<!-- 内容简介、QR码图 -->
				<div  style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto;" >
				    <div style="font-size: 16px;" >
				    <p class="grap02 t2 tj" id="summ" style="font-size: 15px;">
					自食品药品安全投诉举报中心挂牌成立以来，我局及时通过广播电视、普法宣传、食品药品经营场所制度牌等多种形式广泛向社会公布12331、局行政办、业务科室投诉举报电话，广泛接受社会监督，大力营造群防群管、人人参与、社会共治食品药品安全的良好氛围，有效维护了消费者的合法权益。
					</p>
				    </div>		
				</div>
				
				<!-- 软件截图 -->
				<div  style="width:100%;MARGIN-RIGHT: auto; MARGIN-LEFT: auto;float: right;padding-top: 10px" align="center">
					<img src="<%=basePath %>jslib/fm/img/zfbatj2.png" height="398" width="938" alt="">
				</div>	
	        </sicp3:groupbox>
    	</form>   
    </div>    
</body>
</html>
