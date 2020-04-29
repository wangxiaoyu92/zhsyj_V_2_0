<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String systemcode = StringHelper.showNull2Empty(request.getParameter("systemcode"));
    System.out.print("-----------" + systemcode + "------------");
    //用户名+密码+验证码登录开关
    String yzmSwitch = "1";
    String f_username = "";
    String f_password = "";
    String v_bgimg1="./img/bg111.jpg";
    String v_bgimg2="./img/bg112.jpg";
    String v_wheresys=SysmanageUtil.g_wheresys;
    if ("zhongmou".equals(v_wheresys)){
         v_bgimg1="./img/bgzm001.jpg";
         v_bgimg2="./img/bgzm001.jpg";
    }
    String qryzmSwitch = StringHelper.showNull2Empty(SysmanageUtil.getAa01("QRYZMSWITCH").getAaa005());
    if (!"".equals(qryzmSwitch)) {
        yzmSwitch = qryzmSwitch;
    }

    String dev = StringHelper.showNull2Empty(SysmanageUtil.getAa01("DEV").getAaa005());
    String back_username = StringHelper.showNull2Empty(SysmanageUtil.getAa01("BACK_USERNAME").getAaa005());
    String back_password = StringHelper.showNull2Empty(SysmanageUtil.getAa01("BACK_PASSWORD").getAaa005());
    String indexImg = StringHelper.showNull2Empty(SysmanageUtil.getAa01("INDEX_IMG").getAaa005());
    String indexAppQRCodeImg = StringHelper.showNull2Empty(SysmanageUtil.getAa01("INDEX_APP_QRCODE_IMG").getAaa005());
    String indexClickDownloadUrl = StringHelper.showNull2Empty(SysmanageUtil.getAa01("INDEX_DOWNLOAD_URL").getAaa005());

    if (!"".equals(qryzmSwitch)) {
        yzmSwitch = qryzmSwitch;
    }
    if (!"".equals(dev)) {
        f_password=back_password;
        f_username=back_username;
    }
    System.out.println(back_username);
%>
<%
    //如果用户已经登录过了，不再登录，直接跳转到主页面【zjf】
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    if (sysuser != null) {
        request.getSession().setAttribute("systemcode", systemcode);
        request.getRequestDispatcher("/jsp/main.jsp").forward(request, response);
    }
%>
<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var contextPath = '<%=contextPath%>';
    var systemcode = '<%=systemcode%>';
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>
        食药监局综合监管信息平台
    </title>
    <link href="./css/login.css" rel="stylesheet" type="text/css"/>

    <% if ("zhongmou".equals(v_wheresys)){ %>
        <link href="./css/vbooking_v2_zhongmou.css" rel="stylesheet" type="text/css"/>
    <%}else{%>
        <link href="./css/vbooking_v2.css" rel="stylesheet" type="text/css"/>
    <%}%>

    <link rel="stylesheet" href="./css/supersized.css" type="text/css" media="screen"/>


    <script src="<%=contextPath%>/jslib/md5.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="./js/jquery-1.7.2.min.js?releaseno=2016_10_24_1"
            language="javascript"></script>
    <script type="text/javascript" src="./js/supersized.3.2.7.min.js"></script>
    <script type="text/javascript" src="./js/qrcode_client.js" language="javascript"></script>
</head>
<body>
<script type="text/javascript">
    (function (jQuery) {
        jQuery.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    })(jQuery);
    jQuery(document).ready(function () {

            jQuery.supersized({
                // Supersized是一款基于jQuery的图片切换插件,功能特性：1.自动等比例调整图片并填充整个浏览器屏幕;2.循环展示图片，支持滑动和淡入淡出等多种图片切换效果;3.导航按钮，支持键盘方向键导航;
                slide_interval: 60000,//图片切换间隔时间（毫秒）
                transition: 0,//图片切换效果，0-无，1-淡入淡出，2-向上滑动，3-向右滑动，4-向下滑动，5-向左滑动。
                transition_speed: 10000,//切换速度
                performance: 1,

                // 大小和位置
                min_width: 0,
                min_height: 0,
                vertical_center: 1,//是否让图像垂直居中
                horizontal_center: 1,
                fit_always: 0,
                fit_portrait: 0,
                fit_landscape: 0,
                // 组件
                slide_links: 'blank',
                slides: [
                    {image : '<%=v_bgimg1%>'},
                    {image : '<%=v_bgimg2%>'}
                   // {image : './img/bgzm001.jpg'}
                ]
            });

        jQuery(document).keydown(function(event){
            if(event.keyCode==13){
                __doPostBack();
            }
        });
    });
