<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 检查计划id
	String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));
%>
<!DOCTYPE html>
<html>
<head>

<title>派发任务</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var v_taskgrid; // 任务表
var v_comgrid; // 公司表
var v_rygrid; // 人员表
$(function(){
	// 分派任务
	v_taskgrid = $("#taskgrid").datagrid({
		title :'任务列表',
		url : basePath+'supervision/queryTaskList',
		queryParams: {
			planid:'<%=v_planid%>'
		},
		striped : true, //奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : false, //当用户点击行的时候就选中
		selectOnCheck : false,  //单击复选框将选择行
		pagination : true, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'taskid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '任务ID',
				field : 'taskid',
				width : 50,
				hidden : true
			},{
				title : '检查计划id',
				field : 'planid',
				width : 50,
				hidden:true
			},{
				title : '任务名称',
				field : 'taskname',
				width : 100,
				hidden : false
			},{
				title : '任务描述',
				field : 'taskremark',
				width : 250
			},{
				title : '开始时间',
				field : 'tasktimest',
				width : 100
			},{
				title : '结束时间',
				field : 'tasktimeed',
				width : 100
			},{
				title : '创建人',
				field : 'aaa011',
				width : 100
			},{
				title : '创建时间',
				field : 'aae036',
				width : 100
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '添加任务',
			handler : function(){
				addTask();
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除任务',
				handler: function () {
					deleteTask();
				}
			},{
				iconCls: 'ext-icon-application_form_magnify',
				text: '查看任务',
				handler: function () {
					showTask();
				}
			},{
				iconCls: 'icon-edit',
				text: '编辑任务',
				handler: function () {
					editTask();
				}
			}],
			onClickRow : function(rowIndex, rowData){
				var v_taskid = rowData.taskid;	
				querySupervisionItem(v_taskid); // 加载检查项
				$("#taskid").val(v_taskid);
				$("#taskname").val(rowData.taskname); // 任务名称
				$("#taskremark").val(rowData.taskremark); // 任务描述
				$("#tasktimest").val(rowData.tasktimest); // 任务开始时间
				$("#tasktimeed").val(rowData.tasktimeed); // 任务结束时间
			}
	});

	// 检查公司设置
	v_comgrid = $("#comgrid").datagrid({
		title :'检查公司设置',
		striped : true, //奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : false, //当用户点击行的时候就选中
		selectOnCheck : false,  //单击复选框将选择行
		pagination : true, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'taskdetailid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '任务明细ID',
				field : 'taskdetailid',
				width : 50,
				hidden : true
			},{
				title : '任务id',
				field : 'taskid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '公司id',
				field : 'comid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '公司名称',
				field : 'commc',
				width : 150,
				editor : 'textarea'
			},{
				title : '公司地址',
				field : 'comdz',
				width : 250,
				editor : 'textarea'
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '添加检查公司',
			handler : function(){
				addSupervisionCom();
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_comgrid);
				}
			}]
	});
	
	
	// 检查人员设置
	v_rygrid =  $("#rygrid").datagrid({
		title :'计划检查人员设置',
		striped : true, // 奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : false, // 当用户点击行的时候就选中
		selectOnCheck : false,  // 单击复选框将选择行
		pagination : true, // 底部显示分页栏
		pageSize : 10,  // 每页显示的页数
		pageList : [10,20,30],  // 每页显示的页数（供选择）
		rownumbers : true,  // 是否显示行号
		fitColumns :false,  // 列自适应宽度  防止滚动
		idField : 'id',  // 该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  // 按升序排序
		columns :[[
			{
				title : '检查任务人员表ID',
				field : 'id ',
				width : 50,
				hidden : true
			},{
				title : '任务id',
				field : 'taskid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '人员ID',
				field : 'userid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '姓名',
				field : 'username',
				align : 'center',
				editor : 'textarea',
				width : 150,
				hidden:false
			},{
				title : '所属机构id',
				field : 'orgid',
				align : 'center',
				editor : 'textarea',
				width : 150,
				hidden: true
			},{
				title : '所属部门',
				field : 'bmmc',
				align : 'center',
				editor : 'textarea',
				width : 250,
				hidden: false
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '添加检查人员',
			handler : function(){
				addSupervisionRy();
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_rygrid);
				}
			}]
	});		
});

// 添加任务
function addTask() {
	var obj = new Object();
	var url = '<%=basePath%>supervision/taskFormIndex';
	var dialog = parent.sy.modalDialog({
		title : '添加任务',
		param : {
			planid : "<%=v_planid%>"
		},
		width : 630,
		height : 400,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少
		if (obj.type == 'ok') {
			$("#taskgrid").datagrid("reload");
		}
	});

}

