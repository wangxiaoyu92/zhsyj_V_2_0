<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<%
    String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
    String jklx = StringHelper.showNull2Empty(request.getParameter("jklx"));
    String camorgid = StringHelper.showNull2Empty(request.getParameter("camorgid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>食堂监控详情</title>
    <link href="<%=contextPath %>/jsp/tmsyj/tmsyj/css/style.css" rel="stylesheet">
    <jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
    <script src="<%=contextPath %>/jsp/tmsyj/tmsyj/js/common.js"></script>
    <script src="./js/business.js"></script>
</head>
<style>
    html, body {
        font-family: "微软雅黑";
        margin: 0px;
    }
</style>
<script type="text/javascript">
    var basePath = '<%=basePath%>';
    //企业id
    var jkqybh = '<%=comid%>';
    var jklx = '<%=jklx%>';
    var camorgid = '<%=camorgid%>';
    var cams = [];
    $(function () {
            qy();
            loadCameraPlayer();
            loadCameraList(jkqybh,jklx,camorgid);
        })


    //获取企业名称,地址,电话,门头照
    function qy() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: basePath + '/api/tmsyj/getPcompanyList',
            data: {'comid': jkqybh,userid:6},
            success: function (data) {
                var userInfos = data.rows;
                if (userInfos.length > 0) {
                    $('.mclz-top').html(userInfos[0].commc);
                    $('#comdz').html("地址：" + userInfos[0].comdz);
                    $('#comyddh').html("电话：" + userInfos[0].comyddh);
                    $('.mclz-img').html("<img src='" +basePath+ userInfos[0].icon + "'style='width:250px; height:250px;'/>");
                }
            }
        });
    }
    // 获取监控企业的负责人
/*    function loadJkComFzr() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: basePath + '/api/tmsyj/queryJkfzrList',
            data: {'comid': jkqybh},
            success: function (data) {
                var userInfos = data.rows;
                if (userInfos.length > 0) {
                    for (var i = 0; i < userInfos.length; i++) {
                        if (userInfos[i].username != null && userInfos[i].username != '') {
                            $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].username + "</span>");
                        }
                        if (userInfos[i].mobile2 != null && userInfos[i].mobile2 != '') {
                            $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].mobile2 + "</span>");
                        }
                    }
                }
            }
        });
    }*/
</script>
</head>
<body>
<div class="search-shop-box group-shop-mode" style="padding-top: 0px;padding-bottom: 0px">
    <div id="head" style="margin-top:10px;">
        <div class="top">
            <div class="logo">
                <a href="#"><img alt="智慧食药监logo" src="<%=contextPath %>/jsp/tmsyj/tmcy/images/logo-tmcy.png" title="智慧食药监logo" > </a>
            </div>
        </div>
    </div>
    <div id="nav" class="layout" style="margin-top: 20px">
        <ul>
            <li><a href="javascript:linkToSelf(basePath + 'index_zhsyj_zm.jsp');">网站首页</a>

                <div></div>
            </li>
        </ul>
    </div>
</div>
<div class="search-shop-box group-shop-mode" style="padding-top: 20px;padding-bottom: 20px">
    <div class="pic-list" style="margin-right: 50px;margin-left: 50px ">
        <div class="layui-row layui-col-space30">
            <ul id="Result"></ul>
        </div>
    </div>
</div>
<div class="mclz-list">
    <div class="mclz-top"></div>
    <div class="mclz-name">简介</div>
    <div>
        <div class="mclz-img"></div>
        <div class="text-sum">
            <p class="simpletextBold"></p>

            <p class="textBold" id="comdz"></p>

            <p class="textBold" id="comyddh"></p>
        </div>
    </div>
    <div class="blank5"></div>
    <div class="mclzPlayer"></div>


</div>
<div id="foot"></div>
</body>
</html>
