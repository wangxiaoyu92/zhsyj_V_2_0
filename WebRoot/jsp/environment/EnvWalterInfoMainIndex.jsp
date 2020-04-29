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
<title>环境信息--水信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

	var grid;
	$(function() { 
		grid = $('#grid').datagrid({
			//title: '水信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + 'environment/envWalterInfo/queryEnvWalterInfo',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    idField: 'walterid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
				//添加
				{
					width : '200',
					title : '水ID',
					field : 'walterid',
					hidden : true
				},
				{
					width : '200',
					title : 'PH',
					field : 'walterph',
					hidden : false
				},
				{
					width : '200',
					title : '溶氧',
					field : 'waltero2',
					hidden : false
				},
				{
					width : '200',
					title : '温度',
					field : 'waltertemp',
					hidden : false
				},
				{
					width : '200',
					title : '电导率',
					field : 'walterele',
					hidden : false
				},
				{
					width : '200',
					title : '浊度',
					field : 'walterturbidity',
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
			walterph:$("#walterph").val(),   //PH
			waltero2:$("#waltero2").val(),   //溶氧
			waltertemp:$("#waltertemp").val(),   //温度
			walterele:$("#walterele").val(),   //电导率
			walterturbidity:$("#walterturbidity").val()   //浊度
		};
		grid.datagrid({
			url : basePath + 'environment/envWalterInfo/queryEnvWalterInfo',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addEnvWalterInfo() {
		var dialog = parent.sy.modalDialog({
			title : '新增水信息',
			width : 800,
			height : 450,
			url : basePath + 'environment/envWalterInfo/editEnvWalterInfoFormIndex',
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
	function updateEnvWalterInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改用户',
				width : 800,
				height : 450,
				url : basePath + 'environment/envWalterInfo/editEnvWalterInfoFormIndex?walterid=' + row.walterid,
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
			$.messager.alert('提示', '请先选择要修改的水信息！', 'info');
		}
	} 

	
	// 删除
	function delEnvWalterInfo() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var id = row.id;
			$.messager.confirm('警告', '您确定要删除该水信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'environment/envWalterInfo/delEnvWalterInfo', {
						walterid: row.walterid
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
			$.messager.alert('提示', '请先选择要删除的水信息！', 'info');
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
					<td style="text-align:right;"><nobr>PH</nobr></td>
					<td><input id="walterph" name="walterph" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>溶氧</nobr></td>
					<td><input id="waltero2" name="waltero2" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>温度</nobr></td>
					<td><input id="waltertemp" name="waltertemp" style="width: 200px"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>电导率</nobr></td>
					<td><input id="walterele" name="walterele" style="width: 200px"/></td>
				<td style="text-align:right;" ><nobr>浊度</nobr></td>
					<td colspan="3"><input id="walterturbidity" name="walterturbidity" style="width: 200px"/></td>

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
        	<sicp3:groupbox title="水信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addEnvWalterInfo"
								iconCls="icon-add" plain="true" onclick="addEnvWalterInfo()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateEnvWalterInfo"
								iconCls="icon-edit" plain="true" onclick="updateEnvWalterInfo()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delEnvWalterInfo"
								iconCls="icon-remove" plain="true" onclick="delEnvWalterInfo()">删除</a>
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