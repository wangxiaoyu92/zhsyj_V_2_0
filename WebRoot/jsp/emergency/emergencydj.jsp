<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>突发事件登记管理</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUi" value="true"></jsp:param>
    </jsp:include>
    <script type="text/javascript">
        //下拉列表
        var eventlevel = <%=SysmanageUtil.getAa10toJsonArray("EVENTLEVEL")%>;
        var eventstate = <%=SysmanageUtil.getAa10toJsonArray("EVENTSTATE")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                intSelectData("eventlevel", eventlevel);
                intSelectData("eventstate", eventstate);
                form.render();
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/emergency/queryEmergency'
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
                        {field: 'eventid', width: 250, title: '突发事件ID', event: 'trclick'}
                        , {field: 'newsid', width: 150, title: '预案信息编号', event: 'trclick'}
                        , {field: 'eventcontent', width: 150, title: '事件内容', event: 'trclick'}
                        , {field: 'eventaddress', width: 200, title: '事件发生地点', event: 'trclick'}
                        , {field: 'eventdate', width: 150, title: '事件发生时间', event: 'trclick'}
                        , {
                            field: 'eventlevel', width: 100, title: '事件等级'
                            , templet: function (d) {
                                return sy.formatGridCode(eventlevel, d.eventlevel);
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'eventstate', width: 120, title: '事件处理状态'
                            , templet: function (d) {
                                return sy.formatGridCode(eventstate, d.eventstate);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'newsinitiator', width: 100, title: '事件上报人', event: 'trclick'}
                        , {field: 'eventfinder', width: 100, title: '上报人联系方式', event: 'trclick'}
                        , {field: 'operateperson', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'operatedate', width: 150, title: '经办时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(EmergencyFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.eventid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.eventid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addEmergency: function () { // 添加
                        addEmergency();
                    }
                    , updateEmergency: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的突发事件登录记录！');
                        } else {
                            updateEmergency(table.singleData.eventid);
                        }
                    }
                    , delEmergency: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的突发事件登录记录！');
                        } else {
                            delEmergency(table.singleData.eventid);
                        }
                    }
                    , showEmergency: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要查看的突发事件登录记录');
                        } else {
                            showEmergency(table.singleData.eventid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            $("#btn_query").click(function () {
                query();
                return false;
            })
        });
        // 新增
        var addEmergency = function () {
            sy.modalDialog({
                title: '新增'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }

        // 编辑突发事件登记信息
        function updateEmergency(eventid) {
            sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyFormIndex?op=edit&&eventid=' + eventid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        ;

        // 查看突发事件登记信息
        function showEmergency(eventid) {
            sy.modalDialog({
                title: '查看'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyFormIndex?op=view&eventid=' + eventid
                , btn: ['关闭']
            });
        }
        ;

        // 删除突发事件登记信息
        function delEmergency(eventid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/emergency/delEmergency', {
                                eventid: eventid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.table.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
        // 查询
        function query() {
            var param = {
                'newsid': $('#yaxxbh').val(),
                'eventlevel': $('#eventlevel').val(),
                'eventstate': $('#eventstate').val()
            };
            refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/emergency/queryEmergency'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            /*    parent.window.refresh();*/
        }
        // 从预案信息表中读取
        function myselectyaxx() {
            sy.modalDialog({
                title: '预案信息'
                , area: ['100%', '100%']
                , content: basePath + 'emergency/selectyaxxIndex'
                , btn: ['确定','取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return
                }
                if (obj.type == "ok") {
                    $("#yaxxbh").val(obj.data.newsid);
                }
            });
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">预案信息编号:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="yaxxbh" name="yaxxbh" readonly
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectyaxx()">选择预案信息 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">事件等级:</label>

                                    <div class="layui-input-inline">
                                        <select id="eventlevel" name="eventlevel"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">事件处理状态:</label>

                                    <div class="layui-input-inline">
                                        <select id="eventstate" name="eventstate"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <fieldset class="layui-elem-field site-demo-button" style="border: none;">
                                            <div>
                                                <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                                    <i class="layui-icon">&#xe615;</i>搜索
                                                </button>
                                                <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                        id="btn_reset">
                                                    <i class="layui-icon">&#xe621;</i>重置
                                                </button>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addEmergency">
                <button class="layui-btn" data-type="addEmergency" data="btn_addEmergency">增加</button>
            </ck:permission>
            <ck:permission biz="updateEmergency">
                <button class="layui-btn" data-type="updateEmergency" data="btn_updateEmergency">编辑</button>
            </ck:permission>
            <ck:permission biz="delEmergency">
                <button class="layui-btn layui-btn-danger" data-type="delEmergency" data="btn_delEmergency">删除</button>
            </ck:permission>
            <ck:permission biz="showEmergency">
                <button class="layui-btn " data-type="showEmergency" data="btn_showEmergency">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="table" lay-filter="EmergencyFilter"></table>
    </div>
</div>
</body>
</html>