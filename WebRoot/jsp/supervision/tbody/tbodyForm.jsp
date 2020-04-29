<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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
    String tbodyid = StringHelper.showNull2Empty(request.getParameter("tbodyid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>增加表格信息</title>
    <%--<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>--%>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <%--<script src="<%=basePath %>jslib/ckeditor_4.5.9/ckeditor.js"></script>--%>
    <script type="text/javascript">
        //下拉框列表
        var v_tbodycode = [{"id": "", "text": "==请选择=="}, {"id": "0", "text": "量化"}, {"id": "1", "text": "日常"}];
        var tbodyid = "<%=tbodyid%>";
        var form;
        var layer;
        var op = '<%=op%>';
        $(function () {
            initSelectData();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = '<%=basePath %>/supervision/checkTbodyinfo/saveTbodyInfo';
                form.on('submit(saveUser)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
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
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if (op == "edit" || op == "view") {
                    $.post(basePath + 'supervision/checkTbodyinfo/getTbodyinfo', {
                                tbodyid: tbodyid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('#sysUserForm').form('load', result.data);
                                    form.render();
                                }
                                else {
                                    layer.msg('查询失败：' + result.msg);
                                }
                            }, 'json')
                }
                if (op == "view") {
                    $('form :input').attr('disabled', 'disabled');
                    $('#tbodycode').attr('disabled', 'disabled');
                }
            });

        });


        // 提交表单
        function submitForm() {
            $("#saveUserBtn").click();
        }

        //初始化下拉框选项数据
        function initSelectData() {
            var typeOptions = '';
            for (var i = 0; i < v_tbodycode.length; i++) {
                typeOptions += '<option value=\'' + v_tbodycode[i].id + '\' >' + v_tbodycode[i].text + '</option>';
            }
            $("#tbodycode").append(typeOptions);
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>

<body>
<div>
    <br/>

    <div class="layui-container">
        <form id="sysUserForm" class="layui-form" action="">
            <div class="layui-row">
                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <input id="tbodyid" name="tbodyid" type="hidden" value='<%=tbodyid%>'/>
                        <label class="layui-form-label" style="width: 100px"><span
                                style="color: red;">*</span>表格类别：</label>

                        <div class="layui-input-inline">
                            <input type="text" name="tbodytype" id="tbodytype" lay-verify="required"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">计划类别：</label>

                        <div class="layui-input-inline">
                            <select id="tbodycode" name="tbodycode">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">tbody元素id：</label>

                        <div class="layui-input-inline">
                            <input type="text" name="tbbodyid" id="tbbodyid"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">表头数据信息：</label>

                        <div class="layui-input-inline" style="width: 75%">
                            <textarea id="tbodyinfo" name="tbodyinfo" class="layui-textarea"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">表头固定信息：</label>

                        <div class="layui-input-inline" style="width: 75%">
                            <textarea id="tbody" name="tbody" class="layui-textarea"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">底部固定信息：</label>

                        <div class="layui-input-inline" style="width: 75%">
                            <textarea id="tfootinfo" name="tfootinfo" class="layui-textarea"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-inline">
                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-inline">
                            <button class="layui-btn" lay-submit="" lay-filter="saveUser" id="saveUserBtn">保存
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>