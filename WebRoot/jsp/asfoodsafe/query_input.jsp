<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<title>安盛追溯码查询</title>
<link rel="stylesheet"
	href="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery.mobile-1.3.2.css" />
<!-- jQuery and jQuery Mobile -->
<script src="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery-1.9.1.min.js"></script>
<script src="<%=basePath %>jslib/jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$.mobile.page.prototype.options.backBtnText = "后退";
		//表单提交
		$("#queryBtn").click(function() {
			var v_sym = $('#sym').val();
			if (v_sym.length <= 20) {
				alert('请输入有效的追溯码！');
				$('#sym').focus();
				return false;
			} else {
				$.post('<%=basePath%>/common/sjb/checkSymExist', {
					sym : v_sym
				}, 
				function(result) {
					if (result.code=='0') {
						var v_symexist=result.symexist;
						alert("点击 确定 跳到查询明细");
						if ("1"==v_symexist){
							window.location.href = '<%=basePath%>common/sjb/queryProOrClBySym?sym='+v_sym+'&weixinsym=1&time='+new Date().getMilliseconds();
						}else{
							alert("输入的溯源码不存在");
						}
					} else {
						parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
		            }	
					//parent.$.messager.progress('close');
				}, 'json');
				
			}
		});
	});
</script>
</head>
<body>
	<div data-role="page" id="page1">
		<div data-theme="b" data-role="header" data-position="fixed">
			<h3>安盛食品追溯码查询中心</h3>
		</div>

		<div role="main" class="ui-content">
			<form id="myform" method="post" action="">
				<div data-role="fieldcontain">
					<label for="firstName">溯源码：</label> <input type="text" name="sym"
						id="sym" value="2017122713245284340367916000001" />
					<h3 id="tip"></h3>
					<button data-theme="b" id="queryBtn" type="buton">查询</button>
				</div>
			</form>
		</div>

		<%@ include file="query_footer.jsp"%>
</body>
</html>