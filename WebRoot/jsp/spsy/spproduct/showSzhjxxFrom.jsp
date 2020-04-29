<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次号
	String cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品生产生长信息列表</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var s = new Object();
	s.type = "ok";   // 设为刷新父页面
	sy.setWinRet(s);
	var air_grid; // 大气信息表格
	var walter_grid; // 水信息表格
	var soil_grid; // 土壤信息表格
	var v_proid = '<%=proid%>';
	var v_cppcpch = '<%=cppcpch%>';

	$(function() {
		// 大气基本信息
		air_grid = $('#air_grid').datagrid({
			url: basePath + 'environment/envAirInfo/queryEnvAirInfo',
			queryParams: { proid: v_proid, cppcpch: v_cppcpch },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'airid', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [ {
					width : '100',
					title : '主键',
					field : 'airid',
					hidden : true
				}, {
					width : '100',
					title : '总悬浮颗粒物',
					field : 'airtsp',
					hidden : false
				}, {
					width : '100',
					title : '总碳氢化合物',
					field : 'airthc',
					hidden : false
				}, {
					width : '100',
					title : '总氧化剂',
					field : 'airto',
					hidden : false
				}, {
					width : '100',
					title : '氮氧化物',
					field : 'airoxynitride',
					hidden : false
				}, {
					width : '100',
					title : '二氧化硫',
					field : 'airso2',
					hidden : false
				}, {
					width : '100',
					title : '一氧化碳',
					field : 'airco',
					hidden : false
				}, {
					width : '100',
					title : '降尘',
					field : 'airdustfall',
					hidden : false
				}, {
					width:300,
					title:'操作',
					field:'opt',
					align:'center',
					formatter:function(value,rec){
						var v_ret = '<a href="javascript:updataAirxx(\''+rec.airid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/edit.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'
								+ '<a href="javascript:deleteAirxx(\''+rec.airid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/cancel.png" align="absmiddle">删除</a>'
								+ '<a href="javascript:uploadFjView(\''+rec.airid+'\')" mce_href="#">'
								+'<img src="<%=basePath%>images/pub/upload.png" align="absmiddle">上传图片</a>&nbsp;&nbsp;'
								+ '<a href="javascript:delFjView(\''+rec.airid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/set.png" align="absmiddle">管理图片</a>&nbsp;&nbsp;';
						return  v_ret;
					}
				}
			] ]
		});
		// 水基本信息
		walter_grid = $('#walter_grid').datagrid({
			url: basePath + 'environment/envWalterInfo/queryEnvWalterInfo',
			queryParams: { proid: v_proid, cppcpch: v_cppcpch },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'walterid', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [
				{
					width : '100',
					title : '水ID',
					field : 'walterid',
					hidden : true
				}, {
					width : '100',
					title : 'PH',
					field : 'walterph',
					hidden : false
				}, {
					width : '100',
					title : '溶氧',
					field : 'waltero2',
					hidden : false
				}, {
					width : '100',
					title : '温度',
					field : 'waltertemp',
					hidden : false
				}, {
					width : '100',
					title : '电导率',
					field : 'walterele',
					hidden : false
				}, {
					width : '100',
					title : '浊度',
					field : 'walterturbidity',
					hidden : false
				}, {
					width:300,
					title:'操作',
					field:'opt',
					align:'center',
					formatter:function(value,rec){
						var v_ret = '<a href="javascript:updataWalterxx(\''+rec.walterid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/edit.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'
								+ '<a href="javascript:deleteWalterxx(\''+rec.walterid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/cancel.png" align="absmiddle">删除</a>'
								+ '<a href="javascript:uploadFjView(\''+rec.walterid+'\')" mce_href="#">'
								+'<img src="<%=basePath%>images/pub/upload.png" align="absmiddle">上传图片</a>&nbsp;&nbsp;'
								+ '<a href="javascript:delFjView(\''+rec.walterid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/set.png" align="absmiddle">管理图片</a>&nbsp;&nbsp;';
						return  v_ret;
					}
				}
			] ]
		});
		// 土壤基本信息
		soil_grid = $('#soil_grid').datagrid({
			url: basePath + 'environment/envSoilInfo/queryEnvSoilInfo',
			queryParams: { proid: v_proid, cppcpch: v_cppcpch },
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'soilid', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [
				{
					width : '100',
					title : '土壤信息ID',
					field : 'soilid',
					hidden : true
				}, {
					width : '100',
					title : '土壤温度',
					field : 'soiltemperature',
					hidden : false
				}, {
					width : '100',
					title : '土壤盐分',
					field : 'soilsalinity',
					hidden : false
				}, {
					width : '100',
					title : '土壤水分',
					field : 'soilmoisture',
					hidden : false
				}, {
					width:300,
					title:'操作',
					field:'opt',
					align:'center',
					formatter:function(value,rec){
						var v_ret = '<a href="javascript:updataSoilxx(\''+rec.soilid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/edit.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'
								+ '<a href="javascript:deleteSoilxx(\''+rec.soilid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/cancel.png" align="absmiddle">删除</a>'
								+ '<a href="javascript:uploadFjView(\''+rec.soilid+'\')" mce_href="#">'
								+'<img src="<%=basePath%>images/pub/upload.png" align="absmiddle">上传图片</a>&nbsp;&nbsp;'
								+ '<a href="javascript:delFjView(\''+rec.soilid+'\')" mce_href="#">'
								+ '<img src="<%=basePath%>images/pub/set.png" align="absmiddle">管理图片</a>&nbsp;&nbsp;';
						return  v_ret;
					}
				}
			] ]
		});
	});

	// 修改水信息
	function updataWalterxx(id) {
		var dialog = parent.sy.modalDialog({
			title : '修改',
			param : {
				walterid : id
			},
			width : 600,
			height : 300,
			url : basePath + 'environment/envWalterInfo/editEnvWalterInfoFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, walter_grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		}, closeModalDialogCallback);
	}
	// 修改大气信息
	function updataAirxx(id) {
		var dialog = parent.sy.modalDialog({
			title : '修改',
			param : {
				airid : id
			},
			width : 600,
			height : 300,
			url : basePath + 'environment/envAirInfo/editEnvAirInfoFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, air_grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		}, closeModalDialogCallback);
	}
	// 修改土壤信息
	function updataSoilxx(id) {
		var dialog = parent.sy.modalDialog({
			title : '修改',
			param : {
				soilid : id
			},
			width : 600,
			height : 300,
			url : basePath + 'environment/envSoilInfo/editEnvSoilInfoFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, soil_grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		}, closeModalDialogCallback);
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID, grid){
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			grid.datagrid('reload');
		}
		sy.removeWinRet(dialogID);//不可缺少
	}

	// 删除大气信息
	function deleteAirxx(id) {
		$.post(basePath + 'environment/envAirInfo/delEnvAirInfo', {
					airid: id
		},
		function(result) {
			if (result.code == '0') {
				$.messager.alert('提示','删除成功！','info',function(){
					$('#air_grid').datagrid('reload');
				});
			} else {
				$.messager.alert('提示', "删除失败：" + result.msg, 'error');
			}
		},
		'json');
	}
	// 删除水信息
	function deleteWalterxx(id) {
		$.post(basePath + 'environment/envWalterInfo/delEnvWalterInfo', {
					walterid: id
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','删除成功！','info',function(){
							$('#walter_grid').datagrid('reload');
						});
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
	}
	// 删除土壤信息
	function deleteSoilxx(id) {
		$.post(basePath + 'environment/envSoilInfo/delEnvSoilInfo', {
					soilid: id
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','删除成功！','info',function(){
							$('#soil_grid').datagrid('reload');
						});
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
	}
	//上传图片附件（只保存图片到服务器）
	function uploadFjView(id){
		var url = basePath + 'pub/pub/uploadFjViewIndex';
		var dialog = parent.sy.modalDialog({
			title : '上传图片',
			param : {
				folderName : "sycp",
				fjwid : id
			},
			width : 900,
			height : 700,
			url : url
		},closeModalDialogCallback);
	}
	// 管理图片附件
	function delFjView(id){
		var url = basePath + 'pub/pub/delFjViewIndex';
		var dialog = parent.sy.modalDialog({
			title : '管理图片附件',
			param : {
				fjwid : id
			},
			width : 900,
			height : 700,
			url : url
		},closeModalDialogCallback);
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: auto;" border="false">
		<div id="tabs" class="easyui-tabs" fit="false">
			<div title="大气基本信息"  style="overflow:hidden;">
				<sicp3:groupbox title="大气基本信息">
					<div id="air_grid" style="height:400px;overflow:auto;"></div>
				</sicp3:groupbox>
			</div>
			<div title="水基本信息"  style="overflow:hidden;">
				<sicp3:groupbox title="水基本信息">
					<div id="walter_grid" style="height:400px;overflow:auto;"></div>
				</sicp3:groupbox>
			</div>
			<div title="土壤基本信息"  style="overflow:hidden;">
				<sicp3:groupbox title="土壤基本信息">
					<div id="soil_grid" style="height:400px;overflow:auto;"></div>
				</sicp3:groupbox>
			</div>
		</div>
	</div>
</body>
</html>