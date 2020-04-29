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
    String qyyyrz = StringHelper.showNull2Empty(request.getParameter("qyyyrz"));
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String userkind = sysuser.getUserkind();

%>
<!DOCTYPE html>
<html>
<head>
    <title>录入抽样登记信息(中牟)</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        <%--<%if (!"20".equals(userkind) && !"21".equals(userkind)) {%>--%>


        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var v_cydjrwlb = <%=SysmanageUtil.getAa10toJsonArray("CYDJRWLB")%>;
        var v_cydjqylx = <%=SysmanageUtil.getAa10toJsonArray("CYDJQYLX")%>;
        var v_comsfyy = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_qiyezylx = <%=SysmanageUtil.getAa10toJsonArray("QIYEZYLX")%>;
        var v_sfxyfj = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var id = '<%=cydjid%>';
        $(function () {
            //可查看,不是20或21可编辑
            if ('<%=op%>' == 'view') {
                $('#yy').removeAttr('style');
            } else if ('<%=op%>' == 'qyyy') {//点击企业异议按钮时
                if ("20"!='<%=userkind%>' && "21"!='<%=userkind%>') {
                    $('#yy').removeAttr('style');
                }
            } else {
                $('#yy').attr('style', 'display:none');
            }


            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
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

/*                form.on('radio(radio)',function (data) {
                    if(radiovalue===data.elem.value){
                        $(data.elem).prop('checked', false);
                    }else{
                        $(data.elem).prop('checked', true)
                    }
                    form.render();
                    return false;
                });*/

                if (id != "" && id != null) {
                    $.post(basePath + '/jyjc/queryJyjccydj_zm', {
                                cydjid: $('#cydjid').val(),
                                qyyyrz: $('#qyyyrz').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    if (mydata.jyjccjrwbid != null && mydata.jyjccjrwbid != '') {
                                        $.post(basePath + 'jyjc/queryCjrw', {
                                                    jyjccjrwbid: $("#jyjccjrwbid").val()   //(将数据库中值通过此id传给前段页面)
                                                },
                                                function (result) {
                                                    if (result.code == '0') {
                                                        $('#jcrwmc').val(result.rows[0].jcrwmc);
                                                    } else {
                                                        layer.open({
                                                            title: "提示",
                                                            content: "任务查询失败：" + result.msg //这里content是一个普通的String
                                                        });
                                                    }

                                                }, 'json');
                                    }
/*                                    if (mydata.bcydwcomid != null && mydata.bcydwcomid != '') {
                                        $.post(basePath + 'pcompany/queryPcompanyDTO', {
                                                    comid: $("#bcydwcomid").val(),  //(将数据库中值通过此id传给前段页面)
                                                    queryall: '1'
                                                },
                                                function (result) {
                                                    if (result.code == '0') {
                                                        $('#bcydw').val(result.data.commc);
                                                        $('#bcydwfl').val(result.data.comdalei);
                                                        $('#bcydwflname').val(result.data.comdaleiname);
                                                        $('#bcydwdz').val(result.data.comdz);
                                                        $('#tel').val(result.data.comyddh);
                                                        $('#nsxe').val(result.data.comqyndnxse);
                                                        $('#yyzhh').val(result.data.comxkzbh);
                                                        $('#xlr').val(result.data.comfzr);
                                                        $('#comcz').val(result.data.comcz);
                                                        $('#comyzbm').val(result.data.comyzbm);
                                                        $('#comfrhyz').val(result.data.comfrhyz);
                                                    } else {
                                                        layer.open({
                                                            title: "提示",
                                                            content: "企业查询失败：" + result.msg //这里content是一个普通的String
                                                        });
                                                    }

                                                }, 'json');
                                    }*/
                                    form.render();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('form :input').attr('readonly', 'readonly');
                        $('#cydjrwlb').attr('disabled', true);
                        $('#cydjqylx').attr('disabled', true);
                        $('#comsfyy').attr('disabled', true);
                        $('#qiyezylx').attr('disabled', true);
                        $('#sfxyfj').attr('disabled', true);
                        $('#yy').removeAttr('style');
                    }
                }

            });
            intSelectData('cydjrwlb', v_cydjrwlb);
            intSelectData('cydjqylx', v_cydjqylx);
            intSelectData('comsfyy', v_comsfyy);
            intSelectData('qiyezylx', v_qiyezylx);
            intSelectData('sfxyfj', v_sfxyfj);
        });
        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();
        };


        //从单位信息表中读取
        function selectcjrwIndex() {
            parent.sy.modalDialog({
                title: '选择任务'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcjrwIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#jyjccjrwbid").val(myrow.jyjccjrwbid); //任务id
                    $("#jcrwmc").val(myrow.jcrwmc); //任务名称
                    $("#bcydwcomid").val(myrow.comid); //被抽检单位Id
                    $.post(basePath + 'pcompany/queryPcompanyDTO', {
                                comid: $("#bcydwcomid").val(),   //(将数据库中值通过此id传给前段页面)
                                queryall: '1'
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('#bcydw').val(result.data.commc);
                                    $('#bcydwfl').val(result.data.comdaleiname);
                                    //$('#bcydwflname').val(result.data.comdaleiname);
                                    $('#bcydwdz').val(result.data.comdz);
                                    $('#tel').val(result.data.comyddh);
                                    $('#nsxe').val(result.data.comqyndnxse);
                                    $('#yyzhh').val(result.data.comxkzbh);
                                    $('#xlr').val(result.data.comfzr);
                                    $('#comcz').val(result.data.comcz);
                                    $('#comyzbm').val(result.data.comyzbm);
                                    $('#comfrhyz').val(result.data.comfrhyz);
                                    form.render();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }

                            }, 'json');
                }
            });
        }
        //选择复检机构
        function myselectjcjg() {
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
                    $("#fjcomid").val(myrow.comid); //公司名称
                    $("#fjcommc").val(myrow.commc); //公司代码
                }
            });
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        //选择抽检机构名称
        function myselectcom() {
            parent.sy.modalDialog({
                title: '选择抽检单位'
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
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#bcydwcomid").val(myrow.comid); //被抽样单位id
                    $("#bcydw").val(myrow.commc); //被抽样单位名称
                    $("#bcydwfl").val(myrow.comdaleistr); //被抽样单位分类
                    $("#bcydwdz").val(myrow.comdz); //被抽样单位地址
                    $("#tel").val(myrow.comyddh); //被抽样单位联系电话
                    $("#comfrhyz").val(myrow.comfrhyz); //法定代表人
                    $("#yyzhh").val(myrow.yyzzh); //营业执照号
                    $("#xlr").val(myrow.comfzr); //联系人

                }
            });
        };

        function myselectcjcom(){
            parent.sy.modalDialog({
                title: '选择抽检单位'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , param: {
                    querytype: "jyjc"
                }
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
                    $("#cjcommc").val(myrow.commc); //公司名称
                    $("#cjjgcomid").val(myrow.comid); //公司代码
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="jyjcjgForm" style="padding-left: 66px">
            <%--抽检登记表Id--%>
            <input type="hidden" id="cydjid" name="cydjid" value="<%=cydjid%>">
            <input type="hidden" id="qyyyrz" name="qyyyrz" value="<%=qyyyrz%>">
            <%--检验检测抽检任务表id--%>
            <input type="hidden" id="jyjccjrwbid" name="jyjccjrwbid">
            <%--被抽样单位类别
            <input type="hidden" id="bcydwfl" name="bcydwfl">
            --%>
            <%--复检机构Id--%>
            <input type="hidden" id="fjcomid" name="fjcomid">
            <%--年销售额--%>
            <input type="hidden" id="nsxe" name="nsxe">
            <%--传真--%>
            <input type="hidden" id="comcz" name="comcz">
            <%--邮编--%>
            <input type="hidden" id="comyzbm" name="comyzbm">

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">选择抽检任务：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcrwmc" name="jcrwmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>

                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn layui-btn-sm"
                                   iconCls="icon-search" onclick="selectcjrwIndex()">选择任务 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位id：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydwcomid" name="bcydwcomid" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" style="width: auto;">
                            <a href="javascript:void(0)" class="layui-btn layui-btn-sm"
                               iconCls="icon-search" onclick="myselectcom()">选择单位</a>
                            </div>
                            <%} %>

                        </div>

                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydw" name="bcydw"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位分类：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydwfl" name="bcydwfl"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">被抽样单位地址：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bcydwdz" name="bcydwdz"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" id="bcytel" style="width: 120px">被抽样单位联系电话：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="tel" name="tel"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">法定代表人：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="comfrhyz" name="comfrhyz"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">营业执照号：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="yyzhh" name="yyzhh"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">联系人：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="xlr" name="xlr"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">任务来源：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cydjrwly" name="cydjrwly"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">任务类别：</label>

                            <div class="layui-input-inline">
                                <select id="cydjrwlb" name="cydjrwlb"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">区域类型：</label>

                            <div class="layui-input-inline">
                                <select id="cydjqylx" name="cydjqylx"></select>
                            </div>
                        </div>
                    </div>

                    <div id="yy" style="display: none">
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">企业是否有异议：</label>

                                <div class="layui-input-inline">
                                    <select id="comsfyy" name="comsfyy" lay-filter="comsfyy"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">企业质疑类型：</label>

                                <div class="layui-input-inline">
                                    <select id="qiyezylx" name="qiyezylx"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">企业异议描述：</label>

                                <div class="layui-input-inline" style="width: 80%">
                                    <textarea style="width:80%;height: 150px" id="comyydesc"
                                              name="comyydesc"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">企业异议处理结果：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="comyycljg" name="comyycljg"
                                           autocomplete="off" class="layui-input ">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">是否需要复检：</label>

                                <div class="layui-input-inline">
                                    <select id="sfxyfj" name="sfxyfj"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px"><font
                                        class="myred">*</font>复检机构名称：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="fjcommc" name="fjcommc" readonly
                                           autocomplete="off" class="layui-input layui-bg-gray">
                                </div>

                                <% if (!"view".equalsIgnoreCase(op)) {%>
                                <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                    <a href="javascript:void(0)" class="layui-btn"
                                       iconCls="icon-search" onclick="myselectjcjg()">选择复检机构 </a>
                                </div>
                                <%} %>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 120px">复检结果：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="cjresult" name="cjresult"
                                           autocomplete="off" class="layui-input ">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">经办人：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae011" name="aae011" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">经办时间：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae036" name="aae036" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"></label>
                            <div style="height: 200px"></div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label"></label>

                            <div style="height: 200px"></div>
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