//====提取url参数
$.extend({
    getUrlParams: function () {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    },
    getUrlParam: function (name) {
        return $.getUrlParams()[name];
    }
});

//加载数据
function AjaxJson(url, callBack) {
    $.ajax({
        url: url,
        type: "post",
        dataType: "json",
        async: false,
        success: function (data) {
            callBack(data);
        },
        error: function (data) {
            alert("获取数据失败");
        }
    });
}

/*AjaxJson扩展方法*/
$.extend({
    AjaxJson: function (url,param, callBack) {
        $.ajax({
            url: url,
            type: "post",
            data:param,
            dataType: "json",
            async: false,
            success: function (data) {
                callBack(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                LayMsg("加载超时....");
            }
        });
    }
});

//设置cookie
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

//获取cookie
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
    }
    return "";
}

//清除cookie  
function clearCookie(name) {
    setCookie(name, "", -1);
}

//分页
function pagination(container, callback) {
    $(container).jqPaginator({
        totalPages: totalPages, //设置分页的总页数
        visiblePages: 6, //设置最多显示的页码数
        pageSize: 10, // 设置页大小
        currentPage: currentPage, //设置当前的页码
        first: '<li class="first"><a href="javascript:void(0);">首页<\/a><\/li>',
        prev: '<li class="prev"><a href="javascript:void(0);"><i class=\"arrow arrow2\"><\/i>上一页<\/a><\/li>',
        next: '<li class="next"><a href="javascript:void(0);">下一页<i class=\"arrow arrow3\"><\/i><\/a><\/li>',
        last: '<li class="last"><a href="javascript:void(0);">末页<\/a><\/li>',
        page: '<li class="page"><a href="javascript:void(0);">{{page}}<\/a><\/li>',
        onPageChange: function (num, type) {
            if (type == "change") {
                callback(num);
            }
        }
    });
}

//获取页面内容
function AjaxHtml(url, callBack, dType) {
    $.ajax({
        url: url,
        type: "get",
        dataType: dType,
        async: false,
        success: function (data) {
            callBack(data);
        },
        error: function (data) {
            LayMsg("加载超时！");
        }
    });
}

//获取部分内容
function getPartContent(content, length) {
    if (content.length > length) {
        return content.substring(0, length) + "....";
    }
    return content;
}

//值为空时赋值
function IsEmpty(content) {
    if (content == null || typeof (content) == "undefined" || content == "") {
        return "无";
    }else {
        return content;
    }
}

//判断值是否为Null
function IsNull(val) {
    if (typeof (val) == "undefined" || val == undefined || val == "" || val == 'null' || val == 'undefined') {
        return "";
    }else {
        return val;
    }
}

function checkImg(url) {
	if (typeof (url) == "undefined" || url == undefined || url == "" || url == 'null' || url == 'undefined') {
        return "images/kong.jpg";
    }else {
        return basePath + url;
    }
}

function linkToSelf(v_url){
	var url = encodeURI(v_url);
	window.open(url);
}

function linkToSelf(v_url){
	var url = encodeURI(v_url);
	window.location.href = url;
}

function makeStar(id,t_pjxj){   	
	for (var i = 0; i <= t_pjxj; i++) {
		$("#" + id + " .tjxinxing").eq(i).attr("src","images/star_gold.png");
	}
	if (t_pjxj < 2) {
		$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;不满意");
	} else if (t_pjxj < 3) {
		$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;一般");
	} else if (t_pjxj < 4) {
		$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;满意");
	} else {
		$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;很满意");
	}
	for (i = t_pjxj + 1; i < 5; i++) {
		$("#" + id + " .tjxinxing").eq(i).attr("src","images/star_gray.png");
	}
}

function showStar(id,t_pjxj){
	$.each($("#" + id + " .tjxinxing"), function (index, item) {
		for (var i = 0; i <= t_pjxj; i++) {
			$("#" + id + " .tjxinxing").eq(i).attr("src","images/star_gold.png");
		}
		if (t_pjxj < 2) {
			$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;不满意");
		} else if (t_pjxj < 3) {
			$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;一般");
		} else if (t_pjxj < 4) {
			$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;满意");
		} else {
			$("#" + id + " .tjpjpl").html("&nbsp;&nbsp;很满意");
		}
	});
}

function checkStar(){
	var flag = "1";
	$.each($(".pjxj"), function (index, item) {
		var id = $(this).attr("id");//alert(id);
		var pjxj = IsNull($("#" + id).data("num"));//alert(pjxj);
		if(pjxj==""){
	    	alert("请选择评价星级！");
	    	flag = "0";
	    	return false;
	    }
	});
	return flag;
}

function getStar(score){
	var cs = 0; // 需要循环的次数
	var xj = "";
	if(score >= 90 && score <= 100){
		cs = 5;
	}else if(score >= 80 && score < 90){
		cs = 4;
	}else if(score >= 70 && score < 80){
		cs = 3;
	}else if(score >= 60 && score < 70){
		cs = 2;
	}else{
		cs = 1;
	}
	
	for (var i = 0; i < cs; i++) {
		xj += "<img style='float:none;margin:0;' src='images/star.jpg'/>"
	}
	return xj;
}

function showDiv(id){
	$("#"+id).show();
}

function hideDiv(id){
	$("#"+id).hide();
}

