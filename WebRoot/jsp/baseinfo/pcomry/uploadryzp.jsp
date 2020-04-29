<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.db.DbUtils"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
// 人员id
String v_ryid = StringHelper.showNull2Empty(request.getParameter("ryid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传人员照片</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript">
	var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	window.returnValue = s; 

	var ryzpwjm = ''; // 图片样品文件名
	$(function() {
		//构造文件上传容器
		$("#uploader").pluploadQueue({
			runtimes : 'html5,flash', //设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			flash_swf_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf', // Flash环境路径设置
			silverlight_xap_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
			url : '<%=contextPath%>/pcomry/uploadryZp?ryid=<%=v_ryid%>',//上传人员照片URL
			max_file_size : '10mb',//100b, 10kb, 10mb, 1gb
			chunk_size : '1mb',// 分块大小，小于这个大小的不分块
			unique_names : true,// 生成唯一文件名
			// 如果可能的话，压缩图片大小
			resize : { width : 110, height : 140},
			// 指定要浏览的文件类型
			filters : [ {
				title : '图片',
				extensions : 'jpg,jpeg,png'
			}],
			init : {
				FileUploaded : function(up, file, info) { //文件上传完毕触发
					ryzpwjm = file.name;
				}
			}
		});	
	});
	
	//保存
	var uploadFj = function(){								
		var status = $("#fm").validationEngine("validate");
		if (status) { //表单验证通过
			$('#btnSave').linkbutton('disable'); // 设置保存按钮不可用
			
			var uploader = $('#uploader').pluploadQueue();
			if (uploader.files.length > 0) {// 判断队列中是否有文件需要上传
				uploader.bind('StateChanged', function() {// 在所有的文件上传完毕时，提交表单
					if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
						$('#ryzpwjm').val(ryzpwjm);
						var formData = $("#fm").serialize();	
						var s = new Object();      
						s.type = "ok";
						s.ryzpwjm = $('#ryzpwjm').val();
						s.uploadurl = "/upload/pcomryzp";   //企业人员照片
						window.returnValue = s;   
						window.close(); 					
					}
				});
				uploader.start();
			} else {
				alert('请选择一个文件进行上传！');
				$('#btnSave').linkbutton('enable');//
			}		 
		}	
							
	};
	
	//关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();      
		s.type = "ok";
		window.returnValue = s;   
		window.close();    
	} 
</script>
</head>
<body>
<form id="fm"  method="post">
	<input id="ryzpwjm"  name="ryzpwjm" type="hidden" />	
	<input id="ryid"  name="ryid" type="hidden" value="<%=v_ryid%>"/>		
    <sicp3:groupbox title="文件上传组件">
		<table class="table" style="width: 99%;">
			<tr>
				<td colspan="2">
					<div id="uploader">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
				</td>
			</tr>
		</table>
		<br/>
		<table style="width: 99%;">
	        <tr>
				<td style="text-align:center;">
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-upload"  onclick="uploadFj();" id="btnSave" >开始上传</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  onclick="closeAndRefreshWindow();" id="btnCancel" >取消</a>
				</td>
	        </tr>
		</table>
	</sicp3:groupbox>
</form>
</body>
</html>