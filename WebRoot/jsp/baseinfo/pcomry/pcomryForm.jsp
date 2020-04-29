<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String ryid = StringHelper.showNull2Empty(request.getParameter("ryid"));
    String sh = StringHelper.showNull2Empty(request.getParameter("sh"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>企业人员信息管理</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //证件类型
        var ryzjlx = <%=SysmanageUtil.getAa10toJsonArray("RYZJLX")%>;
        //人员性别
        var ryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        //人员民族
        var rymz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
        //人员学历
        var ryxueli = <%=SysmanageUtil.getAa10toJsonArray("RYXUELI")%>;
        //在职状态
        var v_ryzt = <%=SysmanageUtil.getAa10toJsonArray("RYZT")%>;
        //职务
        var v_ryzwgw = <%=SysmanageUtil.getAa10toJsonArray("RYZWGW")%>;
        //技术职称
        var v_ryjszc = <%=SysmanageUtil.getAa10toJsonArray("RYJSZC")%>;
        //人员健康情况
        var v_ryjkqk = <%=SysmanageUtil.getAa10toJsonArray("RYJKQK")%>;
        //人员健康情况
        var v_rypxqk = <%=SysmanageUtil.getAa10toJsonArray("RYPXQK")%>;
        //是否食品安全管理员
        var v_rysfspaqgly = <%=SysmanageUtil.getAa10toJsonArray("RYSFSPAQGLY")%>;
        //是否监督公示人员
        var v_rysfjdgsry = <%=SysmanageUtil.getAa10toJsonArray("RYSFJDGSRY")%>;
        //人员类别
        var v_rysflb = <%=SysmanageUtil.getAa10toJsonArray("RYSFLB")%>;
        //人员是否执业药师
        var v_rysfzyys = <%=SysmanageUtil.getAa10toJsonArray("RYSFZYYS")%>;

        var form; // form表单（查询条件）
        var layer; // 弹出层
        var table;
        var laydate;

        $(function () {

            layui.use(['form', 'layer', 'table', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#rycsrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#rybeginwork2'
                });
                laydate.render({
                    elem: '#ryjkzfzrq'
                });
                laydate.render({
                    elem: '#ryjkzyxjzrq'
                });
                laydate.render({
                    elem: '#ryzyyszcrq2'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#ryzyyszsyxqz2'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#ryzgzsfzrq2'
                    , type: 'datetime'
                });
                form.verify({
                    phone: function (value, item) { //value：表单的值、item：表单的DOM对象
                        if (!new RegExp(/^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\d{8}$/).test(value)) {
                            return '请输入正确的手机号!';
                        }
                    }
                });


                // 主体业态
                var lock = true;// 锁住表单   这里定义一把锁
                var url = basePath + 'pcomry/savePcomry';
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
                            lock = true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#ryid').val().length > 0) {
                    $.post(basePath + 'pcomry/queryPcomryDTO', {
                                ryid: $('#ryid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    for (var attr in mydata) {
                                        $("input[name='" + attr+"']").val(mydata[attr]);
                                        $("select[name='" + attr+"']").val(mydata[attr]);
                                        $("textarea[name='" + attr+"']").val(mydata[attr]);
                                    }
                                    form.render();
                                    //getPersonPhoto($('#ryid').val());
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                                var ryzppath = $("#ryzppath").val();
                                if (ryzppath != "") {
                                    $("#ryzp").attr("src", "<%=contextPath%>" + ryzppath);
                                }
                                var ryjkzpath = $("#ryjkzpath").val();
                                if (ryjkzpath != "") {
                                    $("#ryjkz").attr("src", "<%=contextPath%>" + ryjkzpath);
                                }
                                var rypxzpath = $("#rypxzpath").val();
                                if (rypxzpath != "") {
                                    $("#rypxz").attr("src", "<%=contextPath%>" + rypxzpath);
                                }
                                parent.$.messager.progress('close');
                            }, 'json');

                    if ('<%=op%>' == 'view' || '<%=sh%>' == 'examPcom') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('select').attr('disabled', true);
                        $('#rycsrq').attr('disabled', true);
                        $('#rybeginwork2').attr('disabled', true);
                        $('#ryjkzfzrq').attr('disabled', true);
                        $('#ryjkzyxjzrq').attr('disabled', true);
                        $('#ryzyyszcrq2').attr('disabled', true);
                        $('#ryzyyszsyxqz2').attr('disabled', true);
                        $('#ryzgzsfzrq2').attr('disabled', true);
                        $('#btnselectryzp').css('display', 'none');
                        $('#btnselectjkz').css('display', 'none');
                        $('#btnselectpxz').css('display', 'none');
                        $('.Wdate').attr('disabled', true);
                    }
                }
            });
            getSelectList();

        });

        // 从数据库获取照片
        function getPersonPhoto(v_ryid) {
            if (v_ryid != null && v_ryid != "") {
                $.post(basePath + '/pcomry/getComryzp', {
                            'ryid': v_ryid
                        },
                        function (result) {
                            $('#ryzp').attr('src', result.fileCtxPath + "?" + Math.random());
                            if (result.code == '-1') {
                                layer.alert('提示', result.msg, 'error');
                            }
                        },
                        'json');
            }
        }
        function getSelectList() {
            intSelectData('rysfzyys', v_rysfzyys);
            intSelectData('rysflb', v_rysflb);
            intSelectData('rysfjdgsry', v_rysfjdgsry);
            intSelectData('rysfspaqgly', v_rysfspaqgly);
            intSelectData('rypxqk', v_rypxqk);
            intSelectData('ryjkqk', v_ryjkqk);
            intSelectData('ryjszc', v_ryjszc);
            intSelectData('ryzwgw', v_ryzwgw);
            intSelectData('ryzt', v_ryzt);
            intSelectData('ryzjlx', ryzjlx);
            intSelectData('ryxb', ryxb);
            intSelectData('ryxueli', ryxueli);
            intSelectData('rymz', rymz);
        }
        // 刷新
        function refresh() {
            window.location.reload();
        }

        // 保存企业人员信息
        var savePcomry = function () {
            if ($('#ryemail').val()) {
                $('#ryemail').attr('lay-verify', 'email');
            } else {
                $('#ryemail').removeAttr('lay-verify', 'email');
            }
//            if ($('#ryzjh2').val()) {
//                $('#ryzjh2').attr('lay-verify', 'identity');
//            } else {
//                $('#ryzjh2').removeAttr('lay-verify', 'identity');
//            }
            //判断健康证和职业药师证日期
            var ryzyyszcrq2 = $('#ryzyyszcrq2').val();
            var ryzyyszsyxqz2 = $('#ryzyyszsyxqz2').val();
            if (ryzyyszcrq2 != '' && ryzyyszsyxqz2 != '') {
                if (ryzyyszcrq2 >= ryzyyszsyxqz2) {
                    layer.msg('职业药师注册日期必须小于失效日期', {icon: 5, anim: 6});
                    $('#ryzyyszcrq2').css('border-color', 'red');
                    $('#ryzyyszsyxqz2').css('border-color', 'red');
                    return false;
                }
            }
            var ryjkzfzrq = $('#ryjkzfzrq').val();
            var ryjkzyxjzrq = $('#ryjkzyxjzrq').val();
            if (ryjkzfzrq != '' && ryjkzyxjzrq != '') {
                if (ryjkzfzrq >= ryjkzyxjzrq) {
                    layer.msg('健康证发证日期必须小于失效日期', {icon: 5, anim: 6});
                    $('#ryjkzfzrq').css('border-color', 'red');
                    $('#ryjkzyxjzrq').css('border-color', 'red');
                    return false;
                }
            }
            $("#savePcomryBtn").click();

        };


        //选择企业名称
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
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });

        }

        // 关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        // 上传图片附件
        function uploadFjView(prm_fjtype) {
            var v_fjwid = $("#ryid").val();
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            parent.sy.modalDialog({
                title: '上传人员照片'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    folderName: "comry",
                    fjwid: v_fjwid,
                    fjtype: prm_fjtype,
                    uploadOne: "yes"
                }
                ,btn:['关闭']
            }, function (dialogID) {
                var retVal = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (retVal != null) {
                    if (retVal.type == 'ok') {
                        if (prm_fjtype == "5") {//健康证
                            $("#ryjkzpath").val(retVal.fjpath);
                            $("#ryjkzname").val(retVal.fjname);
                            $("#ryjkz").attr("src", "<%=contextPath%>" + retVal.fjpath);
                        } else if (prm_fjtype == "6") {//培训证
                            $("#rypxzpath").val(retVal.fjpath);
                            $("#rypxzname").val(retVal.fjname);
                            $("#rypxz").attr("src", "<%=contextPath%>" + retVal.fjpath);
                        } else if (prm_fjtype == "7") {//人员照片
                            $("#ryzppath").val(retVal.fjpath);
                            $("#ryzpname").val(retVal.fjname);
                            $("#ryzp").attr("src", "<%=contextPath%>" + retVal.fjpath);
                        }
                    }
                    if (retVal.type == 'deleteok') {
                        var v_defaultpic = "/images/default.jpg";
                        if (prm_fjtype == "5") {//健康证
                            $("#ryjkzpath").val("");
                            $("#ryjkzname").val("");
                            $("#ryjkz").attr("src", "<%=contextPath%>" + v_defaultpic);
                        } else if (prm_fjtype == "6") {//培训证
                            $("#rypxzpath").val("");
                            $("#rypxzname").val("");
                            $("#rypxz").attr("src", "<%=contextPath%>" + v_defaultpic);
                        } else if (prm_fjtype == "7") {//人员照片
                            $("#ryzppath").val("");
                            $("#ryzpname").val("");
                            $("#ryzp").attr("src", "<%=contextPath%>" + v_defaultpic);
                        }
                    }
                }
            });
        }

    </script>
