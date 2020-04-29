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
<script type="text/javascript">
	//视频播放地址
//	var videourl = "http://42.236.61.217:20001/?channel=sub%26cam_indexcode=";
    //gu20180422 var videourl = "rtmp://42.236.61.220:1935/live/pag/42.236.61.217/7302/";
    var videourl = "rtmp://117.158.242.70:1935/live/pag/192.168.0.192/7302/";
    var videourl_err_tip = "http://www.shejian360.com/download/erro.mp4";
</script>
<%-- 视频监控 --%>
<script src="<%=contextPath%>/jslib/myflashflowplayer/jquery-1.8.3/jquery-1.11.0.min.js"></script>
<link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/css.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/base.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jslib/myflashflowplayer/home/inPage/files/css/main.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jslib/myflashflowplayer/home/inPage/files/css/css.css" rel="stylesheet" type="text/css" />  
<link href="<%=contextPath%>/jslib/myflashflowplayer/FlatUI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=contextPath%>//jslib/myflashflowplayer/FlatUI/dist/css/flat-ui.min.css" rel="stylesheet">
<link href="<%=contextPath%>/jslib/myflashflowplayer/mclzplayer.css" rel="stylesheet" type="text/css" /> 
<script src="<%=contextPath%>/jslib/myflashflowplayer/flowplayer-3.2.13.min.js"></script>
<script src="<%=contextPath%>/jslib/myflashflowplayer/mclzplayer2.js"></script>

