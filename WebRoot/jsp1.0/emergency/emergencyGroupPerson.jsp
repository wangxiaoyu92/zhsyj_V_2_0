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
	// 应急小组id
	String v_groupid = StringHelper.showNull2Empty(request.getParameter("groupid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>应急小组成员管理</title>
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
	// 数据过滤
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
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 
	var cb_userkind; // 用户类别
	var cb_lockstate; // 用户锁定状态
	var grid; // 用户信息表
	var persongrid; // 小组成员关系表
	
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
			//url: basePath + 'sysmanager/sysuser/querySysuser',
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
				width : '100',
				title : '用户ID',
				field : 'userid',
				hidden : true
			},{
				width : '80',
				title : '用户',
				field : 'username',
				hidden : false
			},{
				width : '80',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '100',
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
				width : '80',
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
				width : '200',
				title : '统筹区',
				field : 'aaa027',
				hidden : true
			} ] ]
		});
		// 初始化应急小组成员表
		persongrid = $('#persongrid').datagrid({
			url : basePath + '/emergency/queryEmergencyGroupPerson',
			queryParams : {groupid : <%=v_groupid%>},// 请求参数
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
		    idField: 'etpid', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title: '成员关系表id',
				field: 'etpid',
				width : '100',
				hidden : true
			},{
				title: '应急小组id',
				field: 'groupid',
				width : '200',
				hidden : true
			},{
				title: '用户id',
				field: 'userid',
				width: '100',
				hidden: true
			},{
				title: '用户名',
				field: 'username',
				width: '100',
				hidden: false
			},{
				title: '用户描述',
				field: 'description',
				width: '100',
				hidden: false
			},{
				title: '手机号',
				field: 'mobile',
				width: '100',
				hidden: false
			},{
				title: '部门名称',
				field: 'orgname',
				width: '100',
				hidden: false
			},{
				width : '100',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(userkind,value);
				}
			},{
				title: '成员类型',
				field: 'etptype',
				width: '100',
				hidden: false
			},{
				title: '备注',
				field: 'etpremark',
				width: '100',
				hidden: false
			},{
				title: '状态',
				field: 'state',
				width: '100',
				hidden : true
			},{
				title: '经办人',
				field: 'opepateperson',
				width: '100',
				hidden : true
			},{
				title: '经办时间',
				field: 'opepatedate',
				width: '120',
				hidden : true
			}] ]
		});
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 添加用户到应急小组(多选)
	function addUserToGroup() {
		var rows1 = grid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		var rows = grid.datagrid("getSelections");
		var JsonStr = $.toJSON(rows);
		var param = {
			'JsonStr' : JsonStr,
			'groupid' : <%=v_groupid%>
		};  
		$.post(basePath + '/emergency/addUserToEmergencyGroup', param, function(result) {
			if (result.code=='0'){
        		$.messager.alert('提示','操作成功！','info',function(){
        			$('#persongrid').datagrid('reload'); 
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：'+result.msg,'error');
               }
		}, 'json');
		
	} 
	// 编辑成员信息
	function updateGroupUser() {
		var row = $('#persongrid').datagrid('getSelected');
		if (row) {
			<%-- var obj=new Object();
			var url='<%=basePath%>emergency/emergencyGroupPersonFromIndex?etpid=' + row.etpid;		
			var k = myShowModalDialog(url,obj,950,400);  --%>
			var url = '<%=basePath%>emergency/emergencyGroupPersonFromIndex'; 
			var dialog = parent.sy.modalDialog({  
				width : 950,
				height : 400,
				param : {
					etpid : row.etpid
				},  
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID);  
					if (k!=null && "ok"==k){
						$("#persongrid").datagrid("reload");
					}
				sy.removeWinRet(dialogID);
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	
	// 将用户从小组中移除
	function delUserOutOfGroup() {
		var rows1 = persongrid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		var rows = persongrid.datagrid("getSelections");
		var JsonStr = $.toJSON(rows);
		var param = {
			'JsonStr' : JsonStr,
			'groupid' : <%=v_groupid%>
		};  
		$.post(basePath + '/emergency/delUserOutOfEmergencyGroup', param, function(result) {
			if (result.code=='0'){
        		$.messager.alert('提示','操作成功！','info',function(){
        			$('#persongrid').datagrid('reload'); 
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：'+result.msg,'error');
               }
		}, 'json');
	}  	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<input id="groupid" name="groupid" type="hidden" value="<%=v_groupid%>"/>
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="用户列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addUserToGroup"
								iconCls="ext-icon-user_add" plain="true" onclick="addUserToGroup()">加入到应急小组</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <br><br>
	        <sicp3:groupbox title="应急小组成员关系列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateGroupUser"
								iconCls="ext-icon-user_edit" plain="true" onclick="updateGroupUser()">编辑成员信息</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delUserOutOfGroup"
								iconCls="ext-icon-user_delete" plain="true" onclick="delUserOutOfGroup()">从小组中移除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="persongrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>