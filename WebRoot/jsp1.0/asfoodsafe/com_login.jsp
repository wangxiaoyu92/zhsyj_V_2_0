<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品安全溯源平台--企业登录</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jslib/jquery-easyui/jquery-1.7.2.min.js"></script>
</head>
<script type="text/javascript">
function changeImage(obj){ 
	// Math.random() is must. 
	obj.src = '<%=request.getContextPath()%>/servlet/CodeSevlet?' + Math.random(); 
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
	    alert("请输入6位验证码!");
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
		   }else{
		     $("#login_info").html("<font color=red><img src='login_images/cry.gif' />对不起,用户名或者密码错误，可能此用户已经被锁定!</font>");
		   }
	 }
	});
}

function addfocus(){
   $("#userName").focus();
}

$(function(){
	addfocus();
});
</script>
<body>
<div class="headbg"></div>
<div class="loginmain">
<table border="0" cellpadding="0" cellspacing="0" align="center">	
	<tr>
		<td>
			<img src="images/clz.jpg" width="533" height="363" alt=""></td>
		<td>			
	<form id="myform" method="post" onkeydown="if(event.keyCode==13)if(!checkform())return false;">
	<table width="402px" height="300px" border="0" cellpadding="0" cellspacing="0" style="line-height:30px;">
		<tr>
			<td valign="absmiddle"><img src="images/login_title.jpg" />
		</tr>
		<tr>
			<td valign="absmiddle"><font class="loginText">用户名：</font><input type="text" id="userName" name="userName" value="<%=ls_username %>" class="fm-text"/>
		</tr>
		<tr>
			<td><font class="loginText">密&nbsp;&nbsp;&nbsp;码：</font><input type="password" id="userPwd" name="userPwd" value="" class="fm-text" />
			</td>
		</tr>
		<tr>
			<td><font class="loginText">验证码：</font>
			<input type="text" id="userYzm" name="userYzm" value="" maxlength="6" class="fm-text2"/>
			<img src="servlet/CodeSevlet" id="yzmimg" border="0" onclick="changeImage(this)" alt="请输入此验证码，如看不清请点击刷新。" style="cursor:pointer" />
			</td>
		</tr>
		<tr>
		   <td align="left">
		    <input type="button" value="登 录" class="inp_L1" onMouseOver="this.className='inp_L2'" onMouseOut="this.className='inp_L1'" id="input_btn1 deluinput" tabindex="4" onclick="checkform()"/>&nbsp;&nbsp;
            <input value="重　置" class="inp_L1" onMouseOver="this.className='inp_L2'" onMouseOut="this.className='inp_L1'" id="input_btn2"  tabindex="5"  type="reset" />
		</td>
		</tr>
		<tr>
			<td>没有账号？<a href="com_register.jsp">注册加入</a></td>
		</tr>
		<tr>
			<td><div id="login_info" color="red" style="widht:100%;font-size:12px;color:red;" style="float:left;"></div>
		</td>
		</tr>
	</table>
	</form>
        </td>		
	</tr>	
	</table>
</div>

<div id="footer">
	<div id="ftinfo">
	FTS食品安全追溯平台 CopyRight @Right 2014<br/>
	郑州华东计算机系统工程有限公司&nbsp;&nbsp;联系电话：0371-65751486 &nbsp;&nbsp;传真：0371-67993333<br/>
    网址：http://www.zzhdsoft.com&nbsp;&nbsp; 豫ICP备XXXXXXXXXX号	
	</div>
</div>
</body>
</html>