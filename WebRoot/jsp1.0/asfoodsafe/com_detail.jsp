<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "企业信息";
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-溯源企业详情</title>
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<script src="./js/jquery.imagezoom.js"></script>
<link href="./css/imagezoom.css" rel="stylesheet">
<script src="./js/MSClass.js"></script>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
%>
<script language="javascript" type="text/javascript">
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var jdzb = "";
	var wdzb = "";
	var address = "";         
	function initMap() { 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 10);
		mapObj.clearMap();  // 清除地图覆盖物		
	}	    
</script>
</head>
<body>
<div class="news_page" id="news_page" style="font-size: 20px">
	<div style="font-size:16px;margin:0px auto;font-weight:bold;"><%=t_commc%></div>
	<fieldset style="margin-top: 10px;" align="center">
		<legend style="font-size: 19px">企业基本信息</legend>
		<table id="content" style="width:99%;margin:0 20px 20px 0; paddings:5px;font-size:15px;text-align: left;">
			<tr>
<!-- 				<td rowspan='4' align="center" valign="middle"><img id="enterpriseIcon" src="images/kong.jpg" style="width:220px;height:200px;"></td> -->
				<td style="font-size:14px;">企业名称：<span style="font-size:14px;" id="commc"></span></td>
				<td style="font-size:14px;">负责人：<span style="font-size:14px;" id="comfzr"></span></td>
				<td rowspan='4' align="right" valign="middle">
					<!--地图容器-->
				    <div id="mapContainer" style="width:340px;height:200px;margin-top:3px;">
				         &nbsp;
				    </div>		
				</td>
			</tr>
			<tr>
				<td style="font-size:14px;">企业地址：<span style="font-size:14px;" id="comdz"></span></td>
				<td style="font-size:14px;">联系电话：<span style="font-size:14px;" id="comyddh"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">企业网址：<span style="font-size:14px;" id="comwz"></span></td>
				<td style="font-size:14px;">电子邮箱：<span style="font-size:14px;" id="comemail"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">公司简介：</td>
			</tr>
			<tr>
				<td colspan="3"><span id="comjianjie"></span></td>
			</tr>
		</table>
	</fieldset>
	<fieldset style="margin-top: 10px;" align="center">
		<legend style="font-size: 19px">
			产品展示
		</legend>
		<div class="marquee">
			<ul id="marqueeDiv"></ul>
		</div>
		<div id="p2"></div>
	</fieldset>
</div>
<%@ include file="footer.jsp"%>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';
	
	$(function() {
		if (t_currlocation != '') {
			$('#currlocation').html('当前位置：' + t_currlocation);
		}

		initMap();
		getPcompany();
		getComProductList();
	});

	function getPcompany() {
		$.ajax({
			url : basePath + "api/tmsyj/getPcompanyList",
			type : "post",
			dataType : 'json',
			data : {
				comid : t_comid
			},
			success : function(result) {
				if (result.code == '0') {
					if (result.total > 0) {
						var item = result.rows[0];
						$("#commc").text(item.commc);
						$("#comfzr").text(item.comfzr);
						$("#comdz").text(item.comdz);
						$("#comyddh").text(item.comyddh);
						$("#comwz").html("<a href=\"javascript:linkToSelf('"+ item.comwz +"');\"> "+ item.comwz +"</a>");
						$("#comemail").text(item.comemail);
						$("#comjianjie").html("<font style=\"font-size:15px;line-height:200%;\">&nbsp;&nbsp;&nbsp;" + item.comjianjie + "</font>");
						//$("#enterpriseIcon").attr("src",checkImg(item.icon));
						//$("#qrcode").attr("src", checkImg(item.qrcode));
						jdzb = item.comjdzb;
						wdzb = item.comwdzb;
						address = item.comdz;
						addMarker_tantiao(jdzb, wdzb, address, "", t_commc,"images/marker_red.png");
					}
				} else {
					alert(result.msg);
				}
			}
		});
	}

	function getComProductList() {
		$.ajax({
			url : basePath + "api/spsy/getComProductList",
			type : "post",
			dataType : 'json',
			data : {
				procomid : t_comid
			},
			success : function(result) {
				if (result.code == '0') {
					$.each(result.rows, function(index, item) {
						var fjpath = basePath + item.fjpath;
						var html = "";
						html += "<li><a href=\"javascript:linkToSelf('product_detail.jsp?proid="+ item.proid +"&proname="+ item.proname +"');\"><img src='"+fjpath+"'></a></li>";

						//滚动图片
						$('#marqueeDiv').append(html);
					});
				} else {
					alert(result.msg);
				}
			}
		});
	}

	function showPic(url) {
		layer.open({
			type : 1,
			title : "图片预览",
			area : [ "70%", "90%" ],
			shadeClose : true, //点击遮罩关闭
			content : "<img style='width:100%;height:100%;' src=" + url + "></img>"
		});
	}
</script>
<script type="text/javascript">
	/*********跑马灯效果***************/
	var marqueeDivControl = new Marquee("marqueeDiv");
	marqueeDivControl.Direction = "left";
	marqueeDivControl.Step = 1;
	marqueeDivControl.Width = 997;
	marqueeDivControl.Height = 200;
	marqueeDivControl.Timer = 20;
	marqueeDivControl.ScrollStep = 1;
	marqueeDivControl.Start();
	marqueeDivControl.BakStep = marqueeDivControl.Step;
</script>
</body>
</html>