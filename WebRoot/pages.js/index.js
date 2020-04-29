
$(function() {
	if(yzmSwitch=="0"){
		$("#tab_1").hide();
		$("#div_1").hide();
		switch_tab(2);
	}else{		
		switch_tab(1);	
	}
});

//重置
var reset2 = function() {
	$('#fm1').form('clear');
	$('#fm2').form('clear');
};

//切换图片及登录输入框
var curtab_index = 1; 
function switch_tab(i) {
	curtab_index = i;
	var n = 1;
	for (n = 1; n <= 2; n++) {
		var name = "#tab_" + n;
		var classes = "";
		if (n != curtab_index) {
			classes = 'tdbg_' + n + '_1';
			$("#div_" + n).hide();
		} else {
			classes = 'tdbg_' + n + '_2';
			$("#div_" + n).show();
		}
		$(name).removeClass();
		$(name).addClass(classes);
	} 
	//重置
	reset2();
	if(curtab_index == 1){//密码登录		
		$('#userName_'+i).focus();
	}else if(curtab_index == 2){
		changeQrcode($("#qrcodeImg")[0]);//扫码登录
	}	
}

function onEnter() {
	if (event.keyCode == 13) {
		checkform();
	}
}
function checkform() {	
	var n_id = "#userName_" + curtab_index;
	var p_id = "#userPwd_" + curtab_index;
	var username = $(n_id).val();
	var userpwd = $(p_id).val();
	var systemcode = $('#systemcode').val();
	if (username == "") {
		//alert('请输入用户名!');
		//$(n_id).focus();
		$.messager.alert('提示','请输入用户名!','info',function(){
			$(n_id).focus();
		});
		return false;
	}
	if (userpwd == "") {
		//alert('请输入密码!');
		//$(p_id).focus();
		$.messager.alert('提示','请输入密码!','info',function(){
			$(p_id).focus();
		});
		return false;
	} 
 
	var yzm = $("#yzm").val();
	if (yzm == "") {
		//alert('请输入验证码!');
		//$("#yzm").focus();
		$.messager.alert('提示','请输入验证码!','info',function(){
			$("#yzm").focus();
		});
		return false;
	}

	$("#dl").disabled = true;
	$("#btn_div").hide();
	$("#loading-mask").show();
	var formData = {
		"username": username,
		"passwd": hex_md5(userpwd),
		"userkind": curtab_index,
		"yzmId": $("input[name='yzmId']").val(),
		"yzm": yzm,
		"systemcode": systemcode
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
			$.messager.alert('提示','服务器繁忙，请稍后再试！','info',function(){
				$("#dl").disabled = false;
				$("#btn_div").show();
				$("#loading-mask").hide();
			});			
		},
		success: function(result) {
			if (result.code == 0) {
				window.location.href = basePath + "login/gohome";
			} else {
				$.messager.alert('提示','登录失败！' + result.msg,'error',function(){
					$("#dl").disabled = false;
					$("#btn_div").show();
    				$("#loading-mask").hide();	
				});	
			}
		}
	});
}


//动态获取验证码（暂未使用）
var b_clicked = false;
var i_timer;
var i_cnt = 0;
var i_reset_sec = 60;
function getYzm() {
	var n_id = "#userName_" + curtab_index;
	var p_id = "#userPwd_" + curtab_index;
	var username = $(n_id).val();
	var userpwd = $(p_id).val();
	if (username == "") {
		//alert('请输入用户名!');
		//$(n_id).focus();
		$.messager.alert('提示','请输入用户名!','info',function(){
			$(n_id).focus();
		});
		return false;
	}
	if (userpwd == "") {
		//alert('请输入密码!');
		//$(p_id).focus();
		$.messager.alert('提示','请输入密码!','info',function(){
			$(p_id).focus();
		});
		return false;
	} 
	if (b_clicked) return;
	b_clicked = true;
	i_timer = setInterval("cnt_timer()", 1000);
	var formData = {
		"username": username,
		"passwd": hex_md5(userpwd),
		"userkind": curtab_index
	};
	$.ajax({
		url: basePath + "/common/userreg/getVerifyCode",
		type: 'post',
		async: true,
		cache: false,
		data: formData,
		dataType: 'json',
		error: function() {
			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');
		},
		success: function(result) {
			//alert(r.yzmId);
			$("#yzmId").val(result.yzmId);
		}
	});
} 
// 倒计时
function cnt_timer() {
	var y_id = "#yzmBtn";
	i_cnt = i_cnt + 1;
	$(y_id).html('(' + (i_reset_sec - i_cnt) + ')秒后可重新获取');
	if (i_cnt >= i_reset_sec) {
		clearInterval(i_timer);
		i_cnt = 0;
		b_clicked = false;
		$(y_id).html('<img src="' + basePath + '/images/login/hqyzm.png"/>');
	}
}

//刷新验证码
function changeImage(obj){ 
	obj.src = contextPath + '/servlet/CodeServlet?' + Math.random(); 
}


var release = null;
var timerstop = null;
//刷新登录二维码
function changeQrcode(obj){ 
	clearInterval(release);
	clearInterval(timerstop);
	$("#timeText").text(60);
	$("#stateText").text("二维码有效时长一分钟");
	release = setInterval(checkstate,1000);
	timerstop = setInterval(changetime,1000);
	obj.src = contextPath + '/servlet/QRCodeServlet?' + Math.random(); 
}

function changetime(){
	var time = $("#timeText").text();
	if(time-1>=0){
		$("#timeText").text(time-1);
	}else{
		$("#timeText").text(0);
		clearInterval(timerstop);
	}	
}

var jump2MainPage = function(){
	window.location.reload(true);
}

var checkstate = function(){
	$.ajax({
		url: basePath + "login/checkStat",
		type: 'post',
		async: true,
		cache: false,
		dataType: 'json',
		error: function() {
			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');
		},
		success: function(result) {
			if(result.code=='0'){
				if(result.STAT=='200'||result.STAT=='100'||result.STAT=='1031'){
					if(result.STAT=='200'){
						$("#stateText").text("正在进行授权登陆...");
						jump2MainPage();
					}else if(result.STAT=='1031'){
						$("#timeText").text(0);
						$("#qrcodeImg").attr("src", basePath + "images/login/qrcodefalse.png");
						clearInterval(release);
						clearInterval(timerstop);
					}
				}else{
					$.messager.alert('提示',result.STAT+result.MSG,'info');
					clearInterval(release);
					clearInterval(timerstop);
				}				
			} else {
				$.messager.alert('提示','二维码授权登录失败！' + result.msg,'error',function(){
					clearInterval(release);
					clearInterval(timerstop);
				});	
			}
		}
	});
}