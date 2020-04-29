<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>项目参数管理的增加</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var systemcode = <%=SysmanageUtil.getAa10toJsonArray("SYSTEMCODE")%>;
        $(function () {
            //项目代码
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var lock = true;// 锁住表单   这里定义一把锁
                var url = basePath + '/zx/zxpdcjxx/addxmcs';
                intSelectData('systemcode', systemcode);
                form.render();
                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    if ($('#xmcsbm').val().length > 11) {
                        layer.msg('编码长度超过限制！',{time: 1000});
                        lock = true;
                        return false;
                    }
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
                if ($('#xmcsid').val() != "" && $('#xmcsid').val() != null) {
                    $.post(basePath + '/zx/zxpdcjxx/xmcs', {
                            xmcsid: $('#xmcsid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查询失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        }, 'json');
                }
            });
        })
        // 保存
        var submitForm = function () {
            $("#saveRoleBtn").click();
        };

        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };
    </script>
</head>
<body>
<form class="layui-form" action="">
    <table class="layui-table" lay-skin="nob">
        <td style="text-align:right;width: 141px;height: 57px"><font class="myred">*</font>项目参数名称:</td>
        <td>
            <input type="text" id="xmcsmc" name="xmcsmc" lay-verify="required"
                   class="layui-input">
        </td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><font class="myred">*</font>项目参数编码:</td>
            <td>
                <input type="text" id="xmcsbm" name="xmcsbm" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><font class="myred">*</font>项目参数分值:</td>
            <td>
                <input type="text" id="xmcsfz" name="xmcsfz" lay-verify="required||number"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px">对应子系统:</td>
            <td>
                <select id="systemcode" name="systemcode"></select>
            </td>
        </tr>
    </table>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="saveRole"
                    id="saveRoleBtn">保存
            </button>
        </div>
    </div>
</form>
</div>
</body>
</html>