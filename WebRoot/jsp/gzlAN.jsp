<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>工作流按钮</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        var url;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
            });
            $('#btn_zfbalc').click(function () {
                // var url = basePath + 'jsp/workflowyewu/wfyw_zfbalct.jsp';
                var url = basePath + 'images/zmdzfbalc.jpg';
                var title = '执法办案流程图';
                open(title, url);
                return false;
            });
            $('#btn_gwglswlc').click(function () {
                var url = basePath + 'images/gwglswlc.png';
                var title = '公文管理收文流程';
                open(title, url);
                return false;
            });
            $('#btn_gwglfwlc').click(function () {
                var url = basePath + 'images/gwglfwlc.png';
                var title = '公文管理发文流程';
                open(title, url);
                return false;
            });
        });

        function open(title, url) {
            parent.layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%']
                , offset: ['0px', '0px']
                , title: title
                , content: url
                , btn: ['关闭']
            });
        }

    </script>
</head>
<body>
<div style="margin: 10px">
    <button class="layui-btn layui-btn-normal" id="btn_zfbalc">执法办案流程图</button>
    <button class="layui-btn layui-btn-normal" id="btn_gwglswlc">公文管理收文流程</button>
    <button class="layui-btn layui-btn-normal" id="btn_gwglfwlc">公文管理发文流程</button>
</div>
</body>
</html>