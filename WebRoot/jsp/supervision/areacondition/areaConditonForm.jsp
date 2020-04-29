<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String add = StringHelper.showNull2Empty(request.getParameter("add"));
	String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));
%>
<!DOCTYPE html>
<html>
<head>
<title>区域描述信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var form; // form表单（查询条件）
var layer; // 弹出层
var wfxwbhOld='';
$(function() {
	layui.use(['form', 'layer'], function () {
		form = layui.form;
		layer = layui.layer;

		if ($('#aaa027').val().length > 0) {
			$.post(basePath + '/area/condition/findAreaCondition', {
				aaa027: $('#aaa027').val()
			}, function (result) {
				if (result.code == '0') {
					var mydata = result.data;
					$('#fm').form('load', mydata);
					form.render();
				}
			}, 'json');
			if ('<%=op%>' == 'view') {
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly', 'readonly');
				$("#btn_query").addClass('layui-btn-disabled');
			}
		}
		form.on('submit(saveDept)', function (data) {
			var formData = data.field;
			var url = basePath + '/area/condition/saveareaCondition';
			$.post(url, formData, function (result) {
				result = $.parseJSON(result);
				if (result.code == "0") {
					layer.msg('保存成功！', {time: 1000}, function () {
						var obj = new Object();
						obj.type = "ok";
						sy.setWinRet(obj);
						closeWindow();
					});
				} else {
					layer.open({
						title: "提示",
						content: "保存失败：" + result.msg //这里content是一个普通的String
					});
				}
			});
			return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
	});
});
	function submitForm() {
		$("#saveDeptBtn").click();
	}
	//关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
function myselectjwd() {
	var v_address = $("#comdz").val();
	layer.open({
		type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		,
		area: ['100%', '100%'] //
		,
		title: '选择经纬度'
		,
		content: basePath + 'jsp/pub/pub/pubMap.jsp?address=' + v_address + '&a=' + new Date().getMilliseconds()
		,
		shade: [0.8, 'gray'] // 遮罩
		,
		btn: ['确定', '退出']
		,
		btn1: function (index, layero) {
			var iframeWin = window[layero.find('iframe')[0]['name']];
			iframeWin.geocodersnew();
		}
	});
}
function showMenu_aaa027() {
	if ('<%=op%>' == 'view') {
		return;
	}
	var v_opkind = "addcompany";
	var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?opkind=' + v_opkind;
	sy.modalDialog({
		title: '选择地址'
		, area: ['300px', '400px']
		, content: url
	}, function (dialogID) {
		var k = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少

		if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
		$('#aaa027').val(k.aaa027);
			$('#aaa027name').val(k.aaa027name);
			$('#comdz').val(k.aab301);
		}
	});
}

</script>
</head>
<body>
	<form id="fm" class="layui-form" action="">
		<input name="filepath" id="filepath"  type="hidden" />
		<table class="layui-table" style="width: 99%;" lay-skin="nob">
			<input name="add" id="add"  value="<%=add%>" type="hidden"/>
			<tr>
				<td style="text-align:right;"><nobr>区域编码:</nobr></td>
				<td><input name="aaa027" id="aaa027"  class="layui-input" readonly="readonly" value="<%=aaa027%>"/></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>描述:</nobr></td>
				<td colspan="3"><textarea class="layui-textarea" id="text" name="text"
				rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea></td>
			</tr>
			<tr>
				<td style="text-align:right;"><font class="myred">*</font>所属地区:</td>
				<td >
					<div class="layui-form-item" style="padding-top: 13px;">
						<div class="layui-input-inline">
							<input type="text" id="aaa027name" name="aaa027name" lay-verify="required" style="width:200px;"
								   autocomplete="off" class="layui-input layui-bg-gray" onclick="showMenu_aaa027();"
								   readonly>
							<input name="comdz" id="comdz" type="hidden"/>

						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><font class="myred">*</font>地图定位:</td>
				<td colspan="2">
					<div class="layui-form-item" style="padding-top: 13px;">
						<label class="layui-form-label">经度坐标:</label>

						<div class="layui-input-inline">
							<input type="text" id="jdzb" name="jdzb" readonly="readonly" lay-verify="required"
								   autocomplete="off" class="layui-input">
						</div>
						<label class="layui-form-label">纬度坐标:</label>

						<div class="layui-input-inline">
							<input type="text" id="wdzb" name="wdzb" readonly="readonly" lay-verify="required"
								   autocomplete="off" class="layui-input">
						</div>
					</div>
				</td>
				<td>
					<a href="javascript:void(0)" class="layui-btn" id="dtdw"
					   iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>
				</td>
			</tr>

		</table>
		<div class="layui-form-item" style="display: none">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="saveDept"
						id="saveDeptBtn">保存</button>
			</div>
		</div>
	</form>
</body>
</html>