<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.service.news.NewsService"%>
<%@ page import="com.zzhdsoft.siweb.entity.news.News" %>
<%@ page import="com.zzhdsoft.siweb.dto.PagesDTO"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";	
%>
<%
	NewsService newsService = new NewsService();
	News newsdto = new News(); 
	PagesDTO pd = new PagesDTO();
	List newsList = null;	
%> 
<!DOCTYPE html>
<html>
<head>
<title>安盛食品安全追溯平台-政策法规</title>
<jsp:include page="head.jsp"></jsp:include>
<link href="images/nav.css" rel="stylesheet" />
<script src="js/jquery.nav.js"></script>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<script>
function closediv(domid){
	document.getElementById(domid).style.display='none';
}
</script>
</head>
<body>
<div class="zcfg_list">
	<h2><span class="news_more"><a href="javascript:linkToSelf('news_list.jsp?currlocation=国家政策法规&catejc=gjzc');">更多>></a></span><span>国家政策法规</span></h2>
	<ul>
		<%
			newsdto.setCatejc("gjzc");
			pd.setPage(1);
     		pd.setRows(10);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
		%>
				<li><a href="javascript:linkToSelf('news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*50,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
		<%
				}
			}
		%>
	</ul>
</div>

<div class="zcfg_list">
    <h2><span class="news_more"><a href="javascript:linkToSelf('news_list.jsp?currlocation=地方政策法规&catejc=dfzc')">更多>></a></span><span>地方政策法规</span></h2>
	<ul>
		<%
			newsdto.setCatejc("dfzc");
			pd.setPage(1);
     		pd.setRows(10);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
		%>
				<li><a href="javascript:linkToSelf('news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*50,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
		<%
				}
			}
		%>
	</ul>
</div>

<div class="zcfg_list">
    <h2><span class="news_more"><a href="javascript:linkToSelf('news_list.jsp?currlocation=行业标准&catejc=hybz')">更多>></a></span><span>行业标准</span></h2>
	<ul>
		<%
			newsdto.setCatejc("hybz");
			pd.setPage(1);
     		pd.setRows(10);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
		%>
				<li><a href="javascript:linkToSelf('news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*50,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
		<%
				}
			}
		%>
	</ul>
</div>

<%@ include file="footer.jsp"%>
</body>
</html>