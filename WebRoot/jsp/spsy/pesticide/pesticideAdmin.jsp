<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
			+ request.getServerPort() + request.getContextPath() + "/";
	} 
	Sysuser Vsuer = SysmanageUtil.getSysuser();
	String v_aaz001 = Vsuer.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>企业农资信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
	var v_pesticidezl = <%=SysmanageUtil.getAa10toJsonArray("PESTICIDEZL")%>;
	var mytab;
	$(function() {
		$('#pesticidezl').combobox({
			data : v_pesticidezl,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});
		mytab = $('#mytab').datagrid({
			toolbar: '#toolbar',
			url:'<%=basePath%>spsy/pesticide/queryPesticide',
			queryParams: {
				pesticidecomid: '<%=v_aaz001%>'
			},
			striped:true, // 奇偶行使用不同背景色
		    singleSelect:true, // True 就会只允许选中一行
		    pagination:true, // 底部显示分页栏
		    pageSize:10,
		    pageList:[10,15,20],
		    rownumbers:true, // 是否显示行号
		    fitColumns : false, // 列自适应宽度
		    sortOrder:'desc',
		    columns:[[
				{title:'id',field:'pesticideid',align:'center',width:100,hidden:'true'},
				{title:'名称',field:'pesticidename',align:'left',width:130},
				{title:'条码',field:'pesticidesptm',align:'left',width:110},
				{title:'品名',field:'pesticidepm',align:'left',width:100},
				{title:'规格型号',field:'pesticidegg',align:'left',width:80},
				{title:'保质期单位代码',field:'pesticidebzqdwcode',align:'left',hidden:'true'},
				{title:'保质期单位名称',field:'pesticidebzqdwmc',align:'left',hidden:'true'},
				{title:'保质期',field:'pesticidebzq',align:'left',width:60,
						formatter:function(value,rec){
					       if(rec.pesticidebzqdwmc=='月'){
						  		return value+'个'+rec.pesticidebzqdwmc;
					       } else if (!value) {
							   return "";
						   }else{
					       		return value+rec.pesticidebzqdwmc;
						   }
					}
				},
				{title:'产地/基地名称',field:'pesticidecdjd',align:'left',width:150},
				{title:'配料信息',field:'pesticideplxx',align:'left',width:100},
				{title:'产品标准号',field:'pesticidecpbzh',align:'left',width:80},
				{title:'产品种类',field:'pesticidezlstr',align:'left',width:130},
				{title:'包装规格',field:'pesticidebzgg',align:'left',width:80,hidden:'true'}
			]] 
		});  
	}); 
 
	//添加
	function addPesticide(){
		var dialog =  parent.sy.modalDialog({
			title : '添加',
			width : 950,
			height : 600,
			url : basePath + "spsy/pesticide/pesticideFormIndex",
			buttons : [{
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mytab, parent.$);
				} 
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				} 
			}]
		});   
	} 
	//更新
	function editPesticide() {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑信息',
				param : {
					pesticideid : row.pesticideid
				},
				width : 870,
				height : 500,
				url : basePath + '/spsy/pesticide/pesticideFormIndex',
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mytab, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		 }else{
				$.messager.alert('提示', '请先选择要修改的消息！', 'info');
		 }
	}
	//查看
	function showPesticide() {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				param : {
					op : "view",
					pesticideid : row.pesticideid
				},
				width : 870,
				height : 500,
				url : basePath + '/spsy/pesticide/pesticideFormIndex',
				buttons : [{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		} else {
			$.messager.alert('提示', '请先选择要查看的消息！', 'info');
		}
	}
	// 删除
	 function delPesticide() {
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?', function(r) {
				if (r) {
				 $.post(basePath + 'spsy/pesticide/delPesticide', {
							 pesticideid: row.pesticideid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info', function(){
								$('#mytab').datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					}, 'json');
				}
			});
		} else {
			$.messager.alert('提示', '请先选择要删除的信息！', 'info');
		}
	}
	// 查询信息
	function query() {
		var param = {
			'pesticidename': $('#pesticidename').val(),
			'pesticidezl': $('#pesticidezl').combobox('getValue'),
			'pesticidecomid':'<%=v_aaz001%>'
		};
		mytab.datagrid({
			url:'<%=basePath%>spsy/pesticide/queryPesticide',
			queryParams : param
		});
		mytab.datagrid('clearSelections');  
	}
	
	function refresh(){
		window.location.href = window.location.href;
	} 

	// 上传图片附件
	function uploadFjView(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + "pub/pub/uploadFjViewIndex";
			var dialog = parent.sy.modalDialog({
					title : '上传附件',
					param : {
						folderName : "sycp",
						fjwid : row.pesticideid
					},
					width : 900,
					height : 700,
					url : url
			},closeModalDialogCallback);
		} else {
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	
	// 图片附件
	function manageFjView(){
		var row = $('#mytab').datagrid('getSelected');
		if (row) {
			var url = basePath + "pub/pub/delFjViewIndex";
			var dialog = parent.sy.modalDialog({
					title : '管理图片',
					param : {
						fjwid : row.pesticideid
					},
					width : 900,
					height : 700,
					url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}
	
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少		
	}
</script>
</head>
<body> 
<div class="easyui-layout" fit="true"> 
	<div region="center" style="overflow: scroll;" border="false">
		<sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>物品名称</nobr></td>
					<td><input id="pesticidename" name="pesticidename" style="width: 200px"/></td>
					<td style="text-align:right;"><nobr>物品种类</nobr></td>
					<td><input id="pesticidezl" name="pesticidezl" style="width: 200px"/></td>
					<td style="text-align:center;" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-search" onclick="query()"> 查 询 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>
				</tr>
			</table>
        </sicp3:groupbox>
		<sicp3:groupbox title="企业农资列表">
			<div id="toolbar">
				<table>
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_addPesticide" iconCls="icon-add" plain="true"
							onclick="addPesticide()">增加</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_editPesticide" iconCls="icon-edit" plain="true"
							onclick="editPesticide()">编辑</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_showPesticide" iconCls="ext-icon-report_magnify" plain="true"
							onclick="showPesticide()">查看</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton"
							data="btn_delPesticide" iconCls="icon-remove" plain="true"
							onclick="delPesticide()">删除</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFjView"
							iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传图片</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_manageFjView"
							iconCls="icon-no" plain="true" onclick="manageFjView()">管理图片</a>
						</td>   
					</tr>
				</table>
			</div>
			<div id="mytab" style="height:350px;overflow:auto;"></div>
		</sicp3:groupbox>
	</div> 
</div>         
</body>
</html>