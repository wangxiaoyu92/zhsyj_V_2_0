<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
	response.setHeader("Expires","0");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragrma","no-cache");
	response.setDateHeader("Expires",0);
%>
<%
	String ctxpath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ctxpath+"/";
	String fileName = request.getParameter("fileName");
    //System.out.println(fileName);
%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%=ctxpath%>/camera/js/mootools-for-crop.js"> </script>
	<script type="text/javascript" src="<%=ctxpath%>/camera/js/UvumiCrop-compressed.js"> </script>
	<link rel="stylesheet" type="text/css" media="screen" href="<%=ctxpath%>/camera/css/uvumi-crop.css" />
	<style type="text/css">
		body,html{
			background-color:#333;
			margin:0;
			padding:0;
			font-family:Trebuchet MS, Helvetica, sans-serif;
		}

		hr{
			margin:20px 0;
		}

		#main{
			margin:5%;
			position:relative;
			overflow:auto;
			color:#aaa;
			padding:10px;
			border:1px solid #888;
			background-color:#000;
			text-align:center;
			width:350px;
			height:300px;
		}

		#resize_coords{
			width:300px;
		}

		#previewExample3{
			margin:10px;
		}

		.yellowSelection{
			border: 2px dotted #FFB82F;
		}

		.blueMask{
			background-color:#00f;
			cursor:pointer;
		}
	</style>
	<script type="text/javascript">
		exampleCropper1 = new uvumiCropper('example1',{
		    keepRatio:false,
			coordinates:true,
			preview:true,
			downloadButton:true,
			cancelButton:true,
			saveButton:false
		});
	</script>
</head>
<body>
	<div id="main">
		<div>
			<p>
				<img id="example1" src="<%=fileName%>" alt="照片裁切"/> 
			</p>
		</div>
	</div>
</body>
</html>
