<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath()
                + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>项目参数管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#xmcsTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'zx/zxpdcjxx/xmcs'
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
                        {field: 'xmcsbm', width: 150, title: '项目参数编码', event: 'trclick'}
                        , {field: 'xmcsmc', width: 150, title: '项目参数名称', event: 'trclick'}
                        , {field: 'xmcsfz', width: 150, title: '项目参数分值', event: 'trclick'}
                        , {field: 'xmcsksrq', width: 150, title: '项目参数开始时间', event: 'trclick'}
                        , {field: 'xmcsjsrq', width: 150, title: '项目参数结束时间', event: 'trclick'}
                        , {field: 'czyxm', width: 150, title: '操作员姓名', event: 'trclick'}
                        , {field: 'czsj', width: 150, title: '操作时间', event: 'trclick'}
                        , {
                            field: 'cssyzt', width: 150, title: '参数状态', event: 'trclick'
                            , templet: function (d) {
                                if (d.cssyzt == "1") {
                                    return "启用";
                                } else {
                                    return "禁用";
                                }
                            }
                        }
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                form.render();
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.xmcsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.xmcsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    add: function () { // 添加
                        add();
                    }
                    , edit: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            edit(table.singleData.xmcsid);
                        }
                    }
                    , del: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            del(table.singleData.xmcsid);
                        }
                    }
                    , show: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的信息！');
                        } else {
                            show(table.singleData.xmcsid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        })

        function add() {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增信息'
                , content: basePath + '/zx/zxpdcjxx/xmcsFormaddIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function del(xmcsid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '您确定要删除这条记录吗，这将删除对应的项目参数相关信息，且不可恢复！'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/zx/zxpdcjxx/delxmcs', {
                                xmcsid: xmcsid
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
                                        if (table.cache.xmcsTable.length == 1) {
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
        function edit(xmcsid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑信息'
                , content: basePath + '//zx/zxpdcjxx/xmcsFormIndex?xmcsid=' + xmcsid + '&op=edit'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function show(xmcsid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看信息'
                , content: basePath + '/zx/zxpdcjxx/xmcsFormIndex?op=view&xmcsid=' + xmcsid
                , btn: ['关闭'] //可以无限个按钮
            })
        }
        //查询
        function query() {
            var xmcsbm = $('#xmcsbm').val();
            var xmcsmc = $('#xmcsmc').val();
            var param = {
                'xmcsmc': xmcsmc,
                'xmcsbm': xmcsbm
            };
            refresh(param);
        }
        //重置
        function refresh(param, cur) {
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('xmcsTable', {
                url: basePath + 'zx/zxpdcjxx/xmcs'
                , page: {
                    curr: curr
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">项目编码名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="xmcsmc" name="xmcsmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">项目参数编码</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="xmcsbm" name="xmcsbm"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs8 layui-col-sm6 layui-col-md-offset4 layui-col-sm-offset3 layui-col-xs-offset2">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px"></label>

                                    <div class="layui-input-inline">
                                        <ck:permission biz="queryNews">
                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                                <i class="layui-icon">&#xe615;</i>搜索
                                            </button>
                                        </ck:permission>
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
            <ck:permission biz="add">
                <button class="layui-btn" data-type="add" data="btn_add">增加</button>
            </ck:permission>
            <ck:permission biz="edit">
                <button class="layui-btn" data-type="edit" data="btn_edit">修改</button>
            </ck:permission>
            <ck:permission biz="del">
                <button class="layui-btn layui-btn-danger" data-type="del" data="btn_del">删除
                </button>
            </ck:permission>
            <ck:permission biz="show">
                <button class="layui-btn" data-type="show" data="btn_show">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="xmcsTable" lay-filter="tableFilter">
            <input type="hidden" id="xmcsid" name="xmcsid"/>
            <input type="hidden" id="pdjgid" name="pdjgid"/>
        </table>
    </div>
</div>
</body>
</html>