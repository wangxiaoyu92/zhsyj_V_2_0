<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
	String psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>节点时限/URL编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	
	$(function() {						
		if ($('#nodeid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/workflow/queryWfnodeDTO', {
				psbh : $('#psbh').val(),
				nodeid : $('#nodeid').val()
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
	var submitForm = function($dialog, $grid, $pjq) {
		var url = basePath + '/workflow/updateWfnode';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
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
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >    
	       	<sicp3:groupbox title="节点信息">	
	       		<table class="table" style="width: 99%;">
	       			<input name="wfnodeid" id="wfnodeid"  type="hidden" />
					<tr>
						<td style="text-align:right;"><nobr>工作流编号:</nobr></td>
						<td><input name="psbh" id="psbh"  style="width: 300px; " class="input_readonly" readonly="readonly" value="<%=psbh%>"/></td>															
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>工作流名称:</nobr></td>
						<td><input name="psmc" id="psmc"  style="width: 300px; " class="input_readonly" readonly="readonly" /></td>															
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>节点ID:</nobr></td>
						<td><input name="nodeid" id="nodeid"  style="width: 300px; " class="input_readonly" readonly="readonly" value="<%=nodeid%>"/></td>															
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>节点名称:</nobr></td>
						<td><input name="nodename" id="nodename"  style="width: 300px; " class="input_readonly" readonly="readonly" /></td>															
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>节点类型:</nobr></td>
						<td><input name="nodetype" id="nodetype"   style="width: 300px; " class="input_readonly" readonly="readonly" /></td>						
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>节点时限:</nobr></td>
						<td><input name="nodesx" id="nodesx"  style="width: 300px; " class="easyui-validatebox"  data-options="validType:'number'" /></td>
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>节点URL:</nobr></td>
						<td><input name="nodeurl" id="nodeurl"  style="width: 300px; " class="easyui-validatebox" data-options="required:true" /></td>			
					</tr>																																
				</table>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>