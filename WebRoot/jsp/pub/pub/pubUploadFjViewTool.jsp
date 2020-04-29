<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";

    String img_src = (null == request.getParameter("img_src") ? "" : request.getParameter("img_src").toString());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base target="_self"/>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>附件详情</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
    <script type='text/javascript'>
        //测试兼容ie6,firefox3.6,chrome 10.0.648.133
        var size = 0;
        var img_src = "<%=img_src%>";
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            //img_src=$("#Imgbox").attr("src");
            $('#imageView_container').imageView({width: 800, height: 500});
        });

        //放大缩小图片
        function imgToSize(size) {
            var img = $("#Imgbox");
            var oWidth = img.width(); //取得图片的实际宽度
            var oHeight = img.height(); //取得图片的实际高度
            img.width(oWidth + size);
            img.height(oHeight + size / oWidth * oHeight);
        }

        // 翻转图片
        function imgReverse(arg) {
            var img = $("#Imgbox");
            if (arg == 'h') {
                img.css({
                    'filter': 'fliph',
                    '-moz-transform': 'matrix(-1, 0, 0, 1, 0, 0)',
                    '-webkit-transform': 'matrix(-1, 0, 0, 1, 0, 0)'
                });
            } else {
                img.css({
                    'filter': 'flipv',
                    '-moz-transform': 'matrix(1, 0, 0, -1, 0, 0)',
                    '-webkit-transform': 'matrix(1, 0, 0, -1, 0, 0)'
                });
            }
        }

        //原始尺寸
        function fullSize() {
            //获取一张图片
            var screenImage = $("#Imgbox");
            //创建一个新图片
            var newImage = new Image();
            //改变新图片的SRC
            newImage.src = img_src;// screenImage.attr("src");
            //获取真实的尺寸
            var imageWidth = newImage.width;
            var imageHeight = newImage.height;
            //按原始尺寸，设置老图片的大小
            $("#Imgbox").css("width", imageWidth);  //宽度
            $("#Imgbox").css("height", imageHeight);  //高度
        }
        //合适尺寸
        function defaultSize() {
            //获取一张图片
            var screenImage = $("#Imgbox");
            //创建一个新图片
            var newImage = new Image();
            //改变新图片的SRC
            newImage.src = img_src;// screenImage.attr("src");
            //获取真实的尺寸
            var imageWidth = newImage.width;
            var imageHeight = newImage.height;
            //按原始尺寸，设置老图片的大小
            $("#Imgbox").css("width", imageWidth * 0.8);  //宽度
            $("#Imgbox").css("height", imageHeight * 0.8);  //高度
        }
    </script>
</head>
<body style="margin:0 auto;padding:0;text-align:center;">
<div id="imageView_container"
     style="margin:0 auto;width:800px;height:600px;overflow:auto; border:1px solid #000000;padding:10px;text-align:center;">
    <img id="Imgbox" src="<%=img_src %>" rel="<%=img_src %>"
         style="width:100%;height:100%;position:relative; zoom:100%;cursor:move;"/>
</div>
<br/>

<div>
    <button class="layui-btn layui-btn-sm" onclick="imgToSize(80);">放大+</button>
    <button class="layui-btn layui-btn-sm" onclick="imgToSize(-80);">缩小-</button>
    <button class="layui-btn layui-btn-sm" onclick="$('#Imgbox').rotateLeft(90);">向左旋转</button>
    <button class="layui-btn layui-btn-sm" onclick="$('#Imgbox').rotateRight(90);">向右旋转</button>
    <button class="layui-btn layui-btn-sm" onclick="defaultSize();">合适尺寸80%</button>
    <button class="layui-btn layui-btn-sm" onclick="fullSize();">原始尺寸</button>
</div>
<!--
<input type="button" value="+放大" onclick="imgToSize(50)" >
     <input type="button" value="-缩小" onclick="imgToSize(-50);">
         <input type="button" onclick="$('#Imgbox').rotateLeft(90);" value="向左旋转" />
         <input type="button" onclick="$('#Imgbox').rotateRight(90)" value="向右旋转" >
    <input type="button" value="原始尺寸" onclick="fullSize();">
<input type="button" value="水平翻转" onclick="imgReverse('h');">
<input type="button" value="垂直翻转" onclick="imgReverse('v');">
-->

<br/><br/>
</body>
</html>