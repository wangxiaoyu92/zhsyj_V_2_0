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
	// 成员关系表id
	String v_etpid = StringHelper.showNull2Empty(request.getParameter("etpid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>突发事件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
$(function() {
		$('#userkind').combobox({
	    	data:userkind,      
	        valueField:'id',   
	        textField:'text',
	        required:false,
	        editable:false,
	        panelHeight:'auto' 
	    });
		if ($('#etpid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/emergency/queryEmergencyGroupPersonDTO', {
				etpid : $('#etpid').val(),
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
	var url = basePath + '/emergency/saveEmergencyGroupPerson';
	$.messager.progress();	// 显示进度条
	$('#emergencyGroupPersonfm').form('submit',{
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
        			window.returnValue="ok";
					window.close();   
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','保存失败：'+result.msg,'error');
               }
        }    
	});
};

// 关闭窗口
var closeWindow = function($dialog, $pjq){
   	$dialog.dialog('destroy');
};

</script>
</head>
<body>
	<form id="emergencyGroupPersonfm" name="emergencyGroupPersonfm" method="post">
       	<sicp3:groupbox title="应急小组成员详细信息">	
   			<table class="table" style="width: 99%;">
   				<tr>
   					<input id="etpid" name="etpid" type="hidden" value="<%=v_etpid%>"/>
	   		    	<td width="15%"></td>
	   		        <td width="35%"></td>
	   		        <td width="15%"></td>
	   		        <td width="35%"></td>
	   		    </tr>
	   		    <tr>
	   		    	<td style="text-align:right;"><nobr>用户名:</nobr></td>
					<td><input id="username" name="username" style="width: 200px;" 
						class="input_readonly" readonly="readonly"/></td>
						<td style="text-align:right;" ><nobr>用户描述:</nobr></td>
					<td><input id="description" name="description" style="width: 200px" 
						class="input_readonly" readonly="readonly"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>用户手机号:</nobr></td>
					<td><input id="mobile" name="mobile" style="width: 200px"
						class="input_readonly" readonly="readonly"/>
					</td>	
					<td style="text-align:right;" ><nobr>组织名:</nobr></td>
					<td><input id="orgname" name="orgname" style="width: 200px" 
						class="input_readonly" readonly="readonly"/></td>					
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>用户类别:</nobr></td>
					<td><input id="userkind" name="userkind" style="width: 200px;"
						class="input_readonly" readonly="readonly"/></td>
					<td style="text-align:right;" ><nobr>成员类型:</nobr></td>
					<td><input id="etptype" name="etptype" style="width: 200px" /></td>	
				</tr>
				<tr>						
					<td style="text-align:right;">备注:</td>
					<td colspan="3">
						<textarea id="etpremark" name="etpremark" style="width: 580px;" 
						 rows="5"></textarea>
					</td>			
				</tr>	
				<tr>
				  <td colspan="4" style="height: 50px;" >
				    <div align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-save" onclick="submitForm();"> 保存 </a>	
							&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-back" onclick="javascript:window.close();"> 取消 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					</div>														     
				  </td>
				</tr>			
			</table>
    	</sicp3:groupbox>
	</form>
</body>
</html>