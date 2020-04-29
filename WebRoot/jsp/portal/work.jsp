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
	$(function(){ 
		var id = setInterval('showMessage()',6000);
		//clearInteval(id);		
	});
	
	function showMessage(){
		$.post(basePath + '/common/sjb/querySjqd', {
			aae016 : '0'
		},
		function(result) {
			if (result.code == '0') {
				$('#work1').html('');	
				$('#work1').html(result.count);	
			} else {
				$.messager.alert('提示', "操作失败：" + result.msg, 'error');
			}
		},'json');	  
	}
</script>
<br/>
<ul>
	<li>你有【<font style='color:red;font-weight:bold' id="work1"></font>】条司机签到记录未审核，请及时处理！</li>
</ul>
