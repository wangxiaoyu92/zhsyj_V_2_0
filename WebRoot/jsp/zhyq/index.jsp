<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>汤阴县·智慧园区食品质量安全追溯平台</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/carousel.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/default.css">
    <script src="./js/jquery-1.12.0.min.js"></script>
    <script src="./js/common.js"></script>
	<script src="./js/custom.js"></script>
	<script src="./js/layer.js"></script>
	<link href="./css/layer.css" rel="stylesheet">
    <style>
		body{background-color:cornflowerblue;}		
    </style>
</head>
<body style="overflow: hidden;">
<div id="div" style="width: 100%;position: relative;overflow: hidden;">
	<nav class="cd-vertical-nav">
		<ul>
			<li><a href="index.jsp" class="smooth"><span class="label">首页</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=spjkxt');" class="smooth"><span class="label">视频监控系统</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=jgxt');" class="smooth"><span class="label">日常监管系统</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=zsxt');" class="smooth"><span class="label">溯源管理系统</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=zxxt');" class="smooth"><span class="label">信用管理系统</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=xxzyjsxt');" class="smooth"><span class="label">从业人员系统</span></a></li>
			<li><a href="javascript:linkToSelf('<%=contextPath %>/index_tyzhyq.jsp?systemcode=xxzyjsxt');" class="smooth"><span class="label">信息上报系统</span></a></li>
		</ul>
	</nav>
	<div class="navbar navbar-fixed-top skrollable skrollable-between" role="navigation" data-0="line-height:100px; height:100px; background-color:rgba(0,0,0,0);" data-300="line-height:60px; height:60px; background-color:rgba(0,0,0,1);" style="line-height: 100px; height: 100px; background-color: rgba(0, 0, 0, 0);">
		<div class="container">
			<div class="navbar-header">
				<h1><a class="navbar-brand skrollable skrollable-between" href="index.jsp" data-0="line-height:90px;" data-300="line-height:50px;" style="line-height: 90px;">汤阴县·智慧园区</a></h1>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav skrollable skrollable-between" data-0="margin-top:20px;" data-300="margin-top:5px;" style="margin-top: 20px;">
					<li><a class="smooth" href="javascript:showUrl('zhyq_jianjie.jsp');">园区简介</a></li>
					<li><a class="smooth" href="javascript:linkToSelf('map.jsp');">企业分布</a></li>
				</ul>
			</div>
		</div>
	</div>
	<section id="section-home" class="appear carousel carousel-fade slide" data-ride="carousel" data-interval="5000" data-pause="hover">
		<ol class="carousel-indicators" style="z-index: 999">
			<li data-target="#section-home" data-slide-to="0" class="active"></li>
			<li data-target="#section-home" data-slide-to="1" class=""></li>
			<li data-target="#section-home" data-slide-to="2" class=""></li>
			<li data-target="#section-home" data-slide-to="3" class=""></li>
		</ol>
		<!-- Wrapper for slides -->
		<div class="carousel-inner">
			<div class="item active">
				<iframe src="http://tyzjj.3vfang.com:720/p/share/content.php?m=dGFuZ3lpbi1pdGVtPTEyNjAx&from=singlemessage" style="width: 100%; height: 100%; border: none; margin: 0; padding: 0; z-index: 1">hdfaehuawhefkjh</iframe>
				<div class="container-fluid">
					<div class="row home-top">
						<div class="col-md-12">
<!-- 							<img src="img/t6.png" alt="" class="animation203 center-block animated fadeInUp img-responsive"> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script src="js/modernizr.min.js"></script>
<script src="js/jquery.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/skrollr.min.js"></script>
<script src="js/stellar.js"></script>   
<script src="js/jquery.appear.js"></script>
<script src="js/jweixin-1.0.0.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript" src="js/three.min.js"></script>

