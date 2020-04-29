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
    <title>舌尖安全网</title>
    <jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript" src="../../jslib/myflashflowplayer/mclzplayer2.js"></script>
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
    var layer;
    var cams = [];
    $(function () {
        layui.use('layer', function () {
            layer = layui.layer;
            qy();
            loadCameraPlayer();
            loadCameraList(jkqybh,jklx,camorgid);
            if (jkqybh != '') {
//                loadJkComFzr();
            }
        })

    });

    //获取企业名称,地址,电话,门头照
    function qy() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: basePath + 'pcompany/queryPcompanyDTO',
            data: {'comid': jkqybh},
            success: function (data) {
                var userInfos = data.rows;
                if (userInfos.length > 0) {
                    $('.mclz-top').html(userInfos[0].commc);
                    $('#comdz').html("地址：" + userInfos[0].comdz);
                    $('#comyddh').html("电话：" + userInfos[0].comyddh);
                    $('.mclz-img').html("<img src='" +basePath+ userInfos[0].qymtzpath + "'style='width:250px; height:250px;'/>");
                }
            }
        });
    }
    // 获取监控企业的负责人
    function loadJkComFzr() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: basePath + '/jk/jkgl/queryJkfzrList',
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
    }
//    function sp(j) {
//        alert(0)
//        loadCameraPlayer(cams[j])
//    }
    //获取企业的视频摄像头列表
  /*  function loadCameraList() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: basePath + '/jk/jkgl/getJkyList',
            data: {'jkqybh': jkqybh, 'jklx': jklx, 'camorgid': camorgid},
            success: function (data) {
                if (data.total <= 0) {
                    var html = "";
                    html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                    html += " <tr>";
                    html += "     <td  style=\"font-size:16px;color: red;\">未获取到监控源【监控摄像头不在线或监控服务器出现问题】，请联系系统管理员！</td>";
                    html += " </tr>";
                    html += " <tr>";
                    html += "</table>";
                    $("#mclzPlayer").append(html);
                    $("#mclz").append("");
                }
                cams = data.rows;
                loadCameraPlayer();
//                loadCameraPlayer(cams);
//                loadList(cams);
            }
        });
    }*/
//    function loadList(cams) {
//        for (var j = 0; j < cams.length; j++) {
//            var id = cams[j].ocxId;
//            var camName = cams[j].camName;//gu20180420
//            $("#mclz").append("<div onclick='sp(" + j + ") 'style='height:70px;background-color: #8E8E8E;margin-top:2px;margin-bottom:2px'>" +
//            "<span style='font-size: 25px;color: white'><img src='http://www.shejian360.com/home/images/defaultCamImg.png'>" + camName + "</span></div>");
//        }
//    }

//    function loadCameraPlayer(cams) {
//        for (var i = 0; i < cams.length; i++) {
//            var jkybh = cams[i].ocxId;
//            var v_camName = cams[i].camName;//gu20180420
//            $("#mclzPlayer").append("<div id='p_" + jkybh + "'class='layui-col-md6'style='height: 350px;'></div>");
//            addRtmpPlayNewObj(jkybh);
//        }
//    }
</script>
</head>
<body>
<div>
    <div style="height: 200px;background: url('../../img/many.jpg')">
        <div style="font-size: 50px;"></div>
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
</body>
</html>
