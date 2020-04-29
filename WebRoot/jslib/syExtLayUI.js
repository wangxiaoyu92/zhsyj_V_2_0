var selectTableBackGroundColor = "#90E2DA"; // 被选中数据表格行背景颜色
var sy = sy || {};

/**
 * 创建一个模式化的dialog
 * 
 * @author 翟建峰
 * 
 * @requires jQuery,EasyUI
 * 
 */
sy.modalDialog = function(options,callback) {
	var extHeight = 105;
	var screenHeight = window.screen.availHeight;
	//alert(screenHeight)
	//gu20180515 options.area[1]=(screenHeight-105-200)+'px';
	options.maxmin=true;
	var dialog_id = sy.getUUID(8,16);
	//layer提供了5种层类型。
	// 可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）。
	// 若你采用layer.open({type: 1})方式调用，则type为必填项（信息框除外）
	var opts = $.extend({
		id : dialog_id,
		title : '&nbsp;',
		//area : ['800px', '450px'],
		type : 2,
		moveOut : true, // 允许拖拽到窗口外
		maxmin : true,
		shade :  [0.8, 'gray'],
		end: function(){
			//if (callback&&sy.getWinRet(dialog_id)!=null) {
            if (callback) {
				callback(dialog_id);
			}
			return true;
		}
	}, options);
	opts.type = 2;
	var sylayer = null;
	if (opts.content) {
		var urlparam = "";
		var index = 0;
		var v_url = "";
		var paramSymbol = ((opts.content.indexOf("?")==-1)?"?":"&");
		if(!sy.IsNullFlag(opts.param)){
			$.each(options.param,function(key,value){
				if(index!=0){
					urlparam = urlparam + "&" + key + "=" + value;
				}else{
					urlparam = urlparam + paramSymbol + key + "=" + value;
				}
				index = index + 1;
			})
			v_url = opts.content + urlparam + "&dialog_random_id=" + dialog_id;
		}else{
			v_url = opts.content + paramSymbol + "dialog_random_id=" + dialog_id;
		}
		opts.content = v_url;
		sylayer = layer.open(
			opts
		);
	}

	return sylayer;
};

/**
 * 创建一个模式化的dialog
 *
 * @author 翟建峰
 *
 * @requires jQuery,EasyUI
 *
 */
sy.modalDialogLayui = function(options,callback) {
    var extHeight = 105;
    var screenHeight = window.screen.availHeight;
    //alert(screenHeight)
    //gu20180515 options.area[1]=(screenHeight-105-200)+'px';
    options.maxmin=true;
    var dialog_id = sy.getUUID(8,16);
    //layer提供了5种层类型。
    // 可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）。
    // 若你采用layer.open({type: 1})方式调用，则type为必填项（信息框除外）
    var opts = $.extend({
        id : dialog_id,
        title : '&nbsp;',
        //area : ['800px', '450px'],
        type : 2,
        moveOut : true, // 允许拖拽到窗口外
        maxmin : true,
        shade :  [0.8, 'gray'],
        end: function(){
            //if (callback&&sy.getWinRet(dialog_id)!=null) {
            if (callback) {
                callback(dialog_id);
            }
            return true;
        }
    }, options);
    opts.type = 2;
    var sylayer = null;
    if (opts.content) {
        var urlparam = "";
        var index = 0;
        var v_url = "";
        var paramSymbol = ((opts.content.indexOf("?")==-1)?"?":"&");
        if(!sy.IsNullFlag(opts.param)){
            $.each(options.param,function(key,value){
                if(index!=0){
                    urlparam = urlparam + "&" + key + "=" + value;
                }else{
                    urlparam = urlparam + paramSymbol + key + "=" + value;
                }
                index = index + 1;
            })
            v_url = opts.content + urlparam + "&dialog_random_id=" + dialog_id;
        }else{
            v_url = opts.content + paramSymbol + "dialog_random_id=" + dialog_id;
        }
        opts.content = v_url;
        sylayer = layer.open(
            opts
        );
    }

    return sylayer;
};

/**
 * 设置模态窗口返回对象
 * @param prmValue
 * @param prmKey
 */
sy.setWinRet = function(prmValue,prmKey){
	prmKey = sy.getDialogId() + sy.IsNull(prmKey);
	//对象转化为字符串
	var xx = JSON.stringify(prmValue);
	window.LS.set(prmKey,xx);
};

/**
 * 获取模态窗口返回对象
 * @param prmDialogId
 * @param prmKey
 * @returns
 */
sy.getWinRet = function(prmDialogId,prmKey){
	prmKey = prmDialogId + sy.IsNull(prmKey);
	var prmValue = window.LS.get(prmKey);
	if(prmValue==undefined||prmValue=='undefined'||prmValue==undefined||prmValue==""||prmValue==null){
		return null;
	}
	//字符串解析转化成对象
	return JSON.parse(window.LS.get(prmKey));
};

/**
 * 删除模态窗口返回对象
 * @param prmDialogId
 * @param prmKey
 */
sy.removeWinRet = function(prmDialogId,prmKey){
	prmKey = prmDialogId + sy.IsNull(prmKey);
	window.LS.remove(prmKey);
};

/**
 * 判断值是否为Null
 * @param val
 * @returns
 */
sy.IsNull = function(val) {
    if (typeof (val) == "undefined" || val == undefined || val == "" || val == 'null' || val == 'undefined') {
        return "";
    }else {
        return val;
    }
}
sy.IsNullFlag = function(val) {
    if (typeof (val) == "undefined" || val == undefined || val == "" || val == 'null' || val == 'undefined') {
        return true;
    }else {
        return false;
    }
}

/**
 * 生成UUID
 * @param len
 * @param radix
 * @returns
 */
sy.getUUID = function(len, radix) {
	var chars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
	var uuid = [], i;
	radix = radix || chars.length;

	if (len) {
		for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
	} else {
		var r;
		uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
		uuid[14] = '4';
		for (i = 0; i < 36; i++) {
			if (!uuid[i]) {
				r = 0 | Math.random()*16;
				uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
			}
		}
	}

	return uuid.join('');
}

/**
 * 获取模态窗口ID
 */
sy.getDialogId = function(){
	return sy.getUrlParam("dialog_random_id");
}

/**
 * 获取url中的参数
 * @param name
 * @returns
 */
sy.getUrlParam = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r != null) return unescape(r[2]); return null; //返回参数值
}


// 时间格式化
Date.prototype.format = function (format) {
    /*
    * eg:format="yyyy-MM-dd hh:mm:ss";
    */
    if (!format) {
        format = "yyyy-MM-dd hh:mm:ss";
    }
 
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    };
 
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
 
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
};
