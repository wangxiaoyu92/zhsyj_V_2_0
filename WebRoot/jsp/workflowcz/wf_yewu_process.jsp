<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>业务工作流绑定管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var sfqygzl = <%=SysmanageUtil.getAa10toJsonArray("SFQYGZL")%>;
	var cb_sfqygzl;
	var grid;
	
	$(function() {
		cb_sfqygzl = $('#sfqygzl').combobox({
	    	data : sfqygzl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    	    
		grid = $('#grid').datagrid({
			//title: '业务工作流绑定',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/workflow/queryWfyewuProcess',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'yewuprocessid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '业务工作流绑定ID',
				field : 'yewuprocessid',
				hidden : true
			},{
				width : '200',
				title : '业务名称',
				field : 'yewumc',
				hidden : false
			},{
				width : '150',
				title : '业务名称拼音码',
				field : 'yewumcpym',
				hidden : false
			}]],					
			columns : [ [ {
				width : '100',
				title : '是否启用工作流',
				field : 'sfqygzl',
				hidden : false,
				formatter : function(value, row) {
					if (row.sfqygzl == "0"){ //未启用
						return '<span style="color:red;">' + sy.formatGridCode(sfqygzl,value) + '</span>';
					}else{				
						return sy.formatGridCode(sfqygzl,value);
					}
				}
			},{
				width : '150',
				title : '绑定的工作流编号',
				field : 'psbh',
				hidden : false
			},{
				width : '200',
				title : '绑定的工作流名称',
				field : 'psmc',
				hidden : false
			},{
				width : '150',
				title : '绑定时间',
				field : 'aae036',
				hidden : false
			},{
				width : '150',
				title : '所属统筹区',
				field : 'aaa027name',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var psbh = $('#psbh').val();		
		var param = {
			'psbh': psbh
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
        window.location.reload();
	} 

	// 新增
	var addWfyewuProcess = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增业务工作流绑定',
			width : 800,
			height : 600,
			maximizable : false,
			url : basePath + '/workflow/wf_yewu_processFormIndex',
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
	// 修改
	var updateWfyewuProcess = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改业务工作流绑定',
				width : 800,
				height : 600,
				maximizable : false,
				url : basePath + '/workflow/wf_yewu_processFormIndex?yewuprocessid=' + row.yewuprocessid,
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
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	};

	// 删除
	var delWfyewuProcess = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，删除后不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/workflow/delWfyewuProcess', {
						yewuprocessid: row.yewuprocessid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', '操作失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	}

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>工作流编号</nobr></td>
						<td><input id="psbh" name="psbh" style="width: 200px"/></td>																
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
        	<sicp3:groupbox title="业务工作流绑定列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addWfyewuProcess"
								iconCls="icon-add" plain="true" onclick="addWfyewuProcess()">新增</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateWfyewuProcess"
								iconCls="icon-edit" plain="true" onclick="updateWfyewuProcess()">修改</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delWfprocess"
								iconCls="icon-remove" plain="true" onclick="delWfprocess()">删除</a>
							</td> 
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>-->												
						</tr>
					</table>
				</div>
				<div id="grid"></div>
	        </sicp3:groupbox>						         		
        </div>               
    </div>    
</body>
</html>