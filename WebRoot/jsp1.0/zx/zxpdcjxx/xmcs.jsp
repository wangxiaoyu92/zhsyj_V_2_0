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
<title>信息采集</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var xmcs;
	$(function() {
		xmcs = $("#xmcs").datagrid({
			//title : '企业信息查询',
			url : basePath + 'zx/zxpdcjxx/xmcs',
			iconCls : 'icon-ok',
			height : 450,
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			nowrap : true,//True 就会把数据显示在一行里
			striped : true,//奇偶行使用不同背景色
			collapsible : true,
			singleSelect : true,//True 就会只允许选中一行
			fit : false,//让DATAGRID自适应其父容器
			fitColumns : false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
			pagination : true,//底部显示分页栏
			rownumbers : true,//是否显示行号 
			loadMsg : '数据加载中,请稍后...',
			columns : [ [ {
				title : '项目参数ID',
				field : 'xmcsid',
				align : 'left',
				width : 100,
				hidden : true
			}, {
				title : '项目参数编码',
				field : 'xmcsbm',
				align : 'left',
				width : 100
			}, {
				title : '项目参数名称',
				field : 'xmcsmc',
				align : 'left',
				width : 100
			}, {
				title : '项目参数分值',
				field : 'xmcsfz',
				align : 'left',
				width : 100
			}, {
				title : '项目参数开始时间',
				field : 'xmcsksrq',
				align : 'left',
				width : 100
			}, {
				title : '项目参数结束时间',
				field : 'xmcsjsrq',
				align : 'left',
				width : 100
			}, {
				title : '操作员姓名',
				field : 'czyxm',
				align : 'left',
				width : 100
			}, {
				title : '操作时间',
				field : 'czsj',
				align : 'left',
				width : 100
			}, {
				title : '参数状态',
				field : 'cssyzt',
				align : 'left',
				width : 100,
				formatter : function(value, row, index) {
					if (value == "1") {
						return "启用";
					} else {
						return "禁用";
					}
				}
			} ] ]
		});
	})
	var add = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加信息',
			width : 870,
			height : 500,
			url : basePath + '/zx/zxpdcjxx/xmcsFormaddIndex',
			buttons : [
					{
						text : '确定',
						handler : function() {
							dialog.find('iframe').get(0).contentWindow
									.submitForm(dialog, xmcs, parent.$);
						}
					},
					{
						text : '取消',
						handler : function() {
							dialog.find('iframe').get(0).contentWindow
									.closeWindow(dialog, parent.$);
						}
					} ]
		});
	}
	//编辑
	var update = function() { 
		var row = $('#xmcs').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑信息',
				width : 870,
				height : 500,
				url : basePath + '/zx/zxpdcjxx/xmcsFormIndex?xmcsid='
						+ row.xmcsid,
				buttons : [	{
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow
								.submitForm(dialog, xmcs, parent.$);
					}
				},  {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(
								dialog, parent.$);
					}
				} ]
			});
		} else {
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//查看
	var show = function() {
		var row = $('#xmcs').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				width : 870,
				height : 500,
				url : basePath + '/zx/zxpdcjxx/xmcsFormIndex?op=view&xmcsid='
						+ row.xmcsid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(
								dialog, parent.$);
					}
				} ]
			});
		} else {
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//删除
	var delxmcs = function() {
		var row = $('#xmcs').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的项目参数  相关信息，且不可恢复！',
					function(r) {
						if (r) {
							$.post(basePath + '/zx/zxpdcjxx/delxmcs', {
								xmcsid : row.xmcsid
							}, function(result) {
								if (result.code == '0') {
									$.messager.alert('提示', '删除成功！', 'info',
											function() {
												$('#xmcs').datagrid('reload');
											});
								} else {
									$.messager.alert('提示',
											"删除失败：" + result.msg, 'error');
								}
							}, 'json');
						}
					});
		} else {
			$.messager.alert('提示', '请先选择要删除的参数！', 'info');
		}
	}
	//查询
	function xmbmquery() {
		var xmcsbm = $('#xmcsbm').val();
		var xmcsmc = $('#xmcsmc').val();
		var param = {
			'xmcsmc' : xmcsmc,
			'xmcsbm' : xmcsbm
		};
		$('#xmcs').datagrid('reload', param);
		$('#xmcs').datagrid('clearSelections');
	}
	//重置
	function refresh() {
		parent.window.refresh();
	}
</script>
</head>
<body>
	<div region="center" style="overflow: true;" border="false">
		<sicp3:groupbox title="查询条件">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:center;"><nobr>项目编码名称</nobr></td>
					<td><input id="xmcsmc" name="xmcsmc" style="width: 200px" /></td>
					<td style="text-align:center;"><nobr>项目参数编码</nobr></td>
					<td><input id="xmcsbm" name="xmcsbm" style="width: 200px" /></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="xmbmquery()"> 查 询 </a>
						&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-reload"
						onclick="refresh()"> 重 置 </a></td>
				</tr>
			</table>
		</sicp3:groupbox>
	</div>
	<sicp3:groupbox title="信息列表">
		<table>
			<tr>
				<td><a href="javascript:void(0)" class="easyui-linkbutton"
					data="btn_cjxxIndex" iconCls="icon-add" plain="true"
					onclick=" add()">增加</a></td>
				<td>
					<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_" iconCls="icon-edit" plain="true"
						onclick="update()">编辑</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
				</td>
				<td><a href="javascript:void(0)" class="easyui-linkbutton"
					data="btn_xmcs" iconCls="ext-icon-report_magnify" plain="true"
					onclick="show()">查看</a></td>
				<td>
					<div class="datagrid-btn-separator"></div>
				</td>
				<td><a href="javascript:void(0)" class="easyui-linkbutton"
					data="btn_delxmcs" iconCls="icon-remove" plain="true"
					onclick="delxmcs()">删除</a></td>
				<td>
					<div class="datagrid-btn-separator"></div>
				</td>
			</tr>
		</table>
		<div id="xmcs" style="height:350px;overflow:auto;"></div>
	</sicp3:groupbox>
</body>
</html>