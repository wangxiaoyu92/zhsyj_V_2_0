<%@ page language="java" import="java.util.*,com.zzhdsoft.siweb.entity.news.News,com.zzhdsoft.utils.StringHelper" 
pageEncoding="UTF-8"%>
<%
News news=request.getAttribute("news")==null?null:(News)request.getAttribute("news");
request.setAttribute("news",news);

News preNews=request.getAttribute("preNews")==null?null:(News)request.getAttribute("preNews");
request.setAttribute("preNews",preNews);

News nextNews=request.getAttribute("nextNews")==null?null:(News)request.getAttribute("nextNews");
request.setAttribute("nextNews",nextNews);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>安盛科技-${news.newstitle }</title>
<meta name="viewport"
content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telphone=no, email=no" />
<meta name="keywords" content="安盛,安盛科技,河南安盛,安盛科技股份,河南安盛科技肌份有限公司,食品安全,食品溯源,食品安全溯源,食品药品安全,食品药品监管,食品药品信息化" />
<meta name="description" content="安盛科技-${news.newstitle }" />
<link rel="stylesheet" href="../jslib/layuiv1.0.7/css/layui.css" />
<link rel="stylesheet" href="../jsp/asfoodsafe/css/wx_css.css" />
</head>
<body>



<!--
https://www.awobaba.cn/view-9.html
<div class="banner-box">
<div class="banner-text">
<p class="banner-title">经验随谈</p>
<p>归纳博客所有文件,一目了然~</p>
</div>
</div> -->
<div class="layui-main">
<!--
<div class="view-crumb">
<a href="./"><i class="icon">&#xe603;</i> 首页</a><em>&gt;</em><a href="./list-5.html">经验随谈</a><em>&gt;</em>正文 </div>
<div class="clear"></div>-->

<!-- 主体开始 -->
<div class="main-box">
<div class="box-primary">
<div class="box-view">

<!-- 标题 -->
<div class="view-title">
<h2>${news.newstitle}</h2>
<div class="view-info">

<span class="date"><i class="icon">&#xe615;</i>&nbsp;&nbsp;${news.newstjsj}</span>
<span class="icon edit"></span>
</div>
<!-- top工具 -->
<div class="view-tool">
<ul class="tool-meta">
<!--<li class="t-views"><i class="icon">&#xe7fc;</i>58</li>-->
</ul>
<div class="clear"></div>
</div>
<div class="clear"></div>
</div>

<div class="box-content">
<div class="view-content">
${news.newscontent}
</div>
<div class="clear"></div>
</div>

<div class="clear"></div>
</div>
<!-- 文章 e -->

<!-- 上一篇 下一篇 s -->
<div class="box-last">
<div class="view-last">
<div class="meta-nav">
<p>
<%if(null!=preNews){%>
<span>上一篇：</span><a href="news_detail.action?id=${preNews.newsid }&model=wx" title="${preNews.newstitle }">${preNews.newstitle }</a>
<%}else{%>
	   <img src="images/pre.gif" title="上一篇"/>&nbsp;没有上一篇！
<%}%>
</p>
 
<p>
<%if(null!=nextNews){%>
<span>下一篇：</span><a href="news_detail.action?id=${nextNews.newsid }&model=wx" title="${nextNews.newstitle }">${nextNews.newstitle }</a>
<%}else{%>
	   <img src="images/next.gif" title="下一篇"/>&nbsp;没有下一篇！
<%}%>
</p>
</div>

</div>
<div class="clear"></div>
</div>
<!-- 上一篇 下一篇 e -->

</div>
</div>

<!-- 右边栏 -->

<div class="clear"></div>
</div>

<script src="jslib/layuiv1.0.7/layui.js" charset="utf-8"></script>
<script>
layui.config({
base : '/static/js/'
}).use([ 'global', 'view' ]);
</script>

 
<div class="site-info">
<p>Copyright &copy;2016 <a rel="nofollow" target="_blank" href="http://www.hnaskj.com/">河南安盛科技股份有限公司</a> 版权所有.</p>
<p>联系电话 0371-65751486</p>

</body>
</html> 