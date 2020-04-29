<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE HTML>
<html>
<head>
<title>考试监控</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	var v_examsType = [{"id":"","text":"===请选择==="},{"id":"0","text":"练习"},{"id":"1","text":"考试"}]; // 考试类型
	$(function() {
		$("#examsType").combobox({
	    	data : v_examsType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight :'auto'
	    });
		grid = $('#grid').datagrid({
	    	toolbar: '#toolbar',
	     	url : basePath + 'exam/exam/queryExamMonInfos',
	     	striped : true, // 奇偶行使用不同背景色
		 	singleSelect : true,// True只允许选中一行
		 	checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
		 	selectOnCheck : false,			
		 	pagination : true,// 底部显示分页栏
		 	pageSize : 10,
	     	pageList : [ 10, 20, 30 ],
		 	rownumbers : true,// 是否显示行号
		 	fitColumns : false,// 列自适应宽度			
		 	idField: 'examsInfoId', //该列是一个唯一列
		 	sortOrder: 'desc',	
			columns : [ [{
				title: '考试id',
				field: 'examsInfoId',
				width : '100',
				hidden : true
		 	},{
		        title: '考试名称',
				field: 'examsName',
				width : '150',
				hidden : false,
				formatter: function(value, row, index) {
				return "<a href='javascript:void(0)' onclick='showExamDetails(" + "\"" 
						+ row.examsInfoId + "\"" + ")' title='" + value + "'>" 
						+ value + "</a>";
				}
		    
		    },{
		   	    title: '考试类型',
				field: 'examsType',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_examsType, value);
				}
		    },{
		        title: '开始考试时间',
				field: 'startTime',
				width : '100',
				hidden : false
		    },{
		        title: '结束考试时间',
				field: 'endTime',
				width : '100',
				hidden : false
		    },{
				title: '考试限时',
				field: 'duration',
				width : '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "0") {
						return '<span>不限时</span>';
					} else if ((value == "1")) {
						return value + '<span>分钟</span>';
					} 
				}
			},{
		        title: '应考人数',
				field: 'numExamUsers',
				width: '100',
				hidden: false,
				formatter: function(value, row, index) {
					return "<a href='javascript:void(0)' onclick='showExamMon(" + "\"" 
						+ row.examsInfoId + "\"" + ")' title='" + value + "'>" 
						+ value + "</a>";
				}
		    } ]]
		});
	});
	
	//跳转人员考试页面
	function showExamMon(infoId){
		var url=basePath + "exam/exam/examsMonUsers";
		var row = $('#grid').datagrid('getSelected');
		if (row || infoId) {
			var examsInfoId = infoId ? infoId :  row.examsInfoId;
			var dialog = parent.sy.modalDialog({
					title : '人员考试页面',
					param : {
					examsInfoId : examsInfoId
				},
			width : 650,
			height : 450,
			url : url
			})
			grid.datagrid('reload');
		} else {
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	}
	
	//跳转详细考试人员信息
	function showExamDetails(infoId){
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/exam/queryExamMonDIndex";
		if (row || infoId) {
			var examsInfoId = infoId ? infoId :  row.examsInfoId;
			var dialog = parent.sy.modalDialog({
				title : '详细考试人员信息',
				param : {
				examsInfoId : examsInfoId,
				examsName:row.examsName,
				startTime : row.startTime,
				endTime:row.endTime
				},
				width : 800,
				height : 550,
				url : url
		})
			grid.datagrid('reload');
		} else {
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	}
	
	// 重置
	function refresh(){
		// parent.window.refresh();	
		var v_examsType = $('#examsType').combobox('select', '');
		$("#examsName").val('');
		$("#startTime").val('');
		$("#endTime").val('');
		$('#grid').datagrid('load', {});
	}
	
	
	// 查询试题
	function query() {
		var v_examsType = $('#examsType').combobox('getValue');
		var examsName = $("#examsName").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var param = {
			//考试类型	
			'examsType' : v_examsType,
			//考试名称 
			'examsName' : examsName,
			//开始时间 
			'startTime' : startTime,
			//结束时间  
			'endTime' : endTime
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: hidden;" border="false">
			<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>考试分类</nobr></td>
						<td><input id="examsType" name="examsType"  style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>考试名称</nobr></td>
						<td><input id="examsName" name="examsName" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>检查开始时间</nobr></td>
						<td colspan="2"><input type="text" id="startTime"
							name="startTime"
							onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
							class="Wdate" readonly="readonly" /> &nbsp;-&nbsp; <input
							type="text" id="endTime" name="endTime"
							onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',readOnly:true})"
							class="Wdate" readonly="readonly" />
						</td>
						<td colspan="2" style="text-align:center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="考试列表">
			<div id="grid"></div>
			</div>
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>
