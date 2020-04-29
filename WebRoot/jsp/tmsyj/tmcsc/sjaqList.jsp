<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="java.util.*" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>学校食堂</title>
    <jsp:include page="${contextPath}/inc_camera.jsp"></jsp:include>
    <link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/style.css" rel="stylesheet">
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <script src="./js/business.js"></script>
    <script src="./js/bootstrap-paginator.js"></script>
    <link href="./css/style.css" rel="stylesheet">


    <script type="text/javascript">
        var jklx = '1';
        //显示每页的条数
        var displaySize = 12;
        //当前页
        var displayIndex = 1;

        $(function () {
            //初始化数据条数
            reqTOBankend(displayIndex, displaySize);
        });

        var options = {
            currentPage: displayIndex,
            totalPages: 1,
            bootstrapMajorVersion: 3,
            numberOfPages: 5,
            size: "large",
            itemTexts: function (type, page, current) {
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "尾页";
                    case "page":
                        return page;
                }
            },
            tooltipTitles: function (type, page, current) {
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "尾页";
                    case "page":
                        return page + "页";
                }
            }, onPageClicked: function (e, originalEvent, type, page) {
                $('#Result').html('');
                reqTOBankend(page, displaySize);
            }
        }

        //请求后台
        function reqTOBankend(pageIndex, pageSize, commc) {
            displaySize = pageSize;
            displayIndex = pageIndex;
            $.post(basePath + 'api/tmsyj/queryJkqy', {
                        page: displayIndex,
                        rows: displaySize,
                        jkqymc: commc,
                        comdalei: '101201',
                        comcameraflag: '1'
                        ,async: false
                    },
                    function (result) {
                        if (result.code == '0') {
                            options.currentPage = result.currPage;
                            options.totalPages = result.totalPage
                            var data = result.rows;
                            $(".layui-col-md3").remove(); //移除Id为Result的表格里的行，从第二行开始（这里根据页面布局不同页变）
                            var str = '';
                            for (var i = 0; i < data.length; i++) {
                                var rowData = data[i];
                                var jkqymc = rowData.jkqymc;
                                var jkqybh = rowData.jkqybh;
                                var imgUrl = rowData.filepath;
                                var camorgid = rowData.camorgid;
                                var state = rowData.comspjkbz;
                                if (imgUrl == null || imgUrl == "" || imgUrl == "null" || typeof (imgUrl) == "undefined") {
                                    imgUrl = "/images/noqyimg.png";
                                }
                                str += "<div class='col-xs-3 col-sm-3' style='height: 250px;margin-top: 20px'>"

                                str += '<li  onclick=showSpjky("' + jkqybh + '","' + camorgid + '") >';
                                str += '<A title="' + jkqymc + '" class="group-pic  ">';
                                str += '<img class="img"  alt="" src="' + basePath + imgUrl + '">';
                                str += '<div style="height:auto;writh:auto;">';
                                str += ' <p style="font-weight: 600;color: #000000;font-size: 1.2em">' + jkqymc
                                + '</p>';

                                if (state == '1') {
                                    str += '<p class="shop_camera" ><img class="shop_camera" src="' + basePath + '/images/frame/camera-on.png"></p>';
                                } else {
                                    str += '<p class="shop_camera" ><img class="shop_camera" src="' + basePath + '/images/frame/camera-off.png"></p>';
                                }

                                var addr = rowData.comdz;
                                if (addr == null || addr == ""
                                        || typeof (addr) == "undefined") {
                                    addr = "";
                                }
                                str += '<p style="font-size: 1em;">地址：' + addr
                                + ' </p>';
                                //str+='<div class="blank-line"></div>';
                                str += '</div></a></li></div>';
                            }
                            $('#Result').append(str);
                            $('#page_list').bootstrapPaginator(options);

                        } else {
                            alert('查询失败：'
                            + result.msg);
                        }
                    }, 'json');
        }

        // 明厨亮灶视频监控
        var showSpjky = function (comid, camorgid) {
                    window.open(basePath + '/jsp/tmsyj/tmcsc/sjaqxq.jsp?comid=' + comid + '&jklx=' + jklx + '&camorgid=' + camorgid)
                }
                ;
        //        // 查询
        //        function queryjkqy() {
        //            var commc = $("#commc").val();
        //            if (commc == null || commc == '' || commc == "") {
        //                $.messager.alert('提示', '请填写查询的企业名称', 'info');
        //                return;
        //            }
        //            var param = {
        //                'commc': commc
        //            };
        //            reqTOBankend(displayIndex, displaySize, commc);
        //            load();
        //        }
    </script>
</head>
<script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/common.js"></script>
<style type="text/css">
    .search-shop-box .pic-list {

    }

    .search-shop-box .pic-list ul li {
        width: 200px;
        height: auto;
        padding-left: 10px;
        padding-bottom: 10px;
        padding-top: 10px
    }

    .img {
        width: 200px;
        height: 128px;
    }

    .group-shop-mode .pic-list li .shop-txt {
        padding: 10px 5px 10px 5px;
        height: 154px;
        overflow: hidden;
        cursor: pointer;
        -ms-zoom: 1;
    }

    .group-shop-mode .pic-list li .group-pic:hover .shop-txt {
        padding: 10px 5px 10px 5px;
        border-color: red;
    }

    .pic-list li .shop-txt {
        background-color: rgb(255, 255, 255);
    }

    .search-shop-box .pic-list .shop-txt .commc {
        width: 200px;
        height: 20px;
        margin-bottom: 16px;
        font-size: 14px;
        color: black;
    }

    .search-shop-box .pic-list .shop-txt .address {
        width: 200px;
        height: 50px;
        color: rgb(153, 153, 153);
    }

    .blank-line {
        background-color: #d8d8d8;
        width: 160px;
        height: 1px;
        float: left;
    }

    .group-shop-mode .pic-list li .group-pic:hover .shop-txt .commc {
        /*padding: 13px 5px 9px;*/
        color: #148f2d;
    }
</style>

<body>
<div class="search-shop-box group-shop-mode" style="padding-top: 0px;padding-bottom: 0px">
    <div id="head" style="margin-top:10px;">
        <div class="top">
            <div class="logo">
                <a href="#"><img alt="智慧食药监logo" src="<%=contextPath %>/jsp/tmsyj/tmcy/images/logo-tmcy.png" title="智慧食药监logo" > </a>
            </div>
        </div>
    </div>
    <div id="nav" style="margin-top: 20px">
        <ul>
            <li><a href="javascript:linkToSelf(basePath + 'index_zhsyj_zm.jsp');">网站首页</a></li>
        </ul>
    </div>
</div>
<div class="search-shop-box group-shop-mode" style="padding-top: 10px;padding-bottom: 10px">
    <div class="pic-list" style="margin-right: 10px;margin-left: 60px">
        <div class="col-xs-12 col-sm-12">
            <ul id="Result"></ul>
        </div>
    </div>
</div>
<div style="width:96%;margin-left:15px;text-align:center;">
    <ul id="page_list" style="padding-top: 20px"></ul>
</div>

<div id="foot"></div>
</body>
</html>
