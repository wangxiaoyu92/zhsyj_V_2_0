<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_hjhbid = StringHelper.showNull2Empty(request.getParameter("hjhbid"));
	String v_eptbh = StringHelper.showNull2Empty(request.getParameter("eptbh"));
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>进货产品溯源码管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		var v_hjhbid = $("#hjhbid").val();
		var v_eptbh = $("#eptbh").val();
		var v_comid = $("#comid").val();
		// 检查文件是否存在
		$.ajax({
			type : "POST",
			url: basePath + "api/tmsyj/getFjList",
			data: {'fjwid' : v_hjhbid},
			success: function(result){
				result = $.parseJSON(result);
				if (result.rows.length > 0) {
					$("#qrcodeimg").attr("src", basePath + result.rows[0].fjpath);
				} else {
					$("#qrcodeimg").attr("src", basePath + "images/default.jpg");
					$.messager.confirm('提示', '当前没有溯源码，要生成新的溯源码吗?',function(r) {
						if (r) {
							var url = basePath + "tmsyjhtgl/createJinHuoSpQRcode";
							var paramers = {
								hjhbid : v_hjhbid,
								comid : v_comid,
								eptbh : v_eptbh
							};
							$.ajax({
								type : "POST",
								url : url,
								data : paramers,
								success : function(msg){
									var tpname = $("#eptbh").val();
									var v_fjpath = "upload/qrcode/" + tpname + ".gif";
									$("#qrcodeimg").attr("src", basePath + v_fjpath);
									$("#fjpath").val("qrcode/" + tpname + ".gif");
								}
							});
						}
					});
				}
			}
		});
	});
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
		$dialog.dialog('destroy');
	};
</script>
</head>
<body >
	<input type="hidden"  id="hjhbid" name="hjhbid" value="<%=v_hjhbid%>">
	<input type="hidden"  id="eptbh" name="eptbh" value="<%=v_eptbh%>">
	<input type="hidden"  id="comid" name="comid" value="<%=v_comid%>">
	<div style="width:240px;height:250px; margin-left: 90px;margin-top: 40px;" id="comqrcode_div">
		<img name="qrcodeimg" id="qrcodeimg" height="200" width="200" />
	</div>
</body>
</html>