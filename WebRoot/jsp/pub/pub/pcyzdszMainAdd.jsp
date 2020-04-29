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

    // pcyzdszmainid主表id
    String v_pcyzdszmainid = StringHelper.showNull2Empty(request.getParameter("pcyzdszmainid"));

%>
<!DOCTYPE html>
<html>
<head>
    <title>法律法规</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        $(function () {
            layui.use(['form', 'layer'], function () {//保存
                form = layui.form;
                layer = layui.layer;
                var lock = true;// 锁住表单   这里定义一把锁
                var url = basePath + '/pub/pub/savePcyzdszMain';
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
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
                            lock = true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            })

            if ($('#pcyzdszmainid').val().length > 0) {
                parent.$.messager.progress({
                    text: '数据加载中....'
                });
                $.post(basePath + '/pub/pub/queryPcyzdszmainObj', {
                            pcyzdszmainid: $('#pcyzdszmainid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                            } else {
                                parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
            }
        });

        // 保存
        function submitForm() {
            $('#save').click();
        }

        //关闭
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div>
    <form id="pcyzdszMainAddfm" class="layui-form" action="" style="padding-top: 50px">
        <input id="pcyzdszmainid" name="pcyzdszmainid" type="hidden" value="<%=v_pcyzdszmainid%>"/>
        <br/>

        <div class="layui-form-item" style="padding-left: 293px">
            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>表名称：</label>

            <div class="layui-input-inline" style="width: 45%">
                <input type="text" id="tabname" name="tabname" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-left: 293px">
            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>表描述：</label>

            <div class="layui-input-inline" style="width: 45%">
                <input type="text" id="tabnamedesc" name="tabnamedesc" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-left: 293px;padding-top: 30px">
            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>列名称：</label>

            <div class="layui-input-inline" style="width: 45%">
                <input type="text" id="colname" name="colname" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-left: 293px;padding-top: 30px">
            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>列描述：</label>

            <div class="layui-input-inline" style="width: 45%">
                <input type="text" id="colnamedesc" name="colnamedesc" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none">
            <div class="layui-input-inline">
                <button class="layui-btn" lay-submit="" lay-filter="save"
                        id="save">保存
                </button>
            </div>
        </div>
    </form>
</div>
</body>
</html>