<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
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
    String v_jcxmid = StringHelper.showNull2Empty(request.getParameter("jyjcxmid"));  //企业id

%>
<!DOCTYPE html>
<html>
<head>
    <title><title>检验检测项目</title>
    </title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <%--<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>--%>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + 'jyjc/saveJyjcxm', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                if(''==('<%=op%>')){
                                    obj.type = "saveOk";
                                }else {
                                    obj.type="ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                //将数据加载到编辑页面的表单中
                var jcxmid = '<%=v_jcxmid%>';
                if (jcxmid != null && jcxmid!="") {
                    $.post(basePath + 'jyjc/queryJyjcxmDTO', {
                                jcxmid: jcxmid   //(将数据库中值通过此id传给前段页面)
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('form').form('load', result.data);
                                    form.render();
                                    if ('<%=op%>' == 'view') {
                                        $('#jcxmbh').attr('readonly', 'readonly');
                                        $('#jcxmmc').attr('readonly', 'readonly');
                                        $('#jcxmbzz').attr('readonly', 'readonly');
                                    }

//								$("#jcxmbh").val();
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                    /*					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');*/
                                }

                            }, 'json');
                }
            });
        })
        function submitForm() {
            if($("#jcxmbzz").val()!=""&&$("#jcxmbzz").val()!=null){
                $("#jcxmbzz").attr("lay-verify","number");
            }
            $("#saveRoleBtn").click();
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>

<body>
<form class="layui-form" action="" id="pcompany">
    <input type="hidden" name="jyjcxmid" id="jyjcxmid"/>
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><font class="myred">*</font>检测项目编码:</td>
            <td>
                <input type="text" id="jcxmbh" name="jcxmbh" lay-verify="required"
                       class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><font class="myred">*</font>检测项目名称:</td>
            <td>
                <input type="text" id="jcxmmc" name="jcxmmc" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px">检测项目标准值:</td>
            <td>
                <input type="text" id="jcxmbzz" name="jcxmbzz"
                       autocomplete="off" class="layui-input" lay-verify="num">
            </td>
        </tr>
    </table>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="saveRole"
                    id="saveRoleBtn">保存
            </button>
        </div>
    </div>
</form>
</body>
</html>