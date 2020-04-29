<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>课件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>

<script type="text/javascript">
	var fileurl; // 文件路径
	var wareType; // 课件类型
	$(function(){
		fileurl = $("#wareVideo").val();
		wareType = $("#wareType").val();
		if (wareType == 1) { // 视频
			$("#videoPlayer").show();
			loadVideoPlayer();
		} else if (wareType == 2) { // 图片
			$("#imageViewer").show();
			loadImgViewer();
		} else if (wareType == 3) { // pdf
			$("#pdfViewer").show();
			loadPdfViewer();
		};
/* 		else if (wareType == 4) { // 图文
			$("#picwordViewer").show();
			loadpicwordViewer();
		} */
		
	});
	// 加载pdf预览
	function loadImgViewer() {
		var url = basePath + "images/noimg.gif";
		if (fileurl != "") {
			url = basePath + fileurl;
		}
		// 检查文件是否存在
		$.ajax({
			type : "POST",
		   	url: basePath + "api/train/checkWareIsExit",
		   	data: {'wareVideo' : fileurl},
		   	success: function(data){
		   		data = eval('(' + data + ')');
				if (data.isExit == 1) {
					$("#imgIframe").attr("src", url);
				} else if (data.isExit == -1) {
					$("#imgIframe").attr("src", basePath + "images/noimg.gif"); 
				}
		   }
		});
		
		/* // 查看服务器上文件是否存在
		var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.open("GET", url, false);
		xmlhttp.send();
		if (xmlhttp.readyState == 4) {   
			if (xmlhttp.status == 200) { // 存在
				$("#imgIframe").attr("src", url);
			} else if (xmlhttp.status == 404) { // 不存在
				$("#imgIframe").attr("src", basePath + "images/noimg.gif"); 
			}   
		} */
	}
	// 加载pdf预览
	function loadPdfViewer() {
		var url = basePath + "jslib/pdfjs/web/default.pdf";
		if (fileurl != "") {
			url = basePath + fileurl;
		}
		var iframeUrl = basePath + "jslib/pdfjs/web/viewer.html?file=";
		// 检查文件是否存在
		$.ajax({
			type : "POST",
		   	url: basePath + "api/train/checkWareIsExit",
		   	data: {'wareVideo' : fileurl},
		   	success: function(data){
		   		data = eval('(' + data + ')');
				if (data.isExit == 1) {
					$("#pdfIframe").attr("src", iframeUrl + url);
				} else if (data.isExit == -1) {
					$("#pdfIframe").attr("src", iframeUrl + basePath + "jslib/pdfjs/web/default.pdf"); 
				}
		   }
		});
		/* // 查看服务器上文件是否存在
		var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.open("GET", url, false);
		xmlhttp.send();
		if (xmlhttp.readyState == 4) {   
			if (xmlhttp.status == 200) { // 存在
				$("#pdfIframe").attr("src", iframeUrl + url);
			} else if (xmlhttp.status == 404) { // 不存在
				$("#pdfIframe").attr("src", iframeUrl + basePath + "jslib/pdfjs/web/default.pdf");   
			}   
		} */
	}
	
	// 加载图文预览
/* 	function loadpicwordViewer() {
		var v_wareId=$("#wareId").val();
		var iframeUrl = basePath + "train/courseware/showPicwordIndex?wareId="+v_wareId;
		$("#picwordIframe").attr("src", iframeUrl );
	}	 */
	
	// 加载视频播放器
	function loadVideoPlayer() {
		flowplayer("videoPlayer", basePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
	        clip: {
	        	url : basePath + fileurl, // 视频地址
	            autoPlay : false, // 自动播放
	            autoBuffering : true, // 是否自动缓存
	            accelerated : true //开启硬件加速
            },
	        plugins: {
	            controls : {
	                bottom : 0, // 功能条距底部的距离
	                height : 24, // 功能条高度
	                zIndex : 1,
	                fontColor : '#ffffff',
	                timeFontColor : '#333333',
	                play : true, // 开始按钮
	                volume : true, // 音量按钮
	                mute : false, // 静音按钮
	                stop : true,// 停止按钮
	                fullscreen : true, // 全屏按钮
	                scrubber : true,// 进度条
	                time : true, // 是否显示时间信息
	                autoHide : true, // 功能条是否自动隐藏
	                maliu : false, // 清晰度
					yuntai : false, // 云台
					jinJiao : false, // 近焦
					yuanJiao : false, // 远焦
					jieping : false, // 截屏
	                tooltips : {
	                    buttons : true, // 是 否显示
	                    fullscreen : '全屏',// 全屏按钮，鼠标指上时显示的文本
	                    stop : '停止',
	                    play : '开始',
	                    volume : '音量',
	                    mute : '静音',
	                    next : '下一个',
	                    previous : '上一个'
	                }
	            }
	        },
	        showErrors:false
	    });
	}
	
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
		<div region="center" style="overflow: auto;" border="false">
			<input type="hidden" id="wareVideo" value="${courseware.wareVideo}">
			<input type="hidden" id="wareType" value="${courseware.wareType}">
			<input type="hidden" id="wareId" value="${courseware.wareId}">
   			<span>课件名称：</span><span id="wareName">${courseware.wareName}</span><br>
   			<span>课件时长：</span><span id="wareLength">${courseware.wareLength}</span>分
   			<span>课件学分</span><span id="warePoint">${courseware.warePoint}</span>
			<sicp3:groupbox title="课件">
				<div id="videoPlayer" style="width:800px; height:500px; display: none;" align="center"></div>
				<div id="imageViewer" style="width:800px; height:500px; display: none;" align="center">
					<img width="100%" height="480px" id="imgIframe">
				</div>
				<div id="pdfViewer" style="width:800px; height:500px; overflow: auto; display: none;" align="center" >
					<iframe width="780px" height="480px" id="pdfIframe"></iframe> 
				</div>
<!-- 				<div id="picwordViewer" style="width:800px; height:500px; overflow: auto; display: none;" align="center" >
					<iframe width="780px" height="480px" id="picwordIframe"></iframe> 
				</div>		 -->		
						
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>