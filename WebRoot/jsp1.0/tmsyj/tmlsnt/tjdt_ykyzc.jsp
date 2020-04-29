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
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">畜牧养殖</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <ul id="sp_content"></ul>
	                <ul id="sp_page_list"></ul>
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
	var t_comid = '2017111315055382520549490';
   	
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
	
	var v_pageSize = 10;
    var sp_options = {
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
            getJkyList(page, v_pageSize);
        }
    }
    
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getJkyList(1, v_pageSize);
    });


    function getJkyList(page,pageSize) {
        $.ajax({
            url: basePath + "api/tmsyj/getJkyList",
            type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, jkqybh: t_comid, jklx: '1' },
            success: function(result){
                if(result.code == '0'){
                    sp_options.currentPage = result.currPage;
                    sp_options.totalPages = result.totalPage;
                    $('#sp_content').empty();
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<li style=\"border-bottom:1px #999 dotted;height:135px;\">";
                        } else {
                            html += "<li style=\"border-bottom:1px #00a0ea solid;height:135px;text-align:left;\">";
                        }
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += " 	<td rowspan=\"3\" width=\"140px\" style=\"padding-right:15px;\">";
                        html += "   	<a href='#' onclick=\"show_video(\'" + IsNull(item.ocxId) + "\',\'" + IsNull(item.camId) + "\')\" \"><img src=\"images/webcamera.jpg\" style=\"height:120px;width:160px;\" /></a>";
                        html += "   </td>";
                        html += "   <td><a href='#' onclick=\"show_video(\'" + IsNull(item.ocxId) + "\',\'" + IsNull(item.camId) + "\')\"  style=\"font-size:17px;color: #0000F0;text-decoration:none;font-weight:bold;\" >" + IsNull(item.camName) + "</a></td>";
                        html += " </tr>";
                        html += " <tr>";
                        html += "   <td  style=\"font-size:14px;\">企业名称：" + IsNull(item.camOrgName) + "</td>";
                        html += " </tr>";
                        html += " <tr>";
                        if(item.camState=='1'){
                            html += " <td  style=\"font-size:14px;\">在线状态：<span class=\"shop_camera\"><img class=\"shop_camera\" src=\"images/camera-on.png\"></span></td>";
                        }else{
                            html += " <td  style=\"font-size:14px;\">在线状态：<span class=\"shop_camera\"><img class=\"shop_camera\" src=\"images/camera-off.png\"></span></td>";
                        }
                        html += " </tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#sp_content').append(html);
                        if (index == result.rows.length - 1) {
                            $('#sp_page_list').bootstrapPaginator(sp_options);
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
                        html += "     <td  style=\"font-size:14px;\">未获取到监控源【监控摄像头不在线或监控服务器出现问题】，请联系系统管理员！</td>";
                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#sp_content').append(html);
                    }
                }else{
                    alert(result.msg);
                }
            }
        });
    }

    function show_video(jkybh,jkid) {
        var url = basePath + "jsp/tmsyj/tmsyj/show_video.jsp?jkybh=" + jkybh + "&jkid=" + jkid;
        layer.open({
            type: 2,
            title: t_currlocation,
            shift: 3,
            offset: '50px',
            scrollbar: false,
            shade: 0,
            shift:-1,
            maxmin: false,
            shadeClose: true,
            closeBtn: 1, //不显示关闭按钮
            area: ['930px', '550px'],
            content: [url, 'no']
        });
    }
</script>
</body>
</html>