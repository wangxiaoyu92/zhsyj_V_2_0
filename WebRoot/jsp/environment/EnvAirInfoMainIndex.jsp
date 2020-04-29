<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				 + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>环境信息--大气信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

	var grid;
	$(function() { 
		grid = $('#grid').datagrid({
			//title: '大气信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + 'environment/envAirInfo/queryEnvAirInfo',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    idField: 'airid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
				//添加
				{
					width : '200',
					title : '主键',
					field : 'airid',
					hidden : true
				},
				{
					width : '200',
					title : '总悬浮颗粒物',
					field : 'airtsp',
					hidden : false
				},
				{
					width : '200',
					title : '总碳氢化合物',
					field : 'airthc',
					hidden : false
				},
				{
					width : '200',
					title : '总氧化剂',
					field : 'airto',
					hidden : false
				},
				{
					width : '200',
					title : '氮氧化物',
					field : 'airoxynitride',
					hidden : false
				},
				{
					width : '200',
					title : '二氧化硫',
					field : 'airso2',
					hidden : false
				},
				{
					width : '200',
					title : '一氧化碳',
					field : 'airco',
					hidden : false
				},
				{
					width : '200',
					title : '降尘',
					field : 'airdustfall',
					hidden : false
				},
							] ]
		});
		query();
	}); 
</script>
<script type="text/javascript">
	function query() {
		var param = {
			airtsp:$("#airtsp").val(),   //总悬浮颗粒物
			airthc:$("#airthc").val(),   //总碳氢化合物
			airto:$("#airto").val(),   //总氧化剂
			airoxynitride:$("#airoxynitride").val(),   //氮氧化物
			airso2:$("#airso2").val(),   //二氧化硫
			airco:$("#airco").val(),   //一氧化碳
			airdustfall:$("#airdustfall").val()   //降尘
		};
		grid.datagrid({
			url : basePath + 'environment/envAirInfo/queryEnvAirInfo',			
			queryParams : param
		});
		grid.datagrid('clearSelections');  
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addEnvAirInfo() {
		var dialog = parent.sy.modalDialog({
			title : '新增大气信息',
			width : 800,
			height : 450,
			url : basePath + 'environment/envAirInfo/editEnvAirInfoFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog,grid,parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	} 

	// 编辑
	function updateEnvAirInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改',
				width : 800,
				height : 450,
				url : basePath + 'environment/envAirInfo/editEnvAirInfoFormIndex?airid=' + row.airid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的大气信息！', 'info');
		}
	} 

	
	// 删除
	function delEnvAirInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var id = row.id;
			$.messager.confirm('警告', '您确定要删除该大气信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'environment/envAirInfo/delEnvAirInfo', {
						airid: row.airid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload');
                                $('#grid').datagrid('clearSelections');
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的大气信息！', 'info');
		}
	}  	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: auto;" border="false">
        	<sicp3:groupbox title="查询条件">
        	<table class="table" style="width: 99%;">
        		<tr>
					<td style="text-align:right;"><nobr>总悬浮颗粒物</nobr></td>
					<td><input id="airtsp" name="airtsp" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>总碳氢化合物</nobr></td>
					<td><input id="airthc" name="airthc" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>总氧化剂</nobr></td>
					<td><input id="airto" name="airto" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>氮氧化物</nobr></td>
					<td><input id="airoxynitride" name="airoxynitride" style="width: 200px"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>二氧化硫</nobr></td>
					<td><input id="airso2" name="airso2" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>一氧化碳</nobr></td>
					<td><input id="airco" name="airco" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>降尘</nobr></td>
					<td colspan="3"><input id="airdustfall" name="airdustfall" style="width: 200px"/></td>
								</tr>
				<tr>				
					<td colspan="10" style="text-align: right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>

						</center>
					</td>
					</tr>
			</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="大气信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addEnvAirInfo"
								iconCls="icon-add" plain="true" onclick="addEnvAirInfo()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateEnvAirInfo"
								iconCls="icon-edit" plain="true" onclick="updateEnvAirInfo()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delEnvAirInfo"
								iconCls="icon-remove" plain="true" onclick="delEnvAirInfo()">删除</a>
							</td>  
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>           
	</div> 
</body>
</html>