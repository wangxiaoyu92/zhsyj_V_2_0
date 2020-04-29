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
	// 作业id
	String v_homeworkId = StringHelper.showNull2Empty(request.getParameter("homeworkId"));  
%>
<!DOCTYPE html>
<html>
<head>
<title>作业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_type = [{"id":"1","text":"附件"},{"id":"2","text":"问答"}]; // 作业类型
	$(function() {
		// 作业类型
	    $("#type").combobox({
	    	data : v_type,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#type").combobox("select", "1");
        	}
	    });
	    // 如果作业id不为空
	    if ($('#homeworkId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'train/course/queryHomeworkObj', {
				'homeworkId' : $('#homeworkId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.homework;					
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
		parent.$("#"+sy.getDialogId()).dialog("close");   
	}
	// 保存课程信息
	function saveHomework() {
		var url = basePath + "train/course/saveHomework";
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
						 closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
	// 选择作业附件
	function selectHomework(){
		var url = basePath + 'jsp/train/courseware/uploadCourseWare.jsp';
		var dialog = parent.sy.modalDialog({
				title : '选择作业',
				width : 500,
				height : 440,
				url : url
		},function(dialogID) {
			var v_retStr = sy.getWinRet(dialogID);
			if(retVal != null && retVal.type == "ok"){
				$('#fjpath').val(retVal.fjpath);
				$('#fjname').val(retVal.fjname);
				$("#homeworkFjSpan").html(retVal.fjpath);
			}
		    sy.removeWinRet(dialogID);//不可缺少
		});	
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
				<input id="homeworkId" name="homeworkId" type="hidden" value="<%=v_homeworkId%>"/>
        		<sicp3:groupbox title="作业信息">
				<table class="table" style="width:98%;height: 98%">
					<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr> 
	        		<tr>
	                	<td style="text-align:right;"><nobr>作业标题:</nobr></td>
						<td colspan="3"><input id="title" name="title" 
							style="width: 600px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>作业类型:</nobr></td>
						<td><input id="type" name="type" style="width: 200px" class="easyui-combobox"/></td>
						<div style="display: none;" id="HomeWorkFjDiv">
							<td style="text-align:right;"><nobr>作业附件:</nobr></td>
							<td><input id="fjpath" name="fjpath" type="hidden">
								<input id="fjname" name="fjname" type="hidden">
								<span id="homeworkFjSpan" name="homeworkFjSpan"></span>
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="ext-icon-folder_explore" onclick="selectHomework()">选择文件上传 </a>
							</td>
						</div>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>作业满分:</nobr></td>
						<td><input id="score" name="score" style="width: 200px"
							class="easyui-validatebox" data-options="validType:'intOrFloat'"/>分</td>
						<td style="text-align:right;"><nobr>作业及格:</nobr></td>
						<td><input id="pass" name="pass" style="width: 200px"
							class="easyui-validatebox" data-options="validType:'intOrFloat'"/>分</td>
					</tr>
					<tr>
	                	<td style="text-align:right;"><nobr>作业内容(简介):</nobr></td>
						<td><textarea class="content" name="content" id="wareDes" style="width: 600px;"></textarea></td>
					</tr>
				</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveHomework()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>