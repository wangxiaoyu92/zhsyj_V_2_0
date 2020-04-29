var select_player_window = '2';
var select_player_windowId= '1';
var w_map = {'1':null,'2':null,'3':null,'4':null};

function loadCameraPlayer(){
	var playerHtml = '<div class="player">'+
		'<div id="p_1" class="player4"></div>'+
		'<div id="p_2" class="player4"></div>'+
		'<div id="p_3" class="player4"></div>'+
		'<div id="p_4" class="player4"></div>'+
	'</div>'+
	'<div class="list">'+
		'<div class="listTitle">'+
			'<div class="listTitleLeft"><h4>监控列表</h4></div>'+
			'<div class="listTitleRight">'+
				
			'</div>'+
			'</div>'+
		'<div class="listCentre">'+
			'<ul>'+
	        '</ul>'+
		'</div>'+
		'<div class="listBottom">'+
			'<div id="s_player" class="btn-group">'+
		        '<a id="playwindow_1" class="btn btn-primary" href="javascript:void(0);"><span class="fui-checkbox-unchecked"></span>单</a>'+
		        '<a id="playwindow_2" class="btn btn-primary active" href="javascript:void(0);"><span class="fui-list-large-thumbnails"></span>四</a>'+
		      '</div>'+
			'<div id="s_window" class="btn-group">'+
              '<a id="c_1" class="btn btn-primary active" href="javascript:void(0);"><span class="fui-list-large-thumbnails"></span>1</a>'+
              '<a id="c_2" class="btn btn-primary" href="javascript:void(0);"><span class="fui-list-large-thumbnails"></span>2</a>'+
              '<a id="c_3" class="btn btn-primary" href="javascript:void(0);"><span class="fui-list-large-thumbnails"></span>3</a>'+
              '<a id="c_4" class="btn btn-primary" href="javascript:void(0);"><span class="fui-list-large-thumbnails"></span>4</a>'+
            '</div>'+
		'</div>'+
	'</div>';
	$(".mclzPlayer").append(playerHtml);
	$('#p_1').addClass('player_s');
	$('#s_player').on('click', 'a', function () {
      $(this).siblings().removeClass('active').end().addClass('active');
      if($(this).attr("id")=="playwindow_1"){
    	  select_player_window = '1';
    	  /*$("#p_1").attr("class","player1");
    	  $("#p_2").hide();
    	  $("#p_3").hide();
    	  $("#p_4").hide();*/
    	  for(var i = 1;i<5;i++){
    		  if(select_player_windowId==i+""){
    			  $("#p_"+i).attr("class","player1");
    		  }else{
    			  $("#p_"+i+" object").remove(); 
    			  $("#p_"+w_map[i+""]).find('span').attr("class","fui-play");
    			  w_map[i+""]=null;
    			  $("#p_"+i).hide();
    		  }
    	  }
    	  $('#s_window').hide();
    	  
      }else if($(this).attr("id")=="playwindow_2"){
    	  select_player_window = '2';
    	  /*$("#p_1").attr("class","player4");
    	  $("#p_2").show();
    	  $("#p_3").show();
    	  $("#p_4").show();*/
    	  for(var i = 1;i<5;i++){
    		  if(select_player_windowId==i+""){
    			  $("#p_"+i).attr("class","player4");
    		  }else{
    			  $("#p_"+i).show();
    		  }
    	  }
    	  $('#s_window').show();
    	  $('#p_'+select_player_windowId).addClass('player_s');
      }
    });
    $('#s_window').on('click', 'a', function () {
       $(this).siblings().removeClass('active').end().addClass('active');
       $('.player4').siblings().removeClass('player_s');
       var nub = $(this).attr("id").substring(2,3);
       $('#p_'+nub).addClass('player_s');
       select_player_windowId = nub;
     });
}
//获取食品列表
function loadCameraList(){
	$.ajax({   
        type: "POST",  
        dataType: "json",  
        url: BasePath+'/jk/jkgl/queryJky',      
        data : {jkqybh : jkqybh},                   
        success: function(data) {
            $(".listCentre ul li").remove();      
            var cams = data.rows;
            var htmstr = "";
            if(cams&&cams.length>0){
            	//企业信息
//            	htmstr +='<li class="camList" >'+
//          		'<img src="" />&nbsp;企业</li>';
           		for(var i = 0;i<cams.length;i++){
           			var cam = cams[i];
           			htmstr += '<li class="camList" id="p_'+cam.jkybh+'">'+
					          	'<a href="javascript:void(0)">'+
					          		'<img src='+BasePath+'jslib/myflashflowplayer/img/Webcam.png />'+
					          		'&nbsp;'+cam.jkymc+
					          	'</a>'+
					            '<span class="fui-play"></span>'+
					          '</li>';
           		}
            }
            $(".listCentre ul").append(htmstr);
            $('.camList').hover(function(){
            	$(this).attr("class","camList2");
            },function(){
            	$(this).attr("class","camList");
            });
            $('.listCentre ul').on('click', 'li', function () {
                /*$(this).siblings().removeClass('active').end().addClass('active');*/
            	viewCameraNew(this);
            });
        }  
    }); 
}


