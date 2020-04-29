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
<title>用户管理</title>
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
		initUserAaa027GrantZTree();	
		initUserOrgGrantZTree();
	}); 		
	
	//初始化【机构】树
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
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : {'orgid':treeNode.orgid}
		});
		grid.datagrid('unselectAll'); 		  
	}
</script>
<script type="text/javascript">
	//sysuserorg begin
	var settingUserOrg = {
		view: {
			showLine: true
		},	
		check: {
			enable: true,
			chkboxType: { "Y" : "s", "N" : "s" }
		},		
		data: {
			simpleData: {						
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: null		
			},
			key: {
				name: "orgname"
			}
		},
		callback: {
			onCheck: onCheckUserOrg
		}
		
	};
	
	//勾选或不勾选事件	
	function onCheckUserOrg(event, treeId, treeNode) { 
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userOrgGrant");         
		var nodes = treeObj.getCheckedNodes(true);
		var param = "";
		for(var i=0;i<nodes.length;i++){
			param = param + "orgid=" + nodes[i].orgid + "&";
		}
		$('#userOrgtreeCheckedNodes').val(param);		     		  
	}	
	
	// 初始化【机构授权】树
	function initUserOrgGrantZTree(){
		$.ajax({
			url: basePath + '/sysmanager/sysuser/querySysuserOrgZTree',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: '',
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');						
			},
			success: function(result) {
				if (result.code == '0') {
					//准备zTree数据
					var zNodesOrg = eval(result.orgData);
					$.fn.zTree.init($("#treeDemo_userOrgGrant"), settingUserOrg, zNodesOrg);
					//initUserOrgCheckedZTreeNodes();    	
				} else {
					$.messager.alert('提示', result.msg, 'error');
				}				
			}
		});
	}	
	
	// 初始化原来权限节点的选中状态
	function initUserOrgCheckedZTreeNodes() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
		
			var userorgtreeObj = $.fn.zTree.getZTreeObj("treeDemo_userOrgGrant");
			userorgtreeObj.checkAllNodes(false);		
			$.ajax({
				url: basePath + '/sysmanager/sysuser/querySysuserHaveOrgGrant',
				type: 'post',
				async: true,
				cache: false,
				timeout: 100000,
				data: 'userid=' + userid,
				dataType: 'json',
				error: function() {
					$.messager.alert('提示','服务器繁忙，请稍后再试！','info');		
				},
				success: function(result) {
					if (null != result && "[]" != result) {
						//var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");
						$.each(result,function(i, item) { //得到节点，并选中
							var node = userorgtreeObj.getNodeByParam("orgid", item.orgid, null);
							if (null != node) {
								userorgtreeObj.checkNode(node, true, false, true);
							}
						});
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的用户！', 'info');
		}
	}
	
	//保存机构授权
	function saveSysuserOrgGrant() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
			var param = $('#userOrgtreeCheckedNodes').val();
			param = param + "userid=" + userid;
			$.post(basePath + '/sysmanager/sysuser/saveSysuserOrgGrant', param, function(result) {
				if (result.code=='0'){
					$.messager.alert('提示','机构授权成功！','info',function(){
	        		}); 	                        	                     
	            } else {
	          		$.messager.alert('提示','机构授权失败：'+result.msg,'error');
	            }
			}, 'json');			
		}else{
			$.messager.alert('提示', '请先选择要修改的用户！', 'info');
		}		
	}			
	////sysuserorgend

	var settingaaa027 = {
		view: {
			showLine: true
		},	
		check: {
			enable: true,
			chkboxType: { "Y" : "s", "N" : "s" }
		},		
		data: {
			simpleData: {						
				enable: true,
				idKey: "aaa027",
				pIdKey: "aaa148",
				rootPId: null		
			},
			key: {
				name: "aaa129"
			}
		},
		callback: {
			onCheck: onCheckaaa027
		}
		
	};
	
	//勾选或不勾选事件	
	function onCheckaaa027(event, treeId, treeNode) { 
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");         
		var nodes = treeObj.getCheckedNodes(true);
		var param = "";
		for(var i=0;i<nodes.length;i++){
			param = param + "aaa027=" + nodes[i].aaa027 + "&";
		}
		$('#aaa027treeCheckedNodes').val(param);		     		  
	}	

	// 初始化【统筹区授权】树
	function initUserAaa027GrantZTree(){
		$.ajax({
			url: basePath + '/sysmanager/sysuser/querySysuserAaa027ZTree',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: '',
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');						
			},
			success: function(result) {
				if (result.code == '0') {
					//准备zTree数据
					var zNodesaaa027 = eval(result.aaa027Data);
					$.fn.zTree.init($("#treeDemo_userAaa027Grant"), settingaaa027, zNodesaaa027);
					//initUserAaa027CheckedZTreeNodes();    	
				} else {
					$.messager.alert('提示', result.msg, 'error');
				}				
			}
		});
	}	
	
	// 初始化原来权限节点的选中状态
	function initUserAaa027CheckedZTreeNodes() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
			var aaa027treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");
			aaa027treeObj.checkAllNodes(false);		
			$.ajax({
				url: basePath + '/sysmanager/sysuser/querySysuserHaveAaa027Grant',
				type: 'post',
				async: true,
				cache: false,
				timeout: 100000,
				data: 'userid=' + userid,
				dataType: 'json',
				error: function() {
					$.messager.alert('提示','服务器繁忙，请稍后再试！','info');		
				},
				success: function(result) {
					console.info(result);
					if (null != result && "[]" != result) {
						//var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");
						$.each(result,function(i, item) { //得到节点，并选中
							var node = aaa027treeObj.getNodeByParam("aaa027", item.aaa027, null);
							if (null != node) {
								aaa027treeObj.checkNode(node, true, false, true);
							}
						});
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的用户！', 'info');
		}				
	}
	
	//保存行政区划授权
	function saveSysuserAaa027Grant() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;			
			var param = $('#aaa027treeCheckedNodes').val();
			param = param + "userid=" + userid;
			$.post(basePath + '/sysmanager/sysuser/saveSysuserAaa027Grant', param, function(result) {
				if (result.code=='0'){
					$.messager.alert('提示','行政区划授权成功！','info',function(){
	        			//
	        		}); 	                        	                     
	            } else {
	          		$.messager.alert('提示','行政区划授权失败：'+result.msg,'error');
	            }
			}, 'json');
		}else{
			$.messager.alert('提示', '请先选择要修改的用户！', 'info');
		}		
	}	
