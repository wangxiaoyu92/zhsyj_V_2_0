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
	String v_arcid = StringHelper.showNull2Empty(request.getParameter("archiveid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>公文管理</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<style type="text/css">
  body{
   overflow: scroll;
  }
 </style>
 <script src="<%=basePath %>jslib/ckeditor_4.5.9/ckeditor.js"></script>
<script type="text/javascript">
	
	$(function() {
			if ($('#archiveid').val().length > 0) {
				$.post(basePath + '/egovernment/archive/queryArchiveDTO', {
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
				}, 'json');
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
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: scroll;" border="false">
        	<form id="fm" method="post" >	
        			<input id="archiveid" name="archiveid" type="hidden" value="<%=v_arcid%>"/>
	        		<table class="table" style="width: 99%;">	        		    
						<tr>
							<td style="text-align:right;"><nobr>文档编号：</nobr></td>
							<td><input id="archivecode" name="archivecode" style="width: 200px;" /></td>						
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>文档标题：</nobr></td>
							<td><input id="archivetitle" name="archivetitle" style="width: 400px;" class="easyui-validatebox" data-options="required:true" /></td>						
						</tr>								
						<tr>		
							<td style="text-align:right;"><nobr>添加时间：</nobr></td>
							<td><input id="archiveopperdate" name="archiveopperdate" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
						</tr>
						<tr>		
							<td style="text-align:right;"><nobr>文档内容：</nobr></td>
							<td>
								<div height="100px" style="overflow: auto;">
						        	<textarea class="ckeditor"  id="archivecontent" name="archivecontent" cols="20" rows="20"></textarea>
								</div>
							</td>
						</tr>
						<tr>		
							<td style="text-align:right;"><nobr>备注：</nobr></td>
							<td>
								<textarea id="archiveremark" name="archiveremark" cols="50" rows="5"></textarea>
							</td>
						</tr>
					</table>
			</form>
		</div>
	</div>
	
</body>
</html>