<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,java.util.*" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<link href="<%=contextPath%>/jsp/gzfw/css/basic.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-1.7.2.min.js"></script>
<link href="process_images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function query(){
	var ywbh = $('#ywbh2').val();
	if ('' == ywbh || null == ywbh) {
		alert("请输入受理编号查询！");
		return;
	}

	$.post('<%=contextPath%>/workflow/queryYwlclogList', {
		ywbh : ywbh
	}, function(result) {
		if (result.code=='0') {
			var mydata = result.data;	
			if (result.count == '0') {
				alert("没有对应的受理信息，请重新输入受理编号。");
				$('#ywbh').html("受理编号：");
				$('#commc').html("企业名称：");
				$("#nodelist").html("");
			} else {
				$('#ywbh').html("受理编号：" + mydata[0].ywbh);
				$('#commc').html("企业名称：" + mydata[0].commc);
				$("#nodelist").html("");
				var currpos = result.count;				
				var currNode = mydata[currpos-1].nodeid;
				$.each(result.data, function(i, item) {
					var date = "";
					var li_class = "<li class='cls'>";
					if (currNode == item.nodeid) {
						li_class = "<li class='cls highlight'>";
						currpos = i;
					}
					if(i>currpos){
						li_class = "<li class='cls inactive'>";
					}
					date = li_class + "<p class='date'>" + item.aae036+ "</p>";
					var name = "<p class='intro'>" + item.nodename+ "</p></li>";
					$("#nodelist").append(date + name);
				});	
			}		
		} else {
			$.messager.alert('提示','查询失败：' + result.msg,'error');
        }	
	}, 'json');
}

</script>
</head>
<body>
<div class="clear"></div>

	<div class="progress clearfix">
		<div class="progress_1 clearfix">
			<div class="progress_1a fl">
				<input name="ywbh" id="ywbh2" type="text" class="txt_3"  value="2016051015104065433721127" onclick="" />
			</div>
			<div class="progress_1b fl">
				<a href="javascript:query();" class="btn_3" id="query_btn">查&nbsp;询</a>
			</div>
		</div>
		<div class="progress_2">
			受理号说明：当您办理案件登记时，系统会分配给您一个受理号，如“2016051015104065433721127”。
		</div>
		<div class="h20 clear"></div>
		<div class="progress_3 clearfix">
			<div class="progress_r1">
				<span id="ywbh" class="progress_r1_2 fl">受理号:</span>
				<span id="commc" class="progress_r1_3 fl">企业名称：</span>
			</div>
			<div class="progress_r1">
				<span>案件办理进度说明:&nbsp;&nbsp; </span>
				<img src="process_images/circle.png" width="20" height="20" />已办理节点&nbsp;&nbsp;
				<img src="process_images/circle-h.png" width="20" height="20" />当前所在节点&nbsp;&nbsp;
			</div>
			<div class="content">
				<div class="wrapper">
					<hr class="line-left" />
					<hr class="line-right" />
					<div class="main">
						<h1 class="title">
							进度查询结果
						</h1>
						<div class="year">
							<h2>
								<a href="#">案件办理历程<i></i>
								</a>
							</h2>
							<div class="list">
								<ul id="nodelist">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="h40 clear"></div>

</body>
</html>