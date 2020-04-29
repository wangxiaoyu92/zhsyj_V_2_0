<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
%>
<!DOCTYPE html>
<html>
<head>

    <title>选择承办人</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId1 = '';
        var selectNodes1;
        var ajcbrTableData;// 承办人表
        var selectTableDataId2 = '';
        var selectNodes2;
        var ajxbrTableData;// 协办人表
        var selectTableDataId3 = '';
        var selectNodes3;
        var ajqtryTableData// 其他相关人员表
        $(function () {
            layui.use(['form', 'table', 'element', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#ajcbr'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'zfryxm', width: 150, title: '姓名', event: 'trclick1'}
                        , {field: 'zfrybmmc', width: 250, title: '所属部门', event: 'trclick1'}
                    ]]
                });
                // 监听工具条
                table.on('tool(ajcbrFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick1') { // 选中行
                        if (selectTableDataId1 != data.userid) {
                            // 清除所有行的样式
                            $($("#ajcbr").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#ajcbr").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.userid;
                        } else { // 再次选中清除样式
                            $("#ajcbr").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    }
                });
                table.render({
                    elem: '#ajxbr'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'zfryxm', width: 150, title: '姓名', event: 'trclick2'}
                        , {field: 'zfrybmmc', width: 250, title: '所属部门', event: 'trclick2'}
                    ]]
                });
                // 监听工具条
                table.on('tool(ajxbrFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.userid) {
                            // 清除所有行的样式
                            $($("#ajxbr").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#ajxbr").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData2 = data;
                            selectTableDataId2 = data.userid;
                        } else { // 再次选中清除样式
                            $("#ajxbr").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });
                table.render({
                    elem: '#ajqtry'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'zfryxm', width: 150, title: '姓名', event: 'trclick3'}
                        , {field: 'zfrybmmc', width: 250, title: '所属部门', event: 'trclick3'}]]
                });
                // 监听工具条
                table.on('tool(ajqtryFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick3') { // 选中行
                        if (selectTableDataId3 != data.userid) {
                            // 清除所有行的样式
                            $($("#ajqtry").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#ajqtry").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData3 = data;
                            selectTableDataId3 = data.userid;
                        } else { // 再次选中清除样式
                            $("#ajqtry").next().find(obj.tr.selector).attr("style", "");
                            table.singleData3 = '';
                            selectTableDataId3 = '';
                        }
                    }
                });
                form.on('submit(save)', function (data) {
                    var url = basePath + '/zfba/ajdj/saveAjdjCbr';
/*  gu20180630                  if (ajcbrTableData.length < 1 && ajxbrTableData.length < 1 && ajxbrTableData.length < 1) {
                        layer.alert('请选择承办人');
                        return false;
                    }*/
                    var ajcbr_table_rows = $.toJSON(ajcbrTableData);
                    var ajxbr_table_rows = $.toJSON(ajxbrTableData);
                    var ajqtry_table_rows = $.toJSON(ajqtryTableData);
                    var ajdjid = $('#ajdjid').val();
                    var param = {
                        ajcbr_table_rows: ajcbr_table_rows,
                        ajxbr_table_rows: ajxbr_table_rows,
                        ajqtry_table_rows: ajqtry_table_rows,
                        ajdjid: ajdjid
                    }
                    $.post(url, param, function (result) {
//                            result = $.parseJSON(result);
                            if (result.code == '0') {
                                layer.msg('保存成功', {time: 1000}, function () {
                                    var obj = new Object();
                                    obj.a = ajcbrTableData;
                                    obj.b=ajxbrTableData;
                                    sy.setWinRet(obj);
                                    //gu20180704 window.location.reload();
                                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                                });
                            } else {
                                layer.open({
                                    title: '提示'
                                    , content: '保存失败' + result.msg
                                });
                            }
                        },
                        'json');
//                    var formData = data.field;
//                    $.post(url, formData, function (result) {
//                        result = $.parseJSON(result);
//                        if (result.code == '0') {
//                            layer.msg('保存成功', {time: 500}, function () {
//                                var obj = new Object();
//                                obj.type = "ok";
//                                sy.setWinRet(obj);
//                                closeWindow();
//                            });
//                        } else {
//                            layer.open({
//                                title: '提示'
//                                , content: '保存失败' + result.msg
//                            });
//                        }
//                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                querySupervisionItem();
                var $ = layui.$, active = {
                    addAjcbr: function () { // 添加承办员
                        addAjcbr();
                    }
                    , addAjxbr: function () { // 添加协办员
                        addAjxbr();
                    }
                    , addAjqtry: function () {   //添加其他人员
                        addAjqtry();
                    }
                    , delAjcbr: function () { // 删除承办员
                        if (!table.singleData1) {
                            layer.alert('请选择要删除项！');
                        } else {
                            mydatagrid_remove(table.singleData1.userid, 'ajcbr');
                        }
                    }
                    , delAjxbr: function () { // 删除承办员
                        if (!table.singleData2) {
                            layer.alert('请选择要删除项！');
                        } else {
                            mydatagrid_remove(table.singleData2.userid, 'ajxbr');
                        }
                    }
                    , delAjqtry: function () { // 删除承办员
                        if (!table.singleData3) {
                            layer.alert('请选择要删除项！');
                        } else {
                            mydatagrid_remove(table.singleData3.userid, 'ajqtry');
                        }
                    }
                };
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        });
        // 保存
         function submit() {
            $("#saveAjdjBtn").click();
        };
        function querySupervisionItem() {
            // 检查承办员
            var url = basePath + '/zfba/ajdj/queryAjdjCbr';
            var param = {
                ajdjid: '<%=v_ajdjid%>',
                zfrysflx: '1'
            }
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    ajcbrTableData = result.rows;
                    table.reload('ajcbr', {data: ajcbrTableData});
                }
            }, 'json');

            // 检查协办员
            /* url = basePath + '/zfba/ajdj/queryAjdjCbr';*/
            param = {
                ajdjid: '<%=v_ajdjid%>',
                zfrysflx: '2'
            }
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    ajxbrTableData = result.rows;
                    table.reload('ajxbr', {data: ajxbrTableData});
                }
            }, 'json');
            // 检查其他人员
            /*  url = basePath + '/zfba/ajdj/queryAjdjCbr';*/
            param = {
                ajdjid: '<%=v_ajdjid%>',
                zfrysflx: '3'
            }
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    ajqtryTableData = result.rows;
                    table.reload('ajqtry', {data: ajqtryTableData});
                }
            }, 'json');
        }
        // 添加承办人
        function addAjcbr() {
            /*alert(111);*/
            var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                ,offset:["2px","2px"]
                , type: 2
                , title: '添加承办员'
                , content: url
                , param: {
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback1);
        }
        function closeModalDialogCallback1(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if(obj == null || obj == ''){
                return;
            }
            if (obj.type == "ok") {

                var retData = obj.data;
                var a = [];
                for (var i = 0; i < retData.length; i++) {
                    a.push({
                        'userid': retData[i].userid,
                        'zfryxm': retData[i].username,
                        'zfrybmmc': retData[i].orgname
                    });
                }
                var loadData = ajcbrTableData.concat(a); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < a.length; i++) {
                    for (var j = 0; j < ajcbrTableData.length; j++) {
                        if (a[i].userid == ajcbrTableData[j].userid) {
                            loadData.remove(a[i]); // 去除重复的数据
                        }
                    }
                }
                ajcbrTableData = loadData;
                table.reload('ajcbr', {data: loadData});
            }
        }

        // 添加协办人
        function addAjxbr() {
            var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                ,offset:["2px","2px"]
                , type: 2
                , title: '添加协办员'
                , content: url
                , param: {
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback2);
        }
        function closeModalDialogCallback2(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if(obj == null || obj == ''){
                return;
            }
            if (obj.type == "ok") {
                var retData = obj.data;
                var a = [];
                for (var i = 0; i < retData.length; i++) {
                    a.push({
                        'userid': retData[i].userid,
                        'zfryxm': retData[i].username,
                        'zfrybmmc': retData[i].orgname
                    });
                }
                var loadData = ajxbrTableData.concat(a); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < a.length; i++) {
                    for (var j = 0; j < ajxbrTableData.length; j++) {
                        if (a[i].userid == ajxbrTableData[j].userid) {
                            loadData.remove(a[i]); // 去除重复的数据
                        }
                    }
                }
                ajxbrTableData = loadData;
                table.reload('ajxbr', {data: loadData});
            }
        }

        // 添加其他人员
        function addAjqtry() {
            var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                ,offset:["2px","2px"]
                , type: 2
                , title: '添加协办员'
                , content: url
                , param: {
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback3);
        }
        function closeModalDialogCallback3(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if(obj == null || obj == ''){
                return;
            }
            if (obj.type == "ok") {
                var retData = obj.data;
                var a = [];
                for (var i = 0; i < retData.length; i++) {
                    a.push({
                        'userid': retData[i].userid,
                        'zfryxm': retData[i].username,
                        'zfrybmmc': retData[i].orgname
                    });
                }
                var loadData = ajqtryTableData.concat(a); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < a.length; i++) {
                    for (var j = 0; j < ajqtryTableData.length; j++) {
                        if (a[i].userid == ajqtryTableData[j].userid) {
                            loadData.remove(a[i]); // 去除重复的数据
                        }
                    }
                }
                ajqtryTableData = loadData;
                table.reload('ajqtry', {data: loadData});
            }
        }
        function mydatagrid_remove(userid, type) {
            if (type == 'ajcbr') {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除吗?'
                    , btn1: function (index, layero) {
                        var i = ajcbrTableData.length;
                        for (var j = 0; j < ajcbrTableData.length; j++) {
                            if (userid == ajcbrTableData[j].userid) {
                                ajcbrTableData.remove(ajcbrTableData[j]); // 去除数据
                            }
                        }
                        if (ajcbrTableData.length < i) {
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                            //本页的值
                            var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                            layer.msg('删除成功', {time: 500}, function () {
                                if (table.cache.ajcbr.length == 1) {
                                    curent = curent - 1;
                                }
                                table.reload('ajcbr', {
                                    data: ajcbrTableData
                                    ,page: {
                                        curr: curent //重新从第 1 页开始
                                    }
                                });
                            })
                        } else {
                            layer.msg('删除失败', {time: 500});
                        }

                    }
                })
            } else if (type == 'ajxbr') {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除该人员吗?'
                    , btn1: function (index, layero) {
                        var i = ajxbrTableData.length;
                        for (var j = 0; j < ajxbrTableData.length; j++) {
                            if (userid == ajxbrTableData[j].userid) {
                                ajxbrTableData.remove(ajxbrTableData[j]); // 去除数据
                            }
                        }
                        if (ajxbrTableData.length < i) {
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                            //本页的值
                            var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                            layer.msg('删除成功', {time: 500}, function () {
                                if (table.cache.ajcbr.length == 1) {
                                    curent = curent - 1;
                                }
                                table.reload('ajxbr', {
                                    data: ajxbrTableData
                                    ,page: {
                                        curr: curent //重新从第 1 页开始
                                    }
                                });
                            })
                        } else {
                            layer.msg('删除失败', {time: 500})
                        }

                    }
                })
            } else if (type == 'ajqtry') {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除该人员吗?'
                    , btn1: function (index, layero) {
                        var i = ajqtryTableData.length;
                        for (var j = 0; j < ajqtryTableData.length; j++) {
                            if (userid == ajqtryTableData[j].userid) {
                                ajqtryTableData.remove(ajqtryTableData[j]); // 去除数据
                            }
                        }
                        if (ajqtryTableData.length < i) {
                            table.singleData3 = '';
                            selectTableDataId3 = '';
                            //本页的值
                            var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                            layer.msg('删除成功', {time: 500}, function () {
                                if (table.cache.ajqtry.length == 1) {
                                    curent = curent - 1;
                                }
                                table.reload('ajqtry', {
                                    data: ajqtryTableData
                                    ,page: {
                                        curr: curent //重新从第 1 页开始
                                    }
                                });
                            })
                        } else {
                            layer.msg('删除失败', {time: 500})
                        }

                    }
                })
            }
        }

        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-table">
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        <div class="layui-container">
            <div class="layui-row">
                <div class="layui-col-md4">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">案件承办人</h2>

                            <div class="layui-colla-content layui-show">
                                <div class="layui-btn-group demoTable">
                                    <ck:permission biz="addAjcbr">
                                        <button class="layui-btn" data-type="addAjcbr"
                                                data="btn_addAjcbr">选择承办人
                                        </button>
                                    </ck:permission>
                                    <ck:permission biz="delAjcbr">
                                        <button class="layui-btn layui-btn-danger" data-type="delAjcbr"
                                                data="btn_delAjcbr">删除
                                        </button>
                                    </ck:permission>
                                </div>
                                <table class="layui-hide" id="ajcbr" lay-filter="ajcbrFilter"></table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">案件协办人</h2>

                            <div class="layui-colla-content layui-show">
                                <div class="layui-btn-group demoTable">
                                    <ck:permission biz="addAjxbr">
                                        <button class="layui-btn" data-type="addAjxbr"
                                                data="btn_addAjxbr">选择协办人
                                        </button>
                                    </ck:permission>
                                    <ck:permission biz="delAjxbr">
                                        <button class="layui-btn layui-btn-danger" data-type="delAjxbr"
                                                data="btn_delAjxbr">删除
                                        </button>
                                    </ck:permission>
                                </div>
                                <table class="layui-hide" id="ajxbr" lay-filter="ajxbrFilter"></table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">案件其他相关人员</h2>

                            <div class="layui-colla-content layui-show">
                                <div class="layui-btn-group demoTable">
                                    <ck:permission biz="addAjqtry">
                                        <button class="layui-btn" data-type="addAjqtry"
                                                data="btn_addAjqtry">选择其他相关人员
                                        </button>
                                    </ck:permission>
                                    <ck:permission biz="delAjqtry">
                                        <button class="layui-btn layui-btn-danger" data-type="delAjqtry"
                                                data="btn_delAjqtry">删除
                                        </button>
                                    </ck:permission>
                                </div>
                                <table class="layui-hide" id="ajqtry" lay-filter="ajqtryFilter"></table>
                                <div class="layui-form-item" style="display: none">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>