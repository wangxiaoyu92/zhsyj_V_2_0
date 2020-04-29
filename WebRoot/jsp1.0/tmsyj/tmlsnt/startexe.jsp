<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title></title>
<script src="./js/jquery-1.12.0.min.js"></script>
<script type="text/javascript">
	function LaunchApp() { 	
		var exepath = "D:\\NVS_Client\\bin\\IvEyes.exe";
		//var exepath = "D:\\Program Files (x86)\\NVS_Client\\bin\\IvEyes.exe"; 
	    var ws = new ActiveXObject("WScript.Shell");	      
	    ws.Exec(exepath); 
	    closeWindow();
	}  
	
	function LaunchApp2() {  
	    netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');  
	    var file = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);  
	    file.initWithPath("D:\\HiJson_jdk64.exe");  
	    file.launch();
	    closeWindow();  
	}
	
	function closeWindow(){
        window.opener=null;
        window.open('','_self');
        window.close(); 
    }
        
	$(function() {
		LaunchApp();		
	});
</script>
</head>
<body>
	<div>
		<form id="fm" method="post" >			
	       	<sicp3:groupbox title="ceshi">
	       		<a href="javascript:LaunchApp();">Click here to Execute your file</a> 	
	        </sicp3:groupbox>
    	</form>
    </div>    
</body>
</html>