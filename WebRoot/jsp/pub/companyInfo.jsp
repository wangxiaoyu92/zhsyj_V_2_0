<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.askj.baseinfo.dto.PcompanyDTO,com.askj.baseinfo.dto.PcompanyXkzDTO" %>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
			
	// 企业信息
	PcompanyDTO v_com = (PcompanyDTO)request.getAttribute("comInfo");
	// 许可证信息
	List<PcompanyXkzDTO> v_xkzInfo = (List<PcompanyXkzDTO>)request.getAttribute("xkzList");
	
%>
<html>
<head>
<title>企业信息</title>

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
	         <th style="vertical-align:middle;text-align:center;">企业基本信息</th>
	      </tr>      
      </thead>
      <tr class="success">
        <td>
                                          企业名称：${comInfo.commc}
        </td>
      </tr>
      
      <tr class="success">
        <td>
                                         企业法人：${comInfo.comfrhyz}
        </td>
      </tr>
      <tr class="success">
        <td>
                                          企业地址：${comInfo.comdz}
        </td>
      </tr>
      <tr class="success">
        <td>
                                          联系电话：${comInfo.comyddh}
        </td>
      </tr>
      <% for (int k = 0; k < v_xkzInfo.size(); k++){
             PcompanyXkzDTO dto = (PcompanyXkzDTO)v_xkzInfo.get(k);
      %>
      	<tr class="success">
	      	<td>
                                          许可证类型：<%=dto.getComxkzlxstr()%>
        	</td>
       	</tr> 
       	<tr class="success">
        	<td>
                                          许可证编号：<%=dto.getComxkzbh()%>
	        </td>
       	</tr> 
        <tr class="success">
	        <td>
                                          许可范围：<%=dto.getComxkfw()%>
	        </td>
       	</tr> 
        <tr class="success">
	        <td>
                                          许可证有效期起：<%=dto.getComxkyxqq()%>
	        </td>
        </tr> 
        <tr class="success">
	        <td>
                                          许可证有效期止：<%=dto.getComxkyxqz()%>
	        </td>
      	</tr>      
      <%} %> 
    </table>    
</div>
</body>
</html>
