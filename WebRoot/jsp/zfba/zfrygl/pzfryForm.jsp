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
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>执法人员编辑</title>

    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <style>

        @font-face {
            font-family: "seraph";
            src: url('//at.alicdn.com/t/font_400842_0pcshphdq5ubx1or.eot?t=1508464003539'); /* IE9*/
            src: url('//at.alicdn.com/t/font_400842_0pcshphdq5ubx1or.eot?t=1508464003539#iefix') format('embedded-opentype'), /* IE6-IE8 */ url('data:application/x-font-woff;charset=utf-8;base64,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') format('woff'),
            url('//at.alicdn.com/t/font_400842_0pcshphdq5ubx1or.ttf?t=1508464003539') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/ url('//at.alicdn.com/t/font_400842_0pcshphdq5ubx1or.svg?t=1508464003539#seraph') format('svg'); /* iOS 4.1- */
        }

        .seraph {
            font-family: "seraph" !important;
            font-size: 16px;
            font-style: normal;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .icon-tuichu:before {
            content: "\e620";
        }

        .icon-guanbi:before {
            content: "\e62f";
        }

        .icon-mokuai:before {
            content: "\e7b0";
        }

        .icon-text:before {
            content: "\e63f";
        }

        .icon-caidan:before {
            content: "\e606";
        }

        .icon-lock:before {
            content: "\e61e";
        }

        .icon-icon10:before {
            content: "\e626";
        }

        .icon-github:before {
            content: "\e667";
        }

        .icon-oschina:before {
            content: "\e604";
        }

        .icon-xiugai:before {
            content: "\e64f";
        }

        .icon-prohibit:before {
            content: "\e73a";
        }

        .icon-clock:before {
            content: "\e602";
        }

        .icon-test:before {
            content: "\e693";
        }

        .icon-chakan:before {
            content: "\e603";
        }

        .icon-ziliao:before {
            content: "\e661";
        }

        .icon-good:before {
            content: "\e60c";
        }

        /*下拉多选*/
        .layui-form-item select[multiple] + .layui-form-select dd {
            padding: 0;
        }

        .layui-form-item select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin=primary] {
            margin: 0 !important;
            display: block;
            line-height: 36px !important;
            position: relative;
            padding-left: 26px;
        }

        .layui-form-item select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin=primary] span {
            line-height: 36px !important;
            float: none;
        }

        .layui-form-item select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin=primary] i {
            position: absolute;
            left: 10px;
            top: 0;
            margin-top: 9px;
        }

        .multiSelect {
            line-height: normal;
            height: auto;
            padding: 4px 10px;
            overflow: hidden;
            min-height: 38px;
            margin-top: -38px;
            left: 0;
            z-index: 99;
            position: relative;
            background: none;
        }

        .multiSelect a {
            padding: 2px 5px;
            background: #908e8e;
            border-radius: 2px;
            color: #fff;
            display: block;
            line-height: 20px;
            height: 20px;
            margin: 2px 5px 2px 0;
            float: left;
        }

        .multiSelect a span {
            float: left;
        }

        .multiSelect a i {
            float: left;
            display: block;
            margin: 2px 0 0 2px;
            border-radius: 2px;
            width: 8px;
            height: 8px;
            background: url(../../../img/close.png) no-repeat center;
            background-size: 65%;
            padding: 4px;
        }

        .multiSelect a i:hover {
            background-color: #545556;
        }
    </style>
    <script type="text/javascript">
        var zfryxbData = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        var zfryzfly = <%=SysmanageUtil.getAa10toJsonArrayXz("ZFRYLYBM")%>;
        var zfrysfzh_old = null;//身份证修改错误时，回填原值使用。
        var zfrysfzh = null;//身份证修改错误时，回填原值使用。
        var zfrycsrq_old = null;
        var zfryxb_old = null;
        var zfrypym_old = '';
        var form;
        var table;
        var layer;
        var a = true;
        $(function () {
            layui.use(['form', 'table', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                //电话号码验证
                form.verify({
                    tel: function (value, item) {
                        if (!new RegExp("^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$").test(value)) {
                            return '固定电话号码格式不正确，请使用下面的格式：020-88888888';
                        }
                    }

                });
                form.on('submit(save)', function (data) {
                    var url = basePath + '/zfba/zfrygl/reZfry';
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                obj.type = "ok";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                intSelectData('zflybmComBo', zfryzfly);
                intSelectData('zfryxb', zfryxbData);
                innitData();
            })
            //上传图片
            $('#btnselectZfryzp').click(function () {
                uploadFjViewCanNoId(10);
                return false;
            })
            //身份证改变,自动生成生日性别
            $('#zfrysfzh').blur(function () {
                var sfzh = $('#zfrysfzh').val();
                if (sfzh == zfrysfzh_old) {
                    a = true;
                    $('#zfrysfzh').removeAttr("style");
                    return;
                }
                if (sfzh != zfrysfzh) {
                    if (sfzh != null && sfzh != "") {
                        var obj = new Object();
                        obj.value = sfzh;
                        verifyZfrysfzh(obj);
                    } else {
                        layer.msg('身份证号不能为空', {time: 1000});
                        $('#zfrycsrq').val(zfrycsrq_old);
                        $('#zfryxb').val(zfryxb_old);
                        $('#zfrysfzh').val(zfrysfzh_old);
                        form.render();
                    }
                }
            })
            //姓名改变,自动生成首字母大写
            $('#description').blur(function () {
                var name = $('#description').val();
                if (name != zfrypym_old) {
                    getPinYin();
                }
            })
        })

        //初始化数据
        function innitData() {
            if ($('#userid').val().length > 0) {
                $.post(basePath + '/zfba/zfrygl/pzfryDTO', {
                            userid: $('#userid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                for (var attr in mydata) {
                                    $("#" + attr).val(mydata[attr]);
                                }
                                zfrysfzh_old = $('#zfrysfzh').val();
                                zfrysfzh = zfrycsrq_old = $('#zfrycsrq').val();
                                zfryxb_old = $('#zfryxb').val();
                                var v_aa = $('#zfryzflybm').val();
                                var v_cc = [];
                                v_cc = v_aa.split(',');
                                $("#zfryzflybmComBo").val(v_cc);
                                $("#zflybmComBo").val(v_cc);
                                getPinYin();
                                var obj = new Object();
                                obj.value = $('#zfrysfzh').val();
//                                verifyZfrysfzh(obj);
                                form.render();
                                var zfryzppath = $("#zfryzppath").val();
                                if (zfryzppath != "") {
                                    $("#zfryzp").attr("src", "<%=contextPath%>" + zfryzppath);
                                }
                            } else {
                                layer.alert('查询失败：' + result.msg);
                            }
                        }, 'json');

                if ('<%=op%>' == 'view') {
                    $('form :input').addClass('input_readonly');
                    $('form :input').attr('readonly', 'readonly');
                    $('form :input').attr('disabled', 'disabled');
                    $("#btnselectZfryzp").css('display', 'none');
                    $('#zjh').show();
                }
            }
        }

        //保存
        function save() {
            if ($('#zflybmComBo').val()) {
                var v_aa = $('#zflybmComBo').val();
                var v_cc = '';
                v_cc = v_aa.join(',');
                $("#zfryzflybm").val(v_cc);
                $('#zfryzflybmComBo').val(v_cc);
            }else{
                $("#zfryzflybm").val('');
                $('#zfryzflybmComBo').val('');
            }
            //手机号和电话号不为空时验证
            if ($('#telephone').val()) {
                $('#telephone').attr('lay-verify', "tel");
            } else {
                $('#telephone').removeAttr('lay-verify', "tel");
            }
            if ($('#mobile').val()) {
                $('#mobile').attr('lay-verify', "phone");
            } else {
                $('#mobile').removeAttr('lay-verify', "phone");
            }
            if ($('#mobile2').val()) {
                $('#mobile2').attr('lay-verify', "phone");
            } else {
                $('#mobile2').removeAttr('lay-verify', "phone");
            }
            if (a == false) {
                return false;
            }
            $('#save').click();
        }

        //验证身份证号码合法性
        function verifyZfrysfzh(obj) {
            var Zfrysfzh = obj.value;
            obj.value = Zfrysfzh.toUpperCase();//字符串转成大写
            a = validateCard(obj);
            if (!validateCard(obj)) {
                zfrysfzh = $('#zfrysfzh').val();
                $('#zfrysfzh').css('border-color', 'red');
//                $('#zfrysfzh').val(zfrysfzh_old);
//                $('#zfrycsrq').val(zfrycsrq_old);
//                $('#zfryxb').val(zfryxb_old);
//                form.render();
            } else {
                $('#zfrysfzh').val(validateCard(obj));
                form.render();
                checkZfrysfzh(obj);

            }

        }

        //验证身份证号码是否已经登记过
        function checkZfrysfzh(obj) {
            var zfrysfzh = obj.value;
            if (zfrysfzh != "") {
                $.post(basePath + '/zfba/zfrygl/isExistsZfry', {
                            'zfrysfzh': zfrysfzh
                        },
                        function (result) {
                            if (result.code == '0') {
                                checkMaskCard(obj, 'zfrycsrq', 'zfryxb', '1', '2');
                                zfrysfzh_old = $('#zfrysfzh').val();
                                zfrycsrq_old = $('#zfrycsrq').val();
                                zfryxb_old = $('#zfryxb').val();
                                form.render();
                                $('#zfrysfzh').removeAttr("style");
                            } else {
                                a = false;
                                layer.alert('提示' + result.msg);
                                $('#zfrysfzh').css('border-color', 'red');
                            }
                        },
                        'json');
            }
            form.render();
        }

        //获取姓名拼音
        function getPinYin() {
            zfrypym_old = $('#description').val();
            if (zfrypym_old != "") {
                $.post(basePath + '/zfba/zfrygl/getPY', {
                            'zfrypym': zfrypym_old
                        },
                        function (data) {
                            $('#zfrypym').val(data);
                        },
                        'json');
            }
        }

        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        // 上传图片附件
        function uploadFjViewCanNoId(prm_fjtype) {
            var v_fjwid = $("#zfryid").val();
            var url = basePath + 'pub/pub/uploadFjViewIndex';
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , title: '上传附件'
                , param: {
                    folderName: "zfrypic",
                    fjwid: v_fjwid,
                    fjtype: "10",
                    uploadOne: "yes"
                }
                , content: url
                , btn: ['关闭']
            }, function (dialogID) {
                var retVal = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (retVal != null) {
                    if (retVal.type == 'ok') {
                        $("#zfryzppath").val(retVal.fjpath);
                        $("#zfryzpname").val(retVal.fjname);
                        $("#zfryzp").attr("src", "<%=contextPath%>" + retVal.fjpath);
                    }
                    if (retVal.type == 'deleteok') {
                        var v_defaultpic = "/images/default.jpg";
                        $("#zfryzppath").val("");
                        $("#zfryzpname").val("");
                        $("#zfryzp").attr("src", "<%=contextPath%>" + v_defaultpic);
                    }
                }
            });
        }

        function closeModalDialogCallback(dialogID) {
            window.location.reload();
        }
    </script>
