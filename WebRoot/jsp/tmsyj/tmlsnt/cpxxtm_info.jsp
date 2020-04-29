<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch")); // 产品批次号
	String t_proid = StringHelper.showNull2Empty(request.getParameter("proid")); // 产品id
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
<div class="container" style="width:80%;margin-top:5px;min-width:800px;">
    <div class="current-location">
        <span class="position" id="currlocation">当前位置：  </span>
    </div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px;
            	line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">产品生产生长信息</div>
                <div id="table_1" class="table_hide" style="width:50%;" onclick="sele_show(1)">产品检测检疫信息</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
                    <table id="cpscxx_content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
                        <thead style="font-weight:bold;border-bottom:1px #999 solid;">
                        <tr>
                            <td>记录人</td>
                            <td>记录内容</td>
                            <td>记录日期</td>
                            <td>备注</td>
                            <td>操作</td>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
	                <ul id="cpscxx_page_list"></ul>
	            </div>
	            <div id="tables_1" class="tables" style="display:none;width:100%">
	                <table id="cpjcxx_content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
		                        <td>检测项目</td>
		                        <td>检测结果</td>
		                        <td>检测人员</td>
		                        <td>检测单位</td>
		                        <td>检测时间</td>
		                        <td>操作</td>
	                        </tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="cpjcxx_page_list"></ul>
	            </div>
        	</div>
       	    <!--选项卡内容  结束-->   
        </div>
    </div>
</div>		
<div id="foot"></div>		
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_cppcpch = '<%=t_cppcpch%>';
	var t_proid = '<%=t_proid%>';

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
    // 产品生产信息分页
    var cpscxx_options = {
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
            getCpsctmList(page, v_pageSize);
        }
    };

    // 产品检测检疫信息分页
    var cpjcxx_options = {
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
            getCpjcjytmList(page, v_pageSize);
        }
    };
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getCpsctmList(1, v_pageSize); // 生产生长信息
        getCpjcjytmList(1, v_pageSize); // 检验检疫信息
    });
    // 产品生产生长信息
    function getCpsctmList(page, pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getCpsctmList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, cppcpch: t_cppcpch, proid: t_proid },
            success: function(result){ 
            	if(result.code == '0'){
                    cpscxx_options.currentPage = result.currPage;
                    cpscxx_options.totalPages = result.totalPage;
            		$('#cpscxx_content tbody').empty();
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;\">";
                        }
                        html += "<td>" + IsNull(item.szgcczr) + "</td>";
                        html += "<td>" + IsNull(item.szgccznr) + "</td>";
                        html += "<td>" + IsNull(item.szgcczrq).split(" ")[0] + "</td>";
                        html += "<td>" + IsNull(item.szgcbz) + "</td>";
//                        html += "<td><a href=\"javascript:linkToSelf('cpxxtm_info.jsp?procomid=" + IsNull(item.procomid) + "&cppcpch="+ IsNull(item.cppcpch) + "&proid="+ IsNull(item.proid) +  "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">全程追溯</a></td>";
                        html += "<td><a href=\"javascript:void(0);\" onclick=\"productfjcx('" + item.szgcid + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">查看图片</a></td>";
                        html += "</tr>";
                        $('#cpscxx_content tbody').append(html);
                        if (index == result.rows.length - 1) {
                            $('#cpscxx_page_list').bootstrapPaginator(cpscxx_options);
                        }
                    });
                    if (result.total <= 0){
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
                        $('#cpscxx_content').append(html);
                    }
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }

    // 产品检测检疫信息
    function getCpjcjytmList(page, pageSize) {
        $.ajax({
            url: basePath + "api/tmsyj/getCpjcjytmList",
            type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, cppcpch: t_cppcpch, proid: t_proid },
            success: function(result){
                if(result.code == '0'){
                    cpjcxx_options.currentPage = result.currPage;
                    cpjcxx_options.totalPages = result.totalPage;
                    $('#cpjcxx_content tbody').empty();
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;\">";
                        }
                        html += "<td>" + IsNull(item.jcitem) + "</td>";
                        html += "<td>" + IsNull(item.jcjg) + "</td>";
                        html += "<td>" + IsNull(item.jcjcy) + "</td>";
                        html += "<td>" + IsNull(item.jcdw) + "</td>";
                        html += "<td>" + IsNull(item.jcsj).split(" ")[0] + "</td>";
                        html += "<td><a href=\"javascript:void(0);\" onclick=\"productfjcx('" + item.qproductjcid + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">查看图片</a></td>";
                        html += "</tr>";
                        $('#cpjcxx_content tbody').append(html);
                        if (index == result.rows.length - 1) {
                            $('#cpjcxx_page_list').bootstrapPaginator(cpjcxx_options);
                        }
                    });
                    if (result.total <= 0){
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
                        $('#cpjcxx_content').append(html);
                    }
                }else{
                    alert(result.msg);
                }
            }
        });
    }

    function productfjcx(id){
        var url = encodeURI(basePath + "/jsp/tmsyj/tmlsnt/product_fj_list.jsp?fjwid="  + IsNull(id));
        linkToBlank(url);
    }
</script>
</body>
</html>