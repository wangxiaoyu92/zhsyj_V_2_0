<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String aaz499 = StringHelper.showNull2Empty(request.getParameter("aaz499"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>系统参数</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url;
                if ($('#aaz499').val().length > 0) {
                    url = basePath + 'sysmanager/sysparam/updateAa01';
                } else {
                    url = basePath + 'sysmanager/sysparam/addAa01';
                }
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(saveParam)', function (data) {
                    //代码可维护性为 可维护时才能查询 并显示
                    var formData = data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false; //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                if(''==('<%=op%>')){
                                    obj.type = "saveOk";
                                }else {
                                    obj.type="ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                var v_aaz499 = $("#aaz499").val();
                if (v_aaz499 != null && v_aaz499.length > 0) {
                    $.post(basePath + 'sysmanager/sysparam/queryAa01', {
                                aaz499: v_aaz499
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('form').form('load', result.data);
                                    form.render();
                                }
                            }, 'json');
                }
            });

        });
        // 保存
        function submitForm() {
            $("#saveParamBtn").click();
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<form id="fm" class="layui-form" action="">
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label">参数ID:</label>

            <div class="layui-input-inline">
                <input type="text" name="aaz499" id="aaz499" readonly
                       value="<%=aaz499%>" autocomplete="off" class="layui-input layui-bg-gray">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">*</span>参数代码:</label>

            <div class="layui-input-inline">
                <input type="text" name="aaa001" id="aaa001" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">*</span>参数代码名称:</label>

            <div class="layui-input-inline">
                <input type="text" name="aaa002" id="aaa002" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">*</span>参数值:</label>

            <div class="layui-input-inline">
                <input type="text" name="aaa005" id="aaa005" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label">参数值域说明:</label>

            <div class="layui-input-inline">
                <input type="text" name="aaa105" id="aaa105" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label">代码可维护标志:</label>

            <div class="layui-input-inline">
                <select name="aaa104" id="aaa104">
                    <option value="">===请选择===</option>
                    <option value="0">不可维护</option>
                    <option value="1" selected>可维护</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="saveParam"
                    id="saveParamBtn">保存
            </button>
        </div>
    </div>
</form>
</body>
</html>