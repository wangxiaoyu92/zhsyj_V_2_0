<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
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
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">采购产品信息</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <table id="content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
	                            <td>卖方公司</td>
	                            <td>交易商品</td>
	                            <td>交易数量</td>
								<td>计量单位</td>
								<td>交易日期</td>
	                            <td>商品批次</td>
	                            <td>交易类型</td>
	                            <td>操作</td>
	                        </tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="page_list"></ul>
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
	
	var v_pageSize = 10;
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
            getYbzspList(page, v_pageSize);
        }
    };
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getYbzspList(1, v_pageSize);                 
    });
    
    function getYbzspList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getSycpcgxxtmList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage;
                 	$('#content tbody').empty();
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
	                    if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;\">";
                        }
						html += "<td>" + IsNull(item.fromcom) + "</td>";
						html += "<td>" + IsNull(item.lgproname) + "</td>";
						html += "<td>" + IsNull(item.lgprojysl) + "</td>";
						html += "<td>" + IsNull(item.lgprojydwmc) + "</td>";
						html += "<td>" + IsNull(item.lgprojyrq) + "</td>";
						html += "<td>" + IsNull(item.lgpropc) + "</td>";
						if (IsNull(item.lgjylx) == "2") {
							html += "<td>范围外交易</td>";
						} else {
							html += "<td>范围内交易</td>";
						}
						html += "<td><a href=\"javascript:void(0);\" onclick=\"productfjcx('" + item.qledgerstockid + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">交易附件</a></td>";
						html += "</tr>";
						$('#content tbody').append(html);
						if (index == result.rows.length - 1) {
							$('#page_list').bootstrapPaginator(options);
						}
                 	});
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