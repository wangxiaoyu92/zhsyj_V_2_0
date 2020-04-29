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
	String psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>节点权限维护</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var psbh = '<%=psbh %>';
	var nodeid = '<%=nodeid %>';
	var grid;
	$(function() {						
		grid = $('#grid').datagrid({
			//title: '节点权限维护',
			//iconCls: 'icon-tip',
			//toolbar : '#toolbar',
			url : basePath + '/workflow/queryWfnodeNoRole?psbh=' + psbh + '&nodeid=' + nodeid,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'roleid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '20',
				field :'ck',
				checkbox : true 
			},{
				width : '100',
				title : '角色ID',
				field : 'roleid',
				hidden : false
			},{
				width : '150',
				title : '角色名称',
				field : 'rolename',
				hidden : false
			}]],					
			columns : [ [ {
				width : '100',
				title : '角色描述',
				field : 'roledesc',
				hidden : false
			} ] ]
		});
	});

	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var rows = grid.datagrid("getChecked");		
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$pjq.messager.confirm('提示', '确定提交吗?',function(r) {
				if (r) {
					//下面的例子演示了如何提交一个有效并且避免重复提交的表单
					$pjq.messager.progress();	// 显示进度条
					$('#fm').form('submit',{
						url: basePath + '/workflow/addWfnodeRole?JsonStr=' + succJsonStr + '&psbh=' + psbh + '&nodeid=' + nodeid,
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
				}
			});
		}else{
			$pjq.messager.alert('提示', '请选择要操作的记录!', 'warning');
			return;
		}
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
	       	<sicp3:groupbox title="勾选要绑定的角色权限">	
	        	<div id="grid"></div>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>