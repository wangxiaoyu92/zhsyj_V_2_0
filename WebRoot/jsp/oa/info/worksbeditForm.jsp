<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.db.DbUtils" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String worksbid = StringHelper.showNull2Empty(request.getParameter("worksbid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>公文管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style type="text/css">
		body{
			overflow: scroll;
		}
	</style>

	<script type="text/javascript">
        // 是否采纳
        var v_adopt = [{"id":"1","text":"否"},{"id":"2","text":"是"}];
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function() {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                var myDate = new Date();
                laydate.render({
                    elem: '#time',
                    type:'datetime'
                });
                var url = basePath + '/work/task/saveSb';
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
                var v_id = $("#worksbid").val();
                if (v_id != null && v_id.length > 0) {
                    $.post(basePath + '/work/task/queryWDTO', {
                            worksbid: v_id
                        },
                        function (result) {
                            if (result.code == '0') {
                                $('#sysUserForm').form('load', result.data);
                                form.render();
                            }
                        }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                    }
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

        function check(s) {
            window.open(s);

        }

        function myselectAjdjXgry_layui(prm_rykind) {
            var v_useridstr = $("#workTaskDutyPerson").val();
            var url = "<%=basePath%>jsp/pub/pub/selectuserMoregw.jsp?useridstr=" + v_useridstr + "&a=" + new Date().getMilliseconds();
            var v_comrcjdglryid = "";
            var v_comrcjdglryname = "";
            sy.modalDialog({
                title: '选择人员'
                , area: ['1000px', '450px']
                , content: url
                , btn: ['保存']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        if ("" == v_comrcjdglryid) {
                            v_comrcjdglryid = myrow.userid;
                            v_comrcjdglryname = myrow.description;
                        } else {
                            v_comrcjdglryid = v_comrcjdglryid + "," + myrow.userid;
                            v_comrcjdglryname = v_comrcjdglryname + "," + myrow.description;
                        }
                    }
                    $("#cyry").val(v_comrcjdglryname);
                    $("#fzr").val(v_comrcjdglryid);
                }
            });
        }
        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['900px', '470px']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: ""
                }
                , content: basePath + 'work/task/departmentIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if(obj==null||obj==''){
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#orgname").val(myrow.orgname); //科室名称
                    $("#orgid").val(myrow.orgid); //科室代码
                }
            });
        }
	</script>
</head>
<body>
<form id="sysUserForm" class="layui-form" action="">
	<input id="worksbid" name="worksbid" type="hidden" value="<%=worksbid%>"/>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>工作上报内容:</label>
		<div class="layui-input-block">
            <textarea style="width: 600px" id="content" name="content" class="layui-textarea" required
					  lay-verify="required"></textarea>
		</div>
	</div>



	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>向谁上报:</label>
		<div class="layui-input-inline">
			<input type="text" id="cyry" name="cyry"
				   autocomplete="off" class="layui-input" style="width: 300px;" readonly="readonly">
			<input id="fzr" name="fzr" type="hidden"/>
		</div>
		<div class="layui-input-inline" style="padding-left:80px">
			&nbsp;
			<a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
			   iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" class="layui-btn" id="remove"
			   iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
		</div>
	</div>
	<div class="layui-form-item">

		<label class="layui-form-label" style="width: 100px">上报时间:</label>

		<div class="layui-input-inline" >
			<input type="text" id="time" name="time"
				   autocomplete="off" class="layui-input">

		</div>
	</div>
	<div class="layui-form-item">

		<label class="layui-form-label" style="width: 100px">上报人:</label>

		<div class="layui-input-inline" >
			<input type="text" id="name" name="name"
				  readonly class="layui-input">

		</div>
	</div>
	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
			</button>
		</div>
	</div>





</form>
</body>
</html>