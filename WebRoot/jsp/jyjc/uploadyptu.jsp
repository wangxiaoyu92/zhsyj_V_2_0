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
// 检验样品id
String v_jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
if (v_jcypid == null || "".equals(v_jcypid)) {
	v_jcypid = DbUtils.getSequenceStr();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>检验检测样品上传</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s; 

	var jcyptpwjm = ''; // 图片样品文件名
	$(function() {
		//构造文件上传容器
		$("#uploader").pluploadQueue({
			runtimes : 'html5,flash', //设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			flash_swf_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf', // Flash环境路径设置
			silverlight_xap_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
			url : '<%=contextPath%>/jyjc/uploadJyjcypTp?jcypid=<%=v_jcypid%>',//上传文件URL
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
					jcyptpwjm = file.name;
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
						$('#jcyptpwjm').val(jcyptpwjm);
						var formData = $("#fm").serialize();	
						var s = new Object();      
						s.type = "ok";
						s.jcyptpwjm = $('#jcyptpwjm').val();
						s.uploadurl = "/upload/jyjc";
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
	<input id="jcyptpwjm"  name="jcyptpwjm" type="hidden" />	
	<input id="jcypid"  name="jcypid" type="hidden" value="<%=v_jcypid%>"/>		
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