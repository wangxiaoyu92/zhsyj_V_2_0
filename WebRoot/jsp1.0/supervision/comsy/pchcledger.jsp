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
	// 产品所属公司id
	String procomid = StringHelper.showNull2Empty(request.getParameter("procomid"));
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次id
	String cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
	// 产品批次号
	String cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch"));
%>
<!DOCTYPE html>
<html>
<head>
<title>批次耗材与进货台账信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var cphcgrid; // 产品批次耗材列表
var stockgrid; // 产品进货台账
var scszgrid; // 产品生产生长表
var jcjygrid; // 产品检测检疫表
	$(function() { 
		// 产品耗材表
		cphcgrid = $('#cphcgrid').datagrid({
		    title:'产品批次耗材列表',
		    iconCls:'icon-ok',
		    url:basePath +'/spsy/cphc/queryCphc',			
			queryParams : {
				"procomid" : '<%=procomid%>',
				"proid" : '<%=proid%>',
				"cppcid" : '<%=cppcid%>'
			},
		    striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    columns:[[
                {
                	title : '产品材料使用记录表ID',
                	field : 'qproductclsyjlbid',
                	width : 100,
                	hidden : true
               	},{
               		title:'产品材料id',
               		field:'cpclid',
               		width:100,
               		hidden:true
             	},{
             		title:'产品材料名称',
             		field:'cpclname',
             		width:150
             	},{
             		title:'产品材料进货台账ID',
             		field:'qledgerstockid',
             		width:200
             	},{
             		title:'产品材料消耗数量',
             		field:'cpclsysl',
             		width:150
             	},{
             		title:'产品材料单位',
             		field:'cpcldw',
             		width:150
             	}]],
             	onClickRow : function(rowIndex, rowData){
    				queryProLedgerStock(rowData.qledgerstockid);
    			}
		});
		// 产品生产生长信息表
		scszgrid = $('#scszgrid').datagrid({
			url: basePath + 'spsy/spproduct/queryProductScszxx',  	
			queryParams : {
				'proid': '<%=proid%>',
				'cppcpch': '<%=cppcpch%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'szgcid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '生产生长信息id',
				field : 'szgcid',
				hidden : true
			},{
				width : '100',
				title : '产品id',
				field : 'proid',
				hidden : true
			},{
				width : '80',
				title : '操作人',
				field : 'szgcczr',
				hidden : false
			},{
				width : '150',
				title : '操作内容',
				field : 'szgccznr',
				hidden : false
			},{
				width : '100',
				title : '操作日期',
				field : 'szgcczrq',
				hidden : false
			},{
				width : '120',
				title : '备注',
				field : 'szgcbz',
				hidden : false
			},{
				width : '100',
				title : '批次号',
				field : 'cppcpch',
				hidden : false
			}
			] ]
		});
		// 检测检疫表
		jcjygrid = $('#jcjygrid').datagrid({
			url: basePath + 'spsy/spproduct/queryProductJcjyxx', 	
			queryParams : {
				'proid': '<%=proid%>',
				'jcpc': '<%=cppcpch%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qproductjcid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '检测检验信息id',
				field : 'qproductjcid',
				hidden : true
			},{
				width : '100',
				title : '产品id',
				field : 'proid',
				hidden : true
			},{
				width : '120',
				title : '检测项目',
				field : 'jcitem',
				hidden : false
			},{
				width : '80',
				title : '检验员',
				field : 'jcjcy',
				hidden : false
			},{
				width : '100',
				title : '检测结果',
				field : 'jcjg',
				hidden : false
			},{
				width : '100',
				title : '检测单位',
				field : 'jcdw',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'jcsj',
				hidden : false
			},{
				width : '80',
				title : '批次号',
				field : 'jcpc',
				hidden : false
			}] ]
		});
		// 产品台账表
		stockgrid = $('#stockgrid').datagrid({
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
				title : '进货商名称',
				field : 'mfcommc',
				hidden : false
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
			}] ]
		});
	});
	// 查询材料进货台账信息
	function queryProLedgerStock(v_id){
		var param = {
			'qledgerstockid': v_id
		};
		stockgrid.datagrid({
			url: basePath + 'supervision/comsyxx/queryLedgerstock',		
			queryParams : param
		});
		stockgrid.datagrid('clearSelections');
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
			<div id="tabs" class="easyui-tabs" fit="false">
				<div title="产品耗材"  style="overflow:hidden;">
		        	<sicp3:groupbox title="产品耗材信息">
						<table id="cphcgrid" style="width:900px;height:300px;" ></table>
					</sicp3:groupbox>
				</div>
				<div title="产品生产生长"  style="overflow:hidden;">
					<sicp3:groupbox title="生产生长信息">
						<table id="scszgrid" style="width:900px;height:300px;" ></table>
					</sicp3:groupbox>	
				</div>
				<div title="产品检验检疫"  style="overflow:hidden;">
					<sicp3:groupbox title="检测检疫信息">
						<table id="jcjygrid" style="width:900px;height:300px;" ></table>
					</sicp3:groupbox>	
				</div>
			</div>
			<sicp3:groupbox title="进货台账信息">
				<table id="stockgrid" style="width:900px;height:250px;" ></table>
			</sicp3:groupbox>	
        </div>           
	</div> 
</body>
</html>