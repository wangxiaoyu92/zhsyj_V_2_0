/**
 * 包含easyui的扩展和常用的方法
 * 
 * @author 孙宇
 * 
 * @version 20120806
 */

var sy = $.extend({}, sy);/* 定义全局对象，类似于命名空间或包的作用 */

/**
 * 
 * 取消easyui默认开启的parser
 * 
 * 在页面加载之前，先开启一个进度条
 * 
 * 然后在页面所有easyui组件渲染完毕后，关闭进度条
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.parser.auto = false;
$(function() {
	$.messager.progress({
		text : '页面加载中....',
		interval : 100
	});
	$.parser.parse(window.document);
	window.setTimeout(function() {
		$.messager.progress('close');
		if (self != parent) {
			window.setTimeout(function() {
				try {
					parent.$.messager.progress('close');
				} catch (e) {
				}
			}, 500);
		}
	}, 1);
	$.parser.auto = true;
});

/**
 * 使panel和datagrid在加载时提示
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.fn.panel.defaults.loadingMessage = '加载中....';
$.fn.datagrid.defaults.loadMsg = '加载中....';

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 避免验证tip屏幕跑偏
 */
var removeEasyuiTipFunction = function() {
	window.setTimeout(function() {
		$('div.validatebox-tip').remove();
	}, 0);
};
$.fn.panel.defaults.onClose = removeEasyuiTipFunction;
$.fn.window.defaults.onClose = removeEasyuiTipFunction;
$.fn.dialog.defaults.onClose = removeEasyuiTipFunction;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 通用错误提示
 * 
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 */
var easyuiErrorFunction = function(XMLHttpRequest) {
	$.messager.progress('close');
	$.messager.alert('错误', XMLHttpRequest.responseText);
};
$.fn.datagrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.treegrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.tree.defaults.onLoadError = easyuiErrorFunction;
$.fn.combogrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.combobox.defaults.onLoadError = easyuiErrorFunction;
$.fn.form.defaults.onLoadError = easyuiErrorFunction;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			if (!fildOption.hidden) {
				$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			} else {
				$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			}
		}
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var field = $(item.target).attr('field');
				if (item.iconCls == 'icon-ok') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-empty'
					});
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-ok'
					});
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 防止panel/window/dialog组件超出浏览器边界
 * @param left
 * @param top
 */
var easyuiPanelOnMove = function(left, top) {
	var l = left;
	var t = top;
	if (l < 1) {
		l = 1;
	}
	if (t < 1) {
		t = 1;
	}
	var width = parseInt($(this).parent().css('width')) + 14;
	var height = parseInt($(this).parent().css('height')) + 14;
	var right = l + width;
	var buttom = t + height;
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	if (right > browserWidth) {
		l = browserWidth - width;
	}
	if (buttom > browserHeight) {
		t = browserHeight - height;
	}
	$(this).parent().css({/* 修正面板位置 */
		left : l,
		top : t
	});
};
$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
$.fn.window.defaults.onMove = easyuiPanelOnMove;
$.fn.panel.defaults.onMove = easyuiPanelOnMove;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 */
$.fn.panel.defaults.onBeforeDestroy = function() {
	var frame = $('iframe', this);
	try {
		if (frame.length > 0) {
			for ( var i = 0; i < frame.length; i++) {
				frame[i].contentWindow.document.write('');
				frame[i].contentWindow.close();
			}
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	} catch (e) {
	}
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展validatebox，添加验证两次密码功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	eqPassword : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致！'
	}
});

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展datagrid，添加动态增加或删除Editor的方法
 * 
 * 例子如下，第二个参数可以是数组
 * 
 * datagrid.datagrid('removeEditor', 'cpwd');
 * 
 * datagrid.datagrid('addEditor', [ { field : 'ccreatedatetime', editor : { type : 'datetimebox', options : { editable : false } } }, { field : 'cmodifydatetime', editor : { type : 'datetimebox', options : { editable : false } } } ]);
 * 
 */
$.extend($.fn.datagrid.methods, {
	addEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item.field);
				e.editor = item.editor;
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param.field);
			e.editor = param.editor;
		}
	},
	removeEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item);
				e.editor = {};
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param);
			e.editor = {};
		}
	}
});

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展datagrid的editor
 * 
 * 增加带复选框的下拉树
 * 
 * 增加日期时间组件editor
 * 
 * 增加多选combobox组件
 */
