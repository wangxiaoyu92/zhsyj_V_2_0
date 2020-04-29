<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String pdjgid = StringHelper.showNull2Empty(request.getParameter("pdjgid"));
    String djcshh = StringHelper.showNull2Empty(request.getParameter("djcshh"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>诚信评定结果</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">

        //下拉框列表
        //红黑榜等级
        var v_djcshh='<%=djcshh%>';
        var djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
        //生成方式
        var v_pdjgscfs = <%=SysmanageUtil.getAa10toJsonArray("PDJGSCFS")%>;
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            initYear();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;

                intSelectData('djcshh', djcshh);
                intSelectData('pdjgscfs', v_pdjgscfs);

                var url = basePath + 'zx/zxpdjg/saveZxpdjg';
                form.on('submit(save)', function (data) {
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
                form.on('select(select)', function (data) {
                    var comid = $("#comid").val();
                    var niandu = $("#niandu").val();
                    if (comid != "" && niandu != "") {
                        $.ajax({
                            url: basePath + "/zx/zxpdjg/sumScore",
                            data: {
                                "comid": comid,
                                "niandu": niandu
                            },
                            dataType: "json",
                            success: function (result) {
                                $("#pdjgdf").val(result.rows);
                            },
                            error: function () {
                                alert("系统有错误");
                            }
                        });

                    }
                });
                if ($('#pdjgid').val() != "" && $('#pdjgid').val() != null) {
                    $.post(basePath + 'zx/zxpdjg/queryZxpdjgDTO', {
                            pdjgid: $('#pdjgid').val(),
                            djcshh:v_djcshh
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
                        $('#niandu').attr('disabled', true);
                        $('#pdjgscfs').attr('disabled', true);
                        $("#bcytel").css('width', '228px');
                    }
                }
                if(v_djcshh==1){
                    $("#djcshh").val('1');
                }else {
                    $("#djcshh").val('2');
                }
                form.render();
            });
        });
        // 保存
        var submitForm = function () {
            var pdjgdf=$('#pdjgdf').val();
            var djcsqsfz;
            var djcsjsfz;
            if(v_djcshh==1){
                $.ajax({
                    type:'POST',
                    url:basePath + '/zx/zxpdjg/queryzxpddjcs',
                    dataType:'json',
                    data:{djcshh:1},
                    async:false,
                    success:function(result){
                        var mydata = result.data;
                        djcsqsfz=mydata.djcsqsfz;
                        djcsjsfz=mydata.djcsjsfz;
                    }
                });
               if(pdjgdf<djcsqsfz){
                   layer.msg('红名单企业得分要在'+djcsqsfz+'以上' ,{icon: 5,anim:6});
                   return false;
               }else if(pdjgdf>djcsjsfz){
                   layer.msg('红名单企业得分不能超过'+djcsjsfz ,{icon: 5,anim:6});
                   return false;
               }
            }else {
                $.ajax({
                            type:'POST',
                            url:basePath + '/zx/zxpdjg/queryzxpddjcs',
                            dataType:'json',
                            data:{djcshh:2},
                            async:false,
                            success:function(result){
                                var mydata = result.data;
                                djcsqsfz=mydata.djcsqsfz;
                                djcsjsfz=mydata.djcsjsfz;
                            }
                });
                if(pdjgdf>djcsjsfz){
                    layer.msg('黑名单企业得分要在'+djcsjsfz+'以下' ,{icon: 5,anim:6});
                    return false;
                }else  if(pdjgdf<djcsqsfz){
                    layer.msg('黑名单企业得分要在'+djcsqsfz+'以上' ,{icon: 5,anim:6});
                    return false;
                }
            }
            $("#saveAjdjBtn").click();
        };
        //页面加载完成自动生成年度信息
        function initYear() {
            var year = new Date().getFullYear();
            for (var i = year; i > 2010; i--) {
                var temp = '<option value=' + (i) + '>' + i + '</option>';
                //设置value的值和列表参数
                var $time = $(temp);
                $("#niandu").append($time);
            }
        }

        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex?a=' + new Date().getMilliseconds()
                , btn: ['确定'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return;
                }
                if (obj.type == 'ok') {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }
        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };


        //改变了企业的名称，则重新设置评定年份
        function setEmpty() {
            $("select[name='niandu']").next().find(".layui-select-title input").attr("value", "");
        }
    </script>
</head>

<body>
<div class="layui-table">
    <div region="center" style="overflow: visible;" border="false">
        <form class="layui-form" action="" id="zxpdjgForm">
            <input type="hidden" id="pdjgid" name="pdjgid" value="<%=pdjgid%>"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 113px"><font class="myred">*</font>企业代码:：</label>
                <div class="layui-input-inline">
                    <input type="text" id="comid" name="comid"
                           autocomplete="off" readonly class="layui-input" lay-verify="required">
                </div>

                <% if (!"view".equalsIgnoreCase(op)) {%>
                <div class="layui-input-inline" id="btnselectcom" style="width: 100px;">
                    <a href="javascript:void(0)" class="layui-btn"
                       iconCls="icon-search" onclick="myselectcom(),setEmpty()">选择企业 </a>
                </div>
                <%} %>
                <label class="layui-form-label" id="bcytel" style="width: 120px"><font
                        class="myred">*</font>企业名称：</label>
                <div class="layui-input-inline">
                    <input type="text" id="commc" name="commc" readonly="readonly"
                           autocomplete="off" class="layui-input" lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 113px"><font class="myred">*</font>年度：</label>
                <div class="layui-input-inline">
                        <select id="niandu" name="niandu" lay-verify="required" lay-filter="select">
                        <option value="">==请选择==</option>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 229px"><font class="myred">*</font>得分：</label>
                <div class="layui-input-inline">
                    <input type="text" id="pdjgdf"  name="pdjgdf" lay-verify="required"
                           autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 113px"><font class="myred">*</font>产生方式:</label>
                <div class="layui-input-inline">
                    <select id="pdjgscfs" name="pdjgscfs" lay-verify="required"></select>
                </div>
                <label class="layui-form-label" style="width: 229px">等级红黑:</label>
                <div class="layui-input-inline layui-form">
                    <select id="djcshh" name="djcshh" disabled="disabled"></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 113px">等级编码:</label>
                <div class="layui-input-inline">
                    <input type="text" id="djcsbm" name="djcsbm"
                           autocomplete="off" readonly class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 229px">备注:</label>
                <div class="layui-input-inline">
                    <input type="text" id="beizhu" name="beizhu" autocomplete="off" class="layui-input">
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
</div>
</body>
</html>