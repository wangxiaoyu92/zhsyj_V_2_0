<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.askj.tmsyj.tmsyj.entity.Hjyjczb,com.askj.tmsyj.tmsyj.entity.Hjyjcmxb" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<%
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));//食品追溯到当前商户的必传入参
	String t_eptbh = StringHelper.showNull2Empty(request.getParameter("eptbh"));//食品追溯的必传入参
	String t_hjhbid = StringHelper.showNull2Empty(request.getParameter("hjhbid"));
	// 产品检测信息
	Hjyjczb v_productJcInfo = (Hjyjczb)request.getAttribute("jcZbInfo");
	// 产品检验检测明细信息
	List<Hjyjcmxb> v_mxlist = (List<Hjyjcmxb>)request.getAttribute("jcMxList");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script src="<%=contextPath%>/jsp/tmsyj/tmsyj/js/jquery-1.12.0.min.js"></script>
<script src="<%=contextPath%>/jsp/tmsyj/tmsyj/js/common.js"></script>
<link href="<%=contextPath%>/jsp/gzfw/css/basic.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/style/style.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/process_images/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/jsp/pub/spsy/css/index.css">
<script src="<%=contextPath%>/jsp/pub/spsy/js/flexible.js"></script>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_comid = '<%=t_comid%>';
	var t_eptbh = '<%=t_eptbh%>';
	var t_hjhbid = '<%=t_hjhbid%>';
	
	$(function () {
        $('#ywbh').html("e票通编号：" + t_eptbh);
        query();
    });
	
	function query() {
    	$.ajax({
        	url: basePath + "api/tmsyj/getSpsyList",
        	type: "post",
            dataType: 'json',
            data: { eptbh : t_eptbh, hviewjgztid: t_comid,hjhbid:t_hjhbid },
            success: function(result){ 
            	if(result.code == '0'){
            		if (result.total > 0) {
						$("#nodelist").html("");
						var currpos = result.total;
						var mydata = result.rows;
						$('#jcypmc').html("溯源食品名称：" + result.rows[0].jcypmc);
						$('#commc').html("企业名称：" + result.rows[0].commc);
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
		<div class="progress_3 clearfix">
			<div class="progress_r1">
				<span id="commc" class="progress_r1_2 fl">企业名称：</span>
				<span id="jcypmc" class="progress_r1_3 fl">溯源食品名称：</span>
			</div>
			<div class="progress_r1">
				<span id="ywbh" class="progress_r1_2 fl">e票通编号:</span>
				<span class="progress_r1_3 fl">e票通食品溯源说明:&nbsp;&nbsp; 
					<img src="<%=contextPath%>/jsp/gzfw/process_images/circle.png"
						 width="20" height="20" />e票通分销节点&nbsp;&nbsp;
					<img src="<%=contextPath%>/jsp/gzfw/process_images/circle-h.png"
						 width="20" height="20" />当前商户节点&nbsp;&nbsp;
				</span>
			</div>
			<div class="content" style="min-height: auto;">
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
	<div class="box">
		<%
			if (v_productJcInfo != null){
		%>
		<div class="empty"> 产品检验检测信息 </div>
		<div class="cont">
			<table class="table padd">
				<tbody>
				<tr><td>检测主体名称</td><td><p><%=v_productJcInfo.getHviewjgztmc()%></p></td></tr>
				<tr><td>e票通编号</td><td><p><%=v_productJcInfo.getEptbh()%></p></td></tr>
				<tr><td>商品名称</td><td><p><%=v_productJcInfo.getJcypmc()%></p></td></tr>
				<tr><td>检测机构名称</td><td><p><%=v_productJcInfo.getJcorgmc()%></p></td></tr>
				<tr><td>检验检测报告编号</td><td><p><%=v_productJcInfo.getJyjcbgbh()%></p></td></tr>
				</tbody>
			</table>
		</div>
		<% }%>

		<%
			if (v_mxlist != null && v_mxlist.size() > 0){
		%>
		<div class="empty"> 产品检验检测明细信息 </div>
		<%
				for (int k = 0; k < v_mxlist.size(); k++) {
					Hjyjcmxb v_mx = (Hjyjcmxb)v_mxlist.get(k);
		%>
		<table class="table padd">
			<tbody>
			<tr><td>检测项目</td><td><p><%=v_mx.getJcxmmc()%></p></td></tr>
			<tr><td>检测值</td><td><p><%=v_mx.getJcz()%></p></td></tr>
			<tr><td>检测结论</td><td><p><%="1".equals(v_mx.getJyjcjl()) ? "合格" : "不合格"%></p></td></tr>
			<tr><td>限量标准</td><td><p><%=v_mx.getXlbz()%></p></td></tr>
			<tr><td>标准值</td><td><p><%=v_mx.getBzz()%></p></td></tr>
			</tbody>
		</table>
		<%		}
			}
		%>
	</div>
</body>
</html>