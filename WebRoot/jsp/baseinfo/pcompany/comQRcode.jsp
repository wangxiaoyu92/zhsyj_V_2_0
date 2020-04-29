<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>企业二维码管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var table; // 数据表格
	var form; // form表单（查询条件）
	var layer; // 弹出层
	$(function() {
		layui.use(['form','table','layer'],function(){
			form = layui.form;
			table = layui.table;
			layer = layui.layer;
			form.on('submit(save)', function(data){
				var formData = data.field;
				/*console.log(formData)*/
				$.post(basePath + 'pcompany/savePcompanyQRcode', formData, function (result) {
					result = $.parseJSON(result);
					if (result.code == "0"){
						layer.msg('保存成功！', {time : 1000},function(){
							var obj = new Object();
							obj.type = "ok";
							sy.setWinRet(obj);
							closeWindow();
						});
					} else {
						layer.open({
							title : "提示",
							content: "保存失败：" + result.msg //这里content是一个普通的String
						});
					}
				});
				return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
		});
		if ($('#comid').val().length > 0) {
			$.post(basePath + 'pcompany/queryCompanyQRcode',{
				comid : $('#comid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
				} else {
					layer.open({
						title : "提示",
						content: "查询失败：" + result.msg //这里content是一个普通的String
					});
	            }	
	            var qrcodecontent = $("#qrcodecontent").val();
	            var tpname = $("#comid").val();
	            if (qrcodecontent != "") {
	            	$("#qrcodeimg").attr("src", "<%=contextPath%>/upload/qrcode/"+tpname+".gif");
	            } else {
	            	$("#qrcodeimg").attr("src", "<%=contextPath%>/images/default.jpg");
	            }
			}, 'json');
		}
	});
	
	// 创建二维码
	function createQRcode() {
		var comid = $("#comid").val();
		var url = basePath + "pcompany/createComQRcode";
		var paramers = {
			comid : '<%=comid%>'
		};
		$.ajax({
		   type : "POST",
		   url : url,
		   data : paramers,
		   success : function(msg){
		   		var tpname = $("#comid").val();
		   		var v_qrcodepath = "upload/qrcode/" + tpname + ".gif";
		   		$("#qrcodeimg").attr("src", basePath + v_qrcodepath);
		   		$("#qrcodepath").val(v_qrcodepath);
		   }
		});
	}
	// 保存二维码
	function saveQRcode() {
		$("#saveQRcodeBtn").click();
	}
	// 关闭窗口
	var closeWindow = function(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	};
</script>
</head>
<body>
<form class="layui-form" action="" id="fm">
	<input id="comid" name="comid" type="hidden" value="<%=comid%>"/>
	<input id="qrcodepath" name="qrcodepath" type="hidden"/>
	<input id="qrcodecontent" name="qrcodecontent" type="hidden"/>
	<table class="layui-table">
		<tr>
			<td style="text-align:right;"><nobr>企业名称:</nobr></td>
			<td><input id="commc" name="commc" class="layui-input layui-bg-gray" readonly/></td>
		</tr>
		<tr>
			<td style="text-align:right;"><nobr>二维码:</nobr></td>
			<td>
				<div style="width:200px;height:200px;" id="comqrcode_div">
					<img name="qrcodeimg" id="qrcodeimg" height="200" width="400" style="max-width: 200px;"/>
				</div>
			</td>
		</tr>
<%--		<tr>
			<td style="text-align:center;" colspan="2">
				<a href="javascript:void(0)" class="layui-btn"
				   onclick="createQRcode()">生成二维码</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="layui-btn"
				   iconCls="icon-save" onclick="saveQRcode()">保存</a>
			</td>
		</tr>--%>
	</table>
	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save"
					id="saveQRcodeBtn">保存</button>
		</div>
	</div>
</form>
</body>
</html>