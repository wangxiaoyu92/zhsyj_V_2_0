<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'zxBusinessCode.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript" src="../../../jslib/jQueryValidationEngine/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../../../jslib/jquery-easyui-1.3.4/jquery.easyui.min.js"></script>
  <link rel="stylesheet" href="../../../jslib/jquery-easyui-1.3.4/themes/default/easyui.css" type="text/css"></link>
  <link rel="stylesheet" href="../../../jslib/jquery-easyui-1.3.4/themes/icon.css" type="text/css"></link>
 <script type="text/javascript">
	window.onload = function() {
		$('#dg').datagrid({
		    title:'所有征信信息',
			url :  basePath + 'zx/BusinessCode/queryBusinessCode',
			fitColumns : true,
			singleSelect : true,
			striped:true,
			pagination:true,
			rownumbers:true,
			pageNumber:1,
			pageSize:7,
			pageList:[7,14,21],
			idField: 'bcid', 
			sortOrder: 'asc',
			columns : [ [ {
				field : 'bccode',
				title : '编码',
				width : 100
			}, {
				field : 'bcname',
				title : '名称',
				width : 100,
			}, {
				field : 'bclevel',
				title : '级别',
				width : 100,
				formatter : function(value, rec) {
					if (value == '1') {
						return "子系统";
					} else if (value == '2') {
						return "业务";
					}  else if (value == '3') {
						return "项目";
					} else{
						return "级别";
					}

				}
			}
			 ] ],
			toolbar : [ {
				iconCls : 'icon-edit',
				handler : function() {
					alert('edit');
				}
			}, '-', {
				iconCls : 'icon-help',
				handler : function() {
					alert('help');
				}
			} ]

		});
	};
</script>
  </head>
  
  <body>
  <table id="dg" class="easyui-datagrid" style="width:600px;height:400px">
 
</table>  
  	
  </body>
</html>
