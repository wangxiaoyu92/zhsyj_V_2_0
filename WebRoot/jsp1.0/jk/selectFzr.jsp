<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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

<title>指派负责人</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var v_comgrid; // 监控企业表
var v_rygrid; // 监控负责人表
$(function(){
	// 企业设置
	v_comgrid = $("#comgrid").datagrid({
		title :'监控企业',
		url : basePath + 'jk/jkgl/queryJkcomList',
		striped : true, //奇偶行使用不同的颜色
		singleSelect : false, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : true, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'comid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '公司id',
				field : 'comid',
				checkbox : 'true',
				width : 50,
				hidden: false
			},{
				title : '公司名称',
				field : 'commc',
				width : 150,
				hidden: false
			},{
				title : '公司地址',
				field : 'comdz',
				width : 250,
				hidden: false
			}
		]],
		onClickRow : function(rowIndex, rowData){
			var v_comid = rowData.comid;	
			queryJkcomFzr(v_comid); // 查询负责人
			$("#comid").val(v_comid);
		}
	});
	
	// 负责人
	v_rygrid =  $("#rygrid").datagrid({
		title :'负责人表',
		striped : true, // 奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : false, // 当用户点击行的时候就选中
		selectOnCheck : false,  // 单击复选框将选择行
		pagination : true, // 底部显示分页栏
		pageSize : 10,  // 每页显示的页数
		pageList : [10,20,30],  // 每页显示的页数（供选择）
		rownumbers : true,  // 是否显示行号
		fitColumns :false,  // 列自适应宽度  防止滚动
		idField : 'jkqyfzrid',  // 该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  // 按升序排序
		columns :[[
			{
				title : '人员表ID',
				field : 'jkqyfzrid ',
				width : 50,
				hidden : true
			},{
				title : '监控企业id',
				field : 'comid',
				width : 50,
				editor : 'textarea',
				hidden: true
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
				hidden: false
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
			text : '添加负责人',
			handler : function(){
				addJkFzr();
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

// 查询负责人
function queryJkcomFzr(v_comid){
	var param = {
		'comid' : v_comid
	};
	// 负责人
	v_rygrid.datagrid({
		url : basePath + 'jk/jkgl/queryJkfzrList',			
		queryParams : param
	});
}

// 添加检查人员
function addJkFzr(){
	var row = $('#comgrid').datagrid('getSelected');
	var url="<%=basePath%>jsp/pub/pub/selectuser.jsp";
	if (row) {
		var dialog = parent.sy.modalDialog({
			title : '选择企业',
			param : {
			a : new Date().getMilliseconds(),
			singleSelect:"true"
			},
			width : 1000,
			height : 600,
			url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if (obj != null && obj.length > 0){
		   			 for (var k = 0; k <= obj.length-1; k++){
		    		var myrow = obj[k];
		    		var v_rowindex = mydatagrid_append(v_rygrid);
			   		 if (v_rowindex == -1) {
			       	return false;
			    	}
			   			 // 人员ID
			  	  		 $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(myrow.userid); 
			   			 // 人员描述
			   			 $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'username'})).target).val(myrow.description);
			   			 // 组织机构id
			   			 $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'orgid'})).target).val(myrow.orgid);
			  			  // 组织机构名称
			   			 $((v_rygrid.datagrid('getEditor', {index: v_rowindex, field: 'bmmc'})).target).val(myrow.orgname); 
			   			 mydatagrid_endEditing(v_rygrid);
		    }
	    }
			})
    } else {
		$.messager.alert('提示', '请先选择要监控的企业！', 'info');
	}      
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
	var url = basePath + 'jk/jkgl/saveJkFzr';

    parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
	
	// 获取选中的公司
	var v_comgrid_rows = v_comgrid.datagrid('getSelections'); 
	var v_comArr = [];
	for (var i = 0; i < v_comgrid_rows.length; i++) {
		v_comArr.push({'comid' : v_comgrid_rows[i].comid});
	}
	$('#comgrid_rows').val($.toJSON(v_comArr));
	// 获取添加的监管人员
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
		 		alert("保存成功！");
		 		closeAndRefreshWindow();
		 		
           	} else {
           		alert("保存失败：" + result.msg);
            }
        }    
	});
}
// 所属统筹区树
function showMenu_aaa027() {
	var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
	var obj = new Object();
	var dialog = parent.sy.modalDialog({
			title : '所属统筹区树',
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
// 查询
function query() {
	var commc = $('#commc').val();
	var aaa027 = $('#aaa027').val();
	var param = {
		'commc' : commc,
		'aaa027' : aaa027
	};
	v_comgrid.datagrid('reload', param);
	v_comgrid.datagrid('clearSelections');
	v_rygrid.datagrid('loadData', { total: 0, rows: [] });
}

// 重置
function refresh(){
	var param = {
		'commc' : '',
		'aaa027' : ''
	};
	$('#aaa027name').val('');
	$('#commc').val('');
	$('#aaa027').val('');
	v_comgrid.datagrid('reload', param);
	v_comgrid.datagrid('clearSelections');
	v_rygrid.datagrid('loadData', { total: 0, rows: [] });
}

	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>
</head>
<body>
<form id="myform" method="post">
	<div id="cc" class="easyui-layout" style="width:980px;height: 500px;">
		<sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 950px; height: 30px;">
				<tr>
					<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
					<td>
						<input name="aaa027name" id="aaa027name"  style="width: 150px " 
							onclick="showMenu_aaa027()" readonly="readonly" 
						   	class="easyui-validatebox" data-options="required:false" />
						<input name="aaa027" id="aaa027"  type="hidden"/>
						<div id="menuContent_aaa027" class="menuContent" 
							style="display:none; position: absolute;">
							<ul id="treeDemo_aaa027" class="ztree" 
								style="margin-top:0px;width:150px;height:450px;"></ul>
						</div>							
					</td>											
					<td style="text-align:right;"><nobr>监控企业名称:</nobr></td>
					<td><input name="commc" id="commc" style="width: 150px"/></td>	
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>											
				</tr>
			</table>
        </sicp3:groupbox>
		<sicp3:groupbox title="">
			<table style="width:980px;height:420px;" >
				<tr>
					<td>
						<input type="hidden" id="comgrid_rows" name="comgrid_rows"/>
						<table id="comgrid" style="height:400px;width:450px;"></table>
					</td>
					<td>
						<input type="hidden" id="rygrid_rows" name="rygrid_rows"/>
						<table id="rygrid" style="height:400px;width:450px;"></table>
					</td>
				</tr>
			</table>
		</sicp3:groupbox>	
	</div>
	<div region="center" style="overflow: true;" border="false" >
	  	<div style="height:30px; float:right; margin-right: 40px;" >
           	<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
             	onclick="mysave()"data-options="iconCls:'icon-save'">保存</a>
           	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" 
                onclick="closeAndRefreshWindow();" data-options="iconCls:'icon-back'">关闭</a>	
	    </div>
	</div>
</form>
</body>
</html>