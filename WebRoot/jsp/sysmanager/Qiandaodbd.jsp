<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String v_userid = StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>签到点绑定页面</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var layer; // 弹出层
        var unBindTableData = []; // 未绑定表格数据
        var bindTableData = []; // 已绑定表格数据
        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                // 已授权角色列表
                table.render({
                    elem: '#unBindTable'
                    , data: unBindTableData
                    , page: false // 展示分页
                    , height: 450 // 容器高度
                    , cols: [[
                        {field: 'qddmc', title: '签到点名称', event: 'trclick'}
                        , {field: 'qddyxjl', title: '有效距离', event: 'trclick'}
                        , {field: 'qdddz', title: '地址', event: 'trclick'}
                    ]]
                });
                table.render({
                    elem: '#bindTable'
                    , data: bindTableData
                    , page: false // 展示分页
                    , height: 450 // 容器高度
                    , cols: [[
                        {field: 'qddmc', title: '签到点名称', event: 'trclick'}
                        , {field: 'qddyxjl', title: '有效距离', event: 'trclick'}
                        , {field: 'qdddz', title: '地址', event: 'trclick'}
                    ]]
                });
                element.init();
                // 监听点击事件
                table.on('tool(unBindFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        for (var i = 0; i < unBindTableData.length; i++) {
                            if (unBindTableData[i].qddszid == data.qddszid) {
                                unBindTableData = unBindTableData.remove(unBindTableData[i]);
                            }
                        }
                        bindTableData = bindTableData.concat(data);
                        reloadTable();
                    }
                });
                // 监听点击事件
                table.on('tool(bindFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        for (var i = 0; i < bindTableData.length; i++) {
                            if (bindTableData[i].qddszid == data.qddszid) {
                                bindTableData = bindTableData.remove(bindTableData[i]);
                            }
                        }
                        unBindTableData = unBindTableData.concat(data);
                        reloadTable();
                    }
                });
                getTableData();
            });

        });
        function getTableData() {
            // 获取已绑定表格数据
            var param = {userid: $("#userid").val(), aae100: '0'};
            $.post(basePath + 'sysmanager/sysuser/Queryqddczybd',
                    param, function (result) {
                        if (result.code == '0') {
                            var datay = result.rows;
                            param = {userid: $("#userid").val(), aae100: '1'};
                            // 获取未绑定表格数据
                            $.post(basePath + 'sysmanager/sysuser/Queryqddsz',
                                    param, function (result) {
                                        if (result.code == '0') {
                                            var dataw = result.rows;
                                            for (var i = 0; i < datay.length; i++) {
                                                for (var j = 0; j < dataw.length; j++) {
                                                    if (datay[i].qddszid == dataw[j].qddszid) {
                                                        dataw.splice(j, 1);
                                                    }
                                                }
                                            }
                                            table.reload('bindTable', {data: datay});
                                            unBindTableData = dataw;
                                            table.reload('unBindTable', {data: unBindTableData});
                                        }
                                    }, 'json');
                        }
                    }, 'json');


        }
        function reloadTable() {
            table.reload('unBindTable', {data: unBindTableData});
            table.reload('bindTable', {data: bindTableData});
        }

        var submitForm = function () {
            var succJsonStr = $.toJSON(bindTableData);
            $.ajax({
                cache: true,
                type: "POST",
                url: basePath + '/sysmanager/sysuser/Saveqddczybd',
                data: {succes: succJsonStr, userid: $("#userid").val()},
                async: false,
                error: function (request) {
                    layer.open({
                        title: "提示",
                        content: '操作失败：' + result.msg
                    });
                },
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg('操作成功！', {time: 500}, function () {
                            var obj = new Object();
                            obj.type = "ok";
                            sy.setWinRet(obj);
                            closeWindow();
                        });
                    } else {
                        layer.open({
                            title: "提示",
                            content: '操作失败：' + result.msg
                        });
                    }
                }
            });
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>

</head>

<body>
<div class="layui-container">
    <div class="layui-row">
        <input type="hidden" id="userid" name="userid" value="<%=v_userid%>">

        <div class="layui-tab-item layui-show">
            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                <div class="grid-demo">
                    <table id="unBindTable" lay-filter="unBindFilter"></table>
                </div>
            </div>
            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                <div class="grid-demo">
                    <table id="bindTable" lay-filter="bindFilter"></table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>