//本机公网测试地址
//var ServerURL = "http://hhwl2.nat123.net/hhwl/common/sjb";
//var ServerRootURL = "http://hhwl2.nat123.net/hhwl";

//本机测试地址
//var ServerURL = "http://127.0.0.1:8080/hhwl/common/sjb";
//var ServerRootURL = "http://127.0.0.1:8080/hhwl";

//物流公司网址
var ServerURL = "http://61.158.232.27/hhwl/common/sjb";
var ServerRootURL = "http://61.158.232.27/hhwl";


var alertFlag;
var confirmFlag;

function $$(id)
{
	return document.getElementById(id);
}
function setHtml(id, html) {
	if ("string" == typeof(id)) {
		var ele = $$(id);
		if (ele != null) {
			ele.innerHTML = html == null ? "" : html;
		}
	} else if (id != null) {
		id.innerHTML = html == null ? "" : html;
	}
}

function toastInfo(msg){	
	$('.tips').text(msg);
	$('.tips').stop().animate({'opacity': '0.6'}, 1500, function () {
        $(this).animate({'opacity': '0'}, 1500);
    })
}
function alertInfo(msg,flag){
	var winWidth = $(window).width();
    var winHeight = $(window).height();
    var dialogWidth = $('#dialog_alert').width();
    var dialogHeight = $('#dialog_alert').height();
    var dialogTop = (winHeight - dialogHeight) / 2;
    var dialogLeft = (winWidth - dialogWidth) / 2;
    $('#dialog_alert').css({"top": dialogTop, "left": dialogLeft});    
    
    $("#dialog_alert .al-footer .confirm_alert").live("touchstart", function () {
        $(this).addClass("c-confirm");
    });
    $("#dialog_alert .al-footer .confirm_alert").live("touchend", function () {
        $(this).removeClass("c-confirm");
    });
    
    $('#dialog_alert .al-con').html(msg);
    $('#dialog_alert').show();
    $('.layer').show();
    
    alertFlag = flag;
}
function confirmInfo(msg,flag){
	var winWidth = $(window).width();
    var winHeight = $(window).height();
    var dialogWidth = $('#dialog_confirm').width();
    var dialogHeight = $('#dialog_confirm').height();
    var dialogTop = (winHeight - dialogHeight) / 2;
    var dialogLeft = (winWidth - dialogWidth) / 2;
    $('#dialog_confirm').css({"top": dialogTop, "left": dialogLeft});    
    
    $("#dialog_confirm .al-footer .cancel").live("touchstart", function () {
        $(this).addClass("c-cancel");
    });
    $("#dialog_confirm .al-footer .cancel").live("touchend", function () {
        $(this).removeClass("c-cancel");
    });
    $("#dialog_confirm .al-footer .confirm").live("touchstart", function () {
        $(this).addClass("c-confirm");
    });
    $("#dialog_confirm .al-footer .confirm").live("touchend", function () {
        $(this).removeClass("c-confirm");
    });
    
    $('#dialog_confirm .al-con').html(msg);
    $('#dialog_confirm').show();
    $('.layer').show();
    
    confirmFlag = flag;
}

//接收地址栏参数
function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);

	if (r != null){
		return unescape(r[2]);
	}
	return null;
}

function Getjsonp(surl, sdata, callback) {
	$.ajax({
		type : "GET",
		dataType : "jsonp",
		jsonp : "jsonpcallback",
		url : surl,
		data : sdata,
		success : function(dataObj) {
			callback(dataObj);
		}
	});
}

// 绑定开始时间
function BindStartTime() {
	var tbTime = new Date();	
	var year = tbTime.getFullYear();
	var month = (tbTime.getMonth()) + 1;
	if (month < 10) {
		month = "0" + month;
	} else {
		month = month;
	}
	var day = tbTime.getDate();
	if (day < 10) {
		day = "0" + day;
	} else {
		day = day;
	}
	return year + "-" + month + "-" + "01";
}

// 绑定结束时间
function BindEndTime() {
	var tbTime = new Date();
	var year = tbTime.getFullYear();
	var month = (tbTime.getMonth()) + 1;
	if (month < 10) {
		month = "0" + month;
	} else {
		month = month;
	}
	var day = parseInt(getLastDateOfMonth(year, month).getUTCDate() + 1);// 每月的最后一天
	return year + "-" + month + "-" + day;
}

// 计算下个月的前一天
function getLastDateOfMonth(year, month) {
	return new Date(new Date(year, month, 1).getTime() - 1000 * 60 * 60 * 24);
}

function BindNowTime() {
	var dd = new Date();
	var year = dd.getFullYear();
	var month = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd
			.getMonth() + 1);// 获取当前月份的日期，不足10补0
	var day = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate(); // 获取当前几号，不足10补0

	return year + "-" + month + "-" + day;
}

function BindFirstLastTime(ob) {
	var firstDate = new Date();
	firstDate.setDate(1); // 第一天
	var endDate = new Date(firstDate);
	endDate.setMonth(firstDate.getMonth() + 1);
	endDate.setDate(0);
	if (ob == 0) {
		return new Date(firstDate);// 本月第一天
	} else {
		return new Date(endDate);// 本月最后一天
	}

}

// 获取当前时间的前*天
function GetDateStr(AddDayCount) {
	var dd = new Date();
	dd.setDate(dd.getDate() - AddDayCount);// 获取AddDayCount天后的日期
	var y = dd.getFullYear();
	var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd
			.getMonth() + 1);// 获取当前月份的日期，不足10补0
	var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate(); // 获取当前几号，不足10补0

	return y + "-" + m + "-" + d;
}