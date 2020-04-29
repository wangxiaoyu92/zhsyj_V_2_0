<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
        var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var num;
        var mygrData = []
        var obj = new Object();
        var mask;
        $(function () {
            layui.use(['form', 'table', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/pub/wsgldy/queryAjwsParamlist'
                    , where: {
                        ajdjid: '<%=v_ajdjid%>'
                    }
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
                        {type: 'checkbox'}
                        , {field: 'fjcsdmmc', title: '执法文书名称', event: 'trclick'}
                        , {field: 'fjcsdmz', title: '代码值', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                //监听复选框
                table.on('checkbox(ZfbawsFilter)', function (obj) {
                    var checkStatus = table.checkStatus('table');
                    num = checkStatus.data.length;//获取被选中的个数
                    mygrData = checkStatus.data;//获取被选中的数据
                });
            });


        })////////////////

        function queding() {

            var rows = mygrData;
            sy.setWinRet(rows);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        //文书排序
        function wspx() {
            var _basepath = "<%=basePath%>";
            var url = _basepath + "pub/wsgldy/pubWsglAddOrderIndex?a=" + new Date().getMilliseconds();
            parent.sy.modalDialog({
                type: 2
                , title: '文书排序'
                , area: ['100%', '100%']
                , content: url
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-colla-content layui-show">
        <div style="text-align:center; width:100%;height:100%;margin:0px;">
            <div class="layui-input-inline" style="width: 100px">
                <a href="javascript:void(0)" class="layui-btn"
                   iconCls="icon-search" onclick="queding()">确定 </a>
            </div>
            <div class="layui-input-inline" style="width: 100px">
                <a href="javascript:void(0)" class="layui-btn"
                   iconCls="icon-search" onclick="wspx()">文书排序 </a>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="table" lay-filter="ZfbawsFilter"></table>
</div>
</body>
</html>