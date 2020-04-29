<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>应急队伍信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'emergency/queryEmergencyGroupList'
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
                        {field: 'groupname', width: 150, title: '应急小组名称', event: 'trclick'}
                        , {field: 'remark', width: 150, title: '备注', event: 'trclick'}
                        , {
                            field: 'state', width: 150, title: '状态'
                            , templet: function (d) {
                                if (d.state == "0") {
                                    return "<span style='color:blue;'>存在</span>";
                                } else if (d.state == "2") {
                                    return "<span style='color:red;'>已解散</span>"
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'opepateperson', width: 150, title: '经办人', event: 'trclick'}
                        , {field: 'opepatedate', width: 150, title: '经办时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(GroupFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.groupid) {
                            var state = data.state;
                            /*alert(state);*/
                            if (state == '0') {
                                $("#editGroup").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#delgroup").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#userManager").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#rollbackGroup").addClass('layui-btn-disabled').attr("disabled", "true");
                            } else if (state == '2') {
                                $("#editGroup").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#delgroup").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#userManager").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#rollbackGroup").removeClass('layui-btn-disabled').removeAttr("disabled");
                            }
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.groupid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addGroup: function () { // 添加
                        addGroup();
                    }
                    , editGroup: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的应急小组信息！');
                        } else {
                            editGroup(table.singleData.groupid);
                        }
                    }
                    , delgroup: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要操作的数据！');
                        } else {
                            delgroup(table.singleData.groupid);
                        }
                    }
                    , showGroup: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的小组信息！');
                        } else {
                            showGroup(table.singleData.groupid);
                        }
                    }
                    , userManager: function () {
                        if (!table.singleData) {
                            layer.alert('请选择先选择相应的应急小组！');
                        } else {
                            userManager(table.singleData.groupid);
                        }
                    }
                    , rollbackGroup: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要操作的数据！');
                        } else {
                            rollbackGroup(table.singleData.groupid);
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
            });
        });
        // 查询应急小组
        function query() {
            var groupname = $('#groupnameParam').val();
            var state = $('#stateParam').val();
            var param = {
                'groupname': groupname,
                'state': state
            };
            refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/emergency/queryEmergencyGroupList'
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
        // 新增应急队伍
        function addGroup() {
            sy.modalDialog({
                title: '添加小组'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyGroupInfoIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
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
        // 查看应急小组
        function showGroup(groupid) {
            sy.modalDialog({
                title: '查看应急小组'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyGroupInfoIndex?op=view&groupid=' + groupid
                , btn: ['关闭']
            });
        }
        // 编辑应急小组
        function editGroup(groupid) {
            sy.modalDialog({
                title: '编辑应急小组'
                , area: ['100%', '100%']
                , content: basePath + '/emergency/emergencyGroupInfoIndex?op=edit&&groupid=' + groupid
                /*,where:newsid*/
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 解散应急小组
        function delgroup(groupid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '您确定要解散这个应急队伍吗？？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/emergency/delEmergencyGroup', {
                                groupid: groupid
                            },
                            function (result) {
                                if (result.code == '0') {
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
                                        content: "操作失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
        // 成员管理
        function userManager(groupid) {
            sy.modalDialog({
                title: '应急小组成员管理'
                , area: ['100%', '100%']
                , content: basePath + 'emergency/emergencyGroupPersonIndex?groupid=' + groupid
                , btn: ['关闭']
            });
        }
        // 恢复应急小组
        function rollbackGroup(groupid) {
            layer.open({
                title: '警告'
                , content: '您确定要恢复这个应急队伍吗？？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'emergency/rollbackEmergencyGroup', {
                                groupid: groupid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    layer.msg('操作成功', {time: 500}, function () {
                                        table.reload('table', {url: basePath + '/emergency/queryEmergencyGroupList'});
                                        table.singleData = '';
                                        selectTableDataId = '';
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "操作失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">应急小组名称:</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="groupnameParam" name="groupnameParam"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">状态:</label>

                                <div class="layui-input-inline">
                                    <select id="stateParam" name="stateParam">
                                        <option value="">==请选择==</option>
                                        <option value="0">存在</option>
                                        <option value="2">已解散</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label"></label>

                                <div class="layui-input-inline">
                                    <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe615;</i>查询
                                    </button>
                                    <button class="layui-btn layui-btn-sm layui-btn-normal"
                                            id="btn_reset">
                                        <i class="layui-icon">&#xe621;</i>重置
                                    </button>
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
            <ck:permission biz="addGroup">
                <button class="layui-btn" data-type="addGroup" data="btn_addGroup" id="addGroup">增加</button>
            </ck:permission>
            <ck:permission biz="showGroup">
                <button class="layui-btn " data-type="showGroup" data="btn_showGroup" id="showGroup">查看</button>
            </ck:permission>
            <ck:permission biz="editGroup">
                <button class="layui-btn" data-type="editGroup" data="btn_editGroup" id="editGroup">编辑</button>
            </ck:permission>
            <ck:permission biz="delgroup">
                <button class="layui-btn" data-type="delgroup" data="btn_delgroup" id="delgroup">解散小组</button>
            </ck:permission>
            <ck:permission biz="userManager">
                <button class="layui-btn " data-type="userManager" data="btn_userManager" id="userManager">成员管理</button>
            </ck:permission>
            <ck:permission biz="rollbackGroup">
                <button class="layui-btn" data-type="rollbackGroup" data="btn_rollbackGroup" id="rollbackGroup">小组恢复
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="table" lay-filter="GroupFilter"></table>
    </div>
</div>
</body>
</html>