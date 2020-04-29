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
<title>法律法规信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var flfglx = <%=SysmanageUtil.getAa10toJsonArray("FLFGLX")%>
	//法律法规 
	var flfgdl = <%=SysmanageUtil.getFlfgDL()%>; 
	//法律法规小类
	var flfgdxl = <%=SysmanageUtil.getFlfgXL()%>; 
	var cb_flfldlbm;
	var cb_flfgxlbm;
	var grid;
	$(function() {
		//法律大类
		cb_flfldlbm = $('#flfgdlbm').combobox({
	    	data : flfgdl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 180,
	        panelWidth:280  
	    });
		//法律小类
		cb_flfgxlbm = $('#flfgxlbm').combobox({
			data : flfgdxl,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
		});
		//法律法规类型
		cb_flfglx = $('#flfglx').combobox({
			data : flfglx,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 180,
			panelWidth : 280
		});
		grid = $('#grid').datagrid({
			//title: '法律法规类别',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'flfg/queryPflfg',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'flfgid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns :[[ {
				width : '150',
				title : '法律法规ID',
				field : 'flfgid',
				hidden : true
			},{
				width : '150',
				title : '法律法规编号',
				field : 'flfgbh',
				hidden : false
			},{
				width : '150',
				title : '法律法规大类',
				field : 'flfgdlbm',
				hidden : false
			},{
				width : '150',
				title : '法律法规小类',
				field : 'flfgxlbm',
				hidden : false
				/* formatter : function(value,row){
					return sy.formatGridCode(flfgxlbm, value);
				} */
			},{
				width : '150',
				title : '法律法规类型',
				field : 'flfglx',
				hidden : false
			},{
				width : '150',
				title : '法律法规名称',
				field : 'flfgmc',
				hidden : false
			}] ],
			columns : [ [ 
			{
				width : '200',
				title : '法律法规内容',
				field : 'flfgnr',
				hidden : false
			},{
				width : '150',
				title : '操作员',
				field : 'flfgczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'flfgczsj',
				hidden : false
			},{
				width : '200',
				title : '法律法规发布机构',
				field : 'flfgfbjg',
				hidden : false
			},{
				width : '150',
				title : '法律法规发布开始时间',
				field : 'flfgfbkssj',
				hidden : false
			},{
				width : '150',
				title : '法律法规发布结束时间',
				field : 'flfgfbjssj',
				hidden : false
			}          
		]]
		});
	});
	
	//查询法律法规
	function query() {
		var param = {
			'flfgdlbm' : $('#flfgdlbm').val(),
			'flfgxlbm' : $('#flfgxlbm').val(),
			'flfgmc': $('#flfgmc').val()
		};
		grid.datagrid({
			url : basePath + '/flfg/queryPflfg',			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增法律法规
	var addPflfg = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增法律法规',
			width : 900,
			height : 600,
			url : basePath + '/flfg/pflfgFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.savePflfg(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑法律法规信息
	var updatePflfg = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title:'编辑法律法规',
				width:900,
				height:600,
				url:basePath + '/flfg/pflfgFormIndex?flfgid='+row.flfgid,
				buttons:[{
					text : '确定',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.savePflfg(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler : function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要修改的法律法规！','info');
		}
	}
	
	// 删除法律法规类别
	function delPflfg() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var flfgid = row.flfgid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'flfg/delPflfg', {
						flfgid: row.flfgid
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
			$.messager.alert('提示', '请先选择要删除的信息！', 'info');
		}
	}  	
	
	//查看法律法规
	var showPflfg = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看法律法规信息',
				width :900,
				height :600,
				url : basePath +'/flfg/pflfgFormIndex?op=view&flfgid='+row.flfgid,
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
						<td style="text-align:right;"><nobr>法律法规大类</nobr></td>
						<td><input id="flfgdlbm" name="flfgdlbm" style="width: 200px"/>
						</td>						
						<td style="text-align:right;"><nobr>法律法规小类</nobr></td>
						<td><input id="flfgxlbm" name="flfgxlbm" style="width: 200px" />
						</td>								
					</tr>
					<tr><td style="text-align:right;"><nobr>法律法规名称</nobr></td>
						<td><input id="flfgmc" name="flfgmc" style="width: 200px"/></td>					
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
        	<sicp3:groupbox title="法律法规">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addPflfg"
								iconCls="icon-add" plain="true" onclick="addPflfg()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updatePflfg"
								iconCls="icon-edit" plain="true" onclick="updatePflfg()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPflfg"
								iconCls="icon-remove" plain="true" onclick="delPflfg()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showPflfg"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPflfg()">查看</a>
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