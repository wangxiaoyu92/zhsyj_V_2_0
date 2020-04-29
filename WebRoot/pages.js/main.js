
$(function() {
	layui.use(['form', 'table', 'layer', 'element'], function () {
		form = layui.form;
		table = layui.table;
		layer = layui.layer;
		var element = layui.element;
	});
});

//解锁登录
function unlockWindow() {	
	var n_id = "#userName";
	var p_id = "#userPwd";
	var username = $(n_id).val();
	var userpwd = $(p_id).val();
	if (username == "") {
		alert('请输入用户名!');
		$(n_id).focus();
		//$.messager.alert('提示','请输入用户名!','info',function(){
		//	$(n_id).focus();
		//});
		return false;
	}
	if (userpwd == "") {
		alert('请输入密码!');
		$(p_id).focus();
		//$.messager.alert('提示','请输入密码!','info',function(){
		//	$(p_id).focus();
		//});
		return false;
	} 
	var yzm = $("#yzm").val(); 
	if (yzm == "") {
		alert('请输入验证码!');
		$("#yzm").focus();
		//$.messager.alert('提示','请输入验证码!','info',function(){
		//	$("#yzm").focus();
		//});
		return false;
	}
	
	$("#dl").disabled = true;
	var formData = {
		"username": username,
		"passwd": hex_md5(userpwd),
		"userkind": $("#userkind").val(),
		"yzm": yzm
	};
	$.ajax({
		url: basePath + "/login/verify",
		type: 'post',
		async: true,
		cache: false,
		timeout: 100000,
		data: formData,
		dataType: 'json',
		error: function() {
			layer.alert('提示','服务器繁忙，请稍后再试！' + result.msg, {
				skin: 'layui-layer-molv' //样式类名  自定义样式
				,closeBtn: 1    // 是否显示关闭按钮
				,anim: 1 //动画类型
				,icon: 2   // icon
			});
		},
		success: function(result) {
			if (result.code == 0) {
				layer.closeAll()
			} else {
				layer.alert('提示!'+'解锁登录失败！' + result.msg, {
					skin: 'layui-layer-molv' //样式类名  自定义样式
					,closeBtn: 1    // 是否显示关闭按钮
					,anim: 1 //动画类型
					,icon: 2   // icon
				});
			}
		}
	});
}

function changeImage(obj){ 
	obj.src = sy.contextPath + '/servlet/CodeServlet?' + Math.random(); 
}


//修改密码
function modifyPwd() {	
	var passwd = $('#passwd').val();
	var passwd2 = $('#passwd2').val();
	if (passwd == "") {
		alert('请输入原密码!');
		$('#passwd').focus();
		return false;
	}
	if (passwd2 == "") {
		alert('请输入新密码!');
		$('#passwd2').focus();
		return false;
	} 
	var formData = {
		"passwd": hex_md5(passwd),
		"passwd2": hex_md5(passwd2)
	};
	$.ajax({
		url: basePath + "/login/modifyPwd",
		type: 'post',
		async: true,
		cache: false,
		timeout: 100000,
		data: formData,
		dataType: 'json',
		error: function() {
			layer.alert('提示','服务器繁忙，请稍后再试！', {
				skin: 'layui-layer-molv' //样式类名  自定义样式
				,closeBtn: 0    // 是否显示关闭按钮
				,anim: 1 //动画类型
				,icon: 2   // icon
			});
		},
		success: function(result) {
			if (result.code == 0) {
				layer.alert('提示！修改密码成功！', {
					skin: 'layui-layer-molv' //样式类名  自定义样式
					,closeBtn: 0    // 是否显示关闭按钮
					,anim: 1 //动画类型
					,icon: 2   // icon
				});
			} else {
				layer.alert('提示！修改密码失败！' + result.msg, {
					skin: 'layui-layer-molv' //样式类名  自定义样式
					,closeBtn: 1    // 是否显示关闭按钮
					,anim: 1 //动画类型
					,icon: 1   // icon
				});
			}
		}
	});
}