</script>
<script type="text/javascript">
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 
	var cb_userkind;
	var cb_lockstate;
	var grid;
	var grid2;
	var grid3;
	var v_gridaae1;
	var v_gridaae2;
	
	$(function() {
		cb_userkind = $('#userkind').combobox({
	    	data : userkind,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_lockstate = $('#lockstate').combobox({
	    	data : lockstate,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });

		grid = $('#grid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + 'sysmanager/sysuser/querySysuser',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : false
			},{
				width : '80',
				title : '用户名称',
				field : 'username',
				hidden : false
			},{
				width : '150',
				title : '用户描述',
				field : 'description',
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
				width : '100',
				title : '手机号',
				field : 'mobile',
				hidden : false
			},{
				width : '100',
				title : '手机号2',
				field : 'mobile2',
				hidden : false
			},{
				width : '100',
				title : '账户锁定状态',
				field : 'lockstate',
				hidden : false,
				formatter : function(value, row) {
					if (row.lockstate == "1"){ 
						return '<span style="color:red;">' + sy.formatGridCode(lockstate,value) + '</span>';
					}else{ 
						return sy.formatGridCode(lockstate,value);
					}
				}
			},{
				width : '150',
				title : '统筹区',
				field : 'aaa027name',
				hidden : false
			} ] ]
		});

		grid2 = $('#grid2').datagrid({
			title: '可授权角色列表',
			iconCls: 'icon-tip',
			//url: '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'roleid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '角色ID',
				field : 'roleid',
				hidden : false
			},{
				width : '200',
				title : '角色名称',
				field : 'rolename',
				hidden : false
			},{
				width : '150',
				title : '角色描述',
				field : 'roledesc',
				hidden : false
			} ] ]
		});

		grid3 = $('#grid3').datagrid({
			title: '已授权角色列表',
			iconCls: 'icon-tip',
			//url: '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'roleid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '角色ID',
				field : 'roleid',
				hidden : false
			},{
				width : '200',
				title : '角色名称',
				field : 'rolename',
				hidden : false
			},{
				width : '150',
				title : '角色描述',
				field : 'roledesc',
				hidden : false
			} ] ]
		});
		
		v_gridaae1 = $('#gridaae1').datagrid({
			title: '未授权企业大类列表',
			iconCls: 'icon-tip',
			//url: '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 50,
			pageList : [ 50, 100, 150 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'aae140', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '大类名称',
				field : 'aae140',
				hidden : true
			},{
				width : '200',
				title : '大类名称',
				field : 'aae140name',
				hidden : false
			} ] ]
		});
		
		v_gridaae2 = $('#gridaae2').datagrid({
			title: '已授权企业大类列表',
			iconCls: 'icon-tip',
			//url: '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 50,
			pageList : [ 50, 100, 150 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'aae140', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				width : '100',
				title : '大类名称',
				field : 'aae140',
				hidden : true
			},{
				width : '200',
				title : '大类名称',
				field : 'aae140name',
				hidden : false
			} ] ]
		});		
		
	});/////
	
	function query() {
		var param = {
			'username': $('#username').val(),
			'userkind': $('#userkind').combobox('getValue'),
			'lockstate': $('#lockstate').combobox('getValue')
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	function addSysuser() {
		var dialog = parent.sy.modalDialog({
			title : '新增用户',
			width : 800,
			height : 550,
			url : basePath + '/sysmanager/sysuser/sysuserFormIndex',
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

	// 编辑
	function updateSysuser() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
			if (userid == '0' || userid == '1' || userid == '2' || userid == '3' || userid == '4') {
				$.messager.alert('警告', '该用户是系统预置标准用户，不可修改！', 'warning');
				return;
			}

			var dialog = parent.sy.modalDialog({
				title : '修改用户',
				width : 800,
				height : 550,
				url : basePath + '/sysmanager/sysuser/sysuserFormIndex?userid=' + row.userid,
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
		}else{
			$.messager.alert('提示', '请先选择要修改的用户！', 'info');
		}
	} 

	
	// 删除
	function delSysuser() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
			if (userid == '0' || userid == '1' || userid == '2' || userid == '3' || userid == '4') {
				$.messager.alert('警告', '该用户是系统预置标准用户，不可删除！', 'warning');
				return;
			}
			$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
				if (r) {
					$.post(basePath + 'sysmanager/sysuser/delSysuser', {
						userid: row.userid
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
			$.messager.alert('提示', '请先选择要删除的用户！', 'info');
		}
	}  	
	
	// 用户授权【角色、统筹区、机构、企业大类】
	function sysuserRole() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var param = {
				'userid' : row.userid
			};			
			grid2.datagrid({
				url : basePath + '/sysmanager/sysuser/querySysuserNoRole',			
				queryParams : param
			});
			grid2.datagrid('clearSelections'); 
			
			grid3.datagrid({
				url : basePath + '/sysmanager/sysuser/querySysuserRole',			
				queryParams : param
			});
			grid3.datagrid('clearSelections');
			
			v_gridaae1.datagrid({
				url : basePath + '/sysmanager/sysuser/querySysuserNoAae140',			
				queryParams : param
			});
			v_gridaae1.datagrid('clearSelections'); 
			
			v_gridaae2.datagrid({
				url : basePath + '/sysmanager/sysuser/querySysuserAae140',			
				queryParams : param
			});
			v_gridaae2.datagrid('clearSelections'); 							
			
			$('#dlg2').dialog('open').dialog('setTitle', '用户授权'); 	
			
			initUserAaa027CheckedZTreeNodes();//
			initUserOrgCheckedZTreeNodes();//
		}else{
			$.messager.alert('提示', '请先选择要授权的用户！', 'info');
		}
	}
	
	// 保存角色授权
	function saveSysuserRole() {
		var row = grid.datagrid('getSelected'); 
		var rows = grid3.datagrid("getRows");
		//if(rows.length>0){
			var JsonStr = $.toJSON(rows);//zjf
			var param = {
				'JsonStr' : JsonStr,
				'userid' : row.userid
			};  
			$.post(basePath + 'sysmanager/sysuser/saveSysuserRole', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','用户角色授权成功！','info',function(){
	        			//$('#dlg2').dialog('close'); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','用户角色授权失败：'+result.msg,'error');
                }
			}, 'json');
		//}
	}

	// 保存大类授权
	function saveSysuserAae140() {
		var row = grid.datagrid('getSelected'); 
		var rows = v_gridaae2.datagrid("getRows");
		//if(rows.length>0){
			var JsonStr = $.toJSON(rows);//zjf
			var param = {
				'JsonStr' : JsonStr,
				'userid' : row.userid
			};  
			$.post(basePath + 'sysmanager/sysuser/saveSysuserAae140', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','用户大类授权成功！','info',function(){
	        			//$('#dlg2').dialog('close'); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','用户大类授权失败：'+result.msg,'error');
                }
			}, 'json');
		//}
	}	
	
	// 封锁用户
	function lockSysuser() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var lockstate = row.lockstate;
			if(lockstate == '1'){
				$.messager.alert('提示', '该用户的账户已锁定！', 'info');
				return;
			}
			$('#fm3').form('load',{'userid':row.userid,'username':row.username});
			$('#dlg3').dialog('open').dialog('setTitle', '封锁用户');				
		}else{
			$.messager.alert('提示', '请先选择要封锁的用户！', 'info');
		}		
	} 
	
	// 封锁用户【保存】
	function saveLockSysuser() {
		$('#fm3').form('submit',{
			url: basePath + '/sysmanager/sysuser/lockSysuser',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','封锁用户成功！','info',function(){
	        			$('#fm3').form('clear');
	        			$('#dlg3').dialog('close');
						$('#grid').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','封锁用户失败：'+result.msg,'error');
                }
	        }    
		});
	} 

	// 解锁用户
	function unlockSysuser() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var lockstate = row.lockstate;
			if(lockstate == '0'){
				$.messager.alert('提示', '该用户的账户状态正常！', 'info');
				return;
			}
			$.messager.confirm('警告', '您确定要解锁该用户吗?',function(r) {
				if (r) {
					$.ajax({
						url: basePath + '/sysmanager/sysuser/unlockSysuser',
						type: 'post',
						async: true,
						cache: false,
						timeout: 100000,
						data: 'userid=' + row.userid,
						dataType: 'json',
						error: function() {
							$.messager.alert('提示','服务器繁忙，请稍后再试！','info');		
						},
						success: function(result) {
							if (result.code=='0'){
				        		$.messager.alert('提示','解锁用户成功！','info',function(){
									$('#grid').datagrid('reload');  
				        		}); 	                        	            	                        	                     
			              	} else {
			              		$.messager.alert('提示','解锁用户失败：'+result.msg,'error');
			                }	
						}
					});
				}
			});							
		}else{
			$.messager.alert('提示', '请先选择要解锁的用户！', 'info');
		}		
	} 

	// 重置密码
	function resetPasswd() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要重置该用户密码吗?',function(r) {
				if (r) {
					$.ajax({
						url: basePath + '/sysmanager/sysuser/resetPasswd',
						type: 'post',
						async: true,
						cache: false,
						timeout: 100000,
						data: 'userid=' + row.userid,
						dataType: 'json',
						error: function() {
							$.messager.alert('提示','服务器繁忙，请稍后再试！','info');		
						},
						success: function(result) {
							if (result.code=='0'){
				        		$.messager.alert('提示','重置密码成功！','info'); 	                        	                     
			              	} else {
			              		$.messager.alert('提示','重置密码失败：'+result.msg,'error');
			                }	
						}
					});
				}
			});							
		}else{
			$.messager.alert('提示', '请先选择要重置密码的用户！', 'info');
		}		
	}

	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	} 
	
	// 签名上传
	function qianmingsc(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=dzqm&fjwid="+row.userid;
			var dialog = parent.sy.modalDialog({
				title : '签名上传',
				width : 900,
				height : 700,
				url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要上传的记录！', 'info');
		}
	}
	
	//签到点绑定	 
	 function qiandaodbd(){
	   var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '签到点绑定',
				width : 800,
				height : 550,
				url : basePath + 'sysmanager/sysuser/QianDaodbdIndex?userid='+row.userid,
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
		}else{
			$.messager.alert('提示','请先选择要绑定的用户信息！','info');
		}
	}     
 
