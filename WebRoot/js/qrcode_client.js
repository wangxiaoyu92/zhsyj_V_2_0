(function () {

    function QRCode() {
        //二维码请求函数
        this.qrcode_interval = null;
        //二维码超时计时器
        this.qrcode_timeOut_timer = null;
        this.isFocused = false;
        this.trueShowQRCodeInnerHTML = "";
        this.qrcodeTabContainer = null;
        this.qrcodeContentContainer = null;
        this.JSQRCodeTab = null;
        this.options = {};
        this.ajax = new Ajax();
        this.innerHTMLs = {
            loaded: '<span class="qr_tab"><i><img src="http://pic.c-ctrip.com/VacationOnlinePic/vbooking/qr_code.png"></i>扫码登录</span>',
            showQRCode: '<div class="qr_pic_box"> \
                    <img width="200px" height="200px" src="qrcodeImgPlaceHolder">\
                    <div class="qr_overtime_bg"></div> \
                    <div class="qr_overtime_notice"> \
                        <p class="n_txt">二维码失效</p> \
                        <a href="javascript: void(0)" class="org_btn">点击刷新</a> \
                    </div> \
                </div> \
                <div class="qr_info_box"> \
                    <p class="txt01">手机扫码&nbsp;&nbsp;安全登录</p> \
                    <p class="txt_withqr">打开食药监管手机端<br>扫一扫登录</p> \
                </div>',
            showExpire: '<div class="qr_pic_box qr_overtime"> \
                    <img src="http://pic.c-ctrip.com/VacationOnlinePic/vbooking/qr_code.png">\
                    <div class="qr_overtime_bg"></div>\
                    <div class="qr_overtime_notice">\
                        <p class="n_txt">二维码失效</p>\
                        <a href="javascript: void(0)" class="org_btn js_qrcode_refresh">点击刷新</a>\
                    </div>\
                </div>\
                <div class="qr_info_box">\
                    <p class="txt01">手机扫码&nbsp;&nbsp;安全登录</p> \
                    <p class="txt_withqr">打开食药监管手机端<br>扫一扫登录</p> \
                </div>',
            showGoToConfirm: '<div class="qr_pic_box">\
                        <img src="./img/login_scan_success.png">\
                    </div>\
                    <div class="qr_info_box">\
                        <p class="txt01">手机扫码&nbsp;&nbsp;安全登录</p>\
                        <p class="txt02">扫描成功</p>\
                        <p class="txt03">请在手机上确认登录</p>\
                        <a href="javascript: void(0)" class="a_back" id="js_backQRCode">返回二维码登录</a>\
                    </div>'
        };

        this.fetch = function () {
            this.ajax.options = this.options;
            this.ajax.fetch();
        };

        this.getQRImgUrlOrBase64 = function () {
            var _this = this;
            _this.trueShowQRCodeInnerHTML = _this.innerHTMLs.showQRCode.replace(
                "qrcodeImgPlaceHolder",
                "servlet/QRCodeServlet"
            );
            _this.showQRCode();
            this.fetch();
        };

        this.init = function () {
            var _this = this;
            this.qrcodeTabContainer = this.getOneElementByClassName("login_tab");
            this.qrcodeContentContainer = this.getOneElementByClassName(
                "content_box"
            );
            //暂存原始qrcodeContentContainer中内容
            this.innerHTMLs.showZHSYJ = this.qrcodeContentContainer.innerHTML
            //获取二维码
            this.qrcodeLoaded();
            //
            var ctripLogin = document.getElementById("lnkUIDLogin");
            ctripLogin.className += " rtlink";
            ctripLogin.innerHTML += "";
            this.JSQRCodeTab = document.getElementById("js_qrcode_tab");
            this.JSQRCodeTab.addEventListener("click", function (event) {
                _this.getQRImgUrlOrBase64();
            });
            var vbkTab = this.getOneElementByClassName('cur')
            vbkTab.addEventListener('click', function (event) {
                window.location.reload()
            })
        };
        this.getEnv = function () {
            var host = window.location.host;
            if (host.indexOf(".fat") !== -1) {
                return "fat";
            } else if (host.indexOf(".uat") !== -1) {
                return "uat";
            } else {
                return "prod";
            }
        };
        this.showQRCode = function () {
            var _this = this;
            this.qrcodeContentContainer.className = this.qrcodeContentContainer.className.replace(
                "content_box01",
                "content_box02"
            );
            this.qrcodeContentContainer.innerHTML = this.trueShowQRCodeInnerHTML;
            this.isFocused = true;
            //var allArrTabs = [];
            var allTabs = this.JSQRCodeTab.parentNode.children;
            allTabs = Array.prototype.slice.call(allTabs, 0);
            for (var i = 0; i < allTabs.length; i++) {
                var item = allTabs[i];
                if (item.tagName.toLowerCase() === "a") {
                    if (item.id !== "js_qrcode_tab") {
                        if (this.hasClass(item.className, "cur")) {
                            this.removeClass(item, "cur");
                        }
                    } else {
                        item.className = "cur";
                    }
                }
            }
            //清除二维码状态请求
            clearInterval(this.qrcode_interval);
            this.qrcode_interval = setInterval(this.checkStat.bind(this), 3000);
            //清除二维码超时计时器
            clearTimeout(this.qrcode_timeOut_timer);
            //重置二维码超时计时器
            this.qrcode_timeOut_timer = setTimeout(
                function (_this) {
                    _this.showExpire();
                },
                60 * 1000,
                _this
            );
        };

        this.checkStat = function () {
            var _this = this;
            this.options = {
                url: basePath + "login/checkStat",
                type: "POST",
                success: function (response) {
                    var result = JSON.parse(response);
                    if (result.code == '0') {
                        if (result.STAT == '200' || result.STAT == '100' || result.STAT == '1031') {
                            if (result.STAT == '200') {
                                console.log("正在进行授权登陆...");
                                jump2MainPage();
                            } else if (result.STAT == '1031') {
                                this.showExpire();
                                clearInterval(_this.qrcode_interval);
                                clearInterval(_this.qrcode_timeOut_timer);
                            }
                        } else {
                            console.log('提示' + result.STAT + result.MSG + 'info');
                            clearInterval(_this.qrcode_interval);
                            clearInterval(_this.qrcode_timeOut_timer);
                        }
                    } else {
                        console.log('提示' + '二维码授权登录失败！' + result.msg + 'error');
                        clearInterval(_this.qrcode_interval);
                        clearInterval(_this.qrcode_timeOut_timer);
                    }
                }
            };
            this.fetch();
        };

        this.showGoToConfirm = function () {
            var _this = this
            this.qrcodeContentContainer.innerHTML = this.innerHTMLs.showGoToConfirm;
            document.getElementById("js_backQRCode").addEventListener('click', function (event) {
                _this.getQRImgUrlOrBase64();
            });
        };

        this.showExpire = function () {
            var _this = this;
            //清除请求状态函数
            clearInterval(this.qrcode_interval);
            //显示二维码过期提醒
            this.qrcodeContentContainer.innerHTML = this.innerHTMLs.showExpire;
            //绑定二维码点击刷新事件
            var jsQrcodeRefresh = this.getOneElementByClassName("js_qrcode_refresh");
            jsQrcodeRefresh.addEventListener("click", function () {
                _this.refreshQRCode();
            });
        };

        this.refreshQRCode = function () {
            this.getQRImgUrlOrBase64();
        };

        this.qrcodeLoaded = function () {
            var ALink = document.createElement("a");
            ALink.href = "javascript: void(0)";
            ALink.id = "js_qrcode_tab";
            ALink.innerHTML = qrcode.innerHTMLs.loaded;

            this.qrcodeTabContainer.appendChild(ALink);
        };

        this.getOneElementByClassName = function (classString) {
            var elements = document.getElementsByClassName(classString);
            return (elements && elements[0]) || document.createElement("div");
        };

        this.removeClass = function (element, singleClass) {
            if (!this.hasClass(element.className, singleClass)) {
                return;
            }
            var classString = element.className;
            var classList = this.getClassList(classString);
            var index = classList.indexOf(singleClass);
            classList.splice(index, 1);
            element.className = classList.join(" ");
        };

        this.hasClass = function (classString, singleClass) {
            return this.getClassList(classString).indexOf(singleClass) >= 0;
        };

        this.getClassList = function (classString) {
            return classString.split(" ");
        };
    }

    function Ajax(options) {
        this.options = options;
        this.fetch = function () {
            options = this.options || {};
            options.type = (options.type || "GET").toUpperCase();
            options.dataType = options.dataType || "json";
            var params = this.formatParams(options.data);
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    var status = xhr.status;
                    if (status >= 200 && status < 300) {
                        options.success && options.success(xhr.responseText);
                    } else {
                        options.fail && options.fail(status);
                    }
                }
            };

            if (options.type === "GET") {
                xhr.open("GET", basePath + "?" + params, true);
                xhr.send(null);
            } else if (options.type == "POST") {
                xhr.open("POST", options.url, true);
                xhr.setRequestHeader(
                    "Content-Type",
                    "application/x-www-form-urlencoded"
                );
                xhr.send(params);
            }
        };

        this.formatParams = function (data) {
            var arr = [];
            for (var name in data) {
                arr.push(
                    encodeURIComponent(name) + "=" + encodeURIComponent(data[name])
                );
            }
            arr.push(("v=" + Math.random()).replace(".", ""));
            return arr.join("&");
        };
    }

    //二维码初始化 当load时
    window.addEventListener("load", function () {
        //初始化二维码对象
        window.qrcode = new QRCode();
        //调用初始化方法
        qrcode.init();
    });

    var jump2MainPage = function () {
        window.location.reload(true);
    }

})();
