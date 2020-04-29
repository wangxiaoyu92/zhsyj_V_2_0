$(function () {
    $('#top').load('template/top.html');
    $('#foot').load('template/foot.html');
    $('#news').load('template/news.html');
    $('#area').load('template/area.html');
    
    $('#top2').load('template/top2.html');
    
    sele_tab();
});

function sele_tab(){
	$(".tab_title div").mouseover(function () {
		$(".tab_title div").eq($(this).index()).addClass("table_show").siblings().removeClass("table_show");
		$(".tab_title div").eq($(this).index()).removeClass("table_hide").siblings().addClass("table_hide");
        $(".tab_list .tables").eq($(this).index()).show().siblings().hide();
    });
}

// 获取新闻列表
function LoadDataByNewestNew() {
    AjaxJson(basePath + "api/tmsyj/getNewsList?catejc=xfgs&rows=10&page=1", function (data) {
        $(data.rows).each(function (i, item) {
            alert(item.newstitle);
        })
    })
}

// 获取奖惩信息
function LoadDataBySpecialNew() {
    AjaxJson("handler/DataShow_Ajax.ashx?action=GetPunishmentByPager&rows=7&page=1", function (data) {
        $(data.rows).each(function (i, item) {
            $("#rewardslist").append("<li><span></span><a  target='_blank'  href='reward_punish_list.html?bh=" + item["id"] + "'>" + item["punishment_title"] + "</a></li>");
        })
    })
}

// 获取消费公示
function LoadDataBySpecialList() {
    AjaxJson("handler/DataShow_Ajax.ashx?action=GetWorkDynamicByPager&type=2&rows=6&page=1", function (data) {
        $(data.rows).each(function (i, item) {
            $("#specialList").append("<li><a target='_blank' href='list.html?bh=" + item["id"] + "' >" + item["title"] + "</a><span>" + item["upload_time"] + "</span></li>");
        })
    })
}