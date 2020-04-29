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
	// 公司id
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品销货进货台账信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var salesgrid; // 产品销货台账
var stockgrid; // 产品进货台账
	$(function() { 
		salesgrid = $('#salesgrid').datagrid({
			url:basePath +'spsy/productin/salestzgl',
			queryParams : {
				"lgsfromcomid" : '<%=comid%>', // 卖方工作id
				"lgsproid" : '<%=proid%>' // 交易商品id
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    idField: 'lqledgersalesid', //该列是一个唯一列
		    
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : 'ID',
				field : 'lqledgersalesid',
				hidden : true
			},{
				width : '100',
				title : '商品ID',
				field : 'lgsproid',
				hidden : true
			},{ 
				width : '100',
				title : '买方企业名称',
				field : 'commc',
				hidden : false
			},{ 
				width : '100',
				title : '商品名称',
				field : 'lgsproname',
				hidden : false
			},{
				width : '100',
				title : '商品批次',
				field : 'lgspropc',
				hidden : false
			},{
				width : '150',
				title : '生产日期',
				field : 'lgsproscrq',
				hidden : false
			},{
				width : '150',
				title : '交易日期',
				field : 'lgsprojyrq',
				hidden : false
			},{
				width : '100',
				title : '保质期单位ID',
				field : 'lgsprobzqdwcode',
				hidden : true
			},{
				width : '100',
				title : '保质期单位名称',
				field : 'lgsprobzqdwmc',
				hidden : true 
			},{
				width : '100',
				title : '保质期',
				field : 'lgsprobzq',
				hidden : false ,
			 	formatter:function(value,rec){
			    	if(rec.lgsprobzqdwmc=='月'){
				  		return value+'个'+rec.lgsprobzqdwmc;
				   	} else {
				        return value+rec.lgsprobzqdwmc;
				  	}
				}
			},{
				width : '80',
				title : '交易数量',
				field : 'lgsprojysl',
				hidden : false
			} 
			] ]
		});
		// 进货台账表
		stockgrid = $('#stockgrid').datagrid({
			url: basePath + 'supervision/comsyxx/queryLedgerstock',	
			queryParams : {
				"lgtocomid" : '<%=comid%>', // 买方工作id
				"lgproid" : '<%=proid%>' // 交易商品id
			},
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
				title : '供货商名称',
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
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="销货台账">
				<table id="salesgrid" style="width:900px;height:300px;" ></table>
			</sicp3:groupbox>
			<sicp3:groupbox title="进货台账">
				<table id="stockgrid" style="width:900px;height:300px;" ></table>
			</sicp3:groupbox>	
        </div>           
	</div> 
</body>
</html>