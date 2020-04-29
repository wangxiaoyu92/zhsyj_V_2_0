<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.DateUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	//$(function(){ 
		//var id = setInterval('showMessage3()',6000);
		//clearInteval(id);		
	//});
	
	function showMessage3(){
		$.post(basePath + '/common/sjb/querySjqd', {
			aae016 : '0'
		},
		function(result) {
			if (result.code == '0') {
				$('#notice').html('');	
				$('#notice').html(result.count);	
			} else {
				$.messager.alert('提示', "操作失败：" + result.msg, 'error');
			}
		},'json');	  
	}
</script>
<br/>
<ul>
	<li><font style='color:red;font-weight:bold' id="notice">骏化物流信息化平台上线测试，如有问题请联系系统管理员！</font></li>
</ul>
