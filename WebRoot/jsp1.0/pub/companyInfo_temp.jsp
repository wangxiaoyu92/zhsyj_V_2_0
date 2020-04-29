<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.askj.baseinfo.dto.PcompanyDTO" %>
<%@ page import="com.askj.tmsyj.tmsyj.dto.HjyjczbmxbDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
			
	// 企业信息
	// PcompanyDTO v_com = (PcompanyDTO)request.getAttribute("comInfo");
	// 快检信息
	// List v_kjInfo = (List)request.getAttribute("kjList");
	
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>企业信息</title>
<style>
	/*初始化*/
	*{ margin: 0; padding: 0;list-style: none;}	
	body{ font-family:"微软雅黑",Arial,Sans-Serif;font-size: 16px;max-width: 1024px; margin: 0 auto;}
	img{ border:none; display: block;}
	/*开始*/
	.box{ width: 100%; overflow: hidden;}
	.box_img{ width: 20%; overflow: hidden; float: left;}
	.box img{ width:100%;    margin:0 auto; float: left}
	/*企业基本信息*/
	.jbxx{ width: 100%; /*margin: 10px 0 0 10px;*/ float: left; }
	.jbxx_title { font-size:20px; text-align: center; line-height: 44px; color: white; background-color: cornflowerblue;}
	.jbxx img{ width:100%; float: left; max-height: 240px;}
	.jbxx li{ border-bottom: solid 1px #ccc; overflow: hidden; padding: 0 10px;}
	.jbxx li p,span{ float:left; line-height: 34px;}
	.jbxx li p{ width:34%; color: #666;}
	.jbxx li span{ width:58%; }
	/*快捡记录*/
	.kjjl{ width: 100%; float: left;    margin: 16px 0 0 0;}
	.kjjl li{ margin-bottom: 10px;}
	.kjjl .kjjl_title{ font-size:20px; text-align: center; line-height: 44px; color: white; background-color: cornflowerblue;    margin: 0 0 10px 0;}
	.kjjl .kjjl_content{ border: solid 1px #ccc; width: 94%; margin: 0 auto; border-radius: 2%;}
	.kjjl .kjjl_content li{ padding:0 10px; overflow: hidden;}
	.kjjl .kjjl_content li p,span{ float:left; line-height: 34px; }
	.kjjl .kjjl_content li p{ width:35%; color: #666;}
	.kjjl .kjjl_content li span{ width:58%}
</style>
</head>
<body>
	<div class="box">
		<div class="jbxx_title">企业基本信息</div>
		<div class="jbxx">
			<ul>
				<li style="padding: 0;">
					<c:if test="${not empty comInfo.icon}">
						<img src="<%=basePath%>${comInfo.icon}"> 
					</c:if>
					<c:if test="${empty comInfo.icon}">
						<img src="<%=basePath%>images/noimg.gif"}"> 
					</c:if>
				</li>
				<li>
					<p>企业名称：</p>
					<span>${comInfo.commc}</span>
				</li>
				<li>
					<p>企业法人：</p>
					<span>${comInfo.comfrhyz}</span>
				</li>
				<li>
					<p>企业地址</p>
					<span>${comInfo.comdz}</span>
				</li>
				<li style="border:none;">
					<p>联系电话</p>
					<span>${comInfo.comyddh}</span>
				</li>
			</ul>
		</div>
		<%-- <ul class="kjjl">
			<li class="kjjl_title">企业许可证</li>
			<% for (int k = 0; k < v_xkzInfo.size(); k++){
             PcompanyXkzDTO dto = (PcompanyXkzDTO)v_xkzInfo.get(k);
      		%>
			<li>
				<ul  class="kjjl_content">
					<li>
						<p>许可证类型：</p>
						<span><%=dto.getComxkzlxstr()%></span>
					</li>
					<li>
						<p>许可证编号：</p>
						<span><%=dto.getComxkzbh()%></span>
					</li>
					<li>
						<p>许可范围：</p>
						<span><%=dto.getComxkfw()%></span>
					</li>
					<li>
						<p>许可证有效期起：</p>
						<span><%=dto.getComxkyxqq()%></span>
					</li>
					<li border:none;>
						<p>许可证有效期止：</p>
						<span><%=dto.getComxkyxqz()%></span>
					</li>
				</ul>
			</li>
			<%} %> 
		</ul> --%>
		<div class="kjjl">
			<div class="kjjl_title">快捡记录</div>
			<ul>
      		<c:forEach items="${kjList}" var="kj">
			<li>
				<ul class="kjjl_content">
					<li>
						<p>商户名称：</p>
						<span>${kj.hviewjgztmc}</span>
					</li>
					<li>
						<p>所属市场：</p>
						<span>${kj.hviewjgztmc}</span>
					</li>
					<li>
						<p>检测商品：</p>
						<span>${kj.jcypmc}</span>
					</li>
					<li>
						<p>检测项目：</p>
						<span>${kj.jcxmmc}</span>
					</li>
					<li>
						<p>检测值：</p>
						<span>${kj.jcz}</span>
					</li>
					<li>
						<p>标准值：</p>
						<span>${kj.bzz}</span>
					</li>
					<li>
						<p>检测结果：</p>
						<span>${kj.jyjcjlinfo}</span>
					</li>
					<li>
						<p>检测机构：</p>
						<span>${kj.jcorgmc}</span>
					</li>
					<li>
						<p>检测人：</p>
						<span>${kj.jcrymc}</span>
					</li>
					<li>
						<p>检测时间：</p>
						<span>${kj.jyjcrq}</span>
					</li>
				</ul>
			</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>
