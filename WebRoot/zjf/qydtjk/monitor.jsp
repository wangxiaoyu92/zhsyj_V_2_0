<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));
	String aaa027Name = StringHelper.showNull2Empty(request.getParameter("aaa027Name"));
	String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
	String comhhbbz = StringHelper.showNull2Empty(request.getParameter("comhhbbz"));
	String comspjkbz = StringHelper.showNull2Empty(request.getParameter("comspjkbz"));
	String combxbz = StringHelper.showNull2Empty(request.getParameter("combxbz"));
	String commc = StringHelper.showNull2Empty(request.getParameter("commc"));
%>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
	String zxdcity = ((Aa01) SysmanageUtil.getAa01("ZXDCITY")).getAaa005();
%>
<!DOCTYPE html>
<html>
<head>
<title>企业地图监控</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<style type="text/css">		
	/*右下角弹出信息框样式*/
	#pop{width:260px;background:#cfdef5;border:1px solid #95b8e7;font-size:12px;position: fixed;right:10px;bottom:10px;}
	#popHead{line-height:32px;background:#CEDEF3;border-bottom:1px solid #95b8e7;position:relative;font-size:12px;padding:0 0 0 10px;}
	#popHead h2{color:#1a2950;font-size:14px;line-height:32px;height:32px;}/*弹出信息最上面提示标题*/
	#popHead #popClose{color:#1a2950;color:red;position:absolute;right:10px;top:1px;}/*关闭*/
	#popHead a#popClose:hover{color:red;cursor:pointer;}/*关闭HOVER时*/
	#popContent{padding:5px 10px;}/*弹出信息内容*/
	#popTitle a{color:#333;line-height:24px;font-size:14px;font-family:'微软雅黑';font-weight:bold;text-decoration:none;}/*消息提醒标题*/
	#popTitle a:hover{color:#f60;}/*消息提醒标题HOVER时*/
	#popIntro{text-indent:0px;line-height:160%;margin:5px 0;color:#1a2950;}/*内容详情text-indent:24px;*/
	#popMore{text-align:right;border-top:1px dotted #ccc;line-height:24px;margin:8px 0 0 0;}/*查看*/
	#popMore a{color:#f40;text-decoration:none}/*查看a*/
	#popMore a:hover{color:#f00;}/*查看 »a:hover*/
