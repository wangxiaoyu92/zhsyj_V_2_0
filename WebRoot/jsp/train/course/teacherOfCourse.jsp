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
<title>课程讲师管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var teacherGrid; // 讲师
	var teacherOfCourseGrid; // 课程讲师表
	var v_sex = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>; // 人员性别
	var v_eType = [{"id":"","text":"===请选择==="},{"id":"0","text":"外部讲师"},{"id":"1","text":"内部讲师"}]; // 讲师类型
	$(function() {
		teacherGrid = $('#teacherGrid').datagrid({
			toolbar: '#toolbar1',
			url : basePath + 'train/teacher/queryTeachers',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'teacherId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title: '讲师id',
				field: 'teacherId',
				width : '100',
				hidden : true
			},{
				title: '姓名',
				field: 'teacherName',
				width : '100',
				hidden : false
			},{
				title: '类别',
				field: 'teacherType',
				width: '80',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_eType, value); 
				}
			},{
				title: '性别',
				field: 'teacherSex',
				width: '60',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_sex, value); 
				}
			},{
				title: '年龄',
				field: 'teacherAge',
				width : '60',
				hidden : false
			},{
				title: '联系方式',
				field: 'teacherTel',
				width : '100',
				hidden : false
			},{
				title: '地址',
				field: 'teacherAddr',
				width: '100',
				hidden : false
			} ] ]
		});
		teacherOfCourseGrid = $('#teacherOfCourseGrid').datagrid({
			toolbar: '#toolbar2',
			url : basePath + 'train/course/queryTeacherOfCourse',
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
		    idField: 'teacherId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
				field: "ck",
				checkbox: true
			},{
				title : '讲师ID',
				field : 'teacherId',
				width : '100',
				hidden : true
			},{
				title : '姓名',
				field : 'teacherName',
				width : '200',
				hidden : false
			},{
				title : '年龄',
				field : 'teacherAge',
				width : '100',
				hidden : false
			},{
				title: '性别',
				field: 'teacherSex',
				width: '60',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_sex, value); 
				}
			},{
				title : '联系方式',
				field : 'teacherTel',
				width : '100',
				hidden : false
			},{
				title : '地址',
				field : 'teacherAddr',
				width : '200',
				hidden : false
			} ] ]
		});
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	// 添加讲师到课程(多选)
	function addTeacherToCourse() {
		var rows = teacherGrid.datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
		}
		var courseTeachers = $.toJSON(rows);
		var param = {
			'courseTeachers' : courseTeachers,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/addTeacherToCourse', param, function(result) {
			if (result.code=='0') {
        		$.messager.alert('提示','操作成功！','info',function(){
        			teacherOfCourseGrid.datagrid('reload'); 
        		}); 	                        	                     
           	} else {
           		$.messager.alert('提示','操作失败：' + result.msg,'error');
            }
		}, 'json');
	} 
	
	// 将讲师从课程中移除
	function delTeacherOutOfCourse() {
		var rows1 = teacherOfCourseGrid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		}
		var rows = teacherOfCourseGrid.datagrid("getSelections");
		var courseTeachers = $.toJSON(rows);
		var param = {
			'courseTeachers' : courseTeachers,
			'courseId' : $("#courseId").val()
		};  
		$.post(basePath + 'train/course/delTeacherOutOfCourse', param, function(result) {
			if (result.code == '0'){
        		$.messager.alert('提示', '操作成功！', 'info', function(){
        			teacherOfCourseGrid.datagrid('reload'); 
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
        	<sicp3:groupbox title="讲师列表">
	        	<div id="toolbar1">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addTeacherToCourse"
								iconCls="ext-icon-user_add" plain="true" onclick="addTeacherToCourse()">加入到课程</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="teacherGrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <br><br>
	        <sicp3:groupbox title="课程讲师列表">
	        	<div id="toolbar2">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delTeacherOutOfCourse"
								iconCls="ext-icon-user_delete" plain="true" onclick="delTeacherOutOfCourse()">从课程中移除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="teacherOfCourseGrid" style="height:250px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>   
	</div> 
</body>
</html>