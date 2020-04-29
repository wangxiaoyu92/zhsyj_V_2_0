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
<title>课程信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var courseWareGrid; // 课程使用课件表
	var teacherGrid; // 课程讲师表
	var homeworkGrid; // 课程作业表  
	var v_courseCategory = [{"id":"","text":"===请选择==="},{"id":"0","text":"演示课程"}]; // 课程分类
	var v_courseStatus = [{"id":"1","text":"启用"},{"id":"2","text":"禁用"}]; // 课程状态,1=启用,2=禁用
	var v_courseIsmodifyprogress = [{"id":"1","text":"不限制"}]; // 播放限制：0限制 1不限制 {"id":"0","text":"限制"},
	var v_courseTrainType = [{"id":"","text":"===请选择==="},{"id":"0","text":"线上培训"},{"id":"1","text":"线下培训"}]; // 培训类型：0线上培训 1线下培训
	// var v_courseAutoAdopt = [{"id":"0","text":"不"},{"id":"1","text":"是"}]; // 报名自动审核（0-不，1-是）
	// var v_registration = [{"id":"0","text":"不允许"},{"id":"1","text":"允许"}]; // 代报名(0-不允许,1-允许)
	$(function() {
		loadCombobox(); // 加载页面下拉选择框
	    loadCourseWareGrid(); // 加载课程使用课件表
	    loadTeacherGrid(); // 加载课程讲师表
	    loadHomeworkGrid(); // 加载课程作业表
	    // 如果试卷id不为空
	    if ($('#courseId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'train/course/queryCourseObj', {
				'courseId' : $('#courseId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.courseInfo;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg, 'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	// 加载页面下拉框
	function loadCombobox() {
		// 课程分类
		$("#courseCategory").combobox({
	    	data : v_courseCategory,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 课程状态
	    $("#courseStatus").combobox({
	    	data : v_courseStatus,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#courseStatus").combobox("select", "1");
        	}
	    });
	    // 播放限制 
		$("#courseIsmodifyprogress").combobox({
	    	data : v_courseIsmodifyprogress,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#courseIsmodifyprogress").combobox("select", "1");
        	}
	    });
	    // 培训类型
	    $("#courseTrainType").combobox({
	    	data : v_courseTrainType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 报名自动审核
		/* $("#courseAutoAdopt").combobox({
	    	data : v_courseAutoAdopt,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#courseAutoAdopt").combobox("select", "1");
        	}
	    }); */
	    // 代报名
		/* $("#registration").combobox({
	    	data : v_registration,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#registration").combobox("select", "0");
        	}
	    }); */
	}
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
	// 加载课程使用课件表
	function loadCourseWareGrid() {
		var v_courseId = $("#courseId").val();
		if (v_courseId == "" || v_courseId == null) {
			v_courseId = "null";
		}
		courseWareGrid = $('#courseWareGrid').datagrid({
			url : basePath + 'train/course/queryCourseWareOfCourse',
			queryParams : { courseId : v_courseId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'wareId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[ {
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
			}]]
		});
	}
	// 加载课程讲师表
	function loadTeacherGrid() {
		var v_courseId = $("#courseId").val();
		if (v_courseId == "" || v_courseId == null) {
			v_courseId = "null";
		}
		teacherGrid = $("#teacherGrid").datagrid({
			url : basePath + 'train/course/queryTeacherOfCourse',
			queryParams : { courseId : v_courseId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'teacherId', //该列是一个唯一列
		    sortOrder : 'desc',
			columns : [ [ {
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
				title : '联系方式',
				field : 'teacherTel',
				width : '100',
				hidden : false
			},{
				title : '地址',
				field : 'teacherAddr',
				width : '200',
				hidden : false
			}] ]
		});
	}
	// 加载课程作业表
	function loadHomeworkGrid() {
		var v_courseId = $("#courseId").val();
		if (v_courseId == "" || v_courseId == null) {
			v_courseId = "null";
		}
		homeworkGrid = $("#homeworkGrid").datagrid({
			url : basePath + 'train/course/queryHomeOfCourse',
			queryParams : { courseId : v_courseId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'homeworkId', //该列是一个唯一列
		    sortOrder: 'asc',
			columns : [ [ {
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
	}
	// 保存课程信息
	function saveCourseInfo() {
		var url = basePath + "train/course/saveCourse";
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 closeAndRefreshWindow(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
				<input id="courseId" name="courseId" type="hidden" value="<%=v_courseId%>"/>
        		<sicp3:groupbox title="课程设置">
				<table class="table" style="width:98%;height: 98%">
					<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr> 
	        		<tr>
	                	<td style="text-align:right;"><nobr>课程名称:</nobr></td>
						<td colspan="3"><input id="courseName" name="courseName" 
							style="width: 600px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>课程分类:</nobr></td>
						<td><input id="courseCategory" name="courseCategory" 
							style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"><nobr>课程状态:</nobr></td>
						<td><input id="courseStatus" name="courseStatus" 
							style="width: 200px" class="easyui-combobox"/></td>
					</tr>
					<tr>
                        <td style="text-align:right;"><nobr>课程描述:</nobr></td>
						<td colspan="3"><textarea id="courseDes" name="courseDes" 
							style="width: 600px; height: 50px;"></textarea></td>
					</tr> 
					<tr>
                        <td style="text-align:right;"><nobr>通过条件:</nobr></td>
						<td colspan="3"><input id="coursePassCondition" 
							name="coursePassCondition" style="width: 600px"/></td>
					</tr>   
					<tr>
	                	<td style="text-align:right;"><nobr>播放限制:</nobr></td>
						<td><input id="courseIsmodifyprogress" name="courseIsmodifyprogress" 
							style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"><nobr>培训类型:</nobr></td>
						<td><input id="courseTrainType" name="courseTrainType" 
							style="width: 200px" class="easyui-combobox"/></td>
					</tr>
					<!-- <tr>
	                	<td style="text-align:right;"><nobr>报名自动审核:</nobr></td>
						<td><input id="courseAutoAdopt" name="courseAutoAdopt" 
							style="width: 200px" class="easyui-combobox"/></td>
						<td style="text-align:right;"><nobr>代报名:</nobr></td>
						<td><input id="registration" name="registration" 
							style="width: 200px" class="easyui-combobox"/></td>
					</tr> -->
				</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="关联信息">
			 		<div id="tabs" class="easyui-tabs" fit="false">
			 			<div title="课件" style="overflow:hidden;">
			 				<sicp3:groupbox title="课件">
								<div id="courseWareGrid"></div>
							</sicp3:groupbox>
			 			</div>
			 			<div title="讲师" style="overflow:hidden;">
			 				<sicp3:groupbox title="讲师">
								<div id="teacherGrid"></div>
							</sicp3:groupbox>
			 			</div>
			 			<div title="作业" style="overflow:hidden;">
			 				<sicp3:groupbox title="作业">
								<div id="homeworkGrid"></div>
							</sicp3:groupbox>
			 			</div>
			 		</div>
		 		</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveCourseInfo()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>