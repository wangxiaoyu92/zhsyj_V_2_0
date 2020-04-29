<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>成绩管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function() {
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'exam/result/queryExamResults',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'resultInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[{
				title: '结果id',
				field: 'resultInfoId',
				width : '100',
				hidden : true
			},{
				title: '考试名称',
				field: 'resultInfoName',
				width : '300',
				hidden : false
			},{
				title: '用户id',
				field: 'userid',
				width: '100',
				hidden : true
			},{
				title: '用户名',
				field: 'description',
				width: '100',
				hidden : false
			},{
				title: '次数',
				field: 'times',
				width: '100',
				hidden : false
			},{
				title: '开始考试时间',
				field: 'startTime',
				width: '100',
				hidden : false
			},{
				title: '答卷时长',
				field: 'costtimes',
				width: '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value > 60) {
						return Math.floor(value / 60) + "分" + (value % 60) + "秒";
					} else{
						
						return value + "秒";
					} 
				}
			},{
				title: '得分',
				field: 'resultInfoScores',
				width: '100',
				hidden : false
			},{
				title: '及格分数',
				field: 'resultInfoPass',
				width: '100',
				hidden : false
			},{
				title: '及格',
				field: 'opt',
				width: '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (row.resultInfoScores >= row.resultInfoPass) {
						return '<span>是</span>';
					} else{
						return '<span>否</span>';
					} 
				}
			}] ]
		});
	});
	// 编辑考试结果
	function editResult() {		
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + "exam/result/resultFormIndex";
		console.log(basePath + "exam/result/resultFormIndex?resultInfoId=" + row.resultInfoId);
		if (row) {
			var dialog = parent.sy.modalDialog({
				title:'编辑考试结果信息',
				param : {
					resultInfoId:row.resultInfoId
				},
				width:1050,
				height:720,
				url:url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(obj != null && obj == "ok"){
				grid.datagrid('reload');
			}
			})
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	// 删除考试结果
	function delResult() {
		var row = grid.datagrid("getSelected");
		var param = { "resultInfoId" : row.resultInfoId };
		if (row) {
			$.post(basePath + 'exam/result/delResult', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg,'error');
               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 
	// 查询考试
	function query() {
		var v_resultInfoName = $('#resultInfoName').val();
		var param = {
			'resultInfoName' : v_resultInfoName
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>考试名称</nobr></td>
						<td><input id="resultInfoName" name="resultInfoName" style="width: 200px" /></td>							
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="成绩列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editResult"
								iconCls="icon-edit" plain="true" onclick="editResult()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td> -->
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delResult"
								iconCls="icon-remove" plain="true" onclick="delResult()">删除</a>
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