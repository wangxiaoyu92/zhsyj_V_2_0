<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_infoid = StringHelper.showNull2Empty(request.getParameter("infoid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>采纳链接</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style type="text/css">
		body{
			overflow: scroll;
		}
	</style>

	<script type="text/javascript">
        // 是否采纳
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function() {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/work/task/linkInfo';
                form.on('submit(save)', function (data) {
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
                })
                var v_id = $("#infoid").val();
                if (v_id != null && v_id.length > 0) {
                    $.post(basePath + '/work/task/queryInfoObj', {
                            infoid: v_id
                        },
                        function (result) {
                            if (result.code == '0') {
                                $('#sysUserForm').form('load', result.Info);
                                form.render();
                            }
                        }, 'json');
                }
			})
        })
        // 提交表单
        function submitForm() {
            $("#saveAjdjBtn").click();
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }




	</script>
</head>
<body>
<form id="sysUserForm" class="layui-form" action="">
	<input id="infoid" name="infoid" type="hidden" value="<%=v_infoid%>"/>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px">采纳链接：</label>
		<div class="layui-input-block">
            <textarea style="width: 600px" id="linkaddress" name="linkaddress" class="layui-textarea"
					  lay-verify="required"></textarea>
		</div>
	</div>

	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
			</button>
		</div>
	</div>





	<%--<table class="layui-table" lay-skin="nob">--%>
		<%--<tr>--%>
			<%--<td style="text-align:right;;width: 141px;height: 57px"><nobr>信息内容：</nobr></td>--%>
			<%--<td><input type="text" id="content" name="content" lay-verify="required"--%>
					   <%--class="layui-input"></td>--%>
		<%--</tr>--%>

		<%--<tr>--%>
			<%--<td style="text-align:right;;width: 141px;"><nobr>文档内容：</nobr></td>--%>
			<%--<td>--%>
				<%--<textarea id="archivecontent" name="archivecontent"></textarea>--%>
			<%--</td>--%>
		<%--</tr>--%>
		<%--<tr>--%>
			<%--<td style="text-align:right;;width: 141px;"><nobr>科室：</nobr></td>--%>
			<%--<td>--%>
				<%--<input type="text" id="orgname" name="orgname"--%>
					   <%--autocomplete="off" class="layui-input" readonly="readonly">--%>
				<%--<a href="javascript:void(0)" class="layui-btn"--%>
				   <%--iconCls="icon-search" onclick="myselectcom()">选择科室 </a>--%>
			<%--</td>--%>
		<%--</tr>--%>
		<%--<tr>--%>
			<%--<td style="text-align:right;;width: 141px;"><nobr>是否采纳：</nobr></td>--%>
			<%--<td>--%>
				<%--<select name="adopt" id="adopt">--%>
				<%--</select>--%>
			<%--</td>--%>
		<%--</tr>--%>
	<%--</table>--%>
</form>
</body>
</html>