$.extend($.fn.datagrid.defaults.editors, {
	combocheckboxtree : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = true;
			editor.combotree(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combotree('destroy');
		},
		getValue : function(target) {
			return $(target).combotree('getValues').join(',');
		},
		setValue : function(target, value) {
			$(target).combotree('setValues', sy.getList(value));
		},
		resize : function(target, width) {
			$(target).combotree('resize', width);
		}
	},
	datetimebox : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			editor.datetimebox(options);
			return editor;
		},
		destroy : function(target) {
			$(target).datetimebox('destroy');
		},
		getValue : function(target) {
			return $(target).datetimebox('getValue');
		},
		setValue : function(target, value) {
			$(target).datetimebox('setValue', value);
		},
		resize : function(target, width) {
			$(target).datetimebox('resize', width);
		}
	},
	multiplecombobox : {
		init : function(container, options) {
			var editor = $('<input />').appendTo(container);
			options.multiple = true;
			editor.combobox(options);
			return editor;
		},
		destroy : function(target) {
			$(target).combobox('destroy');
		},
		getValue : function(target) {
			return $(target).combobox('getValues').join(',');
		},
		setValue : function(target, value) {
			$(target).combobox('setValues', sy.getList(value));
		},
		resize : function(target, width) {
			$(target).combobox('resize', width);
		}
	}
});

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * @param options
 */
sy.modalDialogbuyongle = function(options) {
    alert(99);
	var v_width=640;
	var v_height=480;
	var iframe_id = "iframe"+Math.floor(Math.random()*100000000);
	if (options.width>0){
		v_width=options.width;
	}
	if (options.height>0){
		v_height=options.height;
	}
	var opts = $.extend({
		title : '&nbsp;',
		width : v_width,
		height : v_height,
		modal : true,
		onClose : function() {
			$(this).dialog('destroy');
			if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
				try {
					alert(this.id);
					CollectGarbage();
				} catch (e) {
				}
			}
		},
		onBeforeDestroy:function() {
			var frame = $('iframe', this);
			try {
				if (frame.length > 0) {
					for ( var i = 0; i < frame.length; i++) {
						frame[i].contentWindow.document.write('');
						frame[i].contentWindow.close();
					}
					frame.remove();
					if ($.browser.msie) {
						CollectGarbage();
					}
				}
			} catch (e) {
			}
		}
	}, options);
	opts.modal = true;// 强制此dialog为模式化，无视传递过来的modal参数
	if (options.url) {
		opts.content = '<iframe id="'+iframe_id+'" src="' + options.url + '" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name="'+iframe_id+'"></iframe>';
	}
	return $('<div/>').dialog(opts);
};
/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * @param title
 *            标题
 * 
 * @param msg
 *            提示信息
 * 
 * @param fun
 *            回调方法
 */
