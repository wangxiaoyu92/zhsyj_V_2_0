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

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String v_jcjgid = StringHelper.showNull2Empty(request.getParameter("jcjgid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测审核</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        //检测检验类别
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        // 检验检测结论
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        //检测检验审核标志
        var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层

        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#impjcsj'
                });
                var url = basePath + '/jyjc/saveJyjcjg';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
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
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });

                var jcjgid = '<%=v_jcjgid%>';
                if (jcjgid != "" && jcjgid != null) {
                    $.post(basePath + '/jyjc/queryJyjcjgDTO', {
                                jcjgid: jcjgid
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
                        $('#impjcsj').attr('disabled', true);
                        $("#jcjylb").attr('disabled', true);
                        $("#jcjyshbz").attr('disabled', true);
                    }
                }
            });
            intSelectData('jcjylb', v_jcjylb);
            intSelectData('impjcjg', v_jyjcjl);
            intSelectData('jcjyshbz', v_shbz);
        });
        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<style>
    body .layer-ext-myskin .layui-layer-content {
        overflow: visible;
    }

    body .layer-ext-myskin .layui-layer-content {
        overflow: visible;
    }
</style>
<body>
<div class="layui-table">
    <div region="center" style="overflow:visible;" border="false">
        <form class="layui-form" action="" id="jyjcjgForm">
            <input id="jcjgid" name="jcjgid" type="hidden"/>
            <input id="comid" name="comid" type="hidden"/>
            <input id="jcypid" name="jcypid" type="hidden"/>

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检验检测类别:</label>

                            <div class="layui-input-inline">
                                <select id="jcjylb" disabled name="jcjylb"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检测样品名称:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcypmc" name="jcypmc" readonly lay-verify="required"
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">受检单位:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="commc" name="commc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px" id="jcxms">检测项目名称:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmmc" name="jcxmmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                            </div>
                            <input id="jcxmid" name="jcxmid" type="hidden"/>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">标准值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmbzz" name="jcxmbzz" readonly autocomplete="off"
                                       lay-verify="required" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">结果值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="imphl" name="imphl" readonly autocomplete="off"
                                       lay-verify="required"
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检测日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="impjcsj" name="impjcsj" disabled
                                       readonly autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">结论:</label>

                            <div class="layui-input-inline layui-form" lay-filter="selFilter">
                                <select id="impjcjg" name="impjcjg" x disabled="disabled"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>复检结果:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="fjjg" name="fjjg" lay-verify="required" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>审核标志:</label>

                            <div class="layui-input-inline layui-form">
                                <select id="jcjyshbz" name="jcjyshbz"
                                        lay-verify="required"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">处理结果:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcjycljg" name="jcjycljg" lay-verify="required"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item" style="display: none">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>