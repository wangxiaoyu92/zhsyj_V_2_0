<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	News news = request.getAttribute("news")==null?null:(News)request.getAttribute("news");
%>
<!DOCTYPE html>
<html>
<head>
<title>${news.newstitle }</title>
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
    </div>
</div>
</body>
</html>