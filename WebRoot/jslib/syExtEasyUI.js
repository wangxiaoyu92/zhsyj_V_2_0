var sy = sy || {};

/**
 * 更改easyui加载panel时的提示文字
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
$.extend($.fn.panel.defaults, {
	loadingMessage : '加载中....'
});

/**
 * 更改easyui加载grid时的提示文字
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
$.extend($.fn.datagrid.defaults, {
	loadMsg : '数据加载中....'
});

/**
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.extend($.fn.panel.defaults, {
			onBeforeDestroy : function() {
				var frame = $('iframe', this);
				try {
					if (frame.length > 0) {
						for (var i = 0; i < frame.length; i++) {
							frame[i].src = '';
							frame[i].contentWindow.document.write('');
							frame[i].contentWindow.close();
						}
						frame.remove();
						if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
							try {
								CollectGarbage();
							} catch (e) {
							}
						}
					}
				} catch (e) {
				}
	}
});

/**
 * 防止panel/window/dialog组件超出浏览器边界
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
/**gu20160407
sy.onMove = {
	onMove : function(left, top) {
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
		$(this).parent().css({
			left : l,
			top : t
		});
	}
};
$.extend($.fn.dialog.defaults, sy.onMove);
$.extend($.fn.window.defaults, sy.onMove);
$.extend($.fn.panel.defaults, sy.onMove);
 */
/**
 * 
 * 通用错误提示
 * 
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
sy.onLoadError = {
	onLoadError : function(XMLHttpRequest) {
		if (parent.$ && parent.$.messager) {
			parent.$.messager.progress('close');
			parent.$.messager.alert('错误', XMLHttpRequest.responseText);
		} else {
			$.messager.progress('close');
			$.messager.alert('错误', XMLHttpRequest.responseText);
		}
	}
};
$.extend($.fn.datagrid.defaults, sy.onLoadError);
$.extend($.fn.treegrid.defaults, sy.onLoadError);
$.extend($.fn.tree.defaults, sy.onLoadError);
$.extend($.fn.combogrid.defaults, sy.onLoadError);
$.extend($.fn.combobox.defaults, sy.onLoadError);
$.extend($.fn.form.defaults, sy.onLoadError);

/**
 * 扩展combobox在自动补全模式时，检查用户输入的字符是否存在于下拉框中，如果不存在则清空用户输入
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
$.extend($.fn.combobox.defaults, {
	onShowPanel : function() {
		var _options = $(this).combobox('options');
		if (_options.mode == 'remote') {/* 如果是自动补全模式 */
			var _value = $(this).combobox('textbox').val();
			var _combobox = $(this);
			if (_value.length > 0) {
				$.post(_options.url, {
					q : _value
				}, function(result) {
					if (result && result.length > 0) {
						_combobox.combobox('loadData', result);
					}
				}, 'json');
			}
		}
	},
	onHidePanel : function() {
		var _options = $(this).combobox('options');
		if (_options.mode == 'remote') {/* 如果是自动补全模式 */
			var _data = $(this).combobox('getData');/* 下拉框所有选项 */
			var _value = $(this).combobox('getValue');/* 用户输入的值 */
			var _b = false;/* 标识是否在下拉列表中找到了用户输入的字符 */
			for (var i = 0; i < _data.length; i++) {
				if (_data[i][_options.valueField] == _value) {
					_b = true;
				}
			}
			if (!_b) {/* 如果在下拉列表中没找到用户输入的字符 */
				$(this).combobox('setValue', '');
			}
		}
	}
});

/**
 * 扩展combogrid在自动补全模式时，检查用户输入的字符是否存在于下拉框中，如果不存在则清空用户输入
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 */
$.extend($.fn.combogrid.defaults, {
	onShowPanel : function() {
		var _options = $(this).combogrid('options');
		if (_options.mode == 'remote') {/* 如果是自动补全模式 */
			var _value = $(this).combogrid('textbox').val();
			if (_value.length > 0) {
				$(this).combogrid('grid').datagrid("load", {
					q : _value
				});
			}
		}
	},
	onHidePanel : function() {
		var _options = $(this).combogrid('options');
		if (_options.mode == 'remote') {/* 如果是自动补全模式 */
			var _data = $(this).combogrid('grid').datagrid('getData').rows;/* 下拉框所有选项 */
			var _value = $(this).combogrid('getValue');/* 用户输入的值 */
			var _b = false;/* 标识是否在下拉列表中找到了用户输入的字符 */
			for (var i = 0; i < _data.length; i++) {
				if (_data[i][_options.idField] == _value) {
					_b = true;
				}
			}
			if (!_b) {/* 如果在下拉列表中没找到用户输入的字符 */
				$(this).combogrid('setValue', '');
			}
		}
	}
});


