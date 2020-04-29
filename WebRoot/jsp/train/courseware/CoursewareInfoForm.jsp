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
	// 课件id
	String v_wareId = StringHelper.showNull2Empty(request.getParameter("wareId")); 
%>

<!DOCTYPE html>
<html>
<head>
<title>课件信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
	var v_wareSource = <%=SysmanageUtil.getAa10toJsonArray("KJLY")%>; // 课件来源
	var v_wareCategory = <%=SysmanageUtil.getAa10toJsonArray("KJFL")%>; // 课件分类
	var v_wareType = <%=SysmanageUtil.getAa10toJsonArrayXz("KJLX")%>; // 课件类型
	$(function() {
		loadCombobox(); // 加载下拉列表框
		// 加载试题内容
	    if ($('#wareId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'train/courseware/queryCoursewareObj', {
				wareId : $('#wareId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.courseware;
					$("#wareVideoSpan").html(mydata.wareVideo);
					$("#wareVideo").val(mydata.wareVideo);		
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	// 加载下拉框
	function loadCombobox() {
		// 课件来源下拉框
		$("#wareSource").combobox({
			data : v_wareSource,      
			valueField : 'id',   
			textField : 'text',
			required : false,
			editable : false,
			panelHeight:'auto'
		});
		//课件分类下拉框
		$("#wareCategory").combobox({
			data : v_wareCategory,      
			valueField : 'id',   
			textField : 'text',
			required : false,
			editable : false,
		    panelHeight:'auto'
		});
		// 课件类型下拉框
		$("#wareType").combobox({
			data : v_wareType,     
			valueField : 'id',   
			textField : 'text',
			required : false,
			editable : false,
			panelHeight:'auto',
			onLoadSuccess: function(){
	        	$("#wareType").combobox("select", "1");
        	}
		});
		// 课件状态下拉框
		$("#wareStatus").combobox({
			data : [{"id":"0","text":"启用"},{"id":"1","text":"禁用"}], // 课程状态,0:启用 1:禁用    
			valueField : 'id',   
			textField : 'text',
			required : false,
			editable : false,
		    panelHeight:'auto',
		    onLoadSuccess: function(){
	        	$("#wareStatus").combobox("select", "0");
        	}
		});
	}
	
	// 保存课件
	function saveCoursewareInfo(){
		
		var v_url = basePath + "train/courseware/saveCoursewareInfo";
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url : v_url,
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
	function closeAndRefreshWindow(){
		var s = "ok";
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
	
	// 选择课件
	function selectWare(){
		var v_wareType = $('#wareType').combobox('getValue');
		var url = basePath + "jsp/train/courseware/uploadCourseWare.jsp?wareType=" + v_wareType;
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '附件管理',
			width : 500,
			height : 440,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if(obj != null && obj.type == "ok"){
				$('#fjpath').val(obj.fjpath);
				$('#fjname').val(obj.fjname);
				$("#wareVideoSpan").html(obj.fjpath);
				$("#wareVideo").val(obj.fjpath);
				if (v_wareType == 1) { // 如果是视频文件，默认转换为flv格式的
					converFile(obj.fjpath); // 转换文件格式
				}
			}
		});
	}
	// 转换文件格式（默认视频文件格式为flv）
	function converFile(filePath) {
		/* parent.$.messager.progress({
			text : '格式转换中....'
		}); */
		$.post(basePath + 'train/courseware/converFile', {
			wareType : $("#wareType").combobox('getValue'), 
			warePath : $("#fjpath").val()
		}, 
		function(result) {
			if (result.code == '0') {
				// parent.$.messager.alert('提示', '转换成功', 'info');
			} else {
			 	// parent.$.messager.alert('提示', '转换失败!' + result.msg, 'error');
            }	
			// parent.$.messager.progress('close');
		}, 'json');
	}
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post" >	
				<input id="wareId" name="wareId" type="hidden" value="<%=v_wareId%>"/>
        		<sicp3:groupbox title="课件信息">
					<table class="table" style="width:98%;height: 98%">
						<tr><td width="10%"></td><td width="40%"></td><td width="10%"></td><td width="40%"></td></tr> 
		        		<tr>
		                	<td style="text-align:right;"><nobr>课件名称:</nobr></td>
							<td colspan="3"><input id="wareName" name="wareName" 
								style="width: 600px" class="easyui-validatebox" data-options="required:true" /></td>
						</tr>
						<tr>
		                	<td style="text-align:right;"><nobr>课件学时:</nobr></td>
							<td><input id="wareLength" name="wareLength" style="width: 200px" 
								class="easyui-validatebox" data-options="validType:'intOrFloat'" /></td>
								
							<td style="text-align:right;"><nobr>课件学分:</nobr></td>
							<td><input id="warePoint" name="warePoint" style="width: 200px" 
								class="easyui-validatebox" data-options="validType:'intOrFloat'" /></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>课件类型:</nobr></td>
							<td><input id="wareType" name="wareType" style="width: 200px" 
								class="easyui-combobox"/></td>
							<td style="text-align:right;"><nobr>课件状态:</nobr></td>
							<td><input id="wareStatus" name="wareStatus" style="width: 200px" 
								class="easyui-combobox"/></td>
						</tr>   
						<tr>
		                	<td style="text-align:right;"><nobr>课件来源:</nobr></td>
							<td><input id="wareSource" name="wareSource" style="width: 200px" 
								class="easyui-combobox" /></td>
							<td style="text-align:right;">课件分类:</td>
							<td><input id="wareCategory" name="wareCategory" style="width: 200px" 
								class="easyui-combobox"/></td>
						</tr>
						<tr >
		                	<td style="text-align:right;"><nobr>上传课件:</nobr></td>
							<td colspan="3">
								<span id="wareVideoSpan" name="wareVideoSpan"></span>
								<input id="wareVideo" name="wareVideo" type="hidden">
								<input id="fjpath" name="fjpath" type="hidden">
								<input id="fjname" name="fjname" type="hidden">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="ext-icon-folder_explore" onclick="selectWare()">选择文件上传 </a>
							</td>
						</tr>
					</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="课件讲义">
        			<div style="overflow: auto;">
			        	<textarea class="ckeditor" name="wareDes" id="wareDes" style="width: 950px;" rows="5"></textarea>
					</div>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveCoursewareInfo()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>