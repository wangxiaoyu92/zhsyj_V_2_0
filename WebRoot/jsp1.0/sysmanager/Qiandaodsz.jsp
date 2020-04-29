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
%> 
<!DOCTYPE html>
<html>
<head>
<title>签到点获取</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript"> 
	var grid;
	$(function() { 
    grid = $('#grid').datagrid({ 
			toolbar: '#toolbar',
			url: basePath + 'sysmanager/sysuser/Queryqdd',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
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
				width : '200',
				title : '签到点名称',
				field : 'qddmc',
				hidden : false
			},{
				width : '80',
				title : '有效距离',
				field : 'qddyxjl',
				hidden : false
			},{
				width : '100',
				title : '经度',
				field : 'qddjdzb',
				hidden : false
			},{
				width : '100',
				title : '纬度',
				field : 'qddwdzb',
				hidden : false 
			},{
				width : '100',
				title : '是否有效',
				field : 'aae100',
				hidden : false,
				formatter : function(value, row){
				      if(value==1){
				         return "有效";
				      }else{
                         return "无效";				      
				      }
				} 
			},{
				width : '100',
				title : '操作员',
				field : 'aae011',
				hidden : false 
			},{
				width : '120',
				title : '操作时间',
				field : 'aae036',
				hidden : false 
			},{
				width : '200',
				title : '地址',
				field : 'qdddz',
				hidden : false 
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false 
			} ] ]
		});
	});
	function addqdd(){
		var dialog = parent.sy.modalDialog({
			title : '新增签到点',
			width : 890,
			height : 600,
			url : basePath + '/sysmanager/sysuser/QianDaodszFromIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	};
	//编辑签到点设置
	  function editqdd() {
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑签到点',
				width:900,
				height:600,
				url:basePath + '/sysmanager/sysuser/QianDaodszFromIndex?qddszid='+row.qddszid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示','请先选择要修改的签到点信息！','info');
		}
	}
	//删除签到点
	function delqdd() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var qddszid = row.qddszid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?该操作将不可恢复',function(r) {
				if (r) {
					$.post(basePath + '/sysmanager/sysuser/delqdd', {
						qddszid: qddszid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', '删除失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的签到点信息！', 'info');
		}
	}  	
</script>
</head>

<body > 
	<sicp3:groupbox title="签到点基本信息">  
       	<div id="toolbar">
       		<table>
				<tr>	        		
					<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysrole"
						iconCls="icon-add" plain="true" onclick="addqdd()">增加</a>
					</td>
					<td>  
						<div class="datagrid-btn-separator"></div>
					</td>  
					<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysrole"
						iconCls="icon-edit" plain="true" onclick="editqdd()">编辑</a>
					</td>
					<td>  
						<div class="datagrid-btn-separator"></div>
					</td>  
					<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysrole"
						iconCls="icon-remove" plain="true" onclick="delqdd()">删除</a>
					</td> 
					<td>  
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</div>
		<div id="grid"></div> 
	</sicp3:groupbox>  
</body>
</html>