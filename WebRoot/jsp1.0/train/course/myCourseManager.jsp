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

<!DOCTYPE HTML>
<html>
<head>
<title>我的课程</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	//课程分类
	var v_courseCategory = <%=SysmanageUtil.getAa10toJsonArray("KCFL")%>;
	$(function() {
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'train/course/queryMyCourses',
			striped : true, // 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'courseId', //该列是一个唯一列
			sortOrder: 'desc',
			columns : [[{
				title: '课程id',
				field: 'courseId',
				width : '80',
				hidden : true
			},{
				title: '课程名称',
				field: 'courseName',
				width : '200',
				hidden : false
			},{
		        title: '课件分类',
				field: 'courseCategory',
				width: '150',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_courseCategory, value);
				}
		 	},{
	 			title: '评价分数',
				field: 'score',
				width : '150',
				hidden : false
			},{
	 			title: '经办人',
				field: 'aae011',
				width : '150',
				hidden : false
		 
		 	},{
	 			title: '经办时间',
				field: 'aae036',
				width : '150',
				hidden : false
			}]]
		});	
	});
	// 查看我的课程
	function showMyCourse(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var url = basePath + 'train/course/showMyCourse';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						courseId : row.courseId,
						score : row.score
					},
					width : 750,
					height : 500,
					url : url
			},function(dialogID) {
				var obj = sy.getWinRet(dialogID);
				if(obj=='ok'){
					grid.datagrid("reload"); 
				}
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}
	}
	// 查询课程
	function query() {
		var v_courseName = $('#courseName').val();
		var param = {
			'courseName' : v_courseName
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
						<td style="text-align:right;"><nobr>课程名称</nobr></td>
						<td><input id="courseName" name="courseName" style="width: 200px"/></td>						
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
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showMyCourse"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showMyCourse()">查看</a>
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
