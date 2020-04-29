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
	// 教师id
	String v_teacherId = StringHelper.showNull2Empty(request.getParameter("teacherId"));  
%>
<!DOCTYPE html>
<html>
<head>
<title>教师信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_sex = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>; // 人员性别
	var v_teacherType = [{"id":"0","text":"外部讲师"},{"id":"1","text":"内部讲师"}]; 
	$(function() {
		$("#teacherSex").combobox({
	    	data : v_sex,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 教师类别
		$("#teacherType").combobox({
	    	data : v_teacherType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#teacherType").combobox("select", "0");
        	}
	    });
	    // 如果教师id不为空
	    if ($('#teacherId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'train/teacher/queryTeacherObj', {
				'teacherId' : $('#teacherId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.teacherInfo;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：' + result.msg, 'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";
		sy.setWinRet(s);
		closeWindow();
	}
	// 保存教师信息
	function saveTeacher() {
		var url = basePath + "train/teacher/saveTeacher";
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
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
	}

	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
        		<sicp3:groupbox title="教师信息">
				<table class="table" style="width:98%;height: 98%">
					<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr> 
	        		<tr>
	                	<td style="text-align:right;"><nobr>教师id:</nobr></td>
						<td><input id="teacherId" name="teacherId" style="width: 200px" value="<%=v_teacherId%>"
							class="input_readonly" readonly="readonly"/></td>
						<td style="text-align:right;"><nobr>类别:</nobr></td>
						<td><input id="teacherType" name="teacherType" style="width: 200px" 
							class="easyui-combobox"/></td>
					</tr>
	        		<tr>
	                	<td style="text-align:right;"><nobr>教师名称:</nobr></td>
						<td colspan="3"><input id="teacherName" name="teacherName" 
							style="width: 600px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>年龄:</nobr></td>
						<td><input id="teacherAge" name="teacherAge" style="width: 200px" 
							class="easyui-validatebox" data-options="validType:'integer'"/></td>
						<td style="text-align:right;"><nobr>性别:</nobr></td>
						<td><input id="teacherSex" name="teacherSex" style="width: 200px" 
							class="easyui-combobox"/></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>讲师:</nobr></td>
						<td><input id="teacherPositional" name="teacherPositional" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>联系方式:</nobr></td>
						<td><input id="teacherTel" name="teacherTel" style="width: 200px" 
							class="easyui-validatebox" data-options="validType:'phoneAndMobile'" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>微博:</nobr></td>
						<td><input id="teacherWeibo" name="teacherWeibo" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>博客:</nobr></td>
						<td><input id="teacherBlog" name="teacherBlog" style="width: 200px" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>邮箱:</nobr></td>
						<td><input id="teacherEmail" name="teacherEmail" style="width: 200px"
							class="easyui-validatebox" data-options="validType:'email'" /></td>
						<td style="text-align:right;"><nobr>生日:</nobr></td>
						<td><input id="teacherBirthday" name="teacherBirthday" 
							class="easyui-datebox" style="width: 200px" /></td>
					</tr>
					<tr>
                        <td style="text-align:right;"><nobr>描述:</nobr></td>
						<td colspan="3"><textarea id="teacherDes" name="teacherDes" 
							style="width: 600px; height: 50px;"></textarea></td>
					</tr> 
					<tr>
	                	<td style="text-align:right;"><nobr>地址:</nobr></td>
						<td colspan="3"><input id="teacherAddr" name="teacherAddr" style="width: 600px"/></td>
					</tr>
				</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveTeacher()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>