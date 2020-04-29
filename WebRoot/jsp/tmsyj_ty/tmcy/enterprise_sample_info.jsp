<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "食品留样公示";
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
	String t_hsplyid = StringHelper.showNull2Empty(request.getParameter("hsplyid"));
	String t_jccc = StringHelper.showNull2Empty(request.getParameter("jccc"));
	String t_splysj = StringHelper.showNull2Empty(request.getParameter("splysj"));
	String t_splyry = StringHelper.showNull2Empty(request.getParameter("splyry"));
	String t_splypz = StringHelper.showNull2Empty(request.getParameter("splypz"));
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
<script src="./js/MSClass.js"></script>
</head>
<body>
<div id="top"></div>	
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;">
        	<h3 style="font-weight:bold;font-size:20px;margin-top:5px;text-align:center;" id="title"></h3>
            <pre style="font-size:13px;margin-top:5px;padding-top:5px;text-align:left;" id="summary"></pre>
            <div class="marquee" style="display: block;">
	        	<ul id="marqueeDiv"></ul>
	        </div>
	        <!--选项卡内容 开始-->
<!--             <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;"> -->
<!--                 <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">食品留样附件</div> -->
<!--             </div> -->
<!--             <div class="tab_list">  -->
<!-- 	            <div id="tables_0" class="tables" style="display:block;width:100%"> -->
<!-- 	                <ul id="content"></ul> -->
<!-- 	                <ul id="page_list"></ul> -->
<!-- 	            </div> -->
<!--         	</div> -->
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
	var t_hsplyid = '<%=t_hsplyid%>';	
   
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
            getFjList(page, v_pageSize);
        }
    }	
    	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        } 
        getFjList(1, v_pageSize);                
    });

    function getFjList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getFjList",
        	type: "post",
            dataType: 'json',
            data: { fjwid: t_hsplyid },
            success: function(result){ 
            	if(result.code == '0'){
            		$('#title').append('<%=t_commc%> >> <%=t_jccc%>');
                    var html = "";           		
            		html += "<div style='text-align:left'>留样名称：<%=t_splypz%></div>";                    
            		html += "<div style='text-align:left'>留样日期：<%=t_splysj%></div>";
            		html += "<div style='text-align:left'>留样人：<%=t_splyry%></div>";
                    $('#summary').append(html);                           
                 	$.each(result.rows, function (index, item) {
                 		var fjpath = basePath + item.fjpath;     
                    	var html = "";             	
                    	html += "<li><a onclick='showPic(\""+fjpath+"\")' ><img src='"+fjpath+"'></a></li>";
        				//滚动图片
        				$('#marqueeDiv').append(html);                 	                 	
                 	});
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function getFjList2(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getFjList",
        	type: "post",
            dataType: 'json',
            data: { fjwid: t_hsplyid },
            success: function(result){ 
            	if(result.code == '0'){
            		$('#title').append('<%=t_commc%> >> <%=t_jccc%>');
                    var html = "";           		
            		html += "<div style='text-align:left'>留样名称：<%=t_splypz%></div>";                    
            		html += "<div style='text-align:left'>留样日期：<%=t_splysj%></div>";
            		html += "<div style='text-align:left'>留样人：<%=t_splyry%></div>";
                    $('#summary').append(html);                           
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
                 	//$(".jqzoom").imagezoom();
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
<script type="text/javascript">
	/*********跑马灯效果***************/
	var marqueeDivControl=new Marquee("marqueeDiv");
	marqueeDivControl.Direction="left";
	marqueeDivControl.Step=1;
	marqueeDivControl.Width=1020;
	marqueeDivControl.Height=233;
	marqueeDivControl.Timer=20;
	marqueeDivControl.ScrollStep=1;				
	marqueeDivControl.Start();
	marqueeDivControl.BakStep=marqueeDivControl.Step;	
</script>
</body>
</html>