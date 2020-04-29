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
	String workTaskId = StringHelper.showNull2Empty(request.getParameter("workTaskId"));
	String workSchedulePercent = StringHelper.showNull2Empty(request.getParameter("workSchedulePercent"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>工作进度管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<style type="text/css">

 </style>

<script type="text/javascript">
    var form; // form表单（查询条件）
    var layer; // 弹出层
    var laydate;
	var element; //Tab的切换功能，切换事件监听等，需要依赖element模块
    element = layui.element;
    var a;
	$(function() {
        layui.use(['form', 'layer', 'laydate','element'], function () {
            form = layui.form;
            layer = layui.layer;
            laydate = layui.laydate;
            element = layui.element;
            form.render();
            var url = basePath + '/work/task/saveSchedule?op='+'<%=op%>';
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

            if ($('#workTaskId').val().length > 0) {
                $.post(basePath + '/work/task/queryWorkTask', {
                        workTaskId: $('#workTaskId').val()
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            $('#fm').form('load', mydata);
                            $('#comrcjdglry').val(mydata.orgid);
                            $('#comrcjdglrynew').val(mydata.orgname);
                        } else {
                            layer.open({
                                title: "提示",
                                content: "查询失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
                $.post(basePath + '/work/task/queryWorkSchedule', {
                        workTaskId: $('#workTaskId').val()
                    },

                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            /*$(":radio[name=workScheduleConfirm][value="+mydata.workScheduleConfirm+"]").attr("checked","true");*/
                            $('#form').form('load', mydata);
                            a=mydata.workScheduleConfirm;
                            form.render();
                        } else {
                            layer.open({
                                title: "提示",
                                content: "查询失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
                if ('<%=op%>' == 'view') {
                    $('#a').css('display', 'none');

                }
            }
        });


        var w_width = $('#aa').width();//拿到容器宽度，即为进度条总长度
        $('#aa').click(function(e){ //点击进度条
            var x=e.offsetX;
            per =   Math.round(x/w_width*100); //得到百分比
            element.progress('demo', per+'%');
            document.getElementById('workSchedulePercent').value=per;
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
				<label class="layui-form-label"><font class="myred">*</font>排序号:</label>
				<div class="layui-input-inline" style="width: 200px;">
					<input type="text" name="workTaskNo" id="workTaskNo"  lay-verify="required"
						   autocomplete="off" class="layui-input" readonly="readonly" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				</div>
				<label class="layui-form-label">工作权重:</label>
				<div class="layui-input-inline" style="width: 200px;">
					<input type="text" name="workTaskWeight" id="workTaskWeight"  lay-verify="required"
						   autocomplete="off" class="layui-input" readonly="readonly" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作任务:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="workTaskContent" name="workTaskContent" cols="20" lay-verify="required"
							  rows="3" readonly="readonly"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作措施:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="workTaskStep" name="workTaskStep" cols="20" lay-verify="required"
							  rows="3" readonly="readonly"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">开始时间:</label>

				<div  class="layui-input-inline" >
					<input type="text" id="workTaskStDate" name="workTaskStDate" lay-verify="required"
						   autocomplete="off" class="layui-input" readonly="readonly">
				</div>
				<label class="layui-form-label">结束时间:</label>

				<div  class="layui-input-inline" >
					<input type="text" id="workTaskEdDate" name="workTaskEdDate" lay-verify="required"
						   autocomplete="off" class="layui-input" readonly="readonly">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">负责人:</label>
				<div class="layui-input-inline">
					<input type="text" id="comrcjdglry" name="comrcjdglry"
						   autocomplete="off" class="layui-input" readonly="readonly">
					<input type="hidden" id="workTaskDutyPerson" name="workTaskDutyPerson">

				</div>


			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">负责领导:</label>
				<div class="layui-input-inline">
					<input type="text" id="comrcjdglrynew" name="comrcjdglrynew"
						   autocomplete="off" class="layui-input" readonly="readonly">
					<input type="hidden" id="workTaskDutyLeader" name="workTaskDutyLeader">

				</div>


			</div>

		</form>
		<form id="form" class="layui-form" action="">
			<div class="layui-form-item">
				<div class="layui-input-inline">
					<input type="hidden" id="workTaskId" name="workTaskId" readonly style="width: 300px" value="<%=workTaskId%>"
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作进度ID:</label>
				<div class="layui-input-inline">
					<input type="text" id="workScheduleId" name="workScheduleId" readonly style="width: 300px"
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作进度描述:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="workScheduleDescribe" name="workScheduleDescribe" cols="20" lay-verify="required"
							  rows="3"></textarea>
				</div>
			</div>
			<div class="layui-form-item">

				<div class="layui-input-inline">
					<input type="hidden" id="workSchedulePercent" name="workSchedulePercent"
						   autocomplete="off" class="layui-input" >
				</div>
			</div>
			<div class="layui-form-item" style="padding: 1px">
				<label class="layui-form-label">工作进度百分比:</label>
			<div class="layui-progress layui-progress-big" id="aa" lay-showpercent="true" lay-filter="demo" style="margin-top: 20px;margin-left: 100px; width:500px">
				<div class="layui-progress-bar layui-bg-red"  lay-percent="<%=workSchedulePercent%>%"></div>
				<div id="bb"></div>
			</div>
			</div>
			<div class="layui-form-item" id="a" pane="">
				<label class="layui-form-label">审批:</label>
				<div class="layui-input-block">
					<input type="radio"  name="workScheduleConfirm" value="1" title="通过" checked="">
					<input type="radio"  name="workScheduleConfirm" value="0" title="驳回">
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