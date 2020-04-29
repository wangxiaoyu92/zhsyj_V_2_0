var trankCount = 0;
var trankStartname = "S";
var trankEndname = "E";
var trankCarID = "car";
var tranklineID = "line";
var stopID = "stop";
var stopcount = 0;
var colorarr = new Array();
colorarr[0] = '0x00CC00';
colorarr[1] = '0x00CC00';
colorarr[2] = '0xFF0000';
colorarr[3] = '0x0033CC';
var TrankpicAgent = true;
var CarImage = "car_";
var stopImage = "Stopsign.png";
var xtImage = "xt.png";
var DoorImage = "menjin.png";
var tempLableID = "tempLB";
var tempMarkimage = "bj_1.png";
var tempMarkID = "tempMarkID";

//------------------------------------------------清空当前所有回放节点---------------------------------------------------------------
function clearall(cliearline) {
    trankCount = 0;
    stopcount = 0;
    var line = getOverlayById("l_tmp");
    mapObj.clearMap();
    if (!cliearline) {
        mapObj.add(line);
    }
}

//------------------------------------------------------------------------检查轨迹是否超出------------------------------------------------
function validate_drowline() {
    if (trankCount >= 3) {
        var result = window.confirm("地图上最多只能保留3条线路，清除线路并回放吗？")
        if (result) {
            clearall(true);
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}

function SetPoint(s_x, s_y, e_x, e_y) {
    trankCount++;
    var s = new AMap.Marker({
        map:mapObj,
        position: [s_x, s_y],
        icon: custormImage + "s" + trankCount + ".gif",
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': trankStartname + trankCount },
        topWhenMouseOver: true
    });
   var e= new AMap.Marker({
       map: mapObj,
       position: [e_x, e_y],
       icon: custormImage + "e" + trankCount + ".gif",
       draggable: false,
       raiseOnDrag: true,
       extData: { 'id': trankEndname + trankCount },
       topWhenMouseOver: true
   });
}

//---------------------------------------------------------------初始化页面标识-----------------------------------------------------------

//初始化页面标识
var markercar;
function InitMarker(x, y, fx, label) {
    markercar = new AMap.Marker({
        map: mapObj,
        position: [x, y],
        icon: custormImage + CarImage + "1.png",
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': trankCarID },
        angle: fx,
        topWhenMouseOver: true
    });
    markercar.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: label
    });
}


function UpdateCar(x, y, labelText, fx) {

    mapObj.remove(markercar);
   
    markercar = new AMap.Marker({
        map: mapObj,
        position: [x, y],
        icon: custormImage + CarImage + "1.png",
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': trankCarID },
        angle: fx,
        topWhenMouseOver: true
    });
    markercar.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: labelText
    });
}

//添加车辆
function CreateCar(x, y, fx) {
    markercar = new AMap.Marker({
        map: mapObj,
        position: [x, y],
        icon: custormImage + CarImage + "1.png",
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': trankCarID },
        angle: fx,
        topWhenMouseOver: true
    });

}





function CreateTempLabel(x, y, text) {
    mapObj.remove(getOverlayById(tempLableID));
    var stopmark = new AMap.Marker({
        position: [x, y],
        icon: custormImage + img,
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': id },
        topWhenMouseOver: true,
        title: labletext
    });
}

//--------------------------------------------------------------显示历史轨迹信息---------------------------------------------------------------
var t_addmarke;
function t_thisaddMarke(x, y) {

    t_addmarke(x, y);
}


function createstopmark(x, y, labletext,addmarke, img, html)
{
    t_addmarke = addmarke;
    var tipOption = "<b>" + labletext + "</b><br/>" + html; //addIMGTip(labletext, html);
    var id = stopID + stopcount;

    var stopmark = new AMap.Marker({
        position: [x, y],
        icon: custormImage + img,
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': id },
        topWhenMouseOver: true,
        title: labletext
    });
    stopmark.content = tipOption;
    AMap.event.addListener(stopmark, 'click', markerClick);
    stopcount++;
    return stopmark;
}
function createStopLabel(x, y, labletext, add, canmarke, addmarke, starttime, endtime) {
    var html = "开始时间：" + starttime + "<br/>结束时间：" + endtime + "<br/>详细地址：" + add;
    var stopmark = createstopmark(x, y, labletext, addmarke, stopImage, html);
    return stopmark;
}

