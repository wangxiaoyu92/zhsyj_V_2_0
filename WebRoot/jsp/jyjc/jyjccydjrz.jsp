<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String v_cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));

%>
<!DOCTYPE html>
<html>
<head>
    <title>抽样登记日志</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var table;
        $(function () {
            layui.use(['form', 'layer', 'table'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                table.render({
                    elem: '#mygrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , url: basePath + '/jyjc/queryQyyyrz'
                    , where: {url: '<%=v_cydjid%>'}
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'description', width: 180, title: '抽样登记环节', event: 'trclick'}
                        , {field: 'username', width: 140, title: '经办人', event: 'trclick'}
                        , {field: 'starttime', width: 150, title: '经办时间', event: 'trclick'}
                    ]]
                });
            });
        })////////////////
        //关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };
    </script>
</head>
<body>
<div class="layui-fluid">
    <table class="layui-hide" id="mygrid" lay-filter="mygridFilter"></table>
</div>
</body>
</html>