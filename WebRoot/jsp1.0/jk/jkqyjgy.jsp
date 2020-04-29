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
<title>监控企业监管员管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var ishavejgy = [{"id":"","text":"==请选择=="},{"id":"0","text":"否"},{"id":"1","text":"是"}];
var v_ishavejgy;
// 是否指派监管员
	var grid;
	$(function() {
	
		v_ishavejgy = $('#ishavejgy').combobox({
	    	data : ishavejgy,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
	    
		grid = $('#grid').datagrid({
			toolbar : '#toolbar',
			url : basePath + 'jk/jkgl/queryJkqy',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jkqybh', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '200',
				title : '监控企业ID',
				field : 'jkqybh',
				hidden : false
			},{
				width : '200',
				title : '监控企业名称',
				field : 'jkqymc',
				hidden : false
			},{
				width : '250',
				title : '监控企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '250',
				title : '监管人',
				field : 'ishavejgy',
				hidden : false,
				formatter:function(value,rec){
				 	if(value == "0")
				 		return '<span style=color:red>暂未指派监管人</span>';
				 	else
				 		return '<span style=color:green>已指派监管人</span>';
				}
			}]]
		});
	});

	// 查询
	function query() {
		var jkqybh = $('#jkqybh').val(); // 监控企业编号
		var jkqymc = $('#jkqymc').val(); // 监控企业名称
		var aaa027 = $('#aaa027').val(); // 监控企业统筹区
		var ishavejgy = $('#ishavejgy').combobox('getValue'); // 监控企业统筹区
		var param = {
			'jkqybh' : jkqybh,
			'jkqymc' : jkqymc,
			'aaa027' : aaa027,
			'ishavejgy' : ishavejgy
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

// 指派负责人
	var addFzrJgy = function() {
		var row = grid.datagrid('getSelected');
		var url="<%=basePath%>jsp/jk/jkqyfzr.jsp";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '指派负责人',
				param : {
				comid : row.jkqybh,
				a:new Date().getMilliseconds()
				},
				width : 800,
				height : 500,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(typeof(obj.type) != "undefined" && obj.type != null && obj.type == 'ok'){
				grid.datagrid('reload');
			}
			sy.removeWinRet(dialogID);//不可缺少
			})
    	} else {
			$.messager.alert('提示', '请先选择相应的监管企业！', 'info');
		}
	};

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		var dialog = parent.sy.modalDialog({
			title : '监控',
			width : 300,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#aaa027').val(obj.aaa027);
			$('#aaa027name').val(obj.aaa027name);
		}
			sy.removeWinRet(dialogID);//不可缺少
		})
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 200px " 
								onclick="showMenu_aaa027();" readonly="readonly" 
							   class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" 
								style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" 
									style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>											
						<td style="text-align:right;"><nobr>监控企业名称:</nobr></td>
						<td><input name="jkqymc" id="jkqymc" style="width: 200px"/></td>												
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>监控企业编号:</nobr></td>
						<td><input id="jkqybh" name="jkqybh" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>是否指派监管员:</nobr></td>
						<td><input id="ishavejgy" name="ishavejgy" style="width: 200px" /></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="监控企业列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addFzrJgy"
								iconCls="ext-icon-group_add" plain="true" onclick="addFzrJgy()">指派监管员</a>
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