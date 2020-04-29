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
		//var id = setInterval('showMessage4()',6000);
		//clearInteval(id);		
	//});
	
	function showMessage4(){
		$.post(basePath + '/common/sjb/querySjqd', {
			aae016 : '0'
		},
		function(result) {
			if (result.code == '0') {
				$('#warn1').html('');	
				$('#warn1').html(result.count);	
			} else {
				$.messager.alert('提示', "操作失败：" + result.msg, 'error');
			}
		},'json');	  
	}
</script>
<br/>
<ul>
	<li>行驶证即将到期【<font style='color:red;font-weight:bold' id="warn1">5</font>】人，请及时处理！</li>
</ul>
<ul>
	<li>营运证即将到期【<font style='color:red;font-weight:bold' id="warn2">5</font>】人，请及时处理！</li>
</ul>
<ul>
	<li>二维即将到期【<font style='color:red;font-weight:bold' id="warn1">8</font>】人，请及时处理！</li>
</ul>
