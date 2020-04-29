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
	String v_examsInfoId = StringHelper.showNull2Empty(request.getParameter("examsInfoId"));
%>
<!DOCTYPE html>
<html>
  <head>
  	<title>应考人员列表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
    var grid;
    var v_examsInfoId;	
    $(function() {
	v_examsInfoId=$('#examsInfoId').val();
	grid = $('#grid').datagrid({
	url : basePath + 'exam/exam/queryExamMonUsers',
	queryParams : { examsInfoId : v_examsInfoId },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			pageSize : 10,
	        pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'examUserId', //该列是一个唯一列
		    sortOrder: 'desc',
		    columns : [[ {
		    	title : '考试用户ID',
				field : 'examUserId',
				width : '100',
				hidden : true
		    },{
		    	title : '用户名',
				field : 'username',
				width : '150',
				hidden : false
		    },{
		    	title : '用户描述',
				field : 'description',
				width : '200',
				hidden : false
		    },{
		    	title : '用户手机',
				field : 'mobile',
				width : '200',
				hidden : false
		    },
		    
		    ]]
	});
	});
    </script>
  </head>
  
  <body>
  <sicp3:groupbox title="应考人员列表">
  <input id="examsInfoId" name="examsInfoId" type="hidden" value="<%=v_examsInfoId%>"/>
  <div id="grid"></div>
  </sicp3:groupbox>
  </body>
</html>
