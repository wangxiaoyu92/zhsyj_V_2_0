<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String v_videopath = StringHelper.showNull2Empty(request.getParameter("videopath"));
%>
<!DOCTYPE html>
<html>
<head>
<title>视频播放</title>
<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
<script type="text/javascript">
	var BasePath = '<%=basePath%>';
	var b_videopath = '<%=v_videopath%>';
	var v_playUrl=BasePath+b_videopath;
	
	$(function() {
       playurl();
	});
	
	//判断url地址属性(播放视频)
	function playurl(){
		var playlist = [{
				autoPlay: true,
				autoBuffering:true,
				url: v_playUrl,  
				live:true,
				maliu:0
	        }
	    ];
		
		flowplayer('p_1', BasePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
			loop: false,
	        clip: {
	            autoPlay: true,
	            autoBuffering:true,
	            leftYunTai:'dasd',
	            accelerated:true//开启硬件加速
	        },
	        playlist: playlist,
	        plugins: {
	        	yuntai :{},
	            controls: {
	                bottom: 0,//功能条距底部的距离
	                height: 24, //功能条高度
	                zIndex: 1,
	                fontColor: '#ffffff',
	                timeFontColor: '#333333',
	                play:true, //开始按钮
	                volume: true, //音量按钮
	                mute: false, //静音按钮
	                stop: true,//停止按钮
					//gaoqing:true,
					//liuchang:true,
	                fullscreen: true, //全屏按钮
	                scrubber: false,//进度条
	                time: false, //是否显示时间信息
	                autoHide: true, //功能条是否自动隐藏
	                maliu:false,
					yuntai:false,
					jinJiao:false,
					yuanJiao:false,
					jieping:false,
	                tooltips: {
	                    buttons: true,//是否显示
	                    fullscreen: '全屏',//全屏按钮，鼠标指上时显示的文本
	                    stop:'停止',
	                    play:'开始',
	                    volume:'音量',
	                    mute: '静音',
	                    next:'下一个',
	                    previous:'上一个'
	                }
	            }
	        },
	        showErrors:false
	    });
	}
	
		// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
</script>
</head>
<body>
	<div class="mclzPlayer" >
	<div id='p_1' class='player4'></div>
	</div>
</body>
</html>