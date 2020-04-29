var imap = {};
imap.base = {};
imap.boundary = {};
imap.overlay = {};
imap.calc = {};
imap.util = {};

var blue = "#4169E1";

//===============地图基础服务==========================
imap.base.buildMap = function (mapname, grade) {
    var map = new BMap.Map(mapname);
    map.addControl(new BMap.NavigationControl());
    // map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.OverviewMapControl());

    var opts = {mapTypes: [BMAP_NORMAL_MAP, BMAP_SATELLITE_MAP]};
    map.addControl(new BMap.MapTypeControl(opts));

    //map.centerAndZoom(point, 8);                 // 初始化地图,设置中心点坐标和地图级别。
    map.enableScrollWheelZoom();

    var styleJson = [
        {
            "featureType": "highway",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "subway",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "railway",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "green",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "manmade",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "building",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        },
        {
            "featureType": "poi",
            "elementType": "all",
            "stylers": {"visibility": "off"}
        }

    ];

    // if (grade === 2) {
        styleJson.push({
            "featureType": "background",
            "elementType": "all",
            "stylers": {
                "color": "#b6d7a8"
            }
        });
    // }

    map.setMapStyle({
        styleJson: styleJson
    });
    return map;
};

//===============地图行政区划边界绘制服务==========================
//绘制父子两级的行政区划边界
imap.boundary.drawParentChilds = function (map, root, childs) {
    map.clearOverlays();

    var name = root.name;
    if (name.length === 0)
        return;

    //绘制parent，删除周边地图
    imap.boundary.drawParent(map, root);

    //绘制child
    for (var j = 0; j < childs.length; j++) {
        if (childs[j].name.length === 0)
            continue;

        if (root.grade === 0 || root.grade === 1) {
            imap.boundary.drawChild(map, childs[j], true);
        } else {
            imap.boundary.drawChild(map, childs[j], false);
        }
    }
};

//绘制父边界
imap.boundary.drawParent = function (map, root) {
    var bdary = new BMap.Boundary();

    //如果已经保存过行政区域坐标数据，那么直接加载，不再请求百度
    // if (root.data && root.data.length > 0) {
    //     var points = imap.util.getPointsFromData(root.data);
    //     if (points.length == 0)
    //         return;
    //
    //     //--------删除外部区域--------------
    //     //for循环都删除掉了，只剩下这个
    //     //网上查了下，东西经南北纬的范围
    //     var EN_JW = "180, 90;";         //东北角
    //     var NW_JW = "-180,  90;";       //西北角
    //     var WS_JW = "-180, -90;";       //西南角
    //     var SE_JW = "180, -90;";        //东南角
    //     //4.添加环形遮罩层
    //     var ply1 = new BMap.Polygon(points + SE_JW + SE_JW + WS_JW + NW_JW + EN_JW + SE_JW, {
    //         strokeColor: "none",
    //         fillColor: "rgb(246,246,246)",
    //         fillOpacity: 1,
    //         strokeOpacity: 0.5
    //     }); //建立多边形覆盖物
    //
    //     map.addOverlay(ply1);
    //
    //     var ply = new BMap.Polygon(points, {
    //         strokeWeight: 2,
    //         strokeColor: blue,
    //         fillColor: "none",
    //         fillOpacity: 0.01
    //     }); //建立多边形覆盖物
    //     map.addOverlay(ply);  //添加覆盖物
    //     var pointArray = ply.getPath();
    //     map.setViewport(pointArray);
    //     return;
    // }

    //从百度获取行政区域坐标数据
    bdary.get(root.name, function (rs) {       //获取行政区域
        var count = rs.boundaries.length; //行政区域的点有多少个
        if (count === 0) {
            return;
        }

        //--------删除外部区域--------------
        //for循环都删除掉了，只剩下这个
        //网上查了下，东西经南北纬的范围
        var EN_JW = "180, 90;";         //东北角
        var NW_JW = "-180,  90;";       //西北角
        var WS_JW = "-180, -90;";       //西南角
        var SE_JW = "180, -90;";        //东南角
        //4.添加环形遮罩层
        var ply1 = new BMap.Polygon(rs.boundaries[0] + SE_JW + SE_JW + WS_JW + NW_JW + EN_JW + SE_JW, {
            strokeColor: "none",
            fillColor: "rgb(246,246,246)",
            fillOpacity: 1,
            strokeOpacity: 0.5
        }); //建立多边形覆盖物

        map.addOverlay(ply1);
        //---------------------------------

        //画区域边界
        var pointArray = [];
        for (var i = 0; i < count; i++) {
            var ply = new BMap.Polygon(rs.boundaries[i], {
                strokeWeight: 2,
                strokeColor: blue,
                fillColor: "none",
                fillOpacity: 0.01
            }); //建立多边形覆盖物
            map.addOverlay(ply);  //添加覆盖物
            pointArray = pointArray.concat(ply.getPath());
        }
        map.setViewport(pointArray);    //调整视野
        //保存数据到后台
        //sendData(model.id, "0", "3", rs.boundaries[0]);
    });
};

