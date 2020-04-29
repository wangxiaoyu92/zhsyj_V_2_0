<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,java.util.*" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<%
	int v_loop_page = 0;
	int v_currPage = request.getAttribute("currPage") == null ? 1
			: Integer.parseInt(request.getAttribute("currPage").toString());
	int v_totalPage = request.getAttribute("totalPage") == null ? 0
			: Integer.parseInt(request.getAttribute("totalPage").toString());
	int v_totalCount = request.getAttribute("totalCount") == null ? 0
			: Integer.parseInt(request.getAttribute("totalCount").toString());
	int v_pageSize = request.getAttribute("pageSize") == null ? 1
			: Integer.parseInt(request.getAttribute("pageSize").toString());
	String v_cateJc = request.getAttribute("cateJc") == null ? ""
			: request.getAttribute("cateJc").toString();
	String v_retPageStr = request.getAttribute("retPageStr") == null ? ""
			: request.getAttribute("retPageStr").toString();
	List v_newsList = request.getAttribute("newslist") == null ? null
			: (List) request.getAttribute("newslist");
	News bean = null;
%>
<jsp:include page="head.jsp"></jsp:include>
<div class="mid_bg">
  <div class="top_4">
    <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;区县动态</div>    
    <div class="top_4c fr">
      <div class="top_4c_1 fl"><img src="<%=contextPath%>/jsp/gzfw/images/bg13.gif" width="19" height="19" /></div>
      <div class="top_4c_2 fl"><input type="text" name="textfield" id="textfield" class="txt_1" /></div>
      <div class="top_4c_3 fl"><a href="#" class="btn_1">搜索</a></div>
    </div>    
  </div>
</div>
</head>
<script type="text/javascript">
  function myshowpostion(){
	  var v_local_catejc="<%=v_cateJc%>";
	  if (v_local_catejc==null || v_local_catejc=="" || v_local_catejc=="flfg_fl"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;法律法规&nbsp;&gt;&nbsp;法律";
	  }else if (v_local_catejc=="flfg_xzfg"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;法律法规&nbsp;&gt;&nbsp;行政法规";
	  }else if (v_local_catejc=="flfg_gz"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;法律法规&nbsp;&gt;&nbsp;规章";
	  }else if (v_local_catejc=="flfg_gfxwj"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;法律法规&nbsp;&gt;&nbsp;规范性文件";
	  }   
  }
  //myshowpostion();
</script>
<body>
<div class="mid_bg">     
  <%@ include file="pubmiddle.jsp"%>
   
  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>
 
</body>
</html>