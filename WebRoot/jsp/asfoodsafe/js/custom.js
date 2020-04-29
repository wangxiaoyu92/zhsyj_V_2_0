

//获取url传递参数值
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg); //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
//获取本时刻
function getDateTime() {
    var d = new Date();
    var year = d.getFullYear();
    var month = (d.getMonth() + 1 > 0 && d.getMonth() + 1 < 10) ? '0' + (d.getMonth() + 1) : d.getMonth() + 1;
    var day = (d.getDate() > 0 && d.getDate() < 10) ? '0' + d.getDate() : d.getDate();
    var hours = (d.getHours() > 0 && d.getHours() < 10) ? '0' + d.getHours() : d.getHours();
    var minutes = (d.getMinutes() > 0 && d.getMinutes() < 10) ? '0' + d.getMinutes() : d.getMinutes();
    var second = (d.getSeconds() > 0 && d.getSeconds() < 10) ? '0' + d.getSeconds() : d.getSeconds();
    return year + "/" + month + "/" + day + " " + hours + ":" + minutes + ":" + second;
}
//获取上周、本周、下周
function obaganlestyle(snum, lnum) {
    var returnlist = new Array();
    var myDate = new Date();
    var day = myDate.getDay();//返回0-6
    //var today = new Array('星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六');
    //当天的日期
    var endday;
    var startday;
    endday = getthisDay(-day + lnum); //算得周日
    startday = getthisDay(-day + snum);//算的周一
    returnlist.push(startday);
    returnlist.push(endday);
    return returnlist;
}
function getthisDay(day) {
    var today = new Date();
    var targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
    today.setTime(targetday_milliseconds); //关键
    var tyear = today.getFullYear();
    var tMonth = today.getMonth();
    var tDate = today.getDate();
    if (tDate < 10) {
        tDate = "0" + tDate;
    }
    tMonth = tMonth + 1;
    if (tMonth < 10) {
        tMonth = "0" + tMonth;
    }
    return tyear + "/" + tMonth + "/" + tDate + "";
}

function getTip(msg) {
    layer.msg(msg, {
        offset: 0,
        shift: 6
    });
}
String.prototype.trim = function () {
    var str = this ,
    str = str.replace(/^\s\s*/, '' ),
    ws = /\s/,
    i = str.length;
    while (ws.test(str.charAt(--i)));
    return str.slice(0, i ,1);
}
