<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>企业征信查询</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">

        //        var v_discredtype = [{"id":"","text":""},{"id":"1","text":"严重失信"},{"id":"2","text":"失信"}];

        var url = "<%=basePath%>/aqcx/discred/queryDiscredInfos";
        var form;
        var table;
        var layer;
        var selectNodes;
        var element; //
        var selectTableDataId = '';
        var mask;
        $(function () {
            initData();
//            initSelectData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
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
                        {field: 'comid', width: 410, title: '企业id', event: 'trclick'}
                        , {field: 'comname', width: 410, title: '企业名称', event: 'trclick'}
                        , {
                            field: 'type', title: '失信程度'
                            , templet: function (d) {
                                if (d.type == "1") {
                                    return '<span style="color:blue">严重失信</span>';
                                } else {
                                    return '<span style="color:green">失信</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'serialnumber', title: '序号', event: 'trclick'}
                        , {field: 'category', title: '类别', event: 'trclick'}
                        , {field: 'reason', title: '列入失信原因', event: 'trclick'}
                        , {field: 'enrolrq', width: 210, title: '列入失信日期', event: 'trclick'}
                        , {field: 'includery', title: '列入人员', event: 'trclick'}
                        , {field: 'removal', title: '移除原因', event: 'trclick'}
                        , {field: 'moverq', width: 210, title: '移除时间', event: 'trclick'}
                        , {field: 'removery', title: '移除人员', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                form.render();
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.id) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.id;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    showdiscred: function () { // 查看结果明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的失信信息！');
                        } else {
                            showdiscred(table.singleData);
                        }
                    }
                    , adddiscred: function () {
                        adddiscred();
                    }
                    , updatediscred: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的失信信息！');
                        } else {
                            updatediscred(table.singleData);
                        }
                    }
                    , deldiscred: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除的失信信息！');
                        } else {
                            deldiscred(table.singleData);
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
            })
        }
        ;
        // 重置
        function reload() {
            table.reload('roleTable', {
                url: basePath + '/aqcx/discred/queryDiscredInfos'
            });
        }
        ;
        function query() {

            // 查询
            var comname = $('#comname').val();
            var param = {
                'comname': comname
            }
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + '/aqcx/discred/queryDiscredInfos'
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        function showdiscred(data) {
            var url = basePath + '/aqcx/discred/discredFormIndex?op=view&id=' + data.id;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看失信企业'
                , content: url
                , btn: ['关闭']
            });
        }
        function adddiscred() {
            sy.modalDialog({
                title: '新增信息'
                , content: basePath + 'aqcx/discred/discredFormIndex'
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('roleTable', {
                    url: basePath + '/aqcx/discred/queryDiscredInfos'
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
            }
        }
        function updatediscred(data) {
            var id = data.id;
            var url = basePath + '/aqcx/discred/discredFormIndex?id=' + id;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑失信企业信息'
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function deldiscred(data) {
            var id = data.id;
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/aqcx/discred/delDiscred', {
                                id: id
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    layer.msg('删除成功', {time: 500}, function () {
                                        mask = layer.load(1, {shade: [0.1, '#393D49']});
                                        table.reload('roleTable', {
                                            url: basePath + '/aqcx/discred/queryDiscredInfos'
                                            , done: function (res, curr, count) {
                                                table.singleData = '';
                                                selectTableDataId = '';
                                                layer.close(mask);
                                            }
                                        });
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json')
                }
            })
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">失信查询条件信息</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">企业名称</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="comname" name="comname"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
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
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="adddiscred">
                <button class="layui-btn" data-type="adddiscred" data="btn_adddiscred">添加</button>
            </ck:permission>
            <ck:permission biz="updatediscred">
                <button class="layui-btn" data-type="updatediscred" data="btn_updatediscred">修改</button>
            </ck:permission>
            <ck:permission biz="deldiscred">
                <button class="layui-btn layui-btn-danger" data-type="deldiscred" data="btn_deldiscred">删除</button>
            </ck:permission>
            <ck:permission biz="showdiscred">
                <button class="layui-btn" data-type="showdiscred" data="btn_showdiscred">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>