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
    String itemid = StringHelper.showNull2Empty(request.getParameter("itemid"));
    String contentid = StringHelper.showNull2Empty(request.getParameter("contentid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>项目内容</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        var contentImpt =
        <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>
        var cb_aaa027;
        var grid;
        var contentimptCommbox;
        var form;
        var layer;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                //评分分值判断
                form.verify({
                    num: function (value) {
                        if (value >= 100 || value < 0) {
                            return '请在0~100之间输入!';
                        }
                    }
                });
                form.render();
                var lock = true;// 锁住表单   这里定义一把锁
                var url = basePath + '/supervision/checkinfo/saveContent';

                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "ok";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;
                        }

                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
                /*//下拉列表
                 intSelectData('contentimpt',contentImpt);*/

                if ($('#contentid').val().length > 0) {
                    $.post(basePath + '/supervision/checkinfo/queryContentByContent', {
                                contentid: $('#contentid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    for (var attr in mydata) {
                                        $("#" + attr).val(mydata[attr]);
                                    }
                                    form.render(); //刷新渲染
                                }
                            }, 'json');

                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#contentimpt').attr('disabled', true);
                        $('.Wdate').attr('disabled', true);
                        /*contentimptCommbox.combobox('disable',true);*/
                    }
                }
            });
            //下拉列表
            intSelectData('contentimpt', contentImpt);
        });

        function submitForm() {
            if ($('#contentscore').val()) {
                $('#contentscore').attr('lay-verify', "num");
            } else {
                $('#contentscore').removeAttr('lay-verify', "num");
            }
            $("#saveRoleBtn").click();
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>

<body>
<div class="layui-table">
    <form id="fm" class="layui-form" action="">
        <div class="layui-container">
            <div class="layui-row">
                <div class="layui-col-md8 layui-col-xs12 layui-col-sm12 layui-col-md-offset2 layui-col-xs-offset0 layui-col-sm-offset0">
                    <input name="filepath" id="filepath" type="hidden"/>
                    <div class="layui-form-item">
                        <label class="layui-form-label">内容ID：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <input type="text" name="contentid" id="contentid" readonly
                                   value='<%=contentid%>' autocomplete="off" class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">项目ID：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <input type="text" name="itemid" id="itemid" readonly
                                   value='<%=itemid%>' autocomplete="off" class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><font class="myred">*</font>编号：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <input type="text" name="contentcode" id="contentcode" required lay-verify="required"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><font class="myred">*</font>重要性：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <select id="contentimpt" name="contentimpt" lay-verify="required">
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">评级分值：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <input type="text" name="contentscore" id="contentscore" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><font class="myred">*</font>排序号：</label>

                        <div class="layui-input-inline" style="width: 80%">
                            <input type="text" name="contentsortid" id="contentsortid" lay-verify="required||number"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label"><font class="myred">*</font>项目内容：</label>

                        <div class="layui-input-block" style="width: 80%">
                            <textarea id="content" name="content" placeholder="请输入内容" class="layui-textarea"
                                      lay-verify="required"></textarea>
                        </div>
                    </div>
                    <%--<input id="contentid" name="contentid" hidden="true" value='<%=contentid%>'/>--%>

                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="save" id="saveRoleBtn">保存
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>