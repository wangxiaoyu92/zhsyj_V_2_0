<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>版本管理</title>
    <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop"
               width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
    </object>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var LODOP; //声明为全局变量
        var table; // 数据表格
        var layer; // 弹出层
        var element; //
        var laydate; // 日期
        var mask;
        $(function () {
            layui.use(['table', 'layer', 'element', 'laydate'], function () {
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                laydate = layui.laydate;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#versionTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysuser/queryversion'
                    , page: false // 展示分页
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'logonlogid', title: '登陆id'}
                        , {field: 'userid', title: '登录名称'}
                        , {field: 'logfailedreason', title: '用户名称'}
                        , {field: 'logontime', title: '登陆时间'}
                        , {field: 'logonappvision', title: '版本号'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                laydate.render({
                    elem: '#logontime'
                    , max: 0 // 限制可选日期，当天之前可选
                });
            });
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
            $("#btn_print").bind("click", function () {
                printHtml();
                return false;
            });
        });

        function query() {
            var param = {
                'userid': $('#username').val(),
                'logontime': $('#logontime').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('versionTable', {
                url: basePath + 'sysmanager/sysuser/queryversion'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    layer.close(mask);
                }
            });
        }
        function printHtml() {
            var url = basePath + '/common/sjb/queryloghtml?' +
                    'logontime=' + $('#logontime').val() +
                    '&userid=' + $('#username').val();
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '签到结果'
                , content: url
                , shade: [0.8, 'gray'] // 遮罩
                , btn: ['打印', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    layer.close(index);
                    var strID = url;
                    LODOP = getLodop();
                    LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_按网址打印");
                    LODOP.ADD_PRINT_URL(30, 20, 746, "95%", strID);
                    LODOP.SET_PRINT_STYLEA(0, "HOrient", 3);
                    LODOP.SET_PRINT_STYLEA(0, "VOrient", 3);
                    LODOP.SET_SHOW_MODE("MESSAGE_GETING_URL", ""); //该语句隐藏进度条或修改提示信息
                    LODOP.SET_SHOW_MODE("MESSAGE_PARSING_URL", "");//该语句隐藏进度条或修改提示信息
                    LODOP.PREVIEW();
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

            <div class="layui-colla-content layui-show" style="height: auto">
                <form class="layui-form" id="myqueryform">
                    <div class="layui-container">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">登录名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="username" name="username" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">日期</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="logontime" name="logontime" class="layui-input">
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
                                            <i class="layui-icon">&#x1002;</i>重置
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_print">
                                            <i class="layui-icon">&#xe621;</i>打印
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
        <table class="layui-hide" id="versionTable"></table>
    </div>
</div>
</body>
</html>