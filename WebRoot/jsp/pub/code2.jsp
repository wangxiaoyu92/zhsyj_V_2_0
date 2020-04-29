<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.askj.spsy.dto.QproductDTO,com.askj.spsy.entity.Qproductjc,com.askj.spsy.entity.Qproductszgcxx,com.zzhdsoft.siweb.entity.Fj" %>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
			
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
	
	// 产品检验检测信息
	List<Fj> v_jyjcPiclist=(List<Fj>)request.getAttribute("jyjcPiclist");	
					
%>
<html>
<head>
<title>溯源信息</title>

<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js" type="text/javascript" charset="utf-8"></script>

<link rel="stylesheet" href="<%=contextPath%>/jslib/bootstrap-3.3.5/css/bootstrap.min.css" type="text/css"></link>
<script src="<%=contextPath%>/jslib/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/bootstrap-3.3.5/js/bootstrap.min.js"></script>



</head>
<body class="devpreview sourcepreview" style="min-height: 347px; cursor: auto;">
<div class="container">
    <table class="table table-bordered">
      <thead>
	     <tr class="success">
	         <th colspan="3" style="vertical-align:middle;text-align:center;">产品基本信息</th>
	      </tr>      
      </thead>
      <tr class="success">
        <td colspan="3">
                                          溯源码：${code}
        </td>
      </tr>
      <tr class="success">
        <td>配料信息：${productInfo.proplxx}</td>
        <td>生产日期：${productInfo.cppcscrq}</td>
        <td>规格：${productInfo.progg}</td>
      </tr>
      <tr class="success">
        <td>产品批次：${productInfo.cppcpch}</td>
        <td>保质期：${productInfo.probzq}</td>
        <td>商品条码：${productInfo.prosptm}</td>
      </tr>   
      <tr class="success">
        <td colspan="3">公司：${productInfo.commc}</td>
      </tr>      
      <tr class="success">
        <td colspan="3">公司地址：${productInfo.comdz}</td>
      </tr> 
      <tr class="success">
        <td colspan="3">产地(基地)：${productInfo.procdjd}</td>
      </tr>  
      <% for (int k=0;k<v_fjlist.size();k++){
             Fj v_Fj=(Fj)v_fjlist.get(k);
      %>
	      <tr class="success">
	        <td colspan="3" style="vertical-align:middle;text-align:center;"><img width="200px;" height="200px;" src="<%=basePath+v_Fj.getFjpath() %>" class="img-rounded"></td>
	      </tr>      
      <%} %>       
                         
    </table>    
    <table class="table table-bordered">
      <thead>
	     <tr class="warning">
	         <th colspan="3" style="vertical-align:middle;text-align:center;">产品材料信息</th>
	      </tr>      
      </thead>
      <thead>
	     <tr class="warning">
	         <th>材料名称</th>
	      </tr>      
      </thead>      
      <tbody>
	      <% for (int k=0;k<v_productClInfo.size();k++){
	             QproductDTO v_cpcldto=(QproductDTO)v_productClInfo.get(k);
	      %>
		      <tr class="warning">
		        <td><%=v_cpcldto.getProname() %></td>
		      </tr>      
	      <%} %>      
      </tbody>
                      
    </table>   
    <table class="table table-bordered">
      <thead>
	     <tr class="success">
	         <th colspan="4" style="vertical-align:middle;text-align:center;">产品生产生长信息</th>
	      </tr>      
      </thead>
      <thead>
	     <tr class="success">
	         <th>操作内容</th>
	         <th>操作时间</th>
	         <th>操作人</th>
	         <th>操作备注</th>
	      </tr>      
      </thead>  
      
      <% for (int k=0;k<v_productScszInfo.size();k++){
             Qproductszgcxx v_Qproductszgcxx=(Qproductszgcxx)v_productScszInfo.get(k);
      %>
	      <tr class="success">
	        <td><%=v_Qproductszgcxx.getSzgccznr() %></td>
	        <td><%=v_Qproductszgcxx.getSzgcczrq()%></td>
	        <td><%=v_Qproductszgcxx.getSzgcczr() %></td>
	        <td><%=v_Qproductszgcxx.getSzgcbz() %></td>
	      </tr>      
      <%} %>      
                        
    </table>        
    <table class="table table-bordered">
      <thead>
	     <tr class="danger">
	         <th colspan="5" style="vertical-align:middle;text-align:center;">产品检验检测信息</th>
	      </tr>      
      </thead>
      <thead>
	     <tr class="danger">
	         <th>检测项目</th>
	         <th>检测结果</th>
	         <th>检测单位</th>
	         <th>检测时间</th>
	         <th>检测人员</th>
	      </tr>      
      </thead>  
      
      <% for (int k=0;k<v_productJcInfo.size();k++){
             Qproductjc v_Qproductjc=(Qproductjc)v_productJcInfo.get(k);
      %>
	      <tr class="danger">
	        <td><%=v_Qproductjc.getJcitem() %></td>
	        <td><%=v_Qproductjc.getJcjg() %></td>
	        <td><%=v_Qproductjc.getJcdw() %></td>
	        <td><%=v_Qproductjc.getJcsj() %></td>
	        <td><%=v_Qproductjc.getJcjcy() %></td>
	      </tr>      
      <% 
        for (int h=0;h<v_jyjcPiclist.size();h++){
           Fj v_Fj2=(Fj)v_jyjcPiclist.get(h);
           if (v_Fj2.getFjwid().equals(v_Qproductjc.getQproductjcid())){
           %>
	      <tr class="danger">
	        <td colspan="5" style="vertical-align:middle;text-align:center;"><img width="200px;" height="200px;" src="<%=basePath+v_Fj2.getFjpath() %>" class="img-rounded"></td>
	      </tr>                  
           <%           
           }
        }
      } %>      
                        
    </table>       

     
</div>
</body>
</html>
