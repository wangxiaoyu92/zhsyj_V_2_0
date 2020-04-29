window.onkeydown = function(e) {
    var ev = window.event || e;
    if (ev.keyCode == 13) //ENTER
    {
        return false;
    }
}


//测试输入框的值是否整数
function checkNum(inputObj) {
    var regex = /^\d*$/;
    return regex.test(inputObj.value);
}


//测试输入框的值的个数
function checkLength(inputObj, maxLength) {
    return inputObj.value.length <= maxLength;
}


//将字符串的首尾空格全部去掉
String.prototype.Trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}
//测试输入框输入值.value的字符长度
function txtlength(obj, len) {
    if (obj.value.replace(/[^\x00-\xFF]/g, '**').length >= len) {
        return false;
    }
    else {
        return true;
    }
}
//测试输入框是否空值.value
function checkInputValueIsEmpty(inputObj) {
    var s = inputObj.value.Trim();
    if (s == null || s == "") {
        return false;
    }
    else {
        return true;
    }
}
function getVali(inputValue) {
    if (inputValue != null || inputValue != undefined) {
        var regex = /^[+-]?\d*\.?\d{0,3}$/;
        return regex.test(inputValue);
    }
}

//判断一个控件的值是否为空
function checkValueIsEmpty(inputValue) {
    var strValue = inputValue.Trim();
    if (strValue == null || strValue == "") {
        return true;
    }
    else {
        return false;
    }
}


//验证最大长度指定的正小数,inputObj为input对象，beforeLength为小数点前面的位数个数，afterLength为小数点后面的位数个数
function checkNumberLength(inputObj, beforeLength, afterLength) {
    if (inputObj.value.indexOf(".") >= 0) {
        var regex = new RegExp("^\\d{0," + beforeLength + "}[.]?\\d{0," + afterLength + "}$");
        return regex.test(inputObj.value.Trim());
    }
    else {
        var regex = new RegExp("^\\d{0," + beforeLength + "}$");
        return regex.test(inputObj.value.Trim());
    }
}


//验证最大长度指定的正负小数,inputObj为input对象，beforeLength为小数点前面的位数个数，afterLength为小数点后面的位数个数
function checkAllNumberLength(inputObj, beforeLength, afterLength) {
    if (inputObj.value.indexOf(".") >= 0) {
        var regex = new RegExp("^-?\\d{0," + beforeLength + "}[.]?\\d{0," + afterLength + "}$");
        return regex.test(inputObj.value.Trim());
    }
    else {
        var regex = new RegExp("^-?\\d{0," + beforeLength + "}$");
        return regex.test(inputObj.value.Trim());
    }
}

//验证最大长度指定的正负小数value
function checkAllNumberLengthByValue(inputValue, beforeLength, afterLength) {
    if (inputValue.indexOf(".") >= 0) {
        var regex = new RegExp("^-?\\d{0," + beforeLength + "}[.]?\\d{0," + afterLength + "}$");
        return regex.test(inputValue.Trim());
    }
    else {
        var regex = new RegExp("^-?\\d{0," + beforeLength + "}$");
        return regex.test(inputValue.Trim());
    }
}


//测试输入框的值是否带小数
function checkNumber(inputObj) {
    var regex = /^([0-9]*)([.]?)([0-9]*)$/;
    return regex.test(inputObj.value);
}


//测试输入框的值是否小数
function checkAllNumber(inputObj) {
    var regex = /^-?([0-9]*)([.]?)([0-9]*)$/;
    return regex.test(inputObj.value);
}


//测试身份证验证
function checkIDnumber(inputObj) {
    var regex = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
    return regex.test(inputObj.value);
}


//测试邮箱验证
function checkemail(inputObj) {
    var regex = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    return regex.test(inputObj.value);
}
//测试邮箱验证
function checkMail(inputObj) {
    var regex = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
    return regex.test(inputObj.value);
}
function KeyPress(inputObj) {//只允许录入数据字符 0-9 和小数点
    var txtval = inputObj.value;
    var key = event.keyCode;
    if ((key < 48 || key > 57) && key != 46) {
        event.returnValue = false;
    }
    else if (key == 46) {
        if (txtval.indexOf(".") != -1 || txtval.length == 0)
            event.returnValue = false;
    }
}


function KeyPressAllNumber(inputObj) {//只允许录入所有小数
    var txtval = inputObj.value;

    var key = event.keyCode;
    if ((key < 48 || key > 57) && key != 46 && key != 45) {
        event.returnValue = false;
    }
    else if (key == 46) {
        if (txtval.indexOf(".") != -1 || txtval.length == 0)
            event.returnValue = false;
    }
    else if (key == 45) {
        if (txtval.indexOf("-") != -1)
            event.returnValue = false;
    }
}


//输入整数
function KeyPressNum() {//只允许录入数据字符 0-9
    var key = event.keyCode;
    if ((key < 48 || key > 57)) {
        event.returnValue = false;
    }
}


function checkInputValueIsEmptyOrOverLength(inputObj, inputLength, inputField) {
    if (!checkInputValueIsEmpty(inputObj)) {
        alert(inputField + "不能为空！");
        return false;
    }
    if (!checkLength(inputObj, inputLength)) {
        alert(inputField + "输入值超出最大长度！");
        return false;
    }
    return true;
}