</head>
<body>
<div>
    <br/>

    <form id="fm" class="layui-form" action="">
        <input name="zfryzflybm" id="zfryzflybm" type="hidden"/>
        <input name="filepath" id="filepath" type="hidden"/>
        <input name="userid" id="userid" type="hidden" class="input_readonly"
               readonly="readonly" value="<%=userid%>"/>
        <input type="hidden" id="zfryid" name="zfryid">

        <table>
            <tr>
                <td>

                    <div class="layui-form-item" style="width: 400px">
                        <label class="layui-form-label" style="width: 110px"><span
                                class="myred">*</span>执法人员登录账号：</label>

                        <div class="layui-input-inline">
                            <input type="text" id="username" name="username" class="layui-input" lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item" style="width: 400px">
                        <label class="layui-form-label" style="width: 110px"><span class="myred">*</span>执法人员姓名：</label>

                        <div class="layui-input-inline">
                            <input type="text" id="description" name="description" class="layui-input"
                                   lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item" style="width: 400px">
                        <label class="layui-form-label" style="width: 110px">姓名拼音码：</label>

                        <div class="layui-input-inline">
                            <input type="text" id="zfrypym" name="zfrypym" class="layui-input" readonly>
                        </div>
                    </div>
                    <div class="layui-form-item" style="width: 400px">
                        <label class="layui-form-label" style="width: 110px">性别：</label>

                        <div class="layui-input-inline">
                            <select id="zfryxb" name="zfryxb"></select>
                        </div>
                    </div>
                </td>
                <td>
                    <br/>

                    <div class="layui-form-item" style="width: 400px">
                        <label class="layui-form-label" style="width: 100px"></label>
                        <img src="<%=contextPath%>/images/default.jpg" name="zfryzp" id="zfryzp"
                             style="margin: 5px 5px 0px 20px"
                             height="140" width="120" onclick="g_showBigPic(this.src);"/>

                        <div class="layui-form-item">
                            <input type="button" id="btnselectZfryzp" class="layui-btn layui-btn-sm"
                                   style="margin: 5px 5px 0px 150px"
                                   value="选择人员照片">
                        </div>
                        <input type="hidden" id="zfryzppath" name="zfryzppath">
                        <input type="hidden" id="zfryzpname" name="zfryzpname">
                    </div>
                </td>
            </tr>
        </table>

        <div class="layui-form-item">
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 110px">出生日期：</label>

                <div class="layui-input-inline">
                    <input type="text" id="zfrycsrq" name="zfrycsrq" class="layui-input" disabled>
                </div>
            </div>
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 145px">身份证号：</label>

                <div class="layui-input-inline" id="sfzh">
                    <input type="text" id="zfrysfzh" name="zfrysfzh" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 110px">手机号：</label>

                <div class="layui-input-inline">
                    <input type="text" id="mobile" name="mobile" class="layui-input">
                </div>
            </div>
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 145px">手机号2：</label>

                <div class="layui-input-inline">
                    <input type="text" id="mobile2" name="mobile2" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 110px">固定电话：</label>

                <div class="layui-input-inline">
                    <input type="text" id="telephone" name="telephone" class="layui-input">
                </div>
            </div>
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 145px">职务：</label>

                <div class="layui-input-inline">
                    <input type="text" id="zfryzw" name="zfryzw" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">执法领域：</label>

            <div class="layui-input-inline" style="width:575px">
                <select id="zflybmComBo" multiple name="zflybmComBo">
                    <option disabled>==请选择==</option>
                </select>
            </div>
            <input id="zfryzflybmComBo" name="zfryzflybmComBo" type="hidden">
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 110px">机构名称：</label>

                <div class="layui-input-inline">
                    <input type="text" id="orgname" name="orgname" class="layui-input">
                </div>
            </div>
            <div class="layui-input-inline" style="width: auto">
                <label class="layui-form-label" style="width: 145px">证件号码：</label>

                <div class="layui-input-inline">
                    <input type="text" id="zfryzjhm" name="zfryzjhm" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">备注：</label>

            <div class="layui-input-inline" style="width: 575px">
                <input type="text" id="zfrybz" name="zfrybz" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="save"
                        id="save">保存
                </button>
            </div>
        </div>
    </form>
</div>
</body>
</html>