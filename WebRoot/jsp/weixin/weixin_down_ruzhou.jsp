<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser,com.zzhdsoft.utils.SysmanageUtil" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String url="http://125.46.93.126:8080/syjzhpt/app/syjgruzhou.apk";
String v_title="请点击下载汝州食药监手机APP";

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
