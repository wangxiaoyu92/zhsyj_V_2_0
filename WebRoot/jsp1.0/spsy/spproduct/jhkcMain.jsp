<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	String v_procomid = sysuser.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>进货库存管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var grid1; // 进货库存汇总表
var grid2; // 进货库存明细表

	$(function() { 
		grid1 = $('#grid1').datagrid({
		    title:'库存汇总表',
		    iconCls:'icon-ok',
		    width:900,
		    height:260,
		    url: basePath + '/spsy/spproduct/queryJhhz',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qjhkchzb', //该列是一个唯一列 
		    sortOrder: 'asc',
		    onClickRow:function(rowIndex,rowData){
		    	queryMx(rowData);
		    },
		    columns:[[
                {title:'汇总表id',field:'qjhkchzb',width:100,hidden:'true'},
				{title:'产品id',field:'proid',width:100,hidden:'true'},
				{title:'类型',field:'cphyclbz',width:100,
						formatter: function(value,row,index){
			  				if (value=="1"){
			  					return "产品"; 
			  				} else if(value=="2"){
			  					return "材料";
			  				}
			  			}
	  			},	
				{title:'产品名称',field:'proname',width:100},	
				{title:'进货数量',field:'jhkcjhsl',width:100},
				{title:'出库数量',field:'jhkcchsl',width:100},
				{title:'结余数量',field:'jhkcjysl',width:100},
				{title:'单位',field:'projldw',width:100}
			]]
		   }); 
		
		grid2 = $('#grid2').datagrid({
			title:'库存详情表',
		    iconCls:'icon-ok',
			width:900,
		    height:300,
			//url: basePath + '/spsy/spproduct/queryLedgerstock',
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
				width : '100',
				title : '商品批次',
				field : 'lgpropc',
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
				width : '80',
				title : '剩余数量',
				field : 'lgprosysl',
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
	
	function queryMx(data) {
		var param = {
			'sphyclid': data.proid,
			'lgprojydwmc' : data.projldw
		};
		$('#grid2').datagrid({
			url: basePath + '/spsy/spproduct/queryLedgerstock',		
			queryParams : param
		});
		$('#grid2').datagrid('clearSelections');   			
	}
	
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
           <table id="grid1" style="height:100%;" ></table>
           <table id="grid2" style="height:100%;" ></table>
        </div>           
	</div> 
</body>
</html>