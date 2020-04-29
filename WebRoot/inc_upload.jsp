<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>

<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!-- plupload 文件上传插件 -->
<link rel="stylesheet" href="<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css" type="text/css"></link>
<script type="text/javascript" src="<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/i18n/zh-CN.js"></script>

<!-- lightbox 图片插件 -->
<link href="<%=contextPath %>/css/picbox.css" rel="stylesheet" />
<link href="<%=contextPath %>/jslib/lightbox-2.6/css/lightbox.css" rel="stylesheet" />
<script src="<%=contextPath %>/jslib/lightbox-2.6/js/lightbox-2.6.min.js"></script>
<script src="<%=contextPath %>/jslib/lightbox-2.6/js/jquery.imageView.js"></script>
<script src="<%=contextPath %>/jslib/lightbox-2.6/js/jquery.rotate.1-1.js"></script>