/**
 * 扩展tree和combotree，使其支持平滑数据格式
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
sy.loadFilter = {
	loadFilter : function(data, parent) {
		var opt = $(this).data().tree.options;
		var idField, textField, parentField;
		if (opt.parentField) {
			idField = opt.idField || 'id';
			textField = opt.textField || 'text';
			parentField = opt.parentField || 'pid';
			var i, l, treeData = [], tmpMap = [];
			for (i = 0, l = data.length; i < l; i++) {
				tmpMap[data[i][idField]] = data[i];
			}
			for (i = 0, l = data.length; i < l; i++) {
				if (tmpMap[data[i][parentField]] && data[i][idField] != data[i][parentField]) {
					if (!tmpMap[data[i][parentField]]['children'])
						tmpMap[data[i][parentField]]['children'] = [];
					data[i]['text'] = data[i][textField];
					tmpMap[data[i][parentField]]['children'].push(data[i]);
				} else {
					data[i]['text'] = data[i][textField];
					treeData.push(data[i]);
				}
			}
			return treeData;
		}
		return data;
	}
};
$.extend($.fn.combotree.defaults, sy.loadFilter);
$.extend($.fn.tree.defaults, sy.loadFilter);

/**
 * 扩展treegrid，使其支持平滑数据格式
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.extend($.fn.treegrid.defaults, {
	loadFilter : function(data, parentId) {
		var opt = $(this).data().treegrid.options;
		var idField, treeField, parentField;
		if (opt.parentField) {
			idField = opt.idField || 'id';
			treeField = opt.textField || 'text';
			parentField = opt.parentField || 'pid';
			var i, l, treeData = [], tmpMap = [];
			for (i = 0, l = data.length; i < l; i++) {
				tmpMap[data[i][idField]] = data[i];
			}
			for (i = 0, l = data.length; i < l; i++) {
				if (tmpMap[data[i][parentField]] && data[i][idField] != data[i][parentField]) {
					if (!tmpMap[data[i][parentField]]['children'])
						tmpMap[data[i][parentField]]['children'] = [];
					data[i]['text'] = data[i][treeField];
					tmpMap[data[i][parentField]]['children'].push(data[i]);
				} else {
					data[i]['text'] = data[i][treeField];
					treeData.push(data[i]);
				}
			}
			return treeData;
		}
		return data;
	}
});

/**
 * 创建一个模式化的dialog【不用这个方法】
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
sy.modalDialog2 = function(options) {
	var iframe_id = "iframe"+Math.floor(Math.random()*100000000);
	var opts = $.extend({
		title : '&nbsp;',
		width : 640,
		height : 480,
		modal : true,
		onClose : function() {
			$(this).dialog('destroy');
			if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
				try {
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
 * 创建一个模式化的dialog
 *
 * @author 翟建峰
 *
 * @requires jQuery,EasyUI
 *
 */
