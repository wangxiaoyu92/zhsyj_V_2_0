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
%>
<!DOCTYPE html>
<html>
<head>
<title>选择试卷</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_paperInfoState = [{"id":"","text":"===请选择==="},{"id":"0","text":"禁用"},{"id":"1","text":"启用"}];
	//下拉框列表
	var grid;
	$(function() {
		// 试卷状态
		$("#paperInfoState").combobox({
	    	data : v_paperInfoState,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
		grid = $('#grid').datagrid({
			url : basePath + 'exam/paper/queryPapers',
			queryParams : {'paperInfoState' : '1'},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'paperInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [{
				field: "ck",
				checkbox: true
			},{
				title: '试卷id',
				field: 'paperInfoId',
				width : '100',
				hidden : true
			},{
				title: '试卷状态',
				field: 'paperInfoState',
				width: '100',
				hidden: false,
				formatter:function(value,row){
					return sy.formatGridCode(v_paperInfoState, value);
				}
			},{
				title: '试卷名称',
				field: 'paperInfoName',
				width : '300',
				hidden : false
			},{
				title: '试卷总分',
				field: 'points',
				width: '100',
				hidden : false
			},{
				title: '试题总数',
				field: 'total',
				width: '100',
				hidden : false
			},{
				title: '及格分数',
				field: 'paperInfoPass',
				width: '100',
				hidden : false
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
			},{
				title: '备注',
				field: 'aae013',
				width: '100',
				hidden : false
			}] ]
		});
	});
	// 查询试题
	function query() {
		var v_paperInfoState = $('#paperInfoState').combobox('getValue');
		var v_paperInfoName = $('#paperInfoName').val();
		var param = {
			'paperInfoState' : v_paperInfoState,
			'paperInfoName' : v_paperInfoName
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 查看试题预览
	var showQuestionPreview = function(infoId){
		var dialog = parent.sy.modalDialog({
			title : '试题预览',
			width : 600,
			height : 400,
			url : basePath + 'exam/question/showQuestionPreview?qsnInfoId=' + infoId,
			buttons : [{
				text : '关闭',
				handler:function(){
					dialog.dialog('close');
				}
			}]
		}, function (dialogID) {
			sy.getWinRet(dialogID);//不可缺少
		});
	};
	function queding(){
    	var rows = grid.datagrid('getSelections');
	   if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择信息！', 'info');
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
						<td><input id="qsnInfoType" name="qsnInfoType" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>试题大类</nobr></td>
						<td><input id="qsnInfoTrade" name="qsnInfoTrade" style="width: 200px" /></td>							
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
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>