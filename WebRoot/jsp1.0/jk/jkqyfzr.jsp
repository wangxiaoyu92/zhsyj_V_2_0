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
	// 监控企业id
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>指派监控人</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
var obj = new Object();
obj.type = 'ok'; 
window.returnValue = obj;
	var grid; // 用户信息表
	var jkqyfzrgrid; // 小组成员关系表
	// 组织结构树
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
	
	$(function() {
		// 初始化用户表
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
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
				title : '手机号',
				field : 'mobile2',
				hidden : false
			},{
				width : '200',
				title : '统筹区',
				field : 'aaa027',
				hidden : true
			} ] ]
		});
		// 初始化应急小组成员表
		jkqyfzrgrid = $('#jkqyfzrgrid').datagrid({
			url : basePath + 'jk/jkgl/queryJkfzrList',
			queryParams : {comid : '<%=v_comid%>'},// 请求参数
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
		    idField: 'jkqyfzrid', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title: '监管企业负责人id',
				field: 'jkqyfzrid',
				width : '100',
				hidden : true
			},{
				title: '企业id',
				field: 'comid',
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
				title: '手机号',
				field: 'mobile2',
				width: '100',
				hidden: false
			},{
				title: '部门名称',
				field: 'bmmc',
				width: '100',
				hidden: false
			}] ]
		});
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 添加用户到监管人(多选)
	function addUserToJkqyFzr() {
		var rows1 = grid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		var rows = grid.datagrid("getSelections");
		var rygrid_rows = $.toJSON(rows);
		var param = {
			'rygrid_rows' : rygrid_rows,
			'comgrid_rows' : $.toJSON([{comid : '<%=v_comid%>'}])
		};  
		$.post(basePath + 'jk/jkgl/saveJkFzr', param, function(result) {
			if (result.code=='0'){
        		$.messager.alert('提示','操作成功！','info',function(){
        			$('#jkqyfzrgrid').datagrid('reload'); 
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：'+result.msg,'error');
               }
		}, 'json');
	} 
	
	// 移除
	function delJkqyFzr() {
		var rows1 = jkqyfzrgrid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		var rows = jkqyfzrgrid.datagrid("getSelections");
		var rygrid_rows = $.toJSON(rows);
		var param = {
			'rygrid_rows' : rygrid_rows,
			'comid' : '<%=v_comid%>'
		};  
		$.post(basePath + 'jk/jkgl/delJkqyFzr', param, function(result) {
			if (result.code == '0'){
        		$.messager.alert('提示','操作成功！','info',function(){
        			$('#jkqyfzrgrid').datagrid('reload'); 
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
		<input id="comid" name="comid" type="hidden" value="<%=v_comid%>"/>
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="人员信息列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" iconCls="ext-icon-user_add" plain="true" 
								class="easyui-linkbutton" onclick="addUserToJkqyFzr()">添加监管人</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <br><br>
	        <sicp3:groupbox title="企业监管人列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" iconCls="ext-icon-user_delete" 、
								class="easyui-linkbutton" plain="true" onclick="delJkqyFzr()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="jkqyfzrgrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>