sy.messagerConfirm = function(title, msg, fn) {
	return $.messager.confirm(title, msg, fn);
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
sy.messagerShow = function(options) {
	return $.messager.show(options);
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
sy.messagerAlert = function(title, msg, icon, fn) {
	return $.messager.alert(title, msg, icon, fn);
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI,jQuery cookie plugin
 * 
 * 更换EasyUI主题的方法
 * 
 * @param themeName
 *            主题名称
 */
sy.changeTheme = function(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for (var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			try {
				$(ifr).contents().find('#easyuiTheme').attr('href', href);
			} catch (e) {
				try {
					ifr.contentWindow.document.getElementById('easyuiTheme').href = href;
				} catch (e) {
				}
			}
		}
	}

	sy.cookie('easyuiTheme', themeName, {
		expires : 7, path : "/"
	});
};

/**
 * 更换菜单风格
 * 
 * @author 孙宇
 * @requires jQuery,EasyUI
 * @param themeName
 */
sy.changeMenu = function(themeName) {
	//切换tree和accordion
	//是否立即生效？
	sy.cookie('easyuiMenu', themeName, {
		expires : 7, path : "/"
	});
};

/**
 * 滚动条
 * 
 * @author 孙宇
 * @requires jQuery,EasyUI
 */
sy.progressBar = function(options) {
	if (typeof options == 'string') {
		if (options == 'close') {
			$('#syProgressBarDiv').dialog('destroy');
		}
	} else {
		if ($('#syProgressBarDiv').length < 1) {
			var opts = $.extend({
				title : '&nbsp;',
				closable : false,
				width : 300,
				height : 60,
				modal : true,
				content : '<div id="syProgressBar" class="easyui-progressbar" data-options="value:0"></div>'
			}, options);
			$('<div id="syProgressBarDiv"/>').dialog(opts);
			$.parser.parse('#syProgressBarDiv');
		} else {
			$('#syProgressBarDiv').dialog('open');
		}
		if (options.value) {
			$('#syProgressBar').progressbar('setValue', options.value);
		}
	}
};

  
   
//form验证扩展
$.extend($.fn.validatebox.defaults.rules, {
	chinese : {// 验证中文  
	    validator : function(value) {  
	        return /^[\u0391-\uFFE5]+$/i.test(value);  
	    },  
	    message : '请输入中文'  
	},  
	chineseAndLength : {// 验证中文及长度  
	    validator : function(value) {  
	        var len = $.trim(value).length;  
	        if (len >= param[0] && len <= param[1]) {  
	            return /^[\u0391-\uFFE5]+$/i.test(value);  
	        }  
	    },  
	    message : '请输入中文'  
	},  
	english : {// 验证英语  
	    validator : function(value) {  
	        return /^[A-Za-z]+$/i.test(value);  
	    },  
	    message : '请输入英文'  
	},  
	englishAndLength : {// 验证英语及长度  
	    validator : function(value, param) {  
	        var len = $.trim(value).length;  
	        if (len >= param[0] && len <= param[1]) {  
	            return /^[A-Za-z]+$/i.test(value);  
	        }  
	    },  
	    message : '请输入英文'  
	},
	englishOrChinese : {// 可以是中文或英文  
        validator : function(value) {  
            return /^[\u0391-\uFFE5]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);  
        },  
        message : '请输入中文或英文'  
    },  
    englishOrChineseAndLength : {// 可以是中文或英文  
        validator : function(value) {  
            var len = $.trim(value).length;  
            if (len >= param[0] && len <= param[1]) {  
                return /^[\u0391-\uFFE5]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);  
            }  
        },  
        message : '请输入中文或英文'  
    }, 
	englishUpperCase : {// 验证英语大写  
	    validator : function(value) {  
	        return /^[A-Z]+$/.test(value);  
	    },  
	    message : '请输入大写英文'  
	},  
	unnormal : {// 验证是否包含空格和非法字符  
	    validator : function(value) {  
	        return /.+/i.test(value);  
	    },  
	    message : '输入值不能为空和包含其他非法字符'  
	},  
	username : {// 验证用户名  
	    validator : function(value) {  
	        return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);  
	    },  
	    message : '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'  
	},  
    loginname: {
        validator: function (value, param) {
            return /^[\u0391-\uFFE5\w]+$/.test(value);
        },
        message: '登录名只允许包含汉字、英文字母、数字及下划线。'
    },     
    safepass: {
        validator: function (value, param) {
            return safePassword(value);
        },
        message: '密码由字母和数字组成，至少6位!'
    },
    equalTo: {
        validator: function (value, param) {
            return value == $(param[0]).val();
        },
        message: '两次输入的密码不一致'
    },    
    idcard: {
        validator: function (value, param) {
            return idCard(value);
        },
        message:'身份证号码不合法'
    },
    postalcode: {
        validator: function (value, param) {
            return /^[1-9]\d{5}$/.test(value);
        },
        message: '邮政编码格式不正确'
    },
    email: {
        validator: function (value, param) {
            return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
        },
        message: 'email格式不正确'
    },
    faxno : {// 验证传真  
        validator : function(value) {  
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);  
        },  
        message : '传真号码不正确'  
    },
    phone: {
        validator: function (value, param) {
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/.test(value);
        },
        message: '固定电话号码格式不正确,请使用下面格式:020-88888888'
    },
    mobile: {
        validator: function (value, param) {
            return /^((\(\d{2,3}\))|(\d{3}\-))?((13\d{9})|(14[7]\d{8})|(18[012356789]\d{8})|(15[012356789]\d{8}))$/.test(value);
        },
        message: '手机号码格式不正确'
    }, 
    phoneAndMobile : {// 电话号码或手机号码  
        validator : function(value) {  
            return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value) || /^(13|15|18)\d{9}$/i.test(value);  
        },  
        message : '电话号码或手机号码格式不正确'  
    },
    url: {
        validator: function (value, param) {
            return /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"])*$/.test(value);
        },
        message: 'url地址格式不正确'
    },
    ip: {
        validator: function (value, param) {
            return /^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$/.test(value);
        },
        message: 'ip地址格式不正确'
    },
    currency: {
        validator: function (value, param) {
            return /^\d+$/.test(value);
        },
        message: '货币格式不正确 '
    },
    qq: {
        validator: function (value, param) {
            return /^[1-9]\d{4,13}$/.test(value);
        },
        message: 'QQ号码格式不正确'
    },
    intOrFloat : {// 验证整数或小数  
        validator : function(value) {  
            return /^\d+(\.\d+)?$/i.test(value);  
        },  
        message : '请输入数字，并确保格式正确'  
    },     
    number: {
        validator: function (value, param) {
            return /^\d+$/.test(value);
        },
        message: '请输入数字'
    },    
    integer: {
        validator: function (value, param) {
            return /^[-\+]?\d+$/.test(value);
        },
        message: '请输入整数'
    },
    double: {
        validator: function (value, param) {
            return /^[-\+]?\d+(\.\d+)?$/.test(value);
        },
        message: '请输入浮点数'
    },
    bigmoney: {
        validator: function (value, param) {
            return /^\d{1,10}(\.\d{1,2})?$/.test(value);
        },
        message: '输入格式应为1234.77'
    },
    iszero: {
        validator: function (value, param) {
            return /^(?!0$)/.test(value);
        },
        message: '该输入项必须为0'
    },
    mediumdate: {
        validator: function (value, param) {
            return /^(\d{4})(\/)(\d{1,2})$/.test(value);
        },
        message: '日期格式应为yyyy/mm'
    },
    shortdate: {
        validator: function (value, param) {
            return /^\d{4}$/.test(value);
        },
        message: '日期格式应为yyyy'
    },
    period: {
        validator: function (value, param) {
            return /^\d{6}$/.test(value);
        },
        message: '日期格式应为yyyymm'
    },
    hengdate: {
        validator: function (value, param) {
            return /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(value);
        },
        message: '日期格式应为yyyy-mm-dd'
    },
    simpledate: {
        validator: function (value, param) {
            return /^(?:(?!0000)[0-9]{4}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(value);
        },
        message: '日期格式应为yyyymmdd'
    },
    minLength : { // 判断最小长度  
        validator : function(value, param) {  
            return value.length >= param[0];  
        },  
        message : '最少输入 {0} 个字符'  
    },  
    length : { // 长度  
        validator : function(value, param) {  
            var len = $.trim(value).length;  
            return len >= param[0] && len <= param[1];  
        },  
        message : "输入内容长度必须介于{0}和{1}之间"  
    },  
    carNo : {  
        validator : function(value) {  
            return /^[\u4E00-\u9FA5][\da-zA-Z]{6}$/.test(value);  
        },  
        message : '车牌号码无效（例：粤B12350）'  
    },  
    carenergin : {  
        validator : function(value) {  
            return /^[a-zA-Z0-9]{16}$/.test(value);  
        },  
        message : '发动机型号无效(例：FG6H012345654584)'  
    },
    comboboxNoEmpty : { // 长度  
        validator : function(value) {  
            var len = $.trim(value).length;
            return value != '==请选择==';
        },  
        message : "必选项不能为空"  
    }
});
	
	
/* 密码由字母和数字组成，至少6位 */
var safePassword = function (value) {
    return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/.test(value));
}

