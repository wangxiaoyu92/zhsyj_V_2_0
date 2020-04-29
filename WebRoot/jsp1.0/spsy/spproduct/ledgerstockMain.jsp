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
<title>进货台账管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/spsy/spproduct/queryLedgerstock',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qledgerstockid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '进货台账ID',
				field : 'qledgerstockid',
				hidden : true
			},{
				width : '200',
				title : '批发商名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '卖方公司id',
				field : 'lgfromcomid',
				hidden : true
			},{
				width : '150',
				title : '资质证明编号',
				field : 'comzzzmbh',
				hidden : false
			},{
				width : '100',
				title : '商品名称',
				field : 'lgproname',
				hidden : false
			},{
				width : '100',
				title : '商品条码',
				field : 'lgprosptm',
				hidden : false
			},{
				width : '100',
				title : '进货日期',
				field : 'lgprojyrq',
				hidden : false
			},{
				width : '80',
				title : '进货数量',
				field : 'lgprojysl',
				hidden : false
			},{
				width : '80',
				title : '单位',
				field : 'lgprojydwmc',
				hidden : false
			},{
				width : '100',
				title : '生产日期',
				field : 'lgproscrq',
				hidden : false
			},{
				width : '100',
				title : '保质期',
				field : 'lgprobzq',
				hidden : false
			},{
				width : '100',
				title : '保质期单位',
				field : 'lgprobzqdwmc',
				hidden : false
			}
			] ]
		});
});

	// 新增台账录入
	function addStock() {		
		var url = basePath + 'spsy/spproduct/showStockIndex';
		var dialog = parent.sy.modalDialog({
				title : '台账录入',
				width : 650,
				height : 700,
				url : url
		},closeModalDialogCallback); 
	};
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#mygrid').datagrid('reload');
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 查看台账信息
	function showStock() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'spsy/spproduct/showStockIndex';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						qledgerstockid : row.qledgerstockid,
						op : "view"
					},
					width : 950,
					height : 700,
					url : url
			},closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要查看的台账信息！', 'info');
		}
	};
	
	// 删除台账信息
	function delStock() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该台账信息吗?',function(r) {
				if (r) {
					$.post(basePath + '/spsy/spproduct/delStock', {
						qledgerstockid: row.qledgerstockid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的台账信息记录！', 'info');
		}
	} 
	// 查询台账信息
	function query() {
		var param = {
			'commc': $('#commc').val(),
			'comzzzmbh':$('#comzzzmbh').val(),
			'proname':$('#proname').val(),
			'prosptm':$('#prosptm').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/spproduct/queryLedgerstock',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections');
	}
	
	function refresh(){
		parent.window.refresh();	
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>批发商名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>批发商资质证明编号</nobr></td>
						<td><input id="comzzzmbh" name="comzzzmbh" style="width:200px" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>商品名称</nobr></td>
						<td><input id="proname" name="proname" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>商品条码</nobr></td>
						<td><input id="prosptm" name="prosptm" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:center;" colspan="4">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="进货台账列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addStock"
								iconCls="icon-add" plain="true" onclick="addStock()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showStock"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showStock()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delStock"
								iconCls="icon-remove" plain="true" onclick="delStock()">删除</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 																																													
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>