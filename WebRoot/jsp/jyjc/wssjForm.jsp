<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String v_jyjcwssjid = StringHelper.showNull2Empty(request.getParameter("jyjcwssjid"));
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String userkind = sysuser.getUserkind();
%>
<!DOCTYPE html>
<html>
<head>
    <title>网上送检</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        //检测检验审核标志
        var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;

        $(function () {
            intSelectData('shbz', v_shbz);
            $('#shbz').val(0);
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#sqsj'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#shsj'
                    , type: 'datetime'
                });

                var url = basePath + '/jyjc/saveWssj';
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
                if ($('#jyjcwssjid').val().length > 0) {
                    $.post(basePath + '/jyjc/queryWssjDTO', {
                                jyjcwssjid:'<%=v_jyjcwssjid%>'
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
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
                        $('form :input').attr('readonly', 'readonly');
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                    }
                }
                if("30" =='<%=userkind%>'){
                    $('#shbz').attr('readonly','readonly').attr('disabled', true);
                    $('#shwtgyy').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#shczyname').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#shsj').attr('readonly','readonly').attr('disabled', true)
                            .addClass('layui-bg-gray');
                    $('#jcorgmc').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#selectjg').css('display', 'none');
                    //$('#sqsj').attr('lay-verify','required')
                    form.render();
                }else {
                    $('#myselectcom').css('display', 'none');
                    $('#myselectwp').css('display', 'none');
                    $('#commc').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#lxr').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#lxdh').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#sqjcwp').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#sqyy').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#sqczyname').attr('readonly','readonly').addClass('layui-bg-gray');
                    $('#sqsj').attr('readonly','readonly').attr('disabled', true).addClass('layui-bg-gray');
                   // $('#shsj').attr('lay-verify','required')
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
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
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
                }
            });
        }
        function myselectyp() {
            sy.modalDialog({
                title: '选择样品'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'pub/pub/selectjyjcypIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                sy.removeWinRet(dialogID);//不可缺少
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#sqjcwp").val(myrow.jcypmc); //样品名称
                }
            });
        }
        //选择检测机构
        function selectjg() {
            parent.sy.modalDialog({
                title: '选择检测机构'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , param: {querytype: "jyjc"}
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
                    $("#jcorgid").val(myrow.comid); //公司名称
                    $("#jcorgmc").val(myrow.commc); //公司代码
                    $('#selectjcry').removeAttr('style');
                    $('#selectjcry').attr('style', 'width: auto;');
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
        <form class="layui-form" action="" id="jyjcjgForm">
            <input id="jyjcwssjid" name="jyjcwssjid" type="hidden" value="<%=v_jyjcwssjid%>"/>
            <input id="sqczyid" name="sqczyid" type="hidden"/>
            <input id="shczyid" name="shczyid" type="hidden"/>
            <input id="jcorgid" name="jcorgid" type="hidden"/>
            <div class="layui-container">

                <div class="layui-row">
                    <div class="layui-form-item">
                            <div class="layui-col-md2" >
                            <label class="layui-form-label" style="width: 160px;"><font color="red">*</font>单位名称：</label>
                            </div>
                            <div class="layui-col-md10" >
                            <div class="layui-input-inline" style="width: 85%">
                                <input type="text" id="commc" name="commc"
                                       autocomplete="off" class="layui-input" lay-verify="required">
                            </div>
                            </div>

<%--                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                            </div>
                            <%} %>--%>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                            <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;"><font color="red">*</font>联系人：</label>
                            </div>
                            <div class="layui-col-md4" >
                            <div class="layui-input-inline">
                                <input type="text" id="lxr" name="lxr" class="layui-input " lay-verify="required">
                            </div>
                            </div>
                            <div class="layui-col-md2" >
                                <label class="layui-form-label" style="width: 160px;"><font color="red">*</font>联系人电话：</label>
                            </div>
                            <div class="layui-col-md4" >
                                <div class="layui-input-inline">
                                    <input type="text" id="lxdh" name="lxdh" class="layui-input" lay-verify="required">
                                </div>
                            </div>
                    </div>
                </div>
                <div class="layui-row">

                    <div class="layui-form-item">
                        <div class="layui-col-md2 ">
                            <label class="layui-form-label" style="width: 160px;"><font color="red">*</font>申请检测物品名称：</label>
                        </div>
                        <div class="layui-col-md10 ">
                            <div class="layui-input-inline" style="width: 85%">
                                <input type="text" id="sqjcwp" name="sqjcwp"  lay-verify="required"
                                       autocomplete="off" class="layui-input ">
                            </div>
<%--                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectwp" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectyp()">选择样品 </a>
                            </div>
                            <%} %>--%>
                        </div>
                    </div>
                </div>
                <div class="layui-row">

                        <div class="layui-form-item" >
                            <div class="layui-col-md2 ">
                            <label class="layui-form-label" style="width: 160px;"><font color="red">*</font>申请原因:</label>
                            </div>
                                <div class="layui-col-md10">
                            <div class="layui-input-inline" style="width: 85%">
                                <textarea id="sqyy" name="sqyy"
                                          style="width: 100%;height: 150px" lay-verify="required"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                        <div class="layui-form-item">
                            <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;">申请操作员姓名:</label>
                            </div>
                            <div class="layui-col-md4">
                            <div class="layui-input-inline" >
                                <input type="text" id="sqczyname" name="sqczyname"  readonly
                                       class="layui-input layui-bg-gray">
                            </div>

                            </div>
                            <div class="layui-col-md2">
                                <label class="layui-form-label" style="width: 160px;">申请日期:</label>
                            </div>
                            <div class="layui-col-md4">
                                <div class="layui-input-inline">
                                    <input type="text" id="sqsj" name="sqsj" readonly disabled
                                           autocomplete="off" class="layui-input layui-bg-gray">
                                </div>
                            </div>

                        </div>
                    </div>
                <div class="layui-row">

                        <div class="layui-form-item">
                            <div class="layui-col-md2">
                                <label class="layui-form-label" style="width: 160px;">审核标志：</label>
                            </div>
                            <div class="layui-col-md10">
                                <div class="layui-input-inline">
                                    <select id="shbz" name="shbz"></select>
                                </div>
                            </div>
                        </div>
                </div>
            <div class="layui-row">

                        <div class="layui-form-item">
                            <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;">审核未通过原因:</label>
                            </div>
                            <div class="layui-col-md10">
                            <div class="layui-input-inline" style="width: 85%">
                                <textarea id="shwtgyy" name="shwtgyy"
                                          style="width:100%;height: 150px"></textarea>
                            </div>
                            </div>
                        </div>
            </div>

            <div class="layui-row">

                        <div class="layui-form-item">
                            <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;">检测机构名称：</label>
                            </div>
                                <div class="layui-col-md10">
                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="jcorgmc" name="jcorgmc" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="selectjg" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectjg()">选择机构</a>
                            </div>
                            <%} %>
                                </div>
                        </div>
            </div>
                <div class="layui-row">

                    <div class="layui-form-item">
                        <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;">审核操作员姓名:</label>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-input-inline">
                                <input type="text" id="shczyname" name="shczyname" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-col-md2">
                            <label class="layui-form-label" style="width: 160px;">审核日期:</label>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-input-inline">
                                <input type="text" id="shsj" name="shsj" readonly disabled
                                       autocomplete="off" class="layui-input layui-bg-gray">
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
        </form>
</div>
</body>
</html>