</head>

<body>
<form class="layui-form" id="fm" method="post">
    <input id="ryid" name="ryid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly"
           value="<%=ryid%>"/>
    <input id="ryzpwjm" name="ryzpwjm" type="hidden"/>
    <input id="comid" name="comid" type="hidden"/>
    <input name="filepath" id="filepath" type="hidden"/>
    <table class="layui-table" style="width: 99%;" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 120px"><font class="myred">*</font>企业名称:</td>
            <td><input id="commc" name="commc" class="layui-input" lay-verify="required" readonly="readonly"/></td>
            <td width="60">
                <% if (!"view".equalsIgnoreCase(op)) {%>
                <a id="btnselectcom" href="javascript:void(0)"
                   class="layui-btn" iconCls="icon-search"
                   onclick="myselectcom()">选择企业 </a>
                <%} %>
            </td>
            <td style="text-align:right;" rowspan="5" width="80">
                <nobr>人员照片预览:</nobr>
            </td>
            <td rowspan="5" colspan="1" style="text-align: center;">
                <div style="text-align: center;" id="ryzhaopian_div">
                    <img src="<%=contextPath%>/images/default.jpg" name="ryzp" id="ryzp" height="140" width="120"
                         onclick="g_showBigPic(this.src);"/>
                </div>
                <%--<a id="btnselectryzp" href="javascript:void(0)"--%>
                <%--class="layui-btn" iconCls="icon-search"--%>
                <%--onclick="uploadFjView(7)">选择人员照片</a>--%>
                <input class="layui-btn layui-btn-sm" id="btnselectryzp" type="button"
                       onclick="uploadFjView(7)" value="选择人员照片">
                <input type="hidden" id="ryzppath" name="ryzppath">
                <input type="hidden" id="ryzpname" name="ryzpname">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>人员姓名:</nobr>
            </td>
            <td><input id="ryxm2" name="ryxm" class="layui-input" lay-verify="required"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>职务:</nobr>
            </td>
            <td>
                <select id="ryzwgw" name="ryzwgw" lay-verify="required"></select>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>职责:</nobr>
            </td>
            <td><input id="ryzhize" name="ryzhize" class="layui-input" lay-verify="required"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>职称:</nobr>
            </td>
            <td><input id="ryjszc" name="ryjszc" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>人员民族:</nobr>
            </td>
            <td>
                <select id="rymz" name="rymz" lay-verify="required"></select>
            </td>
            <td></td>
            <td style="text-align:right;">
                <nobr>人员性别:</nobr>
            </td>
            <td>
                <select id="ryxb" name="ryxb"></select>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>证件类型:</nobr>
            </td>
            <td>
                <select id="ryzjlx" name="ryzjlx" lay-verify="required"></select>
            </td>
            <td></td>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>证件号码:</nobr>
            </td>
            <td><input id="ryzjh2" name="ryzjh" class="layui-input" lay-verify="required"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>出生日期:</nobr>
            </td>
            <td><input id="rycsrq" name="rycsrq" class="layui-input" placeholder="年/月/日"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>年龄:</nobr>
            </td>
            <td><input id="rynl2" name="rynl" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr><font class="myred">*</font>联系电话:</nobr>
            </td>
            <td><input id="rylxdh2" name="rylxdh" class="layui-input" lay-verify="phone"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>毕业院校:</nobr>
            </td>
            <td><input id="rybyyx2" name="rybyyx" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>籍贯:</nobr>
            </td>
            <td><input id="ryjg" name="ryjg" class="layui-input"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>在职状态:</nobr>
            </td>
            <td>
                <select id="ryzt" name="ryzt"></select>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>人员通讯地址:</nobr>
            </td>
            <td colspan="4"><input id="rytxdz" name="rytxdz" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>QQ:</nobr>
            </td>
            <td><input id="ryqq" name="ryqq" class="layui-input"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>email:</nobr>
            </td>
            <td><input id="ryemail" name="ryemail" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>学历:</nobr>
            </td>
            <td><input id="ryxueli" name="ryxueli" class="layui-input"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>专业:</nobr>
            </td>
            <td><input id="ryzhuanye2" name="ryzhuanye" class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>开始工作日期:</nobr>
            </td>
            <td><input id="rybeginwork2" name="rybeginwork" class="layui-input" placeholder="年/月/日"/></td>
            <td></td>
            <td style="text-align:right;">
                <nobr>人员类别:</nobr>
            </td>
            <td>
                <select id="rysflb" name="rysflb"></select>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>人员简介:</nobr>
            </td>
            <td colspan="4">
							<textarea class="layui-textarea" id="ryjianjie" name="ryjianjie"
                                      rows="5"></textarea>
            </td>
        </tr>
    </table>
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 120px">
                <nobr>健康情况:</nobr>
            </td>
            <td>
                <select id="ryjkqk" name="ryjkqk"></select>
            </td>
            <td style="text-align:right;">
                <nobr>培训情况:</nobr>
            </td>
            <td><select id="rypxqk" name="rypxqk"></select></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>是否食品安全管理员:</nobr>
            </td>
            <td>
                <select id="rysfspaqgly" name="rysfspaqgly"></select>
            </td>
            <td style="text-align:right;">
                <nobr>是否监督公示人员:</nobr>
            </td>
            <td><select id="rysfjdgsry" name="rysfjdgsry"></select></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>人员健康证号:</nobr>
            </td>
            <td><input class="layui-input" id="ryjkzh" name="ryjkzh"></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>健康证发证日期:</nobr>
            </td>
            <td><input class="layui-input" id="ryjkzfzrq" name="ryjkzfzrq"></td>
            <td style="text-align:right;">
                <nobr>健康证有效截止日期:</nobr>
            </td>
            <td><input class="layui-input" id="ryjkzyxjzrq" name="ryjkzyxjzrq" ></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>人员健康证:</nobr>
            </td>
            <td style="text-align: center;">
                <div style="text-align: center;" id="ryjkz_div">
                    <img src="<%=contextPath%>/images/default.jpg" name="ryjkz" id="ryjkz"
                         height="140" width="160" onclick="g_showBigPic(this.src);"/>
                </div>
                <a id="btnselectjkz" href="javascript:void(0)"
                   class="layui-btn layui-btn-sm" iconCls="icon-search"
                   onclick="uploadFjView(5)">选择健康证 </a>
                <input type="hidden" id="ryjkzpath" name="ryjkzpath">
                <input type="hidden" id="ryjkzname" name="ryjkzname">
            </td>
            <td style="text-align:right;">
                <nobr>人员培训证:</nobr>
            </td>
            <td style="text-align: center;">
                <div style="text-align: center;" id="rypxz_div">
                    <img src="<%=contextPath%>/images/default.jpg" name="rypxz" id="rypxz"
                         height="140" width="160" onclick="g_showBigPic(this.src);"/>
                </div>
                <a id="btnselectpxz" href="javascript:void(0)"
                   class="layui-btn layui-btn-sm" iconCls="icon-search"
                   onclick="uploadFjView(6)">选择培训证 </a>
                <input type="hidden" id="rypxzpath" name="rypxzpath">
                <input type="hidden" id="rypxzname" name="rypxzname">
            </td>
        </tr>
    </table>
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 120px">
                <nobr>是否职业药师:</nobr>
            </td>
            <td width="260px"><select id="rysfzyys" name="rysfzyys"></select></td>
            <td style="text-align:right;">
                <nobr>执业药师注册编号:</nobr>
            </td>
            <td><input class="layui-input" id="ryzyyszcbh2" name="ryzyyszcbh"></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>职业药师注册日期:</nobr>
            </td>
            <td><input class="layui-input" id="ryzyyszcrq2" name="ryzyyszcrq"></td>
            <td style="text-align:right;">
                <nobr>职业药师证书有效期至:</nobr>
            </td>
            <td><input class="layui-input" id="ryzyyszsyxqz2" name="ryzyyszsyxqz"></td>
        </tr>
    </table>
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 120px">
                <nobr>从业资格类别:</nobr>
            </td>
            <td width="260px"><input class="layui-input" id="rycyzglb2" name="rycyzglb"></td>
            <td style="text-align:right;width: 220px">
                <nobr>资格证书编号:</nobr>
            </td>
            <td><input class="layui-input" id="ryzgzsbh2" name="ryzgzsbh"></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>资格证书发证日期:</nobr>
            </td>
            <td><input class="layui-input" id="ryzgzsfzrq2" name="ryzgzsfzrq" width="200"></td>
            <td style="text-align:right;">
                <nobr>从业范围:</nobr>
            </td>
            <td><input class="layui-input" id="rycyfw2" name="rycyfw"></td>
        </tr>
    </table>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save" id="savePcomryBtn">保存
            </button>
        </div>
    </div>
</form>
</body>
</html>