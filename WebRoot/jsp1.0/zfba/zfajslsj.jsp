<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<!DOCTYPE html>
<html>
<head>
<title>案件受理时间</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
s.value = $("#ajdjslsj").val();


	// 保存 
	var submitForm = function() {
		s.value = $("#ajdjslsj").val();
	    sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");
	};
</script>
</head>
<body>
	<form id="fm" name="fm" method="post">
   		<table class="table" style="width: 450px;">
   		   <tr>
   		     <td width="29%"></td>
   		     <td width="69%"></td>
   		   </tr>
		   <tr>
				<td style="text-align:right;"><nobr>案件受理时间:</nobr></td>
				<td><input name="ajdjslsj" id="ajdjslsj" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					readonly="readonly" style="width: 200px;"></td>						
			</tr>
			<tr>
				<td style="text-align:center;" colspan="2"><nobr>默认为当前时间</nobr></td>
			</tr>
			<tr>
			  <td colspan="2" style="height: 50px;" >
			    <div align="center">
				<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-save" onclick="submitForm()"> 确定 </a>	
				</div>														     
			  </td>
			</tr>									
		</table>
   </form>
</body>
</html>