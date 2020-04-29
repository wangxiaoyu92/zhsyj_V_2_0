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
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jcxmid = StringHelper.showNull2Empty(request.getParameter("jcxmid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测项目</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function() {
		if ($('#jcxmid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'jyjc/queryJyjcxmDTO',{
				jcxmid : $('#jcxmid').val()
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
				$('.Wdate').attr('disabled',true);	
			}
		}
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存检验检测项目
	var saveJyjcxm = function($dialog, $grid, $pjq) {
		var url = basePath + 'jyjc/saveJyjcxm';

		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
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
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
        	<sicp3:groupbox title="检验检测项目">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>检测项目编码:</nobr></td>
						<td><input id="jcxmbh" name="jcxmbh" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>
						<td style="text-align:right;"><nobr>检测项目名称:</nobr></td>
						<td><input id="jcxmmc" name="jcxmmc" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>检测项目标准值:</nobr></td>
						<td><input id="jcxmbzz" name="jcxmbzz" style="width: 200px" class="easyui-validatebox"/></td>			
					</tr>
					<!-- <tr>						
						<td style="text-align:right;"><nobr>操作员姓名:</nobr></td>
						<td><input id="czyxm" name="czyxm" style="width: 200px" class="easyui-validatebox" data-options="required:true
						" /></td>		
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input id="czsj" name="czsj" style="width: 200px" class="easyui-datebox" required="required" /></td>						
					</tr> -->
				</table>
				<td><input id="jcxmid" name="jcxmid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=jcxmid%>"/></td>	
	        </sicp3:groupbox>
	   </form>
</body>
</html>