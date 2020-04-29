<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
	String t_pgzpjid = StringHelper.showNull2Empty(request.getParameter("pgzpjid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/business.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<link href="./css/style.css" rel="stylesheet">
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<%-- 新闻编辑器 --%>
<script src="<%=contextPath %>/jslib/ckeditor/ckeditor.js" type="text/javascript" charset="utf-8"></script> 
</head>
<body>
<div style="width:95%; margin-top:20px;text-align:center;">
	<div style="margin-left:20px;">
		<table style="width:100%;text-align:center;" id="pjcs"></table>
	</div>
</div>
<div style="width:95%; padding-top:20px; margin-left:20px;">		
	<table id="content" style="width:100%;">
		<tr>
			<!-- <td>评价标题:<span id='pjbt'></span></td>	 -->		
			<td>评价人:<span id='pjr'></span></td>			
			<td>评价时间:<span id='pjsj'></span></td>			
		</tr>
	</table>
	<!-- <div id="pj_info" style='padding-top:5px;'>
		<textarea class="ckeditor" id="content" name="content" style="width: 750px; height: 250px;"></textarea>
	</div> -->
	<div id="pjdiv1" style="margin:15px 15px;text-align:left;">
        <h4 style="font-size:14px;font-weight:bold;text-align:left;">企业回复</h4>
        <div id="qypj"></div>
    </div>
    <div id="pjdiv2" style="margin:15px 15px;text-align:left;">
        <h4 style="font-size:14px;font-weight:bold;text-align:left;">监管单位回复</h4>
        <div id="jgpj"></div>
    </div>
</div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';	
	var t_pgzpjid = '<%=t_pgzpjid%>';
	
	$(function () {
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
		
        $("#pjdiv1").hide();
    	$("#pjdiv2").hide();
    	
    	getPgzpjmxList();
    });
    
    function getPgzpjmxList() {
    	$.ajax({
        	url: basePath + "api/tmsyj/getPgzpjmxList",
        	type: "post",
            dataType: 'json',
            data: { pgzpjid: t_pgzpjid },
            success: function(result){ 
            	if(result.code == '0'){
            		$('#pjcs').empty();       
                    $.each(result.rows, function (index, item) {
                    	var html = "";
						html += "<tr class=\"pjcsItem\">";
						html += "   <td style=\"font-size:20px;color:red;\">" + item.pjcsmc + "</td>";
						html += "	<td>";
						html += "		<table class=\"pjxj\" id='" + item.pjcs + "'>";
						html += "			<tr>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td class='tjpjpl'>请选择评分</td>";
						html += "			</tr>";
						html += "		</table>";
						html += "	</td>";
	                    html += "</tr>";	                    
	                    $("#pjcs").append(html);                    	
                   		showStar(item.pjcs,item.pjxj-1);                                     	
                    });
                    // $("#pjbt").html(result.rows[0].pjbt);
                    $("#pjr").html(result.rows[0].pjr);
                    $("#pjsj").html(result.rows[0].pjsj);
                    // CKEDITOR.instances.content.setData(result.rows[0].pjnr);
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }    
</script>
</body>
</html>