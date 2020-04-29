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
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<script src="./js/jquery.imagezoom.js"></script>
<link href="./css/imagezoom.css" rel="stylesheet">
<script src="./js/MSClass.js"></script>
<body>
<div class="news_page" id="news_page" style="font-size: 20px">
	<div style="font-size:16px;margin:0px auto;font-weight:bold;"><%=t_commc%></div>
	<fieldset style="margin-top: 10px;" align="center">
		<legend style="font-size: 19px">产品基本信息</legend>
		<table id="content" style="width:99%;margin:0 20px 20px 0; paddings:5px;font-size:15px;text-align: left;">
			<tr>
				<td style="font-size:14px;">产品名称：<span style="font-size:14px;" id="commc"></span></td>
				<td style="font-size:14px;">产品商标：<span style="font-size:14px;" id="commc"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">生产厂家：<span style="font-size:14px;" id="comfrhyz"></span></td>
				<td style="font-size:14px;">产品标准号：<span style="font-size:14px;" id="comgddh"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">产地：<span style="font-size:14px;" id="comdz"></span></td>
				<td style="font-size:14px;">保质期：<span style="font-size:14px;" id="commc"></span></td>
			</tr>
			<tr>
				<td style="font-size:14px;">产品简介：</td>
			</tr>
			<tr>
				<td colspan="2"><span style="font-size:15px;" id="enterpriseProfile"></span></td>
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
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';
	
	$(function() {
		if (t_currlocation != '') {
			$('#currlocation').html('当前位置：' + t_currlocation);
		}

		getPcompany();
		getFjList(1, 10);
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
						$("#comfrhyz").text(item.comfrhyz);
						$("#comdz").text(item.comdz);
						$("#comgddh").text(item.comgddh);
						$("#enterpriseProfile").html("&nbsp;&nbsp;&nbsp;" + item.comjianjie);
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
				fjwid : t_comid,
				fjtype : '1'
			},
			success : function(result) {
				if (result.code == '0') {
					$.each(result.rows, function(index, item) {
						var fjpath = basePath + item.fjpath;
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
			content : "<img style='width:100%;height:100%;' src=" + url
					+ "></img>"
		});
	}
</script>
<script type="text/javascript">
	/*********跑马灯效果***************/
	var marqueeDivControl = new Marquee("marqueeDiv");
	marqueeDivControl.Direction = "left";
	marqueeDivControl.Step = 1;
	marqueeDivControl.Width = 997;
	marqueeDivControl.Height = 233;
	marqueeDivControl.Timer = 20;
	marqueeDivControl.ScrollStep = 1;
	marqueeDivControl.Start();
	marqueeDivControl.BakStep = marqueeDivControl.Step;
</script>
</body>
</html>