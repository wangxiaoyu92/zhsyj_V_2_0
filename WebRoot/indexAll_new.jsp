<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>智慧食药监-综合监管平台</title>
    <link rel="stylesheet" href="${ctx}/css/all.css">
    <script>
        if (window != top)
            top.location.href = location.href;

        function linkToBlank(v_url){
            var url = encodeURI(v_url);
            window.open(url);
        }

        function linkToSelf(v_url){
            var url = encodeURI(v_url);
            window.location.href = url;
        }

        var jumpToDashboad = function() {
            var url = 'http://39.106.210.17/WebReport/ReportServer?formlet=%E6%99%BA%E6%85%A7%E9%A3%9F%E8%8D%AF%E7%9B%91%E5%A4%A7%E5%B1%8F.frm';
            window.open(url,'newwindow'+"领导视窗",
                'height=900,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,'
                + 'resizable=yes,location=no, status=no');


        };
    </script>
</head>

<body>
<!-- header section -->
<!-- text banner section -->
<section id="banner" class="banner no-padding">
    <div class="container-fluid">
        <div class="row no-gutter">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <blockquote>
                    <img src="${ctx}/images/all/logo.png" alt="logo">
                    <p>食药监局综合监管信息平台</p>
                </blockquote>
            </div>
        </div>
    </div>
</section>
<!-- Text banner section -->
<!-- portfolio section -->
<section id="works" class="works section no-padding">
    <div class="container-fluid con-wd">
        <div class="row no-gutter">

            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=jgxt');" class="work-box">
                <img src="${ctx}/images/all/work-1.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>食品安全监管系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=zsxt');" class="work-box">
                <img src="${ctx}/images/all/work-2.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>食品安全追溯系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=zfbaxt');" class="work-box">
                <img src="${ctx}/images/all/work-3.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>执法办案系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=zxxt');" class="work-box">
                <img src="${ctx}/images/all/work-4.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>食品安全诚信系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('jsp/gzfw/index.jsp');" class="work-box">
                <img src="${ctx}/images/all/work-5.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>食品安全公众服务系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>

            <!-- <div class="col-lg-1" style="clear:left;">&nbsp;</div>-->

            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=dzzwxt');" class="work-box">
                <img src="${ctx}/images/all/work-6.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>电子政务系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=yjzhxt');" class="work-box">
                <img src="${ctx}/images/all/work-7.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>应急指挥系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=jyjcxt');" class="work-box">
                <img src="${ctx}/images/all/work-8.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>食品安全检验检测系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:linkToSelf('index.jsp?systemcode=spjkxt');" class="work-box">
                <img src="${ctx}/images/all/work-9.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>远程视频监控系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
            <div class="col-md-2 col-sm-3 col-xs-4  work  "><a href="javascript:void(0);" onclick="jumpToDashboad()" class="work-box">
                <img src="${ctx}/images/all/work-10.jpg" alt="">
                <div class="overlay">
                    <div class="overlay-caption">
                        <h4>大数据分析系统</h4>
                        <p><i class="fa fa-search-plus fa-2x"></i></p>
                    </div>
                </div>
                <!-- overlay -->
            </a></div>
        </div>
    </div>
</section>

</body>
</html>

