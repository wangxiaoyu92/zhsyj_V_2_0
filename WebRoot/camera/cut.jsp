<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.*,com.zzhdsoft.utils.cut.OperateImage"%>
<%
	response.setHeader("Expires","0");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragrma","no-cache");
	response.setDateHeader("Expires",0);
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>裁切照片</title>
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="friendxxy,friendxxy" />
</head>  
<body>
<%
	String  rootpath = application.getRealPath("/");//绝对路径
	String  ctxpath = request.getContextPath();//相对路径
	String  oldFilename = request.getParameter("fileName");
	//System.out.print("源图片：" + oldFilename);
	
	String  oldFilePath = rootpath + "camera" + File.separator + "upload"  + File.separator + oldFilename;
	String  newFilePath = rootpath + "camera" + File.separator + "upload"  + File.separator + oldFilename; 
	String  max_height= request.getParameter("max_height");
	String  max_width= request.getParameter("max_width");
	String  top= request.getParameter("top");//y
	String  left= request.getParameter("left");//x
	String  width= request.getParameter("width");
	String  height= request.getParameter("height");
	
	//System.out.println(oldFilePath);
	//System.out.println(newFilePath);
	
	OperateImage oImage = new OperateImage();
	oImage.operate(Integer.parseInt(left),Integer.parseInt(top),Integer.parseInt(width),Integer.parseInt(height),oldFilePath,newFilePath);
%>

<script type="text/javascript">
	window.location.href = 'index.jsp?fileName=<%=ctxpath%>/camera/upload/<%=oldFilename%>' 
</script>
</body>
</html>
