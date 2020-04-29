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
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
    String v_comxkzid = StringHelper.showNull2Empty(request.getParameter("comxkzid"));  //企业id
    String v_title = "资质证明管理";
    if (op != null && "add".equalsIgnoreCase(op)) {
        v_title = "资质证明 新增";
    } else if (op != null && "edit".equalsIgnoreCase(op)) {
        v_title = "资质证明 编辑";
    } else if (op != null && "view".equalsIgnoreCase(op)) {
        v_title = "资质证明 查看";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>企业信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">

        // 资质证明
        var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
        // 主体业态
        var zzzmztyt = <%=SysmanageUtil.getAa10toJsonArray("ZZZMZTYT")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function () {
            // 资质证明

            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#comxkyxqq'
                });
                laydate.render({
                    elem: '#comxkyxqz'
                });
                // 主体业态
                var lock = true;// 锁住表单   这里定义一把锁
                var url = basePath + '/pcompany/savePcompanyXkzSingle';
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
                            lock = true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#comxkzid').val().length > 0) {
                    $.post(basePath + 'pcompany/queryPcompanyXkzDTO', {
                                comxkzid: $('#comxkzid').val()
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    for (var attr in mydata) {
                                        $("#" + attr).val(mydata[attr]);
                                    }
                                    form.render();
                                    //$('#comdalei').combobox('setValues',eval("["+mydata.comdalei2+"]"));
                                    var zzzmpath = $("#zzzmpath").val();
                                    if (zzzmpath != "") {
                                        $("#zzzmpic").attr("src", "<%=contextPath%>" + zzzmpath);
                                    }
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                }
                ;

                if ('<%=op%>' == 'view') {
                    $('form :input').addClass('input_readonly');
                    $('form :input').attr('readonly', 'readonly');
                    $('#comxkyxqq').attr('disabled', true);
                    $('#comxkyxqz').attr('disabled', true);
                    $('#comxkzlx').attr('disabled', true);
                    $('#comxkzztyt').attr('disabled', true);
                    $('#btnzzzmpic').css('display', 'none');

                }
            });
            intSelectData('comxkzztyt', zzzmztyt);
            intSelectData('comxkzlx', comzzzm);
        });

        // 关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name))
        };

        // 保存
        var submitForm = function () {
            var comxkyxqq = $('#comxkyxqq').val();
            var comxkyxqz = $('#comxkyxqz').val();
            if (comxkyxqq < comxkyxqz) {
                $("#saveZzzmBtn").click();
            } else {
                $('#comxkyxqq').css('border-color', 'red');
                $('#comxkyxqz').css('border-color', 'red');
                layer.msg('起始时间必须小于结束时间', {icon: 5, anim: 6});
            }

        };

        // 上传图片附件
        function uploadFjViewCanNoId(prm_fjtype) {
            var v_fjwid = $("#comxkzid").val();
            var v_comxkzlx = $("#comxkzlx").val();
            var v_fjtype = "1";
            if (v_comxkzlx != null && v_comxkzlx != "") {
                v_fjtype = "ZZZM" + v_comxkzlx;
            }

            var url = basePath + "/pub/pub/uploadFjViewIndex";
            //创建模态窗口
            sy.modalDialog({
                title: '上传图片附件'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    uploadOne: "yes",
                    folderName : "companyzzzm",
                    fjwid : v_fjwid,
                    fjtype : v_fjtype
                }
                , btn: ['关闭']
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        if (prm_fjtype == "zzzm") {//企业门头照
                            $("#zzzmpath").val(obj.fjpath);
                            $("#zzzmname").val(obj.fjname);
                            $("#zzzmpic").attr("src", "<%=contextPath%>" + obj.fjpath);
                        }
                    }
                    if (obj.type == 'deleteok') {
                        var v_defaultpic = "/images/default.jpg";
                        if (prm_fjtype == "zzzm") {//企业门头照
                            $("#zzzmpath").val("");
                            $("#zzzmname").val("");
                            $("#zzzmpic").attr("src", "<%=contextPath%>" + v_defaultpic);
                        }
                    }
                }
            });
        }

    </script>
</head>

<body>
<div data-options="region:'north'"
     style="height:40px;text-align:center;">
    <font style="font-size:200%;text-align:right;color: green;"><%=v_title%>
    </font>
</div>
<form id="fm" class="layui-form" action="">
    <input type="hidden" id="comxkzid" name="comxkzid" value="<%=v_comxkzid %>">
    <input type="hidden" id="comid" name="comid" value="<%=v_comid %>">
    <input type="hidden" id="sjdatatime" name="sjdatatime">
    <input type="hidden" id="sjdataid" name="sjdataid">
    <input type="hidden" id="sjdatacomdm" name="sjdatacomdm">

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%"><font class="myred">*</font>资质证明类型:</label>

        <div class="layui-input-inline" style="width: 80%">
            <select id="comxkzlx" name="comxkzlx" lay-verify="required"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%"><font class="myred">*</font>编号(注册号):</label>

        <div class="layui-input-inline" style="width: 80%">
            <input type="text" id="comxkzbh" name="comxkzbh" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%"><font class="myred">*</font>有效期起:</label>

        <div class="layui-input-inline" style="width: 80%">
            <input type="text" id="comxkyxqq" name="comxkyxqq" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%"><font class="myred">*</font>有效期止:</label>

        <div class="layui-input-inline" style="width: 80%">
            <input type="text" id="comxkyxqz" name="comxkyxqz" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%">许可范围(经营范围):</label>

        <div class="layui-input-inline" style="width: 80%">
			<textarea class="layui-textarea" id="comxkfw" name="comxkfw" cols="20"
                      rows="10"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%"><font class="myred">*</font>主体业态:</label>

        <div class="layui-input-inline" style="width: 80%">
            <select id="comxkzztyt" name="comxkzztyt" lay-verify="required"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%">经营场所:</label>

        <div class="layui-input-inline" style="width: 80%">
            <input type="text" id="comxkzjycs" name="comxkzjycs"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 10%">组成形式:</label>

        <div class="layui-input-inline" style="width: 80%">
            <input type="text" id="comxkzzcxs" name="comxkzzcxs"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:10%">资质证明图片:</label>

        <div class="layui-input-inline" style="text-align:center;height: 165px;width: 80%">
            <div style="text-align: center;"
                 id="zzzmzhaopian_div">
                <img src="<%=contextPath%>/images/default.jpg"
                     name="zzzmpic" id="zzzmpic" height="130" width="170"
                     onclick="g_showBigPic(this.src);"/>
            </div>
            <% if (op != null && !"view".equalsIgnoreCase(op)) { %>
            <a id="btnzzzmpic" href="javascript:void(0)"
               class="layui-btn" iconCls="icon-upload"
               onclick="uploadFjViewCanNoId('zzzm')">选择资质证明图片</a>
            <%} %>
            <input type="hidden" id="zzzmpath" name="zzzmpath">
            <input type="hidden" id="zzzmname" name="zzzmname">
        </div>
    </div>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save" id="saveZzzmBtn">保存
            </button>
        </div>
    </div>
</form>
</body>
</html>