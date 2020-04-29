var mapObj = null; //地图对象
var mapOverViewState = "Show";  //鹰眼状态
var defultImge = "http://webapi.amap.com/theme/v1.3/markers/n/mark_bs.png";
var custormImage = "http://www.e-wings.com.cn/ICON/images/mark/";
var mapisLoad = false;
var mappicAgent = true;
var infoWindow = new AMap.InfoWindow();

function mapInit(mapID, centerX, centerY, zoom, maponload) {//自定义函数名,在body处页面加载时调用	
    mapObj = new AMap.Map(mapID, {
        resizeEnable: true,
        zoom: zoom,
        center: [centerX, centerY]
    });

    mapObj.plugin(["AMap.ToolBar"], function () {
        //加载工具条插件
        toolbar = new AMap.ToolBar();
        mapObj.addControl(toolbar);
    });
}
//添加地图控件
function addMapControl() { 
    //添加地图类型切换插件
    mapObj.plugin(["AMap.MapType"],function(){
        //地图类型切换
        var mapType= new AMap.MapType({
            defaultType:0,//默认显示卫星图
            showRoad:true //叠加路网图层
        });
        mapObj.addControl(mapType);
    }); 

    //在地图中添加ToolBar插件
    mapObj.plugin(["AMap.ToolBar"],function(){      
        toolBar = new AMap.ToolBar();
        mapObj.addControl(toolBar);     
    });
    //在地图中添加鹰眼插件
    mapObj.plugin(["AMap.OverView"],function(){
        //加载鹰眼
        //初始化隐藏鹰眼
        overView = new AMap.OverView();
        overView.open();
        mapObj.addControl(overView);
    });
    //加载比例尺插件
    mapObj.plugin(["AMap.Scale"], function(){       
        scale = new AMap.Scale();
        mapObj.addControl(scale);
    });			
}


function createMarkfx_08(id, title, imge, x, y, isedit, fx, lable) {
    var marker = new AMap.Marker({
        position: [x, y],
        icon: imge,
        draggable: isedit,
        raiseOnDrag: true,
        extData: { 'id': id },
        angle: fx,
        topWhenMouseOver: true,
        title: title
    });

    return marker;
}
function createMarkfx_01(id, title, imge, x, y, isedit, fx, lable) {
    var marker = new AMap.Marker({
        position: [x, y],
        icon: imge,
        draggable: isedit,
        raiseOnDrag: true,
        extData: { 'id': id },
        angle: fx,
        topWhenMouseOver: true,
        title: title
    });
    marker.setLabel({
        offset: new AMap.Pixel(20, 20),
        content: lable
    });
    return marker;
}

function getOverlayById(id) {
    var markers = mapObj.getAllOverlays();
    var markerscount = markers.length;
    for (var i = 0; i < markerscount; i++) {
        var tempmarker = markers[i];
        if (tempmarker.getExtData().id == id) {
            return tempmarker;
        }
    }
    return null;
}




function markerClick(e) {
    infoWindow.setContent(e.target.content);
    infoWindow.open(mapObj, e.target.getPosition());
}



function removeOverlayById(id) {
    var tempobj = getOverlayById(id);
    if (tempobj != null) {
        mapObj.remove(tempobj);
    }
}


//构建自定义信息窗体
function createInfoWindow(title, content) {
    var info = document.createElement("div");
    info.className = "info";

    //可以通过下面的方式修改自定义窗体的宽高
    //info.style.width = "400px";
    
    // 定义顶部标题
    var top = document.createElement("div");
    var titleD = document.createElement("div");
    var closeX = document.createElement("img");
    top.className = "info-top";
    titleD.innerHTML = title;
    closeX.src = "http://webapi.amap.com/images/close2.gif";
    closeX.onclick = closeInfoWindow;

    top.appendChild(titleD);
    top.appendChild(closeX);
    info.appendChild(top);

    // 定义中部内容
    var middle = document.createElement("div");
    middle.className = "info-middle";
    middle.style.backgroundColor = 'white';
    middle.innerHTML = content;
    info.appendChild(middle);

    // 定义底部内容
    var bottom = document.createElement("div");
    bottom.className = "info-bottom";
    bottom.style.position = 'relative';
    bottom.style.top = '0px';
    bottom.style.margin = '0 auto';
    var sharp = document.createElement("img");
    sharp.src = "http://webapi.amap.com/images/sharp.png";
    bottom.appendChild(sharp);
    info.appendChild(bottom);
    return info;
}

//关闭信息窗体
function closeInfoWindow() {
    mapObj.clearInfoWindow();
}

function addBeiJing(aaa027) {
    //加载行政区划插件
    AMap.service('AMap.DistrictSearch', function() {
        var opts = {
            subdistrict: 1,   //返回下一级行政区
            extensions: 'all',  //返回行政区边界坐标组等具体信息
            level: 'city'  //查询行政级别为 市
        };
        //实例化DistrictSearch
        district = new AMap.DistrictSearch(opts);
        district.setLevel('district');
        //行政区查询
        district.search(aaa027, function(status, result) {
            var bounds = result.districtList[0].boundaries;
            var polygons = [];
            if (bounds) {
                for (var i = 0, l = bounds.length; i < l; i++) {
                    //生成行政区划polygon
                    var polygon = new AMap.Polygon({
                        map: mapObj,
                        strokeWeight: 1,
                        path: bounds[i],
                        fillOpacity: 0.3,
                        fillColor: '#09ACF7',
                        strokeColor: '#F01712'
                    });
                    polygons.push(polygon);
                }
                mapObj.setFitView();//地图自适应
            }
        });
    });
}

//添加marker标记【有弹跳效果】
function addMarker_tantiao(lng,lat,address,title,content,icon) {	
	mapObj.clearMap();  // 清除地图覆盖物				
	//创建点标记				  
	var marker = new AMap.Marker({
		map: mapObj,
		icon: icon,
		position: new AMap.LngLat(lng, lat)
	});
	marker.setTitle(title);
	// 设置label标签
    marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: content
    });
	//设置点标记的动画效果，此处为弹跳效果
	marker.setAnimation('AMAP_ANIMATION_BOUNCE');
	mapObj.setFitView();
}


//添加marker标记
function addMarker_tantiao_no(lng,lat,address,title,content,icon) {
	//mapObj.clearMap();  // 清除地图覆盖物				
	//创建点标记				  
	var marker = new AMap.Marker({
		map: mapObj,
		icon: icon,
		position: new AMap.LngLat(lng, lat)
	});
	marker.setTitle(title);
	// 设置label标签
    marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: content
    });
	//设置点标记的动画效果，此处为弹跳效果
	//marker.setAnimation('AMAP_ANIMATION_BOUNCE');
	mapObj.setFitView();
}

//添加marker标记
function addMarker_infowindow(lng,lat,address,title,content,icon,flag) {
	//mapObj.clearMap();  // 清除地图覆盖物				
	//创建点标记				  
	var marker = new AMap.Marker({
		map: mapObj,
		icon: icon,
		position: new AMap.LngLat(lng, lat)
	});
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
	if(flag=='1'){
		//鼠标点击marker弹出自定义的信息窗体
		//AMap.event.addListener(marker, 'mouseover',function() {
			infoWindow.open(mapObj, marker.getPosition());
		//});
	}
	
	marker.setTitle(title);
	// 设置label标签
    marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: address
    });
    
	mapObj.setFitView();
}