var idCard = function(value) {
	if (value.length == 18 && 18 != value.length) return false;
	var number = value.toLowerCase();
	var d, sum = 0,
	v = '10x98765432',
	w = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2],
	a = '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
	var re = number.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/);
	if (re == null || a.indexOf(re[1]) < 0) return false;
	if (re[2].length == 9) {
		number = number.substr(0, 6) + '19' + number.substr(6);
		d = ['19' + re[4], re[5], re[6]].join('-');
	} else d = [re[9], re[10], re[11]].join('-');
	if (!isDateTime.call(d, 'yyyy-MM-dd')) return false;
	for (var i = 0; i < 17; i++) sum += number.charAt(i) * w[i];
	return (re[2].length == 9 || number.charAt(17) == v.charAt(sum % 11));
}
var isDateTime = function(format, reObj) {
	format = format || 'yyyy-MM-dd';
	var input = this,
	o = {},
	d = new Date();
	var f1 = format.split(/[^a-z]+/gi),
	f2 = input.split(/\D+/g),
	f3 = format.split(/[a-z]+/gi),
	f4 = input.split(/\d+/g);
	var len = f1.length,
	len1 = f3.length;
	if (len != f2.length || len1 != f4.length) return false;
	for (var i = 0; i < len1; i++) if (f3[i] != f4[i]) return false;
	for (var i = 0; i < len; i++) o[f1[i]] = f2[i];
	o.yyyy = s(o.yyyy, o.yy, d.getFullYear(), 9999, 4);
	o.MM = s(o.MM, o.M, d.getMonth() + 1, 12);
	o.dd = s(o.dd, o.d, d.getDate(), 31);
	o.hh = s(o.hh, o.h, d.getHours(), 24);
	o.mm = s(o.mm, o.m, d.getMinutes());
	o.ss = s(o.ss, o.s, d.getSeconds());
	o.ms = s(o.ms, o.ms, d.getMilliseconds(), 999, 3);
	if (o.yyyy + o.MM + o.dd + o.hh + o.mm + o.ss + o.ms < 0) return false;
	if (o.yyyy < 100) o.yyyy += (o.yyyy > 30 ? 1900 : 2000);
	d = new Date(o.yyyy, o.MM - 1, o.dd, o.hh, o.mm, o.ss, o.ms);
	var reVal = d.getFullYear() == o.yyyy && d.getMonth() + 1 == o.MM && d.getDate() == o.dd && d.getHours() == o.hh && d.getMinutes() == o.mm && d.getSeconds() == o.ss && d.getMilliseconds() == o.ms;
	return reVal && reObj ? d: reVal;
	function s(s1, s2, s3, s4, s5) {
		s4 = s4 || 60,
		s5 = s5 || 2;
		var reVal = s3;
		if (s1 != undefined && s1 != '' || !isNaN(s1)) reVal = s1 * 1;
		if (s2 != undefined && s2 != '' && !isNaN(s2)) reVal = s2 * 1;
		return (reVal == s1 && s1.length != s5 || reVal > s4) ? -10000 : reVal;
	}
};


