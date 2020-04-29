<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String xmcsid = StringHelper.showNull2Empty(request.getParameter("xmcsid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>编辑项目参数管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var systemcode = <%=SysmanageUtil.getAa10toJsonArray("SYSTEMCODE")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#xmcsksrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#xmcsjsrq'
                    , type: 'datetime'
                });
                intSelectData('systemcode', systemcode);
                var url = basePath + '/zx/zxpdcjxx/xmcsupdate';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if ($('#xmcsbm').val().length > 11) {
                        layer.msg('编码长度超过限制！', {time: 1000});
                        lock = true;
                        return false;
                    }
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
                var xmcsid = $('#xmcsid').val()
                if (xmcsid != "" && xmcsid != null) {
                    $.post(basePath + '/zx/zxpdcjxx/xmcs', {
                            xmcsid: xmcsid
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $("#systemcode").val();
                                $('form').form('load', mydata);
                                //渲染选择框
                                form.render('select');
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查询失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('input').addClass('input_readonly');
                        $('input').attr('readonly', 'readonly');
                        $('input').attr('disabled', 'true');
                        $('#systemcode').attr('disabled', 'true');
                    }
                }
            });

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
<body>
<div class="layui-table">
    <div region="center" style="overflow: visible;" border="false">
        <form class="layui-form" action="" id="fr">
            <input id="xmcsid" name="xmcsid" type="hidden" value="<%=xmcsid%>"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 110px"><font class="myred">*</font>项目参数名称:：</label>
                <div class="layui-input-inline">
                    <input type="text" id="xmcsmc" name="xmcsmc" lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 110px"><font class="myred">*</font>项目参数编码:：</label>
                <div class="layui-input-inline">
                    <input type="text" id="xmcsbm" name="xmcsbm" lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 110px">操作员姓名:：</label>
                <div class="layui-input-inline">
                    <input type="text" id="czyxm" name="czyxm"
                           autocomplete="off" class="layui-input">
                </div>

                <label class="layui-form-label" style="width: 110px" id="jcxms">操作时间:</label>
                <div class="layui-input-inline">
                    <input type="text" id="czsj" name="czsj"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 110px"><font class="myred">*</font>项目参数分值:：</label>
                <div class="layui-input-inline">
                    <input type="text" id="xmcsfz" name="xmcsfz" lay-verify="required||number"
                           autocomplete="off" class="layui-input">
                </div>

                <label class="layui-form-label" style="width: 110px" id="qyzt">启用状态:</label>
                <div class="layui-input-inline">
                    <input type="text" id="cssyzt" name="cssyzt"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 110px">项目参数开始日期：</label>
                <div class="layui-input-inline">
                    <input type="text" id="xmcsksrq" name="xmcsksrq"
                           autocomplete="off" class="layui-input">
                </div>

                <label class="layui-form-label" style="width: 110px" id="fdsa">项目参数结束日期:</label>
                <div class="layui-input-inline">
                    <input type="text" id="xmcsjsrq" name="xmcsjsrq"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 110px">对应子系统:</label>
                <div class="layui-input-inline">
                    <select id="systemcode" name="systemcode" lay-filter="select"></select>
                </div>
            </div>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>