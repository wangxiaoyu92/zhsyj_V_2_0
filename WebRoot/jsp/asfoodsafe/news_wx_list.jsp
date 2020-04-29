<%@ page language="java" import="java.util.*,com.zzhdsoft.siweb.entity.news.News,com.zzhdsoft.utils.StringHelper" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>河南安盛科技股份有限公司</title>
<meta name="viewport"
content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telphone=no, email=no" />
<meta name="keywords" content="安盛,安盛科技,河南安盛,安盛科技股份,河南安盛科技肌份有限公司,食品安全,食品溯源,食品安全溯源,食品药品安全,食品药品监管,食品药品信息化" />
<meta name="description" content="河南安盛科技股份有限公司(www.hnaskj.com)是国内领先的IT解决方案和行业应用软件设计及服务提供商，国内首批社会保险管理信息系统研发企业，国内首批食品药品安全监管信息化平台研发企业。公司秉承技术创新、引领行业、成就客户、至诚守信的企业理念，致力于为政府、企事业单位等行业信息化提供一体化应用解决方案。深度提供IT咨询规划、软件定制开发、数据增值挖掘、系统集成维护等本地化专业服务。公司拥有一批诚信敬业、专注卓越的技术研发和销售服务团队，始终秉承“为客户创造价值”的服务理念。" />
<link rel="stylesheet" href="../jslib/layuiv1.0.7/css/layui.css" />
<link rel="stylesheet" href="../jsp/asfoodsafe/css/wx_css.css" />
</head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cate_name=request.getAttribute("cate_name")==null?"":request.getAttribute("cate_name").toString();
String cate_id=request.getAttribute("cate_id")==null?"":request.getAttribute("cate_id").toString();
int currPage=request.getAttribute("page")==null?1:Integer.parseInt(request.getAttribute("page").toString());
int pageSize=request.getAttribute("pageSize")==null?1:Integer.parseInt(request.getAttribute("pageSize").toString());
int totalPage=request.getAttribute("totalPage")==null?0:Integer.parseInt(request.getAttribute("totalPage").toString());
//int totalCount=request.getAttribute("totalcount")==null?0:Integer.parseInt(request.getAttribute("totalcount").toString());
List dataList=request.getAttribute("newslist")==null?null:(List)request.getAttribute("newslist");
%>
<body>
<div class="layui-main">
<!--
<div class="view-crumb"><a href="./"><i class="icon">&#xe603;</i> 首页</a><em>&gt;</em>列表
</div>
<div class="clear"></div>-->

<br/>
<!-- 主体开始 https://www.awobaba.cn/-->
<div class="main-box">

<div class="box-primary">

<div class="box-list">
<%
if(null!=dataList && dataList.size()>0){
	News bean=null;
	String news_is_picture="N";
	String fj_path="";
	//BsNewsService newService=new BsNewsService();
	for(int i=0;i<dataList.size();i++){
		bean=(News)dataList.get(i);
		//news_is_picture=bean.getNewsIsPicture();
		fj_path=bean.getNewsfjpath();
		//fj_path=newService.getNewsFjPathByNewsId(bean.getNewsId());//uploads/20140828185602208.jpg
%>
	<div class="li-list">
		<%if(!"".equals(fj_path)){%>
			<div class="thumb"><a href="<%=basePath %>/news/queryWxNewsDetail?newsid=<%=bean.getNewsid()%>&model=wx"><img lay-src="<%=basePath+fj_path %>" src="<%=basePath+fj_path %>" alt="<%=bean.getNewstitle() %>"></a> </div>
		<%}else{%>
			<div class="thumb"><a href="<%=basePath %>/news/queryWxNewsDetail?newsid=<%=bean.getNewsid()%>&model=wx"><img lay-src="images/noimg.png" src="images/noimg.png" alt="<%=bean.getNewstitle() %>"></a> </div>
		<%}%>
		<div class="list-title"><a href="<%=basePath %>/news/queryWxNewsDetail?newsid=<%=bean.getNewsid()%>&model=wx" title="<%=bean.getNewstitle()%>"><%=bean.getNewstitle()%></a></div>
	    <div class="list-content">
	    <%=StringHelper.filterStringHTML(bean.getNewscontent(),300, "...").replaceAll("</?[^>]+>", "").replaceAll("<a>\\s*|\t|\r|\n</a>", "")%> </div>
	<span class="title-r"></span>  
	<span class="meta"> 
		<span class="date"><i class="icon">&#xe615;</i>&nbsp;<%=bean.getNewstjsj()%></span>
	</span>
	<div class="clear"></div>
	<span class="more"><a href="<%=basePath %>/news/queryWxNewsDetail?newsid=<%=bean.getNewsid()%>&model=wx">阅读全文</a></span>
  </div>
<% }
 }%>

<!-- 分页 s -->
<div class="clear"></div>
<div class="navigation pagination">
	<div class="nav-links">
	<%
//如果想改变每页显示的记录数，请在下面的URL传递参数pageSize，默认20
if(currPage<=1){%> 
<%}else{%> 
	<a href="<%=basePath %>news/queryWxNewsList?cateid=<%=cate_id %>&page=1&model=wx&pageSize=5"><i class="icon">首页</i></a>
	<a href="<%=basePath %>news/queryWxNewsList?cateid=<%=cate_id %>&page=<%=currPage-1 %>&model=wx&pageSize=5"><i class="icon">&#xe610;</i>上一页</a>
<%} 
 
if(currPage<totalPage && totalPage!=0){%> 
	<a href="<%=basePath %>news/queryWxNewsList?cateid=<%=cate_id %>&page=<%=currPage+1 %>&model=wx&pageSize=5">下一页<i class="icon">&#xe614;</i></a>
	<a href="<%=basePath %>news/queryWxNewsList?cateid=<%=cate_id %>&page=<%=totalPage %>&model=wx&pageSize=5"><i class="icon">最后页</i></a>
<%}else{%> 
<%}%>
<!-- 
		<a href="index-0.html"><i class="icon">&#xe610;</i></a>
		<span class="current">1</span>
		<a href="index-2.html">2</a>
		<a href="index-3.html"><i class="icon">&#xe614;</i></a>
 -->
 	</div>
</div>
<!-- 分页 e -->
<!-- 分页 e -->
</div>



</div>

<!-- 主体结束 -->
</div>
<div class="clear"></div>
</div>


</div>
<script src="jslib/layuiv1.0.7/layui.js" charset="utf-8"></script>
<script>
layui.config({
base : '/static/js/'
}).use([ 'list', 'global' ]);
</script> 
 
<div class="site-info">
<p>Copyright &copy;2016 <a rel="nofollow" target="_blank" href="http://www.hnaskj.com/">河南安盛科技股份有限公司</a> 版权所有.</p>
<p>联系电话 0371-65751486</p>
</body>
</html>