<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.db.DbUtils" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	String id=DbUtils.getSequenceStr();
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String oataskmanid = StringHelper.showNull2Empty(request.getParameter("oataskmanid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>工作任务管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<style type="text/css">

 </style>

<script type="text/javascript">
    var form; // form表单（查询条件）
    var layer; // 弹出层
    var laydate
	$(function() {
        layui.use(['form', 'layer', 'laydate'], function () {
            form = layui.form;
            layer = layui.layer;
            laydate = layui.laydate;
            laydate.render({
                elem: '#endtime',
                type:'datetime'
            });

            form.render();
            var url = basePath + '/work/task/bnwcoatsakman';
            form.on('submit(save)', function (data) {
                var formData = data.field;
                $.post(url, formData, function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg('保存成功', {time: 1000}, function () {
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
        });

	});

    var submitForm = function () {
        $("#saveTaskBtn").click();
    };

    function closeWindow(){
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    }


</script>
</head>
<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" action="">
			<div class="layui-form-item">
				<div class="layui-input-inline">
					<input type="hidden" id="oataskmanid" name="oataskmanid"  style="width: 300px" value="<%=oataskmanid%>"
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>不能完成原因:</label>
				<div height="100px" class="layui-input-inline" style="width: 350px">
					<textarea class="layui-textarea" id="cannotreason" name="cannotreason" cols="20" lay-verify="required"
							  rows="3"></textarea>
				</div>
			</div>

			<div class="layui-form-item" style="display: none">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="save"
							id="saveTaskBtn">保存</button>
				</div>
			</div>
		</form>
	</div>
</div>
	
</body>
</html>