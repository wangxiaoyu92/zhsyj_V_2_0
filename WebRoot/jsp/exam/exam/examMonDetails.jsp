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
	// 考试id
	String v_examsInfoId = StringHelper.showNull2Empty(request.getParameter("examsInfoId"));
	// 考试名称
	String v_examsName = StringHelper.showNull2Empty(request.getParameter("examsName"));
	// 开始时间 
	String v_startTime = StringHelper.showNull2Empty(request.getParameter("startTime"));
	// 结束时间
	String v_endTime = StringHelper.showNull2Empty(request.getParameter("endTime"));
%>

<!DOCTYPE html>
<html>
  <head>
    <title>应考人员列表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
    var grid;
    var v_examsInfoId; 
    var v_userName;
    $(function() {
	v_examsInfoId=$('#examInfoId').val();
	grid = $('#grid').datagrid({
	url : basePath + 'exam/exam/queryExamMonDetails',
	queryParams : { examInfoId : v_examsInfoId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			pagination : true,// 底部显示分页栏
		 	pageSize : 10,
	        pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'resultMateId', //该列是一个唯一列
		    sortOrder: 'desc',
		    columns : [[{
		        title: '试卷id',
				field: 'paperInfoId',
				width : '100',
				hidden : true
		 },{
		        title: '总分',
				field: 'points',
				width : '100',
				hidden : true
		 },{
		        title: '考试id',
				field: 'examInfoId',
				width : '100',
				hidden : true
		 },{
		    	title : '考试用户ID',
				field : 'resultMateId',
				width : '100',
				hidden : true
		    },{
		    	title : '用户名',
				field : 'userName',
				width : '150',
				hidden : false
		    },{
		    	title : '用户描述',
				field : 'description',
				width : '200',
				hidden : false
		    },{
		    	title : '身份证件号',
				field : 'aac002',
				width : '200',
				hidden : false
		    },{
		    	title : '开始答卷时间',
				field : 'showTime',
				width : '200',
				hidden : false
		    },{
		    	title : '已经答卷时间(分钟)',
				field : 'costtimes',
				width : '200',
				hidden : false
		    },{
				title:'操作',
				field:'opt',
				align:'center',
				width:150,
	            formatter:function(value, row, index){
					var str = "";									
	                str += "<span style='color:blue'><a href='javascript:startExam(" + "\"" + row.paperInfoId;
	                str += "\"" + ")'><img src='<%=basePath%>jslib/jquery-easyui-1.3.4/themes/icons/modify.gif'"; 
	                str += " align='absmiddle'>查看卷子</a></span>";
	                return str;  
	            } 
	      	}]]
	});
	});
	// 查看试卷
	function startExam() {	
		var url=basePath + "exam/result/userStartExamIndex";	
		var row = $('#grid').datagrid('getSelected');
		var dialog = parent.sy.modalDialog({
			title : '查看考试',
			param : {
			examsInfoId : row.examInfoId,
			paperInfoId:row.paperInfoId,
			points : row.points
			},
			width : 1050,
			height : 720,
			url : url
		});
	} 
	
	//收卷
	function windingExam(){
	var row = $('#grid').datagrid('getSelected');
	var url=basePath + "train/courseware/showCourseWareIndex";
	if (row) {
			var dialog = parent.sy.modalDialog({
				title : '开始考试',
				param : {
				wareId : row.wareId
				},
				width : 850,
				height : 600,
				url : url
			})
	
	}else{
			$.messager.alert('提示', '请先选择要交卷的记录！', 'info');
		}
	}
	
	//查询
	function query() {
	var userName = $("#userName").val();
	var examInfoId=$("#examInfoId").val();
	var param = {
			//用户名称
			'userName' : userName,
			'examInfoId' : examInfoId
		};
	  $('#grid').datagrid('load', param);
	  grid.datagrid('clearSelections');
	}
	
	// 重置
	function refresh(){
		$("#userName").val('');
		$('#grid').datagrid('load', {});	
	}
	
	
	//收卷
	function windingMon(){
	var row = $('#grid').datagrid('getSelected');
		if (row) {
		} else {
			$.messager.alert('提示', '请先选择要收卷的信息！', 'info');
		}
	}
	</script>
   </head>
  
  <body>
  	<div class="easyui-layout" fit="true"> 
  			<div region="center" style="overflow: hidden;" border="false">
  			      <sicp3:groupbox title="考试信息">
  			     <input id="paperInfoId" type="hidden" value="${paperInfo.paperInfoId}"/>
				<input id="paperInfoPass" type="hidden" value="${paperInfo.paperInfoPass}"/>
				<input id="examsInfoId" type="hidden" value="${paperInfo.examsInfoId}"/>
				<input id="points" type="hidden" value="${paperInfo.points}"/>
				<input id="resultMateId" type="hidden" value="${resultMateId}"/>
  			        <input id="examInfoId" name="examInfoId" type="hidden" value="<%=v_examsInfoId%>"/>
  			       <table class="table" style="width: 99%;">
  			       	<tr>
  			       	<td>
  			       	<td style="text-align:right;"><nobr>考试名称 </nobr></td>
					<td><%=new String(v_examsName.getBytes("ISO-8859-1"), "utf-8")%></td>  			       	</td>
  			       </tr>
  			       <tr>
  			       <td>
  			       	<td style="text-align:right;"><nobr>考试时间</nobr>
  			       	<td>
  			       	<%=new String(v_startTime.getBytes("ISO-8859-1"), "gbk")%> &nbsp--
  			       	<%=new String(v_endTime.getBytes("ISO-8859-1"), "gbk")%>
  			       	</td>
  			       	</td>
  			       </td>
  			       </tr>
  			      </table>
  			      </sicp3:groupbox>
  				 <sicp3:groupbox title="考试搜索">  
  				 <tr>
  				 <td style="text-align:right;"><nobr>用户名</nobr></td>
				<td><input id="userName" name="userName" style="width: 200px" /></td>
				<td colspan="2" style="text-align:center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
				</td>
  				 </tr>
  				 </sicp3:groupbox>
  				 <sicp3:groupbox title="考试列表 ">
  				 <div id="toolbar">
			<table>
			<tr>
				<td><a href="javascript:void(0)" class="easyui-linkbutton"
				data="btn_showCourseWare" iconCls="ext-icon-report_magnify" plain="true"
				onclick="windingMon()">收卷</a>
				</td>
			</tr>
			</table>
			</div>
  				 <div id="grid"></div>
  				</sicp3:groupbox>
  			</div>
  	</div>
  
  </body>
</html>
