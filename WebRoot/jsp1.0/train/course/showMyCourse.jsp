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
	// 评价分数
	String v_score = StringHelper.showNull2Empty(request.getParameter("score"));
%>

<!DOCTYPE HTML>
<html>
<head>
<title>我的课程信息</title>
<style>
#star li{
float:left;
width:20px;
height:20px;
margin:2px;
display:inline;
color:#999;
font:bold 18px arial;
cursor:pointer
}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var s = "ok";      
	sy.setWinRet(s);
	var courseHomeGrid;// 课程使用课后作业表
	var courseWareGrid; // 课程使用课件表
	var v_wareCategory = <%=SysmanageUtil.getAa10toJsonArray("KJFL")%>; // 课件分类
	var word = [ "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars" ]; // 课程评分登记描述
	var v_wareType = <%=SysmanageUtil.getAa10toJsonArrayXz("KJLX")%>; // 课件类型
	$(function() {
		loadcourseWareGrid(); // 加载课件信息
		loadcourseHomeGrid(); // 加载课后作业信息
		loadCourseAppraise(); // 加载课程评价分数
	});
	// 加载课程评价
	function loadCourseAppraise() {
		loadCourseScore();
		// 评分交互事件
		$("#star li").hover(function () {
	    	$("#star li").css("color", "#999");
	    	$("#star_word").html(word[$(this).index()]);
			for (var j = 0; j <= $(this).index(); j++) {
				$("#star li").eq(j).css("color", "#c00");
			}
	  	},function () {
	  		$("#star li").css("color", "#999");
			loadCourseScore();
	  	});
	  	// 打分绑定事件
	  	$("#star li").bind("click", function() {
	  		var v_score = $(this).index() + 1;
	  		parent.$.messager.progress({text : '打分中....'});
			$.ajax({
				type : "POST",
				url : basePath + "train/course/saveAppraise",
				data : {
					score : v_score,
					courseId : $('#courseId').val()
				},
				success : function(result) {
					parent.$.messager.progress('close'); // 隐藏进度条
					result = eval('(' + result + ')');
					if (result.code == '0') {
						$.messager.alert('提示', '评分成功！', 'info');
						$("#score").val(v_score);
						loadCourseScore();
					} else {
						$.messager.alert('提示', '评分失败：' + result.msg, 'error');
					}
				}
			});
	  	});
	};
	function loadCourseScore() {
		var score = $("#score").val();
		for (var j = 0; j < score; j++) {
			$("#star li").eq(j).css("color", "#c00");
		}
		$("#star_word").html(word[score - 1]);
	}
	//查询包含课件的信息
	function loadcourseWareGrid(){
		var v_courseId = $("#courseId").val();
		if (v_courseId == "" || v_courseId == null) {
			v_courseId = "null";
		}
		courseWareGrid = $("#courseWareGrid").datagrid({
			toolbar : "#toolbar2",
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
			sortOrder : 'desc',
			columns : [ [ {
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
				title : '所需积分',
				field : 'wareCredit',
				width : '100',
				hidden : false
			},{
				title : '时长',
				field : 'wareLength',
				width : '100',
				hidden : false
			},{
		   		title: '课件分类',
				field: 'wareCategory',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_wareCategory, value);
				}
			},{
				title : '学分',
				field : 'warePoint',
				width : '100',
				hidden : false
			},{
		   	    title: '课件类型',
				field: 'wareType',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_wareType, value);
				}
		    },{
		        title: '课件路径',
				field: 'wareVideo',
				width : '100',
				hidden : true
		    }]]
		});
	}
	
	// 查看课件信息
	function showCourseWare(){
		var row = courseWareGrid.datagrid('getSelected');
		if (row) {
			var url = basePath + 'train/courseware/showCourseWareIndex';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						wareId : row.wareId
					},
					width : 850,
					height : 600,
					url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	}
	
	// 加载课程包含的课后作业
	function loadcourseHomeGrid(){
		var v_courseId = $("#courseId").val();
		if (v_courseId == "" || v_courseId == null) {
			v_courseId = "null";
		}
		courseHomeGrid = $("#courseHomeGrid").datagrid({
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
			sortOrder : 'desc',
			columns : [ [ {
				title : '课后作业ID',
				field : 'homeworkId',
				width : '100',
				hidden : true
			},{
		
				title : '作业名称',
				field : 'title',
				width : '100',
				hidden : false
			},{
				title: '作业类型',
				field: 'type',
				width: '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "1") {
						return '<span>附件</span>';
					} else if ((value == "2")) {
						return '<span>问答</span>';
					} 
				}
			},{
				title : '作业内容',
				field : 'content',
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
				width : '300',
				hidden : false
			}]]
		});
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
  		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
  				<input  id="courseId" name="courseId" type="hidden"  value="<%=v_courseId%>">
		 		<sicp3:groupbox title="课程基本信息">
		 			<table class="table" style="width:98%; height: 98%">
		 				<tr><td width="10%"></td><td width="50%"></td><td width="40%"></td></tr> 
						<tr>
							<input type="hidden" name="score" id="score" value="<%=v_score%>">
							<td style="text-align:right;"><nobr>课程名称:</nobr></td>
		 					<td>${courseInfo.courseName}</td>
		 					<td rowspan="2" colspan="1">
								<span style="display: block;">打分结果:
									<ul id="star">
										<li>★</li>
										<li>★</li>
										<li>★</li>
										<li>★</li>
										<li>★</li>
									</ul>
								</span>
								<span id="result"></span>
								<div id="star_word"></div>
				    		</td>
		 				</tr>
		 				<tr>
		 					<td style="text-align:right;"><nobr>课程描述:</nobr></td>
		 					<td>${courseInfo.courseDes}</td>
		 				</tr>
		 			</table>
		 		</sicp3:groupbox>
		 		<sicp3:groupbox title="其它信息">
			 		<div id="tabs" class="easyui-tabs" fit="false">
			 			<div title="课程目录" style="overflow:hidden;">
			 				<sicp3:groupbox title="课件">
			 					<div id="toolbar2">
					        		<table>
										<tr>	        		
											<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showCourseWare"
												iconCls="ext-icon-report_magnify" plain="true" onclick="showCourseWare()">查看</a>
											</td>
											<td><div class="datagrid-btn-separator"></div></td>
										</tr>
									</table>
								</div>
								<div id="courseWareGrid"></div>
							</sicp3:groupbox>
			 			</div>
			 			<div title="作业" style="overflow:hidden;">
			 				<sicp3:groupbox title="作业">
								<div id="courseHomeGrid"></div>
							</sicp3:groupbox>
			 			</div>
			 		</div>
		 		</sicp3:groupbox>
			</form>
  		</div>
  	</div>
</body>
</html>
