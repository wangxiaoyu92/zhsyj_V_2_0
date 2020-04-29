<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
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
<title>法律法规信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	var v_ajdjajdl = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
	
	$(function() {
		//cbo绑定ajdjajdl
		v_ajdjajdl = $('#ajdjajdl').combobox({
			data : v_ajdjajdl,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});

		//绑定grid内容
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/zfba/wfxw/queryWfxw',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ajdjid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [
	        {
				width : '100',
				title : '违法行为参数ID',
				field : 'pwfxwcsid',
				hidden : true
			},{
				width : '100',
				title : '违法行为编号',
				field : 'wfxwbh',
				hidden : false
			},{
				width : '300',
				title : '违法行为描述',
				field : 'wfxwms',
				hidden : false
			},{
				width: '150',
				title: '违反法规',
				field: 'wfxwwffg',
				hidden:false
			},{
				width: '100',
				title: '触犯法规',
				field: 'wfxwcffg',
				hidden:false
			},{
				width: '200',
				title: '触犯法规条款',
				field: 'wfxwcffgtk',
				hidden:false
			},{
				width: '150',
				title: '备注',
				field: 'wfxwbz',
				hidden:false
			}
			] ]
		});
	
	});////////////////
	
	function unselectgrid(){
		$('#mygrid').datagrid('clearSelections');
	}
				
	//新增
	var addWfxw = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增违法行为',
			width : 870,
			height : 650,
			url : basePath + 'zfba/wfxw/wfxwFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog,mygrid,parent.$);
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
		unselectgrid();
	};
	
	
	// 编辑
	function updateWfxw() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '修改违法行为',
				width : 870,
				height : 650,
				url : basePath + '/zfba/wfxw/wfxwFormIndex?pwfxwcsid=' + row.pwfxwcsid,
				buttons : [ {
					text : '修改',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
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
			$.messager.alert('提示', '请先选择要修改的案件登记信息！', 'info');
		};
		unselectgrid();
	};
	
	// 查看
	function showWfxw() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看案件登记',
				width : 870,
				height : 650,
				url : basePath+'/zfba/wfxw/wfxwFormIndex?op=view&pwfxwcsid='+row.pwfxwcsid,
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
			$.messager.alert('提示', '请先选择要查看的违法行为信息！', 'info');
		};
		unselectgrid();
	};
	
	// 删除
	function delWfxw() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_pwfxwcsid = row.pwfxwcsid;

			$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
				if (r) {
					$.post(basePath + '/zfba/wfxw/delWfxw', {
						pwfxwcsid: v_pwfxwcsid
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
			$.messager.alert('提示', '请先选择要删除的案件登记记录！', 'info');
		};
		unselectgrid();
	} 
	//查询
	function query() {
		var param = {
			'wfxwbh': $('#wfxwbh').val(),
			'ajdjajdl':$('#ajdjajdl').combobox('getValue') 
		};
		mygrid.datagrid({
			url : basePath + '/zfba/wfxw/queryWfxw',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections');
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>违法编号：</nobr></td>
						<td><input id="wfxwbh" name="wfxwbh" style="width:200px" /></td>
						<td style="text-align:right;"><nobr>案件大类：</nobr></td>
						<td><input id="ajdjajdl" name="ajdjajdl" style="width: 200px" class="easyui-validatebox"/>
						
						<td style="text-align:left;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>	
					</tr>
<!-- 					<tr>
						<td style="text-align:right;"><nobr>受理标志</nobr></td>
						<td><input id="slbz" name="slbz" style="width: 200px" /></td>
																		
					</tr> -->
																		
					
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="案件登记列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_wfxwglAdd" iconCls="icon-add" plain="true"
								onclick="addWfxw()">增加</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_wfxwglEdit" iconCls="icon-edit" plain="true"
								onclick="updateWfxw()">编辑</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_wfxwglView" iconCls="ext-icon-report_magnify"
								plain="true" onclick="showWfxw()">查看</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_wfxwglDelete" iconCls="icon-remove" plain="true"
								onclick="delWfxw()">删除</a></td>
							<td>
								<div class="datagrid-btn-separator"></div>
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