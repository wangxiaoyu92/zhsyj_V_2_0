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

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    // 任务id
    String v_taskid = StringHelper.showNull2Empty(request.getParameter("taskid"));
    // 计划id
    String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>任务信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var form;
        var laydate;
        var layer;
        var table;

        $(function () {
            layui.use(['form', 'layer', 'laydate', 'table'], function () {
                form = layui.form;
                laydate = layui.laydate;
                layer = layui.layer;
                table = layui.table;


                //时间处理
                laydate.render({
                    elem: '#tasktime'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#tasktimest').val(val[0]);
                        $('#tasktimeed').val(val[1]);
                    }
                });
                form.on('submit(save)', function (data) {
                    var formData = data.field;

                    var url = basePath + 'supervision/saveTask';
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                obj.type = 'ok';
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                        }
                    });
                    return false;
                });
            });

            //取消
            $('#colos').click(function () {
                closeWindow();
            });

            if ($('#taskid').val().length > 0) {
                $.post(basePath + 'supervision/queryTaskObj', {
                            taskid: $('#taskid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                                var tasktimest = $('#tasktimest').val().split(' ');
                                var tasktimeed = $('#tasktimeed').val().split(' ');
                                $('#tasktime').val(tasktimest[0] + ' ~ ' + tasktimeed[0])
                            } else {
                                parent.layer.alert('查询失败：' + result.msg);
                            }
                        }, 'json');

                if ('<%=op%>' == 'view') {
                    $('form :input').attr('readonly', 'readonly');
                    $('form :input').attr('disabled', 'disabled');
                    $('.Wdate').attr('disabled', true);
                    loadSupervisionCompany($('#taskid').val()); // 加载检查企业
                    loadSupervisionPerson($('#taskid').val()); // 加载检查人员
                }
            }
        });

        // 加载检查企业
        function loadSupervisionCompany(v_taskid) {
            layui.use(['table'], function () {
                table = layui.table;
                var url = basePath + 'supervision/querySupervisionCompany';
                table.render({
                    elem: '#comgrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , where: {taskid: v_taskid}
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'commc', width: 200, title: '公司名称'}
                        , {field: 'comdz', width: 202, title: '公司地址'}
                    ]]
                });
            })
        }
        // 加载检查人员
        function loadSupervisionPerson(v_taskid) {
            layui.use(['table'], function () {
                table = layui.table;
                var url = basePath + 'supervision/querySupervisionPerson';
                table.render({
                    elem: '#rygrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , where: {taskid: v_taskid}
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'description', width: 200, title: '姓名'}
                        , {field: 'orgname', width: 203, title: '所属部门'}
                    ]]
                });
            })
        }
        //保存
        function submitForm() {
            $('#save').click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div class="layui-table">

        <form id="taskfm" name="taskfm" class="layui-form" action="">
            <%--<div region="center" style="overflow: true;" border="false" >--%>
            <%--<form id="taskfm" name="taskfm" method="post">--%>
            <input id="taskid" name="taskid" type="hidden" value="<%=v_taskid%>"/>
            <input id="planid" name="planid" type="hidden" value="<%=v_planid%>"/>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>任务名称：</label>

                <div class="layui-input-inline" style="width: 280px">
                    <input type="text" id="taskname" name="taskname" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>任务描述：</label>

                <div class="layui-input-inline" style="width: 280px">
                        <textarea rows="" cols="" style="width: 600px;height: 100px" id="taskremark"
                                  required lay-verify="required" name="taskremark"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>任务起止时间：</label>

                <div class="layui-input-inline" style="width: 280px">
                    <input type="text" id="tasktime" required lay-verify="required" readonly
                           class="layui-input">
                </div>
                <input type="text" id="tasktimest" name="tasktimest" class="layui-hide" readonly>
                <input type="text" id="tasktimeed" name="tasktimeed" class="layui-hide" readonly>
            </div>
            <% if ("view".equalsIgnoreCase(op)) {%>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>经办人：</label>

                <div class="layui-input-inline" style="width: 280px">
                    <input type="text" id="aaa011" name="aaa011"
                           style="width: 400px;" rows="5" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>经办时间：</label>

                <div class="layui-input-inline" style="width: 280px">
                    <input type="text" id="aae036" name="aae036"
                           style="width: 400px;" rows="5" class="layui-input">
                </div>
            </div>
            <%} %>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit="" lay-filter="save" id="save">保存</button>
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" id="colos">取消</button>
                </div>
            </div>
        </form>
</div>
<% if ("view".equalsIgnoreCase(op)) {%>
<div class="layui-table">
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td>
                <table class="layui-hide" id="comgrid" lay-filter="comgr"></table>
            </td>
            <td>
                <table class="layui-hide" id="rygrid" lay-filter="rygr"></table>
            </td>
        </tr>
    </table>
</div>
<%} %>
</body>
</html>