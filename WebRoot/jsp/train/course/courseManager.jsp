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
<title>课程管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	// 课程状态
	var v_courseStatus = [{"id":"","text":"===请选择==="},{"id":"1","text":"启用"},{"id":"2","text":"禁用"}]; 
	$(function() {
		// 课程状态
		$("#courseStatus").combobox({
	    	data : v_courseStatus,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'train/course/queryCourseInfos',
			striped : true, // 奇偶行使用不同背景色
			singleSelect : true, // True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true, // 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true, // 是否显示行号
			fitColumns : false, // 列自适应宽度			
		    idField: 'courseId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[{
				title: '课程id',
				field: 'courseId',
				width : '100',
				hidden : true
			},{
				title: '课程状态',
				field: 'courseStatus',
				width: '100',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_courseStatus, value); 
				}
			},{
				title: '课程名称',
				field: 'courseName',
				width : '300',
				hidden : false
			},{
				title: '课件数',
				field: 'warecount',
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
			}] ]
		});
	});
	// 查询课程
	function query() {
		var v_courseStatus = $('#courseStatus').combobox('getValue');
		var v_courseName = $('#courseName').val();
		var param = {
			'courseName' : v_courseName,
			'courseStatus' : v_courseStatus
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 新增，跳转到新增页面
	function addCourse() {
		var url = basePath + 'train/course/courseFormIndex';
		var dialog = parent.sy.modalDialog({
				title : '添加课程',
				width : 750,
				height : 500,
				url : url
		}, closeModalDialogCallback);
	} 		
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(obj == 'ok'){
			grid.datagrid("reload"); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	// 编辑课程
	function editCourse() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/courseFormIndex';
			var dialog = parent.sy.modalDialog({
					title : '编辑课程',
					param : {
						courseId : row.courseId
					},
					width : 750,
					height : 500,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	// 删除课程
	function delCourse() {
		var row = grid.datagrid("getSelected");
		if (row) {
			var param = {
				'courseId' : row.courseId
			};  
			$.post(basePath + 'train/course/delCourse', param, function(result) {
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
	// 课程人员管理
	function userManager() {
		var row = $('#grid').datagrid('getSelected');
		if(row){
			if(row.courseStatus == "0"){
				$.messager.alert('提示', '该课程还未启用！', 'info');
				return;
			}
			var v_courseId = "'" + row.courseId + "'";	// 小组id	
			var url = basePath + 'train/course/courseUsersIndex';
			var dialog = parent.sy.modalDialog({
					title : '课程人员管理',
					param : {
						courseId : v_courseId,
						time : new Date().getMilliseconds()
					},
					width : 800,
					height : 500,
					url : url
			}, closeModalDialogCallback);
		}
		else{
		  $.messager.alert('提示', '请先选择相应的课程！', 'info');
		}
	}
	 
	// 课件管理
	function wareManager() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/wareOfCourseIndex';
			var dialog = parent.sy.modalDialog({
					title : '课件管理',
					param : {
						courseId : row.courseId
					},
					width : 750,
					height : 560,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择相应的课程！', 'info');
		}
	}
	// 跳转评价统计
	function statistics(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/courseStatistics';
			var dialog = parent.sy.modalDialog({
					title : '评价统计',
					param : {
						courseId : row.courseId
					},
					width : 750,
					height : 400,
					url : url
			}, closeModalDialogCallback);
		} else {
			$.messager.alert('提示', '请先选择相应的课程！', 'info');
		}
	}
	// 讲师管理
	function teacherManager() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/teacherOfCourseIndex';
			var dialog = parent.sy.modalDialog({
					title : '教师管理',
					param : {
						courseId : row.courseId
					},
					width : 750,
					height : 560,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择相应的课程！', 'info');
		}
	}
	// 作业管理
	function homeworkManager() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/course/homeworkOfCourseIndex';
			var dialog = parent.sy.modalDialog({
					title : '作业管理',
					param : {
						courseId : row.courseId
					},
					width : 750,
					height : 560,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择相应的课程！', 'info');
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
						<td style="text-align:right;"><nobr>课程状态</nobr></td>
						<td><input id="courseStatus" name="courseStatus" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>课程名称</nobr></td>
						<td><input id="courseName" name="courseName" style="width: 200px" /></td>							
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
        	<sicp3:groupbox title="课程列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addCourse"
								iconCls="icon-add" plain="true" onclick="addCourse()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editCourse"
								iconCls="icon-edit" plain="true" onclick="editCourse()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delCourse"
								iconCls="icon-remove" plain="true" onclick="delCourse()">删除</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_wareManager"
								iconCls="icon-excel" plain="true" onclick="wareManager()">课件管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_teacherManager"
								iconCls="ext-icon-group" plain="true" onclick="teacherManager()">讲师管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_homeworkManager"
								iconCls="ext-icon-book_open" plain="true" onclick="homeworkManager()">作业管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_userManagers"
								iconCls="ext-icon-group_gear" plain="true" onclick="userManager()">课程人员管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_statistics"
								iconCls="ext-icon-group_gear" plain="true" onclick="statistics()">评价统计</a>
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