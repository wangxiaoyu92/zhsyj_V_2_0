<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>找回密码</title>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<link rel="stylesheet" href="<%=basePath %>/css/pwd.css" type="text/css">
<script type="text/javascript">

$(function() {
	$('#passwd').keyup(function () { 
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
	
		if (false == enoughRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-defule'); 
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-strong'); 
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-medium'); 
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-weak'); 
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	}); 

});


// 保存 
function myreg() {
	var url = basePath + '/pub/pub/findpwtijiao';
	var loginurl = basePath + '/index.jsp';

	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#myform').form('submit',{
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
		 		$.messager.alert('提示','成功：请登录邮箱确认'+result.msg,'info',function(){
		 			//window.location.href=loginurl;
		 			//window.history.go(-1);
		 			//window.history.back();
		 			self.location=document.referrer;//返回并刷新
        		}); 	                        	                     
          	} else {
          		$.messager.alert('提示','失败：'+result.msg,'error');
            }
        }    
	});
};


</script>
</head>
<body style="background-color: white;overflow-y: auto; overflow-x:hidden;">
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;background-color: white;" border="false">
	        	<div id="toolbar" fit="true">
	        	<form name="myform" id="myform" method="post">
	        	  <h1 style="text-align:center;font-size:20px;line-height:30px;">找回登录密码</h1>	
	        		<table  align="center" style="border-spacing:8px;" class="mytable">
	        		    <tr>
						    <td style="text-align:right;"><nobr><font class="myred">*</font>登录账号:</nobr></td>
						    <td colspan="3"><input id="username" name="username" style="width: 300px" 
						    class="easyui-validatebox input-text" data-options="required:true,validType:'length[0,50]'"/></td>
	        		    </tr>
						<tr>
							<td style="text-align:right;"><nobr><font class="myred">*</font>注册的电子邮箱email:</nobr></td>
							<td colspan="3"><input id="useremail" name="useremail" style="width: 300px" 
							class="easyui-validatebox input-text" 
							data-options="required:true,validType:['length[0,100]','email']"/></td>
							
						</tr>						
					    <tr>
					      <td colspan="4">&nbsp;</td>
					    </tr>		
					    <tr>
						<td colspan="4" align=right>
						   <input type="button" value="确认找回" class="btn_bg"
								  onMouseOver="this.className='btn_bg_hover'"
								  onMouseOut="this.className='btn_bg'" id="saveBtn" onclick="myreg();"/>
						   &nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="reset" value="清空重填"  class="btn_bg"
								  onMouseOver="this.className='btn_bg_hover'"
								  onMouseOut="this.className='btn_bg'" id="restBtn" onclick="myform.reset();"/>
						   &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="返回"  class="btn_bg"
								   onMouseOver="this.className='btn_bg_hover'"
								   onMouseOut="this.className='btn_bg'"  onclick="self.location=document.referrer;"/>
						   
						</td>
						</tr>
																                    
					</table>
				</form>
				</div>
        </div>        
    </div>    
</body>
</html>