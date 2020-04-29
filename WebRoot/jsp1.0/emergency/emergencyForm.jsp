<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_eventid = StringHelper.showNull2Empty(request.getParameter("eventid"));
%>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
	String zxdcity = ((Aa01) SysmanageUtil.getAa01("ZXDCITY")).getAaa005();
%>
<!DOCTYPE html>
<html>
<head>
<title>突发事件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<script language="javascript" type="text/javascript"> 
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var zxdcity = '<%=zxdcity%>';
	window.onload = function(){ 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 12);//根据中心点坐标定位地图
		addBeiJing(zxdcity);
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

					var title = "突发事件";
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
		        		var title = "突发事件";
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
		    var lng = mydata[i].eventjdzb;
		    var lat = mydata[i].eventwdzb;
            var address = mydata[i].eventaddress;
			var title = "突发事件";
		    var content = [];	    
		    content.push("地址：" + address); 
	    	addMarker(lng,lat,address,title,content);   
	    }
	    addCluster(0);
	    mapObj.setFitView(); 				
	}
	
	//添加marker标记
	function addMarker(lng,lat,address,title,content) {
		//mapObj.clearMap();  // 清除地图覆盖物				
		//创建点标记				  
		var marker = new AMap.Marker({
			map: mapObj,
			icon: basePath + "images/frame/jingdeng.gif",
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
<script type="text/javascript">
	//下拉列表
	var eventlevel = <%=SysmanageUtil.getAa10toJsonArray("EVENTLEVEL")%>;
	var eventstate = <%=SysmanageUtil.getAa10toJsonArray("EVENTSTATE")%>;
	var cb_eventlevel;
	var cb_eventstate;
	
	$(function() {
		cb_eventlevel = $('#eventlevel').combobox({
	    	data : eventlevel,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_eventstate = $('#eventstate').combobox({
	    	data : eventstate,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		if ($('#eventid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/emergency/queryEmergencyDTO', {
				eventid : $('#eventid').val()
			}, function(result) {
				if (result.code=='0') {
					var mydata = result.data;	
					$('form').form('load', mydata);	
					//自动定位
					var lng = $('#jdzb').val();			
					var lat = $('#wdzb').val();
					geocoderY(lng,lat);	
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');
			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');
				$('#btn_dtdw').attr('disabled',true);			
			}
		}
	});

	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url = basePath + '/emergency/saveEmergency';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
	   	$dialog.dialog('destroy');
	};

	// 地点定位
	var geocoders = function(){
		var address = $('#eventaddress').val();			
		geocoder(address);
	}

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		var dialog = parent.sy.modalDialog({  
				width : 300,
				height : 400, 
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$('#aaa027').val(k.aaa027);
						$('#aaa027name').val(k.aaa027name);
						$('#eventaddress').val(k.aab301);
					}
				sy.removeWinRet(dialogID);
			});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >   
	       	<sicp3:groupbox title="突发事件登记信息">	
	   			<table class="table" style="width: 99%;">					
					<tr>
						<td style="text-align:right;"><nobr>事件登记ID:</nobr></td>
						<td><input name="eventid" id="eventid"  style="width: 200px " class="input_readonly" readonly="readonly" value="<%=v_eventid%>"/></td>
						<td style="text-align:right;"><nobr> 事件发生时间:</nobr></td>
						<td><input	name="eventdate" id="eventdate" class="Wdate"
								onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								readonly="readonly" style="width: 200px;">
						</td>
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>事件等级:</nobr></td>
						<td><input id="eventlevel" name="eventlevel" style="width: 200px"/></td>
						<td style="text-align:right;"><nobr>事件处理状态:</nobr></td>
						<td><input id="eventstate" name="eventstate" style="width: 200px"/></td>															
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>事件上报人:</nobr></td>
						<td><input id="newsinitiator" name="newsinitiator" style="width: 200px"/></td>													
						<td style="text-align:right;"><nobr>上报人联系方式:</nobr></td>
						<td><input id="eventfinder" name="eventfinder" style="width: 200px"
							class="easyui-validatebox" validtype="phoneAndMobile"/></td>
														
					</tr>	
					<tr>						
						<td style="text-align:right;">事件内容:</td>
						<td colspan="3">
							<textarea id="eventcontent" name="eventcontent" style="width: 580px;" rows="5"></textarea>
						</td>			
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div>							
						</td>								
					</tr>										
					<tr>
						<td style="text-align:right;"><nobr>事件发生地点:</nobr></td>
						<td colspan="2"><input name="eventaddress" id="eventaddress" style="width: 99%; "  /></td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_dtdw"
								iconCls="icon-search" onclick="geocoders()"> 地图定位 </a>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>经度坐标:</nobr></td>
						<td><input name="eventjdzb" id="jdzb"  style="width: 175px; " class="easyui-validatebox" data-options="required:true"  readonly="readonly" /></td>	
						<td style="text-align:right;"><nobr>纬度坐标:</nobr></td>
						<td><input name="eventwdzb" id="wdzb"  style="width: 175px; " class="easyui-validatebox" data-options="required:true"  readonly="readonly" /></td>					
					</tr>					
				</table>
	    	</sicp3:groupbox>
	    	<sicp3:groupbox title="地图信息">				
		        <!--地图容器-->
			    <div id="mapContainer" style="width:98%;height:600px;border:#ccc solid 2px;">
			         &nbsp;
			    </div>
			    <div id="result"> </div>
		    	<div id="result1"> </div>
		    </sicp3:groupbox> 
		</form>
    </div>    
</body>
</html>