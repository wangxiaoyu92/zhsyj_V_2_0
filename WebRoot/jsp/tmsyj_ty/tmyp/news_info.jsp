<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "新闻详情";
	String t_newsid = StringHelper.showNull2Empty(request.getParameter("newsid"));
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
<link href="./css/style.css" rel="stylesheet">
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
</head>
<body>
<div id="top"></div>	
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
            <h3 style="font-weight:bold;font-size:20px;margin-top:5px;" id="title"></h3>
            <pre style="text-align:center;font-size:14px;height:45px;margin-top:5px;padding-top:13px;" id="summary"></pre>  
            <div style="margin-top:20px;text-align:left;font-size:16px;" id="content">
               
            </div>
        </div>
    </div>
</div>
<div id="foot"></div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_newsid = '<%=t_newsid%>';

	$(function () {
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getNewsList();
    });

    function getNewsList() {
   		$.ajax({
        	url: basePath + "api/tmsyj/getNewsList",
        	type: "post",
            dataType: 'json',
            data: { newsid: t_newsid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
	            		var item = result.rows[0];             		                 
						$('#title').append(IsNull(item.newstitle));
                        $('#summary').append("发布时间：" + IsNull(item.newstjsj) + "&#9;&#9;内容分类：" + IsNull(item.catename) );
                        $('#content').append(IsNull(item.newscontent));
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