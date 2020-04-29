<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>教师管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	var v_sex = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>; // 人员性别
	var v_eType = [{"id":"","text":"===请选择==="},{"id":"0","text":"外部讲师"},{"id":"1","text":"内部讲师"}]; 
	$(function() {
		// 教师性别
		$("#sex").combobox({
	    	data : v_sex,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 教师类别
		$("#type").combobox({
	    	data : v_eType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url : basePath + 'train/teacher/queryTeachers',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'teacherId', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [[{
				title: '教师id',
				field: 'teacherId',
				width : '100',
				hidden : true
			},{
				title: '姓名',
				field: 'teacherName',
				width : '150',
				hidden : false
			},{
				title: '类别',
				field: 'teacherType',
				width: '80',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_eType, value); 
				}
			},{
				title: '性别',
				field: 'teacherSex',
				width: '80',
				hidden : false,
				formatter: function(value, row) {
					return sy.formatGridCode(v_sex, value); 
				}
			},{
				title: '教师年龄',
				field: 'teacherAge',
				width : '80',
				hidden : false
			},{
				title: '联系方式',
				field: 'teacherTel',
				width : '100',
				hidden : false
			},{
				title: '微博',
				field: 'teacherWeibo',
				width : '150',
				hidden : false
			},{
				title: '博客',
				field: 'teacherBlog',
				width : '150',
				hidden : false
			},{
				title: '地址',
				field: 'teacherAddr',
				width: '200',
				hidden : false
			},{
				title:'操作',
				field:'opt',
				align:'center',
				width:100,
	            formatter:function(value, row, index){
					var str = "";									
	                str += "<span style='color:blue'><a href='javascript:editTeacher(" + "\"" + row.teacherId;
	                str += "\"" + ")'><img src='<%=basePath%>jslib/jquery-easyui-1.3.4/themes/icons/modify.gif'"; 
	                str += " align='absmiddle'>编辑</a></span>";
	                return str;  
	            }   
	      	}] ]
		});
	});
	// 查询课程
	function query() {
		var v_sex = $('#sex').combobox('getValue');
		var v_type = $('#type').combobox('getValue');
		var v_name = $('#teacherName').val();
		var param = {
			'teacherSex' : v_sex,
			'teacherName' : v_name,
			'teacherType' : v_type
		};
		$('#grid').datagrid('load', param);
		grid.datagrid('clearSelections');
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	// 新增，跳转到新增页面
	function addTeacher() {
		var url = basePath + "train/teacher/teacherFormIndex";
		var dialog = parent.sy.modalDialog({
			title : '添加',
			width : 750,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (obj != null) {
				if (obj == 'ok') {
					grid.datagrid('reload');
				}
			}
		});
	} 		
	// 编辑课程
	function editTeacher() {		
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "train/teacher/teacherFormIndex?teacherId=" + row.teacherId;
			var dialog = parent.sy.modalDialog({
				title : '编辑',
				width : 750,
				height : 400,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if (obj != null) {
					if (obj == 'ok') {
						grid.datagrid('reload');
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	} 
	// 删除课程
	function delTeacher() {
		var row = grid.datagrid("getSelected");
		if (row) {
			var param = {
				'teacherId' : row.teacherId
			};  
			$.post(basePath + 'train/teacher/delTeacher', param, function(result) {
				if (result.code == '0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			$('#grid').datagrid('reload'); 
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：' + result.msg,'error');
               }
			}, 'json');
		} else {
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
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
						<td style="text-align:right;"><nobr>教师性别</nobr></td>
						<td><input id="sex" name="sex" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>教师姓名</nobr></td>
						<td><input id="teacherName" name="teacherName" style="width: 200px" /></td>							
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>教师类别</nobr></td>
						<td><input id="type" name="type" style="width: 200px"/></td>						
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
        	<sicp3:groupbox title="教师列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addTeacher"
								iconCls="icon-add" plain="true" onclick="addTeacher()">增加</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editTeacher"
								iconCls="icon-edit" plain="true" onclick="editTeacher()">编辑</a>
							</td>  
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delTeacher"
								iconCls="icon-remove" plain="true" onclick="delTeacher()">删除</a>
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