<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
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
    <title>样品信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        var v_comjyjcbz = sy.IsNull(sy.getUrlParam("comjyjcbz"));

        var form;
        var table;
        var layer;
        var element;
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            initData();
            $('#btn_reset').click(function () {
                reset();
                return false;
            })
        })

        function initData() {
            var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , url: basePath + '/pub/pub/querySelectjyjcyp'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
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
//                        {type:'checkbox'}
                        {field: 'jcypid', title: '检查样品id', event: 'trclick'}
                        , {
                            field: 'jcyplb', title: '检查样品类别', event: 'trclick',
                            templet: function (d) {
                                return sy.formatGridCode(v_jcjylb, d.jcyplb);
                            }
                        }
                        , {field: 'jcypmc', title: '检查样品名称', event: 'trclick'}
                        , {field: 'jcypczy', title: '操作员', event: 'trclick'}
                        , {field: 'jcypczsj', title: '操作时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });

                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.jcypid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jcjgid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
//                var $ = layui.$, active = {
//                    queding: function () { // 添加
//                        if (!table.singleData) {
//                            parent.layer.alert('请先选择样品信息！');
//                        } else {
//                            queding(table.singleData.newsid);
//                        }
//                    }
//                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

            })
        }

        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择样品信息！');
            }
        }
        function reset() {
            $('#jcypmc').val('');
            query();
        }
        function query() {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            var param = {
                'jcypmc': $('#jcypmc').val()
            };
            table.reload('roleTable', {
                url: basePath + '/pub/pub/querySelectjyjcyp'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        //选择数据返回
        function viewResult(data) {
            var rows = data;
            if (rows != "") {
                sy.setWinRet(rows);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            }
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
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                    <label class="layui-form-label">商品名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcypmc" name="jcypmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <a href="javascript:void(0)" class="layui-btn layui-btn-sm layui-btn-normal"
                                           iconCls="icon-search" onclick="query()"> <i class="layui-icon">&#xe615;</i>查询</a>
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
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>