</script>
<form name="form1" method="post" action="#" id="form1">
    <script type="text/javascript">
        //<![CDATA[
        var theForm = document.forms['form1'];
        if (!theForm) {
            theForm = document.form1;
        }
        function __doPostBack() {
            var objErrorLabel = document.getElementById("lblErrorMessage");

            var username = jQuery("#username").val();
            var userpwd = jQuery("#userpwd").val();
            var curtab_index = '1';
            var yzm = jQuery("#yzmId").val();
            var systemcode = jQuery.getUrlParam("systemcode");
            jQuery("#btnLogin").blur();
            if(username.trim()==""){
                objErrorLabel.innerText = "请输入用户名!";
                jQuery("#username").focus();
                return;
            }
            if(userpwd.trim()==""){
                objErrorLabel.innerText = "请输入密码!";
                jQuery("#userpwd").focus();
                return;
            }
            if(yzm.trim()==""){
                objErrorLabel.innerText = "请输入验证码!";
                jQuery("#yzmId").focus();
                return;
            }
            var formData = {
                "username": username,
                "passwd": hex_md5(userpwd),
                "userkind": curtab_index,
                "yzm": yzm,
                "systemcode": systemcode
            };
            jQuery.ajax({
                url: basePath + "/login/verify",
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: formData,
                dataType: 'json',
                error: function () {
                    objErrorLabel.innerText = '服务器繁忙，请稍后再试！';
                    console.log('提示', '服务器繁忙，请稍后再试！');
                },
                success: function (result) {
                    if (result.code == 0) {
                        if(systemcode!=null&&systemcode!=""){
                            window.location.href = basePath + "login/gohome?systemcode="+systemcode;
                        }
                        window.location.href = basePath + "login/gohome";
                    } else {
                        objErrorLabel.innerText = result.msg;
                        console.log('提示', '登录失败！');
                    }
                }
            });

        }
        //]]>
    </script>
    <!--
    class="main"
        class="all"
    -->
    <div>
        <div >

            <div class="box" >
                <div class="logo_bg">

                    <br/>
                    <br/>
                    <br/>
                        <div style="text-align: center">
                            <img src="<%=contextPath+indexImg%>" alt="INDEX_IMG未配置！" style="text-align: center"/>
                </div>

                    <br/>
                    <br/>

                    <p class="login_tab">
                        <a href="javascript:void(0)" class="cur">账号登录</a>
                        <a href="javascript:void(0)" id="lnkUIDLogin"></a>
                    </p>

                    <div class="content_box content_box01 basefix">
                        <div class="content_left">
                            <p>
                                <span>用户名</span>
                                <input name="username" type="text" id="username" tabindex="1" value="<%=f_username%>"/>
                            </p>

                            <p>
                                <span>密　码</span>
                                <input name="userpwd" type="password" id="userpwd" tabindex="2" value="<%=f_password%>"/>
                            </p>

                            <div id="showVfc" name="showVfc" class="code_box basefix">
                                <p class="code">
                                    <span>
                                        <label> 验证码</label>
                                    </span>
                                    <input name="yzmId" type="text" id="yzmId"
                                           tabindex="3" class="vertxt" autocomplete="off"/>
                                </p>
                                <img id="yzmimg" onclick="changeImage(this)" alt="点击刷新验证码" class="code_img"
                                     src="<%=contextPath%>/servlet/CodeServlet" style="border-width:0px;"/>
                            </div>
                            <span id="lblUserInfoUID"></span>
                            <span id="lblErrorMessage" class="user_null"></span>
                            <a onclick="return CheckLogin();" id="btnLogin" class="login"
                               href="javascript:__doPostBack()">登录</a>
                            <a href="<%=basePath%>zhsyj_zm_2.0/mima.html"
                                  class="forget">忘记密码？</a>

                        </div>
                        <div class="content_right">
                            <img src="<%=contextPath%>/img/msyy.jpg" width="100px" height="100px"/>

                            <p class="scan">
                                微信扫一扫
                            </p>

                            <p>
                                关注中牟食药监公众号
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<a class="zs_href_vbk" href="http://116.255.143.56:8090/" target="_blank">--%>
            <%--<img src="<%=contextPath%>/img/zhilian_href.png"/>--%>
        <%--</a>--%>
        <a class="href_vbk" href="http://116.255.143.56:8090/" target="_blank">
            <img src="<%=contextPath%>/img/zhaoshang_href.png"/>
        </a>
    </div>

</form>