sy.modalDialogEasyui = function(options,callback) {
    options.maximizable=true;
    var iframe_id = "iframe" + Math.floor(Math.random()*100000000);
    var dialog_id = sy.getUUID(8,16);
    var opts = $.extend({
        id : dialog_id,
        title : '&nbsp;',
        width : 640,
        height : 480,
        modal : true,
        maximizable:true,
        onClose : function() {
            if (callback) {
                callback(dialog_id);
            }

            $(this).dialog('destroy');
            if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
                try {
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
        var urlparam = "";
        var index = 0;
        var v_url = "";
        var paramSymbol = ((options.url.indexOf("?")==-1)?"?":"&");
        if(!sy.IsNullFlag(options.param)){
            $.each(options.param,function(key,value){
                if(index!=0){
                    urlparam = urlparam + "&" + key + "=" + value;
                }else{
                    urlparam = urlparam + paramSymbol + key + "=" + value;
                }
                index = index + 1;
            })
            v_url = options.url + urlparam + "&dialog_random_id=" + dialog_id;
        }else{
            v_url = options.url + paramSymbol + "dialog_random_id=" + dialog_id;
        }




        opts.content = '<iframe id="'+iframe_id+'" src="' + v_url +'" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name="'+iframe_id+'"></iframe>';
    }
    return $('<div/>').dialog(opts);
};

/**
 * 创建一个模式化的dialog
 * 
 * @author 翟建峰
 * 
 * @requires jQuery,EasyUI
 * 
 */
sy.modalDialog = function(options,callback) {
	options.maximizable=true;
	var iframe_id = "iframe" + Math.floor(Math.random()*100000000);
	var dialog_id = sy.getUUID(8,16);
	var opts = $.extend({
		id : dialog_id,
		title : '&nbsp;',
		width : 640,
		height : 480,
		modal : true,
		top:72,
		maximizable:true,
		onClose : function() {			
            if (callback) {
                callback(dialog_id);
            }
			
			$(this).dialog('destroy');
			if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
				try {
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
		var urlparam = "";
		var index = 0;
		var v_url = "";
		var paramSymbol = ((options.url.indexOf("?")==-1)?"?":"&");
		if(!sy.IsNullFlag(options.param)){
			$.each(options.param,function(key,value){
				if(index!=0){
					urlparam = urlparam + "&" + key + "=" + value;
				}else{
					urlparam = urlparam + paramSymbol + key + "=" + value;
				}
				index = index + 1;
			})
			v_url = options.url + urlparam + "&dialog_random_id=" + dialog_id;
		}else{
			v_url = options.url + paramSymbol + "dialog_random_id=" + dialog_id;
		}

		


		opts.content = '<iframe id="'+iframe_id+'" src="' + v_url +'" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name="'+iframe_id+'"></iframe>';
	}
	return $('<div/>').dialog(opts);
};


/**
 * 创建一个模式化的dialog
 *
 * @author 翟建峰
 *
 * @requires jQuery,EasyUI
 *
 */
sy.modalDialogForZFBA = function(options,callback) {
	options.maximizable=true;
	var iframe_id = "iframe" + Math.floor(Math.random()*100000000);
	var dialog_id = sy.getUUID(8,16);
	var opts = $.extend({
		id : dialog_id,
		title : '&nbsp;',
		width : 640,
		height : 480,
		modal : true,
		maximizable:true,
		onClose : function() {
			if (callback) {
				callback(dialog_id);
			}

			$(this).dialog('destroy');
			if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
				try {
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
		var urlparam = "";
		var index = 0;
		var v_url = "";
		var paramSymbol = ((options.url.indexOf("?")==-1)?"?":"&");
		if(!sy.IsNullFlag(options.param)){
			$.each(options.param,function(key,value){
				if(index!=0){
					urlparam = urlparam + "&" + key + "=" + value;
				}else{
					urlparam = urlparam + paramSymbol + key + "=" + value;
				}
				index = index + 1;
			})
			v_url = options.url + urlparam + "&dialog_random_id=" + dialog_id;
		}else{
			v_url = options.url + paramSymbol + "dialog_random_id=" + dialog_id;
		}




		opts.content = '<iframe id="'+iframe_id+'" src="' + v_url +'" allowTransparency="true" scrolling="auto" width="100%" height="98%" frameBorder="0" name="'+iframe_id+'"></iframe>';
	}
	return $('<div/>').dialog(opts);
};

/**
 * 等同于原form的load方法，但是这个方法支持{data:{name:''}}形式的对象赋值
 */
$.extend($.fn.form.methods, {
	loadData : function(jq, data) {
		return jq.each(function() {
			load(this, data);
		});

		function load(target, data) {
			if (!$.data(target, 'form')) {
				$.data(target, 'form', {
					options : $.extend({}, $.fn.form.defaults)
				});
			}
			var opts = $.data(target, 'form').options;

			if (typeof data == 'string') {
				var param = {};
				if (opts.onBeforeLoad.call(target, param) == false)
					return;

				$.ajax({
					url : data,
					data : param,
					dataType : 'json',
					success : function(data) {
						_load(data);
					},
					error : function() {
						opts.onLoadError.apply(target, arguments);
					}
				});
			} else {
				_load(data);
			}
			function _load(data) {
				var form = $(target);
				var formFields = form.find("input[name],select[name],textarea[name]");
				formFields.each(function() {
					var name = this.name;
					var value = jQuery.proxy(function() {
						try {
							return eval('this.' + name);
						} catch (e) {
							return "";
						}
					}, data)();
					var rr = _checkField(name, value);
					if (!rr.length) {
						var f = form.find("input[numberboxName=\"" + name + "\"]");
						if (f.length) {
							f.numberbox("setValue", value);
						} else {
							$("input[name=\"" + name + "\"]", form).val(value);
							$("textarea[name=\"" + name + "\"]", form).val(value);
							$("select[name=\"" + name + "\"]", form).val(value);
						}
					}
					_loadCombo(name, value);
				});
				opts.onLoadSuccess.call(target, data);
				$(target).form("validate");
			}

			function _checkField(name, val) {
				var rr = $(target).find('input[name="' + name + '"][type=radio], input[name="' + name + '"][type=checkbox]');
				rr._propAttr('checked', false);
				rr.each(function() {
					var f = $(this);
					if (f.val() == String(val) || $.inArray(f.val(), val) >= 0) {
						f._propAttr('checked', true);
					}
				});
				return rr;
			}

			function _loadCombo(name, val) {
				var form = $(target);
				var cc = [ 'combobox', 'combotree', 'combogrid', 'datetimebox', 'datebox', 'combo' ];
				var c = form.find('[comboName="' + name + '"]');
				if (c.length) {
					for (var i = 0; i < cc.length; i++) {
						var type = cc[i];
						if (c.hasClass(type + '-f')) {
							if (c[type]('options').multiple) {
								c[type]('setValues', val);
							} else {
								c[type]('setValue', val);
							}
							return;
						}
					}
				}
			}
		}
	}
});

/**
 * 更换主题
 * 
 * @author 孙宇
 * @requires jQuery,EasyUI
 * @param themeName
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
            //return /^((\(\d{2,3}\))|(\d{3}\-))?((13\d{9})|(14[7]\d{8})|(18[012356789]\d{8})|(15[012356789]\d{8}))$/.test(value);
            return /^1[3|4|5|7|8]\d{9}$/.test(value);
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
        message: '日期格式应为yyyy-mm-dd 如 2012-01-12'
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


//增加一行
function mydatagrid_append(v_datagrid,v_op) {
	if (v_op == 'view') {
		return false;
	}
	var editIndex = -1;
	if (mydatagrid_endEditing(v_datagrid)) {
		v_datagrid.datagrid('appendRow', {});
		editIndex = v_datagrid.datagrid('getRows').length - 1;
		v_datagrid.datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	}
	return editIndex;
} 
//删除一行
function mydatagrid_remove(v_datagrid,v_op) {
	if (v_op == 'view') {
		return false;
	}
	var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
	if (index == -1) {
		alert("请先选择行");
		return false;
	}
	v_datagrid.datagrid('cancelEdit', index).datagrid('deleteRow', index);
	if (index - 1 >= 0) {
		v_datagrid.datagrid('selectRow', index - 1);
	}
} 
//单击某行进行编辑
function mydatagrid_edit(v_datagrid,v_op) {
	if (v_op == 'view') {
		return false;
	}
	var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
	if (index == -1) {
		alert("请先选择行");
		return false;
	}
	v_datagrid.datagrid('selectRow', index).datagrid('beginEdit', index);
}
//结束编辑状态
function mydatagrid_endEditing(v_datagrid) {
	var editIndex = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected')); 
	if (v_datagrid.datagrid('validateRow', editIndex)) {
		var ed = v_datagrid.datagrid('getEditor', {
			index: editIndex
		});
		v_datagrid.datagrid('endEdit', editIndex); 
		return true;
	} else {
		return false;
	}
}
//循环改变所有行编辑状态
function mydatagrid_AllEndEditing(v_datagrid) {
	var rows = v_datagrid.datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		if (v_datagrid.datagrid('validateRow', i)) {
			v_datagrid.datagrid('endEdit', i);
		}
	}
	return true;
} 
//修改除了当前行的编辑状态
function mydatagrid_exceptEndEditing(v_datagrid) {
	var except_index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
	var rows = v_datagrid.datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		if (i != except_index) {
			if (v_datagrid.datagrid('validateRow', i)) {
				v_datagrid.datagrid('endEdit', i);
			}
		}
	}
}
//撤销编辑
function mydatagrid_reject(v_datagrid,v_op) {
	if (v_op == 'view') {
		return false;
	}
	var index = v_datagrid.datagrid('getRowIndex', v_datagrid.datagrid('getSelected'));
	if (index == -1) {
		alert("请先选择行");
		return false;
	}  
	v_datagrid.datagrid('rejectChanges'); 
}
//编辑保存
function mydatagrid_accept(v_datagrid,v_op) {
	if (v_op == 'view') {
		return false;
	}
	if (mydatagrid_endEditing(v_datagrid)) {
		v_datagrid.datagrid('acceptChanges');
	}
}

//gu20170522 扩展datagrid:动态添加删除editor
$.extend($.fn.datagrid.methods, {    
    addEditor : function(jq, param) {   
        if (param instanceof Array) {   
            $.each(param, function(index, item) {  
                var e = $(jq).datagrid('getColumnOption', item.field); 
                e.editor = item.editor; }); 
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


//HashTable的伪实现
function HashTable() {
    var size = 0;
    var entry = new Object();

    this.add = function (key, value) {
        if (!this.containsKey(key)) {
            size++;
        }
        entry[key] = value;
    };

    this.getValue = function (key) {
        return this.containsKey(key) ? entry[key] : null;
    };

    this.remove = function (key) {
        if (this.containsKey(key) && (delete entry[key])) {
            size--;
        }
    };

    this.containsKey = function (key) {
        return (key in entry);
    };

    this.containsValue = function (value) {
        for (var prop in entry) {
            if (entry[prop] == value) {
                return true;
            }
        }
        return false;
    };

    this.getValues = function () {
        var values = new Array();
        for (var prop in entry) {
            values.push(entry[prop]);
        }
        return values;
    };

    this.getKeys = function () {
        var keys = new Array();
        for (var prop in entry) {
            keys.push(prop);
        }
        return keys;
    };

    this.getSize = function () {
        return size;
    };

    this.clear = function () {
        size = 0;
        entry = new Object();
    };
}

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

$.extend($.fn.datagrid.defaults.editors, {
    timespinner: {
        init: function (container, options) {
            var input = $('<input/>').appendTo(container);
            input.timespinner(options);
            return input
        },
        getValue: function (target) {
            var val = $(target).timespinner('getValue');
        },
        setValue: function (target, value) {
            $(target).timespinner('setValue', value);
        },
        resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.resize('resize', width - (input.outerWidth() - input.width()));
            } else {
                input.resize('resize', width);
            }
        }
    }
});
//datagrid 时间控件编辑器扩展
$.extend($.fn.datagrid.defaults.editors, {
    datetimebox: {// datetimebox就是你要自定义editor的名称
        init: function (container, options) {
            var input = $('<input class="easyuidatetimebox">').appendTo(container);
            return input.datetimebox({
                formatter: function (date) {
                    return new Date(date).format("yyyy-MM-dd hh:mm:ss");
                }
            });
        },
        getValue: function (target) {
            return $(target).parent().find('input.combo-value').val();
        },
        setValue: function (target, value) {
            $(target).datetimebox("setValue", value);
        },
        resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else {
                input.width(width);
            }
        }
    }
});
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

//$.extend($.fn.validatebox.defaults.rules, {
//	   dates : {// 验证
//	      validator : function(value) { 
//	       //格式yyyy-MM-dd或yyyy-M-d
//	          return/^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value); 
//	      },
//	      message : '清输入合适的日期格式'
//	  }
//	       })