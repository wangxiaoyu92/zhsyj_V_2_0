<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_aaa100 = StringHelper.showNull2Empty(request.getParameter("aaa100"));  //参数类别代码
	v_aaa100=v_aaa100.toUpperCase();
	
	Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
	String v_userid = vSysUser.getUserid();		
%>
<!DOCTYPE html>
<html>
<head>
<title>系统参数管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表  
	var grid;
	var v_retobj=false;
	var v_b_userid='<%=v_userid%>';
	
	$(function() {	
		window.onbeforeunload = function(){  
		    sy.setWinRet(v_retobj);
		};  
		
		grid = $('#grid').datagrid({
			//title: '系统参数列表',
			//iconCls: 'icon-tip',
			//toolbar: '#toolbar',
			url: basePath + '/sysmanager/sysparam/queryAa10?aaa100=<%=v_aaa100%>',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'aaz093', //该列是一个唯一列
		    sortOrder: '',
			columns : [[{
				width : '100',
				title : 'aa10主键',
				field : 'aaz093',
				hidden : true
			},{
				width : '200',
				title : '参数代码',
				field : 'aaa100',				
				hidden : true
			},{
				width : '200',
				title : '代码值',
				field : 'aaa102',
				hidden : false,
				editor : 'textarea'
			},{
				width : '200',
				title : '代码名称',
				field : 'aaa103',
				hidden : false,
				editor : 'textarea'
			},{
				width : '400',
				title : '开始日期',
				field : 'aae030',
				hidden : true
			},{
				width : '100',
				title : '终止日期',
				field : 'aae031',
				hidden : true
			},{
				width : '40',
				title : 'aa10表主键',
				field : 'aaz094',
				hidden : true
			},{
				width : '40',
				title : 'aaa104',
				field : 'aaa104',
				hidden : true
			},{
				width : '40',
				title : 'aaa101',
				field : 'aaa101',
				hidden : true
			},{
				width : '40',
				title : 'aaa105',
				field : 'aaa105',
				hidden : true
			},{
				width : '40',
				title : 'aaa106',
				field : 'aaa106',
				hidden : true
			},{
				width : '40',
				title : 'aaa107',
				field : 'aaa107',
				hidden : true
			},{
				width : '120',
				title : '经办人',
				field : 'aae011',
				hidden : false
			},{
				width : '130',
				title : '经办时间',
				field : 'aae036',
				hidden : false
			} ] ],
			onDblClickRow:function(){//双击修改	
		        var v_row = grid.datagrid('getSelected');
		    	if (shiFouWeiKong(v_row.aae011) || v_b_userid!=v_row.aae011){
		    		alert('不是自己增加的，不能修改');
		    	}else{
					mydatagrid_edit(grid);
					mydatagrid_exceptEndEditing(grid);			    		
		    	}	
		    },
		  	//工具栏
		    toolbar: [{
		    	id:'btn_addAa10',
		    	iconCls: 'icon-add',
		    	text: '增加',
		    	handler: function() {
		    		mydatagrid_append(grid);
		    	}
		    },
		    '-', {
		    	id:'btn_updateAa10',
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {	
		    		var row = grid.datagrid('getSelected');
			    	if (shiFouWeiKong(row.aae011) || v_b_userid!=row.aae011){
			    		alert('不是自己增加的，不能修改');
			    	}else{
			    		mydatagrid_edit(grid);	
			    	}		    		
		    	}
		    },
		    '-', {
		    	id:'btn_delAa10',
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
			    	var row = grid.datagrid('getSelected');
			    	if (shiFouWeiKong(row.aae011) || v_b_userid!=row.aae011){
			    		alert('不是自己增加的，不能删除');
			    	}else{
			    		if(row.aaz093=='' || row.aaz093==null){
			    			mydatagrid_remove(grid);
			    		}else{
			    			delAa10();
			    		}			    		
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
		    	id:'btn_addAa10',
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		if(mydatagrid_endEditing(grid)){
		    			updateAa10();
		    		}
		    	}
		    },'-', {
		    	id:'btn_refreshAa10Map',
		    	iconCls: 'icon-modify',
		    	text: '重新获取系统代码',
		    	handler: function() {
		    		if(mydatagrid_endEditing(grid)){
		    			refreshAa10Map();
		    		}
		    	}
		    }]		    		 
		});
	});

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 	

	function refreshAa10Map(){
		parent.$.messager.progress({
			text : '数据加载中....'			
		});
		$.post(basePath + 'sysmanager/sysparam/refreshAa10Map', {
			aaa100:'<%=v_aaa100%>'
		}, 
		function(result) {
			if (result.code=='0') {
				v_retobj=true;
				alert('重新获取系统代码 成功');
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
		}, 'json');		
	}
	
	// 提交保存
	var updateAa10 = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var url;
			var aaz093 = row.aaz093;
			if (shiFouWeiKong(aaz093)){
				url = basePath + '/sysmanager/sysparam/addAa10';
			}else{
				url = basePath + '/sysmanager/sysparam/updateAa10';		
			}
			$.messager.progress();	// 显示进度条
			$.post(url, {
				aaz093 : row.aaz093,
				aaa100 : '<%=v_aaa100%>',
				aaa102 : row.aaa102,
				aaa103 : row.aaa103,
				aae030 : row.aae030,
				aae031 : row.aae031,
				aaz094 : row.aaz094,
				aaa104 : row.aaa104,
				aaa101 : row.aaa101,
				aaa105 : row.aaa105,
				aaa106 : row.aaa106,
				aaa107 : row.aaa107,
				aae011 : row.aae011,
				aae036 : row.aae036
			}, function(result) {
				if (result.code == '0') {						        	
					$.messager.alert('提示', '操作成功', 'info',function(){									
						grid.datagrid('reload');
						//v_retobj=true;
						//window.returnValue=v_retobj;
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
	var delAa10 = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + '/sysmanager/sysparam/delAa10', {
						aaz093: row.aaz093
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示',"删除成功！",'info',function(){
								grid.datagrid('reload'); 
								//v_retobj=true;
								//window.returnValue=v_retobj;								
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
        <div region="center" style="overflow: true;" >
        	<sicp3:groupbox title="参数代码列表">
				<div id="grid" style="height:400px;width:860px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>