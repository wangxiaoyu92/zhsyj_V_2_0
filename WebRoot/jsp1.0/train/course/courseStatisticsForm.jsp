<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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

<!DOCTYPE HTML>
<html>
<head>
<title>课程评价</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		var v_courseId = $("#courseId").val();
		$.ajax({
			type : "POST",
			url : basePath + "train/course/queryCourseStatistics",
			data : {
				courseId : v_courseId
			},
			success : function(result) {
				result = eval('(' + result + ')');
				$.each(result.count, function() {
					if (result.score == 1) {
						$("#worse").html("" + result.count + "");
					} else if (result.score == 2) {
						$("#bad").html("" + result.count + "");
					} else if (result.score == 3) {
						$("#common").html("" + result.count + "");
					} else if (result.score == 4) {
						$("#good").html("" + result.count + "");
					} else if (result.score == 5) {
						$("#best").html("" + result.count + "");
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
   		<div region="center" style="overflow: auto;" border="false">
   			<form id="fm" method="post" >	
   				<input id="courseId" name="courseId" type="hidden" value="<%=v_courseId%>"/>
   				<sicp3:groupbox title="基本信息">
   					<table class="table" style="width:98%;height: 98%">
   		 				<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr>
   		 				<tr>
   		 					<td style="text-align:right;"><nobr>课程名称:</nobr></td>
   		 					<td><span id="courseName" name="courseName">${courseInfo.courseName}</span></td> 
   							<td style="text-align:right;"><nobr>课程状态:</nobr></td>
  							<td><span id="courseStatus" name="courseStatus">
  								${courseInfo.courseStatus == 1? '启用' : '禁用'}</span>
  							</td>
 						</tr>
   					</table>
   				</sicp3:groupbox>
   				<sicp3:groupbox title="统计评价">
   					<div style="float: left;width:50%; height: 300px;">
   						<table style="width:90%;padding-top: 30px;padding-left: 5%;">
					   		<tr>
								<td>
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
								</td>
								<td>非常好</td>
								<td><span id="best">0</span>人评价</td>
							</tr>
							<tr>
								<td>
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
								</td>
								<td>好</td>
								<td><span id="good">0</span>人评价</td>
							</tr>
							<tr>
								<td>
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
								</td>
								<td>一般</td>
								<td><span id="common">0</span>人评价</td>
								</tr>
							<tr>
								<td>
									<img src="<%=contextPath%>/images/login/star-on.png">
									<img src="<%=contextPath%>/images/login/star-on.png">
								</td>
								<td>差</td>
								<td><span id="bad">0</span>人评价</td>
							</tr>
							<tr>
								<td>
									<img src="<%=contextPath%>/images/login/star-on.png">
								</td>
								<td>很差</td>
								<td><span id="worse">0</span>人评价</td>
							</tr>	
   						</table>
   					</div>
   			</sicp3:groupbox>
			</form>
		</div>
	</div>
</body>
</html>
