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
    var t_comid = '<%=t_comid%>';
   
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
            getYlcgtmList(page, v_pageSize);
        }
    }
    
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getYlcgtmList(1, v_pageSize); 
    });

    function getYlcgtmList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getYlcgtmList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, hviewjgztid: t_comid },
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
                        	html += "<li style=\"border-bottom:1px #999 dotted;height:135px;\">";
                     	} else {
                        	html += "<li style=\"border-bottom:1px #00a0ea solid;height:135px;\">";
                     	}
                     	html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                     	html += " <tr>";
                     	html += "     <td rowspan=\"5\" width=\"140px\" style=\"padding-right:15px;\">";
                     	html += "         <a href=\"javascript:linkToSelf('ylcgtm_info.jsp?hviewjgztid=" + IsNull(item.hviewjgztid) + "&hjhbid="+ IsNull(item.hjhbid) + "&jhgysid="+ IsNull(item.jhgysid) +  "');\"><img src=\"" + checkImg(item.icon) + "\" style=\"height:120px;width:160px;\" /></a>";
                     	html += "     </td>";
                     	html += "     <td><a href=\"javascript:linkToSelf('ylcgtm_info.jsp?hviewjgztid=" + IsNull(item.hviewjgztid) + "&hjhbid="+ IsNull(item.hjhbid) + "&jhgysid="+ IsNull(item.jhgysid) +  "');\" style=\"font-size:17px;color:#0000F0;text-decoration:none;font-weight:bold;\" >" + IsNull(item.jcypmc) + "</a></td>";
                     	html += " </tr>";
                     	html += " <tr>";
                    	html += "     <td  style=\"font-size:14px;\">供应商：" + IsNull(item.jhgysmc) + "</td>";
                     	html += " </tr>";
                     	html += " <tr>";
                    	html += "     <td  style=\"font-size:14px;\">商标：" + IsNull(item.spsb) + "</td>";
                     	html += " </tr>";
                     	html += " <tr>";
                    	html += "     <td  style=\"font-size:14px;\">采购时间：" + IsNull(item.aae036).split(" ")[0] + "</td>";
                     	html += " </tr>";
                     	html += " <tr>";
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