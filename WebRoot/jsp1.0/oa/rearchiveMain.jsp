<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>

<!DOCTYPE html>
<html>
<head>
<title>文档管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {
	mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/egovernment/archive/queryRearchive',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'rcarchiveid', //该列是一个唯一列
		    sortOrder: 'asc',		
			columns : [ [ 
		        {
					width : '100',
					title : 'ID',
					field : 'rcarchiveid',
					hidden : true
				},{
					width : '100',
					title : '公文编码',
					field : 'rcarchivecode',
					hidden : false
				},{
					width : '350',
					title : '公文标题',
					field : 'rcarchivetitle',
					hidden : false
				},{
					width : '200',
					title : '公文关键字',
					field : 'rcarchivekey',
					hidden : true
				},{
					width : '200',
					title : '公文正文',
					field : 'rcarchivecontent',
					hidden : true
				},{
					width : '200',
					title : '备注',
					field : 'rcarchiveremark',
					hidden : false
				} ,{
					width : '120',
					title : '操作人',
					field : 'rcarchiveopperuser',
					hidden : false
				} ,{
					width : '140',
					title : '操作时间',
					field : 'rcarchiveopperdate',
					hidden : false
				} 
			] ]
		});


}); 
	//根据参数查询
	function query() {
		var param = {
			'rcarchivetitle': $('#rcarchivetitle').val(),
			'rcarchiveopperuser': $('#rcarchiveopperuser').val()
		};
		mygrid.datagrid({
			url : basePath + '/egovernment/archive/queryRearchive',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	// 查看
	function showArchive() {
		var row = $('#mygrid').datagrid('getSelected');
		var url='<%=basePath%>egovernment/archive/archiveFormIndex';
			if (row) {
				var dialog = parent.sy.modalDialog({
				title : '查看信息',
				param : {
					op : "view",
					archiveid :row.rcarchiveid
				},
				width : 870,
				height : 500,
				url : url,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
				},function (dialogID){
					var obj = sy.getWinRet(dialogID);//不可缺少
					if (obj!=null && "ok"==obj){
					$("#mygrid").datagrid("reload");
			}
				})
		}else{
			$.messager.alert('提示', '请先选择要查看的文档！', 'info');
		}
	} 
	//删除
	function  delRearchive() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该文档吗?',function(r) {
				if (r) {
					$.post(basePath + '/egovernment/archive/delRearchive', {
						rcarchiveid: row.rcarchiveid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的文档！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<form id="myqueryfm" method="post">
			<div region="center" style="overflow: true;" border="false">
				<sicp3:groupbox title="查询条件">
					<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>标题</nobr>
							</td>
							<td><input id="rcarchivetitle" name="rcarchivetitle"
								style="width: 200px" /></td>
							<td style="text-align:right;"><nobr>操作员</nobr>
							</td>
							<td><input id="rcarchiveopperuser" name="rcarchiveopperuser"
								style="width:200px" />
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="4"><a
								href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
								class="easyui-linkbutton" iconCls="icon-reload"
								onclick="refresh()"> 重 置 </a></td>
						</tr>


					</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="文档列表">
					<div id="toolbar">
						<table>
							<tr>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
									iconCls="ext-icon-report_magnify" plain="true" onclick="showArchive()">查看</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_delRearchive" name="btn_delRearchive" data="btn_delRearchive"
									iconCls="icon-remove" plain="true" onclick="delRearchive()">删除</a></td>
							</tr>
						</table>
					</div>
					<div id="mygrid" style="height:350px;overflow:auto;"></div>
				</sicp3:groupbox>
			</div>
		</form>
	</div>
</body>
</html>
