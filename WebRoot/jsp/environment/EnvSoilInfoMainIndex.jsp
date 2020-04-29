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
<title>环境信息--土壤信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function() { 
		grid = $('#grid').datagrid({
			//title: '土壤信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + 'environment/envSoilInfo/queryEnvSoilInfo',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'soilid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
				//添加
				{
					width : '200',
					title : '土壤信息ID',
					field : 'soilid',
					hidden : true
				},
				{
					width : '200',
					title : '土壤温度',
					field : 'soiltemperature',
					hidden : false
				},
				{
					width : '200',
					title : '土壤盐分',
					field : 'soilsalinity',
					hidden : false
				},
				{
					width : '200',
					title : '土壤水分',
					field : 'soilmoisture',
					hidden : false
				}
							] ]
		});
		query();
	}); 
</script>
<script type="text/javascript">
	function query() {
		var param = {
			soiltemperature:$("#soiltemperature").val(),
			soilsalinity:$("#soilsalinity").val(),
			soilmoisture:$("#soilmoisture").val()
		};
		grid.datagrid({
			url : basePath + 'environment/envSoilInfo/queryEnvSoilInfo',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');  
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addEnvSoilInfo() {
		var dialog = parent.sy.modalDialog({
			title : '新增土壤信息',
			width : 800,
			height : 450,
			url : basePath + 'environment/envSoilInfo/editEnvSoilInfoFormIndex',
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
	function updateEnvSoilInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改土壤信息',
				width : 800,
				height : 450,
				url : basePath + 'environment/envSoilInfo/editEnvSoilInfoFormIndex?soilid=' + row.soilid,
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
			$.messager.alert('提示', '请先选择要修改的土壤信息！', 'info');
		}
	} 

	
	// 删除
	function delEnvSoilInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该土壤信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'environment/envSoilInfo/delEnvSoilInfo', {
								soilid: row.soilid
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
			$.messager.alert('提示', '请先选择要删除的土壤信息！', 'info');
		}
	}  	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
        		<tr>
					<td style="text-align:right;"><nobr>土壤温度</nobr></td>
					<td><input id="soiltemperature" name="soiltemperature" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>土壤盐分</nobr></td>
					<td><input id="soilsalinity" name="soilsalinity" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>土壤水分</nobr></td>
					<td><input id="soilmoisture" name="soilmoisture" style="width: 200px"/></td>
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
        	<sicp3:groupbox title="土壤信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addEnvSoilInfo"
								iconCls="icon-add" plain="true" onclick="addEnvSoilInfo()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateEnvSoilInfo"
								iconCls="icon-edit" plain="true" onclick="updateEnvSoilInfo()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delEnvSoilInfo"
								iconCls="icon-remove" plain="true" onclick="delEnvSoilInfo()">删除</a>
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