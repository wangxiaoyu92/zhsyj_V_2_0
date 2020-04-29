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
    // 成员关系表id
    String v_etpid = StringHelper.showNull2Empty(request.getParameter("etpid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>突发事件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
        $(function () {
            var userkindOptions = '';
            for (var i = 0; i < userkind.length; i++) {
                userkindOptions += '<option value=\'' + userkind[i].id + '\' >' + userkind[i].text + '</option>';
            }
            $("#userkind").append(userkindOptions);
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/emergency/saveEmergencyGroupPerson'
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                obj.type = "ok";
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
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#etpid').val().length > 0) {
                    $.post(basePath + '/emergency/queryEmergencyGroupPersonDTO', {
                                etpid: $('#etpid').val()
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
                }
            });
        });

        // 保存
        var submitForm = function () {
            $("#saveGroupPersonBtn").click();
        };

        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="emergencyGroupPersonfm" class="layui-form" action="">
            <div class="layui-container">
                <input id="etpid" name="etpid" type="hidden" value="<%=v_etpid%>"/>

                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">用户名：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="username" name="username" readonly
                                           autocomplete="off" class="layui-input layui-bg-gray">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">用户描述：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="description" name="description" readonly
                                           autocomplete="off" class="layui-input layui-bg-gray">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">用户手机号：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="mobile" name="mobile" readonly
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">组织名：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="orgname" name="orgname" readonly
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">用户类别：</label>

                                <div class="layui-input-inline">
                                    <select id="userkind" name="userkind" disabled="disabled">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">成员类型：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="newstitle" name="newstitle"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">备注：</label>

                                <div class="layui-input-inline" style="width: 75%;">
                                    <textarea class="layui-textarea" id="etpremark" name="etpremark" style="height: 150px"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item" style="display: none">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit="" lay-filter="save" id="saveGroupPersonBtn">保存
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