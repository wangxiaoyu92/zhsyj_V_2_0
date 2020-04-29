var leafconfig = new Object(); 
leafconfig.dateStyle = '0';
leafconfig.moneyStyle = '6';

//转化grid列数据到汉字描述
function formatGridColData(v_obj,v_value) {
    var v_ret;
    if (v_obj){
        var v_tempobj;
        $(v_obj).each(function (index) {
            v_tempobj=v_obj[index];
            if (v_tempobj.id==v_value){
                v_ret= v_tempobj.text;
                return false;
            }
        });
    };
    return v_ret;
};

//填充下拉列表的数据
   function intSelectData  (selectName,v_obj) {
    if (v_obj){
        var html="";
        var v_tempobj;
        $(v_obj).each(function (index) {
            v_tempobj=v_obj[index];
            html+="<option value='"+v_tempobj.id+"'>"+v_tempobj.text+"</option>";
        });
        $("#"+selectName).append(html);
        //form.render();
        //gu20180402 layui.form.render();
    }
};

//关闭并刷新父窗口
function closeAndRefreshWindow(){
	var s = new Object();      
	s.type = "ok";
	window.returnValue = s;   
	window.close();    
} 

//预览图片
function g_showBigPic(imgUrl){
	var obj = new Object();	
	popwindow(imgUrl,obj,800,600);
}

  
//关闭窗口  
function closeWindow(){
    window.close();
}

function popwindow(src, obj, width, height) {
	var v_left=(screen.availWidth-width)/2;
    var v_top=(screen.availHeight-height)/2;
    
	var url = src;
	if ("" == width || undefined == width) {
		width = "50";
	}
	if ("" == height || undefined == height) {
		height = "35";
	}
	var style = "help:no;status:no;scroll:auto;dialogWidth:"+width+"px;dialogHeight:"+
    	height+"px;dialogTop:"+v_top+"px;dialogLeft:"+v_left+"px;resizable:yes;center:yes"; 
	//style = "help:no;status:no;dialogWidth:" + width + ";dialogHeight:" + height;
	var retval = window.showModalDialog(url, obj, style);
	return retval;
}

function EnterToTab() {
	var e = window.event.srcElement;
	var type = e.type;
	if (type != 'button' && type != 'textarea' && event.keyCode == 13) {
		event.keyCode = 9;
	}
}

document.onkeydown=function(e){EnterToTab();}
function onlyInputNum() {
	if (event.keyCode < 45 || event.keyCode > 57) {
		if (event.keyCode == 88 || event.keyCode == 120) {
			event.returnValue = true;
		} else {
			event.returnValue = false;
		}
	}
}

function validateCard(element, verfyParityBit) {
	var inputStr = element.value;
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
	if (inputStr == "") return true;
	var format = inputStr.length;
	if (format == 15 || format == 18) {
		if (!checkID(inputStr, inputPro, format, element)) return false;
	} else {
		layer.msg("身份证的位数输入不正确，请重新输入！");
		//element.select();
		return false;
	}
	if ((format == 18) && (!checkCheckStr(inputStr, element, verfyParityBit))) return false;
	if (!is0AndPosInteger(inputStr, element)) {
		layer.msg(inputPro + "输入不合法，请重新输入！");
		return false;
	}
	return inputStr;
	//return true;
}
function checkCheckStr(inputStr, element, verfyParityBit) {
	var aCity = "11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91";
	var iSum = 0;
	var info = "";
	inputStr = inputStr.replace(/x$/i, "a");
	var curCity = inputStr.substr(0, 2);
	if (! (aCity.indexOf(curCity) > 0 || aCity.indexOf(curCity) == 0)) {
		layer.msg("身份证输入不合法！头两位错误，请重新输入！");
		element.select();
		return false;
	}
	if (!verfyParityBit) {
		for (var i = 17; i >= 0; i--) iSum += (Math.pow(2, i) % 11) * parseInt(inputStr.charAt(17 - i), 11);
		if (iSum % 11 != 1) {
			layer.msg("身份证输入不合法！校验位错误，请重新输入！");
			//element.select();
			return false;
		}
	}
	return true;
}
function checkID(inputStr, objName, format, element) {
	var _date;
	if (inputStr.length != format) {
		layer.msg(objName + "格式不对,应为“" + format + "”位，请重新输入！");
		element.select();
		return false;
	} else {
		if (format == 18) {
			_date = inputStr.substring(6, 14);
		} else if (format == 15) {
			_date = "19" + inputStr.substring(6, 12);
		}
		return validate_date(objName, _date, element);
	}
	return true;
}