//将inputObj的文本全角转半角
function DBC2SBC(inputObj) {
    var result = "";
    for (var i = 0; i < inputObj.value.length; i++) {
        code = inputObj.value.charCodeAt(i); //获取当前字符的unicode编码
        if (code >= 65281 && code <= 65373)//在这个unicode编码范围中的是所有的英文字母已及各种字符
        {
            result += String.fromCharCode(inputObj.value.charCodeAt(i) - 65248);
            //把全角字符的unicode编码转换为对应半角字符的unicode码
        }
        else if (code == 12288)//空格
        {
            result += String.fromCharCode(inputObj.value.charCodeAt(i) - 12288 + 32);
        }
        else {
            result += inputObj.value.charAt(i);
        }
    }
    inputObj.value = result;
}


//判断输入的中英文
function checkByteLength(inputObj) {
    var byteLen = 0, len = inputObj.value.length;
    if (inputObj.value) {
        for (var i = 0; i < len; i++) {
            if (inputObj.value.charCodeAt(i) > 255) {//一字节有8位2进制数，从0开始，2的8次方就是255；如果大于255,就表示占用了2个字节
                byteLen += 2;
            }
            else {
                byteLen++;
            }
        }
        return byteLen;
    }
    else {
        return 0;
    }
}

//日期差数
function daysBetween(DateOne, DateTwo) {
    var OneMonth = DateOne.substring(5, DateOne.lastIndexOf('-'));
    var OneDay = DateOne.substring(DateOne.length, DateOne.lastIndexOf('-') + 1);
    var OneYear = DateOne.substring(0, DateOne.indexOf('-'));
    var TwoMonth = DateTwo.substring(5, DateTwo.lastIndexOf('-'));
    var TwoDay = DateTwo.substring(DateTwo.length, DateTwo.lastIndexOf('-') + 1);
    var TwoYear = DateTwo.substring(0, DateTwo.indexOf('-'));
    var subtract = ((Date.parse(OneMonth + '/' + OneDay + '/' + OneYear) - Date.parse(TwoMonth + '/' + TwoDay + '/' + TwoYear)) / 86400000);
    return subtract;
}


function checkMobile(objValue) {
    return (/^1[3|5][0-9]\d{4,8}$/.test(objValue));
}

//只能输入数字、26个英文字母或者下划线组成的字符串
function getRegister(inputValue) {
    var regex = /^[\u4E00-\u9FA5a-zA-Z0-9_]*$/;
    if (!regex.test(inputValue.value)) {
        inputValue.value = "";
        return false;
    } else {
        return false;
    }
}


function getMove(objdiv) {
    var event = window.event;
    $('#' + objdiv + ' input[type=text]').keydown(function(event) {
        event = event ? event : window.event;
        var realkey = event.which ? event.which : event.keyCode;     //获取按键值
        if (realkey == 37) {//-号键值，看具体需要，此处可以替换成方向键等的键值。
            event.keyCode = 0;
            //左键是后退,shift+tab
            //new ActiveXObject('WScript.Shell').SendKeys('+{TAB}');///方式1：每次访问会弹出安全提示，并且光标会移出页面到达浏览器地址栏。
            //$(this).parent().parent().prev().find('.type').focus();//方式2：不够通用,如果页面元素结构复杂则无效。
            ///////////////////////////////////////////////////////////方式3：通用的方式,如下
            var index = $('#' + objdiv + ' input[type=text]').index($(this));
            index--;
            $('#' + objdiv + ' input[type=text]').eq(index).focus();
            return false;
        } else if (realkey == 38) { //up
            if ($(this).parent().parent().prev().length >= 1) {
                $(this).parent().parent().prev().children().children().eq($(this).parent().prevAll().length).focus();
            }
            return false;
        }
        else if (realkey == 39) {
            ///////////////////////////////////////////////////////////方式1：右键是前进,把键值更换为tab的键值,光标会移出页面到达浏览器地址栏。
            //event.keyCode = 9;
            //$(this).parent().parent().next().find('.type').focus();//方式2：不够通用,如果页面元素结构复杂则无效。
            ///////////////////////////////////////////////////////////方式3：通用的方式,如下
            event.keyCode = 0;
            var index = $('#' + objdiv + ' input[type=text]').index($(this));
            index++;
            $('#' + objdiv + ' input[type=text]').eq(index).focus();
            return false;
        } else if (realkey == 40) {   //DOWN
            if ($(this).parent().parent().next().length >= 1) {
                $(this).parent().parent().next().children().children().eq($(this).parent().prevAll().length).focus();
            }
            return false;
        }
    });
}



function CheckRegMobile(objValue) {
    //验证手机号码，包含13，18，15，147号段
    if (objValue != "") {
        var mobile = objValue;
        var reg0 = /^13\d{9}$/;
        var reg1 = /^18\d{9}$/;
        var reg2 = /^15\d{9}$/;
        var reg4 = /^147\d{9}$/;
        var reg3 = /^0\d{11}$/;
        var my = false;
        if (reg0.test(mobile)) my = true;
        if (reg1.test(mobile)) my = true;
        if (reg2.test(mobile)) my = true;
        if (reg4.test(mobile)) my = true;
        if (reg3.test(mobile)) my = true;
        if (!my) {
            return false;
        }
        return true;
    }
} 