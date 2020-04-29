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
    String id = StringHelper.showNull2Empty(request.getParameter("id"));
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>企业信用</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        var v_discredtype = [{"id": "", "text": "===请选择==="}, {"id": "1", "text": "严重失信"}, {"id": "2", "text": "失信"}];


        $(function () {
            intSelectData("type", v_discredtype);
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                var laydate = layui.laydate;
                var url = basePath + 'aqcx/discred/saveDiscredObj';
                // 提交表单，保存
                form.on('submit(savediscred)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 500}, function () {
                                var obj = new Object();
                                obj.type = "ok";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    })
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
               /* laydate.render({
                    elem: '#enrolrq'
                    , type: 'datetime'
                });
                laydate.render({
                    elem: '#moverq'
                    , type: 'datetime'
                });*/
                var start = {
                    elem: '#enrolrq',
                    type:'datetime',
                    show: true,
                    closeStop: '#enrolrq'

                };
                var end = {
                    elem: '#moverq',
                    type:'datetime',
                    show: true,
                    closeStop: '#moverq'
                };
                lay('#enrolrq').on('click', function(e){
                    if($('#moverq').val() != null && $('#moverq').val() != undefined && $('#moverq').val() != ''){
                        start.max = $('#moverq').val();
                    }
                    laydate.render(start);
                });
                lay('#moverq').on('click', function(e){
                    if($('#enrolrq').val() != null && $('#enrolrq').val() != undefined && $('#enrolrq').val() != ''){
                        end.min = $('#enrolrq').val();
                    }
                    laydate.render(end);
                });
                var v_id = $("#id").val();
                if (v_id != null && v_id.length > 0) {
                    $.post(basePath + 'aqcx/discred/queryDiscredObj', {
                                id: v_id
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('#sysUserForm').form('load', result.discredInfo);
                                    form.render();
                                }
                            }, 'json');
                }
                if ('<%=op%>' == 'view') {
                    $('form :input').addClass('input_readonly');
                    $('form :input').attr('readonly', 'readonly');
                    $('#enrolrq').attr('disabled', 'disabled');
                    $('#moverq').attr('disabled', 'disabled');
                    $('#a').css('display', 'none');
                    $('#type').attr("disabled", true);
                }

            });
        })

        //        function initSelectData() {
        //            var typeOptions = '';
        //            for (var i = 0; i < v_discredtype.length; i++) {
        //                typeOptions += '<option value=\'' + v_discredtype[i].id + '\' >' + v_discredtype[i].text + '</option>';
        //            }
        //            $("#type").append(typeOptions);
        //
        //        }
        // 提交表单
        function submitForm() {
            $("#saveUserBtn").click();
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        //从单位信息表中读取
        function myselectcom() {
            var url = basePath + 'pub/pub/selectcomIndex';
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#comname").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }

    </script>
</head>

<body>
<br/>

<form id="sysUserForm" class="layui-form" action="">
    <div class="layui-form-item">

        <label class="layui-form-label" style="width: 100px">企业信用ID：</label>

        <div class="layui-input-inline">
            <input type="text" name="id" id="id" readonly
                   value="<%=id%>" autocomplete="off" class="layui-input layui-bg-gray">
        </div>

        <label class="layui-form-label"><span style="color: red;">*</span>企业名称:</label>

        <div class="layui-input-inline">
            <input id="comid" name="comid" type="hidden">
            <input type="text" name="comname" id="comname" required lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
        <div class="layui-input-inline" style="width: 100px" id="a">
            <a href="javascript:void(0)" class="layui-btn"
               iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>列入失信原因：</label>

        <div class="layui-input-block">
            <textarea style="width: 600px" id="reason" name="reason" class="layui-textarea" required
                      lay-verify="required"></textarea>
        </div>
    </div>

    <div class="layui-form-item">

        <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>信用类别:</label>

        <div class="layui-input-inline">
            <select name="type" id="type" autocomplete="off" lay-verify="required">
            </select>
        </div>

        <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>列入失信时间</label>

        <div class="layui-inline">
            <input id="enrolrq" name="enrolrq" class="layui-input test-item" readonly style="width: 200px"
                   type="text" lay-verify="required">
        </div>

    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">序号:</label>

        <div class="layui-input-inline">
            <input type="text" name="serialnumber" id="serialnumber"
                   autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
        </div>
        <label class="layui-form-label" style="width: 100px">类别:</label>

        <div class="layui-input-inline">
            <input type="text" name="category" id="category" style="width: 200px"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">列入人员:</label>

        <div class="layui-input-inline">
            <input type="text" name="includery" id="includery"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label" style="width: 100px">移除失信时间</label>

        <div class="layui-inline">
            <input id="moverq" name="moverq" class="layui-input test-item"  readonly style="width: 200px"
                   type="text">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">移除失信原因：</label>

        <div class="layui-input-block">
            <textarea id="removal" name="removal" style="width: 600px" class="layui-textarea"
                      ></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">移除人:</label>

        <div class="layui-input-inline">
            <input type="text" name="removery" id="removery"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item" style="display: none">
            <div class="layui-input-inline">
                <button class="layui-btn" lay-submit="" lay-filter="savediscred" id="saveUserBtn">保存</button>
            </div>
        </div>
    </div>
</form>
</body>
</html>
