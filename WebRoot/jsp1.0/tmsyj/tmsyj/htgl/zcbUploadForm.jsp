<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 	
    String v_hjgztxgpicid = StringHelper.showNull2Empty(request.getParameter("hjgztxgpicid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>客户信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree2.jsp"></jsp:include>
<script type="text/javascript">  
	$(function() {
		if ($('#hjgztxgpicid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryJgztpicList', {
				hjgztxgpicid : $('#hjgztxgpicid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');
			 if ('<%=op%>' == 'view'){ 
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				//$('#btnselectcom').hide();
			 }
		} 
	});
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) { 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
			//if($('#jgztfwnfww').val() == 2){ //范围外的企业清空jgztfwnztid
			//  $('#jgztfwnztid').val("");
			//}
		$('#fm').form('submit',{
			url: basePath + 'tmsyjhtgl/saveJgztpic',
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
	        			$grid.datagrid('reload');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
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
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="hjgztxgpicid" name="hjgztxgpicid" value="<%=v_hjgztxgpicid%>"/>
		<input type="hidden" id="hviewjgztid" name="hviewjgztid"/>
		<input type="hidden" id="jgztpickind" name="jgztpickind" value="1"/>
		<input type="hidden" id="jcdw" name="jcdw"/>
		<input type="hidden" id="aae011" name="aae011"/>
		<input type="hidden" id="aae036" name="aae036"/>
		
		 
	       		<table class="table" style="width: 99%;"> 				
					<tr>
						<td style="text-align:right;"><nobr>自查人员:</nobr></td>
						<td><input name="zcry" id="zcry"  style="width: 200px;" class="easyui-validatebox" data-options="required:true"/>
						</td>
					</tr>
					<tr>									
						<td style="text-align:right;"><nobr>自查时间:</nobr></td>
						<td><input name="zcsj" id="zcsj"   class="easyui-datetimebox" 
						data-options="required:true" style="width: 200px; "/></td>						
					</tr> 
					<tr>
						<td style="text-align:right;"><nobr>联系电话:</nobr></td>
						<td><input name="lxdh" id="lxdh"   class="easyui-validatebox" 
						data-options="required:true,validType:'mobile'" style="width: 200px; "/></td>						
					</tr> 					
				</table>
		</form>
    </div>    
</body>
</html>