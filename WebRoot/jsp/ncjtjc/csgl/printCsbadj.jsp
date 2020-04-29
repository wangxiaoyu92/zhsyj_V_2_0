<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 
String csid = StringHelper.showNull2Empty(request.getParameter("csid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>打印《农村流动厨师备案登记表》</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
<script type="text/javascript">
	var editor;
	$(function() {
		//加载ckeditor
		editor = CKEDITOR.replace( 'detailinfo' );
		//设置只读
		CKEDITOR.on('instanceReady', function (ev) {
	        editor = ev.editor;
	        editor.setReadOnly(true); 
	    });				
	});

	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};


</script>
</head>
<body >
<div  style="width: 99%;" >
	<sicp3:groupbox title="打印《农村流动厨师备案登记表》" >	
        <div class="">
 			<textarea  name="detailinfo" id="detailinfo" style="width: 80%;height: 80%">${obj.data}</textarea>
		</div>
	</sicp3:groupbox>
</div>	   
</body>
</html>