/**
 * @author 孙宇
 * 
 * 获得项目根路径
 * 
 * 使用方法：sy.bp();
 * 
 * @returns 项目根路径
 */
sy.bp = function() {
	var curWwwPath = window.document.location.href;
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	var localhostPaht = curWwwPath.substring(0, pos);
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPaht + projectName);
};

/**
 * @author 孙宇
 * 
 * 使用方法:sy.pn();
 * 
 * @returns 项目名称(/sshe)
 */
sy.pn = function() {
	return window.document.location.pathname.substring(0, window.document.location.pathname.indexOf('\/', 1));
};

/**
 * @author 孙宇
 * 
 * 增加formatString功能
 * 
 * 使用方法：sy.fs('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
sy.formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};

/**
 * @author 孙宇
 * 
 * 增加命名空间功能
 * 
 * 使用方法：sy.ns('jQuery.bbb.ccc','jQuery.eee.fff');
 */
sy.ns = function() {
	var o = {}, d;
	for ( var i = 0; i < arguments.length; i++) {
		d = arguments[i].split(".");
		o = window[d[0]] = window[d[0]] || {};
		for ( var k = 0; k < d.slice(1).length; k++) {
			o = o[d[k + 1]] = o[d[k + 1]] || {};
		}
	}
	return o;
};

/**
 * 屏蔽右键
 * 
 * @author 孙宇
 * 
 * @requires jQuery
 */
$(document).bind('contextmenu', function() {
	// return false;
});

/**
 * 禁止复制
 * 
 * @author 孙宇
 * 
 * @requires jQuery
 */
$(document).bind('selectstart', function() {
	// return false;
});

/**
 * @author 郭华(夏悸)
 * 
 * 生成UUID
 * 
 * @returns UUID字符串
 */
sy.random4 = function() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
};
sy.UUID = function() {
	return (sy.random4() + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + "-" + sy.random4() + sy.random4() + sy.random4());
};

/**
 * @author 孙宇
 * 
 * 获得URL参数
 * 
 * @returns 对应名称的值
 */
sy.getUrlParam = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
};

/**
 * @author 孙宇
 * 
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
sy.stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 判断浏览器是否是IE并且版本小于8
 * 
 * @returns true/false
 */
sy.isLessThanIe8 = function() {
	return ($.browser.msie && $.browser.version < 8);
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 将form表单元素的值序列化成对象
 * 
 * @returns object
 */
sy.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};

/**
 * 
 * 将JSON对象转换成字符串
 * 
 * @param o
 * @returns string
 */
