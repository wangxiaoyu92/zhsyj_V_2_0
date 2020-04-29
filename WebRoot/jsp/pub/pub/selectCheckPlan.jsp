<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检查计划管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">

        var v_plantype = [{"id": "", "text": ""}, {"id": "1", "text": "按类别"}, {"id": "2", "text": "按区域"}, {
            "id": "3",
            "text": "按特定对象"
        }];
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        //下拉框列表
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;//进度条
        var url = "<%=basePath%>/supervision/queryPlan";
        $(function () {
            initData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'laydate'], function () {
                form = layui.form;
                var laydate = layui.laydate;
                table = layui.table;
                layer = layui.layer;
                intSelectData('plantype', v_plantype);
                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , url: url
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
                        {field: 'plantitle', title: '名称', event: 'trclick'}
                        , {field: 'plancode', title: '编号', event: 'trclick'}
                        , {
                            field: 'planchecktype', title: '检查类别'
                            , templet: function (d) {
                                if (d.planchecktype == "0") {
                                    return '<span style="color:blue">量化</span>';
                                } else if (d.planchecktype == "1") {
                                    return '<span style="color:blue">日常</span>';
                                } else if (d.planchecktype == "2") {
                                    return '<span style="color:blue">专项</span>';
                                }
                                else {
                                    return '<span style="color:blue">量化</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'plantype', title: '检查类别'
                            , templet: function (d) {
                                if (d.plantype == "1") {
                                    return '<span style="color:blue">按类别</span>';
                                    ;
                                } else if (d.plantype == "2") {
                                    return '<span style="color:blue">按区域</span>';
                                }
                                else {
                                    return '<span style="color:blue">按特定对象</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'planstdate', title: '开始时间', event: 'trclick'}
                        , {field: 'planeddate', title: '结束时间', event: 'trclick'}
                        , {field: 'planoperatedate', title: '经办时间', event: 'trclick'}
                        , {field: 'planoperator', title: '经办人', event: 'trclick'}
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
                        if (selectTableDataId != data.planid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.planid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                laydate.render({
                    elem: '#planstdate'
                });
                laydate.render({
                    elem: '#planeddate'
                });
            })
        }


        function query() {
            var plantype = $("#plantype").val();
            var planstdate = $('#planstdate').val();
            var planeddate = $('#planeddate').val();
            var plantitle = $('#plantitle').val();
            var param = {
                'plantype': plantype,
                'planstdate': planstdate,
                'planeddate': planeddate,
                'plantitle': plantitle
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: url
                , page: true
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        function refresh() {
            parent.window.refresh();
        }

        function viewResult() {
           var rows = table.singleData;
            if (rows != "") {
                var obj=new Object();
                obj.type='ok';
                obj.data = rows;
                sy.setWinRet(obj);
                if ('<%=op%>' == 'view') {
                    parent.$("#" + sy.getDialogId()).dialog("close");
                } else {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                }
            } else {
                layer.alert("请选择检查计划");
            }
        }

    </script>
</head>
<body>
<div class="layui-collapse">
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">查询条件</h2>

        <div class="layui-colla-content layui-show">
            <form class="layui-form" id="myqueryform" style="height: auto">
                <div class="layui-container">
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <label class="layui-form-label">计划名称</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="plantitle" name="plantitle"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <label class="layui-form-label">类型</label>

                                <div class="layui-input-inline">
                                    <select id="plantype" name="plantype" lay-verify="required">
                                    </select>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <label class="layui-form-label">执法时间</label>

                                <div class="layui-inline">
                                    <input id="planstdate" name="planstdate" class="layui-input test-item"
                                           placeholder="yyyy-MM-dd" type="text">
                                </div>
                                &nbsp;-&nbsp;
                                <div class="layui-inline">
                                    <input id="planeddate" name="planeddate" class="layui-input test-item"
                                           placeholder="yyyy-MM-dd" type="text">

                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-btn-group demoTable">
                                    <a href="javascript:void(0)" class="layui-btn layui-btn-sm layui-btn-normal"
                                       onclick="query()"><i class="layui-icon">&#xe615;</i>搜索</a>
                                    <button style="left: 30px" class="layui-btn layui-btn-sm layui-btn-normal "
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
    <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
</div>
</body>
</html>