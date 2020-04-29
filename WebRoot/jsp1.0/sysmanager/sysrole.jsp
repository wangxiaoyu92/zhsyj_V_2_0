<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>角色管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "orgname"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	$(function() { 
		refreshZTree();	
	}); 
	
	//初始化zTree树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据	    
	    return zNodes;
	}

	//单击节点事件
	function onClick(event, treeId, treeNode) {         
		grid.datagrid({
			url : basePath + '/sysmanager/sysrole/querySysrole',			
			queryParams : {'orgid':treeNode.orgid}
		});
		grid.datagrid('unselectAll'); 		  
	}
</script>
<script type="text/javascript">
	var cb_sysroleflag;
	var grid;

	$(function() {
		cb_sysroleflag = $('#sysroleflag').combobox({
	    	data : [{id:'0',text:'非系统角色'},
	    	    	{id:'1',text:'系统角色'}
	    	],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });

		grid = $('#grid').datagrid({
			//title: '角色列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'sysmanager/sysrole/querySysrole',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'roleid', //该列是一个唯一列
		    sortOrder: 'desc',			
			columns : [ [ {
				width : '200',
				title : '角色ID',
				field : 'roleid',
				hidden : false
			},{
				width : '200',
				title : '角色名称',
				field : 'rolename',
				hidden : false
			},{
				width : '200',
				title : '角色描述',
				field : 'roledesc',
				hidden : false
			},{
				width : '200',
				title : '系统角色标志',
				field : 'sysroleflag',
				hidden : false,
				formatter : function(value, row) {
					if (row.sysroleflag == "1"){ 
						return '<span style="color:red;">系统角色</span>';
					}else{ 
						return '非系统角色';
					}
				}
			} ] ]
		});
	});
	
	function query() {
		var rolename = $('#rolename').val();
		var roledesc = $('#roledesc').val();
		var sysroleflag = $('#sysroleflag').combobox('getValue');
		var param = {
			'rolename': rolename,
			'roledesc': roledesc,
			'sysroleflag': sysroleflag
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysrole/querySysrole',			
			queryParams : param
		});
		grid.datagrid('clearSelections');	 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addSysrole = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增角色',
			width : 800,
			height : 450,
			url : basePath + '/sysmanager/sysrole/sysroleFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallback);
	};

	// 修改
	var updateSysrole = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var roleid = row.roleid;
			if (roleid == '0' || roleid == '1' || roleid == '2' || roleid == '3' || roleid == '4') {
				$.messager.alert('警告', '该角色是系统预置标准角色，不可修改！', 'warning');
				return;
			}

			var dialog = parent.sy.modalDialog({
				title : '修改角色',
				width : 800,
				height : 450,
				url : basePath + '/sysmanager/sysrole/sysroleFormIndex?roleid=' + row.roleid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
					}
				} ]
			},closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要修改的角色！', 'info');
		}
	};
	
	function closeModalDialogCallback(dialogID){
		var obj = sy.getWinRet(dialogID);
		if(obj.type == "ok"){
			sy.removeWinRet(dialogID);
			$('#grid').datagrid('reload');
		}	
		sy.removeWinRet(dialogID);//不可缺少					
	}
	
	// 删除
	function delSysrole() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var roleid = row.roleid;
			if (roleid == '0' || roleid == '1' || roleid == '2' || roleid == '3' || roleid == '4') {
				$.messager.alert('警告', '该角色是系统预置标准角色，不可删除！', 'warning');
				return;
			}
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的角色授权、用户授权，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/sysmanager/sysrole/delSysrole', {
						roleid: row.roleid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的角色！', 'info');
		}
	}   
 
	// 角色绑定菜单权限
	function sysroleGrantIndex() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '角色授权',
				width : 420,
				height : 520,
				url : basePath + '/sysmanager/sysrole/sysroleGrantIndex?roleid=' + row.roleid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.saveSysroleGrant(dialog);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});						
		}else{
			$.messager.alert('提示', '请先选择要授权的角色！', 'info');
		}
	}

	// 角色绑定用户
	function sysroleUserIndex() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + '/sysmanager/sysrole/sysroleUserIndex?roleid=' + row.roleid;
			var dialog = parent.sy.modalDialog({
				title : '角色绑定用户',
				width : 950,
				height : 600,
				url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的角色！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>                   
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>角色名称</nobr></td>
						<td><input id="rolename" name="rolename" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>角色描述</nobr></td>
						<td><input id="roledesc" name="roledesc" style="width: 200px" /></td>			
					</tr>
					<tr>				
						<td style="text-align:right;"><nobr>角色类型</nobr></td>
						<td><input id="sysroleflag" name="sysroleflag" style="width: 200px" /></td>
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
        	<sicp3:groupbox title="角色列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysrole"
								iconCls="icon-add" plain="true" onclick="addSysrole()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysrole"
								iconCls="icon-edit" plain="true" onclick="updateSysrole()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysrole"
								iconCls="icon-remove" plain="true" onclick="delSysrole()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_sysroleGrantIndex"
								iconCls="icon-group_key" plain="true" onclick="sysroleGrantIndex()">角色绑定菜单权限</a>
							</td> 
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_sysroleUserIndex"
								iconCls="ext-icon-group_link" plain="true" onclick="sysroleUserIndex()">角色绑定用户</a>
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