sy.jsonToString = function(o) {
	var r = [];
	if (typeof o == "string")
		return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
	if (typeof o == "object") {
		if (!o.sort) {
			for ( var i in o)
				r.push(i + ":" + obj2str(o[i]));
			if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
				r.push("toString:" + o.toString.toString());
			}
			r = "{" + r.join() + "}";
		} else {
			for ( var i = 0; i < o.length; i++)
				r.push(obj2str(o[i]));
			r = "[" + r.join() + "]";
		}
		return r;
	}
	return o.toString();
};

/**
 * @author 郭华(夏悸)
 * 
 * 格式化日期时间
 * 
 * @param format
 * @returns
 */
Date.prototype.format = function(format) {
	if (isNaN(this.getMonth())) {
		return '';
	}
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}
	var o = {
		/* month */
		"M+" : this.getMonth() + 1,
		/* day */
		"d+" : this.getDate(),
		/* hour */
		"h+" : this.getHours(),
		/* minute */
		"m+" : this.getMinutes(),
		/* second */
		"s+" : this.getSeconds(),
		/* quarter */
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		/* millisecond */
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 改变jQuery的AJAX默认属性和方法
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		$.messager.progress('close');
		$.messager.alert('错误', XMLHttpRequest.responseText);
	}
});

/**
 * 解决class="iconImg"的img标记，没有src的时候，会出现边框问题
 * 
 * @author 孙宇
 * 
 * @requires jQuery
 */
$(function() {
	$('.iconImg').attr('src', sy.pixel_0);
});

/**
 * grid代码格式化 
 * 参数必须是下面的格式
 * var codeArray = [{"id":"0","text":"功能"},{"id":"1","text":"菜单"},{"id":"2","text":"按钮"}];		
 * 
 * @author zjf
 */
sy.formatGridCode = function(codeArray,code){
	var myobj = eval(codeArray);
	for(var i=0;i<myobj.length;i++){
		if(code=="" || code==null){
			return "";
		}
	    if(code==myobj[i].id){
	    	return myobj[i].text;
	    }
	}
};

/**
 * 自定义组合框标签【groupbox】的单击事件：切换所有匹配元素的可见性
 *
 * @author zjf
 */
$(function() {
	$('.groupboxtitle').click(function() {
		$(this).next().slideToggle(function() {
			if ($(this).prev().children('img[src*=title-show]').attr('src')) {
				$(this).prev().children('img').attr('src', sy.contextPath + '/images/title-hide.gif');
			} else {
				$(this).prev().children('img').attr('src', sy.contextPath + '/images/title-show.gif');
			}
			$(this).parent().toggleClass('groupboxshrink');
		});
	});
});

/**
 * 格式化日期
 *
 * @author zjf
 */
sy.formatDate = function(date,formater) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	if(formater == 'yyyy-mm-dd'){
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
	}
	else if(formater == 'yyyymmdd'){
		return y + '' + (m < 10 ? ('0' + m) : m) + '' + (d < 10 ? ('0' + d) : d);
	}
	else if(formater == 'yyyymm'){
		return y + '' + (m < 10 ? ('0' + m) : m);
	}
};


/**
 * 解析日期字符串为日期yyyy-mm-dd
 *
 * @author zjf
 */
sy.parseDate = function(str) {
	if (!str) return new Date();
	var ss = (str.split('-'));
	var y = parseInt(ss[0], 10);
	var m = parseInt(ss[1], 10);
	var d = parseInt(ss[2], 10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
		return new Date(y, m - 1, d);
	} else {
		return new Date();
	}
}

/**
 * 获取当前日期星期
 */
sy.showDateTime = function(){
	var date = new Date();  
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate(); 
	var Week = ['日','一','二','三','四','五','六'];   
	return "今天是" + y + "年" + m + "月" + d + "日 " + ' 星期' + Week[date.getDay()];
}


//FineReport打印
sy.doPrint = function(reportUrl,reportParams){	 
   var url = "";
   if (reportParams == '' || reportParams == null){
	   url = sy.contextPath + "/servlet/ReportServlet?reportlet=" + reportUrl;
   }
   else{
	   url = sy.contextPath + "/servlet/ReportServlet?reportlet=" + reportUrl + "&" + reportParams; 
   }
   showModalDialog(url,null,"help:no;status:no;center:yes;dialogWidth:60;dialogHeight:40");
} 	 