// 查看任务
function showTask() {
	var row = $('#taskgrid').datagrid('getSelected');
	if (row) {
		var url = '<%=basePath%>supervision/taskFormIndex';
		var dialog = parent.sy.modalDialog({
			title : '查看任务',
			param : {
				planid : "<%=v_planid%>",
				taskid : row.taskid,
				op : "view"
			},
			width : 830,
			height : 600,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (obj.type == 'ok') {
				$("#taskgrid").datagrid("reload");
			}
		});
	} else {
		$.messager.alert('提示', '请先选择要查看的任务信息！', 'info');
	}
}

// 编辑任务
function editTask() {
	var row = $('#taskgrid').datagrid('getSelected');
	if (row) {
		var obj = new Object();
		var url = '<%=basePath%>supervision/taskFormIndex';
		var dialog = parent.sy.modalDialog({
			title : '添加任务',
			param : {
				planid : "<%=v_planid%>",
				taskid : row.taskid
			},
			width : 630,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (obj.type == 'ok') {
				$("#taskgrid").datagrid("reload");
			}
		});
	} else {
		$.messager.alert('提示', '请先选择要修改的任务信息！', 'info');
	}
}

// 删除任务
function deleteTask() {
	var row = $('#taskgrid').datagrid('getSelected');
	if (row) {
		$.messager.confirm('警告', '您确定要删除该任务吗?',function(r) {
			if (r) {
				$.post(basePath + 'supervision/deleteTask', {
					taskid: row.taskid
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','删除成功！','info',function(){
							$('#taskgrid').datagrid('reload'); 
							v_comgrid.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
							v_rygrid.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
		        		});    	
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
			}
		});
	} else {
		$.messager.alert('提示', '请先选择要删除的任务！', 'info');
	}
} 

// 查询检查项
function querySupervisionItem(v_taskid){
	var param = {
		'taskid' : v_taskid
	};
	// 检查公司
	v_comgrid.datagrid({
		url : basePath + 'supervision/querySupervisionCompany',			
		queryParams : param
	});
	// 检查人员
	v_rygrid.datagrid({
		url : basePath + 'supervision/querySupervisionPerson',			
		queryParams : param
	});
}

// 添加检查人员
function addSupervisionRy(){
	var row = $('#taskgrid').datagrid('getSelected');
	if (row) {
	    var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
		var dialog = parent.sy.modalDialog({
			title : '添加检查人员',
			param : {
				singleSelect : "false",
				a : new Date().getMilliseconds()
			},
			width : 1000,
			height : 600,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (obj != null && obj.length > 0){
				for (var k = 0; k <= obj.length-1; k++){
					var myrow = obj[k];
					mydatagrid_selectman_addRow("ry", myrow);
				}
			}
		});


    } else {
		$.messager.alert('提示', '请先选择分派任务！', 'info');
	}      
}
// 添加检查单位
function addSupervisionCom(){
	var row = $('#taskgrid').datagrid('getSelected');
	if (row) {
	    var url = "<%=basePath%>supervision/selComByPlanIndex";

		var dialog = parent.sy.modalDialog({
			title : '添加检查公司',
			param : {
				planid : "<%=v_planid%>",
				singleSelect : "false",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (obj != null && obj.length > 0){
				for (var k = 0; k <= obj.length-1; k++){
					var myrow = obj[k];
					mydatagrid_selectman_addRow("com", myrow);
				}
			}
		});
    } else {
		$.messager.alert('提示', '请先选择分派任务！', 'info');
	}      
}

function mydatagrid_selectman_addRow(v_tablekind, v_manrow) {
	var v_table;
    var v_rowindex;
    var v_taskid = $("#taskid").val();
    if (v_tablekind != null && v_tablekind == "com") {
    	v_table = v_comgrid;
    	var v_comid = v_manrow.comid;
    	var v_commc = v_manrow.commc;
    	var v_comdz = v_manrow.comdz;
    	v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_comgrid.datagrid('getEditor', {index: v_rowindex, field: 'taskid'})).target).val(v_taskid); // 任务计划id
        $((v_comgrid.datagrid('getEditor', {index: v_rowindex, field: 'comid'})).target).val(v_comid); // 公司id
        $((v_comgrid.datagrid('getEditor', {index: v_rowindex, field: 'commc'})).target).val(v_commc); // 公司名称
        $((v_comgrid.datagrid('getEditor', {index: v_rowindex, field: 'comdz'})).target).val(v_comdz); // 公司地址
    } else if (v_tablekind != null && v_tablekind == "ry") {
    	v_table = v_rygrid;
    	var v_userid = v_manrow.userid; // 人员ID
        var v_orgname = v_manrow.orgname; // 机构名称
        var v_orgid = v_manrow.orgid; // 机构id
        var v_description = v_manrow.description; // 人员姓名
        v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'taskid'})).target).val(v_taskid); // 任务计划id
        $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(v_userid); // 人员ID
        $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'username'})).target).val(v_description); // 人员描述
        $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'orgid'})).target).val(v_orgid); // 组织机构id
        $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'orgname'})).target).val(v_orgname); // 组织机构名称
    }
    mydatagrid_endEditing(v_table);
}

