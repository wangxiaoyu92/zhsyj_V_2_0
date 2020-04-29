<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>法律法规条款条款</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var flfgtkcybz = <%=SysmanageUtil.getAa10toJsonArray("FLFGTKCYBZ")%>
	//var cb_aaa027;
	var cb_flfgtkcybz;
	var grid;
	$(function() {
		//法律法规条款条款常用标志
		cb_flfgtkcybz = $('#flfgtkcybz').combobox({
			data : flfgtkcybz,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
		});
		grid = $('#grid').datagrid({
			//title: '法律法规条款条款',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'flfg/queryPflfgtk',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'flfgtkid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns :[[ {
				width : '150',
				title : '法律法规条款ID',
				field : 'flfgtkid',
				hidden : true
			},{
				width : '150',
				title : '法律法规Id',
				field : 'flfgid',
				hidden : true
			},{
				width : '250',
				title : '法律法规条款',
				field : 'flfgtkxm',
				hidden : false
			},{
				width : '550',
				title : '法律法规条款内容',
				field : 'flfgtknr',
				hidden : false
			},{
				width : '150',
				title : '法律法规条款常用标志',
				field : 'flfgtkcybz',
				hidden : false
			}] ]
		});
	});
	
	//查询法律法规条款
	function query(){
		var param = {
			'flfgtkxm' : $("#flfgtkxm").val()
		};
		grid.datagrid({
			url : basePath +'flfg/queryPflfgtk',
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增法律法规条款
	var addPflfgtk = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增法律法规条款',
			width : 900,
			height : 600,
			url : basePath + '/flfg/pflfgtkFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.savePflfgtk(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑法律法规条款信息
	var updatePflfgtk = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				 title : '编辑法律法规条款',    
				 width : 900,    
				 height : 600,      
				 url :  basePath+'/flfg/pflfgtkFormIndex?flfgtkid='+row.flfgtkid,     
				 buttons:[{
						text:'确定',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.savePflfgtk(dialog,grid,parent.$);
						}
					},{
						text:'取消',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
						}
					}]

			});
		}else{
			$.messager.alert('提示','请先选择要修改的法律法规条款信息！','info');
		}
	};
	
	
	//删除法律法规条款
	var delPflfgtk = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			$.messager.confirm('警告', '您确定要删除该条信息吗?', function(r){
				if (r){
					//异步删除
					$.post(basePath+'flfg/delPflfgtk',{
						flfgtkid : row.flfgtkid
					},function(result){
						if(result.code=='0'){
							$.messager.alert('提示','删除成功！','info',function(){
								$("#grid").datagrid('reload');
							});
						}else{
							$.messager.alert('提示','删除失败：'+result.msg,'error');
						}
					},'json');
				}
			});
		}else{
			$.messager.alert('提示','请先选择要删除的法律法规条款信息！','info');
		}
	};
	
	//查看法律法规条款
	var showPflfgtk = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看法律法规条款信息',
				width :900,
				height :600,
				url : basePath +'/flfg/pflfgtkFormIndex?op=view&flfgtkid='+row.flfgtkid,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的信息！','info');
		}
	}
	
/* 
	//打印
	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	} 	 */
</script>
</head>
<body>
		<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>法律法规条款</nobr></td>
						<td><input id="flfgtkxm" name="flfgtkxm" style="width: 200px"/>
						</td>						
						<td colspan="2" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>							
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="法律法规条款">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addPflfgtk"
								iconCls="icon-add" plain="true" onclick="addPflfgtk()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updatePflfgtk"
								iconCls="icon-edit" plain="true" onclick="updatePflfgtk()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPflfgtk"
								iconCls="icon-remove" plain="true" onclick="delPflfgtk()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showPflfgtk"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPflfgtk()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-print" plain="true" onclick="print()">打印</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    -->
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>  
</body>
</html>