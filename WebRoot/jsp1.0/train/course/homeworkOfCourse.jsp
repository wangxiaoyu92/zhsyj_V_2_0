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
	// 课程id
	String v_courseId = StringHelper.showNull2Empty(request.getParameter("courseId"));
%>
<!DOCTYPE html>
<html>
<head>
<title>课程作业管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid; // 作业表
	var mygrid; // 课程作业表
	var v_type = [{"id":"1","text":"附件"},{"id":"2","text":"问答"}]; // 作业类型
	$(function() {
		// 作业表
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'train/course/queryHomeworks',
			striped : true, // 奇偶行使用不同背景色
			singleSelect : false, // True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true, // 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false, // 是否显示行号
			fitColumns : false, // 列自适应宽度
		    idField: 'homeworkId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title : '作业ID',
				field : 'homeworkId',
				width : '100',
				hidden : true
			},{
				title : '作业名称',
				field : 'title',
				width : '200',
				hidden : false
			},{
		        title: '类型',
				field: 'type',
				width: '150',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_type, value);
				}
		 	},{
				title : '总分',
				field : 'score',
				width : '100',
				hidden : false
			},{
				title: '及格',
				field: 'pass',
				width: '60',
				hidden : false
			},{
				title : '经办人',
				field : 'aae011',
				width : '100',
				hidden : false
			},{
				title : '经办时间',
				field : 'aae036',
				width : '200',
				hidden : false
			} ] ]
		});
		// 课程作业表
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar2',
			url : basePath + 'train/course/queryHomeOfCourse',
			queryParams : { courseId : $("#courseId").val() },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    idField: 'homeworkId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title : '作业ID',
				field : 'homeworkId',
				width : '100',
				hidden : true
			},{
				title : '作业名称',
				field : 'title',
				width : '200',
				hidden : false
			},{
		        title: '类型',
				field: 'type',
				width: '150',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_type, value);
				}
		 	},{
				title : '总分',
				field : 'score',
				width : '100',
				hidden : false
			},{
				title: '及格',
				field: 'pass',
				width: '60',
				hidden : false
			},{
				title : '经办人',
				field : 'aae011',
				width : '100',
				hidden : false
			},{
				title : '经办时间',
				field : 'aae036',
				width : '200',
				hidden : false
			} ] ]
		});
	});
	
	// 添加作业，跳转到新增页面
	function addHomework() {
		var url = basePath + 'train/course/homeworkFormIndex';
		var dialog = parent.sy.modalDialog({
				title : '添加作业',
				width : 750,
				height : 500,
				url : url
		}, closeModalDialogCallback);
	}
	
	// 编辑作业
	function editHomework() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/homeworkFormIndex';
			var dialog = parent.sy.modalDialog({
					title : '编辑作业',
					param : {
						homeworkId : row.homeworkId
					},
					width : 750,
					height : 500,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(obj == 'ok'){
			grid.datagrid("reload"); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 删除作业
	function delHomework() {
		var row = grid.datagrid("getSelected");
		if (row) {
			var param = {
				'homeworkId' : row.homeworkId
			};  
			$.post(basePath + 'train/course/delHomework', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg, 'error');
               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 	
	// 添加作业到课程(多选)
	function addHomeworkToCourse() {
		var rows = grid.datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
		}
		var homeworks = $.toJSON(rows);
		var param = {
			'homeworks' : homeworks,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/addHomeworkToCourse', param, function(result) {
			if (result.code=='0') {
        		$.messager.alert('提示','操作成功！','info',function(){
        			mygrid.datagrid('reload'); 
        		}); 	                        	                     
           	} else {
           		$.messager.alert('提示','操作失败：' + result.msg,'error');
            }
		}, 'json');
	} 
	// 将作业从课程中移除
	function delHomeworkOutOfCourse() {
		var rows = mygrid.datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
		}
		var homeworks = $.toJSON(rows);
		var param = {
			'homeworks' : homeworks,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/delHomeworkOutOfCourse', param, function(result) {
			if (result.code == '0'){
        		$.messager.alert('提示', '操作成功！', 'info', function(){
        			mygrid.datagrid('reload'); 
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示', '操作失败：' + result.msg, 'error');
               }
		}, 'json');
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<input id="courseId" name="courseId" type="hidden" value="<%=v_courseId%>"/>
        <div region="center" style="overflow: true;" border="false">
	        <sicp3:groupbox title="作业列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showHomework"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showHomework()">查看</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addHomework"
								iconCls="icon-add" plain="true" onclick="addHomework()">添加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editHomework"
								iconCls="icon-edit" plain="true" onclick="editHomework()">编辑</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delHomework"
								iconCls="icon-remove" plain="true" onclick="delHomework()">删除</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addHomeworkToCourse"
								iconCls="ext-icon-book_add" plain="true" onclick="addHomeworkToCourse()">加入到课程</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <br><br>
	        <sicp3:groupbox title="课程作业列表">
	        	<div id="toolbar2">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delHomeworkOutOfCourse"
								iconCls="ext-icon-book_delete" plain="true" onclick="delHomeworkOutOfCourse()">从课程中移除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>