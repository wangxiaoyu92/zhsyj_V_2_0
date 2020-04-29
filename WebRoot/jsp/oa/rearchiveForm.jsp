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
	String v_archiveid = StringHelper.showNull2Empty(request.getParameter("archiveid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>收文管理</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<style type="text/css">
  body{
   overflow: scroll;
  }
 </style>
 <script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
<script type="text/javascript">
	var index;
	var form;
	var layer;
	var layedit;
	var laydate;
	$(function() {
		layui.use(['form', 'layer', 'laydate', 'layedit'], function () {
			form = layui.form;
			layer = layui.layer;
			laydate = layui.laydate;
			layedit=layui.layedit;
			laydate.render({
				elem: '#archiveopperdate',
				type:'datetime'
			});
			index=layedit.build('archivecontent');
		});
			if ($('#archiveid').val().length > 0) {
				/*$.post(basePath + '/egovernment/archive/queryArchiveDTO', {
                        archiveid : $('#archiveid').val()
				}, 
				function(result) {
					if (result.code=='0') {
						var editor;
						var mydata = result.data;	
						$('form').form('load', mydata);
 						editor= CKEDITOR.instances.archivecontent;
//     					editor.setData(mydata.archivecontent);	
//						editor = CKEDITOR.replace( 'archivecontent');
						if('<%=op%>' == 'view'){	
							$('form :input').addClass('input_readonly');
							$('form :input').attr('readonly','readonly');
							$('#hide').hide();
							CKEDITOR.on('instanceReady', function (ev) {
				                editor = ev.editor;
				                editor.setReadOnly(true); 
				            }); 

						}
							
					} else {
						parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	                }	
					parent.$.messager.progress('close');
				}, 'json');*/
				$.ajax({
					type:'POST',
					url:basePath + '/egovernment/archive/queryArchiveDTO',
					dataType:'json',
					data:{archiveid:$('#archiveid').val()},
					async:false,
					success:function(result){
						var mydata = result.data;
						$('#archivecontent').val(mydata.archivecontent);
						$('form').form('load', mydata);
						if('<%=op%>' == 'view'){
							$('form :input').addClass('input_readonly');
							$('form :input').attr('readonly','readonly');
							$('#hide').hide();

						}
					}
				});
			}
	});

	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		$pjq.messager.progress();	// 显示进度条
		var url;
		if($('#archiveid').val().length > 0){
			url = basePath + '/egovernment/archive/addArchive';
		}else{
			url = basePath + '/egovernment/archive/addArchive';
		}
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 $grid.datagrid('load');
	        			$dialog.dialog('destroy'); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };  
</script>
</head>
<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" method="post">
			<input id="archiveid" name="archiveid" type="hidden" value="<%=v_archiveid%>"/>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 90px">文档编号:</label>

				<div class="layui-input-inline" style="width: 350px">
					<input type="text" id="archivecode" name="archivecode" lay-verify="required"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 90px"><font class="myred">*</font>文档标题:</label>

				<div class="layui-input-inline" style="width: 650px">
					<input type="text" id="archivetitle" name="archivetitle"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 90px">添加时间:</label>

				<div class="layui-input-inline" style="width: 350px">
					<input type="text" id="archiveopperdate" name="archiveopperdate" lay-verify="required"
						   autocomplete="off" class="layui-input">

				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 90px">文档内容:</label>
				<div class="layui-input-inline" style="width: 650px">
					<textarea id="archivecontent" name="archivecontent"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 90px">备注:</label>

				<div class="layui-input-inline" style="width: 650px">
					<textarea placeholder="请输入内容" class="layui-textarea" id="archiveremark" name="archiveremark"></textarea>
				</div>
			</div>


		</form>
	</div>

</div>
	
</body>
</html>