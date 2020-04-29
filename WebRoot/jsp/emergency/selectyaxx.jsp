<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>预案信息登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;
        var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId = '';
        var mask;
        $(function () {
            var cateidOptions = '';
            for (var i = 0; i < newscate.length; i++) {
                cateidOptions += '<option value=\'' + newscate[i].id + '\' >' + newscate[i].text + '</option>';
            }
            $("#cateid").append(cateidOptions)
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/emergency/queryEmergencysList'
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
                        {field: 'newsid', width: 150, title: '预案编号', event: 'trclick'}
                        , {
                            field: 'newstitle', width: 300, title: '预案标题'
                            , templet: function (d) {
                                if (d.newstitle.length >= 20) {
                                    return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' + d.newsid + '" title="' + d.newstitle + '" target="_blank">' + d.newstitle.substr(0, 20) + '...</a>';
                                } else {
                                    return '<a href="<%=contextPath %>/news/queryNewsDetail?newsid=' + d.newsid + '" title="' + d.newstitle + '" target="_blank">' + d.newstitle + '</a>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'newsfrom', width: 150, title: '预案来源', event: 'trclick'}
                        , {
                            field: 'newsispicture', width: 150, title: '是否图片预案'
                            , templet: function (d) {
                                if (d.newsispicture == "0") {
                                    return '<span style="color:red">否</span>';
                                } else {
                                    return '<span style="color:blue">是</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'cateid', width: 150, title: '所属分类'
                            , templet: function (d) {
                                return sy.formatGridCode(newscate, d.cateid);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'newstjsj', width: 150, title: '添加时间', event: 'trclick'}
                        , {
                            field: 'sfyx', width: 100, title: '是否有效'
                            , templet: function (d) {
                                if (d.sfyx == "1") {
                                    return '<span style="color:blue;">有效</span>';
                                } else {
                                    return '<span style="color:red;">无效</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(NewsFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.newsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.newsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                /*   var $ = layui.$, active = {
                 queding: function () { // 添加
                 if (!table.singleData) {
                 parent.layer.alert('请先选择预案信息！');
                 } else {
                 queding(table.singleData.newsid);
                 }
                 }
                 };*/
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


        function query() {
            var param = {
                'cateid': $('#cateid').val(),
                'newstitle': $('#newstitle').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/emergency/queryEmergencysList',
                where: param
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        function queding(data) {
            if (table.singleData != null && table.singleData != '') {
                var obj = new Object();
                obj.data = table.singleData;
                obj.type = "ok";
                sy.setWinRet(obj);
                closeWindow();
            } else {
                layer.alert('请选择预案！');
            }
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
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
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">预案分类:</label>

                                <div class="layui-input-inline">
                                    <select id="cateid" name="cateid">
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">预案标题:</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="newstitle" name="newstitle"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label"></label>
                                <div class="layui-input-inline">
                                    <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe615;</i>搜索
                                    </button>
                                    <button class="layui-btn layui-btn-sm layui-btn-normal">
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
        <table class="layui-hide" id="table" lay-filter="NewsFilter"></table>
    </div>
</div>
</body>
</html>