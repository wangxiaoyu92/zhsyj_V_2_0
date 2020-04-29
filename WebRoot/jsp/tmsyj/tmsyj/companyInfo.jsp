<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
    String t_currlocation = "企业二维码>>检验检测信息公示";
    String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>企业基本信息</title>
    <script src="./js/jquery-1.12.0.min.js"></script>
    <script src="./js/common.js"></script>
    <script src="../../../zhsyj_zm_2.0/js/common.js"></script>
    <script src="../../../zhsyj_zm_2.0/js/jquery.jslides.js"></script>
    <style>
        /*初始化*/
        * {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        body {
            font-family: "微软雅黑", Arial, Sans-Serif;
            font-size: 16px;
            max-width: 1024px;
            margin: 0 auto;
        }

        img {
            border: none;
            display: block;
        }

        /*开始*/
        .box {
            width: 100%;
            overflow: hidden;
        }

        .box_img {
            width: 20%;
            overflow: hidden;
            float: left;
        }

        .box img {
            width: 100%;
            margin: 0 auto;
            float: left
        }

        /*企业基本信息*/
        .jbxx {
            width: 100%; /*margin: 10px 0 0 10px;*/
            float: left;
        }

        .jbxx_title {
            font-size: 20px;
            text-align: center;
            line-height: 44px;
            color: white;
            background-color: cornflowerblue;
        }

        .jbxx img {
            width: 100%;
            float: left;
            max-height: 240px;
        }

        .jbxx li {
            border-bottom: solid 1px #ccc;
            overflow: hidden;
            padding: 0 10px;
        }

        .jbxx li p, span {
            float: left;
            line-height: 34px;
        }

        .jbxx li p {
            width: 34%;
            color: #666;
        }

        .jbxx li span {
            width: 58%;
        }

        /*快捡记录*/
        .kjjl {
            width: 100%;
            float: left;
            margin: 16px 0 0 0;
        }

        .kjjl li {
            margin-bottom: 10px;
        }

        .kjjl .kjjl_title {
            font-size: 20px;
            text-align: center;
            line-height: 44px;
            color: white;
            background-color: cornflowerblue;
            margin: 0 0 10px 0;
        }

        .kjjl .kjjl_content {
            border: solid 1px #ccc;
            width: 94%;
            margin: 0 auto;
            border-radius: 2%;
        }

        .kjjl .kjjl_content li {
            padding: 0 10px;
            overflow: hidden;
        }

        .kjjl .kjjl_content li p, span {
            float: left;
            line-height: 34px;
        }

        .kjjl .kjjl_content li p {
            width: 35%;
            color: #666;
        }

        .kjjl .kjjl_content li span {
            width: 58%
        }

        .liebiao td {
            border: 1px solid #D1D1D1;
            line-height: 35px;
            padding: 5px;
        }

        button {
            width: 40px;
            height: 20px;
            font-size: 0.6em
        }

        /*.new-shadow{position:fixed;width:100%;height:100%;background-color:rgba(0,0,0,0.3);left:0;top:0;z-index:10000;display:none;}*/
        /*.shadow-box{padding:0 30px;position:absolute;background-color:#FFFFFF;margin:auto;left:0;top:0;bottom:0;right:0;}*/
        /*.shadow-title{font-size:16px;color:#333333;line-height:58px;border-bottom:1px solid #ebebeb;}*/
        /*.shadow-box img{position:absolute;right:-38px;top:0;}*/
        /*.shadow-box iframe{border:1px solid #00a1ea;width:100%;height:380px;margin-top:20px;}*/
    </style>
</head>
<body>
<div class="box">
    <div class="jbxx_title">
        企业基本信息
    </div>
    <div class="jbxx">
        <ul>
            <li style="padding: 0;">
                <img id="enterpriseIcon" src="images/kong.jpg"/>
            </li>
            <li>
                <p>企业名称：</p>
                <span id="commc"></span>
            </li>
            <li>
                <p>企业法人：</p>
                <span id="comfrhyz"></span>
            </li>
            <li>
                <p>企业地址：</p>
                <span id="comdz"></span>
            </li>
            <li>
                <p>联系电话：</p>
                <span id="comgddh"></span>
            </li>
            <li>
                <p>企业简介：</p>
                <span id="comjianjie"></span>
            </li>
            <li>
                <p>企业资质证明：</p>

                <div style="clear: left">
                    <img id="xkz" src="images/kong.jpg" style="width: 150px;height: 150px;float: left;">
                    <img id="yyzz" src="images/kong.jpg" style="width: 150px;height: 150px;float: right;">
                </div>
            </li>

            <li>
                <p>企业人员：</p>
                <table id="ry_content" class="liebiao"
                       style="border-collapse:collapse;font-size:14px;width: 100%;margin-bottom: 20px">
                </table>
                <div id="ry" class="page_btn" style="width: 100%;text-align:center;clear: left"></div>
            </li>
            <li>
                <p>企业图片：</p>
                <ul id="marqueeDiv"></ul>
                <div id="tp" style="width: 100%;text-align:center;"></div>
            </li>
        </ul>
    </div>

    <div class="kjjl">
        <div class="kjjl_title">原料采购</div>
        <ul>
            <li>
                <p>食用农产品：</p>
                <table id="syncp_content" class="liebiao" style="width:100%;margin-top: 20px;border-collapse:collapse;">
                    <thead style="font-weight:bold;">
                    <tr>
                        <td>名称</td>
                        <td>进货日期</td>
                        <td>进货来源</td>
                        <td>生产日期</td>
                        <td>保质期（天）</td>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div id="syncp" style="width: 100%;text-align:center;"></div>
            </li>
            <li>
                <p>预包装食品：</p>
                <table id="ybzsp_content" class="liebiao" style="width:100%;margin-top: 20px;border-collapse:collapse;">
                    <thead style="font-weight:bold;">
                    <tr>
                        <td>名称</td>
                        <td>进货日期</td>
                        <td>进货来源</td>
                        <td>生产日期</td>
                        <td>保质期（天）</td>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div id="ybzsp" style="width: 100%;text-align:center;"></div>
            </li>
        </ul>
    </div>

    <div class="kjjl">
        <div class="kjjl_title">快检记录</div>
        <ul>
            <li>
                <table id="content" class="liebiao" style="width:100%;margin-top: 20px;border-collapse:collapse;">
                    <thead style="font-weight:bold;">
                    <tr id="t_head">
                        <td>检测食品名称</td>
                        <td>检测项目</td>
                        <td>检测结果</td>
                        <td>检测机构</td>
                        <td>检测人</td>
                        <td>检测时间</td>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </li>
        </ul>
        <div id="kj" style="width: 100%;text-align:center;"></div>
    </div>

    <div class="kjjl">
        <div class="kjjl_title">快检报告</div>
        <ul id="content_bg" style="text-align: center"></ul>
        <div id="bg" style="width: 100%;text-align:center;"></div>
    </div>

    <div class="kjjl">
        <div class="kjjl_title">日常检查</div>
        <ul id="rcjc_content"></ul>
        <div id="rc" style="width: 100%;text-align:center;"></div>
    </div>

    <div class="kjjl">
        <div class="kjjl_title">技术支持：河南安盛科技股份有限公司</div>
    </div>
</div>

<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var contextPath = '<%=contextPath%>';
    var t_comid = '<%=t_comid%>';
    var comdalei = '';
    var pageNum = tpNum = kjNum = bgNum = rcNum = ryNum = ybzspNum = syncpNum = 1;
    var pageSize = 10, pageSum = 0;
    $(function () {
        getPcompany();
        getPcompanyXkzFjList();
        getPcomryList();
        ylcg(syncpNum, 'syncp_content', 'syncp', 1);
        ylcg(ybzspNum, 'ybzsp_content', 'ybzsp', 0);
        kjjl();
        kjbg();
    });

    //    //溯源
    //    function spsycx(trace) {
    //        var url = encodeURI(trace);
    //        //显示
    //        $(".new-shadow").show();
    //        $('.shadow-box iframe').attr('src', url);
    //    }
    //    //隐藏
    //    $(".shadow-box img").click(function () {
    //        $(".new-shadow").hide();
    //
    //    });

    function data(id) {
        if (id === 'tp') {
            qytp();
        } else if (id === 'kj') {
            kjjl();
        } else if (id === 'rc') {
            rcjc(comdalei);
        } else if (id === 'ry') {
            getPcomryList();
        } else if (id === 'syncp') {
            ylcg(syncpNum, 'syncp_content', 'syncp', 1);
        } else if (id === 'ybzsp') {
            ylcg(ybzspNum, 'ybzsp_content', 'ybzsp', 0);
        } else if (id === 'bg') {
            kjbg();
        }
    }

    //企业信息
    function getPcompany() {
        $.ajax({
            url: basePath + "api/tmsyj/getPcompanyList",
            type: "post",
            dataType: 'json',
            data: {comid: t_comid},
            success: function (result) {
                if (result.code == '0') {
                    if (result.total > 0) {
                        var item = result.rows[0];
                        $("#commc").text(item.commc);
                        $("#comfrhyz").text(item.comfrhyz);
                        $("#comdz").text(item.comdz);
                        $("#comgddh").text(item.comgddh);
                        $("#comjianjie").text(item.comjianjie);
                        $("#enterpriseIcon").attr("src", checkImg(item.icon));
                        comdalei = item.comdalei;
                        rcjc(comdalei);
                        qytp();
                    }
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //企业资质证明
    function getPcompanyXkzFjList() {
        $.ajax({
            url: basePath + "/api/tmsyj/getPcompanyXkzFjList",
            type: "post",
            dataType: 'json',
            data: {comid: t_comid, comxkzlx: '1,4'},
            success: function (result) {
                if (result.code == '0') {
                    $.each(result.rows, function (index, item) {
                        var fjpath = checkImg(item.fjpath);
                        if (item.comxkzlx == "1") {
                            $('#yyzz').attr('src', fjpath);
                            $('#yyzz').attr('rel', fjpath);
                        }
                        if (item.comxkzlx == "4") {
                            $('#xkz').attr('src', fjpath);
                            $('#xkz').attr('rel', fjpath);
                        }
                    });
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //企业人员信息
    function getPcomryList() {
        $.ajax({
            url: basePath + "/api/tmsyj/getPcomryList",
            type: "post",
            dataType: 'json',
            data: {page: ryNum, rows: pageSize, comid: t_comid, rysfspaqgly: '', rysfjdgsry: ''},
            success: function (result) {
                if (result.code == '0') {
                    page(pageSize, ryNum, result.total, '#6495ED', 'ry');
                    $('#ry_content').empty();
//                    var html = "<tr style='text-align: center'><td>健康证</td><td>食品安全证</td></tr>";
                    var html = "";
                    $.each(result.rows, function (index, item) {
                        $.ajax({
                            url: basePath + "/api/tmsyj/getFjList",
                            type: "post",
                            dataType: 'json',
                            data: {fjwid: item.ryid, fjtype: '5,6'},
                            success: function (result) {
                                if (result.code == '0') {
                                    html += "<tr><td>姓名：" + item.ryxm + "</td><td>职务：" + item.ryzwgwmc + "</td>";
                                    html += "<td>在职状态： 在职</td></tr>";
                                    html += "<tr><td colspan='3' align='center' valign='middle' style='height:150px;width:120px;padding-left: 15%'>";
                                    $.each(result.rows, function (index, item) {
                                        if (result.total > 1) {
                                            html += "<img src='" + checkImg(item.fjpath) + "' style='height:150px;width:120px;'>";
                                        } else {
                                            if (item.fjtype == 5) {
//                                                html += "<td rowspan='0' align='center' valign='middle' style='height:150px;width:120px;'>";
                                                html += "<img src='" + checkImg(item.fjpath) + "' style='height:150px;width:120px;'>";
//                                                html += "<td rowspan='0' align='center' valign='middle' style='height:150px;width:120px;'>";
                                                html += "<img src='images/kong.jpg' style='height:150px;width:120px;'>";
                                            } else if (item.fjtype == 6) {
//                                                html += "<td rowspan='0' align='center' valign='middle' style='height:150px;width:120px;'>";
                                                html += "<img src='images/kong.jpg' style='height:150px;width:120px;'>";
//                                                html += "<td rowspan='0' align='center' valign='middle' style='height:150px;width:120px;'>";
                                                html += "<img src='" + checkImg(item.fjpath) + "' style='height:150px;width:120px;'>";
                                            }
                                        }
                                    });
                                    html += "</tr>"
                                } else {
                                    alert(result.msg);
                                }
                                $('#ry_content').append(html);
                                html = '<tr>'
                            }
                        });
                    });

                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //获取企业展示图片\附件
    function qytp() {
        $.ajax({
            url: basePath + "/api/tmsyj/getFjList",
            type: "post",
            dataType: 'json',
            data: {page: tpNum, rows: pageSize, fjwid: t_comid, fjtype: '1'},
            success: function (result) {
                if (result.code == '0') {
                    page(pageSize, tpNum, result.total, '#6495ED', 'tp');
                    $('#marqueeDiv').empty();
                    if (result.rows.length > 0) {
                        var html = "<div style='clear: left'></div>";
                        $.each(result.rows, function (index, item) {
                            html += "<li style='float:left;margin: 5px 0px 5px 10px;padding: 0px'><img src='" + checkImg(item.fjpath) + "'style='width: 100px;height: 100px;'></li>";
                        });
                        html += "<div style='clear: left'></div>";
                        $('#marqueeDiv').append(html);
                    } else {
                        $('#marqueeDiv').append("无");
                    }
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //原料采购
    function ylcg(num, id, pageid, jcypgl) {
        $.ajax({
            url: basePath + "/api/tmsyj/getYlcgtmList_zm",
            type: "post",
            dataType: 'json',
            data: {page: num, pageSize: pageSize, hviewjgztid: t_comid, jcypgl: jcypgl},
            success: function (result) {
                if (result.code == '0') {
                    $('#' + id + ' tbody').empty();
                    page(pageSize, num, result.total * pageSize, '#6495ED', pageid);
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;width: 100%;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;width: 100%;\">";
                        }
                        html += "<td style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">" + IsNull(item.jcypmc) + "</td>";
                        html += "<td>" + IsNull(item.jcypsspp) + "</td>";
                        html += "<td>" + IsNull(item.jhgysmc) + "</td>";
                        html += "<td>" + IsNull(item.jhscrq).split(" ")[0] + "</td>";
                        html += "<td>" + IsNull(item.spbzq) + "</td>";
                        html += "</tr>";
                        $('#' + id + ' tbody').append(html);
                    });
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //快检记录
    function kjjl() {
        $.ajax({
            url: basePath + "/api/tmsyj/getJyjcjgList",
            type: "post",
            dataType: 'json',
            data: {page: kjNum, rows: pageSize, comid: t_comid},
            success: function (result) {
                if (result.code == '0') {
                    page(pageSize, kjNum, result.total, '#6495ED', 'kj');
                    $('#content tbody').empty();
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        html += "<tr>";
                        html += "<td>" + IsNull(item.jcypmc) + "</td>";
                        html += "<td>" + IsNull(item.jcxmmc) + "</td>";
                        html += "<td>" + IsNull(item.jyjcjlmc) + "</td>";
                        html += "<td>" + IsNull(item.jcorgmc) + "</td>";
                        html += "<td>" + IsNull(item.jcrymc) + "</td>";
                        html += "<td>" + IsNull(item.jyjcrq).split(" ")[0] + "</td>";
                        html += "</tr>";
                        $('#content tbody').append(html);
                    });
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //快检报告
    function kjbg() {
        $.ajax({
            url: pathname + "/api/tmsyj/getJcbgList",
            type: "post",
            dataType: 'json',
            data: {page: bgNum, rows: pageSize, hviewjgztid: t_comid},
            success: function (result) {
                if (result.code == '0') {
                    page(pageSize, bgNum, result.total, '#6495ED', 'bg');
                    $('#content_bg').empty();
                    $.each(result.rows, function (index, item) {
                        var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<li style=\"height:auto;width: 100%;\">";
                        } else {
                            html += "<li style=\"height:auto;width: 100%;\">";
                        }
                        html += "<img src=\"" + checkImg(item.fjpath) + "\" style=\"height:500px;width:365px;\" />";
                        html += "</li>";
                        $('#content_bg').append(html);
                    });
                    if (result.total <= 0) {
                        var html = "";
                        html += "<li style=\"border-bottom:1px #00a0ea solid;height:auto;width: 100%\">";
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += "     <td rowspan=\"5\" width=\"140px\" style=\"padding-right:15px;\">";
                        html += "         <img src=\"images/kong.jpg\" style=\"height:120px;width:160px;\" />";
                        html += "     </td>";
                        html += "     <td  style=\"font-size:14px;\">没有查询到符合条件的记录，如有疑问请联系系统管理员！</td>";
                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#content_bg').append(html);
                    }
                } else {
                    alert(result.msg);
                }
            }
        });
    }

    //日常检查
    function rcjc(comdalei) {
        $.ajax({
            url: basePath + "/api/tmsyj/getJdjcResultList",
            type: "post",
            dataType: 'json',
            data: {page: rcNum, rows: pageSize, comid: t_comid},
            success: function (result) {
                if (result.code == '0') {
                    $('#rcjc_content').empty();
                    page(pageSize, rcNum, result.total, '#6495ED', 'rc');
                    if (result.total > 0) {
                        $.each(result.rows, function (index, item) {
                            var html = "";
                            if (index != result.rows.length - 1) {
                                html += "<li style=\"border-bottom:1px #999 dotted;width: 100%;\">";
                            } else {
                                html += "<li style=\"border-bottom:1px #00a0ea solid;width: 100%;\">";
                            }
                            html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                            html += " <tr>";
                            html += "   <td><a href=\"javascript:linkToBack('api/tmsyj/getJdjcResultDetail?comid=" + IsNull(item.comid) + "&commc=" + IsNull(item.commc) + "&resultid=" + IsNull(item.resultid) + "'," + comdalei + ");\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">检查计划：" + IsNull(item.plantitle) + "</a></td>";
                            html += " </tr>";
                            html += " <tr>";
                            html += "   <td  style=\"font-size:14px;\">检查人员：" + IsNull(item.operateperson) + "</td>";
                            html += " </tr>";
                            html += " <tr>";
                            html += "   <td  style=\"font-size:14px;\">检查日期：" + IsNull(item.resultdate) + "</td>";
                            html += " </tr>";
                            html += " <tr>";
                            html += "   <td  style=\"font-size:14px;\">检查结果编号：" + IsNull(item.resultid) + "</td>";
                            html += " </tr>";
                            html += " <tr>";
                            html += "   <td><a href=\"javascript:linkToSelf('fujianchakan.html?comid=" + IsNull(item.comid) + "&commc=" + IsNull(item.commc) + "&resultid=" + IsNull(item.resultid) + "&plantitle=" + IsNull(item.plantitle) + "&operateperson=" + IsNull(item.operateperson) + "&resultdate=" + IsNull(item.resultdate) + "'," + comdalei + ");\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">查看附件</a></td>";
                            html += " </tr>";
                            html += "</table>";
                            html += "</li>";
                            $('#rcjc_content').append(html);
                        });
                    } else {
                        var html = "";
                        html += "<li style=\"border-bottom:1px #00a0ea solid;height:auto;width: 100%\">";
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += "     <td rowspan=\"5\" width=\"140px\" style=\"padding-right:15px;\">";
                        html += "         <img src=\"images/kong.jpg\" style=\"height:120px;width:160px;\" />";
                        html += "     </td>";
                        html += "     <td  style=\"font-size:14px;\">没有查询到符合条件的记录，如有疑问请联系系统管理员！</td>";
                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#rcjc_content').append(html);

                    }
                } else {
                    alert(result.msg);
                }
            }
        });
    }
    /**
     *  显示翻页按钮
     * @param size   每页个数
     * @param num   当前页
     * @param sum   总个数
     * @param color   按钮颜色
     */
    function page(size, num, sum, color, id) {
//        alert(id)
        var ht = "";
        var Totalpage;
        //获取总页码
        Totalpage = Math.ceil(sum / size);
        if (Totalpage > 1) {
            var i = 1;
            var j = 1;
            //大于三页后,只显示当前页的前两页,依次向后滚动,每次显示五个
            if (num > 3) {
                i = num - 2;
            }
            if (Totalpage > 4) {
                var sa = parseInt(num) + 2;
                //页码全部展示出来后,页码不再向前滚动
                if (sa > Totalpage) {
                    i = Totalpage - 4;
                }
            }
            //数字页码排版会会错位,转换为汉字页码
            var str1 = "零一二三四五六七八九";
            var str2 = "十百千";

            ht += "<button value='上一页' class='" + id + "'>上一页</button>";
            for (i; i <= Totalpage; i++) {
                if (j < 6) {//只展示5五个按钮
                    j++;
                    var s = i + '';
                    var ss = '';
                    for (var x = 0; x < s.length; x++) {//页码转化为字符串
                        var z = parseInt(x + 1);
                        //判断当前位是否是0
                        if (str1[s[x]] != "零") {
                            if (str1[s[x]] === "一" && x == 0 && s.length == 2) {
                                if (s.length > 1) {
                                    if (x < s.length - 1) {
                                        ss += str2[s.length - 2 - x];
                                    }
                                }
                            } else {
                                ss += str1[s[x]];
                                if (s.length > 1) {
                                    if (x < s.length - 1) {
                                        ss += str2[s.length - 2 - x];
                                    }
                                }
                            }
                            //如果0是最后一位,则不显示0
                        } else if (z == s.length) {
                            break;
                            //如果不是最后一位,且最后一位不是0,则显示0,不显示单位
                        } else if (str1[s[z]] != "零") {
                            ss += str1[s[x]];
                        }

                    }
                    if (i == num) {
                        ht += "<button  class='" + id + "' style='background-color:" + color + "; color:#FFFFFF' value='" + i + "'>" + ss + "</button>";
                    } else {
                        ht += "<button  class='" + id + "' value='" + i + "'>" + ss + "</button>";
                    }
                }
            }
            ht += "<button value='下一页'  class='" + id + "'>下一页</button>"
        }
        //分页显示位置
        $('#' + id).html(ht);
        //按钮点击事件
        $('#' + id + ' button').click(function () {
//            alert('id='+id);
//            alert('tpNum='+tpNum+'kjNum='+kjNum+'rcNum='+rcNum);
            var text = $(this).val();
            var cla = $(this).attr('class');
            if (cla === 'tp') {
                if ('上一页' == text) {
                    if (tpNum != 1) {
                        --tpNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (tpNum != Totalpage) {
                        ++tpNum;
                        data(cla);
                    }
                } else {
                    tpNum = text;
                    data(cla);
                }
                return false;
            } else if (cla === 'kj') {
                if ('上一页' == text) {
                    if (kjNum != 1) {
                        --kjNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (kjNum != Totalpage) {
                        ++kjNum;
                        data(cla);
                    }
                } else {
                    kjNum = text;
                    data(cla);
                }
                return false;
            } else if (cla === 'rc') {
                if ('上一页' == text) {
                    if (rcNum != 1) {
                        --rcNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (rcNum != Totalpage) {
                        ++rcNum;
                        data(cla);
                    }
                } else {
                    rcNum = text;
                    data(cla);
                }
                return false;
            } else if (cla === 'ry') {
                if ('上一页' == text) {
                    if (ryNum != 1) {
                        --ryNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (ryNum != Totalpage) {
                        ++ryNum;
                        data(cla);
                    }
                } else {
                    ryNum = text;
                    data(cla);
                }
                return false;
            } else if (cla === 'syncp') {
                if ('上一页' == text) {
                    if (syncpNum != 1) {
                        --syncpNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (syncpNum != Totalpage) {
                        ++syncpNum;
                        data(cla);
                    }
                } else {
                    syncpNum = text;
                    data(cla);
                }
                return false;
            } else if (cla === 'ybzsp') {
                if ('上一页' == text) {
                    if (ybzspNum != 1) {
                        --ybzspNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (ybzspNum != Totalpage) {
                        ++ybzspNum;
                        data(cla);
                    }
                } else {
                    ybzspNum = text;
                    data(cla);
                }
                return false;
            }else if (cla === 'bg') {
                if ('上一页' == text) {
                    if (bgNum != 1) {
                        --bgNum;
                        data(cla);
                    }
                } else if ('下一页' == text) {
                    if (bgNum != Totalpage) {
                        ++bgNum;
                        data(cla);
                    }
                } else {
                    bgNum = text;
                    data(cla);
                }
                return false;
            }
        })
    }
</script>
</body>
</html>