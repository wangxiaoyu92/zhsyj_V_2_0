<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
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
            <!--选项卡内容 开始-->
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">食品留样</div>
                <div id="table_1" class="table_hide" style="width:50%;" onclick="sele_show(1)">一周菜谱</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	            	<div id="noweek_sply" style="display:none;text-align:center;margin-top:20px;">本周还未上传食品留样信息</div>
	                <ul id="content"></ul>
	                <ul id="page_list"></ul>
	            </div>
	            <div id="tables_1" class="tables" style="display:none;width:100%">
                	<div id="noweek_yzcp" style="display:none;text-align:center;margin-top:20px;">本周还未上传一周菜谱信息</div>
	                <table id="weekfood" style="width:100%;margin-top: 20px;border-collapse: collapse;"  class="table table-bordered text-center">
						 <tr>
	                        <td colspan="8" style="text-align:center;"><p style="text-align:center;" id="datess"></p></td>
	                     </tr>
	                     <tr>
	                        <td style="text-align:center;font-weight:bold;">餐次\星期</td>
	                        <td style="text-align:center;font-weight:bold;">周一</td>
	                        <td style="text-align:center;font-weight:bold;">周二</td>
	                        <td style="text-align:center;font-weight:bold;">周三</td>
	                        <td style="text-align:center;font-weight:bold;">周四</td>
	                        <td style="text-align:center;font-weight:bold;">周五</td>
	                        <td style="text-align:center;font-weight:bold;">周六</td>
	                        <td style="text-align:center;font-weight:bold;">周日</td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:center;font-weight:bold;">早餐</td>
	                        <td><p style="text-align:center;" id="bf1" ></p></td>
	                        <td><p style="text-align:center;" id="bf2"></p></td>
	                        <td><p style="text-align:center;" id="bf3"></p></td>
	                        <td><p style="text-align:center;" id="bf4"></p></td>
	                        <td><p style="text-align:center;" id="bf5"></p></td>
	                        <td><p style="text-align:center;" id="bf6"></p></td>
	                        <td><p style="text-align:center;" id="bf7"></p></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:center;font-weight:bold;">中餐</td>
	                        <td><p style="text-align:center;" id="lc1"></p></td>
	                        <td><p style="text-align:center;" id="lc2"></p></td>
	                        <td><p style="text-align:center;" id="lc3"></p></td>
	                        <td><p style="text-align:center;" id="lc4"></p></td>
	                        <td><p style="text-align:center;" id="lc5"></p></td>
	                        <td><p style="text-align:center;" id="lc6"></p></td>
	                        <td><p style="text-align:center;" id="lc7"></p></td>
	                    </tr>
	                    <tr>
	                        <td style="text-align:center;font-weight:bold;">晚餐</td>
	                        <td><p style="text-align:center;" id="dn1"></p></td>
	                        <td><p style="text-align:center;" id="dn2"></p></td>
	                        <td><p style="text-align:center;" id="dn3"></p></td>
	                        <td><p style="text-align:center;" id="dn4"></p></td>
	                        <td><p style="text-align:center;" id="dn5"></p></td>
	                        <td><p style="text-align:center;" id="dn6"></p></td>
	                        <td><p style="text-align:center;" id="dn7"></p></td>
	                    </tr>
	                </table>
            	</div>
        	</div>
        	<!--选项卡内容  结束-->
        </div>
<!--         <div class="col-xs-4 col-sm-4" id="news"></div> -->
    </div>
