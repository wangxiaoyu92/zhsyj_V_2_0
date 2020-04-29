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
    String hjyjczbid = StringHelper.showNull2Empty(request.getParameter("hjyjczbid"));
    String hjyjcmxbid = StringHelper.showNull2Empty(request.getParameter("hjyjcmxbid"));
    Sysuser sysuser = SysmanageUtil.getSysuser();
    String userdalei = sysuser.getUserdalei();
    String aaz001 = sysuser.getAaz001();
    String description = sysuser.getDescription();
    String v_cur_userkind = sysuser.getUserkind();
    if ("30".equals(v_cur_userkind)) {//网上送检人员
        op = "view";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测报告明细表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var cydjid = '<%=cydjid%>';
        var hjyjczbid = '<%=hjyjczbid%>';
        var hjyjcmxbid = '<%=hjyjcmxbid%>';
        var v_szdw = <%=SysmanageUtil.getAa10toJsonArray("SZDW")%>;
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        $(function () {

            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;

                var url = basePath + '/jyjc/saveHjyjcxb';
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
                if (hjyjcmxbid != "" && hjyjcmxbid != null) {
                    $.post(basePath + '/jyjc/queryHjyjcmxb', {
                                hjyjcmxbid: hjyjcmxbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    form.render('select');
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "数据获取失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                    }
                }

            });
            intSelectData('szdw', v_szdw);
            intSelectData('jyjcjl', v_jyjcjl);
        })

        // 保存
        function submitForm() {
            if ($('#jcz').val()) {
                $('#jcz').attr('lay-verify', 'number');
            } else {
                $('#jcz').removeAttr('lay-verify', 'number');
            }
            $("#saveAjdjBtn").click();
        }

        //选择项目
        function myselectxm() {
            parent.sy.modalDialog({
                title: '项目信息'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'pub/pub/selectjyjcxmIndex'
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
                    $("#jcxmid").val(myrow.jyjcxmid); //项目类别
                    $("#jcxmmc").val(myrow.jcxmmc); //项目名称
                    $("#bzz").val(myrow.jcxmbzz); //标准值
                    $("#xlbz").val(myrow.jcxmbz); //标准项目标准
                    $("#jcff").val(myrow.jcxmff); //标准项目方法
                }
            });
        }
        function myselecff() {
            parent.sy.modalDialog({
                title: '检测方法'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'jyjc/jcffglIndex'
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
                    var jcffbzbhs = new Array();
                    var jyjcffbzbids = new Array();
                    for (var i = 0; i < myrow.length; i++) {
                        jcffbzbhs.push(myrow[i].jcffbzbh);
                        jyjcffbzbids.push(myrow[i].jyjcffbzbid);
                    }
                    var jcffbzbh = jcffbzbhs.join(",");
                    var jyjcffbzbid = jyjcffbzbids.join(",");
                    $("#jcff").val(jcffbzbh);
                    $("#jyjcffbzbid").val(jyjcffbzbid);
                }
            })
        }
        function myselectbz() {
            parent.sy.modalDialog({
                title: '标准信息'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'jyjc/jyjcjcbzbIndex'
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
                    var bhs = new Array();
                    var jyjcjcbzbids = new Array();
                    for (var i = 0; i < myrow.length; i++) {
                        bhs.push(myrow[i].bzbh);
                        jyjcjcbzbids.push(myrow[i].jyjcjcbzbid);
                    }
                    var bh = bhs.join(",");
                    var jyjcjcbzbid = jyjcjcbzbids.join(",");
                    $("#jyjcjcbzbid").val(jyjcjcbzbid);
                    $("#xlbz").val(bh);
                }
            })
        }
        function checkBzz() {
            var bzz = $('#bzz').val();
            var jcz = $('#jcz').val();
            if (jcz == null || jcz == "") {
                return;
            }
//            //结论    1是合格    2是不合格
            if (parseInt(bzz) > parseInt(jcz)) {
                $("#jyjcjl").val("1");
            }
            else {
                $("#jyjcjl").val("2");
            }
            form.render();
        }
        function aa10manage(prm_aaa100) {
            var obj = new Object();
            obj.singleSelect = "true";	//
            var url = "<%=basePath%>jsp/sysmanager/aa10.jsp";
            <%--  var v_ret=mySahowModalDialog("<%=basePath%>jsp/sysmanager/aa10.jsp?aaa100="+prm_aaa100+"&a="+new Date().getMilliseconds(),obj,
                 860,460); --%>
            parent.sy.modalDialog({
                title: '选择数值单位',
                area: ['100%', '100%'],
                content: url,
                param: {
                    aaa100: prm_aaa100
                },
                cancel: function (index, layero) {
                    var ziIndex =index ;
                    parent.layer.confirm('确认要关闭吗?', function (index) {

                        parent.layer.close(ziIndex);
                        parent.layer.close(index);

                    });
                    return false;
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (prm_aaa100 == 'SZDW') {
                    g_getAa10FromAaa100ByPost('SZDW');
                } else if (prm_aaa100 == 'XLBZ') {
                    g_getAa10FromAaa100ByPost('XLBZ');
                }
                ;
                sy.removeWinRet(dialogID);
            });
        }
        ;
        function g_getAa10FromAaa100ByPost(prm_aaa100) {
            $.post(basePath + 'sysmanager/sysparam/getAa10MapOneKey', {
                        aaa100: prm_aaa100
                    },
                    function (result) {
                        if ('SZDW' == prm_aaa100) {
                            v_szdw = result;
                            $('#szdw').empty();
                            intSelectData('szdw', v_szdw);
                            form.render();

                        } else if ('XLBZ' == prm_aaa100) {

                        }
                    }, 'json');
        }
        ;
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form class="layui-form" action="" id="jyjcjgForm" style="padding-left: 66px;height: 550px">
            <input type="hidden" id="jyjcffbzbid" name="jyjcffbzbid"/>
            <input type="hidden" id="jyjcjcbzbid" name="jyjcjcbzbid"/>

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检验检测明细表id：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="hjyjcmxbid" name="hjyjcmxbid" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检验检测主表id：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="hjyjczbid" name="hjyjczbid" value="<%=hjyjczbid%>"
                                       autocomplete="off"
                                       readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测项目id：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmid" name="jcxmid" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
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
                            <label class="layui-form-label" style="width: 120px">检测项目名称：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcxmmc" name="jcxmmc" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">标准值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bzz" name="bzz" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测值：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcz" name="jcz" onblur="checkBzz()"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">数值单位：</label>

                            <div class="layui-input-inline">
                                <select id="szdw" name="szdw"></select>
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="aa10manage('SZDW')">+ </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检验检测结论：</label>

                            <div class="layui-input-inline">
                                <select id="jyjcjl" name="jyjcjl"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">限量执行标准：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="xlbz" name="xlbz" autocomplete="off"
                                       class="layui-input layui-bg-gray" disabled="disabled">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectbz()">选择标准 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测方法：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcff" name="jcff" autocomplete="off"
                                       class="layui-input layui-bg-gray" disabled="disabled">
                            </div>
                            <% if (!"view".equalsIgnoreCase(op)) {%>
                            <div class="layui-input-inline" id="myselectcom" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselecff()">选择方法 </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <% if (!"".equalsIgnoreCase(cydjid)) {%>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">抽样登记Id：</label>

                            <div class="layui-input-inline">
                                <input type="text" id="cydjid" name="cydjid" value="<%=cydjid%>" autocomplete="off"
                                       class="layui-input layui-bg-gray" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">移交情况:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="yjqk" name="yjqk"
                                       autocomplete="off" class="layui-input" lay-verify="required">
                            </div>
                        </div>
                    </div>
                    <%} %>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">经办人:</label>

                            <div class="layui-input-inline layui-form">
                                <input type="text" id="aae011" name="aae011" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">经办时间:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="aae036" name="aae036" autocomplete="off" readonly
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