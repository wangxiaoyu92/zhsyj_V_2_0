<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_pcyzdszmainid = StringHelper.showNull2Empty(request.getParameter("pcyzdszmainid"));
	String v_pcyzdszdetailid = StringHelper.showNull2Empty(request.getParameter("pcyzdszdetailid"));
	
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
$(function() {
    $('#aae140').combobox({
    	data : v_aae140,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto' 
    });	
    
	if ($('#pcyzdszdetailid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/pub/pub/queryPcyzdszdetailObj', {
			pcyzdszdetailid : $('#pcyzdszdetailid').val()
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
	
});/////////////////////////////

	// 保存 
	var submitForm = function() {
		var url = basePath + '/pub/pub/savePcyzdszAdd';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#pcyzdszAddfm').form('submit',{
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
						closeWindow();
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
	<form id="pcyzdszAddfm" name="pcyzdszAddfm" method="post">
	  <input id="pcyzdszmainid" name="pcyzdszmainid" type="hidden" value="<%=v_pcyzdszmainid%>"/>
	  <input id="pcyzdszdetailid" name="pcyzdszdetailid" type="hidden" value="<%=v_pcyzdszdetailid %>" />
	  
       		<table class="table" style="width: 800px;">
       		   <tr>
       		     <td width="15%"></td>
       		     <td width="85%"></td>
       		   </tr>
				<tr>
					<td style="text-align:right;"><nobr>大类:</nobr></td>
					<td>	
					  <input id="aae140" name="aae140" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" />				
					</td>						
				</tr>
				<tr>						
					<td style="text-align:right;">值:</td>
					<td >
						<textarea class="easyui-validatebox" id="avalue" name="avalue" style="width: 580px;" 
						 rows="15" data-options="required:true"></textarea>
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