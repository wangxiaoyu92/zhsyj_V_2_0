<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>
<!DOCTYPE HTML >
<html>
<head>

<title>考生报名信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_sex = [ {
		"id" : "",
		"text" : "===请选择==="
	}, {
		"id" : "1",
		"text" : "男"
	}, {
		"id" : "2",
		"text" : "女"
	} ];
	var v_enrollIdcardType = [ {
		"id" : "",
		"text" : "===请选择==="
	}, {
		"id" : "1",
		"text" : "身份证"
	}, {
		"id" : "2",
		"text" : "护照"
	}, {
		"id" : "3",
		"text" : "其他"
	} ];
	 var v_state = [{"id":"","text":"===请选择==="},{"id":"1","text":"未审核"},{"id":"2","text":"审核中"},{"id":"3","text":"审核通过"},{"id":"4","text":"审核未通过"},{"id":"5","text":"已缴费"}]; 
	
	$(function() {
	$("#btnShenH").hide();
	$("#btnUndo").hide();
	$("#btnJiaofei").hide();
	$("#btnSave").hide();
	$("#btnJiaof").hide();
	var enrollState = $("#enrollStates").val();
	if(enrollState==2){
	$("#btnShenH").show();
	}
	if(enrollState==3){
	$("#btnSave").show();
	$("#btnJiaof").show();
	}
	if(enrollState==4){
	$("#btnUndo").show();
	}
	if(enrollState==5){
	$("#btnJiaofei").show();
	}
		// 性别
		$("#enrollSex").combobox({
			data : v_sex,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});
		// 证件类型
		$("#enrollIdcardType").combobox({
			data : v_enrollIdcardType,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});

		// 报名状态
		$("#enrollState").combobox({
			data : v_state,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});

	});
	
	function clickJiaof(){
		var v_url = basePath + "signups/signup/uodateState";
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url : v_url,
			onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
			},success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','缴费成功！','info',function(){
						sy.setWinRet("ok");
						parent.$("#"+sy.getDialogId()).dialog("close");
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','缴费失败失败：'+result.msg,'error');
                }
	        }    
			
		});
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post">
				<input type="hidden" id="enrollId" name="enrollId"
					value="${v_examUserEnroll.enrollId}"> <input type="hidden"
					id="enrollExamId" name="enrollExamId"
					value="${v_examUserEnroll.enrollExamId}">
					<input type="hidden" id="enrollStates" name="enrollStates"
					value="${v_examUserEnroll.enrollState}">
				<sicp3:groupbox title="考生报名信息">
					<table class="table" style="width:98%;height: 98%">
						<tr>
							<td style="text-align:right;"><nobr>姓名:</nobr></td>
							<td><input id="enrollName" name="enrollName"
								value="${v_examUserEnroll.enrollName}" style="width: 195px" />
							</td>
						</tr>

						<tr>
							<td style="text-align:right;"><nobr>考生性别:</nobr>
							</td>
							<td><input id="enrollSex" name="enrollSex"
								value="${v_examUserEnroll.enrollSex}" style="width: 200px"
								class="easyui-combobox" />
							</td>
						</tr>

						<tr>
							<td style="text-align:right;"><nobr>考生单位:</nobr></td>
							<td><input id="enrollUnit" name="enrollUnit"
								value="${v_examUserEnroll.enrollUnit}" style="width: 195px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>考生证件类型:</nobr>
							</td>
							<td><input id="enrollIdcardType" name="enrollIdcardType"
								value="${v_examUserEnroll.enrollIdcardType}"
								style="width: 200px" class="easyui-combobox" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>证件号码:</nobr></td>
							<td><input id="enrollIdcardNo" name="enrollIdcardNo"
								value="${v_examUserEnroll.enrollIdcardNo}" style="width: 195px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>报考考试名称:</nobr></td>
							<td><input id="enrollExamName" name="enrollExamName"
								value="${v_examUserEnroll.enrollExamName}" style="width: 195px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>状态:</nobr>
							</td>
							<td><input id="enrollState" name="enrollState"
								value="${v_examUserEnroll.enrollState}" style="width: 200px"
								class="easyui-combobox" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>备注:</nobr></td>
							<td><input id="enrollRemark" name="enrollRemark"
								value="${v_examUserEnroll.enrollRemark}" style="width: 195px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>报名时间:</nobr></td>
							<td><input id="enrollTime" name="enrollTime"
								value="${v_examUserEnroll.enrollTime}" style="width: 195px" />
							</td>
						</tr>
						<tr></tr>
					</table>
				</sicp3:groupbox>
			</form>
			<br><br>
				<div style="text-align:center">
				<a href="javascript:void(0)"  class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveAdopt()" id="btnSave">审核通过
				</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
					href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeNoAdopt()" id="btnUndo">审核不通过</a>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="javascript:void(0)"  class="easyui-linkbutton"
					iconCls="icon-save" onclick="clickJiaof()" id="btnJiaof">点击缴费
					</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="javascript:void(0)"  class="easyui-linkbutton"
					iconCls="icon-save" onclick="clickJiaofei()" id="btnJiaofei">已缴费
					</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="javascript:void(0)"  class="easyui-linkbutton"
					iconCls="icon-save" onclick="clickShenH()" id="btnShenH">审核中
					</a>
			</div>
		</div>
	</div>
</body>
</html>
