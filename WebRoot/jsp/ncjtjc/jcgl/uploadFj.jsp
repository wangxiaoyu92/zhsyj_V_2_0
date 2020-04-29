<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
	String jcsbid = StringHelper.showNull2Empty(request.getParameter("jcsbid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传组件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript">
	var fjpath = [];
	var fjname = [];
	$(function() {
		//构造文件上传容器
		$("#uploader").pluploadQueue({
			runtimes : 'html5,flash',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			flash_swf_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf',// Flash环境路径设置
			silverlight_xap_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
			url : '<%=contextPath%>/servlet/UploadServlet',//上传文件URL
			max_file_size : '10mb',//100b, 10kb, 10mb, 1gb
			chunk_size : '1mb',//分块大小，小于这个大小的不分块
			unique_names : true,//生成唯一文件名
			// 如果可能的话，压缩图片大小
			// resize : { width : 320, height : 240, quality : 90 },
			// 指定要浏览的文件类型
			filters : [ {
				title : '图片',
				extensions : 'jpg,jpeg,png,gif'
				//extensions: "zip,doc,docx,xls,xlsx,ppt,pptx,txt,jpg,jpeg,png,gif"
			}],
			init : {
				FileUploaded : function(up, file, info) {//文件上传完毕触发
					var response = $.parseJSON(info.response);
					if (response.status) {
						fjpath.push(response.fileUrl);
						fjname.push(file.name);						
					}
				}
			}
		});
	

		//校验表单
		$("#fm").validationEngine({
			//will validate on keyup and blur
			validationEventTriggers : "keyup blur",
			//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
			promptPosition : "centerRight",			 
			//addPromptClass : "formError-noArrow formError-text",
			maxErrorsPerField : 1,
			showOneMessage : true,
			//提示信息是否自动隐藏
			autoHidePrompt:true,
			//是否使用美化过的提示框
			prettySelect : true
		});
		
	});

	//保存
	var uploadFj = function(){								
		var status = $("#fm").validationEngine("validate");
		if (status) { //表单验证通过
			$('#btnSave').linkbutton('disable');//
			
			var uploader = $('#uploader').pluploadQueue();
			if (uploader.files.length > 0) {// 判断队列中是否有文件需要上传
				uploader.bind('StateChanged', function() {// 在所有的文件上传完毕时，提交表单
					if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
						//alert("您上传了：" + uploader.files.length + "个文件！");
						//alert(fjpath);
						//alert(fjname);
						$('#fjpath').val(fjpath);
						$('#fjname').val(fjname);

						var formData = $("#fm").serialize();						
						$.ajax({
				    		url: basePath + '/jg/ncjtjc/jcgl/uploadFj?jcsbid=<%=jcsbid %>',
				    		type: 'post',
				    		async: true,
				    		cache: false,
				    		timeout: 100000,
				    		data: formData,
				    		dataType: 'json',
				    		error: function() {
				    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info',function(){
				    				$('#btnSave').linkbutton('enable');//
				    			});			
				    		},
				    		success: function(result){ 
							 	if (result.code=='0'){	
					        		$.messager.alert('提示','上传成功','info',function(){
					        			showUploadFj();										
					                }); 	                        
				              	} else {
				              		$.messager.alert('提示','上传失败:'+result.msg,'error',function(){
				              			$('#btnSave').linkbutton('enable');//	
				    				});
				                }
					        }  
						});
					}
				});
				uploader.start();
			} else {
				alert('请至少选择一个文件进行上传！');
				$('#btnSave').linkbutton('enable');//
			}		 
		}							
	};

	//上传成功回显图片
	function showUploadFj(){
		if(fjpath.length>0){
			for(var i=0;i<fjpath.length;i++){
				$('#picbox').append("<div style=\"float:left;text-align:center;margin:0 20px 20px 0;\"><a href=" + sy.contextPath + fjpath[i] + " data-lightbox=\"fj\" ><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  fjpath[i] + "\"/></a></div>");
			}
		}
	} 
	
	//关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();      
		s.type = "ok";
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close"); 
		/* window.returnValue = s;   
		window.close();   */  
	} 
	  
	//关闭窗口  
	function closeWindow($dialog){
		parent.$("#"+sy.getDialogId()).dialog("close");
	    /* window.close(); */
	}
</script>
</head>
<body>
<form id="fm"  method="post">
	<input id="fjpath"  name="fjpath" type="hidden" />
	<input id="fjname"  name="fjname" type="hidden" />		
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
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  onclick="closeWindow();" id="btnCancel" >取消</a>
				</td>
	        </tr>
		</table>
	</sicp3:groupbox>
	<sicp3:groupbox title="上传图片预览">
		<div id="picbox" style="width:100%;text-align:center;">
		
		</div>
	</sicp3:groupbox>
</form>
</body>
</html>