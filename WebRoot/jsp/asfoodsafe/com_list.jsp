<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-溯源企业列表</title>
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="./js/bootstrap-paginator.js"></script>
</head>
<body>
<div class="news_list_main">
	<div class="user_posotion">当前位置：<a href="index.jsp">首页</a>&nbsp;>>&nbsp;<span id="currlocation"></span></div>
	<div class="news_page">
		<div class="news_content news_list_content">
			<ul id="content"></ul>
		</div>
		<div style="width:96%;margin-left:15px;text-align:center">
	        <ul id="page_list"></ul>
	    </div>  
	</div>
</div>
<%@ include file="footer.jsp"%>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_comid = '';
		
	var v_pageSize = 15;
    var options = {
        currentPage: 1,
        totalPages: 1,
        bootstrapMajorVersion: 3,
        numberOfPages: 5,
        size: "normal",
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
            getPcompanyList(page, v_pageSize);
        }
    }
    
	$(function() {
		$('#currlocation').html(t_currlocation); 	
		getPcompanyList(1, v_pageSize);   
	});
    
    function getPcompanyList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getPcompanyList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize },
            success: function(result){ 
            	if(result.code == '0'){
            		options.currentPage = result.currPage;
                 	options.totalPages = result.totalPage;                            
                	$('#content').empty();
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
                     	html += " <li><a href=\"javascript:linkToSelf('com_detail.jsp?comid=" + item.comid + "&commc="+ item.commc + "');\">" + item.commc + "</a></li>";
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
</script>
</body>
</html>