<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_hviewjgztid = StringHelper.showNull2Empty(request.getParameter("hviewjgztid"));
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
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
        	<div style="width:96%;margin-left:15px;">
                <ul id="content" ></ul>
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
	var t_hviewjgztid= '<%=t_hviewjgztid%>';
	var t_jcypid = '<%=t_jcypid%>';	
   	
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
            getSpxxtmList(page, v_pageSize);
        }
    }
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getSpxxtmList(1, v_pageSize);                 
    });
    
    function getSpxxtmList(page,pageSize) {
            $.ajax({
                url:  "http://www.paogener.com:9095/fs-circulation/app/detailJson",
                async:true,    //是否异步
                //type: "post",
                type:"get",    //请求方式
                dataType: 'jsonp',
                jsonp: "callbackparam",    //跨域请求的参数名，默认是callback
                data: { curpage: page, pagenum: pageSize, company_id: t_hviewjgztid, jcypid: t_jcypid },
                success: function(result){ 
	            	if(result.code == '0'){
	            		options.currentPage = result.currPage;
	                 	options.totalPages = result.totalPage;                            
	                	$('#content').empty();
	                 	$.each(result.rows, function (index, item) {
	                        var html = "";
	                        var g_img = "";
	                        var h_img = "";
	                        var g_txt = "";
	                        var h_txt = "";
	                        if (index != result.rows.length - 1) {
	                        	html += "<li style=\"border-bottom:1px #999 dotted;\">";
	                     	} else {
	                        	html += "<li style=\"border-bottom:1px #00a0ea solid;\">";
	                     	}
// 	                        if (tp == 1) {
// 	                            html += " <table class='table table-bordered' width=\"97%\"  style=\"text-align:center;margin-top:15px;border-collapse:collapse; font-size:14px;\">";
// 	                            html += " <tr>";
// 	                            html += "      <td rowspan=\"4\" width=\"130px\" style=\"padding-right:15px;padding-top:20px;\">";
// 	                            html += "        <img src=\"" + (item.fjpath == "" ? "images/kong.jpg" : item.fjpath) + "\" style=\"height:100px;width:120px;\" />";
// 	                            html += "     </td>";
// 	                            html += "    <td  style='font-weight: bold;text-align:right;width:80px'>采购日期</td>";
// 	                            html += "    <td colspan='3' >" + item.aae036 + "</td>";
// 	                            if(show)
// 	                            html += "    <td  colspan='2'><p  class=\"btn\" onclick=\"gosearch('" + item.eptbh + "^" + item.hjhbid + "')\" style=\"background-color:#b845ac;color:#fff;\">全程追溯</p></td>";
// 	                            else
// 	                                html += "    <td  colspan='2'><p  class=\"btn\"  style=\"background-color:#b845ac;color:#fff;display:none;\"></p></td>";
// 	                            html += " </tr>";
// 	                            html += "  <tr>";
// 	                            html += "    <td style='font-weight: bold;text-align:right;' >产品名称</td>";
// 	                            html += "    <td  >" + item.jcypmc + "</td>";
// 	                            html += "    <td style='font-weight: bold;text-align:right;width:70px' >类别</td>";
// 	                            html += "    <td  >" + item.spfenleiinfo + "</td>";
// 	                            html += "    <td style='font-weight: bold;text-align:right;width:70px' >品牌</td>";
// 	                            html += "    <td  >" + item.jcypsspp + "</td>";
// 	                            html += "</tr>";
// 	                            html += " <tr>";
// 	                            html += "    <td  style='font-weight: bold;text-align:right;'>规格</td>";
// 	                            html += "    <td  >" + item.spggxh + "</td>";
// 	                            html += "    <td  style='font-weight: bold;text-align:right;'>批号</td>";
// 	                            html += "    <td  >" + item.jhscpcm + "</td>";
// 	                            html += "    <td  style='font-weight: bold;text-align:right;'>采购量</td>";
// 	                            html += "    <td  >" + item.jhsl +"</td>";
// 	                            html += " </tr>";
// 	                            html += " <tr>";
// 	                            html += "    <td  style='font-weight: bold;text-align:right;'>保质日期</td>";
// 	                            html += "    <td  >" + item.spbzq + "</td>";
// 	                            html += "    <td style='font-weight: bold;text-align:right;' >供货商</td>";
// 	                            html += "    <td colspan='3' >" + item.jhgysmc + "</td>";
// 	                            html += " </tr>";
// 	                            html += "</table>";
// 	                        } else if (tp == 2){
	                            html += " <table class='table table-bordered' width=\"97%\"  style=\"text-align:center;margin-top:15px;border-collapse:collapse; font-size:14px;\">";
	                            html += " <tr>";
	                            html += "      <td rowspan=\"4\" width=\"130px\" style=\"padding-right:15px;padding-top:20px;\">";
	                            html += "        <img src=\"" + checkImg(item.fjpath) + "\" style=\"height:100px;width:120px;\" />";
	                            html += "     </td>";
	                            html += "    <td  style='font-weight: bold;text-align:right;width:80px'>采购日期</td>";
	                            html += "    <td >" + IsNull(item.aae036) + "</td>";
	                            if(1==1){
	                            	html += "    <td  colspan='2'><p  class=\"btn\" onclick=\"gosearch('" + item.eptbh+"^"+item.hjhbid + "')\" style=\"background-color:#b845ac;color:#fff;\">全程追溯</p></td>";
	                            }else{
	                                html += "    <td  colspan='2'><p  class=\"btn\"  style=\"background-color:#b845ac;color:#fff;display:none;\"></p></td>";}
	                            html += " </tr>";
	                            html += "  <tr>";
	                            html += "    <td style='font-weight: bold;text-align:right;' >产品名称</td>";
	                            html += "    <td  >" + IsNull(item.jcypmc) + "</td>";
	                            html += "    <td style='font-weight: bold;text-align:right;width:70px' >类别</td>";
	                            html += "    <td  >" + IsNull(item.spfenleiinfo) + "</td>";
	                            html += "</tr>";
	                            html += " <tr>";
	                            html += "    <td  style='font-weight: bold;text-align:right;'>批号</td>";
	                            html += "    <td  >" + IsNull(item.jhscpcm) + "</td>";
	                            html += "    <td  style='font-weight: bold;text-align:right;'>采购量</td>";
	                            html += "    <td  >" + IsNull(item.jhsl) + "</td>";
	                            html += " </tr>";
	                            html += " <tr>";
	                            html += "    <td style='font-weight: bold;text-align:right;' >供货商</td>";
	                            html += "    <td colspan='3' >" + IsNull(item.jhgysmc) + "</td>";
	                            html += " </tr>";
	                            html += "</table>";
	                        //}
	                        html += "</li>";
	                        $('#content').append(html);
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
    
        function gosearch(pcode)
        {
                layer.open({
                    type: 2,
                    title: '全程追溯',
                    scrollbar: false,
                    shift: 3,
                    shade: 0,
                    offset: '50px',
                    maxmin: false,
                    shadeClose: true,
                    area: ['950px', '420px'],
                    content: _urlpara + '/manage/frame/retrospect/retrospectManageByCY.html?productTraceCode=' + pcode + "&restrospectMode=up&enterpriseId=" + getUrlParam('eid')
                })
            
        }

</script>
</body>
</html>