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
    <title>栅栏信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var url ="<%=basePath%>/animal/queryAnimalfence";
        var form;
        var table;
        var layer;
        var selectNodes;
        var element; //
        var selectTableDataId = '';
        $(function() {
            initData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
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
                        {field: 'fenceno', title: '栅栏编号', event: 'trclick'}
                        , {field: 'fencename', title: '栅栏名称', event: 'trclick'}
                        , {field: 'houseno', title: '动物舍所编号', event: 'trclick'}
                        , {field: 'aae011', title: '操作员', event: 'trclick'}
                        , {field: 'aae036', title: '操作时间', event: 'trclick'}
                    ]]
                });
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
            })
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });

        };
        //确定
        function queding() {
            var obj = new Object();
            obj.data = table.singleData;
            obj.type = "ok";
            sy.setWinRet(obj);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }


        //查询
        function query() {
            var param = {
                'fencename': $('#fencename').val(),
                'fenceno': $('#fenceno').val()
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
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + 'animal/queryAnimalfence'
                , where: param //设定异步数据接口的额外参数
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
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
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">栅栏编号</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="fenceno" name="fenceno"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">栅栏名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="fencename" name="fencename"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal" id="reset">
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