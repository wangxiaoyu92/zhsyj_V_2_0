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
    String animaldeathid = StringHelper.showNull2Empty(request.getParameter("animaldeathid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>动物死亡信息管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        var index;
        var form;
        var layer;
        var laydate;
        //死亡原因
        var deathreason = <%=SysmanageUtil.getAa10toJsonArray("DEATHREASON")%>;
        //处理方法
        var treatmentmode = <%=SysmanageUtil.getAa10toJsonArray("TREATMENTMODE")%>;
        $(function () {
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#deathdate',
                    type:'datetime'
                });
                var lock=true;
                form.on('submit(saveNews)', function (data) {
                    var formData=data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + '/animal/saveAnimaldeath', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock=true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });


            });
            intSelectData('deathreason', deathreason);
            intSelectData('treatmentmode', treatmentmode);
            var id = $("#animaldeathid").val();
            if (id != "" && id != null) {
                $.ajax({
                    type:'POST',
                    url:basePath + '/animal/queryAnimaldeathDTO',
                    dataType:'json',
                    data:{animaldeathid:$('#animaldeathid').val()},
                    async:false,
                    success:function(result){
                        var mydata = result.data;
                        $('form').form('load', mydata);
                        $("#animalno").val(mydata.animalinfono);
                        form.render();
                    }
                });
                if ('<%=op%>' == 'view') {
                    $('form:input').addClass('input_readonly');
                    $('form:input').attr('readonly', 'readonly');
                    $('input').attr('disabled', 'true');
                }
            }



        });


        // 保存
        function saveFun() {
            $("#saveNewsBtn").click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        function myselectanimal() {
            sy.modalDialog({
                title: '选择动物信息'
                , area: ['1000px', '470px']
                , content: '<%=basePath%>jsp/pub/pub/selectanimal.jsp'
                , btn: ['确定'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return;
                }
                if (obj.type == 'ok') {
                    var myrow = obj.data;
                    $("#animalno").val(myrow.animalno); //动物编号
                    $("#animalinfoid").val(myrow.animalinfoid); //动物id
                }
            });
        }


        function clearNoNum(obj)
        {
            //先把非数字的都替换掉，除了数字和.
            obj.value = obj.value.replace(/[^\d.]/g,"");
            //保证只有出现一个.而没有多个.
            obj.value = obj.value.replace(/\.{2,}/g,".");
            //必须保证第一个为数字而不是.
            obj.value = obj.value.replace(/^\./g,"");
            //保证.只出现一次，而不能出现两次以上
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            //只能输入两个小数
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');
        }


	</script>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="animaldeathid" name="animaldeathid" type="hidden" value="<%=animaldeathid%>"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>动物信息:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="animalno" name="animalno"
                           autocomplete="off" class="layui-input" lay-verify="required">
                    <input  id="animalinfoid" name="animalinfoid"
                            type="hidden">
                </div>
                <% if (!"view".equalsIgnoreCase(op)) {%>
                <div class="layui-input-inline" id="btnselectcom" style="width: 100px;">
                    <a href="javascript:void(0)" class="layui-btn"
                       iconCls="icon-search" onclick="myselectanimal()">选择动物 </a>
                </div>
                <%} %>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">死亡原因:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="deathreason" id="deathreason" autocomplete="off" >
                    </select>
                </div>

            </div>
            <div class="layui-form-item">

                <label class="layui-form-label" style="width: 90px">处理方法:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="treatmentmode" id="treatmentmode" autocomplete="off" >
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>死亡时间:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="deathdate" name="deathdate"
                           autocomplete="off" class="layui-input" lay-verify="required">
                </div>
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>死亡体重:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="deathweight" name="deathweight"
                           autocomplete="off" class="layui-input" onkeyup="clearNoNum(this)" onblur="clearNoNum(this)" lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">症状及用药描述:</label>
                <div class="layui-input-inline" style="width: 650px">
                    <textarea placeholder="请输入内容" class="layui-textarea" id="symptom" name="symptom"></textarea>
                </div>
            </div>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="saveNews"
                            id="saveNewsBtn">保存
                    </button>
                </div>
            </div>
        </form>
    </div>

</div>

</body>
</html>