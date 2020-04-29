<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>企业二维码管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		if ($('#comid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'pcompany/queryCompanyQRcode',{
				comid : $('#comid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
	            var qrcodecontent = $("#qrcodecontent").val();
	            var tpname = $("#comid").val();
	            if (qrcodecontent != "") {
	            	$("#qrcodeimg").attr("src", "<%=contextPath%>/upload/qrcode/"+tpname+".gif");
	            } else {
	            	$("#qrcodeimg").attr("src", "<%=contextPath%>/images/default.jpg");
	            }
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	
	// 创建二维码
	function createQRcode() {
		var comid = $("#comid").val();
		var url = basePath + "pcompany/createComQRcode";
		var paramers = {
			comid : '<%=comid%>'
		};
		$.ajax({
		   type : "POST",
		   url : url,
		   data : paramers,
		   success : function(msg){
		   		var tpname = $("#comid").val();
		   		var v_qrcodepath = "upload/qrcode/" + tpname + ".gif";
		   		$("#qrcodeimg").attr("src", basePath + v_qrcodepath);
		   		$("#qrcodepath").val(v_qrcodepath);
		   }
		});
	}
	// 保存二维码
	function saveQRcode() {
		var url = basePath + 'pcompany/savePcompanyQRcode';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 window.returnValue="ok";
						 window.close(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
</script>
</head>
<body>
<form id="fm" method="post">
	<sicp3:groupbox title="企业二维码">
   		<table class="table" style="width: 90%;">
   			<tr>
     			<input id="comid" name="comid" type="hidden" value="<%=comid%>"/>
				<input id="qrcodepath" name="qrcodepath" type="hidden"/>
				<input id="qrcodecontent" name="qrcodecontent" type="hidden"/>
     		</tr>
			<tr>	
				<td style="text-align:right;"><nobr>企业名称:</nobr></td>
				<td><input id="commc" name="commc" style="width: 200px" disabled="disabled"/></td>							
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>二维码:</nobr></td>
				<td>
				    <div style="width:200px;height:200px;" id="comqrcode_div">
				    	<img name="qrcodeimg" id="qrcodeimg" height="200" width="200" />
				   	</div>
	    	    </td>
			</tr>
			<tr>	
				<td style="text-align:center;" colspan="2">
					<a href="javascript:void(0)" class="easyui-linkbutton"
					   onclick="createQRcode()">生成二维码</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
				   	   iconCls="icon-save" onclick="saveQRcode()">保存</a>
				</td>
			</tr>
		</table>
	</sicp3:groupbox>
</form>
</body>
</html>