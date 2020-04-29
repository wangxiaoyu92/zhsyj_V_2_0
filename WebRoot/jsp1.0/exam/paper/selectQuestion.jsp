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
	// 试题类型
	String v_type = StringHelper.showNull2Empty(request.getParameter("qsnType"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择试题</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArray("QSNLX")%>; // 试题类型
	var v_qsnInfoTrade = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>; // 试题大类（四品一械）
	//下拉框列表
	var grid;
	$(function() {
		// 试题知识点
		$("#qsnInfoTradeSelect").combotree({
			url : basePath + 'exam/question/queryQsnTrade',
			valueField : 'id',
			textField : 'text',
			required : false, // 设置为必选项
			editable : false, // 不可编辑
			multiple : false, // 显示复选框
			cascadeCheck : false // 串联选择
		});
		// 试题类型
		$("#qsnInfoType").combobox({
	    	data : v_qsnInfoType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#qsnInfoType").combobox("select", "<%=v_type%>");
        	}
	    });
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'exam/question/queryQuestionInfos',
			queryParams : {'qsnInfoType' : "<%=v_type%>", 'qsnInfoState' : '1'},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : true,
			autoRowHeight : false, // 定义设置行的高度
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qsnInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [{
				field: "ck",
				checkbox: true
			},{
				title: '试题id',
				field: 'qsnInfoId',
				width : '100',
				hidden : true
			},{
				title: '试题类型',
				field: 'qsnInfoType',
				width: '80',
				hidden: false,
				formatter:function(value,row){
					return sy.formatGridCode(v_qsnInfoType, value);
				}
			},{
				title: '试题状态',
				field: 'qsnInfoState',
				width: '80',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "0") {
						return '<span>禁用</span>';
					} else if ((value == "1")) {
						return '<span>启用</span>';
					}
				}
			},{
				title: '试题描述',
				field: 'qsnInfoDesc',
				width : '200',
				hidden : false,
				formatter: function(value, row, index) {
					var qsnInfoDesc = "";
					var index = value.indexOf("<input");
					while (index >= 0) {
						qsnInfoDesc += value.substring(0, index) + "()";
						value = value.substring(index);
						index = value.indexOf("/>");
						value = value.substring(index + 2);
						index = value.indexOf("<input");
					}
					qsnInfoDesc += value;
					if (qsnInfoDesc.indexOf("<img") >= 0) {
						return qsnInfoDesc;
					}
					if (qsnInfoDesc.length >= 20) {
						return "<a href='javascript:void(0)' onclick='showQuestionPreview(" + "\"" 
							+ row.qsnInfoId + "\"" +")' title='" + qsnInfoDesc + "'>" 
							+ qsnInfoDesc.substr(0, 20) + "...</a>";
					} else {
						return "<a href='javascript:void(0)' onclick='showQuestionPreview(" + "\"" 
							+ row.qsnInfoId + "\"" + ")' title='" + qsnInfoDesc + "'>" 
							+ qsnInfoDesc + "</a>";
					}
				}
			},{
				title: '试题知识点',
				field: 'qsnInfoTrade',
				width: '200',
				hidden : false,
				formatter : function(value, row, index){
					var tradeList = [];
					if (value) {
						var tradeArr = value.split(",");
						for (var i = 0; i < tradeArr.length; i++) {
							var t = $("#qsnInfoTradeSelect").combotree('tree'); // 获取tree对象
							var node = t.tree("find", tradeArr[i]);
							tradeList.push(node.text);
						}
						return tradeList.join(",");
					} else {
						return "";
					}
				}
			},{
				title: '试题大类',
				field: 'qsnInfoTrade',
				width: '80',
				hidden : false,
				formatter:function(value, row){
					return sy.formatGridCode(v_qsnInfoTrade, value);
				}
			},{
				title: '创建人',
				field: 'aae011',
				width: '80',
				hidden : false
			},{
				title: '最后更新时间',
				field: 'aae036',
				width: '80',
				hidden : false
			}] ]
		});
	});
	// 查询试题
	function query() {
		var v_qsnInfoType = $('#qsnInfoType').combobox('getValue'); // 试题类型
		var v_qsnInfoTrade = $("#qsnInfoTradeSelect").combobox('getValue'); // 试题状态
		var param = {
			'qsnInfoType' : v_qsnInfoType,
			'qsnInfoTrade' : v_qsnInfoTrade
		};
		$('#grid').datagrid('reload', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 新增，跳转到新增页面
	function addQuestion() {
		var url=basePath + "exam/question/questionInfoFormIndex";
		var dialog = parent.sy.modalDialog({
			title : '添加试卷',
			width : 970,
			height : 720,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(obj != null){
				if(obj == 'ok'){
					grid.datagrid('reload');
				}
			}
			sy.removeWinRet(dialogID);//不可缺少
		});
	} 		
	// 查看试题预览
	function showQuestionPreview(infoId){
		var row = $('#grid').datagrid('getSelected');
		var url = basePath + "exam/question/showQuestionPreview";
		if (row || infoId) {
			var qsnInfoId = infoId ? infoId : row.qsnInfoId;
			var dialog = parent.sy.modalDialog({
				title : '查看试题预览',
				param  : {
					qsnInfoId:qsnInfoId
				},
				width : 600,
				height : 400,
				url : url
			},function (dialogID){
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的试题！', 'info');
		}
	}
	function queding(){
		var rows = grid.datagrid('getSelections');
	   if (rows != "") {
		   sy.setWinRet(rows);
		   parent.$("#" + sy.getDialogId()).dialog("close");
		} else {
			$.messager.alert('提示', '请先选择试题信息！', 'info');
		} 
   }
   
   	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		parent.$("#" + sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow:auto;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>试题题型</nobr></td>
						<td><input id="qsnInfoType" name="qsnInfoType" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>试题知识点</nobr></td>
						<td><input id="qsnInfoTradeSelect" name="qsnInfoTradeSelect" style="width: 200px" /></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
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
        	<sicp3:groupbox title="试题列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addQuestion"
								iconCls="icon-add" plain="true" onclick="addQuestion()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>