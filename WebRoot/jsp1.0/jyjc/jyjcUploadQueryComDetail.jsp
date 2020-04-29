<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_impbatchno = StringHelper.showNull2Empty(request.getParameter("impbatchno"));
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	var v_gridmain;
	$(function() {
		grid = $('#grid').datagrid({
			url : basePath + '/jyjc/queryJyjcUploadData',
			queryParams:{impbatchno:'<%=v_impbatchno%>'},
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			nowrap : true,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,		
			pagination : true,// 底部显示分页栏
			pageSize : 100,
			pageList : [ 100, 200, 300 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'impbh', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '100',
				title : '仪器类别',
				field : 'impyqlb',
				hidden : false
			},{
				width : '60',
				title : '编号',
				field : 'impbh',
				hidden : false
			},{
				width : '100',
				title : '样品种类',
				field : 'impypzl',
				hidden : false
			},{
				width : '100',
				title : '样品名称',
				field : 'impypmc',
				hidden : false
			},{
				width : '100',
				title : '检测项目',
				field : 'impjcxm',
				hidden : false
			},{
				width : '80',
				title : '含量',
				field : 'imphl',
				hidden : false
			},{
				width : '70',
				title : '检测结果',
				field : 'impjcjg',
				hidden : false
			},{
				width : '70',
				title : '所属区域',
				field : 'impssqy',
				hidden : false
			},{
				width : '100',
				title : '用户名称',
				field : 'impyhmc',
				hidden : false
			},{
				width : '120',
				title : '被检企业',
				field : 'impbjqy',
				hidden : false
			},{
				width : '80',
				title : '产品商标',
				field : 'impcpsb',
				hidden : false
			},{
				width : '100',
				title : '产品批次',
				field : 'impcppc',
				hidden : false
			},{
				width : '80',
				title : '产品规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '100',
				title : '生产厂家',
				field : 'impsccj',
				hidden : false
			},{
				width : '100',
				title : '抽样时间',
				field : 'impcysj',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'impjcsj',
				hidden : false
			},{
				width : '100',
				title : '检测人员',
				field : 'impjcry',
				hidden : false
			},{
				width : '100',
				title : '备注',
				field : 'impbz',
				hidden : false
			},{
				width : '70',
				title : '补充1',
				field : 'impbc1',
				hidden : false
			},{
				width : '70',
				title : '补充2',
				field : 'impbc2',
				hidden : false
			},{
				width : '130',
				title : '入库日期',
				field : 'imprkrq',
				hidden : false
			}] ]
		});		
	});////////////////////////////////////////////
</script>
</head>
<body >
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">       
        	<sicp3:groupbox title="上传明细">
				<div id="grid" style="height:560px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>