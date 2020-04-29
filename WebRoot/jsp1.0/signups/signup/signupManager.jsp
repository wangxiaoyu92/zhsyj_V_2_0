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
<title>申请用户</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	function saveUser() {
	//手机验证是否输入正确
	var phone = $("#regTel").val();
	if(!(/^1[34578]\d{9}$/.test(phone))){ 
        alert("手机号码有误，请重填");  
        return false; 
    }
    //验证邮箱输入是否正确
    var re = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
    var regEmail=$("#regEmail").val();
    if(!(re.test(regEmail))){
    	alert("你输入的邮箱有误,请重填");
    	return false;  
    }
	var url = basePath + "signups/signup/saveUser";
	$.messager.progress();	// 显示进度条
	$('#fm').form('submit',{
	url: url,
	onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						sy.setWinRet("ok");
						parent.$("#"+sy.getDialogId()).dialog("close");
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
	});
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm"  method="post">
				<sicp3:groupbox title="申请账号">
					<table class="table" style="width:98%;height: 98%">
					<tr>
						<td style="text-align:right;"><nobr>账号:</nobr></td>
						<td><input id="regName" name="regName" style="width: 200px"
							class="easyui-validatebox" class="easyui-validatebox" data-options="required:true"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>密码:</nobr></td>
						<td><input id="regPass" name="regPass" style="width: 200px"
							class="easyui-validatebox" class="easyui-validatebox" data-options="required:true"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>邮箱:</nobr></td>
						<td><input id="regEmail" name="regEmail" style="width: 200px"
							class="easyui-validatebox" class="easyui-validatebox" data-options="required:true"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>注册手机号:</nobr></td>
						<td><input id="regTel" name="regTel" style="width: 200px"
							class="easyui-validatebox" class="easyui-validatebox" data-options="required:true"/></td>
					</tr>
				</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveUser()" id="btnSave">注册 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        </div>
		</div>
	</div>


</body>
</html>

