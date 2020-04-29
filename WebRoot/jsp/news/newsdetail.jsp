<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,com.zzhdsoft.siweb.entity.Fj,java.util.*" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	News news = request.getAttribute("news")==null?null:(News)request.getAttribute("news");
	News preNews = request.getAttribute("preNews")==null?null:(News)request.getAttribute("preNews");
	News nextNews = request.getAttribute("nextNews")==null?null:(News)request.getAttribute("nextNews");
%>
<!DOCTYPE html>
<html>
<head>
<title>${news.newstitle }</title>
<jsp:include page="${contextPath}/jsp/gzfw/head.jsp"></jsp:include>
<script src="<%=contextPath %>/jsp/gzfw/js/news_set.js"></script>
<script type="text/javascript">
	function loadColor(){
		getColor();
	}
	
	var newsid = "${news.newsid}";
	if(newsid.length == 0){
		window.location.href = "404.html";
	}
</script>
</head>
<body onload="loadColor()">
<div class="mid_bg" id="news_page">
	<div class="about clearfix">
		<h2>${news.newstitle }</h2>
	    <div class="news_subinfo">
	    	发布日期：${news.newstjsj }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	来源：${news.newsfrom }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	编辑：${news.newsauthor }
			<!--
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			字体大小
			[<a href="javascript:setFont('16')">大</a>]
			[<a href="javascript:setFont('14')">中</a>]
			[<a href="javascript:setFont('12')">小</a>]
			-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			视力保护色 
			<a href="javascript:setColor('FAFBE6')"><img width="10" height="10" alt="杏仁黄" src="<%=contextPath %>/jsp/gzfw/images/color1.gif"></a>
			<a href="javascript:setColor('FFF2E2')"><img width="10" height="10" alt="秋叶褐" src="${contextPath}/jsp/gzfw/images/color2.gif"></a>
			<a href="javascript:setColor('FDE6E0')"><img width="10" height="10" alt="胭脂红" src="<%=contextPath %>/jsp/gzfw/images/color3.gif"></a>
			<a href="javascript:setColor('F3FFE1')"><img width="10" height="10" alt="芥末绿" src="<%=contextPath %>/jsp/gzfw/images/color4.gif"></a>
			<a href="javascript:setColor('DAFAFE')"><img width="10" height="10" alt="天蓝" src="<%=contextPath %>/jsp/gzfw/images/color5.gif"></a>
			<a href="javascript:setColor('E9EBFE')"><img width="10" height="10" alt="雪青" src="<%=contextPath %>/jsp/gzfw/images/color6.gif"></a>
			<a href="javascript:setColor('EAEAEF')"><img width="10" height="10" alt="灰(默认色)" src="<%=contextPath %>/jsp/gzfw/images/color7.gif"></a>
			<a href="javascript:setColor('FFFFFF')"><img width="10" height="10" alt="银河白" src="<%=contextPath %>/jsp/gzfw/images/color8.gif" ></a>
		</div>
    	<div class="about_nr clearfix">
    		${news.newscontent}
    	</div>
    	&nbsp;&nbsp; &nbsp; &nbsp;
    	
    	<%
	     List dataList=null;	    
	     if(null!=dataList && dataList.size()>0){
	    	 Fj fj = null;
	    	 out.println("附件:<br/>");
	    	 for(int i=0;i<dataList.size();i++){
	 		 	fj=(Fj)dataList.get(i);
	 		 	out.println("&nbsp;&nbsp; &nbsp; &nbsp;"+(i+1)+". <a href='news_downloadFile.action?id="+ fj.getFjid() +"'>"+ fj.getFjname() +"</a><br/>");
	     	}
	     }
	    %>
     
    	<br/>
	    <!-- 分享到 -->
	    <div class="bshare-custom detials_content" style="margin-left:45px;margin-top:10px;">
		<div class="bsPromo bsPromo2"></div>
			<a id="bshare-shareto" class="bshare-more" title="分享到" href="http://www.bShare.cn/">分享到</a>
			<a class="bshare-sinaminiblog" title="分享到新浪微博" href="javascript:void(0);"></a>
			<a class="bshare-ifengmb" title="分享到凤凰微博" href="javascript:void(0);"></a>
			<a class="bshare-neteasemb" title="分享到网易微博" href="javascript:void(0);"></a>
			<a class="bshare-sohuminiblog" title="分享到搜狐微博" href="javascript:void(0);"></a>
			<a class="bshare-qqmb" title="分享到腾讯微博" href="javascript:void(0);"></a>
			<a class="bshare-hexunmb" title="分享到和讯微博" href="javascript:void(0);"></a>
			<a class="bshare-qzone" title="分享到QQ空间" href="javascript:void(0);"></a>
			<a class="bshare-renren" title="分享到人人网" href="javascript:void(0);"></a>
			<a class="bshare-tianya" title="分享到天涯" href="javascript:void(0);"></a>
			<a class="bshare-more bshare-more-icon more-style-addthis" title="更多平台"></a>
			<span style="float: none;" class="BSHARE_COUNT bshare-share-count">11.6K</span>
		</div>
		<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
		<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script> 
    </div>
    
    <div class="news_operate">
		<a href="javascript:window.print();" title="打印此文"><img src="<%=contextPath %>/jsp/gzfw/images/print.gif"/></a>
			&nbsp;&nbsp;
		<a href="javascript:window.close();" title="关闭窗口"><img src="<%=contextPath %>/jsp/gzfw/images/close.gif"/></a>
	</div>

<%--	<div style="height:30px;padding-top:30px;margin:0 auto;width:1000px;text-align:center">--%>
<%--		<div style="float:left">--%>
<%--			<%if(null!=preNews){%>--%>
<%--				<img src="<%=contextPath %>/jsp/news/images/pre.gif" title="上一篇"/>&nbsp;<a href="<%=contextPath %>/news/queryNewsDetail?newsid=${preNews.newsid }" target="_self">${preNews.newstitle }</a>--%>
<%--			<%}else{%>--%>
<%--			    <img src="<%=contextPath %>/jsp/news/images/pre.gif" title="上一篇"/>&nbsp;没有上一篇！--%>
<%--			<%}%>--%>
<%--		</div>--%>
<%--		<div style="float:right">--%>
<%--			<%if(null!=nextNews){%>--%>
<%--			   <img src="<%=contextPath %>/jsp/news/images/next.gif" title="下一篇"/>&nbsp;<a href="<%=contextPath %>/news/queryNewsDetail?newsid=${nextNews.newsid }" target="_self">${nextNews.newstitle }</a>--%>
<%--			<%}else{%>--%>
<%--			   <img src="<%=contextPath %>/jsp/news/images/next.gif" title="下一篇"/>&nbsp;没有下一篇！--%>
<%--			<%}%>--%>
<%--		</div>--%>
<%--	</div>--%>

</div>
	
<jsp:include page="${contextPath}/jsp/gzfw/footer.jsp"></jsp:include>	
</body>
</html>