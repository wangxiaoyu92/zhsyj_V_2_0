<%@ page language="java" import="java.util.*,com.zzhdsoft.siweb.dto.UploadfjDTO" pageEncoding="utf-8"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath;
%>
<%
	List fjList = (List)request.getAttribute("fjList");
	String browserNameVersion=(null==request.getParameter("browserNameVersion")?"":request.getParameter("browserNameVersion").toString());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   	<head>
  	<base target="_self" />
  	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  	<title>查看附件</title>
<script src="<%=contextPath%>/jslib/jquery-1.9.1.js"></script>
  	<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
  	<!-- imageview图片插件 -->
  	
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/jslib/imageview/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/jslib/imageview/css/default.css">
	<link rel="stylesheet" href="<%=contextPath%>/jslib/imageview/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=contextPath%>/jslib/imageview/dist/viewer.css">
	<link rel="stylesheet" href="<%=contextPath%>/jslib/imageview/css/main.css">
	<script src="<%=contextPath%>/jslib/imageview/dist/custom.modernizr.js"></script>
	<script src="<%=contextPath%>/jslib/imageview/assets/js/bootstrap.min.js"></script>
	<script src="<%=contextPath%>/jslib/imageview/dist/viewer.js"></script>
	<script src="<%=contextPath%>/jslib/imageview/assets/js/main.js"></script>
	
<script type="text/javascript">
	function showBigPicture(v_img_src){
		var obj = new Object();
		var url = "<%=basePath %>/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src="+v_img_src+"&time="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 1000,
			height : 600,
			url : url
		});
	};
</script>
</head>
<body>
	<div style="width:100%;height:200px;text-align:center;">
	<%
	if(null!=fjList && fjList.size()>0){
		UploadfjDTO beanFj = null;
   		String v_PicPath = basePath;
   		String fileExpend = null;
   		out.println("附件预览：<br/>");
   		//out.println("<div class=\"col-sm-8 col-md-6\">");
		//out.println("<div class=\"docs-galley\">");
		out.println("<ul  class=\"docs-pictures clearfix\">");
   		String v_imgsrc = "";
   		for(int i=0;i<fjList.size();i++){
   		 	beanFj = (UploadfjDTO)fjList.get(i);
   		    v_imgsrc = v_PicPath + beanFj.getFjpath().replace("\\","/");
   		    fileExpend = beanFj.getFjpath().substring(beanFj.getFjpath().lastIndexOf("."));
   		    if("yes".equals(browserNameVersion)){//
       			out.println("<div style=\"float:left;text-align:center;\"><img width=\"260px\" height=\"260px\" style=\"padding:2px;border:1px solid #ccc;\" src=\""+v_imgsrc+"\" onClick=\"showBigPicture('"+v_imgsrc+"');\"/><br/></div>");
       		}else{//
       		    out.println("<li style=\"float:left;text-align:center;\"><img width=\"260px\" height=\"260px\"style=\"padding:2px;border:1px solid #ccc;\" data-original=\""+v_imgsrc+"\" src=\""+v_imgsrc+"\"/><br/></li>");
       		}		
   		}
   		out.println("</ul>");
		//out.println("</div>");
		//out.println("</div>");    		
    }
    %>
	</div>
	
	<br/>
	<br/>
</body>
</html>