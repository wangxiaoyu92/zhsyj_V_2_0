<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    // 检查计划id
    String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>选择企业</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrData = [];
        var xz;
        var form;
        var table;
        var singleData;
        var selectTableDataId = '';
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");

        $(function () {
            layui.use(['form', 'table', 'element'], function () {
                form = layui.form;
                table = layui.table;
                var element = layui.element;
                var url = basePath + 'supervision/queryComByPlan';
                table.render({
                    elem: '#mygrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , where: {planid: '<%=v_planid%>'}
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {type: 'checkbox'}
//                        {field: 'comid', width: 50, checkbox: 'true', event: 'trclick'}
                        , {field: 'commc', width: 200, title: '企业名称'}
                        , {field: 'comdaleistr', width: 120, title: '企业大类'}
                        , {field: 'comxkzbh', width: 150, title: '许可证编号'}
                        , {field: 'comfrhyz', width: 110, title: '企业法人/业主'}
                        , {field: 'comfrsfzh', width: 170, title: '企业法人/业主身份证号'}
                        , {field: 'comfzr', width: 90, title: '企业负责人'}
                        , {field: 'comgddh', width: 100, title: '固定电话'}
                        , {field: 'comyddh', width: 110, title: '移动电话'}
                        , {field: 'comdz', width: 150, title: '企业地址'}
                    ]]
                });
                //监听复选框
                table.on('checkbox(mygr)', function (obj) {
                    var checkStatus = table.checkStatus('mygrid');
                    xz = checkStatus.data.length;//获取被选中的个数
                    mygrData = checkStatus.data;//获取被选中的数据
                });
            })

            $("#btn_query").click(function () {//查询
                query();
                return false; //阻止页面刷新
            })
            $("#btn_refresh").click(function () {//查询
                refresh();
                return false; //阻止页面刷新
            })
        });
        //查询
        function query() {
            mygrData = [];
            var param = {
                commc: $('#commc').val(),
                planid: $('#planid').val()
            };
            table.reload('mygrid', {url: basePath + 'supervision/queryComByPlan', where: param});
        }
        //确定
        function queding() {
            if (xz > 0) {
                var obj = new Object();
                obj.data = mygrData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择企业！');
                mygrData = [];
            }
        }

        //重置
        function refresh() {
            mygrData = [];
            $('#commc').val('');
            var param = {
                commc: '',
                planid: $('#planid').val()
            };
            table.reload('mygrid', {url: basePath + 'supervision/queryComByPlan', where: param});
        }

    </script>
</head>
<body>
<%--<div class="layui-table">--%>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">

                <form class="layui-form">
                    <div class="layui-container">
                        <input type="hidden" value="<%=v_planid%>" id="planid">

                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                    <label class="layui-form-label">企业名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="commc" id="commc"
                                               class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button id="btn_refresh"
                                                class="layui-btn layui-btn-sm layui-btn-normal">
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
        <table class="layui-hide" id="mygrid" lay-filter="mygr"></table>
    </div>
</div>
</body>
</html>