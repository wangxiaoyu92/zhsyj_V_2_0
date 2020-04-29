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
	String jcgzhbid = StringHelper.showNull2Empty(request.getParameter("jcgzhbid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>稽查工作汇报</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<style type="text/css">

 </style>

<script type="text/javascript">
    var form; // form表单（查询条件）
    var layer; // 弹出层
	$(function() {
        layui.use(['form', 'layer'], function () {
            form = layui.form;
            layer = layui.layer;
            var url = basePath + '/jcgzhb/saveJcgzhb';
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
       if ($('#jcgzhbid').val().length > 0) {
            $.post(basePath + '/jcgzhb/queryJcgzhbDTO', {
                        jcgzhbid: $('#jcgzhbid').val()
                },
                function (result) {
                    if (result.code == '0') {
                        var mydata = result.data;
                        $('#fm').form('load', mydata);
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
           }
        }else{
           $.post(basePath + '/jcgzhb/queryJcgzhbZuiJing', {
                   },
                   function (result) {
                       if (result.code == '0') {
                           var mydata = result.data;
                           var jcgzhb = result.jcgzhb;
                           if(jcgzhb=='old'){
                               var mydata = result.data;
                               $('#lalj').val(mydata.lalj);
                               $('#jalj').val(mydata.jalj);
                               $('#yssflj').val(mydata.yssflj);
                               $('#zxfklj').val(mydata.zxfklj);
                               $('#ajxxgslj').val(mydata.ajxxgslj);
                               $('#cyjjlj').val(mydata.cyjjlj);
                               $('#cjxxgslj').val(mydata.cjxxgslj);
                               $('#bdwsltsjblj').val(mydata.bdwsltsjblj);
                               $('#sjjbtsjblj').val(mydata.sjjbtsjblj);
                               $('#sjjbwthcczlj').val(mydata.sjjbwthcczlj);
                               $('#xcbllj').val(mydata.xcbllj);
                               $('#lj1').val(mydata.lalj);
                               $('#lj2').val(mydata.jalj);
                               $('#lj3').val(mydata.yssflj);
                               $('#lj4').val(mydata.zxfklj);
                               $('#lj5').val(mydata.ajxxgslj);
                               $('#lj6').val(mydata.cyjjlj);
                               $('#lj7').val(mydata.cjxxgslj);
                               $('#lj8').val(mydata.bdwsltsjblj);
                               $('#lj9').val(mydata.sjjbtsjblj);
                               $('#lj10').val(mydata.sjjbwthcczlj);
                               $('#lj11').val(mydata.xcbllj);
                           }else{
                               $('#lalj').val(0);
                               $('#jalj').val(0);
                               $('#yssflj').val(0);
                               $('#zxfklj').val(0);
                               $('#ajxxgslj').val(0);
                               $('#cyjjlj').val(0);
                               $('#cjxxgslj').val(0);
                               $('#bdwsltsjblj').val(0);
                               $('#sjjbtsjblj').val(0);
                               $('#sjjbwthcczlj').val(0);
                               $('#xcbllj').val(0);
                               $('#lj1').val(0);
                               $('#lj2').val(0);
                               $('#lj3').val(0);
                               $('#lj4').val(0);
                               $('#lj5').val(0);
                               $('#lj6').val(0);
                               $('#lj7').val(0);
                               $('#lj8').val(0);
                               $('#lj9').val(0);
                               $('#lj10').val(0);
                               $('#lj11').val(0);
                           }
                       }
                   }, 'json');
       }
	});

    var submitForm = function () {
        $("#saveTaskBtn").click();
    };


    function closeWindow(){
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    }

    function changeValue1(){
        if ('<%=op%>' == 'add') {
            var a = parseInt($('#lj1').val());
            var b = parseInt($('#laby').val());
            $('#lalj').val(a + b);
        }
    }
    function changeValue2(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj2').val());
        var b= parseInt($('#jaby').val());
        $('#jalj').val(a+b);
        }
    }
    function changeValue3(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj3').val());
        var b= parseInt($('#yssfby').val());
        $('#yssflj').val(a+b);
        }
    }
    function changeValue4(){
        if ('<%=op%>' == 'add') {
        var a=  parseFloat($('#lj4').val());
        var b= parseFloat($('#zxfkby').val());
        $('#zxfklj').val((a+b).toFixed(2));
        }
    }
    function changeValue5(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj5').val());
        var b= parseInt($('#ajxxgsby').val());
        $('#ajxxgslj').val(a+b);
        }
    }
    function changeValue6(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj6').val());
        var b= parseInt($('#cyjjby').val());
        $('#cyjjlj').val(a+b);
        }
    }
    function changeValue7(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj7').val());
        var b= parseInt($('#cjxxgsby').val());
        $('#cjxxgslj').val(a+b);
        }
    }
    function changeValue8(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj8').val());
        var b= parseInt($('#bdwsltsjbby').val());
        $('#bdwsltsjblj').val(a+b);
        }
    }
    function changeValue9(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj9').val());
        var b= parseInt($('#sjjbtsjbby').val());
        $('#sjjbtsjblj').val(a+b);
        }
    }
    function changeValue10(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj10').val());
        var b= parseInt($('#sjjbwthcczby').val());
        $('#sjjbwthcczlj').val(a+b);
        }
    }
    function changeValue11(){
        if ('<%=op%>' == 'add') {
        var a=  parseInt($('#lj11').val());
        var b= parseInt($('#xcblby').val());
        $('#xcbllj').val(a+b);
        }
    }
