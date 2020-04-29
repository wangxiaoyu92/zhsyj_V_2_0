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
		mygrid = $("#usergrid").datagrid({
			//title: '节点权限维护',
			//iconCls: 'icon-tip',
			//toolbar : '#toolbar',
			url : basePath + '/workflow/queryWfnodeNoUserid?psbh=' + psbh + '&nodeid=' + nodeid,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 50,
			pageList : [ 50, 100, 150 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '20',
				field :'ck',
				checkbox : true 
			},{
				width : '100',
				title : '用户ID',
				field : 'userid',
				hidden : false
			},{
				width : '70',
				title : '用户账号',
				field : 'username',
				hidden : false
			},{
				width : '180',
				title : '所属机构',
				field : 'orgname',
				hidden : false
			}]],					
			columns : [ [ {
				width : '100',
				title : '用户名称',
				field : 'description',
				hidden : false
			} ] ]
		});
	});

	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var rows = $("#usergrid").datagrid("getChecked");	
		if(rows.length>0){		
			var succJsonStr = $.toJSON(rows);
			$("#userrows").val(succJsonStr);
			$pjq.messager.confirm('提示', '确定提交吗?',function(r) {
				if (r) {
					//下面的例子演示了如何提交一个有效并且避免重复提交的表单
					$pjq.messager.progress();	// 显示进度条
					$('#fm').form('submit',{
						//url: basePath + '/workflow/addWfnodeUserid?JsonStr=' + succJsonStr + '&psbh=' + psbh + '&nodeid=' + nodeid,
						url: basePath + '/workflow/addWfnodeUserid?psbh=' + psbh + '&nodeid=' + nodeid,		
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
	
	function query() {
		var param = {
			'username': $('#username').val(),
			'psbh':psbh,
			'nodeid':nodeid
		};
		mygrid.datagrid({
			url : basePath + '/workflow/queryWfnodeNoUserid',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}	
	
	function refresh(){
		//parent.window.refresh();
		$('#username').val('');
	} 
	
	
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
       	<sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>登录名/用户名/手机号</nobr></td>
					<td><input id="username" name="username" style="width: 200px"/></td>
					<td colspan="2">
				  	    &nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>					
					</td>						
				</tr>
			</table>
        </sicp3:groupbox>
	        	
		<form id="fm" method="post" >   
		   <input type="hidden" name="userrows" id="userrows"> 
	       	<sicp3:groupbox title="勾选要绑定的用户">	
	        	<div id="usergrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>