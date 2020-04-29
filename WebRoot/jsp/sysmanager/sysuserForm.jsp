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
    Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();//获取当前用户
    String v_cur_userkind=vSysUser.getUserkind();
%>
<%
    String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户编辑</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <style>
        .layui-form-label {
            width: 98px;
        }
    </style>
    <script type="text/javascript">
//        // 设置默认返回值
//        var obj = new Object();
//        obj.type = "ng"; // 当为ok时，父页面刷新；不是ok时，不刷新父页面
//        sy.setWinRet(obj);
        var form;
        var layer;
        //下拉框列表

        var v_userkind  // 用户类别
        var v_cur_userkind="<%=v_cur_userkind%>";
        if (v_cur_userkind=="20"){//检验检测机构
            v_userkind = <%=SysmanageUtil.getAa10toJsonArray("JCJGUSERKIND")%>; // 用户类别
        }else{
            v_userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>; // 用户类别
        };

        var v_lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>;  // 用户锁定状态
        var v_selfcomflag = <%=SysmanageUtil.getAa10toJsonArray("SELFCOMFLAG")%>; // 是否只能查看自己监管的企业
        var v_userposition = <%=SysmanageUtil.getAa10toJsonArray("USERPOSITION")%>; // 职位
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url;
                // 职位
                intSelectData('userposition', v_userposition);
                // 用户类别下拉框
                intSelectData('userkind', v_userkind);
                // 用户锁定状态
                intSelectData('lockstate', v_lockstate);
                // 是否只能查看自己监管的企业
                intSelectData('selfcomflag', v_selfcomflag);

                $('#lockstate').val('0');
                $('#selfcomflag').val('0');
                form.render();
                if ($('#userid').val().length > 0) {
                    url = basePath + 'sysmanager/sysuser/updateSysuser';
                } else {
                    url = basePath + 'sysmanager/sysuser/addSysuser';
                }
                //电话号码验证
                form.verify({
                    tel: function (value, item) {
                        if (!new RegExp("^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$").test(value)) {
                            return '固定电话号码格式不正确，请使用下面的格式：020-88888888';
                        }
                    }

                });

                var lock = true;// 锁住表单   这里定义一把锁
                // 提交表单，保存
                form.on('submit(saveUser)', function (data) {
                    debugger
                    var formData = data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        debugger
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                if(''==('<%=op%>')){
                                    obj.type = "saveOk";
                                }else {
                                    obj.type="ok";
                                };
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
                var v_userid = $("#userid").val();
                if (v_userid != null && v_userid.length > 0) {
                    $.post(basePath + 'sysmanager/sysuser/querySysuserDTO', {
                                userid: v_userid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    $('#sysUserForm').form('load', result.data);
                                    form.render();
                                }
                            }, 'json');
                }
            });
        });

        // 提交表单
        function submitForm() {
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
            $("#saveUserBtn").click();
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div style="padding-top: 20px">
    <form id="sysUserForm" class="layui-form" action="">
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label">用户ID:</label>

                <div class="layui-input-inline">
                    <input type="text" name="userid" id="userid" readonly
                           value="<%=userid%>" autocomplete="off" class="layui-input layui-bg-gray">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>登陆帐号:</label>

                <div class="layui-input-inline">
                    <input type="text" name="username" id="username" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>用户名称:</label>

                <div class="layui-input-inline">
                    <input type="text" name="description" id="description" required lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>用户类别:</label>

                <div class="layui-input-inline">
                    <select name="userkind" id="userkind" autocomplete="off" lay-verify="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>账户锁定状态:</label>

                <div class="layui-input-inline">
                    <select name="lockstate" id="lockstate" autocomplete="off" lay-verify="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>所属机构:</label>

                <div class="layui-input-inline">
                    <input type="text" name="orgname" id="orgname" required lay-verify="required" readonly
                           class="layui-input" onclick="showMenu_sysorg();">
                    <input name="orgid" id="orgid" type="hidden"/>

                    <div id="menuContent_sysorg" class="menuContent" style="display:none;position:fixed;z-index:333; ">
                        <ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:178px;height:200px;"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>所属区域:</label>

                <div class="layui-input-inline">
                    <input type="text" name="aaa027name" id="aaa027name" required lay-verify="required" readonly
                           class="layui-input" onclick="showMenu_aaa027();">
                    <input name="aaa027" id="aaa027" type="hidden"/>

                    <div id="menuContent_aaa027" class="menuContent" style="display:none;position:fixed;z-index:333;">
                        <ul id="treeDemo_aaa027" class="ztree" style="height:200px;width: 178px;"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label">电话号码:</label>

                <div class="layui-input-inline">
                    <input type="text" name="telephone" id="telephone"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label">手机号1:</label>

                <div class="layui-input-inline">
                    <input type="text" name="mobile" id="mobile"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label">手机号2:</label>

                <div class="layui-input-inline">
                    <input type="text" name="mobile2" id="mobile2"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label">职位:</label>
                <div class="layui-input-inline">
                    <select name="userposition" id="userposition" autocomplete="off" ></select>
                </div>
            </div>
        </div>
        <% if (!"20".equals(v_cur_userkind)){%>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label"><span style="color: red;">*</span>是否只能查看自己监管的企业:</label>

                <div class="layui-input-inline">
                    <select name="selfcomflag" id="selfcomflag" autocomplete="off" lay-verify="required">
                    </select>
                </div>
            </div>
        </div>
        <%}%>

        <div class="layui-inline">
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit="" lay-filter="saveUser" id="saveUserBtn">保存</button>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>