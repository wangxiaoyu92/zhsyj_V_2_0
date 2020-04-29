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
    String v_pcyzdszmainid = StringHelper.showNull2Empty(request.getParameter("pcyzdszmainid"));
    String v_pcyzdszdetailid = StringHelper.showNull2Empty(request.getParameter("pcyzdszdetailid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));

%>
<!DOCTYPE html>
<html>
<head>
    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var form;
        var layer;
        $(function () {
            intSelectData('aae140',v_aae140);
            layui.use(['form', 'layer'], function () {//保存
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/pub/pub/savePcyzdszAdd';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
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
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#pcyzdszdetailid').val().length > 0) {
                    $.post(basePath + '/pub/pub/queryPcyzdszdetailObj', {
                                pcyzdszdetailid: $('#pcyzdszdetailid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    $('#avalue').text(mydata.avalue);
                                    form.render();
                                } else {
                                    parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                                }
                                parent.$.messager.progress('close');
                            }, 'json');
                }
            })
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
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="pcyzdszAddfm" class="layui-form" action="">
            <input id="pcyzdszmainid" name="pcyzdszmainid" type="hidden" value="<%=v_pcyzdszmainid%>"/>
            <input id="pcyzdszdetailid" name="pcyzdszdetailid" type="hidden" value="<%=v_pcyzdszdetailid %>"/>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>大类：</label>

                <div class="layui-input-inline" style="width: 80%">
                    <select name="aae140" id="aae140" required lay-verify="required"></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>值：</label>

                <div height="100px" class="layui-input-inline" style="width: 80%">
                    <textarea id="avalue" name="avalue" class="layui-textarea" lay-verify="required" rows="10"></textarea>
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
</div>
</body>
</html>