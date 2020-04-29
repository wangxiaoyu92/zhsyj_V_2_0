<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName()
		+ ":" + request.getServerPort() + contextPath + "/";
	// 课件类型
	String v_wareType = StringHelper.showNull2Empty(request.getParameter("wareType"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传课件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript">	
	var v_return = new Object();
	$(function() {
		var v_filters = [{ 
			title : '文件',
			extensions : "pdf,jpg,jpeg,png,gif,mp4,avi,wmv,flv,3gp,rmvb,rm"
		}];
		var v_wareType = $("#wareType").val(); // 文件类型
		if (v_wareType == "1") { // 视频
			v_filters = [{ 
				title : '视频文件',
				extensions: "mp4,avi,wmv,flv,3gp,rmvb,rm"
			}];
	   	} else if (v_wareType == "2") { // 图片
	   		v_filters = [{ 
				title : '图片文件',
				extensions: "jpg,jpeg,png,gif"
			}];
	    } else if (v_wareType == "3") { // 文档
	    	v_filters = [{ 
				title : '文档',
				extensions: "pdf"
			}];
		}
	
		// 上传组件初始化 
		$("#uploader").pluploadQueue({
			multi_selection : false, // 只上传一个
			runtimes : 'html5,flash', // 设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			flash_swf_url : basePath + 'jslib/plupload_1_5_7/plupload/js/plupload.flash.swf', // Flash环境路径设置
			silverlight_xap_url : basePath + 'jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
			url : basePath + 'servlet/UploadServlet?folderName=train', // 上传文件URL
			max_file_size : '1gb',//100b, 10kb, 10mb, 1gb
			chunk_size : '1mb',//分块大小，小于这个大小的不分块
			unique_names : true,//生成唯一文件名
			filters : v_filters,
			init : {
				FileUploaded : function(up, file, info) { // 文件上传完毕触发
					var response = $.parseJSON(info.response);
					if (response.status) {
						$('#fjpath').val(response.fileUrl);
						$('#fjname').val(file.name);
					}
				},
				FilesAdded : function(uploader, files) { //添加文件时触发
					if (uploader.files.length > 1) {
						$.messager.alert('提示','只能上传一个文件！','info');
						uploader.removeFile(files[0]);
					}						
				}
			}
		});
	});

	// 上传图片附件到服务器
	function uploadFj(){								
		var status = $("#fm").validationEngine("validate");
		if (status) { //表单验证通过
			$('#btnSave').linkbutton('disable'); //
			var uploader = $('#uploader').pluploadQueue();
			if (uploader.files.length > 0) { // 判断队列中是否有文件需要上传
				uploader.bind('FileUploaded', function() { // 文件上传成功时触发事件
					$.messager.alert('提示','上传成功','info',function(){
	        			v_return.type = "ok";
						v_return.fjpath = $('#fjpath').val();
					    v_return.fjname = $('#fjname').val();
					    sy.setWinRet(v_return); 	
					    closeAndRefreshWindow();					        			
	                });
				});
				uploader.bind('Error', function() { // 文件上传错误时触发事件
					$.messager.alert('提示','上传失败，请稍后再试！','info');
					$('#btnSave').linkbutton('enable');
				});
				uploader.start();
			} else {
				alert("请至少选择一个文件进行上传！");
				$('#btnSave').linkbutton('enable');
			}		 
		}							
	};
	//关闭并刷新父窗口
	function closeAndRefreshWindow(){     
		sy.setWinRet(v_return);
		parent.$("#"+sy.getDialogId()).dialog("close");
	} 
	  
</script>
</head>
<body>
<form id="fm"  method="post">
	<input id="wareType"  name="wareType" type="hidden" value="<%=v_wareType%>"/>
	<input id="fjpath"  name="fjpath" type="hidden" />
	<input id="fjname"  name="fjname" type="hidden" />		
    <sicp3:groupbox title="课件上传组件">
		<table class="table" style="width: 95%;">
			<tr>
				<td>
					<div id="uploader">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
				</td>
			</tr>
		</table>
		<br/>
		<table style="width: 95%;">
	        <tr>
				<td style="text-align:center;">
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-upload"  
						onclick="uploadFj()" id="btnSave" >开始上传</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  
						onclick="closeAndRefreshWindow()" id="btnCancel" >关闭</a>
				</td>
	        </tr>
		</table>
	</sicp3:groupbox>
</form>
</body>
</html>