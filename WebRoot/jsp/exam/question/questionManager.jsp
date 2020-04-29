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
<!DOCTYPE html>
<html>
<head>
<title>试题管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArray("QSNLX")%>; // 试题类型
	var v_qsnInfoState = [{"id":"","text":"==请选择=="},{"id":"0","text":"禁用"},{"id":"1","text":"启用"}]; // 试题状态
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
		$("#qsnInfoTypeSelect").combobox({
	    	data : v_qsnInfoType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 试题状态
		$("#qsnInfoStateSelect").combobox({
	    	data : v_qsnInfoState,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 试题列表
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'exam/question/queryQuestionInfos',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			autoRowHeight : false, // 定义设置行的高度
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qsnInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [ 
			{
				title: '试题id',
				field: 'qsnInfoId',
				width : '100',
				hidden : true
			},{
				title: '试题类型',
				field: 'qsnInfoType',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_qsnInfoType, value);
				}
			},{
				title: '试题状态',
				field: 'qsnInfoState',
				width: '100',
				hidden : false,
				formatter: function(value, row, index) {
					return sy.formatGridCode(v_qsnInfoState, value);
				}
			},{
				title: '试题描述',
				field: 'qsnInfoDesc',
				width : '300',
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
						return "<a href='javascript:void(0)' onclick='showQuestionPreview(" + "\"" 
							+ row.qsnInfoId + "\"" + ")'>" + qsnInfoDesc + "</a>";
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
				title: '创建人',
				field: 'aae011',
				width: '100',
				hidden : false
			},{
				title: '最后更新时间',
				field: 'aae036',
				width: '150',
				hidden : false
			}] ]
		});
	});
	// 查询试题
	function query() {
		var v_qsnInfoType = $("#qsnInfoTypeSelect").combobox('getValue'); // 试题类型
		var v_qsnInfoTrade = $("#qsnInfoTradeSelect").combotree('getValue'); // 试题大类
		var v_qsnInfoState = $("#qsnInfoStateSelect").combobox('getValue'); // 试题状态
		var param = {
			'qsnInfoType' : v_qsnInfoType,
			'qsnInfoTrade' : v_qsnInfoTrade,
			'qsnInfoState' : v_qsnInfoState
		};
		$('#grid').datagrid('load', param);
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
				title : '跳转到新增页面',
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
		})
	} 		
	// 编辑试题
	function editQusetionInfo() {		
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/question/questionInfoFormIndex";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑试题',
				param  : {
				qsnInfoId:row.qsnInfoId
				},
				width : 970,
				height : 720,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(obj != null && obj == "ok"){
				grid.datagrid('reload');
			}
			sy.removeWinRet(dialogID);//不可缺少
			})
		}else{
			$.messager.alert('提示', '请先选择要修改的试题！', 'info');
		}
	} 
	// 删除试题
	function delQusetionInfos() {
		var rows = grid.datagrid("getSelections");
		if (rows) {
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr
			};  
			$.post(basePath + 'exam/question/delQusetionInfos', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg,'error');
               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的试题！', 'info');
		}
	} 
	// 查看试题预览
	function showQuestionPreview(infoId){
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/question/showQuestionPreview";
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
			})
		}else{
			$.messager.alert('提示', '请先选择要查看的试题！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>试题题型</nobr></td>
						<td><input id="qsnInfoTypeSelect" name="qsnInfoTypeSelect" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>试题知识点</nobr></td>
						<td><input id="qsnInfoTradeSelect" name="qsnInfoTradeSelect" style="width: 200px" /></td>							
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>试题状态</nobr></td>
						<td><input id="qsnInfoStateSelect" name="qsnInfoStateSelect" style="width: 200px" /></td>							
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
        	<sicp3:groupbox title="试题列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showQuestionPreview"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showQuestionPreview()">预览</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addQuestion"
								iconCls="icon-add" plain="true" onclick="addQuestion()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editQusetionInfo"
								iconCls="icon-edit" plain="true" onclick="editQusetionInfo()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delQusetionInfos"
								iconCls="icon-remove" plain="true" onclick="delQusetionInfos()">删除</a>
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