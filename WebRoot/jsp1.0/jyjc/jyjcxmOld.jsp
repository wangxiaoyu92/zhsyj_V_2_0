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
<title>检验检测项目</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function(){
		grid=$("#grid").datagrid({
			//title: '检验检测项目',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'jyjc/queryJyjcxm',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 50,
			pageList : [ 50, 100, 150 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcxmid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns :[[ {
				width : '100',
				title : '检测项目ID',
				field : 'jcxmid',
				hidden : true
			},{
				width : '150',
				title : '检测项目编号',
				field : 'jcxmbh',
				hidden : false
			},{
				width : '150',
				title : '检测项目名称',
				field : 'jcxmmc',
				hidden : false
			},{
				width : '150',
				title : '检测项目标准值',
				field : 'jcxmbzz',
				hidden : false
			},{
				width : '150',
				title : '操作员',
				field : 'jcxmczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'jcxmczsj',
				hidden : false
			}] ]
		});
	});
	//查询检验检测项目
	function query() {
		var param = {
			'jcxmbh': $('#jcxmbh').val(),
			'jcxmmc':$('#jcxmmc').val(),
			'jcxmczy': $('#jcxmczy').val()
		};
		grid.datagrid({
			url : basePath + 'jyjc/queryJyjcxm',			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	//新增检验检测项目
	var addJyjcxm = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增检验检测项目',
			width : 800,
			height : 300,
			url : basePath + 'jyjc/jyjcxmFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveJyjcxm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑诚信评定等级参数信息
	var updateJyjcxm = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑检验检测项目',
				width:800,
				height:300,
				url:basePath + 'jyjc/jyjcxmFormIndex?jcxmid='+row.jcxmid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.saveJyjcxm(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的检验检测项目信息！','info');
		}
	}
	
	// 删除检验检测项目信息
	function delJyjcxm() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var jcxmid = row.jcxmid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'jyjc/delJyjcxm', {
						jcxmid: jcxmid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的检验检测项目信息！', 'info');
		}
	}  	
	
	//查看检验检测项目
	var showJyjcxm = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看检验检测项目',
				width :900,
				height :600,
				url : basePath +'jyjc/jyjcxmFormIndex?op=view&jcxmid='+row.jcxmid,
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
	
/* 	//打印
	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	}  */	
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>检测项目编号</nobr></td>
						<td><input id="jcxmbh" name="jcxmbh" style="width: 200px"/>
						</td>						
						<td style="text-align:right;"><nobr>检测项目名称</nobr></td>
						<td><input id="jcxmmc" name="jcxmmc" style="width: 200px" />
						</td>								
					</tr>
					<tr><td style="text-align:right;"><nobr>操作员</nobr></td>
						<td><input id="jcxmczy" name="jcxmczy" style="width: 200px"/></td>					
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检测项目信息">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcxm"
								iconCls="icon-add" plain="true" onclick="addJyjcxm()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcxm"
								iconCls="icon-edit" plain="true" onclick="updateJyjcxm()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJyjcxm"
								iconCls="icon-remove" plain="true" onclick="delJyjcxm()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_jyjcxmFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showJyjcxm()">查看</a>
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