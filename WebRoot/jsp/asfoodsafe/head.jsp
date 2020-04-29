<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台--食品安全系民生，安盛溯源伴您行！</title>
<meta name="keywords" content="安盛，食品，食品安全，食品追溯，食品溯源，食品安全监管，食品追溯平台，食品溯源平台，安盛食品追溯，安盛食品溯源" />
<meta name="description" content="安盛，食品，食品安全，食品追溯，食品溯源，食品安全监管，食品追溯平台，食品溯源平台，安盛食品追溯，安盛食品溯源" />
<link href="<%=contextPath %>/jsp/asfoodsafe/images/base.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath %>/jsp/asfoodsafe/images/style.css" rel="stylesheet" type="text/css" />
<script src="<%=contextPath %>/jsp/asfoodsafe/js/jquery-1.12.0.min.js"></script>
<script src="<%=contextPath %>/jsp/asfoodsafe/js/common.js"></script>
<script src="<%=contextPath %>/jsp/asfoodsafe/js/custom.js"></script>
<script type="text/javascript" language="javascript">
function qiehuan(num){
	for(var id=0;id<=7;id++){
		if(id==num){
			$("#mynav"+id).attr('className','nav_on');
			$("#qh_con"+id).css('display','block');
		}else{
			$("#mynav"+id).attr('className','');
			$("#qh_con"+id).css('display','none');
		}
	}
}
//加入收藏夹
function addFav(url,title) {  
    if  (document.all) {   
       window.external.addFavorite(url,title);   
     }else if(window.sidebar) {   
        window.sidebar.addPanel(title,url,"");   
     }   
} 

//查询追溯码是否存在
function queryData(){
	var query_zsm = $('#query_zsm').val();
	if(query_zsm.length<=0){
		alert('请输入溯源码！');
		$('#query_zsm').focus();
		return false;
	}
	if(query_zsm.length>0){
  		var url = "sym_query.jsp?sym="+query_zsm;
  		window.open(url);
  	}
}
</script>
</head>
<body>   
<div id="toptools">
  <div class="wrap-w">
    <ul id="toptools-l">
<%
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
	String ls_username = "";	
	if(sysuser != null){
		ls_username = StringHelper.showNull2Empty(sysuser.getUsername());
%>
        <li>您好，欢迎【<font style="color:red;font-weight:600"><%=ls_username%></font>】光临安盛食品安全追溯平台！</li>
        <li><a href="<%=contextPath %>/jsp/asfoodsafe/user_login.jsp" style="color:blue;font-weight:600">管理中心</a></li>
        <li><a href="<%=contextPath%>/login/logout" style="color:blue;font-weight:600">退出系统</a></li>
<% }else{%>
        <li>您好，欢迎来到安盛食品安全追溯平台！</li>
		<li><a href="<%=contextPath %>/jsp/asfoodsafe/user_login.jsp">[请登录]</a></li>
<!-- 		<li><a href="com_register.jsp">[免费注册]</a></li> -->
<%}%>
    </ul>
    <ul id="toptools-r">
      <li><a href=""><img src="<%=contextPath %>/jsp/asfoodsafe/images/weixin.png"/>微信我们</a></li>
      <li><a href=""><img src="<%=contextPath %>/jsp/asfoodsafe/images/tel.png" />400-888-6785</a></li>
      <li><a href="#" onclick="javascript:addFav('http://www.asfoodsafe.com/', '安盛食品安全溯源平台');return false">加入收藏</a></li>
	  <li><a href="#" onClick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.asfoodsafe.com')" >设为首页</a></li>
    </ul>
  </div>
</div>

<div id="logo_query">
<div id="com_logo_left">  <img src="<%=contextPath %>/jsp/asfoodsafe/images/logo.jpg" title="安盛LOGO"/> </div>

<div id="query_right">
	<form id="myform" action="" method="post">
		<font style="font-size:14px;">请输入产品溯源码:如</font>
		<input type="text" id="query_zsm" name="query_zsm" value="" placeholder="169579431000560000010000000012"/>
		<a class="searchSym" href="javascript:void(0)" onclick="queryData()">查询一下</a>
	</form>
</div>


