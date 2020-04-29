<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>工作流节点权限管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var psbh = "";
	var nodeid = "";
	
	var setting = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "psbh",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "psmc"
			}
		},
		callback: {
			onClick: onClick
		}		
	};

	//刷新zTree
	function queryWfprocessZTree(){
		$.post(basePath + '/workflow/queryWfprocessZTree', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}

	//单击工作流列表
	function onClick(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		
		psbh = nodes[0].psbh;
		nodeid = ""; 
		grid.datagrid('loadData',{"total":0,"rows":[]});
		grid2.datagrid('loadData',{"total":0,"rows":[]});
		queryWfnodeZTree(); 
	}
	
	var setting2 = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "nodeid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "nodename"
			}
		},
		callback: {
			onClick: onClick2
		}
		
	};
	
	//刷新zTree
	function queryWfnodeZTree(){
		$.post(basePath + '/workflow/queryWfnodeZTree', {
			'psbh' : psbh
		}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}

	//单击节点列表
	function onClick2(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = zTree.getSelectedNodes();		
		nodeid = nodes[0].nodeid; 			
		queryWfnodeRole();
		queryWfnodeTrans();	 
	}

	//查询节点权限信息 
	function queryWfnodeRole() {		
		var param = {
			'nodeid': nodeid,
			'psbh' : psbh
		};
		grid.datagrid({
			url : basePath + '/workflow/queryWfnodeRole',
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}

	//查询节点流向信息 
	function queryWfnodeTrans() {		
		var param = {
			'psbh' : psbh,
			'transfrom' : nodeid
		};
		grid2.datagrid({
			url : basePath + '/workflow/queryWfnodeTrans',
			queryParams : param
		});
		grid2.datagrid('clearSelections');
	}			
</script>
<script type="text/javascript">
	var grid;
	var grid2;
	var editRow = undefined; 
	
	$(function() {
		grid = $('#grid').datagrid({
			//title: '节点权限',
			//iconCls: 'icon-tip',
			toolbar : '#toolbar',
			url : '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'noderoleid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '节点角色表ID',
				field : 'noderoleid',
				hidden : true
			},{
				width : '150',
				title : '角色名称',
				field : 'rolename',
				hidden : false
			}]],					
			columns : [ [ {
				width : '100',
				title : '节点办理时限 ',
				field : 'nodesx',
				hidden : false
			},{
				width : '300',
				title : '节点操作URL',
				field : 'nodeurl',
				hidden : false
			},{
				width : '100',
				title : '节点类型',
				field : 'nodetype',
				hidden : false
			} ] ]
		});

		grid2 = $('#grid2').datagrid({
			//title: '节点流向',
			//iconCls: 'icon-tip',
			toolbar : '#toolbar2',
			url : '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'nodetransid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '节点流向表ID',
				field : 'nodetransid',
				hidden : true
			},{
				width : '200',
				title : '起点',
				field : 'transfrom',
				hidden : false
			}]],					
			columns : [ [ {
				width : '150',
				title : '流向名称',
				field : 'transname',
				hidden : false
			},{
				width : '100',
				title : '流向值 ',
				field : 'transval',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : false
					}
				}
			},{
				width : '200',
				title : '终点',
				field : 'transto',
				hidden : false
			} ] ]
		});
		
		queryWfprocessZTree();
	});

	
	// 修改节点
	var updateWfnode = function() {
		if(nodeid == "" || nodeid == null){
			$.messager.alert('提示','请先选择节点！','info',function(){
				return; 
    		}); 
		}else{
			var dialog = parent.sy.modalDialog({
				title : '修改节点时限/URL',
				width : 600,
				height : 400,
				maximizable : false,
				url : basePath + '/workflow/wf_node_roleFormIndex?psbh=' + psbh + '&nodeid=' + nodeid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}
	};
	
	// 新增节点权限
	var addWfnodeRole = function() {
		if(nodeid == "" || nodeid == null){
			$.messager.alert('提示','请先选择节点！','info',function(){
				return; 
    		}); 
		}else{
			var dialog = parent.sy.modalDialog({
				title : '新增节点权限',
				width : 600,
				height : 400,
				maximizable : false,
				url : basePath + '/workflow/wf_node_roleAddRoleIndex?psbh=' + psbh + '&nodeid=' + nodeid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}
	};
	// 删除节点权限
	var delWfnodeRole = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要解除该权限绑定吗？',function(r) {
				if (r) {
					$.post(basePath + '/workflow/delWfnodeRole', {
						noderoleid : row.noderoleid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', '操作失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的节点权限记录！', 'info');
		}
	};

	// 编辑
	function edit() {
		var rows = grid2.datagrid('getSelected');
		if (rows) {
			if (editRow != undefined) {
				grid2.datagrid('endEdit', editRow);//
			}
			if (editRow == undefined) {
				editRow = grid2.datagrid('getRowIndex', rows);
				grid2.datagrid('beginEdit', editRow);//
			}
		} else {
			$.messager.alert('提示', '请选择要操作的记录!', 'warning');	
		}
	}
    // 取消编辑
	function undoEdit() {
		grid2.datagrid('rejectChanges');//
		editRow = undefined;
	}

	// 提交保存
	var updateWfnodeTrans = function() {
		if (editRow != undefined) {
			grid2.datagrid('endEdit', editRow);//
		}
		var updated = grid2.datagrid('getChanges', 'updated');
		if (updated.length < 1) {
			editRow = undefined;
			return;
		}
		var row = grid2.datagrid('getSelected');
		if (row) {
			$.messager.progress();	// 显示进度条
			$.post(basePath + '/workflow/updateWfnodeTrans', {
				'nodetransid' : row.nodetransid,
				'transval' : row.transval
			}, function(result) {
				if (result.code == '0') {
	        		grid2.datagrid('acceptChanges');
					editRow = undefined;						        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						queryWfnodeTrans();
					});
				} else {
					grid2.datagrid('rejectChanges');
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '请选择要操作的记录！', 'info');
		}
	};
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
		<div region="center" style="overflow: hidden;" border="false"> 
        	<ul id="treeDemo2" class="ztree" ></ul>       
        </div>    
        <div region="east" style="width:600px;overflow: true;" border="false">
        	<sicp3:groupbox title="节点权限信息">
        		<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfnode"
								iconCls="icon-edit" plain="true" onclick="updateWfnode()">修改节点时限/URL</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addWfnodeRole"
								iconCls="icon-add" plain="true" onclick="addWfnodeRole()">新增节点权限</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  							
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delWfnodeRole"
								iconCls="icon-remove" plain="true" onclick="delWfnodeRole()">删除节点权限</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>  																				
						</tr>
					</table>
				</div>    
	        	<div id="grid" style="height: 250px">></div>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="节点流向信息">
        		<div id="toolbar2">
	        		<table>
						<tr>       		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfnodeTrans"
								iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfnodeTrans"
								iconCls="icon-undo" plain="true" onclick="undoEdit()">取消编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    						
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfnodeTrans"
								iconCls="icon-save" plain="true" onclick="updateWfnodeTrans()">提交保存</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
	        	<div id="grid2" style="height: 250px"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    

</body>
</html>