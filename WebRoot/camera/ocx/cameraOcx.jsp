<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.lbs.commons.GlobalNameS"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="java.util.Date" %> 
<%@ page import="java.io.*" %>
<%@ page import="com.lbs.commons.GlobalNameS" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
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
	if (fileName==null || fileName=="") {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String cdStr = sdf.format(new Date());
		fileName = cdStr + ((int) (Math.random() * 100000 + 10000));//设置拍照图片名称
	}
	String  rootpath = application.getRealPath("/");//绝对路径
	String filePath = rootpath + GlobalNameS.CAMERA_UPLOAD_FILE_PATH + File.separator;
	filePath = filePath.replace("\\","\\\\");
%>
<!DOCTYPE html>
<html>
<head>
<title>照片采集OCX插件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var ocxObject;//获得OCX对象
	$(function() {
		ocxObject = document.getElementById('ocx1');//获得OCX对象
		ocxObject.ImageHeight = 160;
		ocxObject.ImageWidth = 130;
		ocxObject.ImageFileName = '<%=fileName%>';
		ocxObject.FileSavePath = '<%=filePath%>';
	});

	var getPhotoCallBack = function($dialog, $form, $bac901, $pjq){
		var ImageFileName = ocxObject.closeCamera('close');
    	$dialog.dialog('close');
    	if(ImageFileName != ""){
			$bac901.attr('src',"<%=contextPath%>/camera/upload/" + ImageFileName + "?" + Math.random());
			$form.form('load',{
				filepath : "<%=contextPath%>/camera/upload/" + ImageFileName
    		});
    	}
	};

	var cancelCallBack = function($dialog, $pjq){
		var ImageFileName = ocxObject.closeCamera('close');
    	$dialog.dialog('close');
	};
	
	function setMsg(){
		ocxObject.ImageHeight = 160;
		ocxObject.ImageWidth = 130;
		ocxObject.ImageFileName = "110101199605270010";
	}
	
	function getMsg(){
	    var returnValue = ocxObject.ImageHeight + '/' + ocxObject.ImageWidth + '/' + ocxObject.ImageFileName;   
		alert(ocxObject.FileSavePath + ocxObject.ImageFileName + ".jpg");
	}

	function TakePicture(){
		ocxObject.TakePicture("d:",160,130);
	}

	function closeCamera(){
		var ImageFileName = ocxObject.closeCamera('close');
		alert(ImageFileName);
	}
</script>

<script type="text/javascript" event='OnClick' for='videoCapOcx'>	
	//alert('js响应OCX的单击事件测试：你单击了OCX控件！');	
</script>

</head>
<body>
	<table>
		<!--  
		<tr>
			<td><input type='button' width='200' value='设置OCX对外公开的属性值' onclick='setMsg();'/></td>
			<td><input type='button' width='200' value='获取OCX对外公开的属性值' onclick='getMsg();'/></td>
		</tr>
		<tr>
			<td><input type='button' width='200' value='调用OCX对外公开的方法TakePicture' onclick='TakePicture();'/></td>
			<td><input type='button' width='200' value='调用OCX对外公开的方法closeCamera' onclick='closeCamera();'/></td>
		</tr>
		-->
		<tr>
			<td>
				<object id='ocx1' name='videoCapOcx' 
					  classid="clsid:B9364BFF-5AA3-44B0-877E-B7979A926CA9"
					  width='703'
					  height='400'
					  align='center'
					  hspace='0'
					  vspace='0'
				>
				</object>
			</td>
		</tr>
	</table>
</body>
</html>