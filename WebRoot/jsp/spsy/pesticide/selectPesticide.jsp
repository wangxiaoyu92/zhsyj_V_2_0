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
			url:'<%=basePath%>spsy/pesticide/selectComPesticides?pesticidecomid=<%=v_comid%>',
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
				{title:'id',field:'pesticideid',width:100,hidden:'true'},
				{title:'物品名称',field:'pesticidename',width:200},
				{title:'物品条码',field:'pesticidesptm',width:80},
				{title:'保质期',field:'pesticidebzq',width:50},
				{title:'保质期单位id',field:'pesticidebzqdwcode',hidden:'true'},
				{title:'保质期单位',field:'pesticidebzqdwmc',width:50},
				{title:'规格',field:'pesticidegg',width:80},
				{title:'包装规格',field:'pesticidebzgg',width:80},
				{title:'生产厂家',field:'pesticidesccj',width:100},
				{title:'厂家地址',field:'pesticidecjdz',width:150},
				{title:'对应本公司药品id',field:'cphyclid',hidden:'true'}
			]]
	   	});
	}); 
	
	function query() {
		var param = {
			'pesticidename': $('#pesticidename').val(),
			'pesticidesptm': $('#pesticidesptm').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/pesticide/selectComPesticides?pesticidecomid=<%=v_comid%>',
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
	        $pjq.messager.alert('提示','请选择物品数据!','info');
	    }
	}; 
	
	function queding(){
		var rows = mygrid.datagrid('getSelections'); 
		if (rows != "") {
			sy.setWinRet(rows);
	 		parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择物品信息！', 'info');
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
						<td style="text-align:right;"><nobr>名称</nobr></td>
						<td><input id="pesticidename" name="pesticidename" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>条码</nobr></td>
						<td><input id="pesticidesptm" name="pesticidesptm" style="width: 200px" /></td>
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
        	<sicp3:groupbox title="农药或化肥列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>
</body>
</html>