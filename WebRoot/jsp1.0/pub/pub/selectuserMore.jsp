<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_querykind = StringHelper.showNull2Empty(request.getParameter("querykind"));
	if (null==v_querykind || "".equalsIgnoreCase(v_querykind)){
		v_querykind="no";
	}
	
	//目前是选择企业日常监督管理人员时，传过来已经选择过的人员id列表，以逗号分隔例如2016052614593110739048580,2016052614593110739048599
	String v_useridstr = StringHelper.showNull2Empty(request.getParameter("useridstr"));
	
%>
<!DOCTYPE html>
<html>
<head>
<title>选择</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync?',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {"querykind":"<%=v_querykind%>"}, //额外的参数 gu20161210add pubkind='all'取所有的部门
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
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : {'orgid':treeNode.orgid}
		});
		grid.datagrid('unselectAll'); 		  
	}
</script>
<script type="text/javascript">
	var singleSelect =sy.getUrlParam("singleSelect");
	var v_singleSelect=(singleSelect=="true");
	
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 	
	//下拉框列表
	var cb_userkind;
	var cb_lockstate;
	var grid;
	var myselectgrid; 
	
	$(function() {
		grid = $('#grid').datagrid({
			singleSelect:v_singleSelect,// True只允许选中一行
			striped : true,// 奇偶行使用不同背景色
			checkOnSelect : true,
			selectOnCheck : true,
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度		
			pagination : true,// 底部显示分页栏
			pageSize : 200,
			pageList : [ 200, 400, 600 ],		
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
			{
				width : '100',
				field: 'userid', 
				checkbox:'true',
				hidden : false
			},{
				width : '80',
				title : '机构ID',
				field : 'orgid',
				hidden : true
			},{
				width : '150',
				title : '机构名称',
				field : 'orgname',
				hidden : false
			},{
				width : '120',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '120',
				title : '用户名称',
				field : 'username',
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
				title : '手机号2',
				field : 'mobile2',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'mobile',
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
			}, {
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : false
			} ] ]
		}); 
		
		myselectgrid = $('#myselectgrid').datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : {
				useridstr:'<%=v_useridstr%>',
				querykind:'1'
			},			
			singleSelect:false,// True只允许选中一行
			striped : true,// 奇偶行使用不同背景色
			checkOnSelect : true,
			selectOnCheck : true,
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度		
			pagination : true,// 底部显示分页栏
			pageSize : 200,
			pageList : [ 200, 400, 600 ],		
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
			{
				width : '100',
				field: 'userid', 
				checkbox:'true',
				hidden : true
			},{
				width : '80',
				title : '机构ID',
				field : 'orgid',
				hidden : true
			},{
				width : '150',
				title : '机构名称',
				field : 'orgname',
				hidden : false
			},{
				width : '120',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '120',
				title : '用户名称',
				field : 'username',
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
				title : '手机号2',
				field : 'mobile2',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'mobile',
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
			}, {
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : false
			} ] ]
		});
		
	});///////////////////////////
	
	function query() {
		var param = {
			'description': $('#description').val(),
			'userjc': $('#userjc').val(),
			'querykind':'2'
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections'); 
	};

	// 刷新
	function refresh(){
		$('#username').val('');
		var param = {
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : param
		});
	}; 
	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = grid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	
   function queding(){
     var rows=myselectgrid.datagrid('getRows');
	   sy.setWinRet(rows);
	   parent.$("#"+sy.getDialogId()).dialog("close");
   };
   
   function addToSelectGrid(){
		var myrows = grid.datagrid("getChecked");
		var mydata = $.array.clone(myrows);
 		if (!mydata.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}; 
 		$.each(mydata,function(i, val) {
			myselectRow(val);
		}); 
		//v_tempgrid2.datagrid("unselectAll");
		//refreshValue();	   
   };
   
 	function myselectRow(row){
		if (!row) {
			return;
		}
		var tOpts = grid.datagrid("options");
		var idField = tOpts.idField;
		var isExists = myselectgrid.datagrid("getRowIndex", row[idField]) > -1;
		if (!isExists) {
			myselectgrid.datagrid("appendRow", row);
			//v_tempgrid2.datagrid("deleteRow", v_tempgrid2.datagrid("getRowIndex", row[idField]));
		}
	}; 
	
/* 	refreshValue = function() {
		var rows = myselectgrid.datagrid("getRows");
		value = $.array.clone(rows);
	};	 */	
	
	function mydeleterow(){
		var row = myselectgrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认', '您确定要删除该行吗?',function(r) {
				if (r){			
					var indexdelete = myselectgrid.datagrid('getRowIndex',myselectgrid.datagrid('getSelected'));
					if(indexdelete == -1){
						alert("请先选择要删除的行！");
						return false;
					}
					$.messager.alert('提示','删除成功！','info',function(){
						myselectgrid.datagrid('deleteRow',indexdelete);
		    		}); 
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的行！', 'info');
		}		
	};
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:160px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 800px;">
					<tr>
						<td style="text-align:right;"><nobr>用户汉字描述</nobr></td>
						<td><input id="description" name="description" style="width: 180px"/></td>
						<td style="text-align:right;"><nobr>拼音首字母</nobr></td>
						<td><input id="userjc" name="userjc" style="width: 120px"/></td>													
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;
						</td>
					</tr>
				</table>
	        </sicp3:groupbox> 
        	<sicp3:groupbox title="用户列表">
				<div id="grid" style="height:260px;width: 800px;overflow:auto;"></div>
	        </sicp3:groupbox>	
	        <table style="width: 800px;height: 20px;border: 1px solid blue;margin-left: 6px;">
	          <tr>
	            <td style="width: 20%"></td>
	            <td style="width: 60%;margin-top: 5px;">
					<a href="javascript:void(0)" class="easyui-linkbutton"
					   iconCls="ext-icon-arrow_down" onclick="addToSelectGrid()"> 增加到选择列表</a>
					&nbsp;&nbsp;&nbsp;&nbsp;   
					<a href="javascript:void(0)" class="easyui-linkbutton"
					   iconCls="icon-ok" onclick="queding()">确定选择</a>
					&nbsp;&nbsp;&nbsp;&nbsp;   
					<a href="javascript:void(0)" class="easyui-linkbutton"
					   iconCls="icon-delete" onclick="mydeleterow()">删除行</a>						   					   		            
	            </td>
	            <td style="width: 20%"></td>
	          </tr>
	        </table>
	        <sicp3:groupbox title="已选择的用户列表">
			   <table id="myselectgrid" style="width:800px;height:180px;overflow-y:auto;overflow-x:hidden;"></table>
			</sicp3:groupbox>
        </div>          
	</div> 
</body>
</html>