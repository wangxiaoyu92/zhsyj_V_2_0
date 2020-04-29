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
<title>课程课件管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var courseWareGrid; // 课件表
	var wareOfCourseGrid; // 课程课件表
	$(function() {
		courseWareGrid = $('#courseWareGrid').datagrid({
			toolbar: '#toolbar1',
			url : basePath + 'train/courseware/queryCoursewareInfos',
			queryParams : {'wareStatus' : '0' },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'wareId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title : '课件ID',
				field : 'wareId',
				width : '100',
				hidden : true
			},{
				title : '课件名称',
				field : 'wareName',
				width : '200',
				hidden : false
			},{
				title : '课件状态',
				field : 'wareStatus',
				width : '100',
				hidden : false
			},{
				title : '所需积分',
				field : 'wareCredit',
				width : '100',
				hidden : false
			},{
				title : '课件学分',
				field : 'warePoint',
				width : '100',
				hidden : false
			},{
				title : '经办人',
				field : 'aae011',
				width : '100',
				hidden : false
			},{
				title : '经办时间',
				field : 'aae036',
				width : '100',
				hidden : false
			} ] ]
		});
		wareOfCourseGrid = $('#wareOfCourseGrid').datagrid({
			toolbar: '#toolbar2',
			url : basePath + 'train/course/queryCourseWareOfCourse',
			queryParams : { courseId : $("#courseId").val() },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
		    idField: 'wareId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title : '课件ID',
				field : 'wareId',
				width : '100',
				hidden : true
			},{
				title : '课件名称',
				field : 'wareName',
				width : '200',
				hidden : false
			},{
				title : '课件状态',
				field : 'wareStatus',
				width : '100',
				hidden : false
			},{
				title : '所需积分',
				field : 'wareCredit',
				width : '100',
				hidden : false
			},{
				title : '课件学分',
				field : 'warePoint',
				width : '100',
				hidden : false
			},{
				title : '经办人',
				field : 'aae011',
				width : '100',
				hidden : false
			},{
				title : '经办时间',
				field : 'aae036',
				width : '100',
				hidden : false
			} ] ]
		});
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	// 添加课件到课程(多选)
	function addWareToCourse() {
		var rows = courseWareGrid.datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
		}
		var courseWares = $.toJSON(rows);
		var param = {
			'courseWares' : courseWares,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/addWareToCourse', param, function(result) {
			if (result.code=='0') {
        		$.messager.alert('提示','操作成功！','info',function(){
        			wareOfCourseGrid.datagrid('reload'); 
        		}); 	                        	                     
           	} else {
           		$.messager.alert('提示','操作失败：' + result.msg,'error');
            }
		}, 'json');
	} 
	
	// 将课件从课程中移除
	function delWareOutOfCourse() {
		var rows = wareOfCourseGrid.datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
		}
		var courseWares = $.toJSON(rows);
		var param = {
			'courseWares' : courseWares,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/delWareOutOfCourse', param, function(result) {
			if (result.code == '0'){
        		$.messager.alert('提示', '操作成功！', 'info', function(){
        			wareOfCourseGrid.datagrid('reload'); 
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
        	<sicp3:groupbox title="课件列表">
	        	<div id="toolbar1">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addWareToCourse"
								iconCls="ext-icon-book_add" plain="true" onclick="addWareToCourse()">加入到课程</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="courseWareGrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="课程课件列表">
	        	<div id="toolbar2">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delWareOutOfCourse"
								iconCls="ext-icon-book_delete" plain="true" onclick="delWareOutOfCourse()">从课程中移除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="wareOfCourseGrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>