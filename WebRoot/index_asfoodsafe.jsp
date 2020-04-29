<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.service.news.NewsService"%>
<%@ page import="com.zzhdsoft.siweb.entity.news.News" %>
<%@ page import="com.zzhdsoft.siweb.dto.PagesDTO"%>
<%@ page import="com.askj.baseinfo.dto.PcompanyDTO"%>
<%@ page import="com.askj.tmsyj.tmsyj.service.TmsyjApiService"%>
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
<title>安盛食品安全追溯平台</title>
<jsp:include page="${contextPath}/jsp/asfoodsafe/head.jsp"></jsp:include>
<link href="<%=contextPath %>/jsp/asfoodsafe/images/nav.css" rel="stylesheet" />
<script src="<%=contextPath %>/jsp/asfoodsafe/js/jquery-1.12.0.min.js"></script>
<script src="<%=contextPath %>/jsp/asfoodsafe/js/common.js"></script>
<script src="<%=contextPath %>/jsp/asfoodsafe/js/custom.js"></script>
<script src="<%=contextPath %>/jsp/asfoodsafe/js/jquery.jslides.js"></script>
<script>
function closediv(domid){
	document.getElementById(domid).style.display='none';
}
//查询追溯码是否存在
function queryData(){
	var query_zsm = $('#query_zsm').val();
	if(query_zsm.length<=0){
		alert('请输入溯源码！');
		$('#query_zsm').focus();
		return false;
	}
	if(query_zsm.length>0){
  		var url = "sym_query.jsp?sym="+query_zsm;
  		window.open(url);
  	}
}
</script>
</head>
<body>
<div id="full">
	<div class="w_top">
		<img src="<%=contextPath %>/jsp/asfoodsafe/images/closeBtn.png" style="padding-right:6px; cursor:pointer;" onclick="javascript:closediv('full')">
	</div>
	<div class="w_tit">安盛食品安全追溯平台微信</div>
	<div class="w_pic">
		<img src="<%=contextPath %>/jsp/asfoodsafe/images/weixin.jpg" style=" width:124px; height:124px; padding-left:6px;">
	</div>
</div>

<!--banner 开始-->
<div id="full-screen-slider">
	<ul id="slides">
	 	<li style="background:url('<%=contextPath %>/jsp/asfoodsafe/images/1.jpg') no-repeat center top"></li>
	    <li style="background:url('<%=contextPath %>/jsp/asfoodsafe/images/2.jpg') no-repeat center top"></li>   
	    <li style="background:url('<%=contextPath %>/jsp/asfoodsafe/images/3.jpg') no-repeat center top"></li>
		<li style="background:url('<%=contextPath %>/jsp/asfoodsafe/images/4.jpg') no-repeat center top"></li>	
	    <li style="background:url('<%=contextPath %>/jsp/asfoodsafe/images/5.jpg') no-repeat center top"></li>
	</ul>	
</div>
<!--banner 结束 -->

<div class="page_wrap_two">
	<div class="page_left_two">
		<div id="zwgg">
	        <h2 class="news_h2"><span class="news_more"><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=国内动态&catejc=gndt');">更多>></a></span><span class="news_title_span">国内动态</span></h2>
			<ul class="news_ul">
			<%				
				newsdto.setCatejc("gndt");
				pd.setPage(1);
	     		pd.setRows(8);
	     		newsList = newsService.queryNewsList(newsdto,pd);
	      		if (newsList != null && newsList.size() > 0) {
	      			for (int i = 0; i < newsList.size(); i++) {
	      				News bean = (News) newsList.get(i);
			%>
					<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*18,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
			<%
					}
				}
			%>
			</ul>
		</div>
	</div>
	<div class="page_center_two">
	 	<div id="zwgg">
	    	<h2 class="news_h2"><span class="news_more"><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=国际动态&catejc=gjdt');">更多>></a></span><span class="news_title_span">国际动态</span></h2>
			<ul class="news_ul">
			<%				
				newsdto.setCatejc("gjdt");
				pd.setPage(1);
	     		pd.setRows(8);
	     		newsList = newsService.queryNewsList(newsdto,pd);
	      		if (newsList != null && newsList.size() > 0) {
	      			for (int i = 0; i < newsList.size(); i++) {
	      				News bean = (News) newsList.get(i);
			%>
					<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*18,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
			<%
					}
				}
			%>
			</ul>
		</div>
	</div>
	<div class="page_right_two">
		<ul class="images_ul2">
	 	<li><a href="<%=contextPath %>/jsp/asfoodsafe/user_login.jsp" target="_blank"><img src="<%=contextPath %>/jsp/asfoodsafe/images/qyzc2.jpg"></a></li>
	 	<li><a href="<%=contextPath %>/jsp/asfoodsafe/user_login.jsp" target="_blank"><img src="<%=contextPath %>/jsp/asfoodsafe/images/qydl.jpg"></a></li>
	 	<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=2017062317020172925970950');"><img src="<%=contextPath %>/jsp/asfoodsafe/images/mzsm.jpg" style="margin-bottom:3px"></a></li>
	 	<li><img src="<%=contextPath %>/jsp/asfoodsafe/images/kfdh2.jpg"></li>
	 	</ul>
	</div>
