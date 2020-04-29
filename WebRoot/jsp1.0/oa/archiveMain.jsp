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
			url: basePath + '/egovernment/archive/queryArchive',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'archiveid', //该列是一个唯一列
		    sortOrder: 'asc',
			onClickRow:function(rowIndex, rowData){
				if (rowData.slbz==null || rowData.slbz==""|| rowData.slbz.length==0||rowData.slbz=="1"){
					//$("#btn_editArchive").linkbutton('disable');
					//$("#btn_delArchive").linkbutton('disable');
					//$("#btn_shouliArchive").linkbutton('disable');
					//$("#btn_shoulirizhiArchive").linkbutton('disable');

				}else{
					//$("#btn_editArchive").linkbutton('enable');
					//$("#btn_delArchive").linkbutton('enable');
					//$("#btn_shouliArchive").linkbutton('enable');
					//$("#btn_shoulirizhiArchive").linkbutton('enable');
				}
				if(rowData.archivestate==1){
					//$("#btn_editArchive").linkbutton('disable');
				}else{
					//$("#btn_editArchive").linkbutton('enable');
					//$("#btn_delArchive").linkbutton('enable');
				}
			},
			columns : [ [ 
		        {
					width : '100',
					title : 'ID',
					field : 'archiveid',
					hidden : true
				},{
					width : '100',
					title : '公文编码',
					field : 'archivecode',
					hidden : false
				},{
					width : '350',
					title : '公文标题',
					field : 'archivetitle',
					hidden : false
				},{
					width : '200',
					title : '公文关键字',
					field : 'archivekey',
					hidden : true
				},{
					width : '200',
					title : '公文正文',
					field : 'archivecontent',
					hidden : true
				},{
					width : '200',
					title : '备注',
					field : 'archiveremark',
					hidden : false
				} ,{
					width : '120',
					title : '操作人',
					field : 'archiveopperuser',
					hidden : false
				} ,{
					width : '140',
					title : '操作时间',
					field : 'archiveopperdate',
					hidden : false
				} 
			] ]
		});


});
	//删除
	function  delArchive() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该文档吗?',function(r) {
				if (r) {
					$.post(basePath + '/egovernment/archive/delArchive', {
						archiveid: row.archiveid
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
	//新增
	function addArchive(){
		var url='<%=basePath%>egovernment/archive/archiveFormIndex';
		var dialog = parent.sy.modalDialog({
		title : '新建公文',
		width : 950,
		height : 580,
		url : url,
		buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if (obj!=null && "ok"==obj){
			$("#mygrid").datagrid("reload");
		}
		})
	
	} 
	// 编辑
	function updateArchive() {
		var url='<%=basePath%>egovernment/archive/archiveFormIndex';
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
			title : '编辑信息',
				param : {
					archiveid :row.archiveid
				},
				width : 950,
				height : 580,
				url : url,
					buttons : [{
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			}, {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if (obj!=null && "ok"==obj){
				$("#mygrid").datagrid("reload");
				}
			})
		}else{
			$.messager.alert('提示', '请先选择要修改的文档！', 'info');
		}
	} 
	// 查看
	function showArchive() {
		var url='<%=basePath%>egovernment/archive/archiveFormIndex';
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				param : {
					op : "view",
					archiveid :row.archiveid
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
	//根据参数查询
	function query() {
		var param = {
			'archivetitle': $('#archivetitle').val(),
			'archiveopperuser': $('#archiveopperuser').val()
		};
		mygrid.datagrid({
			url : basePath + '/egovernment/archive/queryArchive',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections'); 
	}
	// 刷新
	function refresh(){
		parent.window.refresh();	
	}

	//开始受理
	function kaishishouli(){
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_archiveid=row.archiveid;
			var v_comdm="11";
			var v_commc="汤阴";

			var cfmMsg= "确定要受理申请编号为【"+v_archiveid+"】的记录吗?";

			var v_yewumcpym="gwgllc";
			var v_transval="";
			var v_yewutablename="egarchiveinfo";
			var v_yewucolname="archiveid";

			var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?"+
					"ywbh="+v_archiveid+
					"&comdm="+v_comdm+
					"&commc="+v_commc+
					"&yewumcpym="+v_yewumcpym+
					"&transval="+v_transval+
					"&yewutablename="+v_yewutablename+
					"&yewucolname="+v_yewucolname+
					"&time="+new Date().getMilliseconds()));

			$.messager.confirm('确认', cfmMsg, function (r) {
				if(r){
					parent.$.messager.progress({
						text : '开始受理....'
					});
					$.ajax({
						url:v_url,
						type:'post',
						async:true,
						cache:false,
						timeout: 100000,
						//data:formData,
						error:function(){
							parent.$.messager.progress('close');
							alert("服务器繁忙，请稍后再试！");
						},
						success: function(result){
							result = $.parseJSON(result);
							if (result.code=='0'){
								$("#mygrid").datagrid('reload');
								parent.$.messager.progress('close');
								parent.$.messager.alert('提示','受理成功！','info',function(){
								});
							} else {
								parent.$.messager.progress('close');
								parent.$.messager.alert('提示','受理失败：'+result.msg,'error');
							}
						}

					});
				}
			})

		}else{
			$.messager.alert('提示', '请先选择要删除的案件登记记录！', 'info');
		}
	}

	//受理日志
	function shoulirizhi(){
		var row = $('#mygrid').datagrid('getSelected');
		var url=basePath+'workflow/wfywlclogIndex';
		if (row) {
			var dialog = parent.sy.modalDialog({
				title:'受理日志',
				param : {
				ywbh:row.archiveid,
				time :new Date().getMilliseconds()
				},
				width:1200,
				height:600,
				url:url,
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){ //传递回的type为ok的时候才刷新页面。
				//window.location.reload();
				//shuaxindata();
				}
			})
		}else{
			$.messager.alert('提示', '请先选择要操作的公文记录！', 'info');
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
							<td><input id="archivetitle" name="archivetitle"
								style="width: 200px" /></td>
							<td style="text-align:right;"><nobr>操作员</nobr>
							</td>
							<td><input id="archiveopperuser" name="archiveopperuser"
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
									data="btn_addArchive" iconCls="icon-add" plain="true"
									onclick="addArchive()">增加</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									data="btn_archiveFormIndex" iconCls="icon-edit" plain="true"
									onclick="updateArchive()" id="btn_editArchive">编辑</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_delArchive" name="btn_delArchive" data="btn_delArchive"
									iconCls="icon-remove" plain="true" onclick="delArchive()">删除</a></td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton"
									id="btn_archiveFormIndex" name="btn_archiveFormIndex" data="btn_archiveFormIndex"
									iconCls="ext-icon-application_form_magnify" plain="true" onclick="showArchive()">查看</a></td>
								<td>
								<td>
									<div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_shouliAjdj" id="btn_shouliArchive" name="btn_shouliArchive"
									   iconCls="icon-ok" plain="true" onclick="kaishishouli()">受理</a>
								</td>
								<td>
									<div class="datagrid-btn-separator"></div>
								</td>
								<td><a href="javascript:void(0)"  class="easyui-linkbutton" data="btn_shoulirizhiAjdj"
									   id="btn_shoulirizhiArchive"
									   iconCls="ext-icon-overlays" plain="true" onclick="shoulirizhi()">受理日志</a>
								</td>
								<td>
									<div class="datagrid-btn-separator"></div>
								</td>
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