</div>
<div id="foot"></div>		
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_comid = '<%=t_comid%>';	
   	
   	var tabs = 2;
	function sele_show(bh) {
	    for (var i = 0; i <= tabs; i++) {
	        if (i == bh) {
	            $("#table_" + i + "").addClass('table_show');//添加样式，样式名为className
	            $("#table_" + i + "").removeClass('table_hide');//删除样式，样式名为className
	            $("#tables_" + i + "").css('display', 'block');
	        } else {
	            $("#table_" + i + "").addClass('table_hide');//添加样式，样式名为className
	            $("#table_" + i + "").removeClass('table_show');//删除样式，样式名为className
	            $("#tables_" + i + "").css('display', 'none');
	        }
	    } 
	}
	
	var v_pageSize = 5;
    var options = {
        currentPage: 1,
        totalPages: 1,
        bootstrapMajorVersion: 3,
        numberOfPages: 5,
        size: "large",
        itemTexts: function (type, page, current) {
            switch (type) {
                case "first":
                    return "首页";
                case "prev":
                    return "上一页";
                case "next":
                    return "下一页";
                case "last":
                    return "尾页";
                case "page":
                    return page;
            }
        },
        tooltipTitles: function (type, page, current) {
            switch (type) {
                case "first":
                    return "首页";
                case "prev":
                    return "上一页";
                case "next":
                    return "下一页";
                case "last":
                    return "尾页";
                case "page":
                    return page + "页";
            }
        }, onPageClicked: function (e, originalEvent, type, page) {
            getSplyList(page, v_pageSize);
        }
    }
    	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getSplyList(1, v_pageSize);
        getYzcpList(1, v_pageSize);                
    });

    function getSplyList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmcy/getSplyList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		if (result.total>0) {
	                    $('#noweek_sply').hide();
	                    options.currentPage = result.currPage;
	                 	options.totalPages = result.totalPage; 
	                 	$('#content').empty();                           
	                 	$.each(result.rows, function (index, item) {
	                 		var html = "";
	                        if (index != result.rows.length - 1) {
	                        	html += "<li style=\"border-bottom:1px #999 dotted;height:135px;\">";
	                        } else {
	                            html += "<li style=\"border-bottom:1px #00a0ea solid;height:135px;\">";
	                        }
	                 		html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
	                        html += "  <tr>";
	                        html += "      <td rowspan=\"5\" width=\"140px\"  style=\"padding-right:15px;\">";
	                        html += "         <a href=\"javascript:linkToSelf('enterprise_sample_info.jsp?hsplyid=" + IsNull(item.hsplyid) + "&splysj=" + IsNull(item.splysj) + "&splyry=" + IsNull(item.splyry) + "&splypz=" + IsNull(item.splypz) + "&jccc=" + IsNull(item.jcccmc) + "&commc=" + IsNull(item.commc) + "');\"><img rel=\"" + checkImg(item.icon) + "\" src=\"" + checkImg(item.icon) + "\" style=\"height:120px;width:160px;\" class=\"jqzoom\"/></a>";
	                        html += "      </td>";
	                        html += "      <td  height=\"30px\"><a  href=\"javascript:linkToSelf('enterprise_sample_info.jsp?hsplyid=" + IsNull(item.hsplyid) + "&splysj=" + IsNull(item.splysj) + "&splyry=" + IsNull(item.splyry) + "&splypz=" + IsNull(item.splypz) + "&jccc=" + IsNull(item.jcccmc) + "&commc=" + IsNull(item.commc) + "');\" style=\"font-size:17px;color:#0000F0;text-decoration:none;font-weight:bold;\" >" + IsNull(item.jcccmc) + "</a></td>";
	                        html += " </tr>";
	                        html += " <tr>";
	                        html += "   <td  style=\"font-size:14px;vertical-align:top;\">留样名称：" + IsNull(item.splypz) + "</td>";
	                        html += " </tr>";
	                        html += " <tr>";
	                        html += "   <td  style=\"font-size:14px;vertical-align:top;height:22px;\">留样日期：" + IsNull((item.splysj)).split(" ")[0] + "</td>";
	                        html += " </tr>";
	                        html += " <tr>";
	                        html += "   <td  style=\"font-size:14px;vertical-align:top;\">留样时间：" + IsNull((item.splysj)).split(" ")[1] + "</td>";
	                        html += " </tr>";
	                        html += " <tr>";
	                        html += "   <td  style=\"font-size:14px;vertical-align:top;\">留样人：" + IsNull(item.splyry) + "</td>";
	                        html += " </tr>";
	                        html += "</table>";
	                        html += "</li>";
	                        $('#content').append(html);
	                        if (index == result.rows.length - 1) {
	                        	$('#page_list').bootstrapPaginator(options);
	                    	}
	                 	});
	                 	$(".jqzoom").imagezoom();
	                } else {
	                    $('#noweek_sply').show();
	                }           		                 	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function getYzcpList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmcy/getYzcpList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		if (result.total>0) {
	                    //$('#weekfood').show();
	                    $('#noweek_yzcp').hide();
	                    //$('#datess').html(item.startdate + '至' + item.enddate);
	                    $.each(result.rows, function (index, item) {
		                    $("#bf1").html(item.bf1);
		                    $("#bf2").html(item.bf2);
		                    $("#bf3").html(item.bf3);
		                    $("#bf4").html(item.bf4);
		                    $("#bf5").html(item.bf5);
		                    $("#bf6").html(item.bf6);
		                    $("#bf7").html(item.bf7);
		                    $("#lc1").html(item.lc1);
		                    $("#lc2").html(item.lc2);
		                    $("#lc3").html(item.lc3);
		                    $("#lc4").html(item.lc4);
		                    $("#lc5").html(item.lc5);
		                    $("#lc6").html(item.lc6);
		                    $("#lc7").html(item.lc7);
		                    $("#dn1").html(item.dn1);
		                    $("#dn2").html(item.dn2);
		                    $("#dn3").html(item.dn3);
		                    $("#dn4").html(item.dn4);
		                    $("#dn5").html(item.dn5);
		                    $("#dn6").html(item.dn6);
		                    $("#dn7").html(item.dn7);
	                    });
	                } else {
	                    //$('#weekfood').hide();
	                    $('#noweek_yzcp').show();
	                }
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
</script>
</body>
</html>