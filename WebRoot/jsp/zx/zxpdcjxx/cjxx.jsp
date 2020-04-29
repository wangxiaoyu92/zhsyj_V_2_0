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
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String cjid = StringHelper.showNull2Empty(request.getParameter("cjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>采集信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">

        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            $(".ss").hide();
            //项目代码
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/zx/zxpdcjxx/cjxx';
                initSelect();
                form.render();
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
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
                        }
                        lock = true;//业务逻辑执行失败了，打开锁
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                form.on('select(select)', function (data) {
                    var xm = $("#xmcsdm option:selected").val();
                    $.ajax({
                        url: basePath + "/zx/zxpdcjxx/xmcs?cssyzt=1&xmcsbm=" + xm,
                        dataType: "json",
                        success: function (result) {
                            $('#cjdf').val(result.data.xmcsfz);
                        }
                    })
                })
                if ($('#cjid').val().length > 0) {
                    $.post(basePath + '/zx/zxpdcjxx/xmcsbox', {
                                cjid: $('#cjid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    form.render('select');
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');

                    if ('<%=op%>' == 'view') {
                        $('form:input').addClass('input_readonly');
                        $('form:input').attr('readonly', 'readonly');
                        $('input').attr('disabled', 'true');
                        $('textarea').attr('disabled', 'true');
                        $('.ss').show();
                        $("#xmcsdm").attr('disabled', 'true');
                    }
                }
            });
        })

        function initSelect() {
            $.ajax({
                url: basePath + "/zx/zxpdcjxx/xmcs?cssyzt=1",
                dataType: "json",
                success: function (result) {
                    var data = result.rows;
                    var html = "<option value=''></option>";
                    for (var i = 0; i < data.length; i++) {
                        html += "<option value='" + data[i].xmcsbm + "'>" + data[i].xmcsmc + "</option>";
                    }
                    $("#xmcsdm").append(html);
                    form.render('select');
                },
                error: function () {
                    parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                }
            })
        }
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds()
                    , singleSelect: "true"
//                    , comjyjcbz: "1"
                }
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }
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
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <input type="hidden" id="cjid" name="cjid" value="<%=cjid%>">
                            <label class="layui-form-label" style="width: 113px"><font
                                    class="myred">*</font>企业id:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comid" name="comid"
                                       autocomplete="off" readonly class="layui-input" lay-verify="required">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="btnselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" id="bcytel" style="width: 113px">企业名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="commc" name="commc" readonly="readonly"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 113px"><font
                                    class="myred">*</font>评定项目代码：</label>

                            <div class="layui-input-inline">
                                <select id="xmcsdm" name="xmcsdm"
                                        lay-verify="required" lay-filter="select">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 113px">得分：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cjdf" name="cjdf" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item ss">
                            <label class="layui-form-label" style="width: 113px">操作人姓名:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="czyxm" name="czyxm" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item ss">
                            <label class="layui-form-label" style="width: 113px">年度:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="niandu" name="niandu" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 113px">备注:</label>

                            <div class="layui-input-inline" style="width: 75%" >
                    <textarea placeholder="请输入内容" id="beizhu" name="beizhu"
                              class="layui-textarea"></textarea>
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
            </div>
        </form>
    </div>
</div>
</body>
</html>