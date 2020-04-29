<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
	String v_mypassword=vSysUser.getPasswd();
%>
<!DOCTYPE html>
<html>
<head>
<title>密码确认窗口</title>
<style type="text/css">
.mytab {
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-spacing:0px;
	border-top: 0px solid black;
	border-left: 0px solid black;
	border-right: 0px solid black;
	border-bottom: 0px solid black; 	
}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">	
function queding(){
	   var v_userpwd=$("#userpwd").val();
	   v_userpwd=hex_md5(v_userpwd);
	   var v_localpass="<%=v_mypassword%>";
	   if (v_userpwd==v_localpass){
		   sy.setWinRet(true);
		   parent.$("#"+sy.getDialogId()).dialog("close");
	   }else{
		   alert("密码错误");
		   $("#userpwd").focus(); 
	   }
}

function quxiao(){
	sy.setWinRet(false);
	parent.$("#"+sy.getDialogId()).dialog("close");
}
   
	function refresh(){
		$('#userpwd').val('');
	}    

	function myonload(){
		$('#userpwd').focus();
	}
</script>
</head>
<body onload="myonload();">
	<form id="myfrm" method="post" class="form" >
		<table align="center" border="none" border rules=none cellspacing=0 >
			<tr>
			<p>&nbsp;</p>
				<td colspan="2" height="40">请输入密码：<input id="userpwd" 
				    name="userpwd" type="password" 
				    class="text-input validate[required]"/></td>
			</tr>
			<tr>
			  	<td colspan="2" height="40" align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="queding()"> 确定</a>
						&nbsp;&nbsp;&nbsp;&nbsp;								
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-reload" onclick="quxiao()"> 取消</a>
				</td>	
			</tr>			
		</table>
	</form>  

</body>
</html>