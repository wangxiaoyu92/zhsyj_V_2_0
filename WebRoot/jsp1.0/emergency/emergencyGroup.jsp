<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>应急预案信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	var groupstate;
	$(function() {
		groupstate = $('#stateParam').combobox({
	    	data : [{id:'',text:'==请选择=='},{id:'0',text:'存在'},{id:'2',text:'已解散'}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		mygrid = $('#grid').datagrid({
			url : basePath + 'emergency/queryEmergencyGroupList',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'groupid', //该列是一个唯一列
		    sortOrder: 'desc',
		    onClickRow:function(rowIndex, rowData){
			  if (rowData.state == "2"){
			  	$("#btn_editGroup").linkbutton('disable');
				$("#btn_delgroup").linkbutton('disable');
				$("#btn_userManager").linkbutton('disable');
				$("#btn_rollbackGroup").linkbutton('enable');
			  }else{
				$("#btn_editGroup").linkbutton('enable');
				$("#btn_delgroup").linkbutton('enable');
				$("#btn_userManager").linkbutton('enable');
				$("#btn_rollbackGroup").linkbutton('disable');
			  }
		    },
			columns : [ [ {
				title: '应急小组id',
				field: 'groupid',
				width : '100',
				hidden : true
			},{
				title: '应急小组名称',
				field: 'groupname',
				width : '200',
				hidden : false
			},{
				title: '备注',
				field: 'remark',
				width: '150',
				hidden: false
			},{
				title: '状态',
				field: 'state',
				width: '100',
				hidden : false,
				formatter : function(value,row,index){
					if (value == 0){
						return "<span style='color:blue;'>存在</span>";
					} else if (value == 2) {
						return "<span style='color:red;'>已解散</span>";
					}
				}
			},{
				title: '经办人',
				field: 'opepateperson',
				width: '100',
				hidden : false
			},{
				title: '经办时间',
				field: 'opepatedate',
				width: '120',
				hidden : false
			}] ]
		});
	});
	// 查询应急小组
	function query() {
		var groupname = $('#groupnameParam').val();
		var state = $('#stateParam').val();
		var param = {
			'groupname': groupname,
			'state': $('#stateParam').combobox('getValue')
		};
		$('#grid').datagrid('load', param);
		$('#grid').datagrid('clearSelections'); 
	}
	// 刷新表格信息
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增应急队伍
	function addGroup() {
		var dialog = parent.sy.modalDialog({
			title : '添加小组',
			width : 800,
			height : 500,
			url : basePath + '/emergency/emergencyGroupInfoIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	}

	// 查看应急小组
	function showGroup() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看应急小组',
				width : 800,
				height : 500,
				url : basePath + '/emergency/emergencyGroupInfoIndex?op=view&groupid=' + row.groupid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的小组信息！', 'info');
		}
	}
	// 编辑应急小组
	function editGroup() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑应急小组',
				width : 800,
				height : 500,
				url : basePath + '/emergency/emergencyGroupInfoIndex?groupid=' + row.groupid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的应急小组信息！', 'info');
		}
	}

	// 解散应急小组
	function delgroup() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要解散这个应急队伍吗？',function(r) {
				if (r) {
					$.post(basePath + '/emergency/delEmergencyGroup', {
						groupid: row.groupid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								$('#grid').datagrid('load'); 
			        		}); 
						} else {
							$.messager.alert('提示', "操作失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的数据！', 'info');
		}
	}  
	// 成员管理
	function userManager(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'emergency/emergencyGroupPersonIndex';
			var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 500,
				param : {
					groupid : row.groupid
				}, 
				url : url
			});
			/* var obj = new Object();
			var v_groupid = "'" + row.groupid + "'";	// 小组id	    
		    var url = basePath + 'emergency/emergencyGroupPersonIndex?groupid='
		    	+v_groupid+'&time='+new Date().getMilliseconds(); 
			var k = popwindow(url,obj,800,500); */
		} else {
			$.messager.alert('提示', '请先选择相应的应急小组！', 'info');
		}
	}
	// 恢复应急小组
	function rollbackGroup() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要恢复这个应急队伍吗？',function(r) {
				if (r) {
					$.post(basePath + '/emergency/rollbackEmergencyGroup', {
						groupid: row.groupid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								$('#grid').datagrid('load'); 
			        		}); 
						} else {
							$.messager.alert('提示', "操作失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的数据！', 'info');
		}
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>应急小组名称</nobr></td>
						<td><input id="groupnameParam" name="groupnameParam" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>状态</nobr></td>
						<td><input id="stateParam" name="stateParam" style="width: 200px" /></td>							
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="应急小组列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_showGroup"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showGroup()">查看</a>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_addGroup"
								iconCls="ext-icon-group_add" plain="true" onclick="addGroup()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_editGroup"
								iconCls="ext-icon-group_edit" plain="true" onclick="editGroup()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_delgroup"
								iconCls="ext-icon-group_delete" plain="true" onclick="delgroup()">解散小组</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_userManager"
								iconCls="ext-icon-group_gear" plain="true" onclick="userManager()">成员管理</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" id="btn_rollbackGroup"
								iconCls="ext-icon-group_link" plain="true" onclick="rollbackGroup()">小组恢复</a>
							</td>   
							<td><div class="datagrid-btn-separator"></div></td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px; overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
		
</body>
</html>