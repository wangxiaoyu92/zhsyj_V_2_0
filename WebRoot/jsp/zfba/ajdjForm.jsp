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
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        var mygrid;
        var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
        var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        var v_zxxmcsbm = <%=SysmanageUtil.getComboZxxmcsbm("1")%>;
        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate

        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#ajdjafsj'
                });
                var url = basePath + '/zfba/ajdj/saveAjdj';
                form.verify({
                    comyzbm: function (value, item) {
                        if (!new RegExp("^[0-9]\\d{5}$").test(value)) {
                            return '邮编格式不正确';
                        }
                    }
                });
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
            });
            intSelectData('aae140', v_aae140);
            intSelectData('ajdjajly', v_AJDJAJLY);
            if ($('#ajdjid').val().length > 0) {
                $.post(basePath + '/zfba/ajdj/queryAjdjDTO', {
                            ajdjid: $('#ajdjid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                for (var attr in mydata) {
                                    $("#" + attr).val(mydata[attr]);
                                }
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
                    //$('#btnselectcom').attr('visible',false);
                    $('#myselectcom').css('display', 'none');
                    $('#myselectay').css('display', 'none');
                    $('#aae140').attr('disabled', 'disabled');
                    $('#ajdjajly').attr('disabled', 'disabled');
                    $('#ajdjafsj').attr('disabled', 'disabled');
                }
            }
        });
        // 保存
        var submitForm = function () {
            if ($('#comfrsfzh').val()) {
                $('#comfrsfzh').attr('lay-verify', "identity");
            } else {
                $('#comfrsfzh').removeAttr('lay-verify', "identity");
            }
            if ($('#comyddh').val()) {
                $('#comyddh').attr('lay-verify', "phone");
            } else {
                $('#comyddh').removeAttr('lay-verify', "phone");
            }
            if ($('#comyzbm').val()) {
                $('#comyzbm').attr('lay-verify', "comyzbm");
            } else {
                $('#comyzbm').removeAttr('lay-verify', "comyzbm");
            }
            $("#saveAjdjBtn").click();
        };

        //从单位信息表中读取
        function myselectcom() {
            parent.sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comdm").val(myrow.comdm); //公司代码
                    $("#comid").val(myrow.comid); //公司id
                    $("#comdz").val(myrow.comdz); //企业地址
                    $("#comfrhyz").val(myrow.comfrhyz); //法人/业主
                    $("#comfrsfzh").val(myrow.comfrsfzh); //法人/业主身份证号
                    $("#comyzbm").val(myrow.comyzbm); //邮政编码
                    $("#comyddh").val(myrow.comyddh); //电话号码
                }
            });
        }

        //从单位信息表中读取
        function myselectay() {
            parent.sy.modalDialog({
                title: '选择案由'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectayIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#ajdjay").val(myrow.wfxwms); // 案件登记案由
                }
            });
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        ;

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="ajdjAddDlgfm">
            <div class="layui-container">
                <input type="hidden" id="comdm" name="comdm">
                <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>

                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font class="myred">*</font>案件来源登记表编号：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ajdjbh" name="ajdjbh" lay-verify="required"
                                       autocomplete="off" class="layui-input" value="()食药监食案源(2016) 号">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font
                                    class="myred">*</font>企业ID：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comid" name="comid" readonly lay-verify="required"
                                       autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn "
                                   iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font
                                    class="myred">*</font>企业名称：</label>

                            <div class="layui-input-inline" style="width: 75%">
                                <input type="text" id="commc" name="commc" lay-verify="required" readonly="readonly"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">企业地址：</label>

                            <div class="layui-input-inline" style="width: 75%">
                                <input type="text" id="comdz" name="comdz" readonly="readonly"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">企业法人/业主:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comfrhyz" name="comfrhyz" readonly="readonly"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">法人/业主身份证号:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comfrsfzh" name="comfrsfzh"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">联系电话:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comyddh" name="comyddh" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">邮政编码:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comyzbm" name="comyzbm" lay-verify="comyzbm"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font
                                    class="myred">*</font>登记时间:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ajdjafsj" name="ajdjafsj" lay-verify="required"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font
                                    class="myred">*</font>案件大类:</label>

                            <div class="layui-input-inline">
                                <select id="aae140" name="aae140" lay-verify="required"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px"><font
                                    class="myred">*</font>案件来源:</label>

                            <div class="layui-input-inline">
                                <select id="ajdjajly" name="ajdjajly" lay-verify="required"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">案由:</label>

                            <div class="layui-input-inline" style="width: 65%">
                                <textarea class="layui-textarea" id="ajdjay" name="ajdjay"></textarea>
                            </div>
                            <div class="layui-input-inline" style="width: auto" id="myselectay">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectay()">选择案由 </a>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"
                                   style="width: 130px">案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等):</label>

                            <div class="layui-input-inline" style="width: 75%">
                                <textarea class="layui-textarea" id="ajdjjbqk" name="ajdjjbqk"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 130px">违法事实:</label>

                            <div class="layui-input-inline" style="width: 75%">
                                <textarea class="layui-textarea" id="ajdjwfss" name="ajdjwfss"></textarea>
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