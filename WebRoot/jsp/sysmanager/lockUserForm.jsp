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
%>
<%
	String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
	String username = StringHelper.showNull2Empty(request.getParameter("username"));
%>
<!DOCTYPE html>
<html>
<head>
<title>用户编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var form;
	var layer;
	$(function() {
		layui.use(['form', 'layer'], function(){
			form = layui.form;
			layer = layui.layer;
			// 提交表单，保存
			form.on('submit(saveLockUser)', function(data){
				var formData = data.field;
				$.post(basePath + 'sysmanager/sysuser/lockSysuser', formData, function (result) {
					result = $.parseJSON(result);
					if (result.code == "0"){
						layer.msg('封锁成功！', {time : 100},function(){
							var obj = new Object();
							obj.type = "ok";
							sy.setWinRet(obj);
							closeWindow();
						});
					} else {
						layer.open({
							title : "提示",
							content: "封锁失败：" + result.msg //这里content是一个普通的String
						});
					}
				});
				return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
		});
	});

	// 提交表单
	function submitForm() {
		$("#saveLockUserBtn").click();
	}

	// 关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}

</script>
</head>
<body>
<form id="lockUserForm" class="layui-form" action="">
	<table class="layui-table" lay-skin="nob">
		<tr>
			<td style="text-align:right;width: 141px;height: 57px">用户ID:</td>
			<td><input type="text" name="userid" id="userid" value="<%=userid%>"
					   readonly class="layui-input layui-bg-gray"></td>
		</tr>
		<tr>
			<td style="text-align:right;width: 141px;height: 57px">用户名称:</td>
			<td><input type="text" name="username" id="username" value="<%=username%>"
					   readonly class="layui-input layui-bg-gray"></td>
		</tr>
		<tr>
			<td style="text-align:right;width: 141px;height: 57px">账户封锁原因:</td>
			<td><input type="text" name="lockreason" id="lockreason"
					   required lay-verify="required" class="layui-input"></td>
		</tr>
	</table>
	<%--<div class="layui-form-item">--%>
		<%--<label class="layui-form-label">用户ID:</label>--%>
		<%--<div class="layui-input-inline">--%>
			<%--<input type="text" name="userid" id="userid" value="<%=userid%>"--%>
				   <%--readonly class="layui-input layui-bg-gray">--%>
		<%--</div>--%>
	<%--</div>--%>
	<%--<div class="layui-form-item">--%>
		<%--<label class="layui-form-label">用户名称:</label>--%>
		<%--<div class="layui-input-inline">--%>
			<%--<input type="text" name="username" id="username" value="<%=username%>"--%>
				   <%--readonly class="layui-input layui-bg-gray">--%>
		<%--</div>--%>
	<%--</div>--%>
	<%--<div class="layui-form-item">--%>
		<%--<label class="layui-form-label">账户封锁原因:</label>--%>
		<%--<div class="layui-input-inline">--%>
			<%--<input type="text" name="lockreason" id="lockreason"--%>
				   <%--required lay-verify="required" class="layui-input">--%>
		<%--</div>--%>
	<%--</div>--%>
	<div class="layui-inline">
		<div class="layui-form-item" style="display: none">
			<div class="layui-input-inline">
				<button class="layui-btn" lay-submit="" lay-filter="saveLockUser"
						id="saveLockUserBtn" >保存</button>
			</div>
		</div>
	</div>
</form>
</body>
</html>