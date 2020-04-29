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
    <title>舌尖安全网</title>
    <jsp:include page="${contextPath}/inc_camera.jsp"></jsp:include>
    <link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/base.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        var jklx = '1';
        var layer;
        var laypage;

        //总条数
        var pageTotal = 0;
        //显示每页的条数
        var displaySize = 12;
        //当前页
        var displayIndex = 1;

        $(function () {
            layui.use(['laypage', 'layer'], function () {
                laypage = layui.laypage;
                layer = layui.layer;
                //初始化数据条数
                reqTOBankend(displayIndex, displaySize);
//                load();
            })
        });
        //请求后台
        function reqTOBankend(pageIndex, pageSize, commc) {
            displaySize = pageSize;
            displayIndex = pageIndex;
            $.post(basePath + '/jk/jkgl/queryJkqy', {
                        page: displayIndex,
                        rows: displaySize,
                        jkqymc: commc,
                        comdalei: '101201',
                        comcameraflag: '1'
                    },
                    function (result) {
                console.info(result);
                        if (result.code == '0') {
                            alert(1);
                            var data = result.rows;
                            var count = result.total;
                            load(count);
                            $(".layui-col-md3").remove(); //移除Id为Result的表格里的行，从第二行开始（这里根据页面布局不同页变）
                            var str = '';
                            for (var i = 0; i < data.length; i++) {
                                var rowData = data[i];
                                var jkqymc = rowData.jkqymc;
                                var jkqybh = rowData.jkqybh;
                                var imgUrl = rowData.filepath;
                                var camorgid = rowData.camorgid;
                                var state = rowData.state;
                                if (imgUrl == null || imgUrl == "" || imgUrl == "null" || typeof (imgUrl) == "undefined") {
                                    imgUrl = "/images/noqyimg.png";
                                }
                                str += "<div class='layui-col-md3' style='height: 200px;margin-top: 20px'>"

                                str += '<li  onclick=showSpjky("' + jkqybh + '","' + camorgid + '") >';
                                str += '<A title="' + jkqymc + '" class="group-pic  "    >';
                                str += '<img class="img"  alt="" src="' + basePath + imgUrl + '">';
                                str += '<div class="shop-txt" style="height:auto;writh:auto;">';
                                str += ' <p class="commc">' + jkqymc
                                + '</p>';

                                if (state == '1') {
                                    str += '<span class="shop_camera"><img class="shop_camera" src="' + basePath + '/images/frame/camera-on.png"></span>';
                                } else {
                                    str += '<span class="shop_camera"><img class="shop_camera" src="' + basePath + '/images/frame/camera-off.png"></span>';
                                }

                                var addr = rowData.comdz;
                                if (addr == null || addr == ""
                                        || typeof (addr) == "undefined") {
                                    addr = "";
                                }
                                str += '<p class="address">地址：' + addr
                                + ' </p>';
                                //str+='<div class="blank-line"></div>';
                                str += '</div></a></li></div>';
                            }
                            $('#Result').append(str);
                        } else {
                            parent.$.messager.alert('提示', '查询失败：'
                            + result.msg, 'error');
                        }
                    }, 'json');
        }

        // 明厨亮灶视频监控
        var showSpjky = function (comid, camorgid) {
                    window.open(basePath + '/jsp/sjaq/sjaqxq.jsp?comid=' + comid + '&jklx=' + jklx + '&camorgid=' + camorgid)
                }
                ;
        // 刷新
        function refresh() {
            parent.window.refresh();
        }

        //初始化分页工具条
        function load(count) {
            //执行一个laypage实例
            laypage.render({
                elem: 'toolBar_0' //注意，这里的 test1 是 ID，不用加 # 号
                , limit: displaySize
                , count: count //数据总数，从服务端得到
                , curr: location.hash.replace('#!fenye=', '') //获取起始页
                , hash: 'fenye' //自定义hash值
                , jump: function (obj, first) {
                    //首次不执行
                    if (!first) {
                        reqTOBankend(obj.curr, obj.limit);
                    }
                }
            });
        }

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
<div>
    <div>
        <div style="height: 200px;background: url('../../img/many.jpg')">
            <div style="font-size: 50px"></div>
        </div>
    </div>
</div>
<div class="search-shop-box group-shop-mode" style="padding-top: 20px;padding-bottom: 20px">
    <div class="pic-list" style="margin-right: 50px;margin-left: 50px ">
        <div class="layui-row layui-col-space30">
            <ul id="Result"></ul>
        </div>
    </div>
</div>
<div style="height: 50px">
    <div id="toolBar_0" style="margin-left: 33%"></div>
</div>

<%--<form id="fm" method="post">--%>
<%--<div id="toolBar_0" style="background:#ebf1ff;border:1px solid #ccc;">--%>
<%--</div>--%>
<%--</form>--%>
<div class="layui-footer">
    <!-- 底部固定区域 -->
    版权所有@<a href="http://www.hnaskj.com" target="_blank">河南安盛科技股份有限公司</a>
</div>
</body>
</html>
