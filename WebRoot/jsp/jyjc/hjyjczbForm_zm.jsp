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
    String cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));
    String jcbgrz = StringHelper.showNull2Empty(request.getParameter("jcbgrz"));
    String hjyjczbid = StringHelper.showNull2Empty(request.getParameter("hjyjczbid"));
    Sysuser sysuser = SysmanageUtil.getSysuser();
    String userdalei = sysuser.getUserdalei();
    String aaz001 = sysuser.getAaz001();
    String description = sysuser.getDescription();

%>
<!DOCTYPE html>
<html>
<head>
    <title>检测报告主表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var cydjid = '<%=cydjid%>';
        var hjyjczbid = '<%=hjyjczbid%>';
        var v_shifoubz = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        var v_jcjyshbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#jsbgrq'
                });
                laydate.render({
                    elem: '#bgsdrq'
                });
                laydate.render({
                    elem: '#jcksrq'
                });
                laydate.render({
                    elem: '#jcjsrq'
                });
                var url = basePath + '/jyjc/saveHjyjczb_zm';
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
                if (hjyjczbid != "" && hjyjczbid != null) {
                    $.post(basePath + '/jyjc/queryHjyjczb_zm', {
                                hjyjczbid: hjyjczbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    form.render();
                                    if ($('#jcorgid').val().length > 0) {
                                        $('#selectjcry').removeAttr('style');
                                        $('#selectjcry').attr('style', 'width: auto;');
                                    }
                                    if ($('#jcryid').val().length > 0) {
                                        $('#selectsbxh').removeAttr('style');
                                        $('#selectsbxh').attr('style', 'width: auto;');
                                    }
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "数据获取失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('#jcjyshwtgyy').attr('readonly', 'readonly');
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                    }
                }
                //查询检测登记表获取被检测单位Id和名称
                if (cydjid != "" && cydjid != null) {
                    $.post(basePath + '/jyjc/queryJyjccydj_zm', {
                                cydjid: cydjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('#hviewjgztid').val(mydata.bcydwcomid);
                                    $('#hviewjgztmc').val(mydata.bcydw);
                                    form.render();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "监测主体查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                }
            });
            intSelectData('cybgsfla', v_shifoubz);
            intSelectData('jcjylb', v_jcjylb);
            intSelectData('jcjyshbz', v_jcjyshbz);
            if ('add' == '<%=op%>') {
                if ("2" == '<%=userdalei%>') {
                    $('#jcorgid').val('<%=aaz001%>');
                    $('#jcorgmc').val('<%=description%>');
                }
            }
            if ($('#jcorgid').val().length > 0) {
                $('#selectjcry').removeAttr('style');
                $('#selectjcry').attr('style', 'width: auto;');
            }
            if ($('#jcryid').val().length > 0) {
                $('#selectsbxh').removeAttr('style');
                $('#selectsbxh').attr('style', 'width: auto;');
            }
        });
        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };

        //选择商品
        function selectsp() {
            parent.sy.modalDialog({
                title: '选择商品'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'pub/pub/selectjyjcypIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                sy.removeWinRet(dialogID);//不可缺少
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#jcypid").val(myrow.jcypid); //样品id
                    $("#jcypmc").val(myrow.jcypmc); //样品名称
                }
            });
        }

        //选择设备
        function selectsbxh() {
            parent.sy.modalDialog({
                title: '选择设备'
                , area: ['100%', '100%']
                , param: {
                    hviewjgztid: $('#jcorgid').val()
                }
                , content: basePath + '/tmsyjhtgl/selectJianceyiqiIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                sy.removeWinRet(dialogID);//不可缺少
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#sbxh").val(myrow.jcyqxh); //设备型号
                    $("#sbxlh").val(myrow.jcyqxlh); //设备序列号
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

        //选择检测人员
        function selectjcry() {
            parent.sy.modalDialog({
                title: '选择检测人员'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectuserIndex'
//                , content: basePath + 'jyjc/jcjgryglIndex'
                , param: {'usercomid': $('#jcorgid').val(), 'querykind': 'comusersel'}
//                , param: {'commc': $('#jcorgid').val(), 'querytype': 'jyjc'}
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
                    var myrow = obj.data[0];
                    $("#jcryid").val(myrow.userid); //人员id
                    $("#jcrymc").val(myrow.description); //人员名称
                    $('#selectsbxh').removeAttr('style');
                    $('#selectsbxh').attr('style', 'width: auto;');
                }
            });
        }

        //选择案件
        function selectajdjid() {
            parent.sy.modalDialog({
                title: '选择案件'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectajdjidIndex'
                , param: {'commc': $('#hviewjgztmc').val()}
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
                    $("#ajdjid").val(myrow.ajdjid); //案件登记Id
                    $("#ajdjbh").val(myrow.ajdjbh); //案件登记编号
                }
            });
        }
        function selectCjssxz(){
            parent.sy.modalDialog({
                title: '选择抽检实施细则'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jycjssxzIndex?op=select'
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
                    $("#jycjssxzid").val(myrow.jycjssxzid);
                }
            });
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="jyjcjgForm" style="padding-left: 66px;height: 400px">
            <input type="hidden" id="hviewjgztid" name="hviewjgztid"/> <%--监管主体表id--%>
            <input type="hidden" id="jcztbzjid" name="jcztbzjid" value="<%=cydjid%>"/> <%--检测主体表主键id--%>
            <input type="hidden" id="jcbgrz" name="jcbgrz" value="<%=jcbgrz%>"/> <%--抽检报告日志参数--%>
            <input type="hidden" id="hjyjczbid" name="hjyjczbid" value="<%=hjyjczbid%>"/> <%--检验检测主表id--%>
            <input type="hidden" id="jcypid" name="jcypid"/> <%--商品Id--%>
            <input type="hidden" id="jcorgid" name="jcorgid"/> <%--机构id--%>
            <input type="hidden" id="jcryid" name="jcryid"/> <%--人员id--%>
            <input type="hidden" id="sjcsfs" name="sjcsfs" value="0"/> <%--0手工录入1机器录入--%>
            <input type="hidden" id="detectiondatatype" name="detectiondatatype" value="1"/> <%--抽样登记数据--%>

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">监管主体名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="hviewjgztmc" name="hviewjgztmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽样登记ID：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cydjid" name="cydjid" value="<%=cydjid%>" autocomplete="off"
                                       readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检验检测报告编号：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jyjcbgbh" name="jyjcbgbh"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">商品名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcypmc" name="jcypmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectsp()">选择商品</a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测检验类别：</label>

                            <div class="layui-input-inline">
                                <select id="jcjylb" name="jcjylb"></select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测机构名称：</label>

                            <div class="layui-input-inline">
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
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测人员名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcrymc" name="jcrymc" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="selectjcry" style="width: auto;display:none">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectjcry()">检测人员</a>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">设备型号：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="sbxh" name="sbxh" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="selectsbxh" style="width: auto;display:none">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectsbxh()">选择设备</a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">设备序列号：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="sbxlh" name="sbxlh" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">收到报告日期：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jsbgrq" name="jsbgrq" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">报告送达日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bgsdrq" name="bgsdrq" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" >
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测开始日期:</label>

                            <div class="layui-input-inline layui-form">
                                <input type="text" id="jcksrq" name="jcksrq" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测结束日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcjsrq" name="jcjsrq" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <% if ("view".equals(op) || "audit".equals(op)){%>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">审核标志:</label>

                            <div class="layui-input-inline">
                                <select id="jcjyshbz" name="jcjyshbz"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item" style="width: auto">
                            <label class="layui-form-label" style="width: 120px">审核未通过原因:</label>

                            <div class="layui-input-inline" style="width: 80%">
                                <textarea id="jcjyshwtgyy" name="jcjyshwtgyy"
                                          style="width:80%;height: 150px"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">是否立案:</label>

                            <div class="layui-input-inline">
                                <select id="cybgsfla" name="cybgsfla"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">案件登记id:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ajdjid" name="ajdjid" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="selectajdjid" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectajdjid()">选择案件</a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">案件登记编号:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ajdjbh" name="ajdjbh" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <%}%>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">操作员:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae011" name="aae011" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">操作日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae036" name="aae036" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽检实施细则：</label>
                            <div class="layui-input-inline" style="width:60%;">
                                <input type="text" id="jycjssxzid" name="jycjssxzid" autocomplete="off" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" >
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="selectCjssxz()">选择抽检实施细则 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <%--<div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                            </button>
                        </div>
                    </div>--%>
                    <% if (!"view".equalsIgnoreCase(op)) {%>
                    <div class="layui-col-md12 layui-col-md-offset4">
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button  class="layui-btn" lay-submit="" lay-filter="save" id="saveZbBtn">保存主表信息
                                </button>
                            </div>
                        </div>
                    </div>
                    <%} %>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>