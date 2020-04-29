<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	} 
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择商品</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
	 
	$(function() {  	
		mygrid = $('#mygrid').datagrid({
			url:'<%=basePath%>spsy/spproduct/selectComProducts?procomid=<%=v_comid%>',
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'proid', //该列是一个唯一列
		    sortOrder: 'asc',
		    loadMsg:'数据加载中,请稍后...',   
		    columns:[[
				{title:'商品id',field:'proid',width:100,hidden:'true'},	
				{title:'商品名称',field:'proname',width:200},
				{title:'商品条码',field:'prosptm',width:80},
				{title:'商品批次批号',field:'cppcpch',width:80,hidden:'true'},
				{title:'生产数量',field:'cppcscsl',width:80,hidden:'true'},
				{title:'生产单位',field:'cppcscdwdmstr',width:80},
				{title:'生产单位',field:'cppcscdwdm',hidden:'true'},
				{title:'生产日期',field:'cppcscrq',width:100},
				{title:'保质期',field:'probzq',width:50},
				{title:'保质期单位id',field:'probzqdwcode',hidden:'true'},
				{title:'保质期单位',field:'probzqdwmc',width:50},
				{title:'规格',field:'progg',width:80},
				{title:'包装规格',field:'probzgg',width:80},
				{title:'生产厂家',field:'prosccj',width:100},
				{title:'厂家地址',field:'procjdz',width:150},
				{title:'产品或原材料id',field:'cphyclid',hidden:'true'}
			]]
	   	});
	}); 
	
	function query() {
		var param = {
			'proname': $('#proname').val(),
			'prosptm': $('#prosptm').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/spproduct/selectComProducts?procomid=<%=v_comid%>',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');  
	}

	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = mygrid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择产品数据!','info');
	    }
	}; 
	
	function queding(){
		var rows = mygrid.datagrid('getSelections'); 
		if (rows != "") {
			sy.setWinRet(rows);
	 		parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择商品信息！', 'info');
		} 
   }
	
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: scroll;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>商品名称</nobr></td>
						<td><input id="proname" name="proname" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>商品条码</nobr></td>
						<td><input id="prosptm" name="prosptm" style="width: 200px" /></td>												
					</tr>
					<tr>
					  	<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="产品列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>
</body>
</html>