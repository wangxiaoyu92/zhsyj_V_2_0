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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>工作台账管理</title>
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
            var start = {
                elem: '#workTaskStDate',
                type:'datetime',
                show: true,
                closeStop: '#workTaskStDate'

            };
            var end = {
                elem: '#workTaskEdDate',
                type:'datetime',
                show: true,
                closeStop: '#workTaskEdDate'
            };
            lay('#workTaskStDate').on('click', function(e){
                if($('#workTaskEdDate').val() != null && $('#workTaskEdDate').val() != undefined && $('#workTaskEdDate').val() != ''){
                    start.max = $('#workTaskEdDate').val();
                }
                laydate.render(start);
            });
            lay('#workTaskEdDate').on('click', function(e){
                if($('#workTaskStDate').val() != null && $('#workTaskStDate').val() != undefined && $('#workTaskStDate').val() != ''){
                    end.min = $('#workTaskStDate').val();
                }
                laydate.render(end);
            });
            form.render();
            if ('<%=op%>' == 'add') {
                $('#workTaskWeight').val(1);
            }
            var url = basePath + '/work/task/saveTask';
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
                        form.render();
                    } else {
                        layer.open({
                            title: "提示",
                            content: "查询失败：" + result.msg //这里content是一个普通的String
                        });
                    }
                }, 'json');

           if ('<%=op%>' == 'view') {
               $('form :input').addClass('input_readonly');
               $('form :input').attr('readonly', 'readonly');
               $('#workTaskStDate').attr('disabled', 'disabled');
               $('#workTaskEdDate').attr('disabled', 'disabled');
               $('#a').css('display', 'none');
               $('#b').css('display', 'none');
           }
        }
	});

    var submitForm = function () {
        $("#saveTaskBtn").click();
    };
    function myselectAjdjXgry_layui(prm_rykind){
        var v_useridstr=$("#workTaskDutyPerson").val();
        var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr="+v_useridstr+"&a="+new Date().getMilliseconds();
        var v_comrcjdglryid="";
        var v_comrcjdglryname="";
        sy.modalDialog({
            title:'选择人员'
            ,area : ['1050px','500px']
            ,content:url
            ,btn:['保存']
            ,btn1: function(index, layero){
                window[layero.find('iframe')[0]['name']].queding();
            }
        },function (dialogID) {
            var v_retStr = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);//不可缺少

            if (v_retStr!=null && v_retStr.length>0){
                for (var k=0;k<=v_retStr.length-1;k++){
                    var myrow = v_retStr[k];
                    if (""==v_comrcjdglryid){
                        v_comrcjdglryid=myrow.userid;
                        v_comrcjdglryname=myrow.description;
                    }else{
                        v_comrcjdglryid=v_comrcjdglryid+","+myrow.userid;
                        v_comrcjdglryname=v_comrcjdglryname+","+myrow.description;
                    }
                }
                $("#comrcjdglry").val(v_comrcjdglryname);
                $("#workTaskDutyPerson").val(v_comrcjdglryid);
            };
        });
    };

    function myselectAjdjXgry_layuinew(prm_rykind){
        var v_useridstr=$("#workTaskDutyLeader").val();
        var url = "<%=basePath%>jsp/pub/pub/selectuserMoregw.jsp?useridstr="+v_useridstr+"&a="+new Date().getMilliseconds();
        var v_comrcjdglryid="";
        var v_comrcjdglryname="";
        sy.modalDialog({
            title:'选择人员'
            ,area : ['1050px','500px']
            ,content:url
            ,btn:['保存']
            ,btn1: function(index, layero){
                window[layero.find('iframe')[0]['name']].queding();
            }
        },function (dialogID) {
            var v_retStr = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);//不可缺少

            if (v_retStr!=null && v_retStr.length>0){
                for (var k=0;k<=v_retStr.length-1;k++){
                    var myrow = v_retStr[k];
                    if (""==v_comrcjdglryid){
                        v_comrcjdglryid=myrow.userid;
                        v_comrcjdglryname=myrow.description;
                    }else{
                        v_comrcjdglryid=v_comrcjdglryid+","+myrow.userid;
                        v_comrcjdglryname=v_comrcjdglryname+","+myrow.description;
                    }
                }
                $("#comrcjdglrynew").val(v_comrcjdglryname);
                $("#workTaskDutyLeader").val(v_comrcjdglryid);
            };
        });
    };


    function myclearRcjdgly(){
        $("#comrcjdglry").val('');
        $("#workTaskDutyPerson").val('');
    }

    function myclearRcjdglynew(){
        $("#comrcjdglrynew").val('');
        $("#workTaskDutyLeader").val('');
    }

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
				<label class="layui-form-label">工作台账ID:</label>
				<div class="layui-input-inline">
					<input type="text" id="workTaskId" name="workTaskId" readonly style="width: 300px" value="<%=workTaskId%>"
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>排序号:</label>
				<div class="layui-input-inline" style="width: 200px;">
					<input type="text" name="workTaskNo" id="workTaskNo"  lay-verify="required"
						   autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				</div>
				<label class="layui-form-label">工作权重:</label>
				<div class="layui-input-inline" style="width: 200px;">
					<input type="text" name="workTaskWeight" id="workTaskWeight"  lay-verify="required"
						   autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作任务:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="workTaskContent" name="workTaskContent" cols="20" lay-verify="required"
							  rows="3"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">工作措施:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="workTaskStep" name="workTaskStep" cols="20" lay-verify="required"
							  rows="3"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">完成时限:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="wcsx" name="wcsx" cols="20" lay-verify="required"
							  rows="3"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">开始时间:</label>

				<div  class="layui-input-inline" >
					<input type="text" id="workTaskStDate" name="workTaskStDate"
						   autocomplete="off" class="layui-input">
				</div>
				<label class="layui-form-label">结束时间:</label>

				<div  class="layui-input-inline" >
					<input type="text" id="workTaskEdDate" name="workTaskEdDate"
						   autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">负责人:</label>
				<div class="layui-input-inline">
					<input type="text" id="comrcjdglry" name="comrcjdglry"
						   autocomplete="off" class="layui-input" readonly="readonly">
					<input type="hidden" id="workTaskDutyPerson" name="workTaskDutyPerson">

				</div>
				<div class="layui-input-inline" id="a">
					<a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
					   iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" class="layui-btn" id="remove"
					   iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
				</div>

			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">负责领导:</label>
				<div class="layui-input-inline">
					<input type="text" id="comrcjdglrynew" name="comrcjdglrynew"
						   autocomplete="off" class="layui-input" readonly="readonly">
					<input type="hidden" id="workTaskDutyLeader" name="workTaskDutyLeader">

				</div>
				<div class="layui-input-inline" id="b">
					<a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglrynew"
					   iconCls="icon-search" onclick="myselectAjdjXgry_layuinew(1)">选择人员 </a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" class="layui-btn" id="removenew"
					   iconCls="icon-no" onclick="myclearRcjdglynew()">清除 </a>
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