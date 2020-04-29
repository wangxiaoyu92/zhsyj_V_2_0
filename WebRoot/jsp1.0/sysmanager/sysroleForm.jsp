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
	String roleid = StringHelper.showNull2Empty(request.getParameter("roleid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>角色编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var cb_sysroleflag;

	$(function() {
		cb_sysroleflag = $('#sysroleflag').combobox({
	    	data : [{id:'0',text:'非系统角色'},
	    	    	{id:'1',text:'系统角色'}
	    	],      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 'auto' 
	    });
				
		if ($('#roleid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/sysmanager/sysrole/querySysroleDTO', {
				roleid : $('#roleid').val()
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
				cb_sysroleflag.combobox('disable',true);	
			}
		}

	});


    // 保存 
	var submitForm = function($dialog) {
		var url;
		if($('#roleid').val().length > 0){
			url = basePath + '/sysmanager/sysrole/updateSysrole';
		}else{
			url = basePath + '/sysmanager/sysrole/addSysrole';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		parent.$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		parent.$.messager.alert('提示','保存成功！','info',function(){
			 			var obj = new Object();
			 			obj.type = "ok";
			 			sy.setWinRet(obj);
	        			closeWindow($dialog); 
	        		}); 	                        	                     
              	} else {
              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}; 

	// 关闭窗口
	var closeWindow = function($dialog){
    	$dialog.dialog('close');
	};
</script>
</head>
<body>
<div class="easyui-layout" fit="true"> 
	<form id="fm" method="post">
      	<sicp3:groupbox title="角色信息">	
    		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>角色ID:</nobr></td>
					<td><input id="roleid" name="roleid" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=roleid%>"/></td>						
					<td style="text-align:right;"><nobr>角色名称:</nobr></td>
					<td><input id="rolename" name="rolename" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>角色描述:</nobr></td>
					<td><input id="roledesc" name="roledesc" style="width: 200px" /></td>					
					<td style="text-align:right;"><nobr>角色类型:</nobr></td>
					<td><input id="sysroleflag" name="sysroleflag" style="width: 200px" /></td>
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>所属机构:</nobr></td>
					<td>
						<input name="orgname" id="orgname"  style="width: 200px; " onclick="showMenu_sysorg();" 
						   readonly="readonly" class="input_readonly"/>
						<input name="orgid" id="orgid"  type="hidden"/>
						<div id="menuContent_sysorg" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
						</div>							
					</td>	
				</tr>
			</table>
     	</sicp3:groupbox>
	</form>	
 </div>    	       
</body>
</html>