//绘制子边界，isFill=true,彩色填充
imap.boundary.drawChild = function (map, model, isFill) {
    var fillColor = "none";
    if (isFill) {
        fillColor = imap.util.getRandomColor();
    }
    //如果已经保存过行政区域坐标数据，那么直接加载，不再请求百度
    // if (model.data && model.data.length > 0) {
    //     var points = imap.util.getPointsFromData(model.data);
    //     if (points.length == 0)
    //         return;
    //     var ply = new BMap.Polygon(points, {
    //         strokeWeight: 2,
    //         strokeColor: blue,
    //         fillColor: fillColor,
    //         fillOpacity: 0.4
    //     }); //建立多边形覆盖物
    //     map.addOverlay(ply);
    //
    //     return;
    // }

    //从百度获取行政区域坐标数据
    var bdary = new BMap.Boundary();
    bdary.get(model.name, function (rs) {       //获取行政区域
        var count = rs.boundaries.length; //行政区域的点有多少个
        if (count === 0) {
            return;
        }

        var pointArray = [];
        for (var i = 0; i < count; i++) {
            var ply = new BMap.Polygon(rs.boundaries[i], {
                strokeWeight: 2,
                strokeColor: blue,
                fillColor: fillColor,
                fillOpacity: 0.4
            }); //建立多边形覆盖物
            map.addOverlay(ply);  //添加覆盖物
            pointArray = pointArray.concat(ply.getPath());
        }
        //map.setViewport(pointArray);    //调整视野
        //sendData(model.id, "0", "3", rs.boundaries[0]);

    });
};

//===============地图覆盖物绘制服务==========================
//绘制省市marker--废弃
imap.overlay.drawPMakers = function (map, list, icon, onClick) {
    if (list.length < 0)
        return;

    for (var i = 0; i < list.length; i++) {
        //console.log(list[i]);
        var points = imap.util.getPointsFromData(list[i].odata);

        var myIcon = new BMap.Icon(icon, new BMap.Size(16, 16)); //自定义标志物
        var marker = new BMap.Marker(points[0], {icon: myIcon}); //按照地图点坐标生成标记
        //var marker = new BMap.Marker(points[0]);
        var drawtype = list[i].drawtype;
        var id = list[i].id;
        marker.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(marker);
    }
};
//绘制省市点-以画圆的方式实现无级缩放
imap.overlay.drawPCircles = function (map, list, color, onClick) {
    if (list.length < 0)
        return;

    for (var i = 0; i < list.length; i++) {
        var points = imap.util.getPointsFromData(list[i].odata);
        var circle = new BMap.Circle(points[0], 500, {
            strokeColor: color,
            strokeWeight: 1,
            strokeOpacity: 1,
            strokeStyle: 'solid',
            fillColor: color,
            fillOpacity: 1
        }); //创建圆

        var drawtype = list[i].drawtype;
        var id = list[i].id;
        circle.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(circle);
    }
};

//绘制marker
imap.overlay.drawMakers = function (map, list, icon, onClick) {
    if (list.length < 0)
        return;

    for (var i = 0; i < list.length; i++) {
        //console.log(list[i]);
        var points = imap.util.getPointsFromData(list[i].odata);

        var myIcon = new BMap.Icon(icon, new BMap.Size(24, 24)); //自定义标志物
        var marker = new BMap.Marker(points[0], {icon: myIcon}); //按照地图点坐标生成标记
        //var marker = new BMap.Marker(points[0]);
        var drawtype = list[i].drawtype;
        var id = list[i].id;
        marker.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(marker);
    }
};

//绘制片区外大户marker
imap.overlay.drawOutPeasant = function (map, list, icon0, icon1, icon2, onClick) {

    if (list.length < 0)
        return;

    for (var i = 0; i < list.length; i++) {
        //console.log(list[i]);
        var points = imap.util.getPointsFromData(list[i].odata);

        //0:500-1000，小图标，1:1000-2000中图标，2:2000以上大图标
        var myIcon = new BMap.Icon(icon2, new BMap.Size(16, 16)); //自定义标志物
        if (list[i].icontype === "0") {
            myIcon = new BMap.Icon(icon0, new BMap.Size(8, 8));
        }else if (list[i].icontype === "1") {
            myIcon = new BMap.Icon(icon1, new BMap.Size(12, 12));
        }else if (list[i].icontype === "2") {
            myIcon = new BMap.Icon(icon2, new BMap.Size(16, 16));
        }

        var marker = new BMap.Marker(points[0], {icon: myIcon}); //按照地图点坐标生成标记
        //var marker = new BMap.Marker(points[0]);
        var drawtype = list[i].drawtype;
        var id = list[i].id;
        marker.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(marker);

        //片区外大户按大小统一编号显示
        var centerPoint = points[0];
        var opts = {
            position: centerPoint,    // 指定文本标注所在的地理位置
            offset: new BMap.Size(0, 0)    //设置文本偏移量
        };
        var label = new BMap.Label(i + 1, opts);  // 创建文本标注对象
        label.setStyle({
            border: "0",
            color: "red",
            fontSize: "10px",
            height: "10px",
            lineHeight: "10px"
        });
        map.addOverlay(label);
    }
};

