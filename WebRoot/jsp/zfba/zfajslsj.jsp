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
%>
<!DOCTYPE html>
<html>
<head>
    <title>案件受理时间</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "ok";   // 设为刷新父页面
        s.value = $("#ajdjslsj").val();
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate
        layui.use(['form', 'table', 'layer', 'laydate'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            laydate = layui.laydate;
            laydate.render({
                elem: '#ajdjslsj'
                , type: 'datetime'
            });
        });
        // 保存
        var submitForm = function () {
            s.value = $("#ajdjslsj").val();
            sy.setWinRet(s);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };
    </script>
</head>
<body>
<div class="layui-fluid">
    <form class="layui-form" action="" id="fm" style="padding-top: 70px">
        <table class="layui-table" lay-skin="nob">
            <tr>
                <td style="text-align:right;padding-left: 100px">案件受理时间:</td>
                <td><input name="ajdjslsj" id="ajdjslsj" class="layui-input"
                           readonly style="width: 250px;"></td>
            </tr>
            <tr>
                <td style="text-align:center;" colspan="2">默认为当前时间</td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>