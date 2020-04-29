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
    <title>操作日志管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_gridreport.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var mask;
        // 用户类别
        var cb_userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
        CreateReport("Report");
        // 在网页初始加载时向报表提供数据
        function window_onload() {
            Report.LoadFromURL("<%=basePath%>jsp/gridreport/operatelog.grf");
        }

        $(function () {
            intSelectData('userkind', cb_userkind);
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                // 初始化下拉框数据

                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#logTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysoperatelog/querySysoperatelog'
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
                        {field: 'userid', width:120, title: '用户ID'}
                        , {field: 'username', width:120, title: '用户名称'}
                        , {
                            field: 'userkind', width:120,title: '用户类别'
                            , templet: function (d) {
                                return formatGridColData(cb_userkind, d.userkind);
                            }
                        }
                        , {field: 'userip', width:120,title: '用户IP'}
                        , {field: 'parent', width:120,title: '操作模块'}
                        , {field: 'title', width:120,title: '操作功能'}
                        , {field: 'starttime', width:150,title: '开始时间'}
                        , {field: 'endtime', width:150,title: '结束时间'}
                        , {field: 'module', width:150,title: '简述'}
                        , {field: 'description', width:300,title: '详述'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        });

        function query() {
            var param = {
                'username': $('#username').val(),
                'userkind': $('#userkind').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('logTable', {
                url: basePath + 'sysmanager/sysoperatelog/querySysoperatelog'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    layer.close(mask);
                }
            });
        }

        function myprint() {
            var v_username = $('#username').val();
            var v_userkind = $('#userkind').val();
            var v_url = encodeURI(encodeURI("<%=basePath%>sysmanager/sysoperatelog/querySysoperatelogPrint?username="
            + v_username + "&userkind=" + v_userkind + "&time=" + new Date().getMilliseconds()));
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看失信企业'
                , content: v_url
                , btn: ['关闭']
            })


            Report.LoadDataFromURL(v_url);
            Report.PrintPreview(true);
            return false;
        }

        function print() {
            sy.doPrint('siweb/sysuser.cpt', '')
        }
    </script>
</head>
<body onload="window_onload()">
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="username" name="username"
                                               class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户类别</label>

                                    <div class="layui-input-inline">
                                        <select name="userkind" id="userkind"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline" style="width: auto;">
                                        <ck:permission biz="querySysoperatelog">
                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                    lay-submit="" onclick="query()" data="btn_querySysoperatelog">
                                                <i class="layui-icon">&#xe615;</i>查询
                                            </button>
                                        </ck:permission>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_reset" onclick="refresh()">
                                            <i class="layui-icon">&#x1002;</i>重置
                                        </button>
                                        <ck:permission biz="querySysoperatelogPrint">
                                            <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                    onclick="myprint()" data="btn_querySysoperatelogPrint">
                                                <i class="layui-icon">&#xe621;</i>打印
                                            </button>
                                        </ck:permission>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="logTable"></table>
</div>
</body>
</html>