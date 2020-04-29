<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*"%>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<%
	String ver = (null == request.getParameter("ver"))
			? "zzb"
			: request.getParameter("ver").toString();
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-追溯通介绍</title>
<jsp:include page="head.jsp"></jsp:include>
<link href="images/nav.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.nav.js"></script>
<script>
	function closediv(domid) {
		document.getElementById(domid).style.display = 'none';
	}
</script>
</head>
<body>
<div class="mainbody" style="margin:5 8px 0;border:1px solid #cdcdcd;">
<div class="info_title">一、什么是追溯通?</div>
<p class="info_content">
	追溯通是河南安盛科技股份有限公司专门针对食品企业开发的一款专业软件产品，它以追溯技术为核心，通过软件与服务的完美结合，为企业提供软硬件产品、解决方案、管理平台及服务。
	<br />
	&nbsp;&nbsp;&nbsp;&nbsp;它通过与众多食品企业合作，由企业把其产品严格、规范的管理操作追溯信息录入系统平台，从而实现产品信息的全程可追溯；同时消费者用手机，扫描购买到的产品上的粘贴的食品安全追溯标签二维码，
	获得所购产品的追溯信息，在享受知情权、参与监督的同时，又使其权益得到保障，真正达到“买得放心，吃的安心”！ <br /> <img
		src="images/zst.jpg" style="margin-left:150px;" />
</p>

<div class="info_title">二、为什么要用追溯通?</div>
<p class="info_content">
	<span class="info_tip">企业</span>: 有诚信和品牌意识的企业,需要提升产品质量安全管理水平;
	优质、安全的产品及农产品无法向消费者展示和转播。
</p>
<p class="info_content">
	<span class="info_tip">消费者：</span>无法获取食品质量详细信息,无法判断食品是否安全、营养。
</p>

<div class="info_title">三、使用追溯通有什么好处?</div>
<p class="info_content">
	<span class="info_tip">企业</span>:
	使用追溯通可以规范企业管理，提升产品附加和竞争力，赢得消费者认可，赢得更广阔的市场！ <img src="images/001.jpg" />
	<img src="images/gfgl.jpg" /> <img src="images/ppbh.jpg" />
</p>
<p class="info_content">
	<span class="info_tip">消费者</span>: 买得放心 ，吃的安心 享受到知情权，参与监督 权益得到保障 <img
		src="images/axc.jpg" />
</p>

<div class="info_title">四、追溯通有哪些产品特点?</div>
<div class="info_content_li">
	<ul>
		<li>设计人性化，操作易用性</li>
		<li>任何时候，任意地点上传产品信息</li>
		<li>提供多种追溯查询平台（手机扫描二维码、网络、微信）</li>
	</ul>
</div>

<div class="info_title">五、怎么开通使用追溯通?</div>
<div class="info_content_li">
	<ul>
		<li>通过本网站顶部的[免费注册]自行注册开通</li>
		<li>拨打追溯热线400-888-6785联系开通</li>
		<li>点击本页面右面的在线客服中心，联系在线客服开通</li>
	</ul>
</div>
<%@ include file="footer.jsp"%>
</body>
</html>