</script>
<script type="text/javascript">
    var v_tempgrid2=grid2;
    var v_tempgrid3=grid3;
    
    function mysetgrid(v_gridkind){
    	if (v_gridkind=="grid2"){        		
    		v_tempgrid2 = grid2;
    		v_tempgrid3 = grid3;	
    		
    		//v_tempgrid2=$("#grid2").datagrid({url : ''});
    		//v_tempgrid3=$("#grid3").datagrid({url : ''});
    	}else if (v_gridkind=="gridaae"){
    		v_tempgrid2 = v_gridaae1;
    		v_tempgrid3 = v_gridaae2;
    		//v_tempgrid2=$("#gridaae1").datagrid({url : ''});
    		//v_tempgrid3=$("#gridaae2").datagrid({url : ''});			
    	}
    }
	var btn1 = function(v_gridkind) {
		mysetgrid(v_gridkind);
		var rows = v_tempgrid2.datagrid("getRows"),
		data = $.array.clone(rows);
		$.each(data,function(i, val) {
			selectRow(val);
		});
		v_tempgrid2.datagrid("unselectAll");
		refreshValue();
	},
	btn2 = function(v_gridkind) {
		mysetgrid(v_gridkind);
		var rows = v_tempgrid2.datagrid("getSelections"),
		data = $.array.clone(rows);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		$.each(data,function(i, val) {
			selectRow(val);
		});
		v_tempgrid2.datagrid("unselectAll");
		refreshValue();
	},
	btn3 = function(v_gridkind) {
		mysetgrid(v_gridkind);
		var rows = v_tempgrid3.datagrid("getSelections"),
		data = $.array.clone(rows);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		$.each(data,function(i, val) {
			unselectRow(val);
		});
		v_tempgrid3.datagrid("unselectAll");
		refreshValue();
	},
	btn4 = function(v_gridkind) {
		mysetgrid(v_gridkind);
		var rows = v_tempgrid3.datagrid("getRows"),
		data = $.array.clone(rows);
		$.each(data,function(i, val) {
			unselectRow(val);
		});
		v_tempgrid3.datagrid("unselectAll");
		refreshValue();
	},
	selectRow = function(row) {
		if (!row) {
			return;
		}
		var tOpts = v_tempgrid2.datagrid("options"),
		idField = tOpts.idField;
		var isExists = v_tempgrid3.datagrid("getRowIndex", row[idField]) > -1;
		if (!isExists) {
			v_tempgrid3.datagrid("appendRow", row);
			v_tempgrid2.datagrid("deleteRow", v_tempgrid2.datagrid("getRowIndex", row[idField]));
		}
	},
	unselectRow = function(row) {
		if (!row) {
			return;
		}
		var tOpts = v_tempgrid3.datagrid("options"),
		idField = tOpts.idField;
		var isExists = v_tempgrid2.datagrid("getRowIndex", row[idField]) > -1;
		if (!isExists) {
			v_tempgrid2.datagrid("appendRow", row);
			v_tempgrid3.datagrid("deleteRow", v_tempgrid3.datagrid("getRowIndex", row[idField]));
		}
		else{
			v_tempgrid3.datagrid("deleteRow", v_tempgrid3.datagrid("getRowIndex", row[idField]));
		}
	},
	refreshValue = function() {
		var rows = v_tempgrid3.datagrid("getRows");
		value = $.array.clone(rows);
	};		
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
						<td style="text-align:right;"><nobr>用户名称</nobr></td>
						<td><input id="username" name="username" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>用户类别</nobr></td>
						<td><input id="userkind" name="userkind" style="width: 200px" /></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>账户锁定状态</nobr></td>
						<td><input id="lockstate" name="lockstate" style="width: 200px" /></td>					
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="用户列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysuser"
								iconCls="icon-add" plain="true" onclick="addSysuser()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
								iconCls="icon-edit" plain="true" onclick="updateSysuser()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysuser"
								iconCls="icon-remove" plain="true" onclick="delSysuser()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveSysuserRole"
								iconCls="icon-group_key" plain="true" onclick="sysuserRole()">用户授权</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_lockSysuser"
								iconCls="icon-lock" plain="true" onclick="lockSysuser()">封锁</a>
							</td> 
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_unlockSysuser" 
								iconCls="icon-unlock" plain="true" onclick="unlockSysuser()">解锁</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_resetPasswd"
								iconCls="icon-key" plain="true" onclick="resetPasswd()">重置密码</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_sysuserQmsc"
								iconCls="icon-upload" plain="true" onclick="qianmingsc()">签名上传</a>
							</td>							
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_sysuserQmsc"
								iconCls="ext-icon-group_link" plain="true" onclick="qiandaodbd()">签到点绑定</a>
							</td>							
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton"  -->
<!-- 								iconCls="icon-print" plain="true" onclick="print()">打印</a> -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>    -->
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>           
		
		<div id="dlg2" class="easyui-dialog" style="width:950px;height:480px;overflow: hidden;" closed="true" closeable="true"  modal="true">
			<div id="tt" class="easyui-tabs" style="width:950px;height:480px;">
			    <div title="角色授权" data-options="iconCls:'icon-reload',closable:false" style="overflow:auto;padding:10px;">
					<sicp3:groupbox title="角色授权">
						<table>
							<tr>
								<td>
									<table id="grid2"  style="width:420px;height:340px;overflow-y:auto;overflow-x:hidden;"></table>
								</td>
								<td style="text-align:center;">
									<table>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_fastforward_blue'" onclick="btn1('grid2');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_end_blue'" onclick="btn2('grid2');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_start_blue'" onclick="btn3('grid2');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_rewind_blue'" onclick="btn4('grid2');" ></a></td></tr>
									</table>
								</td>
								<td>
									<table id="grid3" style="width:420px;height:340px;overflow-y:auto;overflow-x:hidden;"></table>
								</td>
							</tr>
						</table>	
					</sicp3:groupbox> 
					<div id="dlg2-buttons" style="float:right" >
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveSysuserRole();">保存角色授权</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
					</div>					
			    </div>
			    <div title="企业大类授权" data-options="iconCls:'icon-reload',closable:false" style="overflow:auto;padding:10px;">
					<sicp3:groupbox title="企业大类授权">
						<table>
							<tr>
								<td>
									<table id="gridaae1"  style="width:420px;height:340px;overflow-y:auto;overflow-x:hidden;"></table>
								</td>
								<td style="text-align:center;">
									<table>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_fastforward_blue'" onclick="btn1('gridaae');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_end_blue'" onclick="btn2('gridaae');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_start_blue'" onclick="btn3('gridaae');" ></a></td></tr>
										<tr><td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-control_rewind_blue'" onclick="btn4('gridaae');" ></a></td></tr>
									</table>
								</td>
								<td>
									<table id="gridaae2" style="width:420px;height:340px;overflow-y:auto;overflow-x:hidden;"></table>
								</td>
							</tr>
						</table>
					</sicp3:groupbox> 
					<div id="dlg2-buttons2" style="float:right" >
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveSysuserAae140();">保存大类授权</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
					</div>											
			    </div>
			    <div title="行政区划授权" data-options="iconCls:'icon-reload',closable:false" style="padding:10px;">
					<sicp3:groupbox title="行政区划授权">
		        		<div style="width:400px;height:340px;overflow: hidden;">
                            <ul id="treeDemo_userAaa027Grant" class="ztree" ></ul> 							 
							<input type="hidden" id="aaa027treeCheckedNodes">
						</div>										
					</sicp3:groupbox> 
					<div id="dlg2-buttons" style="float:right">
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveSysuserAaa027Grant();">保存行政区划授权</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
					</div>
			    </div>
			    <div title="机构授权" data-options="iconCls:'icon-reload',closable:false" style="padding:10px;">
					<sicp3:groupbox title="机构授权">
		        		<div style="width:400px;height:340px;overflow: hidden;">
                            <ul id="treeDemo_userOrgGrant" class="ztree" ></ul> 							 
							<input type="hidden" id="userOrgtreeCheckedNodes">
						</div>										
					</sicp3:groupbox> 
					<div id="dlg2-buttons" style="float:right">
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveSysuserOrgGrant();">保存机构授权</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
					</div>
			    </div>			    
			</div>			
		</div>
	
		<div id="dlg3" class="easyui-dialog" style="width:400px;height:300px;padding:10px 10px;"
			closed="true" closeable="true" buttons="#dlg3-buttons" modal="true">
			<form id="fm3" method="post">
	        	<sicp3:groupbox title="用户信息">	
	        		<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>用户ID:</nobr></td>
							<td><input id="userid3" name="userid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>						
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>用户名称:</nobr></td>
							<td><input id="username3" name="username" style="width: 200px" readonly="readonly" class="input_readonly" /></td>						
						</tr>
						<tr>						
							<td style="text-align:right;"><nobr>账户封锁原因:</nobr></td>
							<td><input id="lockreason3" name="lockreason" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>									
						</tr>
					</table>
		        </sicp3:groupbox>
		   </form>
		   <div id="dlg3-buttons">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveLockSysuser();">确定</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg3').dialog('close')">取消</a>
			</div>
		</div>
	</div> 
</body>
</html>