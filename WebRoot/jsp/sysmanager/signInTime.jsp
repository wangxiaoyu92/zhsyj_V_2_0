<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil " %>
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
<title>签到时间设置</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var settingUserOrg = {
		view: {
			showLine: true
		},
		check: {
			enable: true,
			chkboxType: { "Y" : "s", "N" : "s" }
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: null
			},
			key: {
				name: "orgname"
			}
		},
		callback: {
			onCheck: onCheckUserOrg
		}

	};
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var grid;
	$(function(){
		// 用户表
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url: basePath + 'sysmanager/sysuser/querySysuser',
			queryParams : { orgcode : '410001', orgid : '410523000000'}, // 汤阴食药局
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'userid', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [ {
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : false
			},{
				width : '80',
				title : '用户名称',
				field : 'username',
				hidden : false
			},{
				width : '150',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '200',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(userkind,value);
				}
			},{
				width : '100',
				title : '签到时间',
				field : 'signintime',
				hidden : false
			},{
				width : '100',
				title : '允许开始签到时间',
				field : 'allowsignintime',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'mobile',
				hidden : false
			},{
				width : '100',
				title : '手机号2',
				field : 'mobile2',
				hidden : false
			},{
				width : '150',
				title : '统筹区',
				field : 'aaa027name',
				hidden : false
			} ] ]
		});
		initUserOrgGrantZTree();
	});

	function refresh(){
		parent.window.refresh();	
	}

	function query() {
		var param = {
			'username': $('#username').val(),
			orgcode : '410001',
			orgid : '410523000000'
		};
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}

	// 初始化【组织机构】树
	function initUserOrgGrantZTree(){
		$.ajax({
			url: basePath + '/sysmanager/sysuser/querySysuserOrgZTree',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: '',
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');
			},
			success: function(result) {
				if (result.code == '0') {
					//准备zTree数据
					var zNodesOrg = eval(result.orgData);
					$.fn.zTree.init($("#treeDemo_userOrgGrant"), settingUserOrg, zNodesOrg);
				} else {
					$.messager.alert('提示', result.msg, 'error');
				}
			}
		});
	}

	//勾选或不勾选事件
	function onCheckUserOrg(event, treeId, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userOrgGrant");
		var nodes = treeObj.getCheckedNodes(true);
		var orgid = [];
		for(var i=0;i<nodes.length;i++){
			orgid.push(nodes[i].orgid);
		}
		$('#userOrgtreeCheckedNodes').val(orgid.join(","));
	}

	// 保存机构签到时间
	function saveSysuserOrgSignInTime() {
		var allowSignInTime = $("#allowSignInTime").val();
		if (!allowSignInTime) {
			$.messager.alert('提示', '请先设置允许开始签到时间！','info');
			return;
		}
		var signInTime = $("#signInTime").val();
		if (!signInTime) {
			$.messager.alert('提示', '请先设置签到时间！','info');
			return;
		}
		if (allowSignInTime > signInTime) {
			$.messager.alert('提示', '签到时间设置异常，请重新设置！','info');
			return;
		}
		var param = {orgid : $('#userOrgtreeCheckedNodes').val(),
			signintime : signInTime, allowsignintime : allowSignInTime, byOrg : 'true'};
		$.post(basePath + '/sysmanager/sysuser/saveSysuserSignInTime', param, function(result) {
			if (result.code=='0'){
				$.messager.alert('提示','签到时间设置成功！','info',function(){
					$('#grid').datagrid('reload');
				});
			} else {
				$.messager.alert('提示','签到时间设置失败：'+result.msg,'error');
			}
		}, 'json');
	}

	// 设置签到时间
	function setSignInTime() {
		var allowSignInTime = $("#allowSignInTime").val();
		if (!allowSignInTime) {
			$.messager.alert('提示', '请先设置允许开始签到时间！','info');
			return;
		}
		var signInTime = $("#signInTime").val();
		if (!signInTime) {
			$.messager.alert('提示', '请先设置签到时间！','info');
			return;
		}
		if (allowSignInTime > signInTime) {
			$.messager.alert('提示', '签到时间设置异常，请重新设置！','info');
			return;
		}
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var userid = row.userid;
			var param = { signintime : signInTime, userid : userid, allowsignintime : allowSignInTime, };
			$.post(basePath + '/sysmanager/sysuser/saveSysuserSignInTime', param, function(result) {
				if (result.code=='0'){
					$.messager.alert('提示','签到时间设置成功！','info',function(){
						$('#grid').datagrid('reload');
					});
				} else {
					$.messager.alert('提示','签到时间设置失败：'+result.msg,'error');
				}
			}, 'json');
		}else{
			$.messager.alert('提示', '请先选择要操作的用户！', 'info');
		}
	}
	// 设置所有用户的签到时间
	function setAllSignInTime() {
		var allowSignInTime = $("#allowSignInTime").val();
		if (!allowSignInTime) {
			$.messager.alert('提示', '请先设置允许开始签到时间！','info');
			return;
		}
		var signInTime = $("#signInTime").val();
		if (!signInTime) {
			$.messager.alert('提示', '请先设置签到时间！','info');
			return;
		}
		if (allowSignInTime > signInTime) {
			$.messager.alert('提示', '签到时间设置异常，请重新设置！','info');
			return;
		}
		var param = { signintime : signInTime, allowsignintime : allowSignInTime, isAll : 'true',
			orgcode : '410001', orgid : '410523000000' };
		$.post(basePath + '/sysmanager/sysuser/saveSysuserSignInTime', param, function(result) {
			if (result.code=='0'){
				$.messager.alert('提示','签到时间设置成功！','info', function(){
					$('#grid').datagrid('reload');
				});
			} else {
				$.messager.alert('提示','签到时间设置失败：'+result.msg,'error');
			}
		}, 'json');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: auto;" border="false">
		<sicp3:groupbox title="签到时间设置">
			<div style="text-align: center; font-size: 20px;margin-bottom: 20px;">
				允许开始签到时间：<input name="allowSignInTime" id="allowSignInTime" class="easyui-validatebox"
							data-options="required:true"readonly="readonly" style="width: 200px;" class="Wdate"
							onclick="WdatePicker({readOnly:true,dateFmt:'HH:mm:ss'})"
					/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				签到时间：<input name="signInTime" id="signInTime" class="easyui-validatebox" class="Wdate"
				data-options="required:true"readonly="readonly" style="width: 200px;"
				onclick="WdatePicker({readOnly:true,dateFmt:'HH:mm:ss'})"
				/>
			</div>
		</sicp3:groupbox>
		<div id="tabs" class="easyui-tabs" fit="false">
			<div title="按用户设置登录时间" style="overflow:hidden;">
				<form id="fm" method="post" >
					<sicp3:groupbox title="查询条件">
						<table class="table" style="width: 99%;">
							<tr>
								<td style="text-align:right;"><nobr>用户名称</nobr></td>
								<td><input id="username" name="username" style="width: 200px"/></td>
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
					<sicp3:groupbox title="用户信息">
						<div id="toolbar">
							<table>
								<tr>
									<td><a href="javascript:void(0)" class="easyui-linkbutton"
										   iconCls="icon-edit" plain="true" onclick="setSignInTime()">设置签到时间</a>
									</td>
									<td>
										<div class="datagrid-btn-separator"></div>
									</td>
									<td><a href="javascript:void(0)" class="easyui-linkbutton"
										   iconCls="icon-group_key" plain="true" onclick="setAllSignInTime()">设置所有用户签到时间</a>
									</td>
									<td>
										<div class="datagrid-btn-separator"></div>
									</td>
								</tr>
							</table>
						</div>
						<div id="grid" style="height:350px;overflow:auto;"></div>
					</sicp3:groupbox>
				</form>
			</div>
			<div title="按组织机构设置登录时间"  style="overflow:hidden;">
				<sicp3:groupbox title="组织机构信息">
					<div style="width:400px;height:340px;overflow: hidden;">
						<ul id="treeDemo_userOrgGrant" class="ztree" ></ul>
						<input type="hidden" id="userOrgtreeCheckedNodes">
					</div>
				</sicp3:groupbox>
				<div id="dlg2-buttons" style="float:right">
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					   onclick="saveSysuserOrgSignInTime();">保存签到时间</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
