<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>

<!DOCTYPE HTML>
<html>
<head>
<title>课件管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var v_wareSource = <%=SysmanageUtil.getAa10toJsonArray("KJLY")%>; // 课件来源
	var v_wareCategory = <%=SysmanageUtil.getAa10toJsonArray("KJFL")%>; // 课件分类
	var v_wareType = <%=SysmanageUtil.getAa10toJsonArray("KJLX")%>;  // 课件类型
	var v_wareStatus = [{"id":"0","text":"启用"},{"id":"1","text":"禁用"}]; // 课件状态
	var grid;
	$(function() {
		// 课件来源下拉框
		$("#wareSourceSelect").combobox({
	    	data : v_wareSource,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 课件分类下拉框
	    $("#wareCategorySelect").combobox({
	    	data : v_wareCategory,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    
	    grid = $('#grid').datagrid({
	    	toolbar: '#toolbar',
	    	url : basePath + 'train/courseware/queryCoursewareInfos',
	    	striped : true, // 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'wareId', //该列是一个唯一列
		    sortOrder: 'desc',	
		    columns : [ [{
		        title: '课件id',
				field: 'wareId',
				width : '100',
				hidden : true
		    },{
		        title: '课件名称',
				field: 'wareName',
				width : '150',
				hidden : false
		    
		    },{
		   	    title: '课件状态',
				field: 'wareStatus',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_wareStatus, value);
				}
		    },{
		   	    title: '课件类型',
				field: 'wareType',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_wareType, value);
				}
		    },{
		        title: '课件分类',
				field: 'wareCategory',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_wareCategory, value);
				}
		    },{
		        title: '课件路径',
				field: 'wareVideo',
				width : '100',
				hidden : true
		    },{
		        title: '时长（分）',
				field: 'wareLength',
				width: '100',
				hidden: false
		    },{
		        title: '学分',
				field: 'warePoint',
				width: '100',
				hidden: false
		    },{
		        title: '创建人',
				field: 'aae011',
				width: '100',
				hidden: false
		    },{
		        title: '最后更新',
				field: 'aae036',
				width: '150',
				hidden: false
		    }]]			  
	    });
	});
	
	// 查询试题
	function query() {
		var v_wareSource = $('#wareSourceSelect').combobox('getValue');
		var v_wareCategory = $('#wareCategorySelect').combobox('getValue');
		var wareName = $("#wareName").val();
		var param = {
			// 课件分类	
			'wareCategory' : v_wareCategory,
			//课件来源
			'wareSource' : v_wareSource,
			//课件名称
			'wareName' : wareName
		};
	    $('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	
	// 重置
	function refresh(){
		parent.window.refresh();	
	}
	//跳转添加课件页面
	function addCourseware() {
		var url = basePath + "train/courseware/coursewareInfoFormIndex";

		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '添加课件',
			width : 900,
			height : 500,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if(obj != null){
				if(obj == 'ok'){
					grid.datagrid('reload');
				}
			}
		});
	}
	// 删除课件信息
	function delCoursewareInfos() {
		var rows = grid.datagrid("getSelections");
		if (rows != "") {
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr
			};
			$.post(basePath + 'train/courseware/dellCoursewareInfo', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg,'error');
               }
			}, 'json');
		}else {
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}
	// 编辑课件信息
	function editCoursewareInfo(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "train/courseware/coursewareInfoFormIndex?wareId=" + row.wareId;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '编辑课件',
				width : 900,
				height : 500,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj != null){
					if(obj == 'ok'){
						grid.datagrid('reload');
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	}
	// 查看课件信息
	function showCourseWare(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = "";
			if (row.wareType=="4"){
				url=basePath + "api/train/showPicwordIndex?wareId=" + row.wareId;
				window.open(url);
			}else{
				url = basePath + "train/courseware/showCourseWareIndex?wareId=" + row.wareId;
				//创建模态窗口
				var dialog = parent.sy.modalDialog({
					title : '查看课件',
					width : 900,
					height : 600,
					url : url
				});					
			}
		} else {
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true"> 
		<div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
          		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>课件来源</nobr></td>
						<td><input id="wareSourceSelect" name="wareSourceSelect" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>课件分类</nobr></td>
						<td><input id="wareCategorySelect" name="wareCategorySelect" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>课件名称</nobr></td>
			    		<td><input id="wareName" name="wareName" style="width: 200px" /></td>
						<td colspan="2" style="text-align:center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="课件列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_showCourseWare" iconCls="ext-icon-report_magnify" plain="true"
								onclick="showCourseWare()">查看</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_addCourseware" iconCls="icon-add" plain="true"
								onclick="addCourseware()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_editCoursewareInfo" iconCls="icon-edit" plain="true"
								onclick="editCoursewareInfo()">编辑</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_delCoursewareInfos" iconCls="icon-remove" plain="true"
								onclick="delCoursewareInfos()">删除</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>
