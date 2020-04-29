

function AddressSimpleinObj(onback, x, y)
{
    AMap.service('AMap.Geocoder', function () {//回调函数
        var geocoder = new AMap.Geocoder({});        //实例化Geocoder
        var lnglatXY = [x, y];//地图上所标点的坐标
        geocoder.getAddress(lnglatXY,onback);
    })
}


//function AddressSimpleinObj(onback, x, y)
//{
//    var mls =new MReGeoCodeSearch();
//    var mlsp= new MReGeoCodeSearchOptions();
//    mls.setCallbackFunction(onback);
//    mls.poiToAddressSimple(new MLngLat(x,y),mlsp);
//}
//function routeSearch(arr, onback) {
//    var mrs = new MRouteSearch();
//    var opt = new MRouteSearchOptions();
//    opt.per = 150; //抽稀函数，表示在地图上画导航路径的关键点的个数,默认为150 
//    opt.routeType = 0; //路径计算规则,0表示速度优先（默认） 
//    var multiXY = new MLngLats(arr);
//    mrs.setCallbackFunction(onback);
//    mrs.routeSearchByMultiPoi(multiXY, opt);
//}