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
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String itemid = StringHelper.showNull2Empty(request.getParameter("itemid"));
	String contentid = StringHelper.showNull2Empty(request.getParameter("contentid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>项目内容</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		if ($('#contentid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'omlaw/queryContentByContent',{
				contentid : $('#contentid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：' + result.msg,'error');
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

	// 保存检查项目内容信息 
	var saveContent = function($dialog, $grid, $pjq) {
		var url = basePath + 'omlaw/saveContent';
		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){
				// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				var isValid = $(this).form('validate');
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
	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
	
</script>
</head>

<body>
	<form id="fm" method="post">
		<input id="contentid" name="contentid" hidden="true" value='<%=contentid%>'/>
		<sicp3:groupbox title="内容信息">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>项目ID</nobr></td>
					<td>
						<input id="itemid" name="itemid" style="width: 300px;"
							 class="input_readonly"  readonly="readonly"  value='<%=itemid%>'/>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>编号</nobr></td>
					<td><input id="contentcode"  name="contentcode" style="width: 300px;"
							   class="easyui-validatebox" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>排序号</nobr></td>
					<td><input id="contentsortid" name="contentsortid" style="width: 300px;"
							   class="easyui-validatebox" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">项目内容:</td>
					<td>
						<textarea class="easyui-validatebox" id="content" name="content" style="width: 300px;"
						rows="5" data-options="required:true,validType:'length[0,500]'"></textarea>
					</td>
				</tr>
			</table>
		</sicp3:groupbox>
   </form>
</body>
</html>