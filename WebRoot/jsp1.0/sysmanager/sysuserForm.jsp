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
	String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>用户编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 
	var v_selfcomflag = <%=SysmanageUtil.getAa10toJsonArray("SELFCOMFLAG")%>; 
	
	var cb_userkind;
	var cb_lockstate;

	$(function() {
		cb_userkind = $('#userkind').combobox({
	    	data : userkind,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_lockstate = $('#lockstate').combobox({
	    	data : lockstate,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		
		$('#selfcomflag').combobox({
	    	data : v_selfcomflag,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		
				
		if ($('#userid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/sysmanager/sysuser/querySysuserDTO', {
				userid : $('#userid').val()
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
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		if($('#userid').val().length > 0){
			url = basePath + '/sysmanager/sysuser/updateSysuser';
		}else{
			url = basePath + '/sysmanager/sysuser/addSysuser';
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

	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};

</script>
</head>
<body>
<div class="easyui-layout" fit="true"> 
	<form id="fm" method="post">
		<sicp3:groupbox title="用户信息">	
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>用户ID:</nobr></td>
					<td><input id="userid" name="userid" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=userid%>"/></td>						
					<td style="text-align:right;"><nobr>用户名称:</nobr></td>
					<td><input id="username" name="username" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>用户描述:</nobr></td>
					<td><input id="description" name="description" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>			
					<td style="text-align:right;"><nobr>用户类别:</nobr></td>
					<td><input id="userkind" name="userkind" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
				</tr>
				<tr>		
					<td style="text-align:right;"><nobr>账户锁定状态:</nobr></td>
					<td><input id="lockstate" name="lockstate" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" value="0"/></td>						
					<td style="text-align:right;"><nobr>所属机构:</nobr></td>
					<td>
						<input name="orgname" id="orgname"  style="width: 200px; " onclick="showMenu_sysorg();" 
						   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
						<input name="orgid" id="orgid"  type="hidden"/>
						<div id="menuContent_sysorg" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
						</div>							
					</td>										
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
					<td>
						<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
						   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
						<input name="aaa027" id="aaa027"  type="hidden"/>
						<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
						</div>							
					</td>									
					<td style="text-align:right;"><nobr>手机号1:</nobr></td>
					<td><input id="mobile" name="mobile" style="width: 200px" class="easyui-validatebox"  data-options="validType:'mobile'"/></td>			
				</tr>
				<tr>															
					<td style="text-align:right;"><nobr>手机号2:</nobr></td>
					<td><input id="mobile2" name="mobile2" style="width: 200px" class="easyui-validatebox"  data-options="validType:'mobile'"/></td>
					<td style="text-align:right;"><nobr>电话号码:</nobr></td>
					<td><input id="telephone" name="telephone" style="width: 200px" class="easyui-validatebox"  data-options="validType:'phone'"/></td>
				</tr>
				<tr>															
					<td style="text-align:right;"><nobr>是否只能查看自己监管的企业:</nobr></td>
					<td><input id="selfcomflag" name="selfcomflag" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" value="0"/></td>
				</tr>				
			</table>
        </sicp3:groupbox>      	
	</form>
 </div>    	       
</body>
</html>