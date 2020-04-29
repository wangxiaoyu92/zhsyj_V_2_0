<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01,java.net.URLDecoder"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String address = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("address")),"UTF-8");
%>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
	Sysuser v_sysuser=SysmanageUtil.getSysuser();
	String aaa027="";
	if (v_sysuser!=null){
		aaa027 = StringHelper.showNull2Empty(SysmanageUtil.getSysuser().getAaa027());
	}
	 
%> 
<!DOCTYPE html>
<html>
<head>
<title>地图定位</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
	var obj = new Object();
	obj.type = ''; 
	sy.setWinRet(obj);

	var address = '<%=address%>';
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var aaa027 = '<%=aaa027%>';

	window.onload = function(){ 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 12);//根据中心点坐标定位地图
	    geocoder(address);

		//为地图注册click事件获取鼠标点击出的经纬度坐标   
	    var clickListener = AMap.event.addListener(mapObj, 'click', function(e) {
			var lng = e.lnglat.getLng();
	        var lat = e.lnglat.getLat();
	        geocoderY(lng,lat);
	     	//设置定位坐标
			$('#jdzb').val(lng);
			$('#wdzb').val(lat);
		});
	}
	   
    //获取地图定位数据
	var geocoders = function(){
		obj.jdzb = $('#jdzb').val();		
		obj.wdzb = $('#wdzb').val(); 	
		obj.address = $('#address').val();
		sy.setWinRet(obj);
		parent.$("#"+sy.getDialogId()).dialog("close");
	}	
</script>
<script type="text/javascript"> 
	//地理编码	
	function geocoder(address) {
		mapObj.clearMap();  // 清除地图覆盖物
		var MGeocoder; 
		//加载服务
		AMap.service(["AMap.Geocoder"],function() {
			//地理编码插件
			MGeocoder = new AMap.Geocoder({
	            radius: 1000,
	            extensions: "all"
	        }); 
			MGeocoder.getLocation(address,function(status, result) {
				if (status === 'complete' && result.info === 'OK') {
					var geocode = result.geocodes;
					var lng = geocode[0].location.getLng();
					var lat = geocode[0].location.getLat();
					//设置定位坐标
					$('#jdzb').val(lng);
					$('#wdzb').val(lat);

					var title = "地图定位";
				    var content = [];	    
				    content.push("地址：" + address); 
			    	addMarker(lng,lat,address,title,content);
			    	//mapObj.setFitView();
				    //mapObj.setZoomAndCenter(14, [lng,lat]);   
			    	mapObj.panTo([lng,lat]);				    	
				}
			});
		});
	}
	
	//逆地理编码
	function geocoderY(lng,lat) {
		if(lng != "" && lat != ""){
			//已知点坐标
			var lnglatXY = new AMap.LngLat(lng,lat);
			var MGeocoder; 
			//加载服务
			AMap.service(["AMap.Geocoder"],function() {
				//地理编码插件
				MGeocoder = new AMap.Geocoder({
		            radius: 1000,
		            extensions: "all"
		        });					
		        MGeocoder.getAddress(lnglatXY, function(status, result){
		        	if(status === 'complete'){
		        		var regeocode = result.regeocode;
		        		var address = regeocode.formattedAddress;
		        		$('#address').val(address);//zjf
		        		
		        		var title = "地图定位";
					    var content = [];	    
					    content.push("地址：" + address); 
				    	addMarker(lng,lat,address,title,content);
				    	//mapObj.setFitView();
					    //mapObj.setZoomAndCenter(14, [lng,lat]);   
				    	mapObj.panTo([lng,lat]);
		        	}
				});
			});
		}
	}

	var cluster, markers = [];
    // 添加点聚合
    function addCluster(tag) {
        if (cluster) {
            cluster.setMap(null);
        }
        if (tag == 1) {
            var sts = [{
                url: "http://developer.amap.com/wp-content/uploads/2014/06/1.png",
                size: new AMap.Size(32, 32),
                offset: new AMap.Pixel(-16, -30)
            }, {
                url: "http://developer.amap.com/wp-content/uploads/2014/06/2.png",
                size: new AMap.Size(32, 32),
                offset: new AMap.Pixel(-16, -30)
            }, {
                url: "http://developer.amap.com/wp-content/uploads/2014/06/3.png",
                size: new AMap.Size(48, 48),
                offset: new AMap.Pixel(-24, -45),
                textColor: '#CC0066'
            }];
            mapObj.plugin(["AMap.MarkerClusterer"], function() {
                cluster = new AMap.MarkerClusterer(mapObj, markers, {
                    styles: sts
                });
            });
        } else {
            mapObj.plugin(["AMap.MarkerClusterer"], function() {
                cluster = new AMap.MarkerClusterer(mapObj, markers);
            });
        }
    }

	//地图初始化时，在地图上添加一个marker标记,鼠标点击marker可弹出自定义的信息窗体
	function initialize(mydata) { 
		mapObj.clearMap();  // 清除地图覆盖物
	    // 向地图添加标注点
	    var mapBounds = mapObj.getBounds();
	    var sw = mapBounds.getSouthWest();
	    var ne = mapBounds.getNorthEast();
	    var lngSpan = Math.abs(sw.lng - ne.lng);
	    var latSpan = Math.abs(ne.lat - sw.lat);
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].jcsbjdzb;
		    var lat = mydata[i].jcsbwdzb;
            var address = mydata[i].jcsbjcdd;
			var title = "地图定位";
		    var content = [];	    
		    content.push("地址：" + address); 
	    	addMarker(lng,lat,address,title,content);   
	    }
	    addCluster(0);
	    mapObj.setFitView(); 				
	}
	
	//添加marker标记
	function addMarker(lng,lat,address,title,content) {
		mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			icon: basePath + "images/frame/zbdw.png",
			position: new AMap.LngLat(lng, lat)
		});
		markers.push(marker);
		//实例化信息窗体
	    var infoWindow = new AMap.InfoWindow({
	        isCustom: true,  //使用自定义窗体
	        content: createInfoWindow(title, content.join("<br/>")),
	        offset: new AMap.Pixel(16, -45)
	    });
		//鼠标点击marker弹出自定义的信息窗体
		AMap.event.addListener(marker, 'mouseover',function() {
			infoWindow.open(mapObj, marker.getPosition());
		});
		//mapObj.setFitView();
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">		
	    <div title="地图定位"  style="overflow:hidden;">
			<sicp3:groupbox title="地图信息">				
		        <!--地图容器-->
			    <div id="mapContainer" style="width:98%;height:500px;border:#ccc solid 2px;">
			         &nbsp;
			    </div>
			    <div id="result"> </div>
		    	<div id="result1"> </div>
		    	
		    	<br/><br/><br/>							       	       
		        <div style="text-align:right">
		        	<input name="jdzb" id="jdzb" type="hidden">
		        	<input name="wdzb" id="wdzb" type="hidden">
		        	<input name="address" id="address" type="hidden">
		        	<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_dtdw"
					iconCls="icon-search" onclick="geocoders()"> 保存坐标 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        </div>
		        <br/>	
		    </sicp3:groupbox> 
	    </div>   
    </div>    
</body>
</html>