//绘制片区内大户marker
imap.overlay.drawInPeasant = function (map, list, icon0, icon1, icon2, onClick) {

    if (list.length < 0)
        return;

    for (var i = 0; i < list.length; i++) {
        //console.log(list[i]);
        var points = imap.util.getPointsFromData(list[i].odata);
        //0:500-1000，小图标，1:1000-2000中图标，2:2000以上大图标
        var myIcon = new BMap.Icon(icon2, new BMap.Size(16, 16)); //自定义标志物
        if (list[i].icontype === "0") {
            myIcon = new BMap.Icon(icon0, new BMap.Size(8, 8));
        }else if (list[i].icontype === "1") {
            myIcon = new BMap.Icon(icon1, new BMap.Size(12, 12));
        }else if (list[i].icontype === "2") {
            myIcon = new BMap.Icon(icon2, new BMap.Size(16, 16));
        }
        var marker = new BMap.Marker(points[0], {icon: myIcon}); //按照地图点坐标生成标记
        //var marker = new BMap.Marker(points[0]);
        var drawtype = list[i].drawtype;
        var id = list[i].id;
        marker.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(marker);
    }
};

//绘制片区的多边形
imap.overlay.drawPolygons = function (map, list, showlabel, onClick) {
    if (list.length < 0)
        return;

    var color = "green";
    //强筋、弱筋颜色不同

    for (var i = 0; i < list.length; i++) {
        var points = imap.util.getPointsFromData(list[i].odata);
        //console.log(points);
        if (points.length == 0) {
            return;
        }

        var drawtype = list[i].drawtype;
        var id = list[i].id;
        var areano = list[i].areano;
        var specname = list[i].specname;
        var spectype = list[i].spectype;//1强筋/2弱筋
        if (spectype === '2') {
            color = "#D2691E";
        } else {
            color = "green";
        }

        var ply = new BMap.Polygon(points, {
            strokeColor: color,    //边线颜色。
            fillColor: color,      //填充颜色。当参数为空时，圆形将没有填充效果。
            strokeWeight: 3,       //边线的宽度，以像素为单位。
            strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
            fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
            strokeStyle: 'solid' //边线的样式，solid或dashed。
        }); //建立多边形覆盖物

        ply.addEventListener('click', onClick(drawtype, id));
        map.addOverlay(ply);

        if (showlabel) {
            //片区按大小统一编号显示
            var centerPoint = ply.getBounds().getCenter();
            var opts = {
                position: centerPoint,    // 指定文本标注所在的地理位置
                offset: new BMap.Size(0, 0)    //设置文本偏移量
            };
            var label = new BMap.Label(i + 1, opts);  // 创建文本标注对象
            label.setStyle({
                border: "0",
                color: "red",
                fontSize: "10px",
                height: "10px",
                lineHeight: "10px"
            });
            map.addOverlay(label);
        }
    }
};

//===============地图计算服务==========================


//===============地图功能服务==========================
//将"经度,纬度;经度,纬度;经度,纬度;......"这样的字符串转换为百度point数组
imap.util.getPointsFromData = function (data) {
    var points = [];
    var array = data.split(';');
    for (var i = 0; i < array.length; i++) {

        var jw = array[i].split(',');
        var lng = jw[0].trim();
        var lat = jw[1].trim();
        //console.log("lng: |" + lng + "|, lat: |" + lat + "|");
        points[i] = new BMap.Point(lng, lat);
    }

    //console.log(points);
    return points;
};

//随机颜色
imap.util.getRandomColor_old = function () {
    return '#' + Math.floor(Math.random() * 16777215).toString(16);
};

//指定10个颜色随机
imap.util.getRandomColor = function () {
    var i = Math.floor(Math.random() * 10);
    var array = ['#e9f0cb', '#96ca72', '#a3a6b9', '#f7a9ce', '#fff6ab', '#e5f2ca', '#9bb6d7', '#bdddee', '#fce5ed', '#f8c297'];

    if (i < 0)
        i = 0;
    if (i > 9)
        i = 9;
    return array[i];
};