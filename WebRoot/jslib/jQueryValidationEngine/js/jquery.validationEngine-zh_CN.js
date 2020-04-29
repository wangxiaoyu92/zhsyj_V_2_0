(function($){
	// 验证规则
	$.fn.validationEngineLanguage = function(){};
	$.validationEngineLanguage = {
		newLang:function(){
			$.validationEngineLanguage.allRules = {
				"required":{ // Add your regex rules here, you can take telephone as an example   require : /.+/,//不为空 
					"regex":"none",
					"alertText":"* 此处不能为空",
					"alertTextCheckboxMultiple":"* 请选择一个项目",
					"alertTextCheckboxe":"* 该选项为必选",
					"alertTextDateRange":"* 日期范围不能为空"
				},
				"dateRange":{
					"regex":"none",
					"alertText":"* 无效的 ",
					"alertText2":" 日期范围"
				},
				"dateTimeRange":{
					"regex":"none",
					"alertText":"* 无效的 ",
					"alertText2":" 时间范围"
				},
				"minSize":{
					"regex":"none",
					"alertText":"* 最少 ",
					"alertText2":" 个字符"
				},
				"maxSize":{
					"regex":"none",
					"alertText":"* 最多 ",
					"alertText2":" 个字符"
				},
				"groupRequired":{
					"regex":"none",
					"alertText":"* 至少填写其中一项"
				},
				"min":{
					"regex":"none",
					"alertText":"* 最小值为 "
				},
				"max":{
					"regex":"none",
					"alertText":"* 最大值为 "
				},
				"past":{
					"regex":"none",
					"alertText":"* 日期需在 ",
					"alertText2":" 之前"
				},
				"future":{
					"regex":"none",
					"alertText":"* 日期需在 ",
					"alertText2":" 之后"
				},	
				"maxCheckbox":{
					"regex":"none",
					"alertText":"* 最多选择 ",
					"alertText2":" 个项目"
				},
				"minCheckbox":{
					"regex":"none",
					"alertText":"* 最少选择 ",
					"alertText2":" 个项目"
				},
				"equals":{
					"regex":"none",
					"alertText":"* 两次输入的密码不一致"
				},
                "creditCard": {
                    "regex": "none",
                    "alertText": "* 无效的信用卡号码"
                },
				/**
				 * 正则验证规则补充
				 * Author: ciaoca@gmail.com
				 * Date: 2013-10-12
				 */
				"chinese":{//chinese :  /^[\u0391-\uFFE5]+$/,//中文
					"regex":/^[\u4E00-\u9FA5]+$/,
					"alertText":"* 只能填写中文汉字"
				},
				"english":{//英文
					"regex":/^[A-Za-z]+$/,
					"alertText":"* 只能填写英文"
				},
				"username":{//用户名，字母开始，后跟3~19位字符/^[a-z]\w{3,19}$/i,
					"regex":/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/,
					"alertText":"* 只能填写字母、数字、下划线组成,且长度为6-12位"
				},
				"phone":{//固定电话号码格式，区号可选
					// credit:jquery.h5validate.js / orefalo
					//"regex":/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/,原来的
					"regex":/^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/,
					"alertText":"* 无效的电话号码"
				},
				"mobile":{//手机号码
					"regex":/^((\(\d{2,3}\))|(\d{3}\-))?((13\d{9})|(14[7]\d{8})|(18[012356789]\d{8})|(15[012356789]\d{8}))$/,
					"alertText":"* 无效的手机号码"
				},
				"lxdh":{//手机号码，或者  固定电话号码格式，区号可选
					// credit:jquery.h5validate.js / orefalo
					"regex":/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/,
					"alertText":"* 无效的联系电话(请填写固定电话,或者手机号码)"
				},			
				"email":{//email格式  
					// Shamelessly lifted from Scott Gonzalez via the Bassistance Validation plugin http://projects.scottsplayground.com/email_address_validation/
					//"regex":/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,原来的
					"regex":/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
					"alertText":"* 无效的邮件地址"
				},
				"qq":{//qq : /^[1-9]\d{4,13}$/,//腾讯QQ号码，5~9位
					"regex":/^[1-9]\d{4,10}$/,
					"alertText":"* 无效的 QQ 号码"
				},
				"chinaZip":{//zip : /^[1-9]\d{5}$/,//邮政编码格式   
					"regex":/^\d{6}$/,
					"alertText":"* 无效的邮政编码"
				},
				"integer":{//整数格式
					"regex":/^[\-\+]?\d+$/,
					"alertText":"* 无效的整数"
				},
				"number":{//'double' : /^[-\+]?\d+(\.\d+)?$/,//浮点格式，可正可负，可带小数
					// Number, including positive, negative, and floating decimal. credit:orefalo
                    "regex": /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/,
					"alertText":"* 无效的数值"
				},
				"isShuzi":{//是数字
                    "regex":/^\d+$/,
					"alertText":"* 无效的数值"
				},
				"integerOrFloat":{//判断字符串是否为数字(整数或者浮点数)
                    "regex": /^[0-9]+.?[0-9]*$/,
					"alertText":"* 无效的数值"
				},
				"iszero":{//判断字符串是0
                    "regex":/^(?!0$)/,
					"alertText":"* 无效的数值"
				},
				"chinaId":{//18位身份证号
					/**
					 * 2013年1月1日起第一代身份证已停用，此处仅验证 18 位的身份证号码
					 * 如需兼容 15 位的身份证号码，请使用宽松的 chinaIdLoose 规则
					 * /^[1-9]\d{5}[1-9]\d{3}(
					 * 	(
					 * 		(0[13578]|1[02])
					 * 		(0[1-9]|[12]\d|3[01])
					 * 	)|(
					 * 		(0[469]|11)
					 * 		(0[1-9]|[12]\d|30)
					 * 	)|(
					 * 		02
					 * 		(0[1-9]|[12]\d)
					 * 	)
					 * )(\d{4}|\d{3}[xX])$/i
					 */
					"regex":/^[1-9]\d{5}[1-9]\d{3}(((0[13578]|1[02])(0[1-9]|[12]\d|3[0-1]))|((0[469]|11)(0[1-9]|[12]\d|30))|(02(0[1-9]|[12]\d)))(\d{4}|\d{3}[xX])$/,
					"alertText":"* 无效的身份证号码"
				},
				"chinaIdLoose":{//如需兼容 15 位的身份证号码，请使用宽松的 chinaIdLoose 规则
					"regex":/^(\d{18}|\d{15}|\d{17}[xX])$/,
					"alertText":"* 无效的身份证号码"
				},
				"currency":{//货币格式 
                    "regex":/^\d+(\.\d+)?$/,
					"alertText":"* 无效的数值"
				},
				"date":{
					"regex":/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/,
					"alertText":"* 无效的日期，格式必需为 YYYY-MM-DD"
				},
				"ipv4":{//ip : /^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$/,//ip地址格式   
					"regex":/^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
					"alertText":"* 无效的 IP 地址"
				},
				"url":{//url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"])*$/,//url地址   
					"regex":/^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
					"alertText":"* 无效的网址"
				},
				"onlyNumberSp":{
					"regex":/^[0-9\ ]+$/,
					"alertText":"* 只能填写数字"
				},
				"onlyLetterSp":{
					"regex":/^[a-zA-Z\ \']+$/,
					"alertText":"* 只能填写英文字母"
				},
				"onlyLetterNumber":{
					"regex":/^[0-9a-zA-Z]+$/,
					"alertText":"* 只能填写数字与英文字母"
				},
				//hengDate : /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/,//yyyy-mm-dd
				//simpleDate : /^(?:(?!0000)[0-9]{4}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/ //yyyymmdd
				//tls warning:homegrown not fielded 
				"dateFormat":{
					"regex":/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
					"alertText":"* 无效的日期格式"
				},
				//tls warning:homegrown not fielded 
				"dateTimeFormat":{
					"regex":/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
					"alertText":"* 无效的日期或时间格式",
					"alertText2":"可接受的格式： ",
					"alertText3":"mm/dd/yyyy hh:mm:ss AM|PM 或 ", 
					"alertText4":"yyyy-mm-dd hh:mm:ss AM|PM"
				},
				//zjf自定义身份证号校验规则：
				"IdCard": { 
					"func": function(field,rules,i,options){	
						//alert(field.val());
						return validateCard2(field.val(),false);						
					},
					"alertText": "* 无效的身份证号码"
				}


				
				/**
				 * 自定义公用提示信息：
				 * 外部通过 $.validationEngineLanguage.allRules.validate2fields.alertText 可获取
				 *
				 * 	"validate2fields": {
				 * 		"alertText": "* 请输入 HELLO"
				 *	 },
				 * 	
				 *
				 * 自定义规则示例：
				 * 	"requiredInFunction": { 
				 * 		"func": function(field,rules,i,options){
				 * 			return (field.val()=="test") ? true : false;
				 * 		},
				 * 		"alertText": "* Field must equal test"
				 * 	},
				 *
				 *
				 * Ajax PHP 验证示例
				 * 	"ajaxUserCallPhp": {
				 * 		"url": "phpajax/ajaxValidateFieldUser.php",
				 * 		// you may want to pass extra data on the ajax call
				 * 		"extraData": "name=eric",
				 * 		// if you provide an "alertTextOk", it will show as a green prompt when the field validates
				 * 		"alertTextOk": "* 此帐号名称可以使用",
				 * 		"alertText": "* 此名称已被其他人使用",
				 * 		"alertTextLoad": "* 正在确认帐号名称是否有其他人使用，请稍等。"
				 * 	},
				 * 	"ajaxNameCallPhp": {
				 * 		// remote json service location
				 * 		"url": "phpajax/ajaxValidateFieldName.php",
				 * 		// error
				 * 		"alertText": "* 此名称已被其他人使用",
				 * 		// speaks by itself
				 * 		"alertTextLoad": "* 正在确认名称是否有其他人使用，请稍等。"
				 * 	}
				 */
			};
			
		}
	};
	$.validationEngineLanguage.newLang();
})(jQuery);


//zjf自定义身份证号校验规则调用的【相关函数】--begin
function validateCard2(element, verfyParityBit) {
	//var inputStr = element.value;
	var inputStr = element;
	if (inputStr.length == 17) {
		var v1 = parseInt(inputStr.charAt(0)),
		v2 = parseInt(inputStr.charAt(1)),
		v3 = parseInt(inputStr.charAt(2)),
		v4 = parseInt(inputStr.charAt(3)),
		v5 = parseInt(inputStr.charAt(4)),
		v6 = parseInt(inputStr.charAt(5)),
		v7 = parseInt(inputStr.charAt(6)),
		v8 = parseInt(inputStr.charAt(7)),
		v9 = parseInt(inputStr.charAt(8)),
		v10 = parseInt(inputStr.charAt(9)),
		v11 = parseInt(inputStr.charAt(10)),
		v12 = parseInt(inputStr.charAt(11)),
		v13 = parseInt(inputStr.charAt(12)),
		v14 = parseInt(inputStr.charAt(13)),
		v15 = parseInt(inputStr.charAt(14)),
		v16 = parseInt(inputStr.charAt(15)),
		v17 = parseInt(inputStr.charAt(16));
		var last = (12 - (v1 * 7 + v2 * 9 + v3 * 10 + v4 * 5 + v5 * 8 + v6 * 4 + v7 * 2 + v8 * 1 + v9 * 6 + v10 * 3 + v11 * 7 + v12 * 9 + v13 * 10 + v14 * 5 + v15 * 8 + v16 * 4 + v17 * 2) % 11) % 11;
		if (last == 10) last = 'X';
		inputStr = inputStr + last;
	}
	if (inputStr.length == 18) {
		if (inputStr.substring(17, 18) == "x") {
			inputStr = inputStr.substring(0, 17) + "X";
		}
	}
	var inputPro = "身份证号码";
	if (inputStr == null) inputStr = "";
	if (inputStr == "") return false;
	var format = inputStr.length;
	if (format == 15 || format == 18) {
		if (!checkID2(inputStr, inputPro, format, element)) return false;
	} else {
		//alert("身份证的位数输入不正确，请重新输入！");
		//element.select();
		return false;
	}
	if ((format == 18) && (!checkCheckStr2(inputStr, element, verfyParityBit))) return false;
	if (!is0AndPosInteger2(inputStr, element)) {
		//alert(inputPro + "输入不合法，请重新输入！");
		return false;
	}
	return true;
}
function checkCheckStr2(inputStr, element, verfyParityBit) {
	var aCity = "11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91";
	var iSum = 0;
	var info = "";
	inputStr = inputStr.replace(/x$/i, "a");
	var curCity = inputStr.substr(0, 2);
	if (! (aCity.indexOf(curCity) > 0 || aCity.indexOf(curCity) == 0)) {
		//alert("身份证输入不合法！头两位错误，请重新输入！");
		//element.select();
		return false;
	}
	if (!verfyParityBit) {
		for (var i = 17; i >= 0; i--) iSum += (Math.pow(2, i) % 11) * parseInt(inputStr.charAt(17 - i), 11);
		if (iSum % 11 != 1) {
			//alert("身份证输入不合法！校验位错误，请重新输入！");
			//element.select();
			return false;
		}
	}
	return true;
}
function checkID2(inputStr, objName, format, element) {
	var _date;
	if (inputStr.length != format) {
		//alert(objName + "格式不对,应为“" + format + "”位，请重新输入！");
		//element.select();
		return false;
	} else {
		if (format == 18) {
			_date = inputStr.substring(6, 14);
		} else if (format == 15) {
			_date = "19" + inputStr.substring(6, 12);
		}
		return validate_date2(objName, _date, element);
	}
	return true;
}

function is0AndPosInteger2(inputVal, element) {
	var format = inputVal.length;
	if (format == 18) {
		var lastChar = inputVal.charAt(inputVal.length - 1);
		if (lastChar == "X") 
			inputVal = inputVal.substring(0, inputVal.length - 1);
	}
	for (var i = 0; i < inputVal.length; i++) {
		var oneChar = inputVal.charAt(i); 
		if (oneChar < "0" || oneChar > "9") {
			return false;
		}
	}
	return true;
}

function validate_date2(objName, _date, element) {
	var temp;
	var year, month, day;
	temp = _date.substring(0, 4);
	year = parseInt(temp, 10);
	temp = _date.substring(4, 6);
	month = parseInt(temp, 10);
	temp = _date.substring(6, 8);
	day = parseInt(temp, 10);
	if (year < 1900 || year > 2200) {
		//alert(objName + "年份应介于1900与2200之间，请重新输入！");
		//element.select();
		return false;
	}
	if (month < 1 || month > 12) {
		//alert(objName + "月份必须介于1与12之间，请重新输入！");
		//element.select();
		return false;
	}
	if ((day == 0) || (day > 31)) {
		//alert(objName + "日必须介于0与31之间，请重新输入！");
		//element.select();
		return false;
	} else if (day > 28 && day < 31) {
		if (month == 2) {
			if (day != 29) {
				//alert(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
				//element.select();
				return false;
			} else {
				if ((year % 4) != 0) {
					//alert(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
					//element.select();
					return false;
				} else {
					if ((year % 100 == 0) && (year % 400 != 0)) {
						//alert(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
						//element.select();
						return false;
					}
				}
			}
		}
	} else if (day == 31) {
		if ((month == 2) || (month == 4) || (month == 6) || (month == 9) || (month == 11)) {
			//alert(objName + month + "月无" + day + "日，请重新输入！");
			//element.select();
			return false;
		}
	}
	return true;
}
//zjf自定义身份证号校验规则调用的【相关函数】--end