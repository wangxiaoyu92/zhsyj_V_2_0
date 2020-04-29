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
	String flfgtkid = StringHelper.showNull2Empty(request.getParameter("flfgtkid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>法律法规</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var flfgtkcybz = <%=SysmanageUtil.getAa10toJsonArray("FLFGTKCYBZ")%>
	var grid;
	$(function() {
		//法律法规条款常用标志
		cb_flfgtkcybz = $('#flfgtkcybz').combobox({
			data : flfgtkcybz,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
		});
		if ($('#flfgtkid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'flfg/queryPflfgtkDTO',{
				flfgtkid : $('#flfgtkid').val()
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

	// 保存法律法规信息 
	var savePflfgtk = function($dialog, $grid, $pjq) {
		var url = basePath + 'flfg/savePflfgtk';
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
        	<sicp3:groupbox title="法律法规信息">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>所属法律法规:</nobr></td>
						<td><input id="flfgid" name="flfgid" style="width: 200px" class="easyui-validatebox" data-options="required:true"/></td>						
						<td style="text-align:right;"><nobr>法律法规条款常用标志:</nobr></td>
						<td><input id="flfgtkcybz" name="flfgtkcybz" style="width: 200px" class="easyui-combobox" data-options="required:true" /></td>		
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>法律法规条款:</nobr></td>
						<td colspan="3">
							<input id="flfgtkxm" name="flfgtkxm" style="width: 600px" class="easyui-validatebox" data-options="required:true" />
						</td>			
					</tr>
					<tr>						
						<td style="text-align:right;">法律法规条款内容:</td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="flfgtknr" name="flfgtknr" style="width: 600px;" 
						 	rows="5" data-options="required:false,validType:'length[0,500]'"></textarea>
						</td>			
					</tr>	
				</table>
				<td><input id="flfgtkid" name="flfgtkid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=flfgtkid%>"/></td>	
	        </sicp3:groupbox>
	   </form>
</body>
</html>