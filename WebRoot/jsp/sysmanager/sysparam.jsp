<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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
    <title>系统参数管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var selectTableDataId = '';
        var mask;
        $(function () {
            layui.use(['form', 'table', 'element', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                element = layui.element;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#paramTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysparam/queryAa01'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'aaz499', title: '参数ID', event: 'trclick'}
                        , {field: 'aaa001', title: '参数代码', event: 'trclick'}
                        , {field: 'aaa002', title: '参数名称', event: 'trclick'}
                        , {field: 'aaa005', title: '参数值', event: 'trclick'}
                        , {field: 'aaa105', title: '参数值域说明', event: 'trclick'}
                    ]]
                    , done: function () {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.aaz499) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.aaz499;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addAa01: function () { // 添加
                        addAa01();
                    }
                    , updateAa01: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的参数！');
                        } else {
                            updateAa01(table.singleData.aaz499);
                        }
                    }
                    , delAa01: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的参数！');
                        } else {
                            delAa01(table.singleData.aaz499);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        });

        // 查询
        function query() {
            var aaa001 = $('#aaa001').val();
            var aaa002 = $('#aaa002').val();
            var param = {
                'aaa001': aaa001,
                'aaa002': aaa002
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('paramTable', {
                url: basePath + 'sysmanager/sysparam/queryAa01'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        // 新增
        function addAa01() {
            sy.modalDialog({
                title: '添加'
                , content: basePath + 'sysmanager/sysparam/sysparamFormIndex'
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
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
        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('paramTable', {
                url: basePath + 'sysmanager/sysparam/queryAa01'
                , where: param //设定异步数据接口的额外参数
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , done: function () {
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }
        // 修改
        function updateAa01(id) {
            sy.modalDialog({
                title: '修改'
                , content: basePath + 'sysmanager/sysparam/sysparamFormIndex?op=edit'
                , param: {aaz499: id}
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 删除
        function delAa01(id) {
            layer.confirm('确定要删除这条参数吗?', function (index) {
                $.post(basePath + 'sysmanager/sysparam/delAa01', {
                            aaz499: id
                        },
                        function (result) {
                            if (result.code == '0') {
                                table.singleData = '';
                                selectTableDataId = '';
                                //本页的值
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.paramTable.length == 1) {
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
            })
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
                    <div class="layui-container">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">参数代码</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="aaa001" name="aaa001"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">参数名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="aaa002" name="aaa002"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <div class="layui-input-inline" style="width: auto;">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="">
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
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addAa01">
                <button class="layui-btn" data-type="addAa01" data="btn_addAa01">增加</button>
            </ck:permission>
            <ck:permission biz="updateAa01">
                <button class="layui-btn" data-type="updateAa01" data="btn_updateAa01">修改</button>
            </ck:permission>
            <ck:permission biz="delAa01">
                <button class="layui-btn layui-btn-danger" data-type="delAa01" data="btn_delAa01">删除</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="paramTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>