<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
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
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userdalei = sysuser.getUserdalei();//1非机构用户2机构用户
    String name = sysuser.getUsername();//获取当前登录用户

%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    String v_jyjcffbzbid = StringHelper.showNull2Empty(request.getParameter("jyjcffbzbid"));  //检测方法Id
    String v_comid2 = "nocomid";
    if (v_jyjcffbzbid != null && !"".equalsIgnoreCase(v_jyjcffbzbid)) {
        v_comid2 = v_jyjcffbzbid;
    }

%>
<!DOCTYPE html>
<html>
<head>
    <title><title>机构信息</title>
    </title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var jcffbzbhOld='';
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var index;
        var v_jyjcbzstate = <%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
        var v_sfyx = <%=SysmanageUtil.getAa10toJsonArray("sfyx")%>;
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#fbrq'
                });
                laydate.render({
                    elem: '#ssrq'
                });
                laydate.render({
                    elem: '#fzrq'
                })
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(saveNews)', function (data) {
                    var formData = data.field;
                    /*console.log(formData)*/
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + 'jyjc/jcffglForm', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                if ('' == '<%=op%>') {
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
                //将数据加载到编辑页面的表单中
                var v_jcffid = '<%=v_jyjcffbzbid%>';
                if (v_jcffid != null && v_jcffid != "") {
                    $.post(basePath + 'jyjc/queryJyjcffbzbDto', {
                                jyjcffbzbid: v_jcffid   //(将数据库中值通过此id传给前段页面)
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata=result.data
                                    $('form').form('load',mydata);
                                    jcffbzbhOld=mydata.jcffbzbh;
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
                        $('#bznr').attr('readonly', 'readonly');
                        $('#fbrq').attr('disabled', true);
                        $('#ssrq').attr('disabled', true);
                        $('#fzrq').attr('disabled', true);
                        $('#sfyx').attr('disabled', true);
                        $('#jyjcbzstate').attr('disabled', true);
                    }
                }
            });
            intSelectData('jyjcbzstate',v_jyjcbzstate);
            intSelectData('sfyx',v_sfyx);
            $('#jcffbzbh').blur(function () {
                var jcffbzbh = $('#jcffbzbh').val();
                if (jcffbzbh == null || jcffbzbh == '') {
                    return false;
                }
                if (jcffbzbh != jcffbzbhOld) {
                    checkUniqueness();
                }
            })
        });
        //验证编码唯一性
        function checkUniqueness() {
            var jcffbzbh = $('#jcffbzbh').val().toUpperCase();
            if (jcffbzbh != null && jcffbzbh != "") {
                $.post(basePath + 'jyjc/checkCode', {
                            jcffbzbh: jcffbzbh
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.total;
                                //存在
                                if (mydata > 0) {
                                    layer.msg("编号重复请重新填写");
                                    $('#jcffbzbh').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编码唯一</font>");
                                } else {
                                    $('#jcffbzbh').val(jcffbzbh);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
            }
        }
    function submitForm() {
        $("#saveNewsBtn").click();
    }
    // 关闭窗口
    function closeWindow() {
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    }

    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" action="">
            <input id="jyjcffbzbid" name="jyjcffbzbid" type="hidden">

            <div class="layui-container">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px"><font class="myred">*</font>检测方法标准编号:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcffbzbh" name="jcffbzbh" class="layui-input" lay-verify="required">
                            </div>
                            <div class="layui-input-inline">
                                <font color="red" id="greentext" style="line-height: 35px">保证编码唯一</font>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测方法标准名称:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="jcffbzmc" name="jcffbzmc" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">检测方法标准类别:</label>

                            <div class="layui-input-inline layui-input-treeselect">
                                <input type="text" name="jcffbzlb" id="jcffbzlb" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">发布日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="fbrq" name="fbrq"
                                       autocomplete="off" class="layui-input ">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">标准状态:</label>

                            <div class="layui-input-inline">
                                <select id="jyjcbzstate" name="jyjcbzstate"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">实施日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="ssrq" name="ssrq"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">颁发部门:</label>
                            <%--<font class="myred">*</font>--%>
                            <div class="layui-input-inline">
                                <input type="text" id="bfbm" name="bfbm"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">废止日期:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="fzrq" name="fzrq"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">标准替代情况:</label>

                            <div class="layui-input-inline">
                                <input type="text" id="bztdqk" name="bztdqk" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 120px">是否有效:</label>

                            <div class="layui-input-inline">
                                <select id="sfyx" name="sfyx"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                        <div class="layui-form-item" style="width: auto">
                            <label class="layui-form-label" style="width: 120px">标准内容:</label>
                            <%--<font class="myred">*</font>--%>
                            <div class="layui-input-inline" style="width: 70%;height: 200px">
                                <textarea id="bznr" name="bznr" style="width: 100%;height:150px"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="saveNews"
                                    id="saveNewsBtn">保存
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