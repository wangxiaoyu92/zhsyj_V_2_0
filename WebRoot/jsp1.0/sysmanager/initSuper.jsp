<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>初始化超级管理员权限</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

	var saveFun = function(){
		$("#btnSave").disabled = true;
		$("#loading-mask").show(); 
		$.ajax({
    		url: "<%=contextPath %>/sysmanager/sysuser/initSuper",
    		type: 'post',
    		async: true,
    		cache: false,
    		timeout: 100000,
    		data: '',
    		dataType: 'json',
    		error: function() {
    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info',function(){
    				$("#btnSave").disabled = false;
    				$("#loading-mask").hide();
    			});			
    		},
    		success: function(result) {
    			if (result.code == "0") {
    				$.messager.alert('提示','初始化成功！','info',function(){
    					$("#btnSave").disabled = false;
        				$("#loading-mask").hide();
    				});	
    			} else {
    				$.messager.alert('提示','初始化失败！' + result.msg,'error',function(){
    					$("#btnSave").disabled = false;
	    				$("#loading-mask").hide();	
    				});	
    			}
    		}
    	});	
	};

	function refresh(){
		parent.window.refresh();	
	} 
</script>
</head>
<body>		
	<div class="easyui-layout" fit="true">           
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="初始化超级管理员权限">
        	<div id="loading-mask" style="display:none;z-index:20000;text-align:center;">
        		<img src="<%=contextPath%>/images/frame/loading_square.gif" align="absmiddle" />
        	</div>
        	<br/>
            <br/>    
	        <div style="text-align:center">
	        	<a data="btn_initSuper" href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-reload" onclick="saveFun()" id="btnSave">>>>>初始化超级管理员权限>>>></a>
	        </div>
	        </sicp3:groupbox>
        </div>        
    </div>    

</body>
</html>