function is0AndPosInteger(inputVal, element) {
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
function validate_date(objName, _date, element) {
	var temp;
	var year, month, day;
	temp = _date.substring(0, 4);
	year = parseInt(temp, 10);
	temp = _date.substring(4, 6);
	month = parseInt(temp, 10);
	temp = _date.substring(6, 8);
	day = parseInt(temp, 10);
	if (year < 1900 || year > 2200) {
		layer.msg(objName + "年份应介于1900与2200之间，请重新输入！");
		//element.select();
		return false;
	}
	if (month < 1 || month > 12) {
		layer.msg(objName + "月份必须介于1与12之间，请重新输入！");
		//element.select();
		return false;
	}
	if ((day == 0) || (day > 31)) {
		layer.msg(objName + "日必须介于0与31之间，请重新输入！");
		//element.select();
		return false;
	} else if (day > 28 && day < 31) {
		if (month == 2) {
			if (day != 29) {
				layer.msg(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
				element.select();
				return false;
			} else {
				if ((year % 4) != 0) {
					layer.msg(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
					element.select();
					return false;
				} else {
					if ((year % 100 == 0) && (year % 400 != 0)) {
						layer.msg(objName + year + "年" + month + "月无" + day + "日，请重新输入！");
						element.select();
						return false;
					}
				}
			}
		}
	} else if (day == 31) {
		if ((month == 2) || (month == 4) || (month == 6) || (month == 9) || (month == 11)) {
			layer.msg(objName + month + "月无" + day + "日，请重新输入！");
			element.select();
			return false;
		}
	}
	return true;
}

function validatePeriod(element) {
	inputStr = element.value;
	if (undefined != inputStr && "" != inputStr && null != inputStr) {
		var r = inputStr.match(/^\d{6}$/);
		if (inputStr.length != 6) {
			layer.msg("请输入6位年月，如200401！");
			element.select();
			return false;
		}
		if (fucIntchk(inputStr) == 0) {
			layer.msg("年月中只应包含数字，请重新输入！");
			element.select();
			return false;
		}
		if (inputStr.substr(4, 2) > 12 || inputStr.substr(4, 2) < 1) {
			layer.msg("年月中的月份不合法，请重新输入！");
			element.select();
			return false;
		}
		if (inputStr.substr(0, 4) < 1900) {
			layer.msg("年月中的年份不能小于1900，请重新输入！");
			element.select();
			return false;
		}
	}
	return true;
}
function fucIntchk(str) {
	var strSource = '0123456789';
	var ch;
	var i;
	var temp;
	for (i = 0; i <= (str.length - 1); i++) {
		ch = str.charAt(i);
		temp = strSource.indexOf(ch);
		if (temp == -1) {
			return 0;
		}
	}
	if (strSource.indexOf(ch) == -1) {
		return 0;
	} else {
		return 1;
	}
}
function trimValue(val) {
	if (undefined == val) return val;
	var value = val.replace(/_/g, "");
	value = value.replace(/ /ig, "");
	return value;
}
function checkMaskCard(obj, birthday, sex, mcode, fcode) {
	if (validateMCard(obj)) {
		if (setBirthday(obj, birthday, sex, mcode, fcode)) {
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}
function validateMCard(obj) {
	if (undefined != obj.mask) {
		var mask = validateMask(obj);
		if (!mask) {
			obj.focus();
		}
		return mask;
	}
	return true;
}
function setBirthday(obj, birthday, sex, mcode, fcode) {
	var input = obj.value;
	var strOldID = trimValue(input);
	if (strOldID.length == 15) {
		if (leafconfig.dateStyle == "0") {
			var year = "19" + strOldID.substr(6, 2) + strOldID.substr(8, 2) + strOldID.substr(10, 2);
		} else {
			var year = "19" + strOldID.substr(6, 2) + "-" + strOldID.substr(8, 2) + "-" + strOldID.substr(10, 2);
		}
		var gender = getSexForIDCard(strOldID);
		var name = document.getElementById(birthday);
		var sexname = document.getElementById(sex);
		if (name == null && sexname == null) {
			layer.msg("出生日期和性别id不存在！");
			return false;
		} else {
			if (name != null) {
				name.value = year;
			}
			if (sexname != null) {
				if (fcode == "" && mcode == "") {
					$('#'+sex).val(gender);
				} else {
					if (gender == 0) {
						$('#'+sex).val(fcode);
					} else {
						$('#'+sex).val(mcode);
					}
				}
			}
		}
		return true;
	} else if (strOldID.length == 18) {
		if (leafconfig.dateStyle == "0") {
			var year = strOldID.substr(6, 4) + strOldID.substr(10, 2) + strOldID.substr(12, 2);
		} else {
			var year = strOldID.substr(6, 4) + "-" + strOldID.substr(10, 2) + "-" + strOldID.substr(12, 2);
		}
		var gender = getSexForIDCard(strOldID);
		var name = document.getElementById(birthday);
		var sexname = document.getElementById(sex);
		if (name == null && sexname == null) {
			layer.msg("出生日期和性别id不存在！");
			return false;
		} else {
			if (name != null) {
				name.value = year;
			}
			if (sexname != null) {
				if (fcode == "" && mcode == "") {
					//sexname.value = gender;
					$('#'+sex).val(gender);
				} else {
					if (gender == 0) {
						$('#'+sex).val(fcode);
					} else {
						$('#'+sex).val(mcode);
					}
				}
			}
		}
		return true;
	} else {
		return false;
	}
}
function getSexForIDCard(str) {
	var inputStr = str.toString();
	var sex;
	if (inputStr.length == 18) {
		sex = inputStr.charAt(16);
		if (sex % 2 == 0) {
			return 0;
		} else {
			return 1;
		}
	} else {
		sex = inputStr.charAt(14);
		if (sex % 2 == 0) {
			return 0;
		} else {
			return 1;
		}
	}
}
function compareBirthSex(obj, birth, sex) {
	if (validateMCard(obj)) {
		var strOldID = trimValue(obj.value);
		var year = "";
		if (strOldID.length == 15) {
			if (leafconfig.dateStyle == "0") {
				year = "19" + strOldID.substr(6, 2) + strOldID.substr(8, 2) + strOldID.substr(10, 2);
			} else {
				year = "19" + strOldID.substr(6, 2) + "-" + strOldID.substr(8, 2) + "-" + strOldID.substr(10, 2);
			}
			var gender = getSexForIDCard(strOldID);
			if (year == birth && gender == sex) {
				return true;
			} else {
				if (gender != sex) {
					layer.msg("身份证号码与性别不一致！");
				}
				if (year != birth) {
					layer.msg("身份证号码与出生日期不一致！");
				}
				return false;
			}
		} else if (strOldID.length == 18) {
			if (leafconfig.dateStyle == "0") {
				year = strOldID.substr(6, 4) + strOldID.substr(10, 2) + strOldID.substr(12, 2);
			} else {
				year = strOldID.substr(6, 4) + "-" + strOldID.substr(10, 2) + "-" + strOldID.substr(12, 2);
			}
			var gender = getSexForIDCard(strOldID);
			if (year == birth && gender == sex) {
				return true;
			} else {
				if (gender != sex) {
					layer.msg("身份证号码与性别不一致！");
				}
				if (year != birth) {
					layer.msg("身份证号码与出生日期不一致！");
				}
				return false;
			}
		}
	} else {
		return false;
	}
}

function checkValue(formObj) {
	var obj;
	var form = formObj;
	if (undefined != form.elements) {
		for (i = 0; i < form.elements.length; i++) {
			obj = form[i];
			if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
				if (obj.type == "text" && obj.value.length > 0) {
					var val = obj.value;
					obj.value = trim(val);
				}
				if (!validate(obj)) {
					obj.focus();
					return false;
				}
			}
		}
	} else {
		obj = form;
		if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
			if (!validate(obj)) {
				obj.focus();
				return false;
			}
		}
	}
	if (otherValidate(formObj) == false) {
		return false;
	}
	return true;
}
function trim(str) {
	str = Ltrim(str);
	str = Rtrim(str);
	return str;
}
function Ltrim(str) {
	while (str.length > 0 && str.substr(0, 1) == " ") str = str.substr(1);
	return str;
}
function Rtrim(str) {
	while (str.length > 0 && str.substr(str.length - 1) == "") str = str.substr(0, str.length - 1);
	return str;
}
function otherValidate(formObj) {
	return true;
}
function validate(obj) {
	if (undefined != obj.required && "true" == obj.required) {
		return checkEmpty(obj);
	}
	return true;
}
function checkEmpty(element) {
	var flag = false;
	var reSpaceCheck = /^\s*$/;
	if (reSpaceCheck.test(element.value)) {
		flag = true;
	}
	if (element.value == null || element.value == undefined || flag) {
		if (element.label == undefined) {
			layer.msg("不能为空!");
			element.select();
		} else {
			layer.msg(element.label + "不能为空!");
			element.focus();
		}
		return false;
	} else {
		return true;
	}
}
function checkMask(formObj) {
	var obj;
	var form = formObj;
	if (undefined != form.elements) {
		for (i = 0; i < form.elements.length; i++) {
			obj = form[i];
			if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
				if (!validateM(obj)) {
					obj.focus();
					return false;
				}
			}
		}
	} else {
		obj = form;
		if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
			if (!validateM(obj)) {
				obj.focus();
				return false;
			}
		}
	}
	return true;
}

function validateM(obj) {
	if (undefined != obj.mask) {
		return validateMask(obj);
	}
	return true;
}
function validateMask(obj) {
	str = trimValue(obj.value);
	obj.value = str;
	if (undefined == str || "" == str || null == str) return true;
	if ("date" == obj.mask) return validateDate(obj);
	else if ("shortdate" == obj.mask) return validateShortDate(obj);
	else if ("mediumdate" == obj.mask) return validateMediumDate(obj);
	else if ("money" == obj.mask || "plusmoney" == obj.mask) return validateMoney(obj);
	else if ("bigmoney" == obj.mask) return validateBigMoney(obj);
	else if ("card" == obj.mask) return validateCard(obj);
	else if ("period" == obj.mask) return validatePeriod(obj);
	else if ("######" == obj.mask) {
		return validatePostalcode(obj);
	} else if ("yearmonth" == obj.mask) {
		return timeinput(obj);
	} else if ("url" == obj.mask) {
		return verifyURL(obj);
	} else if ("email" == obj.mask) {
		return isValidEMail(obj);
	} else if ("rate" == obj.mask) {
		return checkRate(obj);
	} else {
		return validateNumber(obj);
	}
	return true;
}

function validateDate(element) {
	str = element.value;
	if (leafconfig.dateStyle == "0") {
		if (str.length < 8 || str.length > 8) {
			layer.msg("日期输入不合法，格式应为\"20040501\"!");
			element.value = "";
			element.select();
			return false;
		} else if (str.length == 8) {
			if (str.match(/[^\d]/g, '') != null) {
				layer.msg("日期输入不合法，格式应为\"20040501\"!");
				element.value = "";
				element.select();
				return false;
			} else {
				if (str.substr(0, 4) < 1900) {
					layer.msg("年份不能小于1900年，请重新输入！");
					element.value = "";
					return false;
				}
				if (str.substr(4, 2) > 12 || str.substr(4, 2) < 1) {
					layer.msg("月份输入不合法，请重新输入！");
					element.value = "";
					return false;
				}
				if (0 == str.substr(0, 4) % 4 && ((str.substr(0, 4) % 100 != 0) || (str.substr(0, 4) % 400 == 0))) {
					if (str.substr(4, 2) == 2) {
						if (str.substr(6, 2) > 29 || str.substr(6, 2) < 1) {
							layer.msg("日期输入不合法，请重新输入！");
							element.value = "";
							return false;
						}
					}
				}
				if (str.substr(4, 2) == 4 || str.substr(4, 2) == 6 || str.substr(4, 2) == 9 || str.substr(4, 2) == 11) {
					if (str.substr(6, 2) > 30 || str.substr(6, 2) < 1) {
						layer.msg("日期输入不合法，请重新输入！");
						element.value = "";
						return false;
					}
				}
				if (str.substr(6, 2) > 31 || str.substr(6, 2) < 1) {
					layer.msg("日期输入不合法，请重新输入！");
					element.value = "";
					return false;
				}
				return true;
			}
		} else if (str.length == 10) {
			var m = str.substr(4, 1);
			var n = str.substr(7, 1);
			if ((m == "/" && n == "/") || (m == "-" && n == "-")) {
				str = str.substr(0, 4) + str.substr(5, 2) + str.substr(8, 2);
				element.value = str;
				return true;
			} else {
				layer.msg("日期输入不合法，请重新输入！");
				element.value = "";
				return false;
			}
		}
	} else {
		if (str.length == 8) {
			var m = str.substr(4, 1);
			var n = str.substr(6, 1);
			if (m == "/" && n == "/") {
				str = str.substr(0, 4) + "-0" + str.substr(5, 1) + "-0" + str.substr(7, 1);
				element.value = str;
			} else if (m == "-" && n == "-") {
				str = str.substr(0, 4) + "-0" + str.substr(5, 1) + "-0" + str.substr(7, 1);
				element.value = str;
			} else if (m != "-" && n != "-" && m != "/" && n != "/") {
				str = str.substr(0, 4) + "-" + str.substr(4, 2) + "-" + str.substr(6, 2);
				element.value = str;
			}
		} else if (str.length == 10) {
			var m = str.substr(4, 1);
			var n = str.substr(7, 1);
			if (m == "/" && n == "/") {
				str = str.substr(0, 4) + "-" + str.substr(5, 2) + "-" + str.substr(8, 2);
				element.value = str;
			}
		} else if (str.length == 9) {
			var m = str.substr(4, 1);
			var o = str.substr(6, 1);
			var n = str.substr(7, 1);
			if (m == "/" && o == "/") {
				str = str.substr(0, 4) + "-0" + str.substr(5, 1) + "-" + str.substr(7, 2);
				element.value = str;
			} else if (m == "-" && o == "-") {
				str = str.substr(0, 4) + "-0" + str.substr(5, 1) + "-" + str.substr(7, 2);
				element.value = str;
			} else if (m == "-" && n == "-") {
				str = str.substr(0, 4) + "-" + str.substr(5, 2) + "-0" + str.substr(8, 1);
				element.value = str;
			} else if (m == "/" && n == "/") {
				str = str.substr(0, 4) + "-" + str.substr(5, 2) + "-0" + str.substr(8, 1);
				element.value = str;
			}
		}
		var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
		if (r == null) {
			layer.msg("日期输入不合法，格式应为\"2004-05-01\"!");
			element.value = "";
			element.select();
			return false;
		}
		var d = new Date(r[1], r[3] - 1, r[4]);
		if (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[4]) {
			return true;
		} else {
			layer.msg("日期输入不合法，格式应为\"2004-05-01\"!");
			element.value = "";
			element.select();
			return false;
		}
	}
}
function validateShortDate(element) {
	str = element.value;
	var r = str.match(/\d{4}/);
	if (r == null || "0" == str.charAt(0)) {
		layer.msg("日期输入不合法，格式应为\"2004\"!");
		element.select();
		return false;
	} else {
		return true;
	}
}
function validateMediumDate(element) {
	str = element.value;
	var r = str.match(/^(\d{4})(\/)(\d{1,2})$/);
	if (r == null) {
		layer.msg("日期输入不合法，格式应为\"2004/05\"!");
		element.select();
		return false;
	}
	var d = new Date(r[1], r[3] - 1, "11");
	if (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == "11") {
		return true;
	} else {
		layer.msg("日期输入不合法，格式应为\"2004/05\"!");
		element.select();
		return false;
	}
}
function validateMoney(element) {
	str = element.value;
	if (str == null || str == "") {
		return true;
	} else {
		if (str.indexOf(".") == 0) {
			if (str.length > 3 || str.lastIndexOf(".") != 0) {
				layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
				element.select();
				return false;
			} else {
				str = "0" + str;
				element.value = str;
			}
		}
		if (str.indexOf("-") == 0) {
			if (str.lastIndexOf("-") != 0) {
				layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
				element.select();
				return false;
			}
		}
		if ((str.substring(0, 1) == 0 && str.indexOf(".") != 1) && str != 0) {
			layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
			element.select();
			return false;
		}
		if (str.lastIndexOf(".") == -1) {
			if (str.length > leafconfig.moneyStyle) {
				layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
				element.select();
				return false;
			} else {
				str = str + ".00";
				element.value = str;
			}
		}
		if (str.lastIndexOf(".") != str.indexOf(".")) {
			layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
			element.select();
			return false;
		}
		if (str.length > leafconfig.moneyStyle + 3 || str.length < 1) {
			layer.msg("数字输入不合法，格式应为最大不超过" + leafconfig.moneyStyle + "位整数与2位小数，请重新输入!");
			element.select();
			return false;
		} else {
			return true;
		}
	}
}
function validateBigMoney(element) {
	str = element.value;
	if (str.indexOf(".") == 0) {
		str = "0" + str;
		element.value = str;
	}
	if (str.lastIndexOf(".") == (str.length - 1)) {
		str = str + "00";
		element.value = str;
	}
	var r = str.match(/^\d{1,10}(\.\d{1,2})?$/);
	if (r == null || ("0" == r[1].charAt(0) && r[1].length > 1)) {
		layer.msg("数字输入不合法，格式应为\"1234512345.77\"!");
		element.select();
		return false;
	} else {
		return true;
	}
}
function validateNumber(element) {
	str = element.value;
	var mask = element.mask;
	var indexDot = mask.indexOf('.');
	var intLen = mask.length;
	var decimalLen = 0;
	if (str != null && str != "") {
		if ( - 1 != indexDot) {
			intLen = mask.substr(0, indexDot).length;
			decimalLen = mask.length - intLen - 1;
		}
		if (str.indexOf('.') == 0) {
			str = "0" + str;
			element.value = str;
		}
		if (str.lastIndexOf(".") == (str.length - 1)) {
			if ( - 1 != indexDot) {
				for (var i = 0; i < decimalLen; i++) {
					str = str + "0";
				}
				element.value = str;
			}
		}
		var indexDot1 = str.indexOf('.');
		var mask = element.mask;
		var indexDot = mask.indexOf('.');
		var indexDot1 = str.indexOf('.');
		var intLen = mask.length;
		var decimalLen = 0;
		if ( - 1 != indexDot) {
			intLen = mask.substr(0, indexDot).length;
			decimalLen = mask.length - intLen - 1;
		}
		var intStrLen = str.length;
		var decimalStrLen = 0;
		if ( - 1 != str.indexOf('.')) {
			intStrLen = str.substr(0, indexDot1).length;
			decimalStrLen = str.length - intStrLen - 1;
		}
		var msg = "数字输入不合法，格式应为最大不超过" + intLen + "位整数(不能以0开头)";
		if (decimalLen > 0) msg = msg + "和" + decimalLen + "位小数!";
		var r = str.match(/^\d+(\.\d+)?$/);
		if (r == null || str.length > mask.length || intStrLen > intLen || decimalStrLen > decimalLen) {
			layer.msg(msg);
			element.select();
			return false;
		}
		if ( - 1 != indexDot1) {
			if ("0" == str.charAt(0) && indexDot1 != 1) {
				layer.msg(msg);
				element.select();
				return false;
			}
		} else {
			if ("0" == str.charAt(0) && str.length > 1) {
				layer.msg(msg);
				element.select();
				return false;
			}
		}
	}
	return true;
}
function validatePostalcode(element) {
	str = element.value;
	if (str != null && str != "") {
		var r = str.match(/^(\d{6})$/);
		if (r == null) {
			layer.msg("邮政编码输入不合法，格式应为\"100013\"的6位整数!");
			element.select();
			return false;
		}
	}
	return true;
}
function validateNumWithLength(element, validatelength) {
	var str = element.value;	
	var number_chars = "0123456789";
	for (var i = 0; i < str.length; i++) {
		if (number_chars.indexOf(str.charAt(i)) == -1) {
			layer.msg("输入不合法，格式应为整数!");
			return false;
		}
	}
	var msg = "输入不合法，格式应为" + validatelength + "位!"
	if (str.length != validatelength) {
		layer.msg(msg);
		return false;
	}
	return true;
}
function checkTimeFormat(obj) {
	var value = obj.value;
	var length = value.length;
	if (length > 9) {
		layer.msg("格式错误，请重新输入");
		obj.value = "";
	} else {
		if (length == 1) {
			obj.value = "0" + value + ":00:00";
		} else if (length == 2) {
			if (parseInt(value) - 24 <= 0) {
				obj.value = value + ":00:00";
			} else {
				layer.msg("格式错误，请重新输入");
				obj.value = "";
			}
		} else if (length == 4) {
			if (value.indexOf(":") == 1) {
				if (parseInt(value.substring(2, 4)) - 60 < 0) {
					obj.value = "0" + value + ":00";
				} else {
					layer.msg("格式错误，请重新输入");
					obj.value = "";
				}
			} else {
				layer.msg("格式错误，请重新输入");
				obj.value = "";
			}
		} else if (length == 5) {
			if (value.indexOf(":") == 2) {
				if (parseInt(value.substring(0, 2)) - 24 < 0 && parseInt(value.substring(3, 5)) - 60 < 0) {
					obj.value = value + ":00";
				} else {
					layer.msg("格式错误，请重新输入");
					obj.value = "";
				}
			} else {
				layer.msg("格式错误，请重新输入");
				obj.value = "";
			}
		} else if (length == 7) {
			if (value.substring(1, 2) == ":" && value.substring(4, 5) == ":") {
				if (parseInt(value.substring(0, 2)) - 24 < 0 && parseInt(value.substring(3, 5)) - 60 < 0 && parseInt(value.substring(6, 8)) - 60 < 0) {
					obj.value = "0" + value;
				}
			} else {
				layer.msg("格式错误，请重新输入");
				obj.value = "";
			}
		} else if (length == 8) {
			if (value.substring(2, 3) == ":" && value.substring(5, 6) == ":" && parseInt(value.substring(0, 2)) - 24 < 0 && parseInt(value.substring(3, 5)) - 60 < 0 && parseInt(value.substring(6, 8)) - 60 < 0) {} else {
				layer.msg("格式错误，请重新输入");
				obj.value = "";
			}
		} else if (value == "") {} else {
			layer.msg("格式错误，请重新输入");
			obj.value = "";
		}
	}
}
function checkRate(obj) {
	var value = obj.value;
	var len = value.length;
	if (value.indexOf("-") != -1) {
		layer.msg("请输入0-1的小数");
		obj.value = "";
		obj.select();
		return false;
	}
	if (value.indexOf("/") != -1) {
		layer.msg("请输入0-1的小数");
		obj.value = "";
		obj.select();
		return false;
	}
	if (value.indexOf(".") != value.lastIndexOf(".") || value.indexOf(".") != 1) {
		layer.msg("请输入0-1的小数");
		obj.value = "";
		obj.select();
		return false;
	}
	if (parseInt(value.substring(0, 1)) > 1) {
		layer.msg("请输入0-1的小数");
		obj.value = "";
		obj.select();
		return false;
	}
	if (value.substring(0, 1) == "1") {
		for (var i = 2; i < len; i++) {
			if (value.substring(i, i + 1) != "0") {
				layer.msg("请输入0-1的小数");
				obj.value = "";
				obj.select();
				return false;
				break;
			}
		}
	}
	return true;
}
function isValidEMail(Email) {
	var EmailStr = Email.value;
	if (EmailStr == "") return true;
	var myReg = /[_a-zA-Z0-9]+@([_a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,3}$/;
	if (myReg.test(EmailStr)) return true;
	else {
		layer.msg("请输入有效的E-MAIL!");
		Email.select();
		return false;
	}
}

function decimalToPercent(obj) {
	var value = obj.value;
	if (value != null && value != "" && value.substring(value.length - 1, value.length) != "%") {
		if (value.split(".").length == 2) {
			var log = "true";
			value = value.replace(".", "");
			if (value.length < 3) {
				if (value.substring(0, 1) == 0) {
					if (value.substring(1, 2) == 0) {
						value = "0%";
					} else {
						value = value.substring(1, 2) + "0%";
					}
				} else {
					value = value + "0%";
				}
			} else if (value.length == 3) {
				if (value.substring(0, 1) == 0) {
					if (value.substring(1, 2) == 0) {
						value = value.substring(2, 3) + "%";
					} else {
						value = value.substring(1, 3) + "%";
					}
				} else {
					value = value + "%";
				}
			} else if (value.length > 3) {
				if (value.substring(0, 1) == 0) {
					for (var j = 0; j < value.length; j++) {
						if (value.substring(j, j + 1) != 0) {
							if (j > 3) {
								value = "0." + value.substring(3, value.length) + "%";
							} else {
								if (j == 1) {
									value = value.substring(j, j + 2) + "." + value.substring(j + 1, value.length) + "%";
								} else if (j == 2) {
									value = value.substring(j, j + 1) + "." + value.substring(j + 1, value.length) + "%";
								}
							}
							log = "false";
							break;
						}
					}
					if (log == "true") {
						value = "0%";
					}
				} else {
					value = value.substring(0, 3) + "." + value.substring(3, value.length) + "%";
				}
			}
		} else if (value.split(".").length == 1) {
			if (value.substring(0, 1) == 0) {
				layer.msg("输入有误，请重新输入！");
			} else {
				value = value + "00%";
			}
		} else {
			layer.msg("输入有误，请重新输入！");
		}
	}
	return value;
}


function getFormValue(frm) {
	var row = "";
	if (frm.elements.length) {
		for (var i = 0; i < frm.length; i++) {
			var obj = frm[i];
			if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
				var name = obj.name;
				var value = obj.value;
				row = row + name + "=" + value + "&";
			}
		}
	}
	return row;
}
function getAlldata(obj) {
	var row = "";
	var flag = 0;
	if (obj.length) {
		for (var i = 0; i < obj.length; i++) {
			if (obj(i).type != "submit" && obj(i).type != "reset" && obj(i).type != "button") {
				if (obj(i).type == "radio" || obj(i).type == "checkbox") {
					if (obj(i).checked) {
						flag = 1;
					} else {
						flag = 0;
					}
				} else {
					if (flag == 1) {
						var name = obj(i).name;
						var value = obj(i).value;
						row = row + name + "=" + value + "&";
					}
				}
			}
		}
	} else {
		if (obj.type != "submit" && obj.type != "reset" && obj.type != "button") {
			if (obj.type == "radio" || obj.type == "checkbox") {
				if (obj.checked) {
					flag = 1;
				} else {
					flag = 0;
				}
			} else {
				if (flag == 1) {
					var name = obj.name;
					var value = obj.value;
					row = row + name + "=" + value + "&";
				}
			}
		}
	}
	return row;
}


function loadScript() {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://webapi.amap.com/maps?v=1.3&key=242ac779e3b541ba8bcf5990601e3768&callback=init";
	document.body.appendChild(script);
}

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

//设置为主页 
function setHome(obj,vrl){ 
try{ 
	obj.style.behavior='url(#default#homepage)';
	obj.setHomePage(vrl); 
} catch(e){ 
	if(window.netscape) { 
			try { 
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
			}catch (e) {
				layer.msg("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
			} 
		  var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
		  prefs.setCharPref('browser.startup.homepage',vrl); 
	}else{
		layer.msg("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。");
	} 
 } 
} 


// 加入收藏 兼容360和IE6 
function addFav(sTitle,sURL) { 
	try{ 
		window.external.addFavorite(sURL, sTitle); 
	}catch (e) { 
		try { 
			window.sidebar.addPanel(sTitle, sURL, ""); 
		} catch (e) {
			layer.msg("加入收藏失败，请使用Ctrl+D进行添加");
		} 
	} 
} 

