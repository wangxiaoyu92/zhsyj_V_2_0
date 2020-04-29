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
<title>诚信评定等级参数</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//红黑榜等级
	var djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
	var cb_djcshh;
	var grid;
	$(function() {

	cb_djcshh = $('#djcshh').combobox({
		data : djcshh,
		valueField : 'id',
		textField : 'text',
		required : true,
		editable :false,
		panelHeight : 180,
		panelWidth : 280
	});
		grid = $('#grid').datagrid({
			//title: '诚信评定结果表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'zx/zxpddjcs/queryZxpddjcs',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'djcsid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns :[[ {
				width : '100',
				title : '等级参数ID',
				field : 'djcsid',
				hidden : true
			},{
				width : '100',
				title : '等级参数编码',
				field : 'djcsbm',
				hidden : false
			},{
				width : '100',
				title : '等级参数名称',
				field : 'djcsmc',
				hidden : false
			},{
				width : '100',
				title : '起始分值',
				field : 'djcsqsfz',
				hidden : false
			},{
				width : '100',
				title : '结束分值',
				field : 'djcsjsfz',
				hidden : false
			}] ],
			columns : [ [ 
			{
				width : '150',
				title : '等级参数开始日期',
				field : 'djcsksrq',
				hidden : false
				},
			{
				width : '150',
				title : '等级参数结束日期',
				field : 'djcsjsrq',
				hidden : false
			},{
				width : '100',
				title : '操作员姓名',
				field : 'czyxm',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'czsj',
				hidden : false
			},{
				width : '100',
				title : '所属红黑',
				field : 'djcshh',
				hidden : false,
				formatter : function(value,row){
					return sy.formatGridCode(djcshh, value);
				}
			}] ]
		});
	});
	
	
	//查询诚信评定等级参数结果
	function query() {
		var param = {
			'djcsbm': $('#djcsbm').val(),
			'djcsmc':$('#djcsmc').val(),
			'djcshh': $('#djcshh').combobox('getValue')
		};
		grid.datagrid({
			url : basePath + '/zx/zxpddjcs/queryZxpddjcs',			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增诚信评定等级参数信息
	var addZxpddjcs = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增诚信评定等级参数信息',
			width : 900,
			height : 600,
			url : basePath + '/zx/zxpddjcs/zxpddjcsFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveZxpddjcs(dialog, grid, parent.$);
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
	var updateZxpddjcs = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑诚信评定等级参数信息',
				width:900,
				height:600,
				url:basePath + '/zx/zxpddjcs/zxpddjcsFormIndex?djcsid='+row.djcsid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.saveZxpddjcs(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的评定等级参数信息！','info');
		}
	}
	
	// 删除诚信评定等级参数信息
	function delZxpddjcs() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var djcsid = row.djcsid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?该操作将不可恢复',function(r) {
				if (r) {
					$.post(basePath + 'zx/zxpddjcs/delZxpddjcs', {
						djcsid: row.djcsid
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
			$.messager.alert('提示', '请先选择要删除的评定参数信息！', 'info');
		}
	}  	
	
	//查看企业评定信息
	var showZxpddjcs = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看诚信评定等级参数信息',
				width :900,
				height :600,
				url : basePath +'/zx/zxpddjcs/zxpddjcsFormIndex?op=view&djcsid='+row.djcsid,
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
						<td style="text-align:right;"><nobr>等级参数编码</nobr></td>
						<td><input id="djcsbm" name="djcsbm" style="width: 200px"/>
						</td>						
						<td style="text-align:right;"><nobr>等级参数名称</nobr></td>
						<td><input id="djcsmc" name="djcsmc" style="width: 200px" />
						</td>								
					</tr>
					<tr><td style="text-align:right;"><nobr>所属红黑</nobr></td>
						<td><input id="djcshh" name="djcshh" style="width: 200px"/></td>					
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
        	<sicp3:groupbox title="诚信评定等级参数信息">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveZxpddjcs"
								iconCls="icon-add" plain="true" onclick="addZxpddjcs()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveZxpddjcs"
								iconCls="icon-edit" plain="true" onclick="updateZxpddjcs()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delZxpddjcs"
								iconCls="icon-remove" plain="true" onclick="delZxpddjcs()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_zxpddjcsFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showZxpddjcs()">查看</a>
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