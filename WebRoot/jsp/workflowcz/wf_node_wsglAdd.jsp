<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
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
<title>节点新增关联文书</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var psbh = '<%=psbh %>';
	var nodeid = '<%=nodeid %>';
	var grid;
	
	$(function() {
		grid = $('#grid').datagrid({
			//title: '节点未关联文书',
			//iconCls: 'icon-tip',
			toolbar : '#toolbar',
			url : basePath + '/workflow/queryWfnodeWsglNo?psbh=' + psbh + '&nodeid=' + nodeid,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 60,
			pageList : [ 10, 20, 30, 60 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'zfwsdmz', //该列是一个唯一列
		    sortOrder: 'desc',					
			columns : [ [ {
				width : '20',
				field :'ck',
				checkbox : true 
			},{
				width : '200',
				title : '文书编号',
				field : 'zfwsdmz',
				hidden : false
			},{
				width : '300',
				title : '文书名称',
				field : 'zfwsdmmc',
				hidden : false
			} ] ]
		});
	});

	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var rows = grid.datagrid("getChecked");		
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$("#mygridrows").val(succJsonStr);
			$pjq.messager.confirm('提示', '确定提交吗?',function(r) {
				if (r) {
					//下面的例子演示了如何提交一个有效并且避免重复提交的表单
					$pjq.messager.progress();	// 显示进度条
					$('#fm').form('submit',{
						//url: basePath + '/workflow/addWfnodeWsgl?JsonStr=' + succJsonStr + '&psbh=' + psbh + '&nodeid=' + nodeid,
						url: basePath + '/workflow/addWfnodeWsgl?psbh=' + psbh + '&nodeid=' + nodeid,
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
	<div region="center" fit="true" border="false">
		<form id="fm" method="post" >    
		<input type="hidden" id="mygridrows" name="mygridrows"/>
	       	<sicp3:groupbox title="勾选要绑定的文书">	
	        	<div id="grid" style="height:450px;overflow:auto;"></div>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>