<script type="text/javascript">
    if (!Modernizr.mq('only all and (max-width: 1024px)')) {
        var container;
        var camera, scene, renderer;
        var mesh, geometry, material;
        var mouseX = 0, mouseY = 0;
        var start_time = Date.now();
        var windowHalfX = window.innerWidth / 2;
        var windowHalfY = window.innerHeight / 2;
		$(".carousel .item").css("height",  window.innerHeight+"px");
        init();
        function init() {
            container = document.createElement('div');
            document.getElementById('sky').appendChild(container);
			
            // Bg gradient
            var canvas = document.createElement('canvas');
            canvas.width = 32;
            canvas.height = document.getElementById('id').style.height=window.innerHeight+'px';
            var context = canvas.getContext('2d');
            var gradient = context.createLinearGradient(0, 0, 0, canvas.height);
            gradient.addColorStop(0, "#1e4877");
            gradient.addColorStop(0.5, "#4584b4");
            context.fillStyle = gradient;
            context.fillRect(0, 0, canvas.width, canvas.height);
            container.style.background = 'url(' + canvas.toDataURL('image/png') + ')';
            container.style.backgroundSize = '32px 100%';
            container.style.height =window.innerHeight+'px';
            camera = new THREE.PerspectiveCamera(30, window.innerWidth / 700, 1, 3000);
            camera.position.z = 6000;
            scene = new THREE.Scene();
            geometry = new THREE.Geometry();
            var texture = THREE.ImageUtils.loadTexture('img/cloud10.png', null, animate);
            texture.magFilter = THREE.LinearMipMapLinearFilter;
            texture.minFilter = THREE.LinearMipMapLinearFilter;
            var fog = new THREE.Fog(0x4584b4, -100, 3000);
            material = new THREE.ShaderMaterial({
                uniforms: {
                    "map": {type: "t", value: texture},
                    "fogColor": {type: "c", value: fog.color},
                    "fogNear": {type: "f", value: fog.near},
                    "fogFar": {type: "f", value: fog.far}
                },
                vertexShader: document.getElementById('vs').textContent,
                fragmentShader: document.getElementById('fs').textContent,
                depthWrite: false,
                depthTest: false,
                transparent: true
            });
            var plane = new THREE.Mesh(new THREE.PlaneGeometry(64, 64));
            for (var i = 0; i < 8000; i++) {
                plane.position.x = Math.random() * 1000 - 500;
                plane.position.y = -Math.random() * Math.random() * 200 - 15;
                plane.position.z = i;
                plane.rotation.z = Math.random() * Math.PI;
                plane.scale.x = plane.scale.y = Math.random() * Math.random() * 1.5 + 0.5;
                THREE.GeometryUtils.merge(geometry, plane);
            }
            mesh = new THREE.Mesh(geometry, material);
            scene.add(mesh);
            mesh = new THREE.Mesh(geometry, material);
            mesh.position.z = -8000;
            scene.add(mesh);
            renderer = new THREE.WebGLRenderer({antialias: false});
            renderer.setSize(window.innerWidth, window.innerHeight);
            container.appendChild(renderer.domElement);
            document.addEventListener('mousemove', onDocumentMouseMove, false);
            window.addEventListener('resize', onWindowResize, false);
        }

        function onDocumentMouseMove(event) {
            mouseX = ( event.clientX - windowHalfX ) * 0.25;
            mouseY = ( event.clientY - windowHalfY ) * 0.15;
        }

        function onWindowResize(event) {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        }

        function animate() {
            requestAnimationFrame(animate);
            position = ( ( Date.now() - start_time ) * 0.03 ) % 8000;
            camera.position.x += ( mouseX - camera.position.x ) * 0.01;
            camera.position.y += ( -mouseY - camera.position.y ) * 0.01;
            camera.position.z = -position + 8000;
            renderer.render(scene, camera);
        }
    }
</script>
<script type="text/javascript">
	function showUrl(url){
        var url = encodeURI(url);
		layer.open({
			type:2,			
			title: "汤阴县·智慧园区简介",
			area:["70%","60%"],
			shade:0,
			content: url
		});
	}
	function showPic(url){
		layer.open({
	        type: 1,
	        title: "图片预览",
	        area:["70%","90%"],
	        shadeClose: true, //点击遮罩关闭
	        content: "<img style='width:100%;height:100%;' src="+url+"></img>"
	  }); 
	}        
</script>
</body>
</html>