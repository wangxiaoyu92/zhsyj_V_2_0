<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "产品信息";
	String t_proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	String t_proname = StringHelper.showNull2Empty(request.getParameter("proname"));
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-溯源产品详情</title>
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<script src="./js/jquery.imagezoom.js"></script>
<link href="./css/imagezoom.css" rel="stylesheet">
<script src="./js/MSClass.js"></script>
</head>
<body>
<div class="news_page" id="news_page" style="font-size: 20px">
	<div style="font-size:16px;margin:0px auto;font-weight:bold;"><%=t_proname%></div>
	<fieldset style="margin-top: 10px;" align="center">
		<legend style="font-size: 19px">产品基本信息</legend>
		<table id="content" style="width:99%;margin:0 20px 20px 0; paddings:5px;font-size:15px;text-align: left;line-height:200%;">
			<tr>
				<td style="font-size:14px;">产品名称：<span style="font-size:14px;" id="proname"></span></td>
				<td style="font-size:14px;">产品商标：<span style="font-size:14px;" id="prosb"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">生产厂家：<span style="font-size:14px;" id="prosccj"></span></td>
				<td style="font-size:14px;">产地：<span style="font-size:14px;" id="procdjd"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">保质期：<span style="font-size:14px;" id="procpbzh"></span></td>
				<td style="font-size:14px;">产品种类：<span style="font-size:14px;" id="prozl"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">产品简介：</td>
			</tr>
			<tr>
				<td colspan="3"><span id="projj"></span></td>
			</tr>
		</table>
	</fieldset>
	<fieldset style="margin-top: 10px;" align="center">
		<legend style="font-size: 19px">
			产品图片
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
	var t_proid = '<%=t_proid%>';
	var t_proname = '<%=t_proname%>';
	
	$(function() {
		if (t_currlocation != '') {
			$('#currlocation').html('当前位置：' + t_currlocation);
		}

		getComProductDetailList();
		getFjList(1, 10);
	});

	function getComProductDetailList() {
		$.ajax({
			url : basePath + "api/spsy/getComProductDetailList",
			type : "post",
			dataType : 'json',
			data : {
				proid : t_proid
			},
			success : function(result) {
				if (result.code == '0') {
					if (result.total > 0) {
						var item = result.rows[0];
						$("#proname").text(item.proname);
						$("#prosb").text(item.prosb);
						$("#prosccj").text(item.prosccj);
						$("#procdjd").text(item.procdjd);
						$("#procpbzh").text(item.procpbzh);
						$("#prozl").text(item.prozl);
						$("#projj").html("<font style=\"font-size:15px;line-height:200%;\">&nbsp;&nbsp;&nbsp;" + item.projj + "</font>");
					}
				} else {
					alert(result.msg);
				}
			}
		});
	}

	function getFjList(page, pageSize) {
		$.ajax({
			url : basePath + "api/tmsyj/getFjList",
			type : "post",
			dataType : 'json',
			data : {
				fjwid : t_proid,
				fjtype : '1'
			},
			success : function(result) {
				if (result.code == '0') {
					$.each(result.rows, function(index, item) {
						var fjpath = checkImg(item.fjpath);
						var html = "";
						html += "<li><a onclick='showPic(\"" + fjpath + "\")' ><img src='"+fjpath+"'></a></li>";

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