// 添加一行
function mydatagrid_append(v_datagrid){
	var editIndex = -1;
	if(mydatagrid_endEditing(v_datagrid)){
		v_datagrid.datagrid('appendRow',{});  //在最后追加一行
		editIndex = v_datagrid.datagrid('getRows').length-1;
		v_datagrid.datagrid('selectRow',editIndex)
				  .datagrid('beginEdit',editIndex);
	}
	return editIndex;
}

// 编辑状态
function mydatagrid_endEditing(v_datagrid){
	var editIndex = v_datagrid.datagrid('getRows').length-1;
	//如果某一行处于校验状态，那么这一行处于编辑状态
	if(v_datagrid.datagrid('validateRow',editIndex)){
		var ed = v_datagrid.datagrid('getEditor',{index:editIndex});  //根据行索引得到编辑器
		v_datagrid.datagrid('endEdit',editIndex);
		return true;
	}else{
		return false;
	}
}

//删除一行
function mydatagrid_remove(v_datagrid){
	var index = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	if (index == -1) {
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('cancelEdit',index).datagrid('deleteRow',index);
	if (index-1 >= 0) {
		v_datagrid.datagrid('selectRow',index-1);
	}
}

/**
 * 保存
 */
function mysave(){
	var url= basePath+'supervision/saveSuperVisionItem';

    parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
	
	mydatagrid_endEditing(v_comgrid);
 	var v_comgrid_rows = v_comgrid.datagrid('getRows');
    $('#comgrid_rows').val($.toJSON(v_comgrid_rows)); 
	
    mydatagrid_endEditing(v_rygrid);
 	var v_rygrid_rows = v_rygrid.datagrid('getRows');
    $('#rygrid_rows').val($.toJSON(v_rygrid_rows));          
		
	$('#myform').form('submit',{
		url: url,
		onSubmit: function(){ 
			// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			var isValid = $(this).form('validate'); 
			if(!isValid){
				// 如果表单是无效的则隐藏进度条
				parent.$.messager.progress('close');	 
			}					
			return isValid;
		},
        success: function(result){
       		parent.$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
				$.messager.alert('提示', "保存成功！", 'info');
           	} else {
				$.messager.alert('警告', "保存失败：" + result.msg, 'warning');
            }
        }    
	});
}
	function closeWindow($dialog){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
<form id="myform" method="post">
	<div id="cc" class="easyui-layout" style="width:930px;height: 630px;">
		<input type="hidden" id="planid" name="planid" value="<%=v_planid%>"/>
		<input type="hidden" id="taskid" name="taskid"/>
		<input type="hidden" id="taskname" name="taskname"/>
		<input type="hidden" id="taskremark" name="taskremark"/>
		<input type="hidden" id="tasktimest" name="tasktimest"/>
		<input type="hidden" id="tasktimeed" name="tasktimeed"/>
		<div region="center" style="overflow: auto;" border="false">
        	<sicp3:groupbox title="分派任务">
				<table id="taskgrid" style="width:870px;height:300px;" ></table>
			</sicp3:groupbox>
			<sicp3:groupbox title="">
				<table>
					<tr>
						<td>
							<input type="hidden" id="comgrid_rows" name="comgrid_rows" value="检查企业"/>
							<table id="comgrid" style="height:300px;width:430px;"></table>
						</td>
						<td>
							<input type="hidden" id="rygrid_rows" name="rygrid_rows" value="检查人员"/>
							<table id="rygrid" style="height:300px;width:430px;"></table>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
        </div> 
	</div>
	<div region="center" style="overflow: auto;" border="false" >
	  	<div style="height:30px;float:right;" >
           	<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
             	onclick="mysave();"data-options="iconCls:'icon-save'">保存</a>
           	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" 
                onclick="closeWindow();" data-options="iconCls:'icon-back'">关闭</a>
	    </div>
	</div>
</form>
</body>
</html>