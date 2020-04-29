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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	// 应急小组id
	String v_groupid = StringHelper.showNull2Empty(request.getParameter("groupid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>应急小组信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
$(function() {
		if ($('#groupid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/emergency/queryEmergencyGroupDto', {
				groupid : $('#groupid').val()
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
			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');	
			}
		}
});

	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url = basePath + '/emergency/saveEmergencyGroup';;

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#emergencyAddDlgfm').form('submit',{
			url: url,
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
	};

// 关闭窗口
var closeWindow = function($dialog, $pjq){
   	$dialog.dialog('destroy');
};

</script>
</head>
<body>
	<form id="emergencyAddDlgfm" name="emergencyAddDlgfm" method="post">
       	<sicp3:groupbox title="应急小组新增信息">	
   			<table class="table" style="width: 99%;">
   				<tr>
   					<input id="groupid" name="groupid" type="hidden" value="<%=v_groupid%>"/>
	   		    	<td width="15%"></td>
	   		        <td width="35%"></td>
	   		        <td width="15%"></td>
	   		        <td width="35%"></td>
	   		    </tr>
	   		    <tr>
	   		    	<td style="text-align:right;"><nobr>应急小组名:</nobr></td>
					<td colspan="3"><input id="groupname" name="groupname" style="width: 580px;"/></td>
				</tr>
				<tr>						
					<td style="text-align:right;">备注:</td>
					<td colspan="3">
						<textarea id="remark" name="remark" style="width: 580px;" 
						 rows="5"></textarea>
					</td>			
				</tr>	
			</table>
    	</sicp3:groupbox>
	</form>
</body>
</html>