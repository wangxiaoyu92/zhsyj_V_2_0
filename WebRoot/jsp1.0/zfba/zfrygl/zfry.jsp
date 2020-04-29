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
<title>执法人员</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	$(function() {
		grid = $('#grid').datagrid({
			//title: '司机列表',
			//iconCls: 'icon-tip',
			toolbar : '#toolbar',
			url : basePath + '/zfba/zfrygl/findZfry',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField : 'sjid', //该列是一个唯一列
			sortOrder : 'desc',
			frozenColumns : [ [ {
				width : '100',
				title : '执法人员ID',
				field : 'zfryid',
				hidden : false
			}, {
				width : '100',
				title : '执法人员编号',
				field : 'zfrybh',
				hidden : false
			}, {
				width : '100',
				title : ' 姓名',
				field : 'zfryname',
				hidden : false
			}] ],
			columns : [ [ {
				width : '100',
				title : ' 姓名拼音码',
				field : 'zfrypym',
				hidden : false
			}, {
				width : '100',
				title : '性别',
				field : 'zfryxb',
				hidden : false
			}, {
				width : '100',
				title : '出生日期',
				field : 'zfrycsrq',
				hidden : false
			}, {
				width : '100',
				title : '身份证号',
				field : 'zfrysfzh',
				hidden : false
			}, {
				width : '100',
				title : '手机号',
				field : 'zfrysjh',
				hidden : false
			}, {
				width : '100',
				title : '证件号',
				field : 'zfryzjhm',
				hidden : false
			}, {
				width : '100',
				title : '执法领域',
				field : 'zfryzflyid',
				hidden : false
			}, {
				width : '100',
				title : '用户id',
				field : 'zfryuserid',
				hidden : false
			}, {
				width : '100',
				title : '操作员',
				field : 'zfryczy',
				hidden : false
			}, {
				width : '100',
				title : '操作时间',
				field : 'zfryczsj',
				hidden : false
			}, {
				width : '200',
				title : '备注',
				field : 'zfrybz',
				hidden : false
			} ] ]
		});
	});
	//跳转到增 ，改 ， 查 页面
	// 新增
	function addZfry() {
		var dialog = parent.sy.modalDialog({
			title : '新增司机',
			width : 870,
			height : 500,
			url : basePath + 'zfba/zfrygl/zfryFormIndex',
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
	}
	// 查询
	function query() {
		 var zfrybh = $('#zfrybh').val(); 
		var zfryname = $('#zfryname').val();
		var zfrysfzh = $('#zfrysfzh').val(); 
		var param = {
			'zfrybh': zfrybh,
			'zfryname': zfryname,
			'zfrysfzh': zfrysfzh
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();
	}
	// 编辑
	function updateZfry() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑执法人员',
				width : 870,
				height : 500,
				url : basePath + 'zfba/zfrygl/zfryFormIndex?yc=y&zfryid=' + row.zfryid,
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
			$.messager.alert('提示', '请先选择要修改的执法人员！', 'info');
		}
	}

	// 查看
	function showZfry() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看执法人员',
				width : 870,
				height : 500,
				url : basePath + 'zfba/zfrygl/zfryFormIndex?op=view&zfryid=' + row.zfryid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的执法人员！', 'info');
		}
	}
	// 删除
	function delZfry() {
		var row = $('#grid').datagrid('getSelected'); 
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的执法人员相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + 'zfba/zfrygl/delZfry', {
						zfryid: row.zfryid 
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
			$.messager.alert('提示', '请先选择要删除的执法人员！', 'info');
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
						<td style="text-align:right;"><nobr>执法人员编号</nobr></td>
						<td><input id="zfrybh " name="zfrybh" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>执法人员姓名</nobr></td>
						<td><input id="zfryname" name="zfryname" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>身份证号</nobr></td>
						<td><input id="zfrysfzh" name="zfrysfzh" style="width: 200px" /></td>
					</tr>
					<tr>
						<td colspan="2"><a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search" onclick="query()">
								查 询 </a> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload"
							onclick="refresh()"> 重 置 </a></td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="司机列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_zfryFormIndex" iconCls="icon-add" plain="true"
								onclick="addZfry()">增加</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_updateSj" iconCls="icon-edit" plain="true"
								onclick="updateZfry()">编辑</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_sjglFormIndex" iconCls="ext-icon-report_magnify"
								plain="true" onclick="showZfry()">查看6</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_delSj" iconCls="icon-remove" plain="true"
								onclick="delZfry()">删除</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>