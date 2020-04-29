<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "从业人员信息公示";
	String t_ryid = StringHelper.showNull2Empty(request.getParameter("ryid"));
	String t_ryxm = StringHelper.showNull2Empty(request.getParameter("ryxm"));
	String t_ryzt = StringHelper.showNull2Empty(request.getParameter("ryzt"));
	String t_ryzwgw = StringHelper.showNull2Empty(request.getParameter("ryzwgw"));
	String t_rybeginwork = StringHelper.showNull2Empty(request.getParameter("rybeginwork"));
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
<link href="./css/bootstrap-combined.min.css" rel="stylesheet">
<script src="./js/bootstrap-paginator.js"></script>
<link href="./css/style.css" rel="stylesheet">
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<script src="./js/jquery.imagezoom.js"></script>
<link href="./css/imagezoom.css" rel="stylesheet">
</head>
<body>
<div id="top"></div>	
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
        	<h3 style="font-weight:bold;font-size:20px;margin-top:5px;text-align:center;" id="title"></h3>
            <pre style="font-size:13px;margin-top:5px;padding-top:5px;text-align:left;" id="summary"></pre>
            <div id="tables_0" class="tables" style="display:block;width:100%">
                <table width="100%" align="center">
                	<tr>
	                	<td style="text-align:center"><img id="jkzm" style="width:316px; height:222px;" rel="images/kong.jpg" src="images/kong.jpg" class="jqzoom" /></br></br>健康证明</td>
	                	<td style="text-align:center"><img id="pxhgz" style="width:316px; height:222px;" rel="images/kong.jpg" src="images/kong.jpg" class="jqzoom" /></br></br>食品安全培训合格证</td>
                	</tr>
                </table>
            </div>            
        </div>
<!--         <div class="col-xs-4 col-sm-4" id="news"></div> -->
    </div>
</div>
<div id="foot"></div>		
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_ryid = '<%=t_ryid%>';	
   
	var v_pageSize = 10;	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        } 
        getFjList(1, v_pageSize);                
    });

    function getFjList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getFjList",
        	type: "post",
            dataType: 'json',
            data: { fjwid: t_ryid, fjtype: '5,6' },
            success: function(result){ 
            	if(result.code == '0'){
            		$('#title').append('<%=t_ryxm%>');
                    var html = "";
                    html += "<table width=90% align='center' style=\"font-size:13px;font-size:14px;line-height:25px\">";
                    html += "<tr>";
//                     html += "<td width=100 style='text-align:right'>就业时间：</td>";
//                     html += "<td>" + '<%=t_rybeginwork%>' + "</td>";
                    html += "<td width=100 style='text-align:right'>职务：</td>";
                    html += "<td>" + '<%=t_ryzwgw%>' + "</td>";
                    html += "<td style='text-align:right'>在职状态：</td>";
                    html += "<td>" + '<%=t_ryzt%>' + "</td>";
                    html += "</tr>";
            		html += "</table>";
                    $('#summary').append(html);                           
                 	$.each(result.rows, function (index, item) {
                 		var fjpath = checkImg(item.fjpath);     
                    	if (item.fjtype == "5"){
		                    $('#jkzm').attr('src', fjpath);
		                    $('#jkzm').attr('rel', fjpath);
		                }
		                if (item.fjtype == "6") {
		                    $('#pxhgz').attr('src', fjpath);
		                    $('#pxhgz').attr('rel', fjpath);
		                }
                 	});
                 	$(".jqzoom").imagezoom();                 	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
</script>
</body>
</html>