function createStopLabel_xt(x, y, labletext, add, canmarke, addmarke, starttime, endtime) {
    var html = "开始时间：" + starttime + "<br/>结束时间：" + endtime + "<br/>详细地址：" + add;
    var stopmark = createstopmark(x, y, labletext, addmarke, xtImage, html);
    return stopmark;
}
function createStopLabel1(x, y, labletext, add, canmarke, addmarke, starttime, endtime) {
    var html = "开门时间：" + starttime + "<br/>关门时间：" + endtime + "<br/>详细地址：" + add;
    var stopmark = createstopmark(x, y, labletext, addmarke, DoorImage, html);
    return stopmark;
}
//缴费地点
function createStopLabel2(x, y, labletext, addmarke, costTime, costJE, costCH) {
    var html = "缴费时间：" + costTime + "<br/>缴费金额：" + costJE + "<br/>地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点：" + costCH;
    var stopmark = createstopmark(x, y, labletext, addmarke, "20.gif", html);
    return stopmark;
}


function AddStopLabel(x, y, labletext, add, canmarke, addmarke, starttime, endtime) {
    var stopmark = createStopLabel(x, y, labletext, add, canmarke, addmarke, starttime, endtime);
    mapObj.add(stopmark);
}

var line=null;
function drowingline(arrline, fit) {
    if (line != null){
        mapObj.remove(line);
    }
    
    line = new AMap.Polyline({
        path: arrline,          //设置线覆盖物路径
        strokeColor: "#FF3300", //线颜色
        strokeOpacity: 1,       //线透明度
        strokeWeight: 3,        //线宽
        strokeStyle: "solid",  //线样式
        extData: { 'id': "l_tmp" }
    });
    mapObj.add(line);
    
    if (fit) {
        mapObj.setFitView();
    }
}

function drowingpline(arrline) {
    if (line != null) {
        mapObj.remove(line);
    }
     line = new AMap.Polyline({
        path: arrline,          //设置线覆盖物路径
        strokeColor: "#FF3300", //线颜色#FF3300
        strokeOpacity: 1,       //线透明度
        strokeWeight: 3,        //线宽
        strokeStyle: "solid"  //线样式
    });
     mapObj.add(line);
}


//------------------------------------------------------------------------------回放-----------------------------------------------------------

function UpdateTempLabel(x, y, labletext) {

    var lb = mapObj.getOverlayById(tempLableID);
    if (lb != null) {
        lb.lnglat.lngX = x;
        lb.lnglat.latY = y;
        lb.option.content = labletext;
        mapObj.updateOverlay(lb);
    }
    else {
        var labeloption = TranckLabel(labletext, 0x000000);
        var label = new MLabel(new MLngLat(x, y), labeloption);
        label.id = tempLableID; //对象编号，也是对象的唯一标识   
        mapObj.addOverlay(label, false); //向地图添覆盖物
    }

}

var movetimeout = null;
var isremove = true;
function moveMap(p_x, p_y) {
    if (isremove) {
        var bounds = mapObj.getLngLatBounds();
        //    alert(bounds.southWest.lngX + "," + bounds.northEast.lngX + "," + bounds.southWest.latY + "," + bounds.northEast.latY);
        //    alert(x,y);

        var x = parseFloat(p_x);
        var y = parseFloat(p_y);

        if (parseFloat(x) >= bounds.southWest.lngX && x <= bounds.northEast.lngX && y >= bounds.southWest.latY && y <= bounds.northEast.latY) {
            //        alert("1");
            if (movetimeout) {
                clearTimeout(movetimeout);
                clearTimeout = null;
            }
        }
        else {

            if (movetimeout) {
                //            alert("2-1");

                //            clearTimeout(movetimeout);
                //            clearTimeout = null;
            }
            else {
                //            alert("2-2");
                movetimeout = setTimeout(function () { mapObj.panTo(AMap.LngLat(x, y)); movetimeout = null; }, 50);
            }

        }
    }
}

//var bounds = mapObj.getLngLatBounds(); //返回MLngLatBounds类对象，该对象表示地图视野范围矩形区域西南和东北角点的经纬度坐标   
//alert(bounds.southWest.lngX + "," + bounds.southWest.latY + ";" + bounds.northEast.lngX + "," + bounds.northEast.latY);   

function CreateTempMark(x, y, labletext, fx) {
    markercar = new AMap.Marker({
        map: mapObj,
        position: [x, y],
        icon:  custormImage + tempMarkimage,
        draggable: false,
        raiseOnDrag: true,
        extData: { 'id': tempMarkID },
        angle: fx,
        topWhenMouseOver: true
    });
    markercar.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
        content: labletext
    });
}