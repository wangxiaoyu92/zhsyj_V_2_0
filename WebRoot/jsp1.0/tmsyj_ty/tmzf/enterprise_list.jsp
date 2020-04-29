<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
    String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));//搜索专用
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
<!--         <div class="col-xs-12 col-sm-12" style="text-align:center;"> -->
        <div class="col-xs-12 col-sm-12" style="overflow: hidden;">
            <div id="area"></div>
            <div style="width:96%;margin-left:15px;text-align:center">
                <ul id="content"></ul>
                <ul id="page_list"></ul>
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
    var t_commc = '<%=t_commc%>';
   
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
            getZfajList(page, v_pageSize, t_aaa027);
        }
    }
    
    $(function () {        
        if (t_commc == "") {         
	        if (t_currlocation != '') {
	            $('#currlocation').html('当前位置：' + t_currlocation);
	        } 
        } else {            
	        $('#currlocation').html('当前位置：搜索  >>"' + t_commc + '"');	                
        } 
    });

    function getZfajList(page,pageSize,t_aaa027) {
    	$.ajax({
        	url: basePath + "api/tmzf/getZfajList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, aaa027: t_aaa027, commc: t_commc, ajdjbh: t_commc },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage;                            
                	$('#content').empty();
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
                     	var g_img = "";
	                    var g_txt = "";
	                    var h_img = "";
	                    var h_txt = "";
                     	if (index != result.rows.length - 1) {
                        	html += "<li style=\"border-bottom:1px #999 dotted;\">";
                     	} else {
                        	html += "<li style=\"border-bottom:1px #00a0ea solid;\">";
                     	}
                     	html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                     	html += " <tr>";
                     	html += "   <td rowspan=\"3\" style=\"margin-right:5px;\">";
                     	html += "         <a href=\"javascript:linkToSelf('enterprise_list_info.jsp?comid=" + item.comid + "&commc="+ item.commc + "&ajdjbh="+ item.ajdjbh + "&ajdjid="+ item.ajdjid +  "');\"><img src=\"images/syj_guohui_xiao.png\" style=\"height:30px;width:30px;\"/></a>";
                     	html += "   </td>";
                     	html += "   <td><a href=\"javascript:linkToSelf('enterprise_list_info.jsp?comid=" + item.comid + "&commc="+ item.commc + "&ajdjbh="+ item.ajdjbh + "&ajdjid="+ item.ajdjid + "');\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">案件登记编号："  + IsNull(item.ajdjbh) + "</a></td>";
//                      	html += "   <td><img src=\"images/syj_guohui_xiao.png\" style=\"height:30px;width:30px;margin-right:10px;\"/><a href=\"javascript:linkToSelf('enterprise_list_info.jsp?comid=" + item.comid + "&commc="+ item.commc + "&ajdjbh="+ item.ajdjbh + "&ajdjid="+ item.ajdjid + "');\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">案件登记编号："  + IsNull(item.ajdjbh) + "</a></td>";
                     	html += " </tr>";
                     	html += " <tr>";
                     	html += "   <td  style=\"font-size:14px;\">案件处理对象：" + IsNull(item.commc) + "</td>";
                     	html += " </tr>";
//                      	html += " <tr>";
//                      	html += "   <td  style=\"font-size:14px;\">法人业主：" + IsNull(item.comfrhyz) + "</td>";
//                      	html += " </tr>";
//                      	html += " <tr>";
//                      	html += "   <td  style=\"font-size:14px;\">案件状态：" + IsNull(item.ajztinfo) + "</td>";
//                      	html += " </tr>";
                     	html += "</table>";
                     	html += "</li>";
                     	$('#content').append(html);
                     	if (index == result.rows.length - 1) {
                        	$('#page_list').bootstrapPaginator(options);
                    	}
                 	});
                    if (result.total<=0){
                        var html = "";
                        html += "<li style=\"border-bottom:1px #00a0ea solid;height:135px;\">";
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += "     <td rowspan=\"5\" width=\"140px\" style=\"padding-right:15px;\">";
                        html += "         <img src=\"images/kong.jpg\" style=\"height:120px;width:160px;\" />";
                        html += "     </td>";
                        html += "     <td  style=\"font-size:14px;\">没有查询到符合条件的记录，如有疑问请联系系统管理员！</td>";                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#content').append(html);
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