<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
	String pwfxwcsid = StringHelper.showNull2Empty(request.getParameter("pwfxwcsid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>执法人员编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var v_ajdjajdl = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;

$(function(){
		//cbo绑定ajdjajdl
		v_ajdjajdl = $('#ajdjajdl').combobox({
			data : v_ajdjajdl,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});


		if ($('#pwfxwcsid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zfba/wfxw/findWfxw', {
				pwfxwcsid : $('#pwfxwcsid').val()
			}, function(result) {
				if (result.code == '0') {
					var mydata = result.data;
					$('#fm').form('load', mydata);
				} else {
					parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
				}
				parent.$.messager.progress('close');
			}, 'json');
			if ('<%=op%>' == 'view') {
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly', 'readonly');
			}
		}
	});
	
	
	

	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		url = basePath + '/zfba/wfxw/saveWfxw';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress(); // 显示进度条
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if (!isValid) {
					$pjq.messager.progress('close'); // 如果表单是无效的则隐藏进度条 
				}
				return isValid;
			},
			success : function(result) {
				$pjq.messager.progress('close');// 隐藏进度条  
				result = $.parseJSON(result);
				if (result.code == '0') {
					$pjq.messager.alert('提示', '保存成功！', 'info', function() {
						$grid.datagrid('load');
						$dialog.dialog('destroy');
					});
				} else {
					$pjq.messager.alert('提示', '保存失败：' + result.msg, 'error');
				}
			}
		});
	};

	//关闭窗口
	var closeWindow = function($dialog, $pjq) {
		$dialog.dialog('destroy');
	};
</script>
</head>
<body>    
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
       	<sicp3:groupbox title="执法人员信息">	
       		<table class="table" style="width: 99%;">
				 
				 <tr>
					<td style="text-align:right;"><nobr>违法行为参数ID</nobr></td>
					<td><input name="pwfxwcsid" id="pwfxwcsid"  style="width: 175px; " class="input_readonly" readonly="readonly" value="<%=pwfxwcsid%>"/></td>
					<td style="text-align:right;"><nobr>案件登记案件大类</nobr></td>
					<td><input id="ajdjajdl" name="ajdjajdl" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" />
					</td>				
				 </tr>
				 
				 <tr>
					<td style="text-align:right;"><nobr>违法行为编号</nobr></td>
					<td><input name="wfxwbh" id="wfxwbh"  style="width: 175px; " /></td>
				 </tr>
				 
				 <tr>
					<td style="text-align:right;"><nobr>违法行为描述</nobr></td>
					<td colspan="3"><textarea class="easyui-validatebox" id="wfxwms" name="wfxwms" style="width: 600px;" 
						 rows="5"  data-options="required:false,validType:'length[0,2000]'"></textarea></td>
								
				 </tr>				 
				 
				  <tr>
					<td style="text-align:right;"><nobr>违反法规</nobr></td>
					<td><input name="wfxwwffg" id="wfxwwffg"  style="width: 175px; " /></td>
					<td style="text-align:right;"><nobr>违反条款</nobr></td>
					<td><input id="wfxwwftk " name="wfxwwftk" style="width: 175px" /></td>				
				 </tr>
				 
				  <tr>
					<td style="text-align:right;"><nobr>违反条款内容</nobr></td>
					<td><input name="wfxwwftknr" id="wfxwwftknr"  style="width: 175px; "/></td>
					<td style="text-align:right;"><nobr>处罚法规</nobr></td>
					<td><input id="wfxwcffg " name="wfxwcffg" style="width: 175px" /></td>				
				 </tr>
				 
				 <tr>
					 <td style="text-align:right;"><nobr>处罚法规条款</nobr></td>
					<td colspan="3"><input id="wfxwcffgtk " name="wfxwcffgtk" style="width: 575px" /></td>								
				 </tr>
				 
				 <tr>
					<td style="text-align:right;"><nobr>处罚法规条款内容</nobr></td>
					<td colspan="3"><textarea class="easyui-validatebox" id="wfxwcffgtknr" name="wfxwcffgtknr" style="width: 600px;" 
						 rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea></td>
								
				 </tr>				 
				 
				 <tr>
					<td style="text-align:right;"><nobr>处罚内容</nobr></td>
					<td colspan="3"><textarea class="easyui-validatebox" id="wfxwcfnr" name="wfxwcfnr" style="width: 600px;" 
						 rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea></td>
						 				 
				 </tr>
				 <tr>
				 	<td style="text-align:right;"><nobr>备注</nobr></td>
					<td colspan="3"><textarea class="easyui-validatebox" id="wfxwbz" name="wfxwbz" style="width: 600px;" 
						 rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea>
					</td>	
				 </tr>
			</table>
        </sicp3:groupbox>
   </form>
</body>
</html>