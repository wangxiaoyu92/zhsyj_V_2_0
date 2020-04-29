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
	String v_infoid = StringHelper.showNull2Empty(request.getParameter("infoid"));
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
        $(function() {
            fj();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/work/task/saveInfo';
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
                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('#xzks').css('display', 'none');
                        $('#btnselectcom').css('display', 'none');
                    }
                }
			})
            intSelectData("adopt", v_adopt);
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
        function uploadFjView(type) {
            var id = "";
            var url = basePath + "jsp/pub/egovernment/uploadViewWarenew.jsp";
            if ('<%=op%>' == 'add') {
                id='<%=id%>';
            }else{
               id='<%=v_infoid%>';
            }
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: id,
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
                    var html = $("#ceshi").html();
                    html = "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
                    $("#ceshi").html(html);
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }
        function fj() {
            var html = "";
            var id = "";
            if ('<%=op%>' == 'add') {
                id='<%=id%>';
            }else{
                id='<%=v_infoid%>';
            }
            $.ajax({
                type: 'POST',
                url: basePath + '/workflow/FJ',
                dataType: 'json',
                data: {fjwid:id, fjtype:'66'},
                async: false,
                success: function (result) {
                    var mydata = result.data;
                    var orgname=result.orgname;
                    var orgid=result.orgid;
                    $("#orgname").val(orgname);
                    $("#orgid").val(orgid);
                    for (var i = 0; i < mydata.length; i++) {
                        var a = mydata[i].fjname;
                        var b = mydata[i].fjpath;
                        html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

                    }
                }
            });
            $("#ceshi").html(html);
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
	<input id="infoid" name="infoid" type="hidden" value="<%=v_infoid%>"/>
	<input id="id" name="id" type="hidden" value="<%=id%>"/>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>信息内容:</label>
		<div class="layui-input-block">
            <textarea style="width: 600px" id="content" name="content" class="layui-textarea" required
					  lay-verify="required"></textarea>
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px">是否采纳:</label>

		<div class="layui-input-inline">
			<select name="adopt" id="adopt" autocomplete="off" disabled="disabled" lay-verify="required">
			</select>
		</div>

		<label class="layui-form-label"><span style="color: red;">*</span>科室名称:</label>

		<div class="layui-input-inline">
			<input type="text" id="orgname" name="orgname" readonly
				   autocomplete="off" class="layui-input">
			<input id="orgid" name="orgid" type="hidden">
		</div>
		<div class="layui-input-inline" style="width: 110px">
			<a href="javascript:void(0)" id="xzks" class="layui-btn"
			   iconCls="icon-search" onclick="myselectcom()">选择科室 </a>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px">信息附件:</label>
		<div class="layui-input-inline" style="width: 250px">
			<span class="font_main" style="padding-top: 50px"></span>
			<a id="btnselectcom" href="javascript:void(0)"
			   class="layui-btn" iconCls="icon-upload"
			   onclick="uploadFjView('66')">上传信息附件</a><br/>
			<span id="ceshi"></span>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 100px">采纳链接:</label>
		<div class="layui-input-inline">
			<input type="text" id="linkaddress" name="linkaddress"
				   autocomplete="off" class="layui-input">
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