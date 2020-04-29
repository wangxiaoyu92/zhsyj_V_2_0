<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%><%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String id = StringHelper.showNull2Empty(request.getParameter("id"));
	String v_cxrecord = StringHelper.showNull2Empty(request.getParameter("cxrecord"));
	String v_ryid = StringHelper.showNull2Empty(request.getParameter("ryid"));
	String v_ryxm = StringHelper.showNull2Empty(request.getParameter("ryxm"));
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>人员诚信信用</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
		var cxrecord=<%=v_cxrecord%>;
        var v_discredtype = [{"id":"","text":""},{"id":"1","text":"诚信行为记录"},{"id":"2","text":"失信行为记录"}];
        var form;
        var layer;
	 $(function  (){

         layui.use(['form', 'layer','laydate'], function(){
             form = layui.form;
             layer = layui.layer;
             var laydate = layui.laydate;
             var url=basePath + 'aqcx/trust/saveTrustObj';
             // 提交表单，保存
             form.on('submit(savediscred)', function(data){
                 var formData = data.field;
                 $.post(url, formData, function (result) {
                     result = $.parseJSON(result);
                     if (result.code == "0"){
                         layer.msg('保存成功！', {time : 500},function(){
                             var obj = new Object();
                             obj.type = "ok";
                             sy.setWinRet(obj);
                             closeWindow();
                         });
                     } else {
                         layer.open({
                             title : "提示",
                             content: "保存失败：" + result.msg //这里content是一个普通的String
                         });
                     }
				 })
                 return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
			 });
            /* laydate.render({
                 elem: '#starttime'
                 ,type: 'datetime'
             });
             laydate.render({
                 elem: '#endtime'
                 ,type: 'datetime'
             });*/
             var start = {
                 elem: '#starttime',
                 type:'datetime',
                 show: true,
                 closeStop: '#starttime'

             };
             var end = {
                 elem: '#endtime',
                 type:'datetime',
                 show: true,
                 closeStop: '#endtime'
             };
             lay('#starttime').on('click', function(e){
                 if($('#endtime').val() != null && $('#endtime').val() != undefined && $('#endtime').val() != ''){
                     start.max = $('#endtime').val();
                 }
                 laydate.render(start);
             });
             lay('#endtime').on('click', function(e){
                 if($('#starttime').val() != null && $('#starttime').val() != undefined && $('#starttime').val() != ''){
                     end.min = $('#starttime').val();
                 }
                 laydate.render(end);
             });
             intSelectData("cxrecord",v_discredtype);
             var v_id = $("#id").val();
             if (v_id != null && v_id.length > 0){
                 $.post(basePath + 'aqcx/trust/queryTrustObj', {
                         id : v_id
                     },
                     function(result) {
                         if (result.code=='0') {
                             $('#sysUserForm').form('load', result.trust);
                             form.render();
                         }
                     }, 'json');
             };
             if ('<%=op%>' == 'view') {
                 $('form :input').addClass('input_readonly');
                 $('form :input').attr('readonly', 'readonly');
                 $('#starttime').attr('disabled', 'disabled');
                 $('#endtime').attr('disabled', 'disabled');
                 $('#a').css('display', 'none');
             }
             if(cxrecord==1){
                 $("#cxrecord").val('1');
             }else {
                 $("#cxrecord").val('2');
             }
             form.render();
         });


     })

//        function initSelectData() {
//            var typeOptions = '';
//            for (var i = 0; i < v_discredtype.length; i++) {
//                typeOptions += '<option value=\'' + v_discredtype[i].id + '\' >' + v_discredtype[i].text + '</option>';
//            }
//            $("#cxrecord").append(typeOptions);
//
//        }
        // 提交表单
        function submitForm() {
            if ($('#telephone').val()) {
                $('#telephone').attr('lay-verify', 'phone');
            } else {
                $('#telephone').removeAttr('lay-verify', 'phone');
            }
            if ($('#score').val()) {
                $('#score').attr('lay-verify', 'number');
            } else {
                $('#score').removeAttr('lay-verify', 'number');
            }
            $("#saveUserBtn").click();
        }
        // 关闭窗口
        function closeWindow(){
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        //选择人员



        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择人员'
                , area: ['100%', '100%']
                , content: basePath + 'aqcx/trust/personnelIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#ryid").val(myrow.ryid); //人员id
                    $("#ryxm").val(myrow.ryxm); //人员名称
                }
            });
        }

    </script>
  </head>
  
  <body>
	  <form id="sysUserForm" class="layui-form" action="">

		  <div class="layui-form-item">
			  <label class="layui-form-label">id:</label>
			  <div class="layui-input-inline">
				  <input type="text" name="id" id="id" readonly
						 value="<%=id%>" autocomplete="off" class="layui-input layui-bg-gray">
			  </div>
			  <label class="layui-form-label"><span style="color: red;">*</span>人员名称:</label>
			  <div class="layui-input-inline">
				  <input id="ryid" name="ryid" type="hidden">
				  <input type="text" name="ryxm" id="ryxm" value="<%=v_ryxm%>" required lay-verify="required"
						 autocomplete="off" class="layui-input" disabled="disabled">
			  </div>
			  <div class="layui-input-inline" style="width: 100px" id="a">
				  <a href="javascript:void(0)" class="layui-btn"
					 iconCls="icon-search" onclick="myselectcom()">选择人员</a>
			  </div>
		  </div>
		  <div class="layui-form-item">
			  <label class="layui-form-label">行为类型:</label>
			  <div class="layui-input-inline">
				  <select name="cxrecord" id="cxrecord" autocomplete="off" lay-verify="required" disabled="disabled">
				  </select>
			  </div>
			  <% if (!"1".equalsIgnoreCase(v_cxrecord)){ %>
			  <label class="layui-form-label">受到处罚的情况:</label>
			  <%} %>
			  <% if (!"2".equalsIgnoreCase(v_cxrecord)){ %>
			  <label class="layui-form-label">获得成果名称:</label>
			  <%} %>
			  <div class="layui-input-inline">
				  <input type="text" name="situation" id="situation"
						 autocomplete="off"  class="layui-input">
			  </div>
		  </div>
		  <div class="layui-form-item">
			  <label class="layui-form-label">分数:</label>
			  <div class="layui-input-inline">
				  <input type="text" name="score" id="score"
						 autocomplete="off"  class="layui-input" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
			  </div>
			  <label class="layui-form-label"><span style="color: red;">*</span>开始时间</label>
			  <div class="layui-inline">
				  <input id="starttime" name="starttime" required lay-verify="required"  class="layui-input test-item" placeholder="yyyy-MM-dd HH:mm:ss" type="text">
			  </div>



		  </div>
		  <div class="layui-form-item">

			  <label class="layui-form-label">联系方式:</label>
			  <div class="layui-input-inline">
				  <input type="text" name="telephone" id="telephone"
						 autocomplete="off"  class="layui-input">
			  </div>
			  <label class="layui-form-label"><span style="color: red;">*</span>结束时间</label>
			  <div class="layui-inline">
				  <input id="endtime" name="endtime" required lay-verify="required"  class="layui-input test-item" placeholder="yyyy-MM-dd HH:mm:ss" type="text">
			  </div>
		  </div>
		  <div class="layui-inline">
			  <div class="layui-form-item" style="display: none">
				  <div class="layui-input-inline">
					  <button class="layui-btn" lay-submit="" lay-filter="savediscred" id="saveUserBtn" >保存</button>
				  </div>
			  </div>
		  </div>
	  </form>
  </body>
</html>
