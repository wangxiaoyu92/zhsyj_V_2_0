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
<title>我的考试</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid; // 用户考试表格
	var examPaperGrid; // 考试包含试卷表格
	$(function() {
		grid = $('#grid').datagrid({
			// toolbar: '#toolbar',
			url : basePath + 'exam/result/queryUserExams',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'examsInfoId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[{
				title: '考试id',
				field: 'examsInfoId',
				width : '100',
				hidden : true
			},{
				title: '考试名称',
				field: 'examsInfoName',
				width : '300',
				hidden : false
			},{
				title: '考试类型',
				field: 'examsType',
				width : '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "0") {
						return '<span>练习</span>';
					} else if ((value == "1")) {
						return '<span>考试</span>';
					} 
				}
			},{
				title: '考试开始时间',
				field: 'starttime',
				width : '150',
				hidden : false
			},{
				title: '考试结束时间',
				field: 'endtime',
				width : '150',
				hidden : false
			},{
				title: '考试限时',
				field: 'duration',
				width : '100',
				hidden : false,
				formatter: function(value, row, index) {
					if (value == "0") {
						return '<span>不限时</span>';
					} else if ((value == "1")) {
						return value + '<span>分钟</span>';
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
			}] ],
			onClickRow : function(rowIndex, rowData){			
				var examsInfoId = rowData.examsInfoId;
				examPaperGrid.datagrid({
					url : basePath + 'exam/result/queryExamPapers',			
					queryParams : { 'examsInfoId' : examsInfoId }
				});
			}
		});
		examPaperGrid = $('#examPaperGrid').datagrid({
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'examsDataId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [{
				title: 'id',
				field: 'examsDataId',
				width : '100',
				hidden : true
			},{
				title: '考试信息id',
				field: 'examsInfoId',
				width : '100',
				hidden : true
			},{
				title: '试卷id',
				field: 'paperInfoId',
				width : '100',
				hidden : true
			},{
				title: '试卷名称',
				align:'center',
				field: 'paperInfoName',
				width : '200',
				hidden : false
			},{
				title: '试卷总分',
				field: 'points',
				align:'center',
				width: '80',
				hidden : false
			},{
				title: '试题总数',
				field: 'total',
				align:'center',
				width: '80',
				hidden : false
			},{
				title: '及格分数',
				field: 'paperInfoPass',
				align:'center',
				width: '80',
				hidden : false
			},{
				title: '创建人',
				field: 'aae011',
				width: '100',
				hidden : true
			},{
				title: '最后更新时间',
				field: 'aae036',
				width: '150',
				hidden : true
			},{
				title:'操作',
				field:'opt',
				align:'center',
				width:150,
	            formatter:function(value, row, index){
					var str = "";									
	                str += "<span style='color:blue'><a href='javascript:startExam(" + "\"" + row.paperInfoId;
	                str += "\"" + ")'><img src='<%=basePath%>jslib/jquery-easyui-1.3.4/themes/icons/modify.gif'"; 
	                str += " align='absmiddle'>开始考试</a></span>";
	                return str;  
	            }   
	      	}] ]
		});
	});
	// 查询考试
	function query() {
		var v_examName = $('#examName').val();
		var param = {
			'examsInfoName' : v_examName
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 开始考试
	function startExam() {
		var url=basePath + "exam/result/userStartExamIndex";		
		var row = $('#examPaperGrid').datagrid('getSelected');
		var dialog = parent.sy.modalDialog({
			title : '开始考试',
			param : {
			examsInfoId : row.examsInfoId,
			paperInfoId:row.paperInfoId,
			points : row.points
			},
			width : 1050,
			height : 720,
			url : url
		})
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
						<td><input id="examName" name="examName" style="width: 200px" /></td>							
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
        	<sicp3:groupbox title="考试列表">
				<div id="grid" style="height: 300px;"></div>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="考试试卷列表">
				<div id="examPaperGrid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>