</script>
</head>
<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" action="">

					<input type="HIDDEN" id="jcgzhbid" name="jcgzhbid" readonly style="width: 300px" value="<%=jcgzhbid%>"
						   class="layui-input layui-bg-gray">

			<div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">立案:</label>
                <div class="layui-input-inline" style="width: 800px;">
				<label class="layui-form-label" style="width: 30px">本月:</label>
				<div class="layui-input-inline" style="width: 150px;">
					<input type="text" name="laby" id="laby" onchange="changeValue1();"
						   autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
				</div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj1">
                        <input type="text" name="lalj" id="lalj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    </div>
			</div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">结案:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="jaby" id="jaby" onchange="changeValue2();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj2">
                        <input type="text" name="jalj" id="jalj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">移送司法:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="yssfby" id="yssfby" onchange="changeValue3();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj3">
                        <input type="text" name="yssflj" id="yssflj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">执行罚款(元）:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="zxfkby" id="zxfkby" onchange="changeValue4();"
                               autocomplete="off" class="layui-input" onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj4">
                        <input type="text" name="zxfklj" id="zxfklj"
                               autocomplete="off" class="layui-input" onkeyup="this.value=this.value.replace(/[^0-9\.]/g,'')">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">案件信息
                    公示:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">任务:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="ajxxgsrw" id="ajxxgsrw"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="ajxxgsby" id="ajxxgsby" onchange="changeValue5();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj5">
                        <input type="text" name="ajxxgslj" id="ajxxgslj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">抽样检验:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">任务:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="cyjjrw" id="cyjjrw"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="cyjjby" id="cyjjby" onchange="changeValue6();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <input type="HIDDEN" id="lj6">
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="cyjjlj" id="cyjjlj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">抽检信息公示:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">任务:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="cjxxgsrw" id="cjxxgsrw"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="cjxxgsby" id="cjxxgsby" onchange="changeValue7();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj7">
                        <input type="text" name="cjxxgslj" id="cjxxgslj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">本单位受理投诉举报:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="bdwsltsjbby" id="bdwsltsjbby" onchange="changeValue8();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj8">
                        <input type="text" name="bdwsltsjblj" id="bdwsltsjblj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">省局交办投诉举报:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="sjjbtsjbby" id="sjjbtsjbby" onchange="changeValue9();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj9">
                        <input type="text" name="sjjbtsjblj" id="sjjbtsjblj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">省局交办问题核查处置:</label>
                <div class="layui-input-inline" style="width: 800px;">
                    <label class="layui-form-label" style="width: 30px">任务:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="sjjbwthcczrw" id="sjjbwthcczrw"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="sjjbwthcczby" id="sjjbwthcczby" onchange="changeValue10();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj10">
                        <input type="text" name="sjjbwthcczlj" id="sjjbwthcczlj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 130px">协查办理:</label>
                <div class="layui-input-inline" style="width: 700px;">
                    <label class="layui-form-label" style="width: 30px">任务:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="xcblrw" id="xcblrw"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">本月:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="text" name="xcblby" id="xcblby" onchange="changeValue11();"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
                    <label class="layui-form-label" style="width: 30px">累计:</label>
                    <div class="layui-input-inline" style="width: 150px;">
                        <input type="HIDDEN" id="lj11">
                        <input type="text" name="xcbllj" id="xcbllj"
                               autocomplete="off" class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^0-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    </div>
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