<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
	String roleid = StringHelper.showNull2Empty(request.getParameter("roleid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>角色绑定用户</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">	
	var roleid = '<%=roleid %>';
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
	// 数据过滤
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}
	
	//单击节点事件
	var orgid = ""; 
	var username = ""; 
	var userkind_v = "";	 
	function onClick(event, treeId, treeNode) {
		orgid = treeNode.orgid;
		username = $('#username').val();
		userkind_v =  $('#userkind').combobox('getValue');          
		querySysroleNoUser();
		querySysroleUser();		  
	}

	
	//查询角色未绑定的用户
	function querySysroleNoUser(){
		grid.datagrid({
			url : basePath + '/sysmanager/sysrole/querySysroleNoUser',			
			queryParams : {
				'roleid': roleid,
				'orgid': orgid,
				'username': username,
				'userkind': userkind_v
			}
		});
		grid.datagrid('unselectAll'); 
	}
	//查询角色已绑定的用户
	function querySysroleUser(){
		grid2.datagrid({
			url : basePath + '/sysmanager/sysrole/querySysroleUser',			
			queryParams : {
				'roleid': roleid,
				'orgid': orgid,
				'username': username,
				'userkind': userkind_v
			}
		});
		grid2.datagrid('unselectAll'); 
	}
</script>
<script type="text/javascript">
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 
	var cb_userkind; // 用户类别
	var cb_lockstate; // 用户锁定状态
	var grid; // 用户信息表
	var grid2; // 用户角色关系表
	
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
		// 初始化用户表
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			//url: basePath + 'sysmanager/sysrole/querySysroleNoUser',
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
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : true
			},{
				width : '150',
				title : '用户名',
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
				width : '200',
				title : '所属机构',
				field : 'orgname',
				hidden : false
			}] ]
		});
		// 初始化用户角色关系表
		grid2 = $('#grid2').datagrid({
			toolbar: '#toolbar2',
			//url : basePath + 'sysmanager/sysrole/querySysroleUser',
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
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : true
			},{
				width : '150',
				title : '用户名',
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
				width : '200',
				title : '所属机构',
				field : 'orgname',
				hidden : false
			}] ]
		});
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 角色绑定用户(多选)
	function addSysuserRole() {
		var rows = grid.datagrid("getSelections");
		if(rows.length>0){
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr,
				'roleid' : roleid
			};  
			$.post(basePath + '/sysmanager/sysrole/addSysuserRole', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			querySysroleNoUser();
	        			querySysroleUser();	        			
	        		}); 	                        	                     
	             } else {
	             	$.messager.alert('提示','操作失败：'+result.msg,'error');
	             }
			}, 'json');
		}else{
			$.messager.alert('提示', '请先选择要操作的记录!', 'warning');
			return;
		}
	} 
	
	// 角色解除绑定用户(多选)
	function delSysuserRole() {
		var rows = grid2.datagrid("getSelections");
		if(rows.length>0){
			var JsonStr = $.toJSON(rows); 
			var param = {
				'JsonStr' : JsonStr,
				'roleid' : roleid
			};  
			$.post(basePath + '/sysmanager/sysrole/delSysuserRole', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			querySysroleNoUser();
	        			querySysroleUser();
	        		}); 	                        	                     
	             } else {
	             	$.messager.alert('提示','操作失败：'+result.msg,'error');
	             }
			}, 'json');
		}else{
			$.messager.alert('提示', '请先选择要操作的记录!', 'warning');
			return;
		}
	}  	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
		    <sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>用户名称</nobr></td>
						<td><input id="username" name="username" style="width: 150px"/></td>						
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>用户类别</nobr></td>
						<td><input id="userkind" name="userkind" style="width: 150px" /></td>								
					</tr>
				</table>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="所属机构">
        		<ul id="treeDemo" class="ztree" ></ul>
        	</sicp3:groupbox>       
        </div>
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="角色【未绑定】用户列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysuserRole"
								iconCls="ext-icon-user_add" plain="true" onclick="addSysuserRole()">绑定用户</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="角色【已绑定】用户列表">
	        	<div id="toolbar2">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysuserRole"
								iconCls="ext-icon-user_delete" plain="true" onclick="delSysuserRole()">解除绑定</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="grid2" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>