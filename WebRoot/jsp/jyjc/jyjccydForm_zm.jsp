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
    String cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));//抽样登记Id
    String jyjccydid = StringHelper.showNull2Empty(request.getParameter("jyjccydid"));//抽样单Id
%>
<!DOCTYPE html>
<html>
<head>
    <title>抽样单填写(中牟)</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var v_cydjrwlb = <%=SysmanageUtil.getAa10toJsonArray("CYDJRWLB")%>;//任务类别
        var v_cydjqylx = <%=SysmanageUtil.getAa10toJsonArray("CYDJQYLX")%>;//区域类型
        var v_cyddschj = <%=SysmanageUtil.getAa10toJsonArray("CYDDSCHJ")%>;//生产环节
        var v_cyddschjcpk = <%=SysmanageUtil.getAa10toJsonArray("CYDDSCHJCPK")%>;//生产环节成品库
        var v_cyddlthj = <%=SysmanageUtil.getAa10toJsonArray("CYDDLTHJ")%>;//流通环节
        var v_cyddcyhj = <%=SysmanageUtil.getAa10toJsonArray("CYDDCYHJ")%>;//餐饮环节
        var v_cyddcyhjcg = <%=SysmanageUtil.getAa10toJsonArray("CYDDCYHJCG")%>;//餐馆环节
        var v_cyddcyhjst = <%=SysmanageUtil.getAa10toJsonArray("CYDDCYHJST")%>;//食堂环节
        var v_ypxxyply = <%=SysmanageUtil.getAa10toJsonArray("YPXXYPLY")%>;//样品来源
        var v_ypxxypsx = <%=SysmanageUtil.getAa10toJsonArray("YPXXYPSX")%>;//样品属性
        var v_ypxxyplx = <%=SysmanageUtil.getAa10toJsonArray("YPXXYPLX")%>;//样品类型
        var v_ypxxscjggjrqlb = <%=SysmanageUtil.getAa10toJsonArray("YPXXSCJGGJRQLB")%>;//样品信息生产加工购进日期类别
        var v_sfck = <%=SysmanageUtil.getAa10toJsonArray("AAA104")%>;//是否出口
        var v_ypxxypxt = <%=SysmanageUtil.getAa10toJsonArray("YPXXYPXT")%>;//样品形态
        var v_ypxxbzfl = <%=SysmanageUtil.getAa10toJsonArray("YPXXBZFL")%>;//包装分类
        var v_cysypdcc = <%=SysmanageUtil.getAa10toJsonArray("CYSYPDCC")%>;//样品存储方式
        var v_cyypbz = <%=SysmanageUtil.getAa10toJsonArray("CYYPBZ")%>;//样品包装类型
        var v_cyfs = <%=SysmanageUtil.getAa10toJsonArray("CYFS")%>;//抽样方式
        var v_bcydwyj = <%=SysmanageUtil.getAa10toJsonArray("BCYDWYJ")%>;//被抽检单位意见
        var v_sczyj = <%=SysmanageUtil.getAa10toJsonArray("BCYDWYJ")%>;//生产者意见
        var cydjid = '<%=cydjid%>';
        var jyjccydid = '<%=jyjccydid%>';
        $(function () {
            layui.use(['form', 'layer', 'laydate', 'element'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                var element = layui.element;
                laydate.render({
                    elem: '#ypxxscjggjrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#jsypjzrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#bcydwqmrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#cydwgzrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#sczqmrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#aae036'
                    , type: 'datetime'
                });
                var url = basePath + '/jyjc/saveJyjccyd_zm';
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
                if (jyjccydid != "" && jyjccydid != null) {
                    $.post(basePath + '/jyjc/queryJyjccyd_zm', {
                                jyjccydid: jyjccydid,
                                cydjid: cydjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    if (mydata.cyddlthjqt != null && mydata.cyddlthjqt != '') {
                                        $('#cyddlthjqtid').removeAttr('style');
                                        $('#cyddlthjqtid').attr('style', 'width: auto;');
                                    }
                                    if (mydata.cyddcyhjqt != null && mydata.cyddcyhjqt != '') {
                                        $('#cyddcyhjqtid').removeAttr('style');
                                        $('#cyddcyhjqtid').attr('style', 'width: auto;');
                                    }
                                    if (mydata.ypxxyplyqt != null && mydata.ypxxyplyqt != '') {
                                        $('#ypxxyplyqtid').removeAttr('style');
                                        $('#ypxxyplyqtid').attr('style', 'width: auto;');
                                    }
                                    if (mydata.ypxxyplxqt != null && mydata.ypxxyplxqt != '') {
                                        $('#ypxxyplxqtid').removeAttr('style');
                                        $('#ypxxyplxqtid').attr('style', 'width: auto;');
                                    }
                                    form.render();
                                    $('form').form('load', mydata);
                                    form.render();

                                }
                            }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('form :input').attr('readonly', 'readonly');
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                        $('#aae011id').removeAttr('style');
                        $('#btnselectcjcom').attr('style',"display: none");
                    }
                }

                if (cydjid != "" && cydjid != null) {
                    $.post(basePath + '/jyjc/queryJyjccydj_zm', {
                                cydjid: $('#cydjid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    $('#comid').val(mydata.bcydwcomid);
                                    $('#commc').val(mydata.bcydw);
                                    $('#comdz').val(mydata.bcydwdz);
                                    $('#comnxse').val(mydata.nsxe);
                                    $('#comyyzhh').val(mydata.yyzhh);
                                    $('#comlxr').val(mydata.xlr);
                                    $('#comyddh').val(mydata.tel);
                                    form.render();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                }
                //抽样地点
                var cyddschj, cyddschjcpk;
                //生产环节
                form.on('radio(cyddschjcpk)', function (data) {
                    cyddschjcpk = data.elem;
                    if (cyddschj != null && cyddschj != '') {
                        cyddschj.checked = false;
                        form.render();
                    }
                });
                //成品库
                form.on('radio(cyddschj)', function (data) {
                    cyddschj = data.elem;
                    if (cyddschjcpk != null && cyddschjcpk != '') {
                        cyddschjcpk.checked = false;
                        form.render();
                    }
                });
                //流通环节
                form.on('radio(cyddlthj)', function (data) {
                    if (data.value == '8') {
                        $('#cyddlthjqtid').removeAttr('style');
                        $('#cyddlthjqtid').attr('style', 'width: auto;');
                    } else {
                        $('#cyddlthjqtid').attr('style', 'width: auto;display:none');
                        $('#cyddlthjqt').val('');
                    }
                    form.render();
                });
                //餐饮环节
                var cyddcyhjcg, cyddcyhjst, cyddcyhj;
                //餐馆
                form.on('radio(cyddcyhjcg)', function (data) {
                    cyddcyhjcg = data.elem;
                    if (cyddcyhj != null && cyddcyhj != '') {
                        cyddcyhj.checked = false;
                    }
                    if (cyddcyhjst != null && cyddcyhjst != '') {
                        cyddcyhjst.checked = false;
                    }
                    var dat = {'cyddcyhj': '10'};
                    $('form').form('load', dat);
                    $('#cyddcyhjqtid').attr('style', 'display:none');
                    $('#cyddcyhjqt').val('');
                    form.render();
                });
                //食堂
                form.on('radio(cyddcyhjst)', function (data) {
                    cyddcyhjst = data.elem;
                    if (cyddcyhj != null && cyddcyhj != '') {
                        cyddcyhj.checked = false;
                    }
                    if (cyddcyhjcg != null && cyddcyhjcg != '') {
                        cyddcyhjcg.checked = false;
                    }
                    var dat = {'cyddcyhj': '20'};
                    $('form').form('load', dat);
                    $('#cyddcyhjqtid').attr('style', 'display:none');
                    $('#cyddcyhjqt').val('');
                    form.render();
                });
                //餐饮
                form.on('radio(cyddcyhj)', function (data) {
                    cyddcyhj = data.elem;
                    var cyddcyhj_val = data.value;
                    if (cyddcyhj_val != 10) {
                        if (cyddcyhjcg != null && cyddcyhjcg != '') {
                            cyddcyhjcg.checked = false;

                        }
                    }
                    if (cyddcyhj_val != 20) {
                        if (cyddcyhjst != null && cyddcyhjst != '') {
                            cyddcyhjst.checked = false;
                        }
                    }
                    if (cyddcyhj_val == 80) {
                        $('#cyddcyhjqtid').removeAttr('style');
                    } else {
                        $('#cyddcyhjqtid').attr('style', 'display:none');
                        $('#cyddcyhjqt').val('');
                    }
                    form.render();
                });
                //样品来源
                form.on('radio(ypxxyply)', function (data) {
                    if (data.value == '4') {
                        $('#ypxxyplyqtid').removeAttr('style');
                        $('#ypxxyplyqtid').attr('style', 'width: auto;');
                    } else {
                        $('#ypxxyplyqtid').attr('style', 'width: auto;display:none');
                        $('#ypxxyplyqt').val('');
                    }
                    form.render();
                });
                //样品类型
                form.on('radio(ypxxyplx)', function (data) {
                    if (data.value == '6') {
                        $('#ypxxyplxqtid').removeAttr('style');
                        $('#ypxxyplxqtid').attr('style', 'width: auto;');
                    } else {
                        $('#ypxxyplxqtid').attr('style', 'width: auto;display:none');
                        $('#ypxxyplxqt').val('');
                    }
                    form.render();
                });


            });
            intSelectData('cydjrwlb', v_cydjrwlb);
            intSelectData('cydjqylx', v_cydjqylx);
            intSelectData('ypxxscjggjrqlb', v_ypxxscjggjrqlb);
            intSelectData('sfck', v_sfck);
            intSelectData('ypxxypxt', v_ypxxypxt);
            intSelectData('ypxxbzfl', v_ypxxbzfl);
            intSelectData('cysypdcc', v_cysypdcc);
            intSelectData('cyfs', v_cyfs);
            intSelectData('bcydwyj', v_bcydwyj);
            intSelectData('sczyj', v_sczyj);
            intSelectData('cyypbz', v_cyypbz);
            cyddschj();
            cyddschjcpk();
            cyddlthj();
            cyddcyhj();
            ypxxyply();
            ypxxypsx();
            ypxxyplx();
        });
        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };
        //生产环节
        function cyddschj() {
            var cyddschj = '';
            for (var i = 1; i < v_cyddschj.length; i++) {
                cyddschj += " <input type='radio' lay-filter='cyddschj' name='cyddschj' title='" + v_cyddschj[i].text + "'value='" + v_cyddschj[i].id + "'>"
            }
            $('#cyddschj').html(cyddschj);
        }

        //生产环节成品库
        function cyddschjcpk() {
            var cyddschjcpk = "";
            for (var i = 1; i < v_cyddschjcpk.length; i++) {
                cyddschjcpk += " <input type='radio' lay-filter='cyddschjcpk' name='cyddschjcpk' title='" + v_cyddschjcpk[i].text + "'value='" + v_cyddschjcpk[i].id + "'>"
            }
            $('#cyddschjcpk').html(cyddschjcpk);
        }

        //流通环节
        function cyddlthj() {
            var cyddlthj = "";
            for (var i = 1; i < v_cyddlthj.length; i++) {
                cyddlthj += " <input type='radio' lay-filter='cyddlthj' name='cyddlthj' title='" + v_cyddlthj[i].text + "'value='" + v_cyddlthj[i].id + "'>"
            }
            $('#cyddlthj').html(cyddlthj);
        }

        //餐饮环节
        function cyddcyhj() {
            var cyddcyhj = "";//餐饮
            var cyddcyhjcg = "";//餐馆
            var cyddcyhjst = "";//食堂
            for (var i = 1; i < v_cyddcyhj.length; i++) {
                if (v_cyddcyhj[i].text == '餐馆') {
                    cyddcyhjcg += " <input type='radio' lay-filter='cyddcyhj' name='cyddcyhj' title='" + v_cyddcyhj[i].text + "'value='" + v_cyddcyhj[i].id + "'>" +
                    "(&nbsp;&nbsp;&nbsp;";
                    for (var j = 1; j < v_cyddcyhjcg.length; j++) {
                        cyddcyhjcg += "<input type='radio' lay-filter='cyddcyhjcg' name='cyddcyhjcg' title='" + v_cyddcyhjcg[j].text + "'value='" + v_cyddcyhjcg[j].id + "'>";
                    }
                    cyddcyhjcg += ")<br/>"
                } else if (v_cyddcyhj[i].text == '食堂') {
                    cyddcyhjst += "<input type='radio' lay-filter='cyddcyhj' name='cyddcyhj' title='" + v_cyddcyhj[i].text + "'value='" + v_cyddcyhj[i].id + "'>" +
                    "(&nbsp;&nbsp;&nbsp;";
                    for (var j = 1; j < v_cyddcyhjst.length; j++) {
                        cyddcyhjst += "<input type='radio' lay-filter='cyddcyhjst' name='cyddcyhjst' title='" + v_cyddcyhjst[j].text + "'value='" + v_cyddcyhjst[j].id + "'>";
                    }
                    cyddcyhjst += ")<br/>";
                } else {
                    cyddcyhj += " <input type='radio' lay-filter='cyddcyhj' name='cyddcyhj' title='" + v_cyddcyhj[i].text + "'value='" + v_cyddcyhj[i].id + "'>";
                }
            }
            $('#cyddcyhj').html(cyddcyhjcg + cyddcyhjst + cyddcyhj);
        }

        //样品来源
        function ypxxyply() {
            var ypxxyply = "";
            for (var i = 1; i < v_ypxxyply.length; i++) {
                ypxxyply += " <input type='radio' lay-filter='ypxxyply' name='ypxxyply' title='" + v_ypxxyply[i].text + "'value='" + v_ypxxyply[i].id + "'>";
            }
            $('#ypxxyply').html(ypxxyply);
        }

        //样品属性
        function ypxxypsx() {
            var ypxxypsx = "";
            for (var i = 1; i < v_ypxxypsx.length; i++) {
                ypxxypsx += " <input type='radio' lay-filter='ypxxypsx' name='ypxxypsx' title='" + v_ypxxypsx[i].text + "'value='" + v_ypxxypsx[i].id + "'>";
            }
            $('#ypxxypsx').html(ypxxypsx);
        }

        //样品类型
        function ypxxyplx() {
            var ypxxyplx = "";
            for (var i = 1; i < v_ypxxyplx.length; i++) {
                ypxxyplx += " <input type='radio' lay-filter='ypxxyplx' name='ypxxyplx' title='" + v_ypxxyplx[i].text + "'value='" + v_ypxxyplx[i].id + "'>";
            }
            $('#ypxxyplx').html(ypxxyplx);
        }

        //选择样品
        function jcypmc() {
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
                    console.log(myrow);
                    $('form').form('load', myrow);
                    $('#zxbzjswj').val(myrow.spzxbzh);
                }
            });
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        function myclearCydd() {
            $("input:radio[name='cyddschj']").removeAttr('checked');//生产环节
            $("input:radio[name='cyddschjcpk']").removeAttr('checked');//生产环节成品库
            $("input:radio[name='cyddlthj']").removeAttr('checked');//流通环节
            $("input:radio[name='cyddcyhj']").removeAttr('checked');//餐馆环节
            $("input:radio[name='cyddcyhjcg']").removeAttr('checked');//餐馆
            $("input:radio[name='cyddcyhjst']").removeAttr('checked');//食堂
//            $('input:radio[name=cyddschj]').attr('checked',false);//生产环节
//            $('input:radio[name=cyddschjcpk]').attr('checked',false);//生产环节成品库
//            $('input:radio[name=cyddlthj]').attr('checked',false);//流通环节
//            $('input:radio[name=cyddcyhj]').attr('checked',false);//餐馆环节
//            $('input:radio[name=cyddcyhjcg]').attr('checked',false);//餐馆
//            $('input:radio[name=cyddcyhjst]').attr('checked',false);//食堂
            form.render();
        }

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="cydForm">

            <input type="hidden" id="jyjccydid" name="jyjccydid" value="<%=jyjccydid%>"><%--检验检测抽样单id--%>
            <input type="hidden" id="cydjid" name="cydjid" value="<%=cydjid%>"><%--检验检测抽样登记表id--%>
            <input type="hidden" id="jcypid" name="jcypid"><%--检测样品id--%>
            <input type="hidden" id="comid" name="comid"><%--被检测单位id--%>

            <div class="layui-container">
                <div class="layui-collapse">
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">国家食品安全抽样检验抽样单</h2>

                        <div class="layui-colla-content layui-show">
                            <div class="layui-row">
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 140px">抽样单编号：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cydbh" name="cydbh"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 140px">NO：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cydno" name="cydno"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 140px">任务来源：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cydjrwly" name="cydjrwly"
                                                   autocomplete="off" class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 140px">任务类别：</label>

                                        <div class="layui-input-inline">
                                            <select id="cydjrwlb" name="cydjrwlb" style="disabled:false"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">
                                        <h2 class="layui-colla-title">被抽样单位信息</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">单位名称：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="commc" name="commc"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" id="bcytel"
                                                           style="width: 140px">单位地址：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comdz" name="comdz"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">区域类型：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="cydjqylx" name="cydjqylx"
                                                                style="disabled:false"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">法人代表：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comfrhyz" name="comfrhyz"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">年销售额：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comnxse" name="comnxse"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">营业执照号：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comyyzhh" name="comyyzhh"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">联 系 人：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comlxr" name="comlxr"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">电 话：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comyddh" name="comyddh"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">传 真：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comcz" name="comcz"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">邮 编：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="comyzbm" name="comyzbm"
                                                               autocomplete="off" class="layui-input layui-bg-gray">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">

                                        <h2 class="layui-colla-title">抽样地点</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width:140px;font-size: 1.2em;">生产环节：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="cyddschj"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">成品库：(</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="cyddschjcpk"></div>
                                                    </div>
                                                    <label class="layui-form-label" style="width: auto;font-size:1.2em">)</label>
                                                </div>
                                            </div>

                                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">流通环节：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="cyddlthj"></div>
                                                    </div>
                                                    <div class="layui-input-inline" id="cyddlthjqtid"
                                                         style="width: auto;display:none">
                                                        <label class="layui-form-label"
                                                               style="width: auto;font-size: 1.2em">其他：</label>

                                                        <div class="layui-input-inline">
                                                            <input type="text" id="cyddlthjqt" name="cyddlthjqt"
                                                                   autocomplete="off" class="layui-input ">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">餐饮环节：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="cyddcyhj"></div>
                                                        <div class="layui-form-item" id="cyddcyhjqtid"
                                                             style="display: none">
                                                            <label class="layui-form-label"
                                                                   style="width: auto;font-size: 1.2em">其他：</label>

                                                            <div class="layui-input-inline">
                                                                <input type="text" id="cyddcyhjqt" name="cyddcyhjqt"
                                                                       class="layui-input "/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="layui-col-md12">
                                                <div class="layui-form-item">
                                                    <div class="layui-input-inline">
                                                        <a id="btnselectcjcom" href="javascript:void(0)"
                                                           class="layui-btn" onclick="myclearCydd()">抽样地点清空重填</a>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">

                                        <h2 class="layui-colla-title">样品信息</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">样品来源：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="ypxxyply"></div>
                                                    </div>
                                                    <div class="layui-input-inline" id="ypxxyplyqtid"
                                                         style="width: auto;display: none">
                                                        <label class="layui-form-label"
                                                               style="width: auto;font-size: 1.2em">其他：</label>

                                                        <div class="layui-input-inline">
                                                            <input type="text" id="ypxxyplyqt" name="ypxxyplyqt"
                                                                   autocomplete="off" class="layui-input ">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">样品属性：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="ypxxypsx"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px;font-size: 1.2em">样品类型：</label>

                                                    <div class="layui-input-inline" style="width: auto">
                                                        <div id="ypxxyplx"></div>
                                                        <div class="layui-input-inline" id="ypxxyplxqtid"
                                                             style="width: auto;display: none">
                                                            <label class="layui-form-label"
                                                                   style="width: auto;font-size: 1.2em">其他：</label>

                                                            <div class="layui-input-inline">
                                                                <input type="text" id="ypxxyplxqt" name="ypxxyplxqt"
                                                                       autocomplete="off" class="layui-input ">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">样品名称：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="jcypmc" name="jcypmc"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                    <% if (!"view".equalsIgnoreCase(op)) {%>
                                                    <div class="layui-input-inline" id="myselectcom"
                                                         style="width: auto;">
                                                        <a href="javascript:void(0)" class="layui-btn"
                                                           iconCls="icon-search" onclick="jcypmc()">选择样品 </a>
                                                    </div>
                                                    <%} %>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">商标：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="spsb" name="spsb"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">日期类别：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="ypxxscjggjrqlb"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">生产\加工\购进日期：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="ypxxscjggjrq" name="ypxxscjggjrq"

                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">规格型号：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="spggxh" name="spggxh"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">样品批号：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="ypph" name="ypph"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">保质期：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="spbzq" name="spbzq"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">执行标准∕技术文件：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="zxbzjswj" name="zxbzjswj"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">质量等级：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="zldj" name="zldj"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">单价：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="spprice" name="spprice"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">是否出口：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="sfck" name="sfck"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样基数∕批量：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cyjspl" name="cyjspl"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样数：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cys" name="cys"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">备样数量：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="bysl" name="bysl"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">样品形态：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="ypxxypxt" name="ypxxypxt">ypxxypxt</select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">包装分类：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="ypxxbzfl" name="ypxxbzfl">ypxxbzfl</select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">

                                        <h2 class="layui-colla-title">（标示）生产者信息</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">生产者名称：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="sczmc" name="sczmc"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">生产者地址：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="sczdz" name="sczdz"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">生产许可证编号：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="scxkzbh" name="scxkzbh"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">生产者联系人：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="sczlxr" name="sczlxr"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">联系电话：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="sczlxdh" name="sczlxdh"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">

                                        <h2 class="layui-colla-title">抽样时样品的储存</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样时样品的储存方式：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="cysypdcc" name="cysypdcc"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样时样品的温度：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cysypdccwd" name="cysypdccwd"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">寄、送样品截止日期：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="jsypjzrq" name="jsypjzrq"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">寄送样品地址：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="jsypdz" name="jsypdz"
                                                               autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样样品包装：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="cyypbz" name="cyypbz"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">抽样方式：</label>

                                                    <div class="layui-input-inline">
                                                        <select id="cyfs" name="cyfs"></select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-collapse">
                                <div class="layui-colla-item">
                                    <div class="layui-row">

                                        <h2 class="layui-colla-title">抽样单位信息</h2>

                                        <div class="layui-colla-content layui-show">
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">单位名称：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwmc" name="cydwmc"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">地址：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwdz" name="cydwdz"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label"
                                                           style="width: 140px">联系人：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwlxr" name="cydwlxr"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">电话：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwlxdh" name="cydwlxdh"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">传真：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwcz" name="cydwcz"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                                <div class="layui-form-item">
                                                    <label class="layui-form-label" style="width: 140px">邮编：</label>

                                                    <div class="layui-input-inline">
                                                        <input type="text" id="cydwyb" name="cydwyb"
                                                               autocomplete="off" class="layui-input ">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-row">
                                <div class="layui-colla-content layui-show">
                                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 140px">备注：</label>

                                            <div class="layui-input-inline" style="width: 80%">
                                                <textarea id="beizhu" name="beizhu"
                                                          style="width: 80%;height: 140px"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <%--<div class="layui-colla-content layui-show">--%>
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm12"
                                     style="border: 1px #E6E6E6 solid">
                                    <br/>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label"
                                               style="width: 100px">被抽样单位对抽样程序、过程、封样状态及上述内容意见：</label>

                                        <div class="layui-input-inline">
                                            <select id="bcydwyj" name="bcydwyj"></select>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px">签名图：</label>

                                            <div class="layui-input-inline">
                                                <img src="<%=basePath%>images/default.jpg" id="bcydwqmpic"
                                                     name="bcydwqmpic"
                                                     style="max-width: 190px;height: 190px">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px">签名日期：</label>

                                            <div class="layui-input-inline">
                                                <input type="text" id="bcydwqmrq" name="bcydwqmrq"
                                                       autocomplete="off" class="layui-input ">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm12"
                                     style="border: 1px #E6E6E6 solid;border-left: none">
                                    <br/>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label"
                                               style="width: 100px">生产者对抽样程序、过程、封样状态及上述内容意见：</label>

                                        <div class="layui-input-inline">
                                            <select id="sczyj" name="sczyj"></select>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px">签名图：</label>

                                            <div class="layui-input-inline">
                                                <img src="<%=basePath%>images/default.jpg" id="sczqmpic" name="sczqmpic"
                                                     style="max-width: 190px;height: 190px">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px">签名日期：</label>

                                            <div class="layui-input-inline">
                                                <input type="text" id="sczqmrq" name="sczqmrq"
                                                       autocomplete="off" class="layui-input ">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm12"
                                     style="border:1px #E6E6E6 solid;border-left: none">
                                    <div class="layui-form-item" style="height: 105px">
                                        <br/>
                                        <label class="layui-form-label"
                                               style="width: 80px">抽样人签字：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cyrqmpic" name="cyrqmpic"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">

                                        <label class="layui-form-label"
                                               style="width: 80px">抽样单位 &nbsp;&nbsp;（公章）：</label>

                                        <div class="layui-input-inline">
                                            <img src="<%=basePath%>images/default.jpg" id="cydwgzpic" name="cydwgzpic"
                                                 style="max-width: 190px;height: 190px">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"
                                               style="width: 80px">盖章日期：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cydwgzrq" name="cydwgzrq"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-row" id="aae011id" style="display: none">
                            <div class="layui-colla-content layui-show">
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"
                                               style="width: 140px">操作员：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="aae011" name="aae011" readonly
                                                   autocomplete="off" class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"
                                               style="width: 140px">操作时间：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="aae036" name="aae036" readonly
                                                   autocomplete="off" class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--</div>--%>
            </div>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">
                        保存
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>