<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String id = StringHelper.showNull2Empty(request.getParameter("id"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>环境信息--编辑土壤信息</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<style type="text/css">
  body{
   overflow: scroll;
  }
 </style>
<script type="text/javascript">
	var editor;
	var id = '<%=id%>';
	$(function() {
			if ($('#soilid').val().length > 0) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
				$.post(basePath + 'environment/envSoilInfo/queryEnvSoilInfo', {
							soilid : $('#soilid').val()
				}, 
				function(result) {
					if (result.total=='1') {
						var mydata = result.rows[0];
						$('form').form('load', mydata);
							
					} else {
						parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	                }	
					parent.$.messager.progress('close');
				}, 'json');
			}
	});

	// 保存 
	function  submitForm($dialog, $grid, $pjq) {
		var url = basePath + 'environment/envSoilInfo/addEnvSoilInfo';
		if ($('#soilid').val().length > 0) {
			url = basePath + 'environment/envSoilInfo/updateEnvSoilInfo';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
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
					$pjq.messager.alert('提示','保存成功！','info',function(){
						$grid.datagrid('load');
						$dialog.dialog('destroy');
	        		}); 	                        	                     
              	} else {
					$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }

		});
	};
	  
	//关闭窗口
	var closeWindow = function($dialog, $pjq){
		$dialog.dialog('destroy');
	};
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: scroll;" border="false">
        	<form id="fm" method="post" >
	        		<table class="table" style="width: 99%;">	  
	        		    <tr  hidden="hidden">
							<td style="text-align:right;"><nobr>土壤信息ID：</nobr></td>
							<td><input id="soilid" name="soilid" style="width: 200px;" value="<%=id%>"/></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>土壤温度：</nobr></td>
							<td><input id="soiltemperature" name="soiltemperature" style="width: 200px;" /></td>						
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>土壤盐分：</nobr></td>
							<td><input id="soilsalinity" name="soilsalinity" style="width: 200px;" /></td>						
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>土壤水分：</nobr></td>
							<td><input id="soilmoisture" name="soilmoisture" style="width: 200px;" /></td>						
						</tr>
												
						
					</table>
			</form>
		</div>
	</div>
	
</body>
</html>