<div class="vbk_footer" style="display: none">
    <div class="footer_bg">
        <div class="footer_content">
            <p>
                郑州市高新区西三环99号大学科技园12号楼18层 邮编: 4500000 电话: 0371-65751489 传真: ***-********
            </p>

            <p>
                服务电话: ***-********(免长话费) ***-********
            </p>

            <p>
                Copyright&copy; 2004-2016 hnaskj.com All rights reserverd 版权所有@河南安盛科技股份有限公司
            </p>
        </div>
    </div>
    <div class="footer_last">
        <p>
            为了您更好的使用食品药品监管系统，推荐您下载安装并适用chrome浏览器登录系统。
            <a class="login_other" href="http://www.google.com/chrome/eula.html?hl=zh-CN&amp;standalone=1">点此进入官方下载</a>
        </p>
    </div>
</div>
<div class="appd_wrap_open" style="display: none;" onclick="openAppPanel()">
    <div class="appd_wrap_open_cnt" style="left: -100%;"></div>
</div>
<div class="appd_wrap_pop" style="display: block;" id="appPanel">
    <div class="appd_wrap_pop_cnt" style="left: 0%;">
        <div class="appd_wrap_pop_box">
            <a href="javascript:closeAppPanel();" class="appd_wrap_close" title="关闭">×</a>

            <div class="appd_wrap_pop_pic_phone pic_for_gift_all"></div>
            <div class="appd_wrap_pop_text style_for_gift_all">
                <p class="word_s">
                    食药手机客户端&nbsp;&nbsp;&nbsp;&nbsp;监管执法更方便
                </p>
                <p class="word_s">
                    <br>为了您能更好的使用本系统，推荐您下载安装最新版【火狐浏览器】。
                    <br><a href="http://www.firefox.com.cn/" target="_blank">点此进入官方下载</a>
                </p>
            </div>
            <div class="appd_wrap_pop_cont">
                <div class="appd_wrap_pop_code">
                    <p>
                        扫一扫下载
                    </p>
                    <img src="<%=contextPath+indexAppQRCodeImg%>" alt="INDEX_APP_QRCODE_IMG参数未配置！" width="100px" height="100px">
                </div>
                <div class="appd_wrap_pop_form">
                    <p>
                        点击下载
                    </p>

                    <a class="vbk_and"
                       href="<%=indexClickDownloadUrl%>"
                       target="_blank"></a>
                </div>
            </div>
        </div>
    </div>
</div>
<!---展示的图片列表...---->
<%--<ul id="supersized" class="quality" style="visibility: visible;width: 2048px;height: 1000px"></ul>--%>
<ul id="supersized" class="quality" style="visibility: visible;"></ul>
</body>
</html>

<script type="text/javascript" language="JavaScript">

    function CheckLogin() {
        //登录前非空验证
        var objErrorLabel = document.getElementById("lblErrorMessage");
        var operid = document.getElementById("username").value;
        operid = trim(operid);
        if (operid == null || operid == "") {
            objErrorLabel.innerText = '请输入用户名';
            return false;
        }
        var pwd = document.getElementById("userpwd").value;
        pwd = trim(pwd);
        if (pwd == null || pwd == "") {
            objErrorLabel.innerText = '请输入登录密码';
            return false;
        }

        var yzmId = document.getElementById("yzmId").value;
        yzmId = trim(yzmId);
            if (yzmId == null || yzmId == "") {
                objErrorLabel.innerText = '请输入验证码';
                return false;
            }
        return true;
    }

    function changeImage(obj) {
        //刷新验证码
        obj.src = contextPath + '/servlet/CodeServlet?' + Math.random();
    }

    function trim(str) {
        //FUNCTION:去掉字符串的两边空格,中间的空格保留 
        v = str.replace(/(^\s*)|(\s*$)/g, "");
        return v;
    }

    function closeAppPanel() {
        //手机端下载关闭窗口
        animatePosition(document.getElementById('appPanel'), 'left', 0, -100, 200, function () {
            document.getElementsByClassName('appd_wrap_open')[0].style.display = "block";
            animatePosition(document.getElementsByClassName('appd_wrap_open_cnt')[0], 'left', -100, 0, 20, function () {
            });
        });
    }

    function openAppPanel() {
        //手机端下载打开窗口
        animatePosition(document.getElementsByClassName('appd_wrap_open_cnt')[0], 'left', 0, -100, 20, function () {
            document.getElementsByClassName('appd_wrap_open')[0].style.display = "none";
            animatePosition(document.getElementById('appPanel'), 'left', -100, 0, 200, function () {
            });
        });
    }

    function animatePosition(dom, attrName, begin, target, finishTime, callback) {
        //手机端下载窗口
        var timeInterval = parseInt(finishTime * 1.0 / Math.abs(target - begin));
        var valueInterval = target > begin ? 1 : -1;
        var temp = begin;
        var interval = window.setInterval(function () {
            if ((begin < target && temp >= target) || (begin >= target && temp < target)) {
                window.clearInterval(interval);
                callback();
            }
            dom.style[attrName] = temp + '%';
            temp += valueInterval;
        }, timeInterval);
    }

</script>
