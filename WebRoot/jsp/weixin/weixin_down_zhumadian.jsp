<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser,com.zzhdsoft.utils.SysmanageUtil" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
//String ls_aaa027 = sysuser.getAaa027().toString().substring(0,4);
String url="http://42.236.68.36:8080/syjzhpt/app/syjgzhumadian.apk";
String v_title="请点击下载驻马店食药监手机APP";


/*if (ls_aaa027!=null && "4117".equalsIgnoreCase(ls_aaa027)){//驻马店
	url="http://192.168.1.13:8080/syjzhpt/download/syjzhpt.apk";
	v_title="请点击下载驻马店食药监";
}
if (ls_aaa027!=null && "4105".equalsIgnoreCase(ls_aaa027)){//汤阴
	url="http://192.168.1.13:8080/syjzhpt/download/syjzhpt.apk";
	v_title="请点击下载驻马店食药监";
}
if (ls_aaa027!=null && "4114".equalsIgnoreCase(ls_aaa027)){//商丘
	url="http://192.168.1.13:8080/syjzhpt/download/syjzhpt.apk";
	v_title="请点击下载驻马店食药监";
}*/


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>应用下载</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta http-equiv="description" content="应用下载">
	<link rel="stylesheet" href="weixin/css/app.css" type="text/css" />
	<script src="weixin/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
  </head>
  
  <body class="success">
   <div class="page-wrap">
		<div class="info">
			<div class="ok-btn"><img src="<%=basePath %>/jsp/weixin/img/logo.png" alt="安盛科技" ></div>
<!-- 			<p class="entry-con">感谢您本公司研发的手机客户端</p> -->
<!-- 			<h2 class="entry-hd">恭喜注册成功</h2> -->
<!-- 			<ul class="info-list"> -->
<!-- 				<li>您的健康档案账号：15507621887</li> -->
<!-- 				<li>您的健康档案密码：621887</li> -->
<!-- 			</ul> -->
		</div>
		
		<div class="download">
			<h3 class="entry-hd" ><%=v_title %></h3>
            <div class="entry-hd" >
			<a href="<%=url %>" class="android-btn" id="J_weixin">
			<img src="<%=basePath %>/jsp/weixin/img/android-btn.png" alt="安卓版下载"></a>
			</div>
		</div>
		<div class="app">
<!-- 		请致电：400-888-6785 -->
			<img src="<%=basePath %>/jsp/weixin/img/app.jpg" alt="应用预览">
			<p class="entry-con">下载完成后，根据自己的账号登录客户端<br/>如有下载或使用过程中遇到困难，请联系管理员</p>
		</div>
		<div class="footer-bg" id="footer-info" style="display: block">
			<p class="entry-con">注：微信用户请在右上角选择“在浏览器中打开”，再选择下载应用</p>
		</div>
	</div>
	<div id="weixin-tip"><p><img src="<%=basePath %>/jsp/weixin/img/live_weixin.png" alt="微信打开"/><span id="close" title="关闭" class="close" >X</span></p></div>
 <script type="text/javascript"> 
var is_weixin = (function(){return navigator.userAgent.toLowerCase().indexOf('micromessenger') !== -1})();
window.onload = function() { 
	var winHeight = typeof window.innerHeight != 'undefined' ? window.innerHeight : document.documentElement.clientHeight; //兼容IOS，不需要的可以去掉
	var btn = document.getElementById('J_weixin');
	var tip = document.getElementById('weixin-tip');
	var close = document.getElementById('close');
	//是微信
	if (is_weixin) {
	$('#footer-info').css('display','');
		btn.onclick = function(e) {
			tip.style.height = winHeight + 'px'; //兼容IOS弹窗整屏
			tip.style.display = 'block';
			return false;
		}
		close.onclick = function() {
			tip.style.display = 'none';
		}
	}else{
	var url ="<%=url %>";
//     window.open(url);
 window.location.href=url;
	}
}    
</script>
 </body>
</html>
