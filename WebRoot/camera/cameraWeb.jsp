<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="java.util.Date" %> 
<%@ page import="java.io.*" %>
<%
	String ctxpath = request.getContextPath();
%>
<%
	String fileName = "";	
	String aac002 = request.getParameter("aac002");
	String aac001 = request.getParameter("aac001");
	if (aac001 == null || aac001 == ""){
		fileName = aac002;	
	}else{
		fileName = aac001;
	}
	if (fileName == null || fileName == "") {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String cdStr = sdf.format(new Date());
		fileName = cdStr + ((int) (Math.random() * 100000 + 10000));//设置拍照图片名称
	}
	fileName = fileName + ".jpg";
%>
<!DOCTYPE html>
<html>
<head>
	<title>web照片采集</title>
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

		#main1{
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
	<jsp:include page="${ctxpath}/inc.jsp"></jsp:include>
	<script type="text/javascript">	
		var getPhotoCallBack = function($dialog, $form, $bac901, $pjq){
	    	$dialog.dialog('close');	    	
			$bac901.attr('src',"<%=ctxpath%>/camera/upload/<%=fileName%>?" + Math.random());
			$form.form('load',{
				filepath : "<%=ctxpath%>/camera/upload/<%=fileName%>"
    		});
		};
	
		var cancelCallBack = function($dialog, $pjq){
	    	$dialog.dialog('close');
		};
	</script>
</head>
<body>
	<table>
	<tr>
		<td valign="top">
			<div id="main1">
	
	<!-- First, include the JPEGCam JavaScript Library -->
	<script type="text/javascript" src="webcam.js"></script>
	
	<!-- Configure a few settings -->
	<script language="JavaScript">
		webcam.set_api_url('save.jsp?fileName=<%=fileName%>');
		webcam.set_quality(90); // JPEG quality (1 - 100)
		webcam.set_shutter_sound(true); // play shutter click sound
	</script>
	
	<!-- Next, write the movie to the page at 320x240 -->
	<script language="JavaScript">
		document.write(webcam.get_html(320, 240));
	</script>
	
	<!-- Some buttons for controlling things -->
	<br/>
	<form>
		<input type="button" value="属性设置" onClick="webcam.configure()">
			&nbsp;&nbsp;
		<input type="button" value="拍照" onClick="take_snapshot()">
	</form>
	
	<!-- Code to handle the server response -->
	<script language="JavaScript">	
		webcam.set_hook('onComplete', my_completion_handler);
		
		function take_snapshot() {
			// take snapshot and upload to server 
			webcam.snap();
		}
		
		function my_completion_handler(result) {
			var json = eval("(" + result + ")");
			var fileName = json.fileName;
			setTimeout(_getPhoto(fileName),10);
			// window.returnValue = fileName;
			sy.setWinRet(fileName);
			webcam.reset();// reset camera for another shot
		}

		function _getPhoto(fileName){
       		return function(){
    			getPhoto(fileName);
        	}
		}

		function getPhoto(fileName){
			document.getElementById('upload_results').innerHTML = 
				'<iframe name="import_frame" width=400 height=520 src="index.jsp?fileName='+ fileName + '"  frameborder=auto>' +
				'</iframe>';
		}
	</script>
	</div>
	</td>
	<td valign="top">
		<div id="upload_results" style="background-color:#eee;"></div>
	</td>
	</tr>
	</table>
</body>
</html>
