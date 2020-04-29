<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

%>
<%
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	System.out.println("v_comid zzzm "+v_comid);
%>
<!DOCTYPE html>
<html>
<head>
	<title>企业信息</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">

		// 资质证明
		var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;

		var cb_comzzzm; // 资质证明
		var grid;
		$(function() {
			grid = $('#grid').datagrid({
				//title: '企业信息列表',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				url: basePath + 'pcompany/queryPcompanyXkzDTO',
				queryParams : {'comid' : '<%=v_comid%>'}, // 企业范围内
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度
				idField: 'comxkzid', //该列是一个唯一列
				sortOrder: '',
				columns : [ [ {
					width : '200',
					title : '企业许可信息ID',
					field : 'comxkzid',
					hidden : true
				},{
					width : '60',
					title : '企业id',
					field : 'comid',
					hidden : true
				},{
					width : '120',
					title : '资质证明类型',
					field : 'comxkzlx',
					hidden : false,
					formatter:function(value,row){
						return sy.formatGridCode(comzzzm,value);
					}
				},{
					width : '140',
					title : '编号(注册号)',
					field : 'comxkzbh',
					hidden : false
				},{
					width : '120',
					title : '有效期起',
					field : 'comxkyxqq',
					hidden : false
				},{
					width : '120',
					title : '有效期止',
					field : 'comxkyxqz',
					hidden : false
				},{
					width : '200',
					title : '许可范围(经营范围)',
					field : 'comxkfw',
					hidden : true
				},{
					width : '100',
					title : '主体业态',
					field : 'comxkzztyt',
					hidden : true
				},{
					width : '100',
					title : '经营场所',
					field : 'comxkzjycs',
					hidden : false
				},{
					width : '150',
					title : '组成形式',
					field : 'comxkzzcxs',
					hidden : false
				}
				]]
			});

			if('<%=op%>' == 'view'){
				$("#mytab tr td[name='btntd']").hide();
			}

		});/////////////////////////////////////////

		// 关闭窗口
		var closeWindow = function($dialog, $pjq){
			$dialog.dialog('destroy');
		};

		// 新增
		function addZzzm() {
			var dialog = parent.sy.modalDialog({
				title : '新增',
				width : 600,
				height : 600,
				url : basePath + '/pcompany/pcomZzzmFormIndex?op=add&comid=<%=v_comid%>',
				buttons : [{
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}

		// 编辑
		function editZzzm() {
			var row = $('#grid').datagrid('getSelected');
			if(row){
				var v_comid=row.comid;
				var v_comxkzid=row.comxkzid;

				var dialog = parent.sy.modalDialog({
					title : '编辑',
					width : 600,
					height : 600,
					url : basePath + '/pcompany/pcomZzzmFormIndex?op=edit&comid='+v_comid+'&comxkzid='+v_comxkzid,
					buttons : [{
						text : '确定',
						handler : function() {
							dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
						}
					},{
						text : '关闭',
						handler : function() {
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
						}
					} ]
				});

			}else{
				$.messager.alert('提示','请先选择要修改的资质证明信息！','info');
			}
		}

		// 查看
		function viewZzzm() {
			var row = $('#grid').datagrid('getSelected');
			if(row){
				var v_comid=row.comid;
				var v_comxkzid=row.comxkzid;

				var dialog = parent.sy.modalDialog({
					title : '查看',
					width : 600,
					height : 600,
					url : basePath + '/pcompany/pcomZzzmFormIndex?op=view&comid='+v_comid+'&comxkzid='+v_comxkzid,
					buttons : [{
						text : '关闭',
						handler : function() {
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
						}
					} ]
				});

			}else{
				$.messager.alert('提示','请先选择要查看的资质证明信息！','info');
			}
		}

		// 删除
		function delZzzm() {
			var row = $('#grid').datagrid('getSelected');
			if (row) {
				var comxkzid = row.comxkzid;
				$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
					if (r) {
						$.post(basePath + 'pcompany/delPcompanyXkzDTO',
								{comxkzid: comxkzid},
								function(result){
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
				$.messager.alert('提示', '请先选择要删除的资质证明记录！', 'info');
			}
		}

	</script>
</head>

<body>
<div id="grid" style="height:350px;overflow:auto;"></div>
<div id="toolbar">
	<table id="mytab">
		<tr>
			<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_savePcompany"
								iconCls="icon-add" plain="true" onclick="addZzzm()">增加</a>
			</td>
			<td name="btntd">
				<div class="datagrid-btn-separator"></div>
			</td>
			<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
								iconCls="icon-edit" plain="true" onclick="editZzzm()">编辑</a>
			</td>
			<td name="btntd">
				<div class="datagrid-btn-separator"></div>
			</td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
				   iconCls="icon-edit" plain="true" onclick="viewZzzm()">查看</a>
			</td>
			<td name="btntd">
				<div class="datagrid-btn-separator"></div>
			</td>
			<td name="btntd"><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysuser"
								iconCls="icon-remove" plain="true" onclick="delZzzm()">删除</a>
			</td>
		</tr>
	</table>
</div>
</body>
</html>