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
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>智慧园区</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/isotope.css" media="screen"/>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/carousel.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/default.css">
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
<section id="section-photo" class="section appear clearfix bg-gray">
    <div class="container">
       
        <div class="row">
            <nav id="filter" class="col-md-12 text-center animated notransition animated fadeInNow animation58">
                <ul>
                    <li><a href="#" class="current btn-theme btn-small" data-filter="*">全部</a></li>
                    <li><a href="#" class="btn-theme btn-small" data-filter=".house">楼盘</a></li>
                    <li><a href="#" class="btn-theme btn-small" data-filter=".scene">现场</a></li>
                </ul>
            </nav>
            <div class="col-md-12">
                <div class="row notransition animated fadeInUpNow animation103">
                    <div class="portfolio-items isotopeWrapper clearfix" id="3">
                        <article class="col-md-4 isotopeItem house">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/img1.jpg" alt="" class="backimg"/>
                                    <a href="http://www.qsjqj.com/vrpano/vrpano351/" target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/xqhp.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>冠城大通蓝郡</h4>
                                </div>
                            </div>
                        </article>
                        <article class="col-md-4 isotopeItem scene">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/img4.jpg" alt="" class="backimg"/>
                                    <a href="http://720yun.com/t/fe72cjp5q4w?pano_id=270295" target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/xqhp.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>南京长江大桥</h4>
                                </div>
                            </div>
                        </article>
                        <article class="col-md-4 isotopeItem scene">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/mgbs.jpg" alt="" class="backimg"/>
                                    <a href="http://720yun.com/t/bcb2dcafjew"
                                       target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/mgbs.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>美国别墅庄园</h4>
                                </div>
                            </div>
                        </article>
                        <article class="col-md-4 isotopeItem house">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/img5.jpg" alt="" class="backimg"/>
                                    <a href="http://720yun.com/t/9b621jbkuci?pano_id=316711" target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/xqhp.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>小区航拍</h4>
                                </div>
                            </div>
                        </article>
                        <article class="col-md-4 isotopeItem house">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/img8.jpg" alt="" class="backimg"/>
                                    <a href="http://www.qsjqj.com/vrpano/vrpano362/" target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/xqhp.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>婚礼现场</h4>
                                </div>
                            </div>
                        </article>
                        <article class="col-md-4 isotopeItem scene">
                            <div class="bg-white">
                                <div class="vrone" title="电脑端直接点击二维码<br>手机端体验更多请扫码"
                                     data-toggle="tooltip" data-placement="bottom" data-html="true">
                                    <img src="img/hylh.jpg" alt="" class="backimg"/>
                                    <a href="http://720yun.com/t/12a2cjzuuev" target="_blank">
                                        <div class="qrcode"
                                             style="background: url('img/xqhp.png') center no-repeat;">
                                        </div>
                                    </a>
                                </div>
                                <div class="align-center pad-top25 pad-bot5">
                                    <h4>汇银乐虎</h4>
                                </div>
                            </div>
                        </article>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="js/modernizr.min.js"></script>
<script src="js/jquery.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.isotope.min.js"></script>
<script src="js/skrollr.min.js"></script>
<script src="js/stellar.js"></script>
<script src="js/jquery.appear.js"></script>
<script src="js/jweixin-1.0.0.js"></script>
<script src="js/main.js"></script>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_comid = '';
		
	var v_pageSize = 6;
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