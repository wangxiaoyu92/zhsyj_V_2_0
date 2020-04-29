function isNotaNumber(inputString) {
	if (trim(inputString) == "")
		return true;
	return isNaN(inputString);
}
function setNullDateForm(content) {
	document.all[content].value = "1900-01-01";
	return "1900-01-01";
}
function setNullDate() {
	return "1900-01-01";
}
function startVsEndForm(startDate, endDate) {
	var start = document.all[startDate].value;
	var end = document.all[endDate].value;
	return startVsEnd(start, end);
}
function startVsEnd(startDate, endDate) {
	if (startDate > endDate) {
		return (false);
	} else {
		return (true);
	}
}
function isStringDateForm(obj, msg) {
	var szValue = document.all[obj].value;
	return isStringDate(szValue, msg);
}
function isStringDate(szDate, msg) {
	arDate = new Array("", "", "");
	arDate = szDate.split("-");
	msg = msg + "格式错误:";
	if (arDate.length > 2) {
		if (isNotaNumber(arDate[0])) {
			alert(msg + "年度不能为空!");
			return (false);
		}
		if (isNotaNumber(arDate[1])) {
			alert(msg + "月份不能为空!");
			return (false);
		}
		if (isNotaNumber(arDate[2])) {
			alert(msg + "日期不能为空!");
			return (false);
		}
		year = parseInt(arDate[0], 10);
		month = parseInt(arDate[1], 10);
		day = parseInt(arDate[2], 10);
	} else {
		alert("日期格式错误！");
		return false;
	}
	if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
		if ((day < 1) || (day > 30)) {
			alert(msg + "日期在1 - 30之间");
			return (false);
		}
	} else {
		if (month != 2) {
			if ((day < 1) || (day > 31)) {
				alert(msg + "日期在1 - 31之间");
				return (false);
			}
		} else {
			if ((year % 100) != 0 && (year % 4 == 0) || (year % 100) == 0
					&& (year % 400) == 0) {
				if (day > 29) {
					alert(msg + "日期在1 - 29之间");
					return (false);
				}
			} else {
				if (day > 28) {
					alert(msg + "日期在1 - 28之间");
					return (false);
				}
			}
		}
	}
	return true;
}
function isValidDateForm(year, month, day, msg) {
	var years = document.all[year].value;
	var months = document.all[month].value;
	var days = document.all[day].value;
	return isValidDate(years, months, days, msg)
}
function isValidDate(year, month, day, msg) {
	msg = msg + "格式错误:";
	if (year == "") {
		alert(msg + "年度不能为空!");
		return (false);
	}
	if (month == "") {
		alert(msg + "月份不能为空!");
		return (false);
	}
	if (day == "") {
		alert(msg + "日期不能为空!");
		return (false);
	}
	year = parseInt(year, 10);
	month = parseInt(month, 10);
	day = parseInt(day, 10);
	if (month < 1 || month > 12) {
		alert(msg + "月份在1-12之间");
		return false;
	}
	if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
		if ((day < 1) || (day > 30)) {
			alert(msg + "日期在1 - 30之间");
			return (false);
		}
	} else {
		if (month != 2) {
			if ((day < 1) || (day > 31)) {
				alert(msg + "日期在1 - 31之间");
				return (false);
			}
		} else {
			if ((year % 100) != 0 && (year % 4 == 0) || (year % 100) == 0
					&& (year % 400) == 0) {
				if (day > 29) {
					alert(msg + "日期在1 - 29之间");
					return (false);
				}
			} else {
				if (day > 28) {
					alert(msg + "日期在1 - 28之间");
					return (false);
				}
			}
		}
	}
	return true;
}
function isSpecLetterForm(str) {
	var strs = document.all[str].value;
	return isSpecLetter(strs);
}
function isSpecLetter(str) {
	if (str == null || str == "") {
		return true;
	}
	var alphaChars = "abcdefghijklmnopqrstuvwxyz";
	var digitChars = "0123456789";
	var asciiChars = alphaChars + digitChars + "_.@ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var v_len = str.length;
	var i;
	for (i = 0; i < v_len; i++) {
		if (asciiChars.indexOf(str.charAt(i)) == -1)
			return false;
	}
	return true;
}
function isNumberForm(str) {
	var strs = document.all[str].value;
	return isNumber(strs);
}
function isNumber(str) {
	if (str == null || str == "") {
		return true;
	}
	var asciiChars = "0123456789";
	var v_len = str.length;
	var i;
	for (i = 0; i < v_len; i++) {
		if (asciiChars.indexOf(str.charAt(i)) == -1)
			return false;
	}
	return true;
}
function isMailForm(str) {
	var strs = document.all[str].value;
	return isMail(strs);
}
function isMail(str) {
	if (str == null || str == "") {
		return true;
	}
	if (str.length < 5)
		return false;
	if (str.indexOf(" ") > 2)
		return false;
	if (str.indexOf("@") == -1)
		return false;
	if (str.indexOf(".") == -1)
		return false;
	if (str.lastIndexOf(".") == str.length)
		return false;
	index1 = str.indexOf("@", 0);
	index2 = str.indexOf(".", 0);
	if (index1 < 1 || index2 < 2 || index2 >= str.length - 1) {
		return false;
	}
	return true;
}
function formatLessTen(szValue) {
	if (szValue < 10)
		return ("0" + szValue);
	else
		return (szValue);
}
function isNullForm(str, msg) {
	var strs = document.all[str].value;
	return isNull(strs, msg);
}
function isNull(str, msg) {
	var szValue = str;
	if (szValue == null || szValue == "") {
		alert(msg + "不能为空,请录入!");
		return false;
	}
	return true;
}
function tooLargeForm(str, len, msg) {
	var strs = document.all[str].value;
	return tooLarge(strs, len, msg);
}
function tooLarge(str, len, msg) {
	var szValue = str;
	if (szValue.length > len) {
		alert(msg + "不能大于" + len + "字,请重新输入!");
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
	while (str.length > 0 && str.substr(0, 1) == " ")
		str = str.substr(1);
	return str;
}
function Rtrim(str) {
	while (str.length > 0 && str.substr(str.length - 1) == "")
		str = str.substr(0, str.length - 1);
	return str;
}
function checkID(object, year, month, day, gender) {
	var obj = document.all[object];
	if (obj == null) {
		return false;
	}
	var str = trim(obj.value);
	var len = str.length;
	var sYear = "";
	var sMonth = "";
	var sDay = "";
	var sSex = "";
	var msg = "";
	var ch = "0123456789";
	var str_ch = "";
	if (len != 15 && len != 18) {
		alert("您的居民身份证长度为" + len + "，应该为15位或18位！");
		return false;
	}
	if (len == 15) {
		sYear = parseInt(str.substring(6, 8), 10);
		sMonth = parseInt(str.substring(8, 10), 10);
		sDay = parseInt(str.substring(10, 12), 10);
		sSex = parseInt(str.substring(14, 15), 10);
		str_ch = str.substring(0, 15);
	} else if (len == 18) {
		sYear = parseInt(str.substring(6, 10), 10);
		sMonth = parseInt(str.substring(10, 12), 10);
		sDay = parseInt(str.substring(12, 14), 10);
		sSex = parseInt(str.substring(16, 17), 10);
		str_ch = str.substring(0, 17);
		if (sYear < 1900 || sYear > 2100) {
			alert("居民身份证号码年份出错！");
			return false;
		}
	}
	for ( var i = 0; i < str_ch.length; i++) {
		if (ch.indexOf(str_ch.charAt(i)) == -1) {
			alert("居民身份证号码含有非法字符！");
			return false;
		}
	}
	if (sMonth < 1 || sMonth > 12) {
		alert("月份应在1 - 12！");
		return false;
	}
	if ((sMonth == 4) || (sMonth == 6) || (sMonth == 9) || (sMonth == 11)) {
		if ((sDay < 1) || (sDay > 30)) {
			alert("日期应在1 - 30之间");
			return (false);
		}
	} else {
		if (sMonth != 2) {
			if ((sDay < 1) || (sDay > 31)) {
				alert("日期在1 - 31之间");
				return (false);
			}
		} else {
			if ((sYear % 100) != 0 && (sYear % 4 == 0) || (sYear % 100) == 0
					&& (sYear % 400) == 0) {
				if (sDay > 29) {
					alert("日期在1 - 29之间");
					return (false);
				}
			} else {
				if (sDay > 28) {
					alert("日期应在1 - 28之间");
					return (false);
				}
			}
		}
	}
	if (year != null) {
		if (len == 15) {
			if (sYear != year.substring(year.length - 2, year.length))
				msg = "出生日期中的年份";
		}
		if (len == 18) {
			if (sYear != year)
				msg = "出生日期中的年份";
		}
	}
	if (month != null) {
		if (sMonth != parseInt(month, 10)) {
			if (msg == "")
				msg = "出生日期中的月份"
			else
				msg = msg + "、月份";
		}
	}
	if (day != null) {
		if (sDay != parseInt(day, 10)) {
			if (msg == "")
				msg = "出生日期中的日期"
			else
				msg = msg + "、日期";
		}
	}
	if (gender != null) {
		if ((sSex == 1) || (sSex == 3) || (sSex == 5) || (sSex == 7)
				|| (sSex == 9)) {
			if (gender == 2) {
				if (msg == "")
					msg = "性别"
				else
					msg = msg + "及性别";
			}
		} else if ((sSex == 0) || (sSex == 2) || (sSex == 4) || (sSex == 6)
				|| (sSex == 8)) {
			if (gender == 1) {
				if (msg == "")
					msg = "性别"
				else
					msg = msg + "及性别";
			}
		}
	}
	if (msg != "") {
		if (!window.confirm(msg
				+ "与居民身份证号码中的数据不符合，是否继续操作？点击确定继续下一步操作，点击取消重新修改！"))
			return false;
	}
	return true;
}
function isIPlist(iplist) {
	if (iplist != '') {
		var ips = iplist.split(',');
		for ( var i = 0; i < ips.length; i++) {
			if (!isIPSegment(ips[i])) {
				alert("IP地址格式错误：" + ips[i]);
				return false;
			}
		}
	}
	return true;
}
function isIPSegment(ip) {
	var ipseg = ip.split('.');
	if (4 != ipseg.length) {
		return false;
	}
	for ( var i = 0; i < ipseg.length; i++) {
		if ('*' != ipseg[i]) {
			if (ipseg[i].indexOf('-') < 0) {
				if (isNaN(ipseg[i]) || ipseg[i] < 0 || ipseg[i] > 255) {
					return false;
				}
			} else {
				var sects = ipseg[i].split('-');
				if (sects.length != 2) {
					return false;
				}
				for ( var j = 0; j < sects.length; j++) {
					if (isNaN(new Number(sects[j]))) {
						return false;
					}
					var sect = parseInt(sects[j]);
					if (isNaN(sect) || sect < 0 || sect > 255) {
						return false;
					}
				}
			}
		}
	}
	return true;
}