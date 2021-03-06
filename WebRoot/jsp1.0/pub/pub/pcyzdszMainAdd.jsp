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
	
	// pcyzdszmainid主表id
	String v_pcyzdszmainid = StringHelper.showNull2Empty(request.getParameter("pcyzdszmainid"));
	
%>
<!DOCTYPE html>
<html>
<head>
<title>法律法规</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
    
	if ($('#pcyzdszmainid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/pub/pub/queryPcyzdszmainObj', {
			pcyzdszmainid : $('#pcyzdszmainid').val()
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('form').form('load', mydata);			
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
		}, 'json');
	}
});

	// 保存 
	var submitForm = function() {
		var url = basePath + '/pub/pub/savePcyzdszMain';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#pcyzdszMainAddfm').form('submit',{
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
	};

	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
	<form id="pcyzdszMainAddfm" name="pcyzdszMainAddfm" method="post">
 		<input id="pcyzdszmainid" name="pcyzdszmainid" type="hidden" value="<%=v_pcyzdszmainid%>"/>
   			<table class="table" style="width: 600px;" >
   		    	<tr>
       		    	<td width="15%"></td>
       		     	<td width="85%"></td>
       		   	</tr>
				<tr>						
					<td style="text-align:right;">表名称:</td>
					<td>	
					  <input id="tabnamedesc" name="tabnamedesc" style="width: 400px" 
					  class="easyui-validatebox" data-options="required:true" />				
					</td>			
				</tr>
				<tr>						
					<td style="text-align:right;">列名称:</td>
					<td>	
					  <input id="colnamedesc" name="colnamedesc" style="width: 400px" 
					  class="easyui-validatebox" data-options="required:true" />				
					</td>			
				</tr>
				<tr>
					<td colspan="2" style="height: 50px;" >
				    	<div align="right">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-save" onclick="submitForm();"> 保存 </a>	
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-back" onclick="closeWindow()"> 取消 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
						</div>														     
				  	</td>
				</tr>									
			</table>
	   </form>
</body>
</html>