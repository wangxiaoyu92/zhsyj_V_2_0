<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<%
Cookie temp = null;
String ls_username="";
Cookie[] cookies = request.getCookies();
if(cookies!=null){
	int cookielen = cookies.length;
	if(cookielen != 0){
	   for (int i = 0; i < cookielen; i++){
	     temp = cookies[i];
	     if(temp.getName().equals("spsy_username"))
	         ls_username=temp.getValue();
	  }
	}
}
 %>
<head>
<link rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>安盛食品安全追溯监管平台</title>
  <jsp:include page="inc.jsp"></jsp:include>
<style>
.inputtxt{
    display:block;
    width:129px;
    padding-left:2px;
    font-size:12px;
	color:#ffffff;
    height:16px;
    line-height:16px;
    border:0px;
	background:transparent;
}
a:link{color:#fff;}
a:visited{color:#fff;}
a:hover{color:orange;}
a:link{color:#fff;}
</style>
<script language="JavaScript">
if (window != top)
top.location.href = location.href;
</script>
	
<SCRIPT language="JavaScript">
function changeImage(obj){ 
	// Math.random() is must. 
	obj.src = '<%=request.getContextPath()%>/servlet/CodeSevlet?' + Math.random(); 
}
function clearForm(){
	$("#userPwd").val('');
	$("#userYzm").val('');
}
function checkform(){
	 var username=$("#userName").val();
	 var userpwd=$("#userPwd").val();
	 var useryzm=$("#userYzm").val();
	 if (username==""){
	    alert("请输入用户名!");
	    $("#userName").focus();
	    return false;
	 }
	 if (userpwd==""){
	    alert("请输入密码!");
		$("#userPwd").focus();
	    return false;
	 }
	  if (useryzm=="" || useryzm.length<6){
	    alert("请输入验证码!");
		$("#userYzm").focus();
	    return false;
	 }
	 $("#login_info").html("<img src='login_images/loading-balls.gif' /><br/>登录检测中...");
	 var formData=$("#myform").serialize();
	 $.ajax({
		url:"frame/user_login.action?time="+new Date().getMilliseconds(),
		type:'post',
		async:true,
		cache:false,
		timeout: 100000,
		data:formData,
		error:function(){
		   alert("服务器繁忙，请稍后再试！");
		},
		success: function(result){
		   if(result=="1"){
		      window.location.href="./frame/index.html";
		   }else if(result=="3"){
		      $("#login_info").html("<font color=red><img src='login_images/cry.gif' />对不起,您输入的验证码错误!</font>");
		   }else if(result=="2"){
		      $("#login_info").html("<font color=red><img src='login_images/cry.gif' />对不起,禁止非法登录!</font>");
		   }else{
		     $("#login_info").html("<font color=red><img src='login_images/cry.gif' />对不起,用户名或者密码错误，可能此用户已经被锁定,或者企业尚未被审核!</font>");
		   }
	 }
	});
}

function addfocus(){
   $("#userName").focus();
}
</script>
</head>
<body bgcolor="#026aa9" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow:hidden" onload="addfocus()">
<form id="myform" method="post" onkeydown="if(event.keyCode==13)if(!checkform())return false;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td align="center" valign="middle">
<table  width="1012" height="586" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5">
			<img src="login_images/login_01.jpg" width="1012" height="269" alt=""></td>
	</tr>
	<tr>
		<td rowspan="6">
			<img src="login_images/login_02.jpg" width="447" height="318" alt=""></td>
		<td colspan="2" width="133" height="20" style="background:url(login_images/login_03.jpg) no-repeat">
			<input type="text" class="inputtxt" id="userName" name="userName" value="<%=ls_username %>"/>
		</td>
		<td colspan="2" rowspan="2">
			<img src="login_images/login_04.jpg" width="432" height="48" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" width="133" height="28" style="background:url(login_images/login_05.jpg) no-repeat">
			<input type="password" id="userPwd" name="userPwd" value="" style="width:129px; border:0px; background:transparent; color:#FFFFFF; padding-left:2px;font-size:12px;"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" width="133" height="28" style="background:url(login_images/login_06.jpg) no-repeat" valign="absmiddle">
			<input type="text" id="userYzm" name="userYzm" maxlength="6" value="" style="width:129px;height:28px;line-height:28px; border:0px; background:transparent; color:#FFFFFF; padding-left:2px;padding-top:2px;font-size:14px;"/>
		</td>
		<td rowspan="2" valign="top" width="170" height="52" style="background:url(login_images/login_07.jpg)">
			<img src="servlet/CodeSevlet" width="165" id="yzmimg" border="0" onclick="changeImage(this)" alt="请输入此验证码，如看不清请点击刷新。" style="cursor:pointer" />
		</td>
		<td rowspan="4">
			<img src="login_images/login_08.jpg" width="262" height="270" alt=""></td>
	</tr>
	<tr>
		<td width="65" height="22" background="login_images/login_09.jpg">
			<input type="button" style="width:65;cursor:hand;height:22; border:0; background:transparent;" onclick="checkform()">	
		</td>
		<td width="68" height="22" background="login_images/login_10.jpg">
			<input type="button" style="width:65;cursor:hand;height:22; border:0; background:transparent;" onclick="clearForm()">	
		</td>
	</tr>
	<tr>
		<td colspan="3" width="303" height="59" style="background:url(login_images/login_11.jpg)">
			<div id="login_info" color="red" style="widht:100%;font-size:12px;color:red;" style="float:left;"></div>
		</td>
	</tr>
	<tr>
		<td colspan="3" width="303" height="156" style="background:url(login_images/login_12.jpg) repeat-y;">
		<a href="index.html" target="_self" style="text-decoration:none">返回追溯平台首页</a>
		</td>
	</tr>
</table>

</td>
</tr>
</table>
</form>
</body>
</html>