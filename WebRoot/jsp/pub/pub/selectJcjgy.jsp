<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String jcsbid = StringHelper.showNull2Empty(request.getParameter("jcsbid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择农村聚餐监管员</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var jcsbid = '<%=jcsbid %>';
	var grid2;
	var grid3;
	$(function() {
		grid2 = $('#grid2').datagrid({
			title: '可指派的现场监管员',
			iconCls: 'icon-tip',
			url : basePath + '/ncjtjc/jcgl/queryJcjgyNo?jcsbid='+jcsbid,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '监管员ID',
				field : 'userid',
				hidden : true
			},{
				width : '100',
				title : '监管员姓名',
				field : 'username',
				hidden : false
			},{
				width : '200',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(userkind,value);
				}
			},{
				width : '150',
				title : '用户所属机构id',
				field : 'orgid',
				hidden : true
			},{
				width : '150',
				title : '用户所属机构',
				field : 'orgname',
				hidden : false
			} ] ]
		});
	
		grid3 = $('#grid3').datagrid({
			title: '已指派的现场监管员',
			iconCls: 'icon-tip',
			url : basePath + '/ncjtjc/jcgl/queryJcjgy?jcsbid='+jcsbid,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '监管员ID',
				field : 'userid',
				hidden : true
			},{
				width : '100',
				title : '监管员姓名',
				field : 'username',
				hidden : false
			},{
				width : '200',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(userkind,value);
				}
			},{
				width : '150',
				title : '用户所属机构id',
				field : 'orgid',
				hidden : true
			},{
				width : '150',
				title : '用户所属机构',
				field : 'orgname',
				hidden : false
			} ] ]
		});
	});

	//保存
	function addJcjgy() { 
		var rows = grid3.datagrid("getRows");
		//if(rows.length>0){
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr,
				'jcsbid' : jcsbid
			};  
			$.post(basePath + 'ncjtjc/jcgl/addJcjgy', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			closeWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','操作失败：'+result.msg,'error');
                }
			}, 'json');
		//}
	} 

</script>
<script type="text/javascript">
	var btn1 = function() {
		var rows = grid2.datagrid("getRows"),
		data = $.array.clone(rows);
		$.each(data,function(i, val) {
			selectRow(val);
		});
		grid2.datagrid("unselectAll");
		refreshValue();
	},
	btn2 = function() {
		var rows = grid2.datagrid("getSelections"),
		data = $.array.clone(rows);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		$.each(data,function(i, val) {
			selectRow(val);
		});
		grid2.datagrid("unselectAll");
		refreshValue();
	},
	btn3 = function() {
		var rows = grid3.datagrid("getSelections"),
		data = $.array.clone(rows);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		$.each(data,function(i, val) {
			unselectRow(val);
		});
		grid3.datagrid("unselectAll");
		refreshValue();
	},
	btn4 = function() {
		var rows = grid3.datagrid("getRows"),
		data = $.array.clone(rows);
		$.each(data,function(i, val) {
			unselectRow(val);
		});
		grid3.datagrid("unselectAll");
		refreshValue();
	},
	selectRow = function(row) {
		if (!row) {
			return;
		}
		var tOpts = grid2.datagrid("options"),
		idField = tOpts.idField;
		var isExists = grid3.datagrid("getRowIndex", row[idField]) > -1;
		if (!isExists) {
			grid3.datagrid("appendRow", row);
			//grid2.datagrid("deleteRow", grid2.datagrid("getRowIndex", row[idField]));
		}
	},
	unselectRow = function(row) {
		if (!row) {
			return;
		}
		var tOpts = grid3.datagrid("options"),
		idField = tOpts.idField;
		var isExists = grid2.datagrid("getRowIndex", row[idField]) > -1;
		if (!isExists) {
			grid2.datagrid("appendRow", row);
			grid3.datagrid("deleteRow", grid3.datagrid("getRowIndex", row[idField]));
		}
		else{
			grid3.datagrid("deleteRow", grid3.datagrid("getRowIndex", row[idField]));
		}
	},
	refreshValue = function() {
		var rows = grid3.datagrid("getRows");
		value = $.array.clone(rows);
	};		
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
	        <sicp3:groupbox title="指派监管员">
				<table>
					<tr>
						<td>
							<table id="grid2"  style="width:450px;height:380px;overflow:auto;"></table>
						</td>
						<td style="text-align:center;">
							<table>
								<tr>
									<td><a href="javascript:void(0);" class="easyui-linkbutton" 
									data-options="plain:true,iconCls:'ext-icon-control_end_blue'" onclick="btn2();" >选入</a>
									</td>
								</tr>
								<tr>
									<td><a href="javascript:void(0);" class="easyui-linkbutton" 
									data-options="plain:true,iconCls:'ext-icon-control_start_blue'" onclick="btn3();" >选出</a>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table id="grid3" style="width:450px;height:380px;overflow:auto;"></table>
						</td>
					</tr>
				</table>
				<br/><br/><br/>							       	       
		        <div style="text-align:right">
		        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addJcjgy"
						iconCls="icon-ok" onclick="addJcjgy()">提交保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
		        	<a href="javascript:void(0)" class="easyui-linkbutton" 
						iconCls="icon-cancel" onclick="closeWindow()">取消关闭</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
		        </div>		
			</sicp3:groupbox> 
        </div>        
    </div>    
</body>
</html>