//获取url
function viewCameraNew(cam){
	var camId = cam.id.substring(2,cam.id.length);
	if(!isPlay(camId)){
		addMclzPlayObjNew(camId,"http://218.29.171.186:20001/play_video?channel=sub%26cam_indexcode",select_player_windowId);
		$(cam).find('span').attr("class","fui-pause");
		if(w_map[select_player_windowId]!=null){		
			$("#p_"+w_map[select_player_windowId]).find('span').attr("class","fui-play");
		}
		w_map[select_player_windowId]=camId;
		getNextWindow();
	}else{
		alert("正在播放该监控！");
	}
}

//判断url 地址属性(播放视屏)
function addMclzPlayObjNew(id,url,htmlObjID){
	var camId = id;//视屏id
//	var playUrl = url;//播放地址
	var playUrl = "http://218.29.171.186:20001/play_video?channel=sub%26cam_indexcode="+camId;//播放地址
	var playlist = [{
			autoPlay: true,
			autoBuffering:false,
			url: playUrl,
			live:true,
			maliu:0
        }
    ];
	
	flowplayer('p_'+select_player_windowId, BasePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
		loop: false,
        clip: {
            autoPlay: true,
            autoBuffering:true,
            leftYunTai:'dasd',
            accelerated:true,//开启硬件加速
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
                stop: false,//停止按钮
				//gaoqing:true,
				//liuchang:true,
                fullscreen: false, //全屏按钮
                scrubber: true,//进度条
                time: true, //是否显示时间信息
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
function isPlay(camId){
	for(var i = 1;i<5;i++){
		if(w_map[i+""]==camId){
			return true;
		}
	}
	return false;
}

function getNextWindow(){
	if(select_player_window=='2'){
		var nub = Number(select_player_windowId);
		nub++;
		if(nub>4){
			nub = 1;
		}
		$('#c_'+nub).click();
	}
}


//获取url
function viewCamera(cam){
	var camId = cam.id.substring(2,cam.id.length);
	if(!isPlay(camId)){
		$.ajax({   
	        type: "POST",  
	        dataType: "text", 
	        url: BasePath+'cameraAction!getUrlByCmaId.action',       
	        data : {camId :camId},
	        success: function(data) {
	        	var jsonData = $.parseJSON(data);
	        	if(jsonData.success){
	        		addMclzPlayObj(jsonData.obj,select_player_windowId);
	        		$(cam).find('span').attr("class","fui-pause");
					if(w_map[select_player_windowId]!=null){		
						$("#p_"+w_map[select_player_windowId]).find('span').attr("class","fui-play");
					}
					w_map[select_player_windowId]=camId;
	        		getNextWindow();
	        	}else{
	        		alert("未获取到播放地址");
	        	}
	        },
	        error : function() {    
	        	alert("未获取到播放地址");    
	        }  
	    }); 
	}else{
		alert("正在播放该监控！");
	}
}

//判断url地址属性
function addMclzPlayObj(data,htmlObjID){
	var camId = data.id;//视屏id
	var map = data.attributes;//视频属性
	var playUrl = map.playUrl;//播放地址
	var control_cloud = false;
	if(map.control_cloud==1){
		control_cloud = true;
	}
	var focus = false;
	if(map.focus==1){
		focus = true;
	}
	var screenshot = false;
	if(map.screenshot==1){
		screenshot = true;
	}
	var recording = false;
	if(map.recording==1){
		recording = true;
	}
	var playback = false;
	if(map.playback==1){
		playback = true;
	}
	var talkback = false;
	if(map.talkback==1){
		talkback = true;
	}
	var fullScreen = false;
	if(map.fullScreen==1){
		fullScreen = true;
	}
	var cut = false;
	if(map.cut==1){
		cut = true;
	}
	var playlist = [{
			autoPlay: true,
			autoBuffering:false,
			url: playUrl,
			live:true,
			maliu:0
        }
    ];
	if(cut){//判断是否拥有切换码流的权限
		var mainPlayUrl = playUrl.replace("sub", "main");
		playlist = [//播放列表  注意第一个是流畅   第二个是高清
		            {
						autoPlay: true,
						autoBuffering:false,
						url: playUrl,
						crossdomain : 'http://218.29.171.189:20001/crossdomain.xml',
						live:true,
						maliu:0,
						leftYunTai:'qwe',
						webServlet:BasePath+'ptzControlAction!notAuth_ptzControl.action',
						camId:camId,
						speed:4
		            },{
		                autoPlay: true,
						autoBuffering:false,
						url: mainPlayUrl,
						crossdomain : 'http://218.29.171.189:20001/crossdomain.xml',
						live:true,
						maliu:1,
						leftYunTai:'uyi',
						webServlet:BasePath+'ptzControlAction!notAuth_ptzControl.action',
						camId:camId,
						speed:4
		            }
		        ];
	}
	flowplayer('p_'+select_player_windowId, BasePath + "jslib/myflashflowplayer/flowplayer.commercial.swf", {
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
                stop: false,//停止按钮
				//gaoqing:true,
				//liuchang:true,
                fullscreen: fullScreen, //全屏按钮
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
        showErrors:false
    });
}


