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
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String jklx = StringHelper.showNull2Empty(request.getParameter("jklx"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>监控摄像头列表【自动播放】</title>
	<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
	<script type="text/javascript">
        var basePath = '<%=basePath%>';
        //企业id
        var jkqybh = '<%=comid%>';
        var jklx = '<%=jklx%>';
        //视频播放地址
        if(jklx != '1'){
            videourl = basePath + 'upload/videos/'+ jklx + '/';//播放离线视频
        }

        $(function() {
            loadCameraList();
            if (jkqybh != '') {
                loadJkComFzr();
            }
        });

        // 获取监控企业的负责人
        function loadJkComFzr(){
            $.ajax({
                type: "POST",
                dataType: "json",
                url: basePath+'/jk/jkgl/queryJkfzrList',
                data : {'comid' : jkqybh },
                success: function(data) {
                    var userInfos = data.rows;
                    if (userInfos.length > 0) {
                        for (var i = 0; i < userInfos.length; i++) {
                            if (userInfos[i].username != null && userInfos[i].username != '') {
                                $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].username + "</span>");
                            }
                            if (userInfos[i].mobile2 != null && userInfos[i].mobile2 != '') {
                                $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].mobile2 + "</span>");
                            }
                        }
                    }
                }
            });
        }

        //获取企业的视频摄像头列表
        function loadCameraList(){
            $.ajax({
                type: "POST",
                dataType: "json",
                url: basePath+'/jk/jkgl/queryJky',
                data : {'jkqybh' : jkqybh,'jklx' : jklx},
                success: function(data) {
                    var cams = data.rows;
                    loadCameraPlayer(cams);
                }
            });
        }

        function loadCameraPlayer(cams){
            for(var i=0;i<cams.length;i++){
                var jkybh = cams[i].jkybh;
                var jksppath = cams[i].jksppath;
                $(".mclzPlayer").append("<div id='p_"+jkybh+"' class='player4'></div>");
                addMclzPlayObjNew(jkybh,jksppath);
            }
        }

        //判断url地址属性(播放视频)
        function addMclzPlayObjNew(id,jksppath){
            var camId = id;//视频源id
            var playUrl;
            if(jklx != '1'){
                playUrl = videourl + jksppath;//播放地址
            }
            var playlist = [{
                autoPlay: true,
                autoBuffering:true,
                url: playUrl,
                live:true,
                maliu:0
            }
            ];

            flowplayer('p_'+camId, basePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
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
<div id="fzrinfo" style="height: 40px; color: blue; font-size: 20px; margin-left: 30px;"></div>
<div class="mclzPlayer" ></div>
</body>
</html>