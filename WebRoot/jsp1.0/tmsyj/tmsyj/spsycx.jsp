<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));//食品追溯到当前商户的必传入参
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
	String t_eptbh = StringHelper.showNull2Empty(request.getParameter("eptbh"));//食品追溯的必传入参
	String t_jcypmc = StringHelper.showNull2Empty(request.getParameter("jcypmc"));
	String t_hjhbid = StringHelper.showNull2Empty(request.getParameter("hjhbid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/business.js"></script>
<script src="./js/common.js"></script>
<link href="<%=contextPath%>/jsp/gzfw/css/basic.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/style/style.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/process_images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';	
	var t_commc = '<%=t_commc%>';
	var t_eptbh = '<%=t_eptbh%>';
	var t_jcypmc = '<%=t_jcypmc%>';
	var t_hjhbid = '<%=t_hjhbid%>';
	
	$(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        $('#ywbh2').val(t_eptbh);
        $('#ywbh').html("e票通编号：" + t_eptbh);
		$('#commc').html("企业名称：" + t_commc);
		$('#jcypmc').html("溯源食品名称：" + t_jcypmc);
        query();  
    });
	
	function query() {
		var ywbh = $('#ywbh2').val();
		if (IsNull(ywbh)=='') {
			alert("请输入e票通编号！");
			return;
		}
	
    	$.ajax({
        	url: basePath + "api/tmsyj/getSpsyList",
        	type: "post",
            dataType: 'json',
            data: { eptbh : ywbh, hviewjgztid: t_comid,hjhbid:t_hjhbid },
            success: function(result){ 
            	if(result.code == '0'){
            		if (result.total > 0) {
						$("#nodelist").html("");
						var currpos = result.total;
						var mydata = result.rows;				
						var currNode = mydata[currpos-1].nodeid;
						//先生成源头节点【范围外供货商】
						var li_class = "<li class='cls inactive'>";
						var date = li_class;
						var name = "<p class='intro'>" + IsNull(result.rows[0].nodename)+ "</p></li>";
						$("#nodelist").append(date + name);
						//循环生成分销节点
						$.each(result.rows, function (index, item) {
							var date = "";
							var li_class = "<li class='cls'>";
							if (currNode == item.nodeid) {
								li_class = "<li class='cls highlight'>";
								currpos = index;
							}
							if(index>currpos){
								li_class = "<li class='cls inactive'>";
							}
							date = li_class + "<p class='date'>" + IsNull(item.aae036)+ "</p>";
							var name = "<p class='intro'>" + IsNull(item.commc)+ "</p></li>";
							$("#nodelist").append(date + name);
						});	
					} else {
						$("#nodelist").html("");
						$('#ywbh').html("e票通编号：");
						$('#commc').html("企业名称：");
						$('#jcypmc').html("溯源食品名称：");
						alert("没有查询到对应的食品分销信息！");
					}		                            	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
</script>
</head>
<body>    
	<div class="progress clearfix">
		<div class="progress_1 clearfix">
			<div class="progress_1a fl">
				<input name="ywbh" id="ywbh2" type="text" class="txt_3"  placeholder="请输入e票通编号" value="" />
			</div>
			<div class="progress_1b fl">
				<a href="javascript:query();" class="btn_3" id="query_btn">查&nbsp;询</a>
			</div>
		</div>
		<div class="progress_2">
			e票通编号说明：企业用户通过河南安盛科技股份有限公司的溯源平台或企安宝APP分销商品时，系统会分配给您一个e票通编号，如【2017051409372183423375133】。
		</div>
		<div class="h20 clear"></div>
		<div class="progress_3 clearfix">
			<div class="progress_r1">
				<span id="commc" class="progress_r1_2 fl">企业名称：</span>
				<span id="jcypmc" class="progress_r1_3 fl">溯源食品名称：</span>
				
			</div>
			<div class="progress_r1">
				<span id="ywbh" class="progress_r1_2 fl">e票通编号:</span>
				<span class="progress_r1_3 fl">e票通食品溯源说明:&nbsp;&nbsp; 
					<img src="<%=contextPath%>/jsp/gzfw/process_images/circle.png" width="20" height="20" />e票通分销节点&nbsp;&nbsp;
					<img src="<%=contextPath%>/jsp/gzfw/process_images/circle-h.png" width="20" height="20" />当前商户节点&nbsp;&nbsp;
				</span>
			</div>
			<div class="content">
				<div class="wrapper">
					<hr class="line-left" />
					<hr class="line-right" />
					<div class="main">
						<h1 class="title">
							食品溯源查询结果
						</h1>
						<div class="year">
							<h2>
								<a href="#">商品分销历程<i></i>
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
</body>
</html>