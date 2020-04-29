<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_hscpcbid = StringHelper.showNull2Empty(request.getParameter("hscpcbid"));
	String t_jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
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
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
            <!--选项卡内容 开始-->
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; 
            	line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">检验检测信息</div>
                <div id="table_1" class="table_hide" style="width:50%;" onclick="sele_show(1)">配料表信息</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <ul id="content"></ul>
	                <ul id="page_list"></ul>
	            </div>
	            <div id="tables_1" class="tables" style="display:none;width:100%">
	                <table id="cppl_content" style="width:100%;margin-top: 20px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
		                        <td></td>
		                        <td>产品名称</td>
		                        <td>配料信息</td>
	                        </tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="sppl_page_list"></ul>
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
	var t_hscpcbid = '<%=t_hscpcbid%>';	
   	
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
            getCpxxtmJyjcFjList(page, v_pageSize);
        }
    }
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getCpxxtmJyjcFjList(1, v_pageSize);                 
    });
    
    function getCpxxtmJyjcFjList() {
    	$.ajax({
        	url: basePath + "api/tmsyj/getCpxxtmJyjcFjList",
        	type: "post",
            dataType: 'json',
            data: { hscpcbid: t_hscpcbid, fjtype: '9' },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage;
            		$('#content').empty();           		
                 	$.each(result.rows, function (index, item) {
                 		var html = ""; 
	            		if (index != result.rows.length - 1) {
	                        html += "<li style=\"border-bottom:1px #999 dotted;\">";
	                    } else {
	                        html += "<li style=\"border-bottom:1px #00a0ea solid;\">";
	                    } 
	                    html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";                       
                        html += " <tr>";
                        html += "   <td style=\"text-align:center\"><img style=\"width:100%;height:100%;\" src=\"" + checkImg(item.fjpath) + "\"></td>";
//                         html += "   <td style=\"text-align:center\"><img style=\"width:316px; height:222px;\" rel=\"" + checkImg(item.fjpath) + "\" src=\"" + checkImg(item.fjpath) + "\" class=\"jqzoom\"/></td>";                       
                        html += " </tr>";                        
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
    
    function showPic(url){
		layer.open({
	        type: 1,
	        title: "图片预览",
	        area:["70%","90%"],
	        shadeClose: true, //点击遮罩关闭
	        content: "<img style='width:100%;height:100%;' src="+url+"></img>"
	  }); 
	}

</script>
</body>
</html>