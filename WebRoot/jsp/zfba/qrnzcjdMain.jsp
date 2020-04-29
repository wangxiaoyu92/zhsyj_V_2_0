<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	System.out.println("op"+op);
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};

</script>
</head>
<body>
    <input name="check1" type="radio" value="0"/>违法事实不成立，依法提出不得行政处罚意见
    <input name="check1" type="radio" value="1">违法行为轻微，依法可以不予行政处罚的，提出不予行政处罚意见
    <input name="check1" type="radio" value="2">符合条件，7日内立案、填写立案申请表
    <a href="javascript:void(0);" id="subBtn" class="easyui-linkbutton" onclick="sub()" data-options="iconCls:'icon-save'">提交</a>
			           
</body>
</html>