<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>企业申请溯源码</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
// 产品种类
var v_prozl = <%=SysmanageUtil.getAa10toJsonArray("PROZL")%>;
// 生产单位代码
var v_scdwdm = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>;

	$(function() { 
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url : basePath + '/spsy/spproduct/queryComProductsPc',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'cppcid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '产品批次ID',
				field : 'cppcid',
				hidden : true
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '150',
				title : '商品名称',
				field : 'proname',
				hidden : false
			},{
				width : '100',
				title : '商品类型',
				field : 'prozl',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_prozl,value);
				}
			},{
				width : '100',
				title : '商品批次',
				field : 'cppcpch',
				hidden : false
			},{
				width : '150',
				title : '生产日期',
				field : 'cppcscrq',
				hidden : false
			},{
				width : '80',
				title : '生产数量',
				field : 'cppcscsl',
				hidden : false
			},{
				width : '80',
				title : '单位名称',
				field : 'cppcscdwdm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_scdwdm,value);
				}
			},{
				width : '100',
				title : '溯源码是否已生成',
				field : 'cppcsymscbz',
				hidden : false,
				formatter : function(value, row) {
					if (value == '1'){
						return "<span style='color:blue;'>已生成</span>";
					} else if (value == '0') {
						return "<span style='color:red;'>未生成</span>";
					}
				}
			},{
				width:100,
				title:'操作',
				field:'opt',
				align:'center',
	            formatter:function(value,rec){ 
	                  return '<span style="color:blue" mce_style="color:blue"><a href="javascript:deletesym(\''+rec.cppcsymscbz+'\',\''+rec.cppcid+'\');" mce_href="#" data="btn_deletesym"><img src="<%=basePath%>images/pub/no2.png" align="absmiddle">删除溯源码</a></span>';
	             }   
	        }
			] ]
		});
	}); 
	// 删除溯源码
	function deletesym(prm_cppcsymscbz,prm_cppcid) {
		if (prm_cppcsymscbz==null || prm_cppcsymscbz!='1'){
			alert("还未生成溯源码，不能删除");
			return;
		};

		$.messager.confirm('警告', '您确定要删除该记录吗?',function(r) {
			if (r) {
				$.post(basePath + '/spsy/spproduct/deletesym', {
					cppcid: prm_cppcid
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
	}; 
	
	// 查询
	function query() {
		var param = {
			'proname': $('#proname').val(),
			'cppcpch':$('#cppcpch').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/spproduct/queryComProductsPc',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');  
	}
	function refresh(){
		parent.window.refresh();	
	} 
	// 申请溯源码
	function applySym() {		
		var row = $('#mygrid').datagrid('getSelected');
		if (!row) {
			alert("请选择产品批次！");
			return;
		}
		if (row.cppcsymscbz == '1') {
			alert("已生成溯源码，请重新选择！");
			return;
		}
		var v_cppcid = row.cppcid; // 产品批次id
		var url = basePath + 'spsy/spproduct/applySymFromIndex';
		var dialog = parent.sy.modalDialog({
				title : '申请溯源码',
				param : {
					cppcid : v_cppcid
				},
				width : 450,
				height : 300,
				url : url
		}, closeModalDialogCallback);
	}
	
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$("#mygrid").datagrid('reload'); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	// 查看溯源码
	function showSym(){
		var row = $('#mygrid').datagrid('getSelected');
		if (row.cppcsymscbz == '0') {
			alert("该批次产品还未申请溯源码，还不能查看！！！");
			return;
		}
		var pcid = row.cppcid;
		var url = basePath + 'spsy/spproduct/showSymIndex';
		var dialog = parent.sy.modalDialog({
				title : '查看溯源码',
				param : {
					cppcid : pcid
				},
				width : 920,
				height : 520,
				url : url
		});
	}
	
	
	//导出excel
	var exportToExcel = function(filename){	
		var row = $('#mygrid').datagrid('getSelected');
		if (row.cppcsymscbz == '0') {
			alert("该批次产品还未申请溯源码，还不能导出！！！");
			return;
		}		
		
		$('#fm').form('submit',{  
	    	url : basePath + '/spsy/spproduct/exportExcel?cppcid=' + row.cppcid,   
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	//	
	        }  
	    });		  
	}; 
	
	// 导出溯源码到excel表格
	function exportExcel(){
		var row = $('#mygrid').datagrid('getSelected');
		if (row.cppcsymscbz == '0') {
			alert("该批次产品还未申请溯源码，还不能导出！！！");
			return;
		}
		$.post(basePath + '/spsy/spproduct/exportExcel', {
			cppcid: row.cppcid
		},
		function(result) {
			//if (result.code == '0') {
			//	$.messager.alert('提示','导出成功！','info');    	
			//} else {
			//	$.messager.alert('提示', "导出失败：" + result.msg, 'error');
			//}
		},
		'json');
	}
</script>
</head>
<body>
	<form id="fm" method="post" enctype="multipart/form-data">	  
	</form>
	
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        <sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>商品名称</nobr></td>
					<td><input id="proname" name="proname" style="width: 200px" /></td>
					<td style="text-align:right;"><nobr>商品批次</nobr></td>
					<td><input id="cppcpch" name="cppcpch" style="width: 200px" /></td>
				</tr>
				<tr>
					<td style="text-align:center;" colspan="4">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>
				</tr>
			</table>
        </sicp3:groupbox>
        <sicp3:groupbox title="产品批次信息">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td>  
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_applySym"
								iconCls="ext-icon-add" plain="true" onclick="applySym()">申请溯源码</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showSym"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showSym()">查看溯源码</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_exportExcel"
								iconCls="icon-excel" plain="true" onclick="exportToExcel()">导出溯源码</a> 
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
	</div> 
</body>
</html>