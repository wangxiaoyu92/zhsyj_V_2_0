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

%>
<%
	String eventjdzb = StringHelper.showNull2Empty(request.getParameter("eventjdzb"));
	String eventwdzb = StringHelper.showNull2Empty(request.getParameter("eventwdzb"));
	String eventcontent = StringHelper.showNull2Empty(request.getParameter("eventcontent"));
	String operateperson = StringHelper.showNull2Empty(request.getParameter("operateperson"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>极光推送内容</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        $(function () {
            var eventjdzb=$("#eventjdzb").val();
            var eventwdzb=$("#eventwdzb").val();
            var v_eventcontent=$("#eventcontent").val();
            var operateperson=$("#operateperson").val();
            $("#texts").val(v_eventcontent);
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;

                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    var texts=$("#texts").val();
					/*console.log(formData)*/
					var v_url='/common/sjb/yingjidiaodu';
					if ("all"==operateperson){
                        v_url='/common/sjb/yingjidiaoduAll';
					};
                    $.post(basePath + v_url, {
                            "eventjdzb": eventjdzb,
                            "eventwdzb": eventwdzb,
                            "eventcontent": texts,
                            "operateperson": operateperson,
							"texts":texts
                        },
                        function (result) {
                            if (result.code == '0') {
                                $.messager.alert('提示', '发送调度通知成功！', 'info');
                                closeWindow();
                            } else {
                                $.messager.alert('提示', '发送调度通知失败：' + result.msg, 'error');
                            }
                        },
                        'json');
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            })
        })
        function submitForm() {
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
		<input type="hidden" name="eventjdzb" id="eventjdzb" value="<%=eventjdzb %>">
		<input type="hidden" name="eventwdzb" id="eventwdzb" value="<%=eventwdzb %>">
		<input type="hidden" name="eventcontent" id="eventcontent" value="<%=eventcontent %>">
		<input type="hidden" name="operateperson" id="operateperson" value="<%=operateperson %>">

		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">请输入</label>
			<div class="layui-input-block">
				<textarea id="texts" name="texts"  style="width: 320px;" rows="6" placeholder="请输入内容" class="layui-textarea" value="<%=eventcontent%>"></textarea>
			</div>
		</div>

		<div class="layui-form-item" style="display: none">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="saveRole"
						id="saveRoleBtn">确定
				</button>
			</div>
		</div>
	</form>

</body>
</html>