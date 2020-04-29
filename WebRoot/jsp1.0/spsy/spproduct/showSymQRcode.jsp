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
	String v_qsymscmxbid = StringHelper.showNull2Empty(request.getParameter("qsymscmxbid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>企业二维码管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		if ($('#qsymscmxbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'spsy/spproduct/querySymQrcode',{
				qsymscmxbid : $('#qsymscmxbid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
	            //var qrcodecontent = $("#qrcodecontent").val();
	            var tpname = $("#qrcodepath").val();
	            if (tpname != "") {
	            	$("#qrcodeimg").attr("src", "<%=basePath%>"+tpname);
	            } else {
	            	$("#qrcodeimg").attr("src", "<%=basePath%>images/default.jpg");
	            }
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
</script>
</head>
<body>
<form id="fm" method="post">
	<sicp3:groupbox title="二维码">
	<input type="hidden"  id="qrcodepath" name="qrcodepath">
	<input type="hidden"  id="qsymscmxbid" name="qsymscmxbid" value="<%= v_qsymscmxbid %>">
   		<table class="table" style="width: 90%;">
			<tr>
				<td>
				    <div style="width:380px;height:380px;" id="comqrcode_div">
				    	<img name="qrcodeimg" id="qrcodeimg" height="200" width="200" />
				   	</div>
	    	    </td>
			</tr>
		</table>
	</sicp3:groupbox>
</form>
</body>
</html>