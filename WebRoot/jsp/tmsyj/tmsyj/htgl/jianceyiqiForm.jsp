<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	String v_hjcjgjcyqbid=StringHelper.showNull2Empty(request.getParameter("hjcjgjcyqbid")); //进出库表主键
	String v_title="检测仪器 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="检测仪器 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="检测仪器 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="检测仪器 查看";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>检测仪器详情页</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
		var form; // form表单（查询条件）
		var layer; // 弹出层
		var laydate;
		$(function () {
			// 资质证明

			layui.use(['form', 'layer', 'laydate'], function () {
				form = layui.form;
				layer = layui.layer;
				laydate = layui.laydate;
				laydate.render({
					elem: '#jcyqgmrq'
					,type: 'datetime'
				});
				laydate.render({
					elem: '#jcyqscrq'
					,type: 'datetime'
				});
				// 主体业态
				var lock = true;// 锁住表单   这里定义一把锁
				var url = basePath + '/tmsyjhtgl/saveJianceyiqi';
				form.on('submit(save)', function (data) {
					var formData = data.field;
					if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
						return false;
					}
					lock = false  //进来后，立马把锁锁住
					$.post(url, formData, function (result) {
						result = $.parseJSON(result);
						if (result.code == '0') {
							layer.msg('保存成功', {time: 1000}, function () {
								var obj = new Object();
								if ('' == ('<%=op%>')) {
									obj.type = "saveOk";
								} else {
									obj.type = "ok";
								}
								sy.setWinRet(obj);
								closeWindow();
							});
						} else {
							layer.open({
								title: '提示'
								, content: '保存失败' + result.msg
							});
							lock = true;
						}
					});
					return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
				});
				if ($('#hjcjgjcyqbid').val().length > 0) {
					$.post(basePath + '/tmsyjhtgl/queryJianceyiqiDTO', {
								hjcjgjcyqbid : $('#hjcjgjcyqbid').val()
							},
							function (result) {
								if (result.code == '0') {
									var mydata = result.data;
									$('form').form('load', mydata);
									form.render();
								} else {
									layer.open({
										title: "提示",
										content: "查询失败：" + result.msg //这里content是一个普通的String
									});
								}
							}, 'json');
				}
				;

				if ('<%=op%>' == 'view') {
					$('form :input').addClass('input_readonly');
					$('form :input').attr('readonly', 'readonly');
					$('#jcyqscrq').attr('disabled', true);
					$('#jcyqgmrq').attr('disabled', true);
				}
			});
		});

		// 关闭窗口
		var closeWindow = function () {
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		};

		// 保存
		var submitForm = function () {
			var jcyqscrq = $('#jcyqscrq').val();
			var jcyqgmrq = $('#jcyqgmrq').val();
			if (jcyqscrq < jcyqgmrq) {
				$("#saveJcyqBtn").click();
			} else {
				$('#jcyqscrq').css('border-color', 'red');
				$('#jcyqgmrq').css('border-color', 'red');
				layer.msg('生产时间必须小于购买时间', {icon: 5, anim: 6});
			}

		};

	</script>
</head>

<body>
<div data-options="region:'north'"
	 style="height:40px;text-align:center;">
	<font style="font-size:200%;text-align:right;color: green;"><%=v_title%>
	</font>
</div>
<form id="fm" class="layui-form" action="">
	<input type="hidden" id="hjcjgjcyqbid" name="hjcjgjcyqbid" value="<%=v_hjcjgjcyqbid %>">
	<input type="hidden" id="hviewjgztid" name="hviewjgztid">
	<input type="hidden" id="aae011" name="aae011">
	<input type="hidden" id="aae036" name="aae036">
	<div class="layui-row">
		<div class="layui-form-item">
			<div class="layui-col-md2">
				<label class="layui-form-label" style="width: 160px;"><font color="red">*</font>检测仪器名称：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqmc" name="jcyqmc" class="layui-input " lay-verify="required">
				</div>
			</div>
			<div class="layui-col-md2" >
				<label class="layui-form-label" style="width: 160px;"><font color="red">*</font>检测仪器型号：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqxh" name="jcyqxh" class="layui-input" lay-verify="required">
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-form-item">
			<div class="layui-col-md2">
				<label class="layui-form-label" style="width: 160px;"><font color="red">*</font>检测仪器序列号：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqxlh" name="jcyqxlh" class="layui-input " lay-verify="required">
				</div>
			</div>
			<div class="layui-col-md2" >
				<label class="layui-form-label" style="width: 160px;"><font color="red">*</font>检测仪器生产厂家：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqsccj" name="jcyqsccj" class="layui-input" lay-verify="required">
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-form-item">
			<div class="layui-col-md2">
				<label class="layui-form-label" style="width: 160px;">检测仪器购买日期：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqgmrq" name="jcyqgmrq" class="layui-input " lay-verify="required">
				</div>
			</div>
			<div class="layui-col-md2" >
				<label class="layui-form-label" style="width: 160px;">检测仪器生产日期：</label>
			</div>
			<div class="layui-col-md4" >
				<div class="layui-input-inline">
					<input type="text" id="jcyqscrq" name="jcyqscrq" class="layui-input">
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-form-item">
			<div class="layui-col-md2">
				<label class="layui-form-label" style="width: 160px;">检测仪器检测项目:</label>
			</div>
			<div class="layui-col-md10">
				<div class="layui-input-inline" style="width: 85%">
                                <textarea id="jcyqjcxm" name="jcyqjcxm"
										  style="width:100%;height: 150px"></textarea>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-form-item">
			<div class="layui-col-md2">
				<label class="layui-form-label" style="width: 160px;">检测仪器产品用途:</label>
			</div>
			<div class="layui-col-md10">
				<div class="layui-input-inline" style="width: 85%">
                                <textarea id="jcyqcpyt" name="jcyqcpyt"
										  style="width:100%;height: 150px"></textarea>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save" id="saveJcyqBtn">保存
			</button>
		</div>
	</div>
</form>
</body>
</html>