<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>工作日管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	
	$(function() {	    
		grid = $('#grid').datagrid({
			//title: '工作日管理',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/workflow/queryWfworkday',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'wdyear', //该列是一个唯一列
		    sortOrder: 'desc',				
			columns : [ [ {
				width : '200',
				title : '工作年度',
				field : 'wdyear',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var wdyear = $('#wdyear').val();		
		var param = {
			'wdyear': wdyear
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addWfworkday = function() {
		var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
		var dialog = parent.sy.modalDialog({
				title : '添加',
				param : {
					op : "add"
				},
				width : 950,
				height : 600,
				url : url
		}, closeModalDialogCallback);
	};
	// 修改
	var updateWfworkday = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
			var dialog = parent.sy.modalDialog({
					title : '修改',
					param : {
						op : "update",
						getCurYear : row.wdyear
					},
					width : 950,
					height : 600,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};
	// 查看
	var queryWfworkday = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						op : "view",
						getCurYear : row.wdyear
					},
					width : 950,
					height : 600,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};

	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(obj.type=='ok'){
			grid.datagrid('load'); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>工作年度</nobr></td>
						<td><input id="wdyear" name="wdyear" style="width: 200px"/></td>																
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="工作年度列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addWfworkday"
								iconCls="icon-add" plain="true" onclick="addWfworkday()">新增年度工作日</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfworkday"
								iconCls="icon-edit" plain="true" onclick="updateWfworkday()">修改年度工作日</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_queryWfworkday"
								iconCls="ext-icon-report_magnify" plain="true" onclick="queryWfworkday()">查看年度工作日</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  							
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>						         		
        </div>               
    </div>    
</body>
</html>