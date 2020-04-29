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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jkid = StringHelper.showNull2Empty(request.getParameter("jkid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>监控源编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表	
	$(function() {				
		if ($('#jkid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/jk/jkgl/queryJkyDTO', {
				jkid : $('#jkid').val()
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

			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');							
			}
			
			//$('#jkqybh').addClass('input_readonly');
			//$('#jkqybh').attr('readonly','readonly');
			//$('#jkybh').addClass('input_readonly');
			//$('#jkybh').attr('readonly','readonly');
			//$('#camorgid').addClass('input_readonly');
			//$('#camorgid').attr('readonly','readonly');
		}
	});


	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		if($('#jkid').val().length > 0){
			url = basePath + '/jk/jkgl/updateJky';
		}else{
			url = basePath + '/jk/jkgl/addJky';
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

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		var dialog = parent.sy.modalDialog({
			title : '监控',
			width : 300,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#aaa027').val(obj.aaa027);
			$('#aaa027name').val(obj.aaa027name);
		}
			sy.removeWinRet(dialogID);//不可缺少
		})
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >    
	       	<sicp3:groupbox title="监控源信息">	
	       		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>监控源ID:</nobr></td>
						<td><input name="jkid" id="jkid"  style="width: 175px; " class="input_readonly" readonly="readonly" value="<%=jkid%>"/></td>
						<td style="text-align:right;"><nobr>明厨亮灶监控对象id:</nobr></td>
						<td><input name="camorgid" id="camorgid"   style="width: 175px; " /></td>
					</tr>					
					<tr>	
						<td style="text-align:right;"><nobr>监控企业编号:</nobr></td>
						<td><input name="jkqybh" id="jkqybh"   style="width: 175px; "  class="easyui-validatebox" data-options="required:true" /></td>											
						<td style="text-align:right;"><nobr>监控企业名称:</nobr></td>
						<td><input name="jkqymc" id="jkqymc" style="width: 175px; " class="easyui-validatebox" data-options="required:true" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>监控源编号:</nobr></td>
						<td><input name="jkybh" id="jkybh"  style="width: 175px; "  class="easyui-validatebox" data-options="required:true" /></td>								
						<td style="text-align:right;"><nobr>监控源名称:</nobr></td>
						<td><input name="jkymc" id="jkymc"   style="width: 175px; " class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>监控类型:</nobr></td>
						<td><input name="jklx" id="jklx"   style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>显示顺序:</nobr></td>
						<td><input name="orderno" id="orderno"    style="width: 175px; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>离线监控视频路径:</nobr></td>
						<td><input name="jksppath" id="jksppath"   style="width: 175px; " /></td>
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 175px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>
					</tr>					
				</table>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>