</div>

<div style="margin:0 auto;text-align:center;margin:5px 0;">
	<a href=""><img src="<%=contextPath %>/jsp/asfoodsafe/images/zh.jpg" style=""></a>
</div>

<div class="page_wrap_two">
	<div class="page_left_two">
		<div id="zwgg">
	        <h2 class="news_h2"><span class="news_more"><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/com_list.jsp?currlocation=追溯企业');">更多>></a></span><span class="news_title_span">溯源企业</span></h2>
			<ul class="news_ul" id="content">
			<%
				PcompanyDTO dto = new PcompanyDTO();
				pd.setPage(1);
	     		pd.setRows(8);
	     		TmsyjApiService tmsyjApiService = new TmsyjApiService();
	     		Map m = tmsyjApiService.getPcompanyList(request, dto, pd);
	     		List comList = (List) m.get("rows");
	      		if (comList != null && comList.size() > 0) {
	      			for (int i = 0; i < comList.size(); i++) {
	      				Map m2 = (Map) comList.get(i);
	      				Object comid = m2.get("comid");
	      				Object commc = m2.get("commc");
	      				String commc2 = PubFunc.abbreviate(commc.toString(),2*18,"...");
	      				Object comclrq = m2.get("comclrq");
			%>
			<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/com_detail.jsp?comid=<%=comid %>&commc=<%=commc%>');" title="<%=commc%>"><%=commc2%></a><span>2017-10-10</span></li>
			<%
					}
				}
			%>
			</ul>
		</div>
	</div>
	<div class="page_center_two">
	 	<div id="zwgg">
	    	<h2 class="news_h2"><span class="news_more"><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_list.jsp?currlocation=政策法规&catejc=gjzc');">更多>></a></span><span class="news_title_span">政策法规</span></h2>
			<ul class="news_ul">
			<%
				newsdto.setCatejc("gjzc");
				pd.setPage(1);
	     		pd.setRows(8);
	     		newsList = newsService.queryNewsList(newsdto,pd);
	      		if (newsList != null && newsList.size() > 0) {
	      			for (int i = 0; i < newsList.size(); i++) {
	      				News bean = (News) newsList.get(i);
			%>
					<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=<%=bean.getNewsid() %>');" title="<%=bean.getNewstitle()%>"><%=PubFunc.abbreviate(bean.getNewstitle(),2*18,"...")%></a><span><%=PubFunc.split(bean.getNewstjsj().toString()," ")[0]%></span></li>
			<%
					}
				}
			%>
			</ul>
		</div>
	</div>
	<div class="page_right_two">
		<ul class="images_ul">
		<li><a href="javascript:linkToBlank('<%=contextPath %>/jsp/asfoodsafe/news_detail.jsp?newsid=2017062317020149685258464');"><img src="<%=contextPath %>/jsp/asfoodsafe/images/gypt.jpg"></a></li>
		<li><a href="<%=contextPath %>/jsp/asfoodsafe/lxwm.jsp" target="_blank"><img src="<%=contextPath %>/jsp/asfoodsafe/images/lxwm.jpg"></a></li>
		</ul>
	</div>
</div>

<jsp:include page="${contextPath}/jsp/asfoodsafe/footer.jsp"></jsp:include>
</body>
</html>