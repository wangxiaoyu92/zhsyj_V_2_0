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
	  <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;食品</div> 
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
	  var v_local_cateJc="<%=v_cateJc%>";
	  if (v_local_cateJc==null || v_local_cateJc=="" || v_local_cateJc=="ggtz_sp"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;食品";
	  }else if (v_local_cateJc=="ggtz_yp"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;药品";
	  }else if (v_local_cateJc=="ggtz_bjp"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;保健品";
	  }else if (v_local_cateJc=="ggtz_hzp"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;化妆品";
	  }else if (v_local_cateJc=="ggtz_ylqx"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;医疗器械";
	  }else if (v_local_cateJc=="ggtz_zyys"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;执业药师";
	  }else if (v_local_cateJc=="ggtz_qt"){
		  DangQianWeiZhi.innerHTML="<span>当前位置</span>&nbsp;&gt;&nbsp;公告通知&nbsp;&gt;&nbsp;其他";
	  }
  }
  myshowpostion();
</script>

<body>
<div class="mid_bg">
  <div class="h20 clear"></div>
  
  <div class="ntit_2">
    <ul>
      <li class="marr10"><a id="ggtz_sp"  href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_sp&page=1" class="curr" >食品</a></li>
      <li class="marr10"><a id="ggtz_yp"  href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_yp&page=1">药品</a></li>
      <li class="marr10"><a id="ggtz_bjp" href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_bjp&page=1" >保健品</a></li>
      <li class="marr10"><a id="ggtz_hzp" href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_hzp&page=1">化妆品</a></li>
      <li class="marr10"><a id="ggtz_ylqx" href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_ylqx&page=1">医疗器械</a></li>
      <li class="marr10"><a id="ggtz_zyys" href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_zyys&page=1">执业药师</a></li>
      <li><a id="ggtz_qt" href="<%=contextPath %>/news/queryNewsList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize%>&cateJc=ggtz_qt&page=1">其他</a></li>
    </ul>
  </div>
  
  <%@ include file="pubmiddle.jsp"%>
  
  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>

<script type="text/javascript">
	//根据返回的cate_jc定位 
	function myshoworhidden(){		
		var v_local_cate_jc="<%=v_cateJc%>";
		if (v_local_cate_jc==null || v_local_cate_jc==""){
			return;
		}
		document.getElementById("ggtz_sp").className = "";
		document.getElementById("ggtz_bjp").className = "";	
		document.getElementById("ggtz_yp").className = "";	
		document.getElementById("ggtz_hzp").className = "";	
		document.getElementById("ggtz_ylqx").className = "";
		document.getElementById("ggtz_zyys").className = "";
		document.getElementById("ggtz_qt").className = "";
		
		if (v_local_cate_jc=="ggtz_sp"){//食品
			document.getElementById("ggtz_sp").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_bjp"){//保健品
			document.getElementById("ggtz_bjp").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_yp"){//药品
			document.getElementById("ggtz_yp").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_hzp"){//化妆品
			document.getElementById("ggtz_hzp").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_ylqx"){//医疗器械
			document.getElementById("ggtz_ylqx").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_zyys"){//职业药师
			document.getElementById("ggtz_zyys").className = "curr";	
		}else if (v_local_cate_jc=="ggtz_qt"){//其他
			document.getElementById("ggtz_qt").className = "curr";	
		}	
	};

    myshoworhidden();
</script>
 
</body>
</html>