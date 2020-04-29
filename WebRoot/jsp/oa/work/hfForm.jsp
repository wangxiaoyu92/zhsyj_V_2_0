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
	String oamatterdynamicid = StringHelper.showNull2Empty(request.getParameter("oamatterdynamicid"));
	String replycontent = StringHelper.showNull2Empty(request.getParameter("replycontent"));
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



        });
        $("#replycontent").val("<%=replycontent%>");
        fjqt();

	});

    var submitForm = function () {
        $("#saveTaskBtn").click();
    };




    function myclearRcjdgly(){
        $("#comrcjdglry").val('');
        $("#workTaskDutyPerson").val('');
    }


   function fjqt() {
        var html = "";

            var fjwid='<%=oamatterdynamicid%>';

        $.ajax({
            type: 'POST',
            url: basePath + '/workflow/FJ',
            dataType: 'json',
            data: {fjwid: fjwid,
                fjtype:'GWQTFJ'
            },
            async: false,
            success: function (result) {
                var mydata = result.data;
                for (var i = 0; i < mydata.length; i++) {
                    var a = mydata[i].fjname;
                    var b = mydata[i].fjpath;
                    html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

                }
            }
        });
        $("#ceshinew").html(html);
    }

    function closeWindow(){
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    }

    function check(s) {
        window.open(s);

    }
</script>
</head>
<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" action="">
			<div class="layui-form-item">
				<div class="layui-input-inline">
					<input type="hidden" id="oamatterdynamicid" name="oamatterdynamicid"  style="width: 300px" value="<%=oamatterdynamicid%>"
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>回复内容:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="replycontent" name="replycontent" cols="20" lay-verify="required"
							  rows="3" value="<%=replycontent%>"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" >附件:</label>

				<div class="layui-input-inline" style="width: 250px">
					<span id="ceshinew"></span>
				</div>
			</div>


		</form>
	</div>
</div>
	
</body>
</html>