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
    String cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测录入信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;

        $(function () {
            var id = $("#cydjid").val();
            if (id == "") {
                $("#hide").eq(0).hide();
            }
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
//                laydate({
//                      //是否显示时分秒
//                });
                laydate.render({
                    elem: '#cysj'
                });
                var url = basePath + '/jyjc/saveJyjccydj';
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
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if (id != "" && id != null) {
                    $.post(basePath + '/jyjc/queryJyjccydj', {
                                cydjid: $('#cydjid').val()
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
                        $('form:input').addClass('input_readonly');
                        $('form:input').attr('readonly', 'readonly');
                        $('input').attr('disabled', 'true');
                        $('#myselectcom').hide();
                        $('#bcytel').css("width", '228px')
                    }
                }
            });
        });
        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };

        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['80%', '80%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == "") {
                    return false;
                }
                sy.removeWinRet(dialogID);
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#bcydwcomid").val(myrow.comid); //公司id
                    $("#bcydw").val(myrow.comdm); //公司名称
                    $("#bcydwdz").val(myrow.comdz); //公司地址
                    $("#bcydwfl").val(myrow.comdalei); //公司分类
                    $("#tel").val(myrow.comyddh); //公司练习电话
                }
            });
        }


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
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="jyjcjgForm" style="padding-left: 66px">
            <input id="cydjid" name="cydjid" type="hidden" value="<%=cydjid%>"/>
            <input id="bcydwcomid" name="bcydwcomid" type="hidden"/>
            <input id="scdwcomid" name="scdwcomid" type="hidden"/>

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>被抽样单位:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydw" name="bcydw" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                            </div>

                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" id="bcytel" style="width: 120px">被抽样单位联系电话：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="tel" name="tel" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位地址：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydwdz" name="bcydwdz" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位分类：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydwfl" name="bcydwfl" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>抽样编号:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cybh" name="cybh"
                                       autocomplete="off" class="layui-input" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">样品名称:</label>

                            <div class="layui-input-inline layui-form">
                                <input type="text" id="ypmc" name="ypmc"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">样品批号或生产日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ypbh" name="ypbh" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽样时间:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cysj" name="cysj" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font
                                    class="myred">*</font>抽样数量:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="countcy" name="countcy" autocomplete="off"
                                       lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">生产单位:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="scdw" name="scdw" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽样经手人:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cyjsr" name="cyjsr" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽样分类:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cyfl" name="cyfl" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item" id="hide">
                            <label class="layui-form-label" style="width: 120px">经办时间:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae036" name="aae036" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">经办人:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae011" name="aae011" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
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