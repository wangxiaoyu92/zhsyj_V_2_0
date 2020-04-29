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
<title>工作流管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var cllx = <%=SysmanageUtil.getAa10toJsonArray("CLLX")%>;
	var cb_cllx;
	var grid;
	
	$(function() {
		cb_cllx = $('#cllx').combobox({
	    	data : cllx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });	    
		grid = $('#grid').datagrid({
			//title: '工作流管理',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/workflow/queryWfprocess',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'psid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '工作流流程ID',
				field : 'psid',
				hidden : true
			},{
				width : '200',
				title : '流程编号',
				field : 'psbh',
				hidden : false
			}]],					
			columns : [ [ {
				width : '300',
				title : '流程名称',
				field : 'psmc',
				hidden : false
			},{
				width : '200',
				title : '添加人姓名',
				field : 'aae011',
				hidden : false
			},{
				width : '200',
				title : '添加时间',
				field : 'aae036',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var psbh = $('#psbh').val();		
		var param = {
			'psbh': psbh
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addWfprocess = function() {
		var url = basePath + 'jsp/workflow/addprocess.jsp';
//		var params;
//		var style = "dialogWidth:980px;dialogHeight:800px;status:no";
//		window.showModalDialog(url+"?time="+new Date().getMilliseconds(),params, style);
		var dialog = parent.sy.modalDialog({
				title : '添加',
				width : 800,
				height : 600,
				url : url,
			    maximizable:true
		}, closeModalDialogCallback);
	};
	// 修改
	var updateWfprocess = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.post(basePath + '/workflow/checkProcessIsUse', {
				psbh: row.psbh
			},
			function(result) {
				if (result.code == '0') {
					//	
				} else {
					$.messager.alert('提示', "操作失败：" + result.msg, 'error');
					return;
				}
			},'json');
			var url = basePath + 'jsp/workflow/updateprocess.jsp';
			var dialog = parent.sy.modalDialog({
					title : '修改',
					param : {
						name : row.psmc
					},
					width : 800,
					height : 600,
					url : url,
				    maximizable:true
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};
	// 查看
	var getWfprocess = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var url = basePath + 'jsp/workflow/viewprocess.jsp';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						name : row.psmc
					},
					width : 800,
					height : 600,
					url : url,
				    maximizable:true
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		alert(obj.type);
		if(obj.type=='ok'){
			grid.datagrid('load');
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}

	// 删除
	var delWfprocess = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的工作流相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/workflow/delWfprocess', {
						psbh: row.psbh,
						psmc: row.psmc
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "操作失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>工作流编号</nobr></td>
						<td><input id="psbh" name="psbh" style="width: 200px"/></td>																
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
        	<sicp3:groupbox title="工作流列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addWfprocess"
								iconCls="icon-add" plain="true" onclick="addWfprocess()">新增</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfprocess"
								iconCls="icon-edit" plain="true" onclick="updateWfprocess()">修改</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_getWfprocess"
								iconCls="ext-icon-report_magnify" plain="true" onclick="getWfprocess()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delWfprocess"
								iconCls="icon-remove" plain="true" onclick="delWfprocess()">删除</a>
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