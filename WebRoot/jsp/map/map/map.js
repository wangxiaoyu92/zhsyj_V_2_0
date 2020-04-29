function getRandomColor() {
    return '#' + Math.floor(Math.random() * 16777215).toString(16);
}
//用于面积计算的js文件
var earthRadiusMeters = 6371000.0; //源码中使用半径为6367460.0;
//var point = new BMap.Point();
var metersPerDegree = 2.0 * Math.PI * earthRadiusMeters / 360.0;
var degreesPerRadian = 180.0 / Math.PI;
var radiansPerDegree = Math.PI / 180.0;
var metersPerKm = 1000.0;
var meters2PerHectare = 10000.0;
var feetPerMeter = 3.2808399;
var feetPerMile = 5280.0;
var acresPerMile2 = 640;

function calculateArea(points) {
    if (points.length > 2) {
        var areaMeters2 = PlanarPolygonAreaMeters2(points);
        //alert(areaMeters2);
        if (areaMeters2 > 1000000.0)
            areaMeters2 = SphericalPolygonAreaMeters2(points);
        return Areas(areaMeters2.toFixed(2));
    }

    return 0;
}

function Areas(areaMeters2) {
    //alert(areaMeters2);
    var areaHectares = areaMeters2 / meters2PerHectare;
    var areaKm2 = areaMeters2 / metersPerKm / metersPerKm;
    var areaFeet2 = areaMeters2 * feetPerMeter * feetPerMeter;
    var areaMiles2 = areaFeet2 / feetPerMile / feetPerMile;
    var areaAcres = areaMiles2 * acresPerMile2;
    //return areaMeters2.toPrecision(4)+' m&sup2; / '+areaHectares.toPrecision(4)+' hectares / '+areaKm2.toPrecision(4)+' km&sup2; / '+areaFeet2.toPrecision(4)+' ft&sup2; / '+areaAcres.toPrecision(4)+' acres / '+areaMiles2.toPrecision(4)+' mile&sup2;';}
    var area = (areaMeters2 / 666.6667).toFixed(2) + ', ' + areaMeters2 + ' m&sup2(平方米);  <br/>  ' + areaHectares.toFixed(4) + ' hectares(公顷)  <br/>  ' + areaKm2.toFixed(4) + ' km&sup2(平方公里);<br />'
        + areaFeet2.toFixed(2) + ' ft&sup2(平方英尺);  <br/>  ' + areaAcres.toFixed(4) + ' acres(英亩)  <br/>  ' + areaMiles2.toFixed(4) + ' mile&sup2(平方英里);';

    var area = (areaMeters2 / 666.6667).toFixed(2);
    return area;
}
function PlanarPolygonAreaMeters2(points) {
    var a = 0.0;

    for (var i = 0; i < points.length; ++i) {
        var j = (i + 1) % points.length;
        var xi = points[i].lng * metersPerDegree * Math.cos(points[i].lat * radiansPerDegree);
        var yi = points[i].lat * metersPerDegree;
        var xj = points[j].lng * metersPerDegree * Math.cos(points[j].lat * radiansPerDegree);
        var yj = points[j].lat * metersPerDegree;

        //alert(points[i].lng+","+points[i].lat);

        a += xi * yj - xj * yi;
    }
    //alert(a);
    return Math.abs(a / 2.0);
}
function SphericalPolygonAreaMeters2(points) {
    var totalAngle = 0.0;

    for (i = 0; i < points.length; ++i) {
        var j = (i + 1) % points.length;
        var k = (i + 2) % points.length;
        //alert(i+","+j+","+k);
        totalAngle += Angle(points[i], points[j], points[k]);
        // alert(i);
    }
    var planarTotalAngle = (points.length - 2) * 180.0;
    var sphericalExcess = totalAngle - planarTotalAngle;
    if (sphericalExcess > 420.0) {
        totalAngle = points.length * 360.0 - totalAngle;
        sphericalExcess = totalAngle - planarTotalAngle;
    }
    else if (sphericalExcess > 300.0 && sphericalExcess < 420.0) {
        sphericalExcess = Math.abs(360.0 - sphericalExcess);
    }
    return sphericalExcess * radiansPerDegree * earthRadiusMeters * earthRadiusMeters;

}
function Angle(p1, p2, p3) {
    var bearing21 = Bearing(p2, p1);
    //alert("jjj"+bearing21);
    var bearing23 = Bearing(p2, p3);
    var angle = bearing21 - bearing23;
    if (angle < 0.0) angle += 360.0;
    return angle;
}

function Bearing(from, to) {
    var lat1 = from.lat * radiansPerDegree;
    var lon1 = from.lng * radiansPerDegree;
    var lat2 = to.lat * radiansPerDegree;
    var lon2 = to.lng * radiansPerDegree;
    var angle = -Math.atan2(Math.sin(lon1 - lon2) * Math.cos(lat2), Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(lon1 - lon2));
    if (angle < 0.0) angle += Math.PI * 2.0;
    angle = angle * degreesPerRadian;
    return angle;
}


