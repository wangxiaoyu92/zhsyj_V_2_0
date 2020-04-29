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
<html>
<head>
<title>溯源信息</title>

	<script src="<%=contextPath%>/jslib/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js" type="text/javascript" charset="utf-8"></script>
	<link href="<%=contextPath%>/jslib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="<%=contextPath%>/jslib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url:"<%=contextPath%>/common/sjb/g?sym=${code}",
			type:'post',
			async:true,
			cache:false,
			timeout: 100000,
			error:function(){
				alert("服务器繁忙，请稍后再试！");
			},
			success: function(result){
				result = $.parseJSON(result);
				if(result.code == '0') {
					var items = result.data;
					var htmlContent = "";
					var cailiaoxinxi = "";
					for(var i=0;i<items.length;i++){
						var proid = items[i].proid;
						var commc = items[i].commc;
						var comdz = items[i].comdz;
						var comyddh = items[i].comyddh;
						var proname= items[i].proname;
						var prosptm= items[i].prosptm;
						var prozlstr= items[i].prozlstr;
						var cpclname= items[i].cpclname;
						var cppcscrq= items[i].cppcscrq;
						var cppcpch= items[i].cppcpch;
						var cpclname= items[i].cpclname;

						if(i==0){
							$("#productTitle").html(proname);
							$("#scrq").html(cppcscrq);
							$("#chj").html(commc);
							$("#cpdz").html(comdz);
							$("#tiaoxingma").html(prosptm);
							$("#cppcpch").html(cppcpch);
						}else{
							cailiaoxinxi +=proname+"   ";
							itemContent=
									'<div class="row"><h4 class="text-info">'+proname+':【目标产品->'+cpclname+'】'+'</h4>'+
							'<div class="col-sm-4">'+
								'<div class="col-sm-4">'+
									'<p>材料生产日期:'+cppcscrq+'</p>'+
									'<p>材料厂家:'+commc+'</p>'+
									'<p>材料产地(基地):'+comdz+'</p>'+
								'</div>'+
								'<div class="col-sm-4">'+
									'<p>材料批次:'+cppcpch+'</p>'+
									'<p>材料条码:'+prosptm+'</p>'+
									'<p>材料保质期:</p>'+
								'</div>'+
							'</div></div>';
							htmlContent+=itemContent;

						}
					}
					$("#cailiaoxinxi").html(cailiaoxinxi);
					$("#cailiaomingxi").html(htmlContent);
				}
			}

		});
	});
</script>

</head>
<body class="devpreview sourcepreview" style="min-height: 347px; cursor: auto;">
<div class="container">
	<div class="jumbotron">
		<h1 class="text-primary" id="productTitle"></h1>
		<div class="row">
			<div class="col-sm-4">
				<p>溯源码:${code}</p>
				<p>生产日期:<span id="scrq"></span></p>
				<p>厂家:<span id="chj"></span></p>
				<p>产地(基地):<span id="cpdz"></span></p>
			</div>
			<div class="col-sm-4">
				<p>产品批次:<span id="cppcpch"></span></p>
				<p>规格</p>
				<p>商品条码:<span id="tiaoxingma"></span></p>
				<p>保质期</p>
			</div>
		</div>
	</div>
	<div class="jumbotron">
		<p class="text-success">材料信息：<span id="cailiaoxinxi"></span></p>
	</div>
	<div class="jumbotron">
		<img src="<%=contextPath%>/images/default.jpg">
		<img src="<%=contextPath%>/images/default.jpg" class="img-rounded">
		<img src="<%=contextPath%>/images/default.jpg" class="img-circle">
		<img src="<%=contextPath%>/images/default.jpg" class="img-thumbnail">
	</div>
	<div class="jumbotron">
		<p class="text-success">材料列表</p>
		<div class="row" id="cailiaomingxi">

		</div>
	</div>

</div>
</body>
</html>
