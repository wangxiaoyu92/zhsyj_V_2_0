<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>初始化超级管理员权限</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var element;
        var layer;
        $(function () {
            layui.use(['element', 'layer'], function () {
                element = layui.element;
                layer = layui.layer;
            });
        });
        function saveFun() {
            $("#btnSave").disabled = true;
            $("#loading-mask").show();
            $.ajax({
                url: "<%=contextPath %>/sysmanager/sysuser/initSuper",
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: '',
                dataType: 'json',
                error: function () {
                    layer.alert('服务器繁忙，请稍后再试！', function (index) {
                        $("#btnSave").disabled = false;
                        $("#loading-mask").hide();
                        layer.close(index);
                    });
                },
                success: function (result) {
                    if (result.code == "0") {
                        layer.alert('初始化成功！', function (index) {
                            $("#btnSave").disabled = false;
                            $("#loading-mask").hide();
                            layer.close(index);
                        });
                    } else {
                        layer.alert('初始化失败！' + result.msg, function (index) {
                            $("#btnSave").disabled = false;
                            $("#loading-mask").hide();
                            layer.close(index);
                        });
                    }
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item" style="width:100%;height:50%;">
            <h2 class="layui-colla-title">初始化超级管理员权限</h2>
            <div class="layui-colla-content layui-show">
                <div id="loading-mask" style="display:none;z-index:20000;text-align:center;">
                    <img src="<%=contextPath%>/images/frame/loading_square.gif" align="absmiddle"/>
                </div>
                <div style="text-align:center">
                    <ck:permission biz="initSuper">
                        <button class="layui-btn" data-type="initSuper"
                                data="btn_initSuper" onclick="saveFun()">>>>>初始化超级管理员权限>>>>
                        </button>
                    </ck:permission>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
