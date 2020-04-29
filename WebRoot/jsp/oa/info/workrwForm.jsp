<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.db.DbUtils" %>
<%
	String contextPath = request.getContextPath();
	String id=DbUtils.getSequenceStr();
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
                    elem: '#endtime',
                    type:'datetime'
                });
                var url = basePath + '/work/task/addOatask';
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 500}, function () {
                                var ywbh='<%=id%>';
                                var comdm="11";
                                var commc="工作任务";
                                var yewumcpym="ayrw";
                                var transval="";
                                var yewutablename="egarchiveinfo";
                                var yewucolname="archiveid";
                                var fzruserid=$("#fzr").val();
                                var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfgongwenprocess?"+
                                    "ywbh="+ywbh+
                                    "&comdm="+comdm+
                                    "&commc="+commc+
                                    "&yewumcpym="+yewumcpym+
                                    "&transval="+transval+
                                    "&yewutablename="+yewutablename+
                                    "&fzruserid="+fzruserid+
                                    "&yewucolname="+yewucolname+
                                    "&time="+new Date().getMilliseconds()));
                                $.post(v_url, {
                                    },
                                    function (result) {
                                        if (result.code == '0') {
                                            /*layer.msg('受理成功！', {time: 1000
                                            }, function () {
                                                parent.layer.close(parent.layer.getFrameIndex(window.name));
                                            });*/
                                            layer.msg('保存成功,任务已经分派！', {time: 1000}, function () {
                                                var obj = new Object();
                                                obj.type = "ok";
                                                sy.setWinRet(obj);
                                                var  orgname=$("#orgname").val();
                                                sy.setWinRet(orgname);

                                                closeWindow();

                                            });
                                        } else {
                                            layer.open({
                                                title: "提示",
                                                content: "受理失败：" + result.msg //这里content是一个普通的String
                                            });
                                        }
                                    },
                                    'json');

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
                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#xzks').css('display', 'none');
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
                , area: ['900px', '270px']
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

        function showMenu_aaa027new() {
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                ,
                area: ['300px', '100%']
                ,
                title: '选择科室'
                ,

                content: basePath + 'jsp/pub/pub/selectgworg.jsp'
                ,
                shade: [0.8, 'gray'] // 遮罩
                ,
                btn: ['确定', '退出']
                ,
                yes: function (index) {
                    //当点击‘确定’按钮的时候，获取弹出层返回的值
                    var v_retObj = window["layui-layer-iframe" + index].myqueding();
                    //打印返回的值，看是否有我们想返回的值。
                    if (v_retObj != null) {
                        $("#orgid").val(v_retObj.orgid);
                        $("#orgname").val(v_retObj.orgname);
                        $("#zxrUserid").val(v_retObj.fz);
                    }
                    //最后关闭弹出层
                    layer.close(index);
                },
                cancel: function () {
                    //右上角关闭回调
                }
            });
        }

        function uploadFjViewqt(type) {
                var fjwid='<%=id%>';

            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传其它附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: fjwid,
                    fjtype: type
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    /*$("#ceshi").html(myrow.fjpath);*/ //人员id
                    var html = $("#ceshinew").html();
                    html += "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
                    $("#ceshinew").html(html);
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }
	</script>
</head>
<body>
<form id="sysUserForm" class="layui-form" action="">
	<input type="hidden" id="userid" name="userid"  style="width: 300px" value="<%=id%>"
		   class="layui-input layui-bg-gray">
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>工作任务内容:</label>
		<div class="layui-input-block">
            <textarea style="width: 600px" id="taskcontent" name="taskcontent" class="layui-textarea" required
					  lay-verify="required"></textarea>
		</div>
	</div>



	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>指定科室:</label>


		<div class="layui-input-inline">
			<input name="orgname" id="orgname" onclick="showMenu_aaa027new();"
				   readonly="readonly" class="layui-input layui-bg-gray" lay-verify="required" style="width: 600px"/>
			<input name="orgid" id="orgid" type="hidden"/>
			<input id="zxrUserid" name="zxrUserid" type="hidden"/>
		</div>
		<div id="menuContent_aaa027new" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
			<div class="layui-side-scroll" style="width:250px;">
				<ul id="treeDemo_aaa027new" class="ztree"></ul>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><font class="myred">*</font>截止时间:</label>

		<div  class="layui-input-inline" >
			<input type="text" id="endtime" name="endtime"
				   autocomplete="off" class="layui-input" lay-verify="required">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px">附件:</label>

		<div class="layui-input-inline" style="width: 250px">
			<div id="b">
				<a id="btnselectcomnew" href="javascript:void(0)"
				   class="layui-btn" iconCls="icon-upload"
				   onclick="uploadFjViewqt('GWQTFJ')">上传附件</a><br/>
			</div>
			<span id="ceshinew"></span>
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