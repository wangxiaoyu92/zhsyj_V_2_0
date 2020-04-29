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
	// 试题类型
	String v_qsnType = StringHelper.showNull2Empty(request.getParameter("qsnType"));
	// 试题名称
	String v_qsnTypeTitle = StringHelper.showNull2Empty(request.getParameter("qsnTypeTitle"));
	// 试题分数  
	String v_qsnPoint = StringHelper.showNull2Empty(request.getParameter("qsnPoint"));
%>
<!DOCTYPE html>
<html>
<head>
<title>大题类型</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArrayXz("QSNLX")%>; // 试题类型
	$(function() {
		$("#qsnType").combobox({
	    	data : v_qsnInfoType,       
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	if ("<%=v_qsnType%>") {
	        		$("#qsnType").combobox("select", "<%=v_qsnType%>");
	        	} else {
					$("#qsnType").combobox("select", "1");
				}
        	}
	    });
	});
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");      
	}
	var saveType = function() {
		var v_qsnType = $("#qsnType").combobox("getValue"); // 大题类型
		var v_qsnTypeTitle = $("#qsnTypeTitle").val(); // 试题名称
		var v_qsnPoint = $("#qsnPoint").val(); // 试题分值
		
		var isValid = $("#fm").form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
		if(!isValid){
			alert( "填写数据不符合规范");
			return;
		} else {
			var retVal = {
				type : v_qsnType,
				name : v_qsnTypeTitle,
				point : v_qsnPoint
			};
			sy.setWinRet(retVal);
		 	closeAndRefreshWindow();
		}
	};
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: auto;" border="false">
        	<form id="fm" method="post">	
        		<sicp3:groupbox title="大题类型">
	        		<table class="table" style="width:98%;height: 98%">
	        		   <tr>
	        		     <td width="15%"></td>
	        		     <td width="35%"></td>
	        		     <td width="15%"></td>
	        		     <td width="35%"></td>
	        		   </tr> 
	        		   <tr>
							<td style="text-align:right;"><nobr>大题类型:</nobr></td>
							<td colspan="3"><input id="qsnType" name="qsnType"
								style="width: 200px" class="easyui-combobox" data-options="required:true" /></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>试题名称:</nobr></td>
							<td colspan="3"><input id="qsnTypeTitle" name="qsnTypeTitle" 
								value="<%=new String(v_qsnTypeTitle.getBytes("ISO-8859-1"),"GBK")%>"
								style="width: 200px" class="easyui-validatebox" data-options="required:true"/></td>
						</tr>
						<tr>
	                        <td style="text-align:right;"><nobr>试题分值(每题):</nobr></td>
							<td colspan="3"><input id="qsnPoint" name="qsnPoint" value="<%=v_qsnPoint%>"
								style="width: 200px" class="easyui-validatebox" 
								data-options="required:true,validType:'intOrFloat'" /></td>
						</tr> 
					</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveType()" id="btnSave">确定 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>