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
	<title>福码溯源</title>
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
	       	<sicp3:groupbox title="福码溯源">
	       		<!-- 内容简介、QR码图 -->
				<div  style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto;" >
				    <div style="font-size: 16px;" >
				    <p class="grap02 t2 tj" id="summ" style="font-size: 15px;">
					福码溯源平台，是北京慧眼智行自主研发的手机扫码软件，是亿阳福码云服务移动互联网的重点产品，条码、二维码、亿阳福码，作为商品信息的载体，通过它您可以查询到商品的真实信息，可以和企业建立互通，提升企业的品牌价值，为商品安全保驾护航，或许，您还可以获得更多的云增值服务，福码溯源平台，让商品查询变为一件乐事，你收获的不仅仅是单一的商品，更是一份关爱与体贴，分享，互动，VIP礼遇，丰富的抽奖活动，更多更好的商品推荐，尽在福码溯源平台。
					</p>
				    </div>		
				</div>
				
				<!-- 软件截图 -->
				<div  style="width:100%;MARGIN-RIGHT: auto; MARGIN-LEFT: auto;float: right;padding-top: 10px">
					<img style="padding-right: 40px" src="<%=basePath %>jslib/fm/img/11.jpg" height="398" width="238" alt="">
					<img style="padding-right: 40px" src="<%=basePath %>jslib/fm/img/22.jpg" height="398" width="238" alt="">
					<img style="padding-right: 40px" src="<%=basePath %>jslib/fm/img/33.jpg" height="398" width="238" alt="">
					<img style="padding-right: 20px" src="<%=basePath %>jslib/fm/img/2.jpg" height="398" width="238" alt="">
				</div>	
	        </sicp3:groupbox>
    	</form>   
    </div>    
</body>
</html>