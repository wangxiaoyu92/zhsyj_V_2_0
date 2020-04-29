﻿<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%--    <meta http-equiv="Content-Type" content="text/jsp; charset=utf-8"/>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9,IE=10">
    <title>智慧食药监-公众服务平台</title>
    <link rel="stylesheet" type="text/css" href="zhsyj_zm_2.0/css/style.css"/>
    <script type="text/javascript" src="zhsyj_zm_2.0/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="zhsyj_zm_2.0/js/jquery.jslides.js"></script>


</head>

<body>
<!------------header------------->
<div id="top"></div>

<!------------slider------------->
<div id="full-screen-slider">
    <ul id="slides">
        <li style="background:url('zhsyj_zm_2.0/images/banner01.jpg') no-repeat center top"></li>
        <%--<li style="background:url('zhsyj_zm_2.0/images/banner02.jpg') no-repeat center top"></li>--%>
        <li style="background:url('zhsyj_zm_2.0/images/banner03.jpg') no-repeat center top"></li>
    </ul>
</div>

<!------------search------------->
<div class="search">
    <div class="search_con">
        <div class="sousuosi fl">
            <p>最近热门搜索词：<br/><a >姚家镇小学食堂</a> <a >幼儿园食堂</a> <a >兰州拉面</a> <a>家家乐超市</a></p>
        </div>
        <div class="suosuokuang fl">
            <input type="text" id="t_commc1">
            <a class="search_btn" onclick="query()">查&nbsp;询</a>
        </div>
        <div class="search_link fr">
            <a href="javascript:linkToSelf('ditu.html','101401')">菜市场地图</a>
            <a href="javascript:linkToSelf('ditu.html','101101')">生产企业地图</a>
            <a href="javascript:linkToSelf('ditu.html','101302')">流通销售企业地图</a>
            <a href="javascript:linkToSelf('ditu.html','101202')">美食地图</a>
        </div>
    </div>
</div>

<!-------------about-------------------->
<div class="about">
    <div class="abouttit">
        <p>平台简介</p>
    </div>
    <div class="aboutcon">
        <div class="about_img fl"><img src="zhsyj_zm_2.0/images/about.jpg" width="1056" height="439" class=""/></div>
        <div class="abouttxt fr">
            <p class="title">中牟 · 智慧食药监督-公众服务平台</p>
            中牟县食品药品监督管理局2018年推出的公众服务平台。深化风险分级 监管，以风险分级监管为抓手，根据食品药品企业或单位的产品情况、 质量安全管控情况和信用情况等风险要素进行定期评估，按照风险高低
            评定等级，实施分级监管。为建设美好中牟创造更加安全、绿色、透明 的食品安全环境。
            <p class="p1">时时数据更新<br/>多项绿色数据中心技术创新，快速获取企业信息</p>

            <p class="p2">高效稳定的查询服务多年集群管理和系统优化技术，<br/>提供极致稳定的查询能力</p>

            <p class="p3">可靠安全的存储服务<br/>多级数据存储解决方案，保障数据存储安全无忧</p>
        </div>
        <div class="clear"></div>
    </div>
</div>

<!----------xiangmu------------->
<div class="xiangmu">
    <div class="xiangmucon">
        <div class="xiangmutit">
            <p>快速查找</p>
        </div>
        <div class="xiangmulist">
            <ul>
                <li>
                    <img src="zhsyj_zm_2.0/images/xiangmu01.jpg" width="240" height="380"/>

                    <div class="top-box">
                        <a href="javascript:linkToSelf('shitang.html?title=学校食堂','101201')" target="_blank">

                            <p><img src="zhsyj_zm_2.0/images/xiangmupic01.png" width="78" height="78"/><span>学校食堂</span></p>
                        </a>

                        <div class="down-box">
                            <div class="my-box">
                                <a class="hide" href="javascript:linkToSelf('shitang.html?title=学校食堂','101201')">学校食堂</a>

                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="zhsyj_zm_2.0/images/xiangmu02.jpg" width="240" height="380"/>

                    <div class="top-box">
                        <a href="javascript:linkToSelf('caishichang.html?','101401')" target="_blank">

                            <p><img src="zhsyj_zm_2.0/images/xiangmupic02.png" width="78" height="78"/><span>放心菜市场</span></p>
                        </a>

                        <div class="down-box">
                            <div class="my-box">
                                <a href="javascript:linkToSelf('caishichang.html?','101401')">农贸市场</a>
                                <a href="javascript:linkToSelf('ditu.html','101401')">菜市场地图</a>
                                <%--<a href="javascript:linkToSelf('caishichang.html?','101401')">超市</a>--%>
                            </div>
                        </div>
                    </div>

                </li>
                <li>
                    <img src="zhsyj_zm_2.0/images/xiangmu03.jpg" width="240" height="380"/>

                    <div class="top-box">
                        <a href="javascript:linkToSelf('shengchan.html','101101')" target="_blank">

                            <p><img src="zhsyj_zm_2.0/images/xiangmupic03.png" width="78" height="78"/><span>透明生产</span></p>
                        </a>

                        <div class="down-box">
                            <div class="my-box">
                                <a href="javascript:linkToSelf('shengchan.html','101101')">生产企业</a>
                                <a href="javascript:linkToSelf('ditu.html','101101')">生产企业地图</a>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="zhsyj_zm_2.0/images/xiangmu04.jpg" width="240" height="380"/>

                    <div class="top-box">
                        <a href="javascript:linkToSelf('liutong.html','101302')" target="_blank">

                            <p><img src="zhsyj_zm_2.0/images/xiangmupic04.png" width="78" height="78"/><span>流通销售</span></p>
                        </a>

                        <div class="down-box">
                            <div class="my-box">
                                <a href="javascript:linkToSelf('liutong.html','101301')">食品批发企业</a>
                                <a href="javascript:linkToSelf('liutong.html','101302')">食品零售企业</a>
                                <a href="javascript:linkToSelf('ditu.html','101302')"> 企业地图</a>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="zhsyj_zm_2.0/images/xiangmu05.jpg" width="240" height="380"/>

                    <div class="top-box">
                        <a href="javascript:linkToSelf('canyin.html','101202')" target="_blank">

                            <p><img src="zhsyj_zm_2.0/images/xiangmupic05.png" width="78" height="78"/><span>透明餐饮</span></p>
                        </a>

                        <div class="down-box">
                            <div class="my-box">
                                <a href="javascript:linkToSelf('canyin.html','101202')">社会餐饮</a>
                                <a href="javascript:linkToSelf('canyin.html','101201')">学校食堂</a>
                                <a href="javascript:linkToSelf('canyin.html','101205')">网络餐饮</a>
                                <a href="javascript:linkToSelf('ditu.html','101202')">美食地图</a>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </li>
            </ul>
        </div>
    </div>
</div>

<div id="foot"></div>
<script type="text/javascript">

    $("#top").load("zhsyj_zm_2.0/muban_top.html");
    $("#foot").load("zhsyj_zm_2.0/muban_foot.html");
    function query() {
        var url = "http://"+homeURL+"/zhsyj_zm_2.0/query.html?commc=" + $("#t_commc1").val() + "&comdalei=";
        window.open(encodeURI(url));
    }
    $(".top-box").hover(function () {
        $(this).stop().animate({top: -380}, 1000)
    }, function () {
        $(this).stop().animate({top: 0}, 1000)
    })
</script>
</body>

</html>