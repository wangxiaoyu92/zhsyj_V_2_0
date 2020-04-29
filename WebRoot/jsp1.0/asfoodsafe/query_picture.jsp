<%@ page language="java" import="java.util.*,com.xml.vo.BsProductFj,com.xml.service.com.BsSymService" pageEncoding="UTF-8"%>
<%@ include file="query_head.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();
BsSymService service=null;
List dataList=null;
BsProductFj bean=null;
String sym_state="";
if(!"".equals(sym)){
	service=new BsSymService();
	sym_state=service.checkSym(sym);
	if("ok".equals(sym_state)){
		dataList=service.getProductFjInfo(sym);
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>二维码溯源查询</title>
    <link rel="stylesheet" media="all" type="text/css" href="redbox/jquery-rebox.css" />	
<script type="text/javascript" src="redbox/lib/jquery-litelighter.js"></script>
<script type="text/javascript" src="redbox/jquery-rebox.js"></script>
<style>
.gallery img{width:150px;height:150px;padding:5px;border:1px solid #ccc;}
.gallery a:hover img{padding:5px;border:1px solid blue;}
</style>
<script type="text/javascript">	
	var sym='<%=sym%>';
	var sym_state='<%=sym_state%>';
	if(sym.length==0){
		alert('请输入追溯码！');
		top.location.href='index.jsp';
	}
	if(sym.length>0 && sym_state!="ok"){
	    alert('不好意思，系统平台查询不到此追溯码，请输入有效的追溯码！');
		top.location.href='index.jsp';
	}
    	
$(document).ready(function(){
	$('#gallery2').rebox({ selector: 'a' });
});
</script>
  </head>
<body>

<div class="example-container">
	<h3>产品图片</h3>
	<div>
		<div id="gallery2" class="gallery">
		<% 
		if(null!=dataList && dataList.size()>0){
			for(int i=0;i<dataList.size();i++){
				bean=(BsProductFj)dataList.get(i);
				out.println("<a href=\""+basePath+bean.getFjPath()+"\" title=\"\"><img src=\""+basePath+bean.getFjPath()+"\"></a>");
			}
		}else{
			out.println("<img src=\"images/notp.jpg\">");
		}
		%>
		<!-- 
			<a href="images/01.jpg" title="Caption for image A"><img src="images/01.jpg" /></a>
			<a href="images/02.jpg" title="Caption for image B"><img src="images/02.jpg" /></a>
			<a href="images/03.jpg" title="Caption for image C"><img src="images/03.jpg" /></a>
		 -->
		 </div>
	</div>
</div>
<%@ include file="query_footer.jsp"%>
</body>
</html>