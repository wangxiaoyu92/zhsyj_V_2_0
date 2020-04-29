<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.askj.spsy.dto.QproductDTO" %>
<%@ page import="com.askj.spsy.entity.Qproductjc,com.zzhdsoft.siweb.entity.Fj" %>
<%@ page import="com.askj.spsy.entity.Qproductszgcxx" %>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
			
	// 产品信息
	QproductDTO v_productInfo=(QproductDTO)request.getAttribute("productInfo");
	
	// 产品材料信息
	List<QproductDTO> v_productClInfo=(List<QproductDTO>)request.getAttribute("productClInfo");
	
	// 产品检测信息
	List<Qproductjc> v_productJcInfo=(List<Qproductjc>)request.getAttribute("productJcInfo");	
	
	// 产品生产生长信息信息
	List<Qproductszgcxx> v_productScszInfo=(List<Qproductszgcxx>)request.getAttribute("productScszInfo");
	
	// 产品图片信息
	List<Fj> v_fjlist=(List<Fj>)request.getAttribute("proPiclist");
	
	// 产品视频信息
	List<Fj> v_fjvideolist=(List<Fj>)request.getAttribute("fjvideolist");	
	
	// 产品检验检测信息
	List<Fj> v_jyjcPiclist=(List<Fj>)request.getAttribute("jyjcPiclist");	
