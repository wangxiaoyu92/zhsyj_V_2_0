<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_jkybh = StringHelper.showNull2Empty(request.getParameter("jkybh"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<style type="text/css">
.player11{
	margin:0 5px 0 5px;
	width:915px;
	height:500px;
	background-color: black;
	float:center;
}
</style>
<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
</head>
<body>
	<div id="mclzPlayers"></div>
</body>
</html>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_jkybh = '<%=t_jkybh%>';
	
	$(function () {
		loadCameraPlayer(t_jkybh);
    });
    
	function loadCameraPlayer(jkybh){		        	
 		$("#mclzPlayers").append("<div id='p_" + jkybh + "' class='player11'></div>");
 		addMclzPlayNewObj(jkybh);
 		//addRtmpPlayNewObj(jkybh);
	}

	//播放视频
	var control_cloud = false;
	var focus = false;
	var screenshot = false;	
	function addMclzPlayNewObj(jkybh){
		var camId = jkybh;//视频源id	
		var playUrl = videourl + camId;//播放地址		
		var playlist = [{
				autoPlay: true,
				autoBuffering:false,
				url: playUrl,  
				live:true,
				maliu:0
	        }
	    ];
				
		var cut = true;
		if (cut) {//判断是否拥有切换码流的权限
			var mainPlayUrl = playUrl.replace("sub", "main");
			playlist = [//播放列表：注意第一个是高清；第二个是流畅；
					{
						autoPlay : true,
						autoBuffering : false,
						url : mainPlayUrl,
						live : true,
						maliu : 1,
						leftYunTai : 'uyi',
						camId : camId,
						speed : 4
					},
					{
						autoPlay : true,
						autoBuffering : false,
						url : playUrl,
						live : true,
						maliu : 0,
						leftYunTai : 'qwe',
						camId : camId,
						speed : 4
					}];
		}
		flowplayer('p_' + camId, basePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
			loop : false,
			clip : {
				autoPlay : true,
				autoBuffering : true,
				leftYunTai : 'dasd',
				accelerated : true //开启硬件加速
			},
			playlist : playlist,
			plugins : {
				yuntai : {},
				controls : {
					bottom : 0,//功能条距底部的距离
					height : 24, //功能条高度
					zIndex : 1,
					fontColor : '#ffffff',
					timeFontColor : '#333333',
					play : true, //开始按钮
					volume : true, //音量按钮
					mute : false, //静音按钮
					stop : false,//停止按钮
					//gaoqing:true,
					//liuchang:true,
					fullscreen : true, //全屏按钮
					scrubber : true,//进度条
					time : true, //是否显示时间信息
					autoHide : true, //功能条是否自动隐藏
					maliu : cut,
					yuntai : control_cloud,
					jinJiao : focus,
					yuanJiao : focus,
					jieping : screenshot,
					tooltips : {
						buttons : true,//是否显示
						fullscreen : '全屏',//全屏按钮，鼠标指上时显示的文本
						stop : '停止',
						play : '开始',
						volume : '音量',
						mute : '静音',
						next : '下一个',
						previous : '上一个'
					}
				}
			},
			showErrors : false
		});
	}
	
	function addRtmpPlayNewObj(jkybh){
		var camId = jkybh;//视频源id	
		var playUrl = videourl + camId;//播放地址
		var cut = false;		
		flowplayer('p_' + camId, basePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
			loop: false,
	        clip: {
	        	autoPlay: true,
	            autoBuffering:true,
	            url: playUrl,
	            scaling: 'fit',
	            provider: 'hddn',
	            live: true,
	            accelerated:true,//开启硬件加速
	        },
	        //playlist: playlist,
	        plugins: {
	        	yuntai :{},
	        	hddn: {
	                url: basePath + "jslib/myflashflowplayer/flowplayer.rtmp-3.2.13.swf",
	                netConnectionUrl: playUrl
	            },
	            controls: {
	                bottom: 0,//功能条距底部的距离
	                height: 24, //功能条高度
	                zIndex: 1,
	                fontColor: '#ffffff',
	                timeFontColor: '#333333',
	                play:true, //开始按钮
	                volume: true, //音量按钮
	                mute: false, //静音按钮
	                stop: false,//停止按钮
					//gaoqing:true,
					//liuchang:true,
	                fullscreen: true, //全屏按钮
	                scrubber: true,//进度条
	                time: true, //是否显示时间信息
	                autoHide: true, //功能条是否自动隐藏
	                maliu:cut,
					yuntai:control_cloud,
					jinJiao:focus,
					yuanJiao:focus,
					jieping:screenshot,
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
	        showErrors:true
	    });
	}
</script>
