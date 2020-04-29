/**
 * jQuery jslides 1.1.0
 *
 * http://www.cactussoft.cn
 *
 * Copyright (c) 2009 - 2013 Jerry
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

/*********定义全局变量*********/
var fullUrl = window.location.href;//全路径
var currentUrl = window.location.pathname;//当前路径
var pathname = currentUrl.substring(0, currentUrl.substr(1).indexOf("/") + 1);//项目名
var relUrl = fullUrl.substring(0, fullUrl.lastIndexOf("/") + 1);//相对路径
var homeURL = window.location.host + pathname;//根路径
var basePath=pathname+'/';
var contextPath=homeURL+'/';

var videourl = "rtmp://117.158.242.70:1935/live/pag/127.0.0.1/7302/";
var videourl_err_tip = "http://www.shejian360.com/download/erro.mp4";

/*更换top*/
var dalei='';
function setTop (comdalei,dl,pageNum, pageSize, pageSum){
	var color;
	if(comdalei==''||comdalei==null){
		dalei=dl;
	}else{
		dalei = comdalei.substring(0, comdalei.length - 1);
	}
	$("#top").load("muban_top.html");
	if (dalei == '10120') {
		color = '#B02828';//餐饮
	} else if (dalei == '10130') {
		color = '#B8641B';//流通
	} else if (dalei == '10140') {
		color = '#0A7D44';//菜市场
	} else {
		color = '#2d286b';//生产
	}
	page(pageSize, pageNum, pageSum, color);
}


$(function(){
	var numpic = $('#slides li').size()-1;
	var nownow = 0;
	var inout = 0;
	var TT = 0;
	var SPEED = 5000;


	$('#slides li').eq(0).siblings('li').css({'display':'none'});


	var ulstart = '<ul id="pagination">',
		ulcontent = '',
		ulend = '</ul>';
	ADDLI();
	var pagination = $('#pagination li');
	var paginationwidth = $('#pagination').width();
	$('#pagination').css('margin-left',(470-paginationwidth))
	
	pagination.eq(0).addClass('current')
		
	function ADDLI(){
		//var lilicount = numpic + 1;
		for(var i = 0; i <= numpic; i++){
			ulcontent += '<li>' + '<a href="#">' + (i+1) + '</a>' + '</li>';
		}
		
		$('#slides').after(ulstart + ulcontent + ulend);	
	}

	pagination.on('click',DOTCHANGE)
	
	function DOTCHANGE(){
		
		var changenow = $(this).index();
		
		$('#slides li').eq(nownow).css('z-index','900');
		$('#slides li').eq(changenow).css({'z-index':'800'}).show();
		pagination.eq(changenow).addClass('current').siblings('li').removeClass('current');
		$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(changenow).fadeIn(500);});
		nownow = changenow;
	}
	
	pagination.mouseenter(function(){
		inout = 1;
	})
	
	pagination.mouseleave(function(){
		inout = 0;
	})
	
	function GOGO(){
		
		var NN = nownow+1;
		
		if( inout == 1 ){
			} else {
			if(nownow < numpic){
			$('#slides li').eq(nownow).css('z-index','900');
			$('#slides li').eq(NN).css({'z-index':'800'}).show();
			pagination.eq(NN).addClass('current').siblings('li').removeClass('current');
			$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(NN).fadeIn(500);});
			nownow += 1;

		}else{
			NN = 0;
			$('#slides li').eq(nownow).css('z-index','900');
			$('#slides li').eq(NN).stop(true,true).css({'z-index':'800'}).show();
			$('#slides li').eq(nownow).fadeOut(400,function(){$('#slides li').eq(0).fadeIn(500);});
			pagination.eq(NN).addClass('current').siblings('li').removeClass('current');

			nownow=0;

			}
		}
		TT = setTimeout(GOGO, SPEED);
	}
	
	TT = setTimeout(GOGO, SPEED); 

})