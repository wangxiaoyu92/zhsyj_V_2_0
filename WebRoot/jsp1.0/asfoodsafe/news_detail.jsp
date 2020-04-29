<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";	
%>
<%
	String t_currlocation = "新闻详情";
	String t_newsid = StringHelper.showNull2Empty(request.getParameter("newsid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-新闻详情</title>
<jsp:include page="head.jsp"></jsp:include>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script src="images/news_set.js"></script>
</head>
<body onload="getColor();">
<div class="news_page" id="news_page">
    <div class="news_title" style="font-size:16px;" id="title"></div>
    <div class="news_subinfo" id="summary"></div>
    <div class="news_subinfo">
		<!--
		&nbsp;&nbsp;&nbsp;&nbsp;
		字体大小
		[<a href="javascript:setFont('16')">大</a>]
		[<a href="javascript:setFont('14')">中</a>]
		[<a href="javascript:setFont('12')">小</a>]
		-->
		&nbsp;&nbsp;&nbsp;&nbsp;
		视力保护色 
		<a href="javascript:setColor('FAFBE6')"><img width=10 height=10 alt=杏仁黄 src="images/color1.gif"></a>
		<a href="javascript:setColor('FFF2E2')"><img width=10 height=10 alt=秋叶褐 src="images/color2.gif"></a>
		<a href="javascript:setColor('FDE6E0')"><img width=10 height=10 alt=胭脂红 src="images/color3.gif"></a>
		<a href="javascript:setColor('F3FFE1')"><img width=10 height=10 alt=芥末绿 src="images/color4.gif"></a>
		<a href="javascript:setColor('DAFAFE')"><img width=10 height=10 alt=天蓝 src="images/color5.gif"></a>
		<a href="javascript:setColor('E9EBFE')"><img width=10 height=10 alt=雪青 src="images/color6.gif"></a>
		<a href="javascript:setColor('EAEAEF')"><img width=10 height=10 alt=灰(默认色) src="images/color7.gif"></a>
		<a href="javascript:setColor('FFFFFF')"><img width=10 height=10 alt=银河白 src="images/color8.gif" ></a>
	</div>
	<div class="news_content" style="text-indent:0em;" id="content"></div>
    <div class="news_content" style="text-indent:0em;">
	    <br/><img src="images/wx.jpg"/>
	    <!-- 分享到 -->
	    <div class="bshare-custom detials_content" style="margin-left:45px;margin-top:10px;">
		<div class="bsPromo bsPromo2"></div>
		<a id="bshare-shareto" class="bshare-more" title="分享到" href="http://www.bShare.cn/">分享到</a><a class="bshare-sinaminiblog" title="分享到新浪微博"></a><a class="bshare-ifengmb" title="分享到凤凰微博" href="javascript:void(0);"></a><a class="bshare-neteasemb" title="分享到网易微博" href="javascript:void(0);"></a><a class="bshare-sohuminiblog" title="分享到搜狐微博" href="javascript:void(0);"></a><a class="bshare-qqmb" title="分享到腾讯微博" href="javascript:void(0);"></a><a class="bshare-hexunmb" title="分享到和讯微博" href="javascript:void(0);"></a><a class="bshare-qzone" title="分享到QQ空间" href="javascript:void(0);"></a><a class="bshare-renren" title="分享到人人网"></a><a class="bshare-tianya" title="分享到天涯" href="javascript:void(0);"></a><a class="bshare-more bshare-more-icon more-style-addthis" title="更多平台"></a><span style="float: none;" class="BSHARE_COUNT bshare-share-count">11.6K</span>
		</div>
		<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
		<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
	    <!-- 新闻版权声明 -->
		<div style="font-family:'宋体','Microsoft YaHei';">
		   <img src="images/shengming.jpg"/><font style="font-weight:bold;color:#ff6600;font-size:16px;">版权与免责声明</font><br/>
		   <div style="font-size:12px;color:#9b9b9b;">
		　　    ① 凡本网注明“来源：安盛食品安全追溯监管平台”的所有作品，版权均属于安盛食品安全追溯监管平台，未经本网授权不得转载、摘编或利用其它方式使用上述作品。已经本网授权使用作品的，应在授权范围内使用，并注明“来源：安盛食品安全追溯监管平台”。违反上述声明者，本网将追究其相关法律责任。
			<br/>
		　　    ② 凡本网注明“来源：XXX（非安盛食品安全追溯监管平台）”的作品，均转载自其它媒体，转载目的在于传递更多信息，并不代表本网赞同其观点和对其真实性负责；如其他媒体、网站或个人从本网站转载使用，须保留本网站注明的“来源”，并自负版权等法律责任；
			<br/>
		　　    ③ 如因作品内容、版权和其它问题需要同本网联系的，请及时与我们联系，我们会在第一时间内响应处理。
			<br/>
		　　    ※ 联系方式：安盛食品安全追溯监管平台 电话：0371-65751486
		   </div>
		</div>  
    </div>
    
    <div class="news_operate">
		<a href="javascript:window.print();" title="打印此文"><img src="images/print.gif"/></a>&nbsp;&nbsp;
		<a href="javascript:window.close();" title="关闭窗口"><img src="images/close.gif"/></a>
	</div>
</div>
	
<div style="height:30px;padding-top:30px;margin:0 auto;width:1000px;text-align:center">
	<div style="float:left">
	    <a onclick="getPreNews();"><img src="images/pre.gif" title="上一篇" />上一篇</a>
	</div>
	<div style="float:right">
	    <a onclick="getNextNews();">下一篇<img src="images/next.gif" title="下一篇" /></a>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_newsid = '<%=t_newsid%>';

	$(function () {
        getNewsList();
    });

    function getNewsList() {
   		$.ajax({
        	url: basePath + "news/getNewsList",
        	type: "post",
            dataType: 'json',
            data: { newsid: t_newsid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
	            		var item = result.rows[0];             		                 
						$('#title').append(IsNull(item.newstitle));
                        $('#summary').append("发布日期：" + IsNull(item.newstjsj) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容来源：" + IsNull(item.newsfrom) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编辑：" + IsNull(item.newsfrom));
                        $('#content').append(IsNull(item.newscontent));
                    }   	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}          
        });
    }
    
    function getPreNews() {
   		$.ajax({
        	url: basePath + "news/getPreNews",
        	type: "post",
            dataType: 'json',
            data: { newsid: t_newsid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
            			$('#title').empty();
            			$('#summary').empty();
            			$('#content').empty();
	            		var item = result.rows[0];             		                 
						$('#title').append(IsNull(item.newstitle));
                        $('#summary').append("发布日期：" + IsNull(item.newstjsj) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容来源：" + IsNull(item.newsfrom) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编辑：" + IsNull(item.newsfrom));
                        $('#content').append(IsNull(item.newscontent));
                        t_newsid = item.newsid;                       
                    }   	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}          
        });
    }  
    
    function getNextNews() {
   		$.ajax({
        	url: basePath + "news/getNextNews",
        	type: "post",
            dataType: 'json',
            data: { newsid: t_newsid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
            			$('#title').empty();
            			$('#summary').empty();
            			$('#content').empty();
	            		var item = result.rows[0];             		                 
						$('#title').append(IsNull(item.newstitle));
                        $('#summary').append("发布日期：" + IsNull(item.newstjsj) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容来源：" + IsNull(item.newsfrom) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编辑：" + IsNull(item.newsfrom));
                        $('#content').append(IsNull(item.newscontent));
                        t_newsid = item.newsid; 
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