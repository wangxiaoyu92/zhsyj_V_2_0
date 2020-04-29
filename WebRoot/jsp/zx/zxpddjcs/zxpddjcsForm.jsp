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
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String djcsid = StringHelper.showNull2Empty(request.getParameter("djcsid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>诚信评定等级参数</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        //红黑榜等级
        var v_djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                intSelectData("djcshh", v_djcshh);
                form.render();
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#djcsksrq'
                });
                laydate.render({
                    elem: '#djcsjsrq'
                });
                var lock = true;
                var url = basePath + 'zx/zxpddjcs/saveZxpddjcs';
                form.on('submit(save)', function (data) {
                    if ($('#djcsksrq').val() >= $('#djcsjsrq').val()) {
                        $('#djcsksrq').css('border-color', 'red');
                        $('#djcsjsrq').css('border-color', 'red');
                        layer.msg('开始时间不能大于等于结束时间', {icon: 5, anim: 6});
                        return false;
                    }
                    if (!lock) {
                        return;
                    }
                    lock = false;
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#djcsid').val() != "" && $('#djcsid').val() != null) {
                    $.post(basePath + 'zx/zxpddjcs/queryZxpddjcsDTO', {
                                djcsid: $('#djcsid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    form.render();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');

                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#djcshh').attr('disabled', true);
                        $('#djcsksrq').attr('disabled', true);
                        $('#djcsjsrq').attr('disabled', true);
                    }
                }
            });
        });


        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };

        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

    </script>
</head>

<body>
<div class="layui-table">
    <div region="center" style="overflow: visible;" border="false">
        <form class="layui-form" action="" id="zxpdjgForm">
            <div class="layui-container">
                <div class="layui-row">
                    <input type="hidden" id="djcsid" name="djcsid" value="<%=djcsid%>">

                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" id="bcytel" style="width: 120px"><font
                                    class="myred">*</font>等级参数编码：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsbm" name="djcsbm"
                                       autocomplete="off" class="layui-input" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>等级参数名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsmc" name="djcsmc"
                                       autocomplete="off" class="layui-input" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>起始分值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsqsfz" lay-verify="required||number" name="djcsqsfz"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>结束分值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsjsfz" lay-verify="required||number" name="djcsjsfz"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item" id="djcsrq">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>等级参数开始日期：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsksrq" name="djcsksrq" lay-verify="required"
                                       autocomplete="off"
                                       class="layui-input" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>等级参数结束日期：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="djcsjsrq" lay-verify="required" name="djcsjsrq"
                                       autocomplete="off"
                                       class="layui-input" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>所属红黑:</label>

                            <div class="layui-input-inline">
                                <select id="djcshh" name="djcshh" lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item" style="display: none">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>