</style>
</head>
<script type="text/javascript" src="<%=contextPath%>/jslib/yanue.pop.js"></script>
<script type="text/javascript">
	//下拉框列表
	var aaa027 = '<%=aaa027%>';
	var aaa027Name = '<%=aaa027Name%>';
	var comdalei = '<%=comdalei%>';
	var comhhbbz = '<%=comhhbbz%>';
	var comspjkbz = '<%=comspjkbz%>';
	var combxbz = '<%=combxbz%>';
	var commc = '<%=commc%>';
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var zxdcity = '<%=zxdcity%>';
		
	$(function() {
		queryCompany();
		var id = setInterval('queryEmergency()',6000);
		var id2 = setInterval('getSysuserLocation()',6000);
	});
	
	//统计【企业】分布图
	var queryCompany = function(){
		$.post(basePath + '/common/sjb/queryCompany', {
				"aaa027" : aaa027,
				"comdalei" : comdalei,
				"comhhbbz" : comhhbbz,
				"comspjkbz" : comspjkbz,
				"combxbz" : combxbz,
				"commc" : commc
			},
			function(result) {
				if (result.code == '0') {
					var count = result.total;
                    if(count>0){
						var mydata = result.rows;
						initialize(mydata);							                    	
	                } 																	
				}
			},
		'json');
	};

	
	// 查看【企业】详情
	var showCompany = function(comid) {	
		var dialog = parent.sy.modalDialog({
			title : '查看企业详细信息',
			width : 800,
			height : 600,
			maximizable : true,
			url : basePath + "/pcompany/pcompanyFormIndex?op=view&comid=" + comid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//统计【突发事件】分布图
	var queryEmergency = function(){
		mapObj.remove(markers_event);//zjf
		$.post(basePath + '/emergency/queryEmergency', {
				"aaa027" : aaa027,
				"eventstate" : '0'
			},
			function(result) {
				if (result.code == '0') {
					var count = result.total;
                    if(count>0){
						var mydata2 = result.rows;
						initialize2(mydata2);
						//var pop = new Pop("","标题连接网址","当前有【<font style='color:red;font-weight:bold'>"+count+"</font>】个突发事件，请及时处理！<br/>");								                    	
	                } 																	
				}
			},
		'json');
	};
	

	// 查看【突发事件】详情
	var showEmergency = function(comid) {	
		var dialog = parent.sy.modalDialog({
			title : '查看突发事件详细信息',
			width : 800,
			height : 600,
			url : basePath + '/emergency/emergencyFormIndex?op=view&eventid=' + comid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//统计【监管员】实时分布图
	var getSysuserLocation = function(){
		mapObj.remove(markers_sysuser);//zjf
		$.post(basePath + '/common/sjb/getSysuserLocation', {
				"username" : ''
			},
			function(result) {
				if (result.code == '0') {
					var count = result.total;
                    if(count>0){
						var mydata3 = result.rows;
						initialize3(mydata3);
	                } 																	
				}
			},
		'json');
	};
	
	// 明厨亮灶视频监控
	var showSpjky = function(comid) {
		var url = basePath + '/jsp/jk/jkyAllList.jsp?comid=' + comid;
		var obj = new Object();
		var k = popwindow(url,obj,950,650); 
	};
	
	// 应急指挥监控
	var showYjzhjk = function(comid) {
		var url = 'http://116.255.143.56:5080/RTMonitoring/MutiMeeting/Application.html';
		window.open(url,'应急指挥中心监控','height=2000,width=2000,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');			
	};
	
	

</script>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="地图信息">			 
		        <!--地图容器-->
			    <div id="mapContainer" style="width:99%;height:600px;border:#00A1EA solid 1px;margin-top: 3px">
			         &nbsp;
			    </div>
			    <div id="result"> </div>
		    	<div id="result1"> </div>
		    </sicp3:groupbox>          
    	</div>    
    </div>
    <!-- 消息提示框 -->
	<div id="pop" style="display:none;">
		<div id="popHead">
			<a id="popClose" title="关闭">关闭</a>
			<h2>温馨提示</h2>
		</div>
		<div id="popContent">
			<dl>
				<!--<dt id="popTitle"><a href="http://yanue.info/" target="_blank">消息提醒标题参数</a></dt>-->
				<dd id="popIntro">消息提醒内容参数</dd>
			</dl>
			<!-- <p id="popMore"><a href="http://yanue.info/" target="_blank">查看>></a></p> -->
		</div>
	</div>    
</body>
</html>
<script language="javascript" type="text/javascript">         
	window.onload= function(){ 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 10);
		addBeiJing(zxdcity);
		mapObj.clearMap();  // 清除地图覆盖物
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
		//mapObj.clearMap();  // 清除地图覆盖物
	    // 向地图添加标注点
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].comjdzb;
		    var lat = mydata[i].comwdzb;
	        var address = mydata[i].comdz;
	        var commc = mydata[i].commc;
	        var comid = mydata[i].comid+"";
	        var combxbz = mydata[i].combxbz;
	        var comspjkbz = mydata[i].comspjkbz;
	        var comhhbbz = mydata[i].comhhbbz;
			var title = "地图定位";
		    var content = [];	    
		    content.push("企业名称：" + commc);
		    content.push("企业地址：" + address);
		    
		    content.push("<a onclick=showCompany('"+comid+"')>详细信息</a>");  
			if(combxbz=='1'){
				content.push("<img src='<%=contextPath%>/images/frame/picc.png'/>");
			}
			if(comspjkbz=='1'){
				content.push("<a onclick=showSpjky('"+comid+"')>视频监控</a>");
			}
			var icon = ''; 
			if(comhhbbz=='0'){
				icon = basePath + "images/frame/heidw.png";
			}else if(comhhbbz=='1'){
				icon = basePath + "images/frame/hongdw.png";
			}else{
				icon = basePath + "images/frame/zbdw.png";
			}
		     
	    	addMarker(lng,lat,address,title,content,icon);   
	    }
	    //addCluster(0);
	    //mapObj.setFitView(); 				
	}
	
	//添加marker标记
	function addMarker(lng,lat,address,title,content,icon) {
		//mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			icon: icon,
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
		AMap.event.addListener(marker, 'click',function() {
			infoWindow.open(mapObj, marker.getPosition());
		});
		//mapObj.setFitView();
	}



	//地图初始化时，在地图上添加一个marker标记,鼠标点击marker可弹出自定义的信息窗体
	var markers_event = [];
	function initialize2(mydata) { 
		mapObj.remove(markers_event);
	    // 向地图添加标注点
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].eventjdzb;
		    var lat = mydata[i].eventwdzb;
	        var eventdate = mydata[i].eventdate;
	        var address = mydata[i].eventaddress;
	        var eventid = mydata[i].eventid+"";
			var title = "突发事件定位";
		    var content = [];	    
		    content.push("事件发生时间：" + eventdate);
		    content.push("事件发生地点：" + address);
		    content.push("<a onclick=showEmergency('"+eventid+"')>详细信息</a>");  
		    content.push("<a onclick=showYjzhjk('"+eventid+"')>现场视频<img src='<%=contextPath%>/images/frame/webcam.png'/></a>");  
	    	addMarker2(lng,lat,address,title,content);   
	    }
	    //mapObj.setFitView(); 				
	}
	
	//添加marker标记
	function addMarker2(lng,lat,address,title,content) {
		//mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			icon: basePath + "images/frame/jingdeng.gif",
			position: new AMap.LngLat(lng, lat)
		});
		markers_event.push(marker);
		//实例化信息窗体
	    var infoWindow = new AMap.InfoWindow({
	        isCustom: true,  //使用自定义窗体
	        content: createInfoWindow(title, content.join("<br/>")),
	        offset: new AMap.Pixel(16, -45)
	    });
		//鼠标点击marker弹出自定义的信息窗体
		AMap.event.addListener(marker, 'click',function() {
			infoWindow.open(mapObj, marker.getPosition());
		});
		//mapObj.setFitView();
	}
	
	//地图初始化时，在地图上添加一个marker标记,鼠标点击marker可弹出自定义的信息窗体
	var markers_sysuser = [];
	function initialize3(mydata) { 
		mapObj.remove(markers_sysuser);
	    // 向地图添加标注点
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].lng;
		    var lat = mydata[i].lat;
	        var dwsj = mydata[i].dwsj;
	        var address = mydata[i].address;
	        var username = mydata[i].username;
	        var description = mydata[i].description;
	        var mobile = mydata[i].mobile;

			var title = "人员定位";
		    var content = [];	    
		    content.push("定位时间：" + dwsj);
		    content.push("定位地点：" + address);
			content.push("姓名：" + username);
			content.push("描述：" + description);
			content.push("手机号：" + mobile);
			 content.push("<a onclick=showYjzhjk('')>现场视频<img src='<%=contextPath%>/images/frame/webcam.png'/></a>");  
	    	addMarker3(lng,lat,address,title,content);   
	    }				
	}
	
	//添加marker标记
	function addMarker3(lng,lat,address,title,content) {	
		//mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			icon: basePath + "images/frame/rydw.png",
			position: new AMap.LngLat(lng, lat)
		});
		markers_sysuser.push(marker);
		//实例化信息窗体
	    var infoWindow = new AMap.InfoWindow({
	        isCustom: true,  //使用自定义窗体
	        content: createInfoWindow(title, content.join("<br/>")),
	        offset: new AMap.Pixel(16, -45)
	    });
		//鼠标点击marker弹出自定义的信息窗体
		AMap.event.addListener(marker, 'click',function() {
			infoWindow.open(mapObj, marker.getPosition());
		});
		//mapObj.setFitView();
	}
</script>
