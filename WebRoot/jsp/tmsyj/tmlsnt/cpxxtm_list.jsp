<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
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
<div class="container" style="width:90%;margin-top:5px;min-width:1050px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">农产品</div>
            </div>
            <div class="tab_list">
                <div id="tables_0" class="tables" style="display:block;width:100%">
                    <table id="syncp_content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
                        <thead style="font-weight:bold;border-bottom:1px #999 solid;">
                        <tr>
                            <td>农产品名称</td>
                            <td>生产批次</td>
                            <td>商品条码</td>
                            <td>规格型号</td>
                            <td>产品标准号</td>
                            <td>商标(品牌)</td>
                            <td>生产日期</td>
                            <td>生产数量</td>
                            <td>计量单位</td>
                            <td>保质期</td>
                            <td>操作</td>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <ul id="syncp_page_list"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="foot"></div>		
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
    var t_comid = '<%=t_comid%>';

    var tabs = 3;
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
            getCpxxtmList(page, v_pageSize);
        }
    };
    
    $(function () {        
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getCpxxtmList(1, v_pageSize);
    });

    function getCpxxtmList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getSycptmList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, procomid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage;                            
                	$('#syncp_content tbody').empty();
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;\">";
                        }
                        html += "<td style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">"
                            + IsNull(item.proname) + "</td>";
                        html += "<td>" + IsNull(item.cppcpch) + "</td>";
                        html += "<td>" + IsNull(item.prosptm) + "</td>";
                        html += "<td>" + IsNull(item.progg) + "</td>";
                        html += "<td>" + IsNull(item.procpbzh) + "</td>";
                        html += "<td>" + IsNull(item.prosb) + "</td>";
                        html += "<td>" + IsNull(item.cppcscrq).split(" ")[0] + "</td>";
                        html += "<td>" + IsNull(item.cppcscsl) + "</td>";
                        html += "<td>" + IsNull(item.cppcscsldw) + "</td>";
                        html += "<td>" + IsNull(item.probzq) + "</td>";
                        html += "<td><a href=\"javascript:linkToSelf('cpxxtm_info.jsp?procomid="
                            + IsNull(item.procomid) + "&currlocation=" + IsNull(item.proname)
                            + ">>产品信息透明&cppcpch="+ IsNull(item.cppcpch) + "&proid="
                            + IsNull(item.proid) +  "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">全程追溯</a></td>";
                        html += "</tr>";
                        $('#syncp_content tbody').append(html);
                     	if (index == result.rows.length - 1) {
                        	$('#page_list').bootstrapPaginator(options);
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
                        $('#syncp_content').append(html);
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