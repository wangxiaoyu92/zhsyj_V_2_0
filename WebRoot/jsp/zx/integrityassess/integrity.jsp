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
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<title>诚信评估</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
    
	var assess_level = '<%=SysmanageUtil.getAa10toJsonArray("ZXSYSJBMC") %>';
	assess_level = eval(assess_level);
	var cb_username;
	var cb_assess;
	var cb_bcname;
	var datagrid;
	$(function() {
		 cb_assess=$('#aaa102').combobox({
			data : assess_level,
			valueField : 'id',
			textField : 'text',
			required : false,
	        editable : false,
	        panelHeight : 'auto'
			});
		/**cb_username=$('#username').combobox({
			url:basePath + 'sysmanager/sysuser/querySysuser',
			valueField : 'userid',
			textField : 'username',
			required : false,
	        editable : false,
	        panelHeight : 'auto'
			});
		cb_bcname=$('#bcname').combobox({
			url : "zx/BusinessCode/queryBusinessCode",
			valueField : 'bcid',
			textField : 'bcname',
			required : false,
	        editable : false,
	        panelHeight : 'auto'
			});*/
		datagrid= $('#dg').datagrid({
			title : '诚信评估信息',
			url : basePath + 'zx/IntegrityAssess/queryIntegrityAssessInfo',
			fitColumns : true,
			singleSelect : true,
			striped : true,
			pagination : true,
			rownumbers : true,
			pageNumber : 1,
			pageSize : 10,
			pageList : [ 10, 20, 30],
			idField : 'iaid',
			sortOrder : 'asc',
			columns : [ [ {
				field : 'spyear',
				title : '年份',
				width : 100
			},
			  {
				field : 'iaaccessdate',
				title : '审核日期',
				width : 100,
			},{
				field : 'commc',
				title : '企业名称',
				width : 100,
			}, {
				field : 'iascore',
				title : '成绩',
				width : 100,
			}, {
				field : 'aaa103',
				title : '诚信等级',
				width : 100,
			}, {
				field : 'bcname',
				title : '名称',
				width : 100,
			}, {
				field : 'username',
				title : '办理人',
				width : 100,
			} ] ]
		});
	});
	
	//查询
	function query() {
		var param = {
			'username': $('#username').val(),
			'aaa102': $('#aaa102').combobox('getValue'),
			'commc': $('#commc').val()
		};
		datagrid.datagrid({
			url : basePath + 'zx/IntegrityAssess/queryIntegrityAssessInfo',			
			queryParams : param
		}); 
		datagrid.datagrid('clearSelections');
	}
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	//添加界面显示
	function addSysuser(){
		$('#dlg').dialog('open').dialog('setTitle', '新增评估信息');
		$('#fm').form('clear');
		cb_assess=$('#spzxgrade').combobox({
			data : assess_level,
			valueField : 'id',
			textField : 'text',
			required : false,
	        editable : false,
	        panelHeight : 'auto'
			});
	}
	/**
	function saveSysuser() {
		$('#fm').form('submit',{
			url: basePath + 'sysmanager/sysuser/saveSysuser',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#dlg').dialog('close');
						$('#grid').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	} 
	*/
	//添加信息
	function saveSysuser() {
		$('#fm').form('submit',{
			url: basePath + 'zx/IntegrityAssess/savaIntegrity',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#dlg').dialog('close');
						$('#dg').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:left;"><nobr>办理人</nobr>
						</td>
						<td><input id="username" name="username" 
							style="width: 200px" />
						</td>
						<td style="text-align:left;"><nobr>诚信等级</nobr>
						</td>
						<td><input id="aaa102" class="easyui-combobox" name="aaa102"
							style="width: 200px" />
						</td>
					</tr>
					<tr>
						<td style="text-align:left;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" /></td>
						<td colspan="2"><a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search" onclick="query()">
								查 询 </a> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload"
							onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="评估列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_addSysuser" iconCls="icon-add" plain="true"
								onclick="addSysuser()">增加</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_updateSysuser" iconCls="icon-edit" plain="true"
								onclick="updateSysuser()">编辑</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_delSysuser" iconCls="icon-remove" plain="true"
								onclick="delSysuser()">删除</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="dg" style="height:350px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:800px;height:450px;padding:10px 10px;"
		closed="true" closeable="true" buttons="#dlg-buttons" modal="true">
		<form id="fm" method="post">
        	<sicp3:groupbox title="评估信息">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>年份:</nobr></td>
						<td><input id="spyear1" name="spyear" style="width: 200px;" class="easyui-datebox" required="required" 
							class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>						
						<td style="text-align:right;"><nobr>评估日期:</nobr></td>
						<td><input id="iaaccessdate" name="iaaccessdate" style="width: 200px" class="easyui-datebox" required="required" 
							class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>成绩:</nobr></td>
						<td><input id="iascore1" name="iascore" style="width: 200px" 
							class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>
						<td style="text-align:right;"><nobr>录入人员:</nobr></td>
						<td><input id="userid" name="userid" style="width: 200px" /></td>								
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>诚信等级:</nobr></td>
						<td><input id="spzxgrade" name="spzxgrade" style="width: 200px"  /></td>						
						<td style="text-align:right;"><nobr>参数名称:</nobr></td>
						<td><input id="bccode" name="bccode" style="width: 200px" /></td>			
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>IP地址:</nobr></td>
						<td><input id="logid" name="logid" style="width: 200px"  /></td>						
						<td style="text-align:right;"><nobr>企业ID:</nobr></td>
						<td><input id="comid" name="comid" style="width: 200px" /></td>			
					</tr>
				</table>
	        </sicp3:groupbox>
	   </form>
	   <div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveSysuser()">确定</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
	</div>


</body>
</html>