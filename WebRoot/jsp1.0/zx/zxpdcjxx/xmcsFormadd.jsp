<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
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
<title>采集信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var systemcode  = <%=SysmanageUtil.getAa10toJsonArray("SYSTEMCODE")%>;

$(function (){ 
	 $('#systemcode,#systemcode1').combobox({
	    	data : systemcode,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    }); 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zx/zxpdcjxx/xmcs', {
				xmcsid : $('#xmcsid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;	
					$('#fr').form('load', mydata);	
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
				parent.$.messager.progress('close');
			}, 'json'); 
})

var submitForm = function($dialog, $grid, $pjq) {
	 $pjq.messager.progress();	// 显示进度条
	$('#form').form('submit',{
		url:basePath + '/zx/zxpdcjxx/addxmcs',
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
       },
       success: function(result){
       	$pjq.messager.progress('close');// 隐藏进度条  
       	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$pjq.messager.alert('提示','保存成功！','info',function(){
		 		$grid.datagrid('load');
       			$dialog.dialog('destroy');  
       		}); 	                        	                     
         	} else {
         		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
           }
       }    
	});
	}
//关闭页面
var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };
  </script>
</head>
<body>  
		<form id="form" name="form" method="post">
			<sicp3:groupbox title="信息采集">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>项目参数名称:</nobr></td>
						<td><input id="xmcsmc" name="xmcsmc" style="width: 300px"
							class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>项目参数编码:</nobr></td>
						<td><input id="xmcsbm" name="xmcsbm" style="width: 300px"
							class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>项目参数分值:</nobr></td>
						<td><input id="xmcsfz" name="xmcsfz" style="width: 300px"
							class="easyui-validatebox" data-options="required:true"></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr> 对应子系统:</nobr></td>
						<td><input id="systemcode" name="systemcode" style="width: 300px" ></td>
					</tr>
				</table>
			</sicp3:groupbox>
		</form> 
</body>
</html>