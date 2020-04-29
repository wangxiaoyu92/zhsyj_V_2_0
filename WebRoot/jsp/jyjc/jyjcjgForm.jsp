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
    String jcjgid = StringHelper.showNull2Empty(request.getParameter("jcjgid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测录入</title>
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
        var laydate;

        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
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
                var jcjgid = '<%=jcjgid%>';
                if (jcjgid != "" && jcjgid != null) {
                    $.post(basePath + '/jyjc/queryJyjcjgDTO', {
                                jcjgid: jcjgid
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
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#impjcsj').attr('disabled', true);
                        $("#jcjylb").attr('disabled', true);
                    }
                }
            });
            intSelectData('jcjylb', v_jcjylb);
            intSelectData('impjcjg', v_jyjcjl);
        });
        // 保存
        var submitForm = function () {
            checkBzz();
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
                    $("#comdm").val(myrow.comdm); //公司代码
                    $("#comid").val(myrow.comid);//公司id
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
                    $("#jcypid").val(myrow.jcypid); //样品id
                    $("#jcypmc").val(myrow.jcypmc); //样品名称
                }
            });
        }
        //选择项目
        function myselectxm() {
            sy.modalDialog({
                title: '项目信息'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'pub/pub/selectjyjcxmIndex'
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
                    $("#jcxmid").val(myrow.jcxmid); //项目类别
                    $("#jcxmmc").val(myrow.jcxmmc); //项目名称
                    $("#jcxmbzz").val(myrow.jcxmbzz); //标准值
                }
            });
        }
        //验证标准值
        function checkBzz() {
            var bzz = $('#jcxmbzz').val();
            var jgz = $('#imphl').val();

//            //结论    1是合格    2是不合格
            if (parseInt(bzz) > parseInt(jgz)) {
                $("select[name='impjcjg']").find("option[value='1']").attr("selected", true);
                $("select[name='impjcjg']").next().find(".layui-select-title input").attr("value", "合格");
            }
            else {
                $("select[name='impjcjg']").find("option[value='2']").attr("selected", true);
                $("select[name='impjcjg']").next().find(".layui-select-title input").attr("value", "不合格");
            }
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
            <input id="jcjgid" name="jcjgid" type="hidden" value="<%=jcjgid%>"/>
            <input id="comid" name="comid" type="hidden"/>
            <input id="jcypid" name="jcypid" type="hidden"/>

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>检验检测类别:</label>
                            <div class="layui-input-inline">
                                <select id="jcjylb" name="jcjylb" lay-verify="required"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>检测样品名称:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcypmc" name="jcypmc" readonly lay-verify="required"
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectyp()">选择样品 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>受检单位:：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="commc" name="commc" readonly
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
                            <label class="layui-form-label" style="width: 100px" id="jcxms"><font
                                    class="myred">*</font>检测项目名称:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmmc" name="jcxmmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                            </div>
                            <input id="jcxmid" name="jcxmid" type="hidden"/>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectxm()">选择项目 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>标准值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmbzz" name="jcxmbzz" readonly autocomplete="off"
                                       lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>结果值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="imphl" onblur="checkBzz()" name="imphl" autocomplete="off"
                                       lay-verify="required" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检测日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="impjcsj" name="impjcsj"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font class="myred">*</font>结论:</label>

                            <div class="layui-input-inline layui-form" lay-filter="selFilter">
                                <select id="impjcjg" name="impjcjg"  disabled="disabled"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">复检结果:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="fjjg" name="fjjg" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>处理结果:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcjycljg" name="jcjycljg" autocomplete="off" class="layui-input"
                                       lay-verify="number">
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