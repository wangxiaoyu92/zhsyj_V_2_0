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
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">产品信息</div>
                <div id="table_1" class="table_hide" style="width:50%;" onclick="sele_show(1)">检验信息</div>
            </div>            
            <div class="tab_list">            
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <table id="content" style="width:100%;margin-top: 20px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
	                        <td>产品名称</td>
	                        <td>生产批次号</td>
	                        <td>商品条码</td>
	                        <td>规格</td>
	                        <td>生产日期</td>
	                        <td>保质期</td>
	                        <td>操作</td>
	                        </tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="page_list"></ul>
	            </div>           
	            <div id="tables_1" class="tables" style="display:none;width:100%">
	                <table id="content" style="width:100%;margin-top: 20px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
	                        <td>产品检验报告编号</td>
	                        <td>执行标准号</td>
							<td>检验日期</td>
							<td>检验结论</td>
							<td>操作</td>
							</tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="page_list"></ul>            
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
            //getPcomryList(page, v_pageSize);
        }
    }
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        //getPcompanyXkzFjList(1, v_pageSize);  
        //getPcomryList(1, v_pageSize);                
    });

    function getPcompanyXkzFjList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getPcompanyXkzFjList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid, comxkzlx: '3' },
            success: function(result){ 
            	if(result.code == '0'){                           
                 	$.each(result.rows, function (index, item) {
                 		var fjpath = checkImg(item.fjpath);   
		                if (item.comxkzlx == "1") {
		                    $('#yyzz').attr('src', fjpath);
		                    $('#yyzz').attr('rel', fjpath);
		                }
                    	if (item.comxkzlx == "4"){
		                    $('#xkz').attr('src', fjpath);
		                    $('#xkz').attr('rel', fjpath);
		                }
                 	});
                 	$(".jqzoom").imagezoom();                 	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function getPcomryList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getPcomryList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid, rysfspaqgly:'1', rysfjdgsry:'1' },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage; 
                 	$('#content tbody').empty();                           
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;height:40px;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;height:40px;\">";
                        }
                        html += "<td><img src='images/person.png' width='16px' height='16px'></td>"
                        html += "<td>" + item.ryxm + "</td><td>" + item.ryzwgwinfo + "</td><td>" + item.rylxdh + "</td><td>" + item.ryztinfo + "</td>";
                        html += "<td><a href=\"enterprise_person_info.jsp?ryid=" + item.ryid + "&ryxm="+ item.ryxm + "&ryzwgw=" + item.ryzwgwinfo + "&rylxdh=" + item.rylxdh + "&ryzt=" + item.ryztinfo + "\" target='_blank' style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">查看证件</a></td>";                        
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
</script>
</body>
</html>