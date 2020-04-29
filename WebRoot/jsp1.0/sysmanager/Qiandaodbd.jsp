<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%  String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_userid = StringHelper.showNull2Empty(request.getParameter("userid")); 
%> 
<!DOCTYPE html>
<html>
<head>
<title>签到点获取</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript"> 
	var grid;
	var secGrid;
	$(function() { 
    	grid = $('#grid').datagrid({ 
			url: basePath + 'sysmanager/sysuser/Queryqddsz?aae100=1&userid='+$("#userid").val() ,
			title: '未绑定的签到点',
			iconCls: 'icon-tip',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			//pagination : true,// 底部显示分页栏
			//pageSize : 10,
			//pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qddszid', //该列是一个唯一列
		    sortOrder: 'desc',			
			columns : [ [ { 
				width : '200',
				title : '签到点id',
				field : 'qddszid',
				hidden : true
			},{
				width : '100',
				title : '签到点名称',
				field : 'qddmc',
				hidden : false
			},{
				width : '60',
				title : '有效距离',
				field : 'qddyxjl',
				hidden : false 
			},{ 
				width : '150',
				title : '地址',
				field : 'qdddz',
				hidden : false 
			} ] ],
			onClickRow:
				function(index,data) {
					appendGridData(index,data);
				}
		}); 
    	secGrid = $('#secGrid').datagrid({ 
			url: basePath + 'sysmanager/sysuser/Queryqddczybd?aae100=1&userid='+$("#userid").val() ,
			title: '已绑定的签到点',
			iconCls: 'icon-tip',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			//pagination : true,// 底部显示分页栏
			//pageSize : 10,
			//pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qddszid', //该列是一个唯一列
		    sortOrder: 'desc',			
			columns : [ [ { 
				width : '200',
				title : '绑定id',
				field : 'qddczybdid',
				hidden : true
			},{ 
				width : '200',
				title : '签到点id',
				field : 'qddszid',
				hidden : true
			},{
				width : '100',
				title : '签到点名称',
				field : 'qddmc',
				hidden : false
			},{
				width : '60',
				title : '有效距离',
				field : 'qddyxjl',
				hidden : false 
			},{ 
				width : '150',
				title : '地址',
				field : 'qdddz',
				hidden : false 
			} ] ],
			onClickRow:
				function(index,data) {
					appendsecGridData(index,data);
				}
		}); 
	});
	 function appendGridData(index,v_data){
	 	var addData = {
		 				'qddszid' : v_data.qddszid,
		 				'qddmc' : v_data.qddmc,
		 				'qddyxjl' : v_data.qddyxjl,
		 				'qdddz':v_data.qdddz
		 			}; 
		 			$("#secGrid").datagrid("appendRow",addData);
		 			$("#grid").datagrid("deleteRow",index);
	 }
	 function appendsecGridData(index,v_data){
	 	var addData = {
		 				'qddszid' : v_data.qddszid,
		 				'qddmc' : v_data.qddmc,
		 				'qddyxjl' : v_data.qddyxjl,
		 				'qdddz':v_data.qdddz
		 			}; 
		 			$("#grid").datagrid("appendRow",addData);
		 			$("#secGrid").datagrid("deleteRow",index);
		 			
	 }
	 
	 var submitForm = function($dialog, $grid, $pjq) {
	 	var rows = secGrid.datagrid("getRows");	 
			var succJsonStr = $.toJSON(rows); 
			//下面的例子演示了如何提交一个有效并且避免重复提交的表单
			$.messager.progress();	// 显示进度条
			$.ajax({
				cache: true,
				type: "POST",
				url:basePath + '/sysmanager/sysuser/Saveqddczybd',
				data:{succes:succJsonStr,userid:$("#userid").val()},
				async: false,
				error: function(request) {
					$.messager.alert('提示', '操作失败:' + request, 'error');
				},
				success: function(result) {
					$.messager.progress('close');// 隐藏进度条
					result = $.parseJSON(result);
					if (result.code == '0') {
						$.messager.alert('提示', '操作成功', 'info',function(){
							// $grid.datagrid('load');
	        			     $dialog.dialog('destroy');  
						});
					} else {
						$.messager.alert('提示', '操作失败:' + result.msg, 'error');
					}
				} 
			}); 	
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };
	</script>
	 
</head>

<body > 
    <input type="hidden" id="userid" name="userid" value="<%=v_userid%>">
	<sicp3:groupbox title="签到点基本信息">
	<table>
		<tr>
			<td>
				<table id="grid"  style="width:360px;height:380px;overflow-y:auto;overflow-x:hidden;"></table>
			</td> 
			<td>
				<table id="secGrid" style="width:360px;height:380px;overflow-y:auto;overflow-x:hidden;"></table>
			</td>
		</tr>
	</table> 
		<!-- <table>
			<tr>
				<td>
					<table id="grid"  style="width:360px;height:360px;overflow:auto;"></table>
				</td>
				<td>
					<table id="grid2"  style="width:360px;height:360px;overflow:auto;"></table>
				</td> 
			</tr>
		</table> -->
		       <!--  <div style="text-align:right">
		        	<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-ok" onclick="addComProducts()">提交保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
		        	<a href="javascript:void(0)" class="easyui-linkbutton" 
						iconCls="icon-cancel" onclick="closeWindow()">取消关闭</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
		        </div>	 -->
	</sicp3:groupbox> 
</body>
</html>