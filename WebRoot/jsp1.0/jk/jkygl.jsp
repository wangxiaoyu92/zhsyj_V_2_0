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
<title>监控源管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var state = <%=SysmanageUtil.getAa10toJsonArray("AAA104")%>;
	var cb_state;
	var grid;
	
	$(function() {
		cb_state = $('#state').combobox({
	    	data : state,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
	    
		grid = $('#grid').datagrid({
			//title : '监控源列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			toolbar : '#toolbar',
			url : basePath + '/jk/jkgl/queryJky',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jkid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '200',
				title : '监控源ID',
				field : 'jkid',
				hidden : false
			},{
				width : '200',
				title : '监控企业编号',
				field : 'jkqybh',
				hidden : false
			},{
				width : '200',
				title : '监控企业名称',
				field : 'jkqymc',
				hidden : false
			},{
				width : '250',
				title : '监管人',
				field : 'ishavejgy',
				hidden : false,
				formatter:function(value,rec){
				 	if (value == "0") {
				 		return '<span style=color:red>暂未指派监管人</span>';
			 		} else {
				 		return '<span style=color:green>已指派监管人</span>';
			 		}
				}
			}]],				
			columns : [ [ {
				width : '150',
				title : '监控源编号',
				field : 'jkybh',
				hidden : false
			},{
				width : '200',
				title : '监控源名称',
				field : 'jkymc',
				hidden : false
			},{
				width : '100',
				title : '监控类型',
				field : 'jklx',
				hidden : false
			},{
				width : '100',
				title : '显示顺序',
				field : 'orderno',
				hidden : false
			},{
				width : '150',
				title : '统筹区',
				field : 'aaa027name',
				hidden : false
			} ] ]
		});
		
		var  vSysUser = <%=SysmanageUtil.getSysuser().getUsername()%>;
		//删除权限
		//导入功能（admin 才有）
		if(vSysUser=="admin" || vSysUser=="tygly"){
			$('.delete').css('display','');
		}
		
		
	});

	// 查询
	function query() {
		var jkqybh = $('#jkqybh').val();
		var jkqymc = $('#jkqymc').val();
		var jkybh = $('#jkybh').val();
		var state = $('#state').combobox('getValue');
		var param = {
			'jkqybh': jkqybh,
			'jkqymc': jkqymc,
			'jkybh': jkybh,
			'state': state
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addJky = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增监控源',
			width : 870,
			height : 500,
			url : basePath + '/jk/jkgl/jkyglFormIndex',
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
		});
	};

	// 编辑
	var updateJky = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑监控源',
				width : 870,
				height : 500,
				url : basePath + '/jk/jkgl/jkyglFormIndex?jkid=' + row.jkid,
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
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	};

	
	// 删除
	var delJky = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的监控源相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/jk/jkgl/delJky', {
						jkid: row.jkid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
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

	// 指派负责人
	var fzrJky = function() {
		var url="<%=basePath%>jsp/jk/selectFzr.jsp";
		var dialog = parent.sy.modalDialog({
			title : '指派负责人',
			param : {
			a : new Date().getMilliseconds(),
			singleSelect:"true"
			},
			width : 1000,
			height : 550,
			url : url
			})
	};
	// 导入
	var jkydrIndex = function(){		
		var dialog = parent.sy.modalDialog({
			title : '导入监控源',
			iconCcs : 'ext-icon-monitor',
			width : 870,
			height : 522,
			url : basePath + '/jg/jkgl/jkydrIndex',
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, grid, parent.$);
				}
			} ]
		});
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
							<input name="aaa027name" id="aaa027name"  style="width: 200px " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>											
						<td style="text-align:right;"><nobr>监控企业名称:</nobr></td>
						<td><input name="jkqymc" id="jkqymc" style="width: 200px"/></td>												
						<td style="text-align:right;"><nobr>监控企业编号:</nobr></td>
						<td><input id="jkqybh" name="jkqybh" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>监控源编号:</nobr></td>
						<td><input id="jkybh" name="jkybh" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>在线状态</nobr></td>
						<td><input id="state" name="state" style="width: 200px" /></td>																	
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
        	<sicp3:groupbox title="监控源列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addJky"
								iconCls="icon-add" plain="true" onclick="addJky()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateJky"
								iconCls="icon-edit" plain="true" onclick="updateJky()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>							  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJky"
								iconCls="icon-remove" plain="true" onclick="delJky()">删除</a>
							</td>
							<td class="delete" style="display: none" >  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_fzrJky"
								iconCls="ext-icon-group_add" plain="true" onclick="fzrJky()">指派负责人</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
<%--							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_jkydrIndex" --%>
<%--								iconCls="ext-icon-report_go" plain="true" onclick="csdrIndex()">导入监控源</a>--%>
<%--							</td> --%>
<%--							<td>  --%>
<%--								<div class="datagrid-btn-separator"></div>--%>
<%--							</td>--%>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>