%>
<!DOCTYPE html>
<html data-dpr="1" style="font-size: 54px;">
<head>
<title>溯源信息</title>
<link rel="stylesheet" href="<%=contextPath%>/jsp/pub/spsy/css/index.css">
<script src="<%=contextPath%>/jsp/pub/spsy/js/flexible.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/jquery-1.11.3.min.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/openimg.js"></script>
<script src="<%=contextPath%>/jsp/pub/spsy/js/pinchzoom.min.js"></script>
</head>
<body style="font-size: 12px;">
	<div class="box">
		<div class="top"> <img src="<%=contextPath%>/jsp/pub/spsy/images/top_logo.png" alt="安盛食品安全追溯监管平台"> </div>
		<div class="banner"></div>
		<div class="security padd">
			<p>您查询的标识码为安盛食品安全追溯监管平台签发</p>
		    <p>授权<span class="green">${productInfo.commc}</span>使用</p>
		    <p class="green">此标识码无异常使用记录</p>
		</div>
		<div class="empty"> 基础信息 </div>
		<div class="cont padd">
		    <table class="table">
				<tbody>
				<tr><td><p>产品名称</p></td><td><p>${productInfo.proname}</p></td></tr>
				<tr><td><p>品名</p></td><td><p>${productInfo.propm}</p></td></tr>
		        	<tr><td><p>追溯码</p></td><td><p>${code}</p></td></tr>
		        	<tr><td><p>配料信息</p></td><td><p>${productInfo.proplxx}</p></td></tr>
		        	<tr><td><p>生产日期</p></td><td><p>${productInfo.cppcscrq}</p></td></tr>
		        	<tr><td><p>规格</p></td><td><p>${productInfo.progg}</p></td></tr>
		        	<tr><td><p>价格</p></td><td><p>${productInfo.proprice}</p></td></tr>
		        	<tr><td><p>产品批次</p></td><td><p>${productInfo.cppcpch}</p></td></tr>
		        	<tr><td><p>保质期</p></td><td><p>${productInfo.probzq}</p></td></tr>
		        	<tr><td><p>商品条码</p></td><td><p>${productInfo.prosptm}</p></td></tr>
		        	<tr><td><p>公司</p></td><td><p>${productInfo.prosccj}</p></td></tr>
		        	<tr><td><p>公司地址</p></td><td><p>${productInfo.comdz}</p></td></tr>
		        	<tr><td><p>产地(基地)</p></td><td><p>${productInfo.procdjd}</p></td></tr>
		        	<tr><td><p>简介</p></td><td><p>${productInfo.projj}</p></td></tr>
		      	</tbody>
			</table>
		</div>
		<div class="empty"> 产品材料信息 </div>
  		<div class="cont padd">
  			<table class="table">
				<tbody>
					<tr><td>材料名称</td></tr>
  					<% 
  					if (v_productClInfo!=null && v_productClInfo.size()>0){
  					for (int k = 0; k < v_productClInfo.size(); k++){
		            	QproductDTO v_cpcldto = (QproductDTO)v_productClInfo.get(k);
		      		%>
			      	<tr><td><%=v_cpcldto.getProname() %></td></tr>      
		      		<%}} %>
  				</tbody>
			</table>
  		</div>
		<div class="empty"> 产品图片 </div>
  		<div class="img-box padd">
			<% 
			if (v_fjlist!=null && v_fjlist.size()>0){
			for (int k = 0; k < v_fjlist.size(); k++){
	             Fj v_Fj = (Fj)v_fjlist.get(k);
	      	%>
	      		<div><img src="<%=basePath + v_Fj.getFjpath()%>" ></div>
	      	<%}} %>
  		</div>
  		<div class="empty"> 产品生产生长信息 </div>
		<div class="cont">
			<% 
			if (v_productScszInfo!=null && v_productScszInfo.size()>0){
			for (int k = 0; k < v_productScszInfo.size(); k++){
	             Qproductszgcxx v_Qproductszgcxx = (Qproductszgcxx)v_productScszInfo.get(k);
	      	%>
		    <table class="table padd">
				<tbody>
		        	<tr><td>操作内容</td><td><p><%=v_Qproductszgcxx.getSzgccznr()%></p></td></tr>
		        	<tr><td>操作时间</td><td><p><%=v_Qproductszgcxx.getSzgcczrq()%></p></td></tr>
		        	<tr><td>操作人</td><td><p><%=v_Qproductszgcxx.getSzgcczr()%></p></td></tr>
		        	<tr><td>操作备注</td><td><p><%=v_Qproductszgcxx.getSzgcbz()%></p></td></tr>
		      	</tbody>
			</table>
			<%}} %>
		</div>
		<div class="empty"> 产品检验检测信息 </div>
		<div class="cont">
			<% 
			if (v_productJcInfo!=null && v_productJcInfo.size()>0){
			for (int k = 0; k < v_productJcInfo.size(); k++){
	             Qproductjc v_Qproductjc = (Qproductjc)v_productJcInfo.get(k);
	      	%>
		    <table class="table padd">
				<tbody>
		        	<tr><td>检测项目</td><td><p><%=v_Qproductjc.getJcitem()%></p></td></tr>
		        	<tr><td>检测结果</td><td><p><%=v_Qproductjc.getJcjg()%></p></td></tr>
		        	<tr><td>检测单位</td><td><p><%=v_Qproductjc.getJcdw()%></p></td></tr>
		        	<tr><td>检测时间</td><td><p><%=v_Qproductjc.getJcsj()%></p></td></tr>
		        	<tr><td>检测人员</td><td><p><%=v_Qproductjc.getJcjcy()%></p></td></tr>
		        	<%  
		        	if (v_jyjcPiclist!=null && v_jyjcPiclist.size()>0){
		        	for (int h = 0; h < v_jyjcPiclist.size(); h++){
				           Fj v_Fj2 = (Fj)v_jyjcPiclist.get(h);
				           if (v_Fj2.getFjwid().equals(v_Qproductjc.getQproductjcid())){
			        %>
		        			<tr><div class="img-box padd"><img src="<%=basePath + v_Fj2.getFjpath()%>" ></div></tr>
		        	<%	   }
		        	}} %>
		      	</tbody>
			</table>
			<%}} %>
		</div>
        <div class="empty"> 产品视频 </div>
       	<%  
       	if (v_fjvideolist!=null && v_fjvideolist.size()>0){
       	for (int h = 0; h < v_fjvideolist.size(); h++){
	           Fj v_Fjvideo = (Fj)v_fjvideolist.get(h);
	           String v_videpPath=basePath+v_Fjvideo.getFjpath();
	           System.out.println(v_videpPath);
        %>
		<div class="img-box padd">
	    	<video controls="controls" src="<%=v_videpPath %> " 
	      		width="100%" height="100%" loop="loop"></video>
	  	</div> 
       	<%	   
       	}} %>        

		<div class="foot">由安盛食品安全追溯监管平台提供技术支持</div>
	</div>
</body>
</html>
