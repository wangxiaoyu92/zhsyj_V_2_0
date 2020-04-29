<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}	
%>
<!DOCTYPE html>
<html>
<head>
<title>执法办案流程图</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script>
//关闭并刷新父窗口
function closeAndRefreshWindow(){
	var s = new Object();      
	s.type = "ok";
	sy.setWinRet(s);
	parent.$("#"+sy.getDialogId()).dialog("close");  
} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true"> 
		<div region="center" style="overflow: true;" border="false">     
			<sicp3:groupbox title="执法办案流程图">
				<table class="table" style="width: 99%;">
					<tr>
						<td><img src="<%=contextPath%>/images/zmdzfbalc.jpg" name="zfbalct" id="zfbalct" />	</td>																
					</tr>

				</table>
	        </sicp3:groupbox>			
    	</div>   
	</div>	    
</body>
</html>