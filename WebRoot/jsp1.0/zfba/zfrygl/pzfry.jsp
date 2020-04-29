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
var v_zfrylybm= <%=SysmanageUtil.getAa10toJsonArray("ZFRYLYBM")%>;

$(function(){
	cb_sjsfzjlx = $('#zfrylybm').combobox({
    	data : v_zfrylybm,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto'
    });
	
	grid = $('#grid').datagrid({ 
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
		onLoadSuccess:function(data){
			$('#grid').datagrid('unselectAll');
		},
		frozenColumns : [ [ {
			width : '100',
			title : '用户ID',
			field : 'userid',
			hidden : false
		}, {
			width : '100',
			title : '执法人员ID',
			field : 'zfryid',
			hidden : false
		},{
			width : '100',
			title : '用户名',
			field : 'username',
			hidden : false
		}, {
			width : '100',
			title : '描述',
			field : 'description',
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
		},{
			width : '100',
			title : '证件号码',
			field : 'zfryzjhm',
			hidden : false
		},{
			width : '100',
			title : '手机号',
			field : 'mobile',
			hidden : false
		}, {
			width : '100',
			title : '机构名',
			field : 'orgname',
			hidden : false
		}, {
			width : '100',
			title : '执法领域',
			field : 'zfryzflymc',
			hidden : false
		}, {
			width : '100',
			title : '执法人员职务',
			field : 'zfryzw',
			hidden : false
		}, {
			width : '100',
			title : '统筹区编码',
			field : 'aaa027',
			hidden : false
		}, {
			width : '200',
			title : '备注',
			field : 'zfrybz',
			hidden : false
		} ] ]
	});
});

// 查询
	function query() {
		 var mobile = $('#mobile').val(); 
		var v_zfrylybm2 = $('#zfrylybm').combobox('getValue'); 
		var param = {
			'mobile': mobile,
			'zfrylybm': v_zfrylybm2 
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');
	}
//重置
 function refresh(){
	parent.window.refresh();
}
//修改
function updateZfry() {
	var row = $('#grid').datagrid('getSelected');
	if (row) {
		var dialog = parent.sy.modalDialog({
			title : '编辑执法人员',
			width : 700,
			height : 500,
			url : basePath + '/zfba/zfrygl/pzfryFormIndex?userid='+row.userid,                                           
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
		$.messager.alert('提示', '请先选择要编辑的执法人员！', 'info');
	}
}
//查看
function showZfry() {
	var row = $('#grid').datagrid('getSelected');
	if (row) { 
		var dialog = parent.sy.modalDialog({
			title : '查看执法人员',
			width : 700,
			height : 500,
			url : basePath + '/zfba/zfrygl/pzfryFormIndex?op=view&userid=' + row.userid+'&zfryid='+row.zfryid,
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
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
					<tr> 
						<td style="text-align:right;"><nobr>手机号</nobr></td>
						<td><input id="mobile" name="mobile" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>执法领域</nobr></td>
						<td><input id="zfrylybm" name="zfrylybm" style="width: 200px" /></td>
						<td colspan="2"><a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search" onclick="query()">
								查 询 </a> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload"
							onclick="refresh()"> 重 置 </a></td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="执法人员列表">
				<div id="toolbar">
					<table>
						<tr> 
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_reZfry" iconCls="icon-edit" plain="true"
								onclick="updateZfry()">编辑</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_pzfryDTO" iconCls="ext-icon-report_magnify"
								plain="true" onclick="showZfry()">查看</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td> 
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
				
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>