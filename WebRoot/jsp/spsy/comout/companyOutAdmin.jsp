<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%
String contextPath = request.getContextPath();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>范围外企业管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_comghsorxhs=<%=SysmanageUtil.getAa10toJsonArray("COMGHSORXHS")%>;
var v_comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
		
$(function(){
	$('#mytab').datagrid({
		toolbar: '#toolbar',
    	title:'范围外企业管理',
    	iconCls:'icon-ok',
    	height:450,
    	pageSize:20,
    	pageList:[10,15,20],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fitColumns: true,
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	url: basePath + 'spsy/comout/queryComout',
    	loadMsg:'数据加载中,请稍后...',
    	sortOrder:'desc',
    	columns:[[
			{title:'企业ID',field:'comid',align:'center',hidden:true,width:120},
			{title:'企业名称',field:'commc',align:'left',width:200},
			{title:'许可证编号',field:'comxkzbh',align:'left',width:100},
			{title:'企业类型',field:'comdalei',align:'left',width:120,
				formatter : function(value, row) {
					return sy.formatGridCode(v_comdalei,value);
				}
			},
			{title:'法定代表人/负责人',field:'comfrhyz',align:'left',width:100},
			{title:'联系电话',field:'comyddh',align:'center',width:100},
			{title:'厂家地址',field:'comdz',align:'left',width:200},
			{title:'合作关系',field:'comghsorxhs',align:'left',width:90,
				formatter : function(value, row) {
					return sy.formatGridCode(v_comghsorxhs,value);
				}
			},
			{title:'录入企业',field:'comlrcommc',align:'left',width:150,hidden:'true'},
			{title:'添加时间',field:'comdzcsj',align:'center',width:110}
		]]
   	});
});

//添加
function addOutCom(){
	var url = basePath + 'jsp/spsy/comout/companyOutAdd.jsp';
	parent.sy.modalDialog({
			title : '添加',
			width : 850,
			height : 400,
			url : url
	}, closeModalDialogCallback);
}

//修改
function updateOutCom(){
	var row = $('#mytab').datagrid('getSelected');
	if(row){
		var url='<%=basePath%>/jsp/spsy/comout/companyOutAdd.jsp?comid='+row.comid;
		//创建模态窗口
		parent.sy.modalDialog({
			title : '修改',
			width : 850,
			height : 400,
			url : url
		},closeModalDialogCallback);
	}else{
		$.messager.alert('提示','请先选择要修改的企业！','info');
	}
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var obj = sy.getWinRet(dialogID);
	if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
		$("#mytab").datagrid("reload"); 
	}
	sy.removeWinRet(dialogID);//不可缺少		
}

//删除
function delOutCom(){
	var row = $('#mytab').datagrid('getSelected');
	if (row) {
		$.messager.confirm('警告', '您确定要删除该企业信息吗?',function(r) {
			if (r) {
				$.post(basePath + 'spsy/comout/delCompanyout', {
							comid: row.comid
						},
						function(result) {
							if (result.code == '0') {
								$.messager.alert('提示','删除成功！','info',function(){
									$('#mytab').datagrid('reload');
								});
							} else {
								$.messager.alert('提示', "删除失败：" + result.msg, 'error');
							}
						},
						'json');
			}
		});
	}else{
		$.messager.alert('提示', '请先选择要删除的企业信息！', 'info');
	}
}

// 上传图片附件
function fjManage(){
	var row = $('#mytab').datagrid('getSelected');
	if (row) {
		var url = basePath + "pub/pub/uploadFjViewIndex";
		var dialog = parent.sy.modalDialog({
			title : '上传附件',
			param : {
				folderName : "company",
				fjwid : row.comid
			},
			width : 900,
			height : 700,
			url : url
		},closeModalDialogCallback);
	} else {
		$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
	}
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: scroll;" border="false">
			<sicp3:groupbox title="企业列表">
				<div id="toolbar">
					<table>
						<tr>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addOutCom"
								   iconCls="icon-add" plain="true" onclick="addOutCom()">添加</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateOutCom"
								   iconCls="icon-edit" plain="true" onclick="updateOutCom()">修改</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delOutCom"
								   iconCls="icon-remove" plain="true" onclick="delOutCom()">删除</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_fjManage"
								   iconCls="icon-remove" plain="true" onclick="fjManage()">企业附件管理</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="mytab" style="height:450px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>