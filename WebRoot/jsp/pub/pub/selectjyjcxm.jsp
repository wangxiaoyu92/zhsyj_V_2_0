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
    <title>检验检测项目</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
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
                    , url: basePath + '/pub/pub/querySelectjyjcxm'
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
                        {
                            field: 'jcxmmc', title: '检查项目名称', event: 'trclick'
                        }
                        , {field: 'jcxmbzz', title: '标准值', event: 'trclick'}
                        , {field: 'jcxmczy', title: '操作员', event: 'trclick'}
                        , {field: 'jcxmczsj', title: '操作时间', event: 'trclick'}
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
                        if (selectTableDataId != data.jyjcxmid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jyjcxmid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    viewResult: function () { //获取选中数据
                        var checkStatus = table.checkStatus('roleTable')
                                , data = checkStatus.data;
//                    alert(data);
                        if (data != "") {
                            viewResult(data);
                        } else {
                            layer.alert("请选择项目信息");
                        }

                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

            })
        }
        function reset() {
            $('#jcypmc').val('');
            query();
        }

        function query() {
            var param = {
                'jcxmmc': $('#jcypmc').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + '/pub/pub/querySelectjyjcxm'
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
        //确定方法
        function queding() {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择项目信息！');
            }
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
                                    <label class="layui-form-label">检查项目名称</label>

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
                                        <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn_reset">
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
        <input type="hidden" id="jcxmid" name="jcxmid"/>
        <input type="hidden" id="jcxmbh" name="jcxmbh"/>
    </div>
</div>
</body>
</html>