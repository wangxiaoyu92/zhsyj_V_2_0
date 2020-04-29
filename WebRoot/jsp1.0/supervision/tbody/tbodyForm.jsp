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
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String tbodyid = StringHelper.showNull2Empty(request.getParameter("tbodyid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>增加表格信息</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<script src="<%=basePath %>jslib/ckeditor_4.5.9/ckeditor.js"></script>
<script type="text/javascript">
	//下拉框列表
	var grid;
	var op ="<%=op%>";
	var tbodyid ="<%=tbodyid%>";
	var editor;
	$(function() {
//	//加载ckeditor
//        CKEDITOR.replace( 'tbodyinfo', {
//            extraPlugins: 'colordialog,table',
//            height: 200
//        } );
					 
		if ($('#tbodyid').val().length > 0) {
//            alert("3333"+tbodyid);
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + '/supervision/checkTbodyinfo/getTbodyinfo',{
				tbodyid : tbodyid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
			
		}
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存检查项目内容信息 
	var saveContent = function($dialog, $grid, $pjq) {
		var url = basePath + '/supervision/checkTbodyinfo/saveTbodyInfo';
		//提交一个有效并且避免重复提交的表单
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

	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	 
</script>
</head>

<body >
	<form id="fm" method="post">
	<input id="tbodyid" name="tbodyid" style="width: 200px;" hidden="true" value='<%=tbodyid%>'/>
        	<sicp3:groupbox title="计划和类别关联">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>表格类别</nobr></td>
						<td><input id="tbodytype" name="tbodytype" style="width: 260px;"/>
						</td>		
						<td style="text-align:right;"><nobr>计划类别</nobr></td>
						<td><input id="tbodycode" name="tbodycode" style="width: 260px;"/>
						</td>
				</tr>				
					<tr>
						<td style="text-align:right;"><nobr>tbody元素id</nobr></td>
						<td><input id="tbbodyid" name="tbbodyid" style="width: 260px;"/>
						</td>		
				</tr>	
				<tr>
						<td style="text-align:right;"><nobr>表头数据信息</nobr></td>
						<td colspan="3">
						<textarea  id="tbodyinfo" name="tbodyinfo" > </textarea>
						</td>		
				</tr>
				<tr>
						<td style="text-align:right;"><nobr>表头固定信息</nobr></td>
						<td colspan="3">
						<textarea  id="tbody" name="tbody" rows="10" style="width: 100%" > </textarea>
						</td>		
				</tr>
				<tr>
						<td style="text-align:right;"><nobr>底部固定信息</nobr></td>
						<td colspan="3" >
						<textarea  id="tfootinfo" name="tfootinfo" rows="10" style="width: 100%" > </textarea>
						</td>		
				</tr>						
				</table>
				       </sicp3:groupbox>
	   </form>
	  
</body>
</html>