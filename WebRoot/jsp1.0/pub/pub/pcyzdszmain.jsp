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
<title>法律法规</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);

var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;

$(function() {					
		$('#gridmain').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#maintoolbar',
			url: basePath + '/pub/pub/queryPcyzdszmain',     
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			onLoadSuccess:function(data){
					$(this).datagrid('clearSelections');
			},
			onClickRow:function(rowIndex,rowData){
				myquery(rowData);
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pcyzdszmainid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '主表ID',
				field : 'pcyzdszmainid',
				hidden : true
			},{
				width : '100',
				title : '表代码',
				field : 'tabname',
				hidden : true
			},{
				width : '200',
				title : '表名称',
				field : 'tabnamedesc',
				hidden : false
			},{
				width : '150',
				title : '列代码',
				field : 'colname',
				hidden : true
			},{
				width : '300',
				title : '列名称',
				field : 'colnamedesc',
				hidden : false
			}
			] ]
		});
		
		$('#griddetail').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: '',  		
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			onLoadSuccess:function(data){
					$(this).datagrid('clearSelections');
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pcyzdszdetailid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '明细表ID',
				field : 'pcyzdszdetailid',
				hidden : true
			},{
				width : '80',
				title : '大类',
				field : 'aae140',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_aae140,value);
				}				
			},{
				width : '600',
				title : '值',
				field : 'avalue',
				hidden : false
			}
			] ]
		});
});

	// 根据主表内容查询详细表内容
	function myquery(v_rowData) {
	    if (v_rowData){
			var param = {
				'pcyzdszmainid': v_rowData.pcyzdszmainid
			};
			$("#griddetail").datagrid({
				url : basePath + '/pub/pub/queryPcyzdszdetail',			
				queryParams : param
			});
			$("#griddetail").datagrid('clearSelections'); 	    	
	    }
	}
	
	// 新增主表内容 
	var addMain = function() {	
		var obj = new Object();
		var url='<%=basePath%>pub/pub/pcyzdszMainAddIndex';		
		var dialog = parent.sy.modalDialog({ 
			title : '添加',
			width : 800,
			height : 400, 
			url : url
		},function(dialogID){
			var k = sy.getWinRet(dialogID); 
				if (k != null && "ok" == k){
					$("#gridmain").datagrid("reload");
					sy.setWinRet("ok");
				}			
			sy.removeWinRet(dialogID);
		});
	};
	
	// 编辑
	function updateMain() {
		var row = $('#gridmain').datagrid('getSelected');
		if (row) {
			var obj = new Object();
			var url = '<%=basePath%>pub/pub/pcyzdszMainAddIndex';		
			var dialog = parent.sy.modalDialog({ 
				title : '编辑',
				width : 600,
				height : 300,
				param : {
					pcyzdszmainid : row.pcyzdszmainid
				},  
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if (k != null && "ok" == k){
						$("#gridmain").datagrid("reload");
						sy.setWinRet("ok");
					}
				sy.removeWinRet(dialogID);
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的信息！', 'info');
		}
	};	
	
	// 删除
	function delMain() {
		var row = $('#gridmain').datagrid('getSelected');
		if (row) {
			var v_pcyzdszmainid = row.pcyzdszmainid;

			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/pub/pub/delPcyzdszMain', {
						pcyzdszmainid: v_pcyzdszmainid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#gridmain').datagrid('reload'); 
								sy.setWinRet("ok");
			        		});    	
						} else {
							$.messager.alert('提示', '删除失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}
	
	// 新增
	var addDetail = function() {	
		var row = $('#gridmain').datagrid('getSelected');
		if (row){
			var obj=new Object();
			var url='<%=basePath%>pub/pub/pcyzdszAddIndex';		
			var dialog = parent.sy.modalDialog({ 
				title : ' ',
				width : 800,
				height : 400,
				param : {
					pcyzdszmainid : row.pcyzdszmainid
				},  
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if (k!=null && "ok"==k){
						$("#griddetail").datagrid("reload");
						sy.setWinRet("ok");
					}			
				sy.removeWinRet(dialogID);
			});
		}else{
			$.messager.alert('提示', '请先选择主表记录！', 'info');
		}
	};	
	
	// 编辑
	function updateDetail() {
		var row = $('#griddetail').datagrid('getSelected');
		if (row) {
			var obj=new Object();
			var url='<%=basePath%>pub/pub/pcyzdszAddIndex';		
			var dialog = parent.sy.modalDialog({ 
				title : ' ',
				width : 800,
				height : 400,
				param : {
					pcyzdszdetailid : row.pcyzdszdetailid
				},  
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if (k!=null && "ok"==k){
						$("#griddetail").datagrid("reload");
						sy.setWinRet("ok");
					}			
				sy.removeWinRet(dialogID);
			}); 
		}else{
			$.messager.alert('提示', '请先选择要修改的信息！', 'info');
		}
	};
	
	// 删除
	function delDetail() {
		var row = $('#griddetail').datagrid('getSelected');
		if (row) {
			var v_pcyzdszdetailid = row.pcyzdszdetailid;

			$.messager.confirm('警告', '您确定要删除该条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/pub/pub/delPcyzdsz', {
						pcyzdszdetailid: v_pcyzdszdetailid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#griddetail').datagrid('reload');
								sy.setWinRet("ok");
			        		});    	
						} else {
							$.messager.alert('提示', '删除失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 	

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="主表">
        		<div id="maintoolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcyzdszMainAdd"
								iconCls="icon-add" plain="true" onclick="addMain()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcyzdszMainEdit"
								iconCls="icon-edit" plain="true" onclick="updateMain()">编辑</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 														
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPcyzdszMain"
								iconCls="icon-remove" plain="true" onclick="delMain()">删除</a> 
							</td>																																														
						</tr>
					</table>
				</div> 
				<div id="gridmain" style="height:320px;overflow:auto;"></div>
	        </sicp3:groupbox>	
        	<sicp3:groupbox title="明细表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcyzdszAdd"
								iconCls="icon-add" plain="true" onclick="addDetail()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcyzdszEdit"
								iconCls="icon-edit" plain="true" onclick="updateDetail()">编辑</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 														
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcyzdszDelete"
								iconCls="icon-remove" plain="true" onclick="delDetail()">删除</a> 
							</td>																																														
						</tr>
					</table>
				</div>        	
				<div id="griddetail" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	
        </div>        
    </div>   
</body>
</html>