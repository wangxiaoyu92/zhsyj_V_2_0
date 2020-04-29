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
<title>业务参数管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var setting = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "bccode",
				pIdKey: "bcparentcode",
				rootPId: 0		
			},
			key: {
				name: "bcname"
			}
		},
		callback: {
			onClick: onClick,
			onExpand : onExpand
		}
		
	};

	//单击节点事件
	function onClick(event, treeId, treeNode) {         
		//onExpand(event, treeId, treeNode);
		/*
		$('#grid').datagrid({
			url : basePath + '/zx/BusinessCode/queryBusinessCodeZTree',			
			queryParams : {'curCode':treeNode.bccode}
		});
		$('#grid').datagrid('unselectAll'); 		  
		*/
		var name = '',name2="";
		if(treeNode.bclevel == '1'){
			name = "子系统";
			name2 = "业务";
		}
		else if(treeNode.bclevel == '2'){
			name = "业务";
			name2 = "项目";
		}
		else if(treeNode.bclevel == '3'){
			name = "项目";
			name2 = "级别";
		}
		else if(treeNode.bclevel == '4'){
			name = "级别";
			name2 = "错误，不能添加";
		}
		else if(treeNode.bclevel == '0'){
			name = "根";
			name2 = "子系统";
		}
		else{
			name = "未知";
			name2 = "错误，不能添加";
		}
		$('#showCurrNodeName').val(treeNode.bcname);
		$('#showCurrNodeType').val(name);
		$('#currNodeName').val(treeNode.bccode);
		$('#currNodeType').val(treeNode.bclevel);
		$('#newNodeTypeName').val(name2);
	}
	
	function onExpand(event, treeId, treeNode){
		$.ajax({
			url:basePath + '/zx/BusinessCode/queryBusinessCodeZTree?curCode='+treeNode.bccode,
			type:'json',
			async:true,
			cache:false,
			timeout: 100000,
			//data:formData,
			error:function(){
				alert("服务器繁忙，请稍后再试！");
			},
			success: function(obj){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var zNodes = eval('('+obj+')');
				//treeObj.removeChildNodes(treeNode);
				var r = eval('('+zNodes.treeData+')');
				treeObj.addNodes(treeNode,r,false);
		     }
		});
	}

	$(function(){
		//初始化机构树
		$.post(basePath + '/zx/BusinessCode/queryBusinessCodeZTree', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.treeData);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);  	
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	});
</script>
<script type="text/javascript">
	var cb_sysroleflag;

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

		$('#grid').datagrid({
			title: '业务参数',
			//iconCls: 'icon-tip',
			//height:380,
			toolbar: '#toolbar',
			url: basePath + 'zx/BusinessCode/queryBusinessCodeList',
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
				width : '120',
				title : '子系统',
				field : 'subsys'
			},{
				width : '120',
				title : '业务',
				field : 'business',
				hidden : false
			},{
				width : '140',
				title : '项目',
				field : 'item',
				hidden : false
			},{
				width : '80',
				title : '级别',
				field : 'level',
				hidden : false
			} ,{
				width : '80',
				title : '分值',
				field : 'score',
				hidden : false
			} ,{
				width : '80',
				title : '系数',
				field : 'ratio',
				hidden : false
			} ,{
				width : '80',
				title : '是否启用',
				field : 'enable',
				hidden : false,
					formmatter:function(value,rec){
						if(value == '0'){
							return "禁用";
						}
						else{
							return "启用";
						}
					}
			} ,{
				width : '80',
				title : '开始日期',
				field : 'bpdatebegin',
				hidden : false
			} ,{
				width : '80',
				title : '结束日期',
				field : 'bpdateend',
				hidden : false
			} 
			] ]
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
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');
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
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
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
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的角色！', 'info');
		}
	};

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
 
	// 授权
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
						dialog.find('iframe').get(0).contentWindow.saveSysroleGrant(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});						
		}else{
			$.messager.alert('提示', '请先选择要授权的角色！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>                   
        <div region="center" style="overflow: hidden;width:99%;" border="false">
            <sicp3:groupbox title="业务参数列表" display='none' >
       		        <fieldset  >
       	            <legend >当前节点信息</legend>
		        		<table class="table" style="width: 99%;border:solid 0px red;" border="0">
							<tr>
								<td style="text-align:right;"><nobr>当前节点名称</nobr></td>
								<td><input id="showCurrNodeName"  style="width: 100px" readOnly="readonly"/></td>						
								<td style="text-align:right;"><nobr>当前节点类别:</nobr></td>
								<td><input id="showCurrNodeType"  style="width: 100px"  readOnly="readonly"/></td>			
							</tr>
						</table>
					</fieldset>
					<fieldset  >
       	            <legend >追加新节点</legend>
					<table class="table" style="width: 99%;border:solid 0px red;">
						<tr>	
						    <td style="text-align:right;"><nobr>追加节点类型：</nobr></td>
							<td><input id="newNodeTypeName" name="newNodeTypeName" style="width: 100px" readonly="readonly"/></td>
						    <td style="text-align:right;"><nobr>追加节点名称：</nobr></td>
							<td><input id="newNodeType" name="newNodeName" style="width: 100px" /></td>
							<td colspan="4">
							    <a href="javascript:void(0)" class="easyui-linkbutton"  plain="true"
									iconCls="icon-save" onclick="query()"> 保存 </a>
								   <div class="datagrid-btn-separator"></div>
								<a href="javascript:void(0)" class="easyui-linkbutton"  plain="true"
									iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
							</td>
							<input type="hidden" id="currNodeCode" name="currNodeCode" >
							<input type="hidden" id="currNodeType" name="currNodeType" >
						</tr>
				 </table>
				 </fieldset>
        	</sicp3:groupbox>
	        <br>
        	<sicp3:groupbox title="业务参数列表">
	        	<div id="toolbar">
	        	    <table>
						<tr>
							<td style="text-align:right;"><nobr>子系统</nobr></td>
							<td><input id="subsys" name="subsys" style="width: 100px"/></td>						
							<td style="text-align:right;"><nobr>业务</nobr></td>
							<td><input id="business" name="business" style="width: 100px" /></td>			
							<td style="text-align:right;"><nobr>项目</nobr></td>
							<td><input id="item" name="item" style="width: 100px" /></td>
							<td style="text-align:right;"><nobr>级别</nobr></td>
							<td><input id="level" name="level" style="width: 40px" /></td>
							<td style="text-align:right;"><nobr>得分</nobr></td>
							<td><input id="score" name=""score"" style="width: 40px" /></td>
							<td style="text-align:right;"><nobr>系数</nobr></td>
							<td><input id="ratio" name="ratio" style="width: 40px" /></td>
							<td>
								<a href="javascript:void(0)" class="easyui-linkbutton"  plain="true"
									iconCls="icon-search" onclick="query()"> 查 询 </a>
								<div class="datagrid-btn-separator"></div>
								<a href="javascript:void(0)" class="easyui-linkbutton"  plain="true"
									iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
							</td>
						</tr>
					</table>
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
								iconCls="icon-group_key" plain="true" onclick="sysroleGrantIndex()">授权</a>
							</td> 
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
				<div style="width:100%;height:100%;overflow:none;">
					<table id="grid"></table>
				</div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>