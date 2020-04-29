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
<title>系统参数管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表  
	var grid;
	
	$(function() {	    
		grid = $('#grid').datagrid({
			//title: '系统参数列表',
			//iconCls: 'icon-tip',
			//toolbar: '#toolbar',
			url: basePath + '/sysmanager/sysparam/queryAa01',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'aaz499', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '参数ID',
				field : 'aaz499',
				hidden : true
			},{
				width : '200',
				title : '参数代码',
				field : 'aaa001',				
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : true
					}
				}
			},{
				width : '200',
				title : '参数名称',
				field : 'aaa002',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : true
					}
				}
			}]],				
			columns : [ [ {
				width : '400',
				title : '参数值',
				field : 'aaa005',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : false
					}
				}
			},{
				width : '400',
				title : '参数值域说明',
				field : 'aaa105',
				hidden : false,
				editor : {
					type : 'text',
					options : {
						required : false
					}
				}
			},{
				width : '100',
				title : '代码可维护标志',
				field : 'aaa104',
				hidden : true
			} ] ],
			onDblClickRow:function(){//双击修改				
		        var selected = grid.datagrid('getSelected');
				if(selected){
					mydatagrid_edit(grid);
					mydatagrid_exceptEndEditing(grid);
				}				
		    },
		  	//工具栏
		    toolbar: [{
		    	iconCls: 'icon-add',
		    	text: '增加',
		    	handler: function() {
		    		mydatagrid_append(grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {
		    		mydatagrid_edit(grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
			    	var row = grid.datagrid('getSelected');
		    		if(row.aaz499=='' || row.aaz499==null){
		    			mydatagrid_remove(grid);
		    		}else{
		    			delAa01();
		    		}
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-undo',
		    	text: '取消',
		    	handler: function() {
		    		mydatagrid_reject(grid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		if(mydatagrid_endEditing(grid)){
		    			updateAa01();
		    		}
		    	}
		    }]		    		 
		});
	});

	// 查询
	function query() {
		var aaa001 = $('#aaa001').val();
		var aaa002= $('#aaa002').val();
		var param = {
			'aaa001': aaa001,
			'aaa002':aaa002 
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 	

	// 提交保存
	var updateAa01 = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var url;
			var aaz499 = row.aaz499;
			if (aaz499=='undefined' || aaz499==null){
				url = basePath + '/sysmanager/sysparam/addAa01';
			}else{
				url = basePath + '/sysmanager/sysparam/updateAa01';		
			}
 
			$.messager.progress();	// 显示进度条
			$.post(url, {
				aaz499 : row.aaz499,
				aaa001 : row.aaa001,
				aaa002 : row.aaa002,
				aaa005 : row.aaa005,
				aaa105 : row.aaa105,
				aaa104 : '1'
			}, function(result) {
				if (result.code == '0') {						        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						query();
					});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '请选择要操作的记录！', 'info');
		}
	};
	
	// 删除
	var delAa01 = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/sysmanager/sysparam/delAa01', {
						aaz499: row.aaz499
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示',"删除成功！",'info',function(){
								grid.datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	};	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>参数代码</nobr></td>
						<td><input id="aaa001" name="aaa001" style="width: 200px"/></td>
						<td style="text-align:center;"><nobr>参数名称</nobr></td>
						<td><input id="aaa002" name="aaa002" style="width: 200px"></td>										
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
        	<sicp3:groupbox title="系统参数列表">
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>