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
	var cb_userkind;
	var cb_lockstate;
	var grid;
	 
	
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
			singleSelect:v_singleSelect,// True只允许选中一行
			striped : true,// 奇偶行使用不同背景色
			checkOnSelect : true,
			selectOnCheck : true,
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度		
			pagination : true,// 底部显示分页栏
			pageSize : 500,
			pageList : [ 500, 1000, 1500 ],		
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
				hidden : false
			},{
				width : '150',
				title : '机构名称',
				field : 'orgname',
				hidden : false
			},{
				width : '200',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '150',
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
	});
	
	function query() {
		var param = {
			'username': $('#username').val(),
			'userkind': $('#userkind').combobox('getValue'),
			'lockstate': $('#lockstate').combobox('getValue'),
			'querykind':'all'
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		$('#username').val('');
		$('#userkind').combobox('select', '');
		$('#lockstate').combobox('select', '');
		var param = {
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : param
		});
	} 
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
     var rows=grid.datagrid('getSelections');
	   sy.setWinRet(rows);
	   parent.$("#"+sy.getDialogId()).dialog("close");
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
								iconCls="icon-search" onclick="queding()"> 确定</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="用户列表">
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>          
	</div> 
</body>
</html>