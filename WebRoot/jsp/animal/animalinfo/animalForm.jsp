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
    String animalinfoid = StringHelper.showNull2Empty(request.getParameter("animalinfoid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>动物信息管理</title>
	<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style type="text/css">
		body{
			overflow: scroll;
		}
	</style>
    <style type="text/css">
        /**treeselect*/
        .layui-form-select .layui-tree {
            display: none;
            position: absolute;
            left: 0;
            top: 42px;
            padding: 5px 0;
            z-index: 999;
            min-width: 100%;
            border: 1px solid #d2d2d2;
            max-height: 300px;
            overflow-y: auto;
            background-color: #fff;
            border-radius: 2px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .12);
            box-sizing: border-box;
        }

        .layui-form-selected .layui-tree {
            display: block;
        }
    </style>
	<script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
	<script type="text/javascript">
        var index;
        var form;
        var layer;
        var laydate;
        //毛发颜色
        var haircolor = <%=SysmanageUtil.getAa10toJsonArray("HAIRCOLOR")%>;
        //养殖类型
        var culturestyle = <%=SysmanageUtil.getAa10toJsonArray("CULTURESTYLE")%>;
        //设备类型
        var equipmenttype = <%=SysmanageUtil.getAa10toJsonArray("EQUIPMENTTYPE")%>;
        var animallod = '';
        $(function () {
            $('#animalno').blur(function () {
                var animalno = $('#animalno').val();
                if (animalno == null || animalno == '') {
                    return false;
                }
                if (animalno != animallod) {
                    checkUniqueness();
                }
            })
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#birthday',
                    type:'datetime'
                });
                laydate.render({
                    elem: '#weaningdate',
                    type:'datetime'
                });
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
                    $.post(basePath + '/animal/saveAnimalinfo', formData, function (result) {
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
            intSelectData('haircolor', haircolor);
            intSelectData('culturestyle', culturestyle);
            intSelectData('equipmenttype', equipmenttype);
            var id = $("#animalinfoid").val();
            if (id != "" && id != null) {
                $.ajax({
                    type:'POST',
                    url:basePath + '/animal/queryAnimalinfoDTO',
                    dataType:'json',
                    data:{animalinfoid:$('#animalinfoid').val()},
                    async:false,
                    success:function(result){
                        var mydata = result.data;
                        $('form').form('load', mydata);
                        $("#animalnoold").val(mydata.animalno);
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

        function myselectfather() {
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
                    $("#fatherno").val(myrow.animalno); //父编号
                    $("#fatherid").val(myrow.animalinfoid); //父id
                }
            });
        }

        function myselectfence() {
            sy.modalDialog({
                title: '选择栅栏信息'
                , area: ['1000px', '470px']
                , content: '<%=basePath%>jsp/pub/pub/selectfence.jsp'
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
                    $("#fencename").val(myrow.fencename); //父编号
                    $("#fenceid").val(myrow.animalfenceid); //父id
                }
            });
        }

        function myselectmother() {
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
                    $("#motherno").val(myrow.animalno); //父编号
                    $("#motherid").val(myrow.animalinfoid); //父id
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

        //验证编码唯一性
        function checkUniqueness() {
            animallod = $('#animalno').val();
            var animalno = $('#animalno').val();
            var animalnoold = $('#animalnoold').val();
            if(animalnoold==animalno){
                animalod = animalno;
                $('#animalno').val(animalno);
                $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
            }else {
                if (animalno != null && animalno != "") {
                    $.post(basePath + '/animal/queryAnimalinfoDTO', {
                            animalno: animalno
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                //存在
                                if (mydata != undefined) {
                                    layer.msg("编号重复请重新填写");
                                    $('#animalno').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编号唯一</font>");
                                } else {
                                    animalod = animalno;
                                    $('#animalno').val(animalno);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
                }
            }
        }

    </script>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="animalinfoid" name="animalinfoid" type="hidden" value="<%=animalinfoid%>"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>动物编号:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="animalno" name="animalno"
                           autocomplete="off" class="layui-input" lay-verify="required">
                    <input id="animalnoold" name="animalnoold" type="hidden"/>
                </div>
                <div class="layui-input-inline">
                    <font color="red" id="greentext">保证编号唯一</font>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>栅栏:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="fencename" name="fencename"
                           autocomplete="off" class="layui-input" lay-verify="required">
                    <input  id="fenceid" name="fenceid"
                            type="hidden">
                </div>
                <% if (!"view".equalsIgnoreCase(op)) {%>
                <div class="layui-input-inline" id="btnselectcom" style="width: 100px;">
                    <a href="javascript:void(0)" class="layui-btn"
                       iconCls="icon-search" onclick="myselectfence()">选择栅栏 </a>
                </div>
                <%} %>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>出生时间:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="birthday" name="birthday"
                           autocomplete="off" class="layui-input" lay-verify="required">

                </div>
                <label class="layui-form-label" style="width: 90px">识别码:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="identificationcode" name="identificationcode"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">动物性别:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="sex" id="sex" autocomplete="off">
                        <option value="1">公</option>
                        <option value="0">母</option>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 90px">毛发颜色:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="haircolor" id="haircolor" autocomplete="off" >
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">养殖类型:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="culturestyle" id="culturestyle" autocomplete="off" >
                    </select>
                </div>
                <label class="layui-form-label" style="width: 90px">设备类型:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <select name="equipmenttype" id="equipmenttype" autocomplete="off" >
                    </select>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">断奶日期:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="weaningdate" name="weaningdate"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">断奶体重:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="weaningweight" name="weaningweight"
                           autocomplete="off" class="layui-input" onkeyup="clearNoNum(this)" onblur="clearNoNum(this)">
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">死亡日期:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="deathdate" name="deathdate"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">死亡体重:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="deathweight" name="deathweight"
                           autocomplete="off" class="layui-input" onkeyup="clearNoNum(this)" onblur="clearNoNum(this)">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">父编号:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="fatherno" name="fatherno"
                           autocomplete="off" class="layui-input">
                    <input  id="fatherid" name="fatherid"
                           type="hidden">
                </div>
                <% if (!"view".equalsIgnoreCase(op)) {%>
                <div class="layui-input-inline" id="btnselectcom" style="width: 100px;">
                    <a href="javascript:void(0)" class="layui-btn"
                       iconCls="icon-search" onclick="myselectfather()">选择父编号 </a>
                </div>
                <%} %>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">母编号:</label>
                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="motherno" name="motherno"
                           autocomplete="off" class="layui-input">
                    <input  id="motherid" name="motherid"
                            type="hidden">
                </div>
                <% if (!"view".equalsIgnoreCase(op)) {%>
                <div class="layui-input-inline" id="btnselectcom" style="width: 100px;">
                    <a href="javascript:void(0)" class="layui-btn"
                       iconCls="icon-search" onclick="myselectmother()">选择母编号 </a>
                </div>
                <%} %>
            </div>
            <div class="layui-form-item">

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