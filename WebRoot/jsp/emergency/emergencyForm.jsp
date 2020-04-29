<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
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
        window.onload = function () {
            mapInit("mapContainer", zxdjdzb, zxdwdzb, 12);//根据中心点坐标定位地图
            addBeiJing(zxdcity);
        }
        //地理编码
        function geocoder(address) {
            mapObj.clearMap();  // 清除地图覆盖物
            var MGeocoder;
            //加载服务
            AMap.service(["AMap.Geocoder"], function () {
                //地理编码插件
                MGeocoder = new AMap.Geocoder({
                    radius: 1000,
                    extensions: "all"
                });
                MGeocoder.getLocation(address, function (status, result) {
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
                        addMarker(lng, lat, address, title, content);
                        //mapObj.setFitView();
                        //mapObj.setZoomAndCenter(14, [lng,lat]);
                        mapObj.panTo([lng, lat]);
                    }
                });
            });
        }

        //逆地理编码
        function geocoderY(lng, lat) {
            if (lng != "" && lat != "") {
                //已知点坐标
                var lnglatXY = new AMap.LngLat(lng, lat);
                var MGeocoder;
                //加载服务
                AMap.service(["AMap.Geocoder"], function () {
                    //地理编码插件
                    MGeocoder = new AMap.Geocoder({
                        radius: 1000,
                        extensions: "all"
                    });
                    MGeocoder.getAddress(lnglatXY, function (status, result) {
                        if (status === 'complete') {
                            var regeocode = result.regeocode;
                            var address = regeocode.formattedAddress;
                            var title = "突发事件";
                            var content = [];
                            content.push("地址：" + address);
                            addMarker(lng, lat, address, title, content);
                            //mapObj.setFitView();
                            //mapObj.setZoomAndCenter(14, [lng,lat]);
                            mapObj.panTo([lng, lat]);
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
                mapObj.plugin(["AMap.MarkerClusterer"], function () {
                    cluster = new AMap.MarkerClusterer(mapObj, markers, {
                        styles: sts
                    });
                });
            } else {
                mapObj.plugin(["AMap.MarkerClusterer"], function () {
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
                addMarker(lng, lat, address, title, content);
            }
            addCluster(0);
            mapObj.setFitView();
        }

        //添加marker标记
        function addMarker(lng, lat, address, title, content) {
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
            AMap.event.addListener(marker, 'mouseover', function () {
                infoWindow.open(mapObj, marker.getPosition());
            });
            //mapObj.setFitView();
        }
        //下拉列表
        var eventlevel = <%=SysmanageUtil.getAa10toJsonArray("EVENTLEVEL")%>;
        var eventstate = <%=SysmanageUtil.getAa10toJsonArray("EVENTSTATE")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                var laydate = layui.laydate;
                var url = basePath + '/emergency/saveEmergency';
                intSelectData("eventlevel", eventlevel);
                intSelectData("eventstate", eventstate);
                form.render();
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                //自定义验证规则
                form.verify({
                    eventfinder: function (value, item) { //value：表单的值、item：表单的DOM对象
                        debugger
                        if (!new RegExp(/^1[3|4|5|8][0-9]\d{4,8}$/).test(value) && !new RegExp("^(0[0-9]{2,3}/-)?([2-9][0-9]{6,7})+(/-[0-9]{1,4})?$").test(value)) {
                            return '电话号码或者手机号码格式不正确';
                        }
                    }
                });
                if ($('#eventid').val()) {
                    $.post(basePath + '/emergency/queryEmergencyDTO', {
                        eventid: $('#eventid').val()
                    }, function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            $('form').form('load', mydata);
                            form.render();
                            var lng = $('#jdzb').val();
                            var lat = $('#wdzb').val();
                            geocoderY(lng, lat);
                        } else {
                            layer.open({
                                title: "提示",
                                content: "查询失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#btn_dtdw').css('display', 'none');
                        $('#eventstate').attr('disabled', true);
                        $('#eventlevel').attr('disabled', true);
                        $('#eventdate').attr('disabled', true);
                        $('#btn_xzya').css('display', 'none');

                    }
                }
                laydate.render({
                    elem: '#eventdate'
                    , type: 'datetime'
                });
            });


        });
        // 保存
        var submitForm = function () {
            if ($("#eventfinder").val()) {
                $("#eventfinder").attr("lay-verify", "eventfinder");
            }
            $("#saveEmergencyBtn").click();
        };

        // 关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        // 地点定位
        var geocoders = function () {
            if ($('#eventaddress').val() == null || $('#eventaddress').val() == '') {
                layer.alert('请选择所属地区');
                return false;
            }
            var address = $('#eventaddress').val();
            geocoder(address);
        }
        //选择预案
        function getYuan() {
            parent.sy.modalDialog({
                title: '预案信息'
                , area: ['100%', '100%']
                , content: basePath + 'emergency/selectyaxxIndex'
                , btn: ['确定','取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return
                }
                if (obj.type == "ok") {
                    $("#newsid").val(obj.data.newsid);
                }
            });
        }
        function showMenu_aaa027() {
            if ('<%=op%>' == 'view') {
                return;
            }
            sy.modalDialog({
                title: '选择地区'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectAaa027.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#aaa027').val(k.aaa027);
                    $('#aaa027name').val(k.aaa027name);
                    $('#eventaddress').val(k.aab301);
                }
                sy.removeWinRet(dialogID);
            });
        }
    </script>
</head>
<form class="layui-form" action="" id="fm">
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;">
                <nobr>事件登记ID:</nobr>
            </td>
            <td>
                <input type="text" id="eventid" name="eventid" readonly value="<%=v_eventid%>"
                       class="layui-input layui-bg-gray">
            </td>
            <td style="text-align:right;">
                <nobr> 事件发生时间:</nobr>
            </td>
            <td>
                <input type="text" name="eventdate" id="eventdate" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>事件等级:</nobr>
            </td>
            <td>
                <select id="eventlevel" name="eventlevel"></select>
            </td>
            <td style="text-align:right;">
                <nobr>事件处理状态:</nobr>
            </td>
            <td>
                <select id="eventstate" name="eventstate"></select>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>事件上报人:</nobr>
            </td>
            <td>
                <input type="text" name="newsinitiator" id="newsinitiator" class="layui-input">
            </td>
            <td style="text-align:right;">
                <nobr>上报人联系方式:</nobr>
            </td>
            <td>
                <input type="text" name="eventfinder" id="eventfinder" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">事件内容:</td>
            <td colspan="3">
                <textarea class="layui-textarea" id="eventcontent" name="eventcontent" rows="5"></textarea>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>所属地区:</td>
            <td>
                <input name="aaa027name" id="aaa027name" style="width: 200px; " onclick="showMenu_aaa027();"
                       readonly="readonly" class="layui-input" lay-verify="required"/>
                <input name="aaa027" id="aaa027" type="hidden"/>

                <div id="menuContent_aaa027" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
                    <div class="layui-side-scroll" style="width:250px;">
                        <ul id="treeDemo_aaa027" class="ztree"></ul>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>事件发生地点:</nobr>
            </td>
            <td colspan="2"><input name="eventaddress" id="eventaddress" class="layui-input" readonly="readonly"/></td>
            <td>
                <a href="javascript:void(0)" class="layui-btn" id="btn_dtdw"
                   iconCls="icon-search" onclick="geocoders()"> 地图定位 </a>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>预案信息编号:</nobr>
            </td>
            <td colspan="2"><input name="newsid" id="newsid" class="layui-input" readonly="readonly"/></td>
            <td>
                <a href="javascript:void(0)" class="layui-btn" id="btn_xzya"
                   iconCls="icon-search" onclick="getYuan()"> 选择预案 </a>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>经度坐标:</td>
            <td><input name="eventjdzb" id="jdzb" class="layui-input" lay-verify="required" readonly/></td>
            <td style="text-align:right;"><font class="myred">*</font>纬度坐标:</td>
            <td><input name="eventwdzb" id="wdzb" class="layui-input" lay-verify="required" readonly/></td>
        </tr>
        <tr>
            <td style="text-align:right;">地图信息:</td>
            <td colspan="3">
                <div id="mapContainer" style="width:98%;height:600px;border:#ccc solid 2px;">
                    &nbsp;
                </div>
                <div id="result"></div>
                <div id="result1"></div>
            </td>
        </tr>
    </table>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save" id="saveEmergencyBtn">保存
            </button>
        </div>
    </div>
</form>
</body>
</html>