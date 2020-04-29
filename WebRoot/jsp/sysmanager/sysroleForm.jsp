<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String roleid = StringHelper.showNull2Empty(request.getParameter("roleid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>角色编辑</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;

                var url;
                if ($('#roleid').val().length > 0) {
                    url = basePath + 'sysmanager/sysrole/updateSysrole';
                } else {
                    url = basePath + 'sysmanager/sysrole/addSysrole';
                }
                var lock = true;
                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    /*console.log(formData)*/
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false; //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
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
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            });
            var v_roleid = $("#roleid").val();
            if (v_roleid != null && v_roleid.length > 0) {
                $.post(basePath + 'sysmanager/sysrole/querySysroleDTO', {
                            roleid: v_roleid
                        },
                        function (result) {
                            if (result.code == '0') {
                                $('form').form('load', result.data);
                                form.render();
                            }
                        }, 'json');
            }
        });

        function submitForm() {
            $("#saveRoleBtn").click();
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<br/>

<form id="fm" class="layui-form" action="">
    <table class="layui-table" lay-skin="nob">
        <tr>
            <td style="text-align:right;width: 141px;height: 57px">角色ID:</td>
            <td><input type="text" name="roleid" id="roleid" readonly
                       value="<%=roleid%>" autocomplete="off" class="layui-input layui-bg-gray"></td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><span style="color: red;">*</span>角色名称:</td>
            <td><input type="text" name="rolename" id="rolename" required lay-verify="required"
                       autocomplete="off" class="layui-input"></td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><span style="color: red;">*</span>角色类型:</td>
            <td><select name="sysroleflag" lay-verify="required">
                <option value="">===请选择===</option>
                <option value="0">非系统角色</option>
                <option value="1">系统角色</option>
            </select></td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px">角色描述:</td>
            <td><input type="text" name="roledesc" id="roledesc" autocomplete="off" class="layui-input"></td>
        </tr>
        <tr>
            <td style="text-align:right;width: 141px;height: 57px"><span style="color: red;">*</span>所属机构:</td>
            <td><input type="text" name="orgname" id="orgname" required lay-verify="required" readonly
                       autocomplete="off" class="layui-input" onclick="showMenu_sysorg();">
                <input name="orgid" id="orgid" type="hidden"/>

                <div id="menuContent_sysorg" class="menuContent" style="display:none; ">
                    <ul id="treeDemo_sysorg" class="ztree"
                        style="margin-top:0px;width:auto;height:250px;"></ul>
                </div></td>
        </tr>
    </table>
    <div class="layui-inline">
        <div class="layui-form-item" style="display: none">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="saveRole" id="saveRoleBtn">保存
                </button>
            </div>
        </div>
    </div>
</form>
</body>
</html>