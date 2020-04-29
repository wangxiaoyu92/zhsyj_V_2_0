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
	<title>执法情况统计</title>
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
	       	<sicp3:groupbox title="执法情况统计">
	       		<!-- 内容简介、QR码图 -->
				<div  style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto;" >
				    <div style="font-size: 16px;" >
				    <p class="grap02 t2 tj" id="summ" style="font-size: 15px;">
					近年来，我局严格以习总书记提出的“四个最严”抓食品安全工作，在县委县政府“五条路径”的指引下，不断加大对食品生产企业及经营单位的监管力度，开展各类专项整治活动，加大抽检力度；通过举办稽查培训班，对乡镇所稽查工作考核以及为执法人员配备移动执法终端，不断提升执法人员执法办案水平。在此基础上，我局稽查工作业绩从2014年以来呈跳跃式增长，特别是2016年，我局先后举行了“大排查、大整治、大平安”、“百日攻坚”、“百日攻坚回头看”、“夜市摊整治”等专项整治活动，共查处食品安全违法违规案件325起，其中5万元以上案件（大案）13起，罚没款金额129.2万元，抽检1786批次，位居全市第一位，严厉地打击了食品安全违法违规行为，净化了食品市场环境，保障了全县人民的饮食安全。鉴于我局稽查工作的突出表现，安阳市食品药品监管系统稽查工作现场会于5月20日在我县召开，来自全市的稽查工作人员来我县进行观摩学习。
					</p>
				    </div>		
				</div>
				
				<!-- 软件截图 -->
				<div  style="width:100%;MARGIN-RIGHT: auto; MARGIN-LEFT: auto;float: right;padding-top: 10px" align="center">
					<img src="<%=basePath %>jslib/fm/img/zfbatj1.png" height="398" width="938" alt="">
				</div>	
	        </sicp3:groupbox>
    	</form>   
    </div>    
</body>
</html>