<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 供货商关系类型
	String comgxlx = StringHelper.showNull2Empty(request.getParameter("comgxlx"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择供货商</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {					
	mygrid = $('#mygrid').datagrid({
		url: basePath + '/spsy/spproduct/querySelectcom',
		queryParams : {
			'comfwnfww': '1', // 默认查询范围外企业
			"comgxlx" : '<%=comgxlx%>' // 供货商关系类型
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
		idField: 'csid', //该列是一个唯一列
		sortOrder: 'asc',
		columns : [ [ {
			width : '100',
			title : '企业ID',
			field : 'csid',
			hidden : true
		},{
			width : '100',
			title : '企业名称',
			field : 'commc',
			hidden : false
		},{
			width : '100',
			title : '资质证明编号编号',
			field : 'comzzzmbh',
			hidden : false
		},{
			width : '80',
			title : '企业法人/业主',
			field : 'comfrhyz',
			hidden : false
		},{
			width : '120',
			title : '移动电话',
			field : 'comyddh',
			hidden : false
		},{
			width : '120',
			title : '企业地址',
			field : 'comdz',
			hidden : false
		},{
			width : '120',
			title : '企业范围内外类型',
			field : 'comfwnfww',
			hidden : true
		}
		] ]
	});
	$('input:radio[name="comfwnfww"]').click(function(){
		query();
	});
});
	
function query() {
	var v_jgztfwnfww = $('input:radio[name="comfwnfww"]:checked').val();
	var param = {
		'comfwnfww': v_jgztfwnfww,
		"comgxlx" : '<%=comgxlx%>', // 供货商关系类型
		'commc': $('#commc').val()
	};
	mygrid.datagrid({
		url : basePath + '/spsy/spproduct/querySelectcom',			
		queryParams : param
	});
	mygrid.datagrid('clearSelections'); 
}
function queding(){
	var rows = mygrid.datagrid('getSelections'); 
  	if (rows != "") {
  		sy.setWinRet(rows);
	 	parent.$("#"+sy.getDialogId()).dialog("close");
	}else{
		$.messager.alert('提示', '请先选择企业信息！', 'info');
	} 
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: auto;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" /></td>
						<td>
							<input type="radio" value="0" name="comfwnfww"/>范围内
							<input type="radio" value="1" name="comfwnfww" checked/>范围外
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
						</td>											
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="供货商查询">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>