<!-- 导航菜单 -->
<div id="menu_out">
	<div id="menu_in">
		<div id="menu">
			<ul id="nav">
			<li><a href="<%=contextPath %>/jsp/asfoodsafe/index.jsp" onmouseover="javascript:qiehuan(0)" id="mynav0" class="nav_on" ><span>网站首页</span></a></li>
			<li class="menu_line"></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=2017062317020149685258464')" onmouseover="javascript:qiehuan(1)" id="mynav1" class="nav_off"><span>关于平台</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="<%=contextPath %>/jsp/asfoodsafe/xwdt_index.jsp" onmouseover="javascript:qiehuan(2)" id="mynav2" class="nav_off"><span>新闻动态</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=社会监督&catejc=shjd')" onmouseover="javascript:qiehuan(3)" id="mynav3" class="nav_off"><span>社会监督</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/com_list.jsp?currlocation=追溯企业')" onmouseover="javascript:qiehuan(4)" id="mynav4" class="nav_off"><span>溯源企业</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="<%=contextPath %>/jsp/asfoodsafe/zst.jsp" onmouseover="javascript:qiehuan(5)" id="mynav5" class="nav_off"><span>追溯通</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="<%=contextPath %>/jsp/asfoodsafe/zcfg_index.jsp" onmouseover="javascript:qiehuan(6)" id="mynav6" class="nav_off"><span>政策法规</span></a></li>
			
			<li class="menu_line"></li>
			<li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp" onmouseover="javascript:qiehuan(7)" id="mynav7" class="nav_off"><span>追溯产品</span></a></li>
			</ul>
		<div id="menu_con">

<!--第一个菜单的子菜单-->
<div id=qh_con0 style="display: block">
<ul>
<!-- 
  <li><a href="#"><span>栏目名称1</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称2</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称3</span></a></li>
-->
</ul>
</div> 
<!--第二个菜单的子菜单-->
<div id=qh_con1 style="display: none">
<ul>
<!--
  <li><a href="#"><span>栏目名称4</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称5</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称6</span></a></li>
-->
</ul>
</div> 
<!--第三个菜单的子菜单-->
<div id=qh_con2 style="display: none">
<ul>
  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=国内动态&catejc=gndt')"><span>国内动态</span></a></li>
  <li class=menu_line2></li>

  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=国际动态&catejc=gjdt');"><span>国际动态</span></a></li>
  <li class=menu_line2></li>
  
  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=权威发布&catejc=qwfb');"><span>权威发布</span></a></li>
  <li class=menu_line2></li>
  
  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=食品科技&catejc=spkj')"><span>食品科技</span></a></li>
</ul>
</div> 
<!--第四个菜单的子菜单-->
<div id=qh_con3 style="display: none">
<ul>
<!--
  <li><a href="#"><span>栏目名称10</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称11</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称12</span></a></li>
-->
</ul>
</div> 
<!--第五个菜单的子菜单-->
<div id=qh_con4 style="display: none">
<ul>
<!--
  <li><a href="#"><span>栏目名称13</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称14</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称15</span></a></li>
-->
</ul>
</div>
<!--第六个菜单的子菜单-->
<div id=qh_con5 style="display: none">
<ul>
<!--
  <li><a href="#"><span>栏目名称16</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称17</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称18</span></a></li>
-->
</ul>
</div>
<!--第七个菜单的子菜单-->
<div id=qh_con6 style="display: none">
<ul>
  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=国家政策法规&catejc=gjzc');"><span>国家政策法规</span></a></li>
  <li class=menu_line2></li>

  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=地方政策法规&catejc=dfzc');"><span>地方政策法规</span></a></li>
  <li class=menu_line2></li>
<!-- 
 <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=行政许可&catejc=xzxk');"><span>行政许可</span></a></li>
 <li class=menu_line2></li>
--> 
  <li><a href="javascript:linkToSelf('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=行业标准&catejc=hybz');"><span>行业标准</span></a></li>
</ul>
</div>
<!--第八个菜单的子菜单-->
<div id=qh_con7 style="display: none">
<ul>
  <li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp?ver=zzb"><span>食品安全管理系统(种植版)</span></a></li>
  <li class=menu_line2></li>

  <li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp?ver=yzb"><span>食品安全管理系统(养殖版)</span></a></li>
  <li class=menu_line2></li>

  <li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp?ver=ltb"><span>食品安全管理系统(流通版)</span></a></li>
  <li class=menu_line2></li>
  
  <li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp?ver=cyb"><span>食品安全管理系统(餐饮版)</span></a></li>
  <li class=menu_line2></li>
  
  <li><a href="<%=contextPath %>/jsp/asfoodsafe/zscp_index.jsp?ver=rp"><span>乳品安全管理系统</span></a></li>  
</ul>
</div>

<!--第九个菜单的子菜单
<div id=qh_con8 style="display: none">
<ul>
  <li><a href="#"><span>栏目名称25</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称26</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称27</span></a></li>
</ul>
</div>
-->
<!--第十个菜单的子菜单
<div id=qh_con9 style="display: none">
<ul>
  <li><a href="#"><span>栏目名称28</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称29</span></a></li>
  <li class=menu_line2></li>

  <li><a href="#"><span>栏目名称30</span></a></li>
</ul>
</div>
-->
</div>
</div>
</div>
</div>