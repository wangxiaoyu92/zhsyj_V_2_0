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
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
%>
<!DOCTYPE html>
<html>
<head>

<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	//案件承办人
	var v_ajcbr_table=$("#ajcbr_table");
	v_ajcbr_table.datagrid({
		title :'案件承办人',
		//iconCls : 'icon-tip',
		url : basePath+'/zfba/ajdj/queryAjdjCbr',
		queryParams: {
			ajdjid:'<%=v_ajdjid%>',
			zfrysflx:'1'
		},
		striped : true, //奇偶行使用不同的颜色
		singleSelect : false, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : false, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'ajcbrid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '案件承办人ID',
				field : 'ajcbrid',
				width : 50,
				hidden : true
			},{
				title : '案件登记id',
				field : 'ajdjid',
				width : 50,
				hidden:true
			},{
				title : '对应sysuser表ID',
				field : 'userid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '姓名',
				field : 'zfryxm',
				align : 'center',
				width : 130,
				editor : 'textarea'
			},{
				title : '所属部门',
				field : 'zfrybmmc',
				align : 'center',
				width : 280,
				editor : 'textarea'
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '选择承办人',
			handler : function(){
				myselectAjdjXgry("ajcbr");
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_ajcbr_table);
				}
			}]
	});
	
	//案件协办人
	var v_ajxbr_table=$("#ajxbr_table");
	v_ajxbr_table.datagrid({
		title :'案件协办人',
		//iconCls : 'icon-tip',
		url : basePath+'/zfba/ajdj/queryAjdjCbr',
		queryParams: {
			ajdjid:'<%=v_ajdjid%>',
			zfrysflx:'2'
		},
		striped : true, //奇偶行使用不同的颜色
		singleSelect : false, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : false, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'ajcbrid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '案件承办人ID',
				field : 'ajcbrid',
				width : 50,
				hidden : true
			},{
				title : '案件登记id',
				field : 'ajdjid',
				width : 50,
				hidden:true
			},{
				title : '对应sysuser表ID',
				field : 'userid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '姓名',
				field : 'zfryxm',
				align : 'center',
				width : 130,
				editor : 'textarea'
			},{
				title : '所属部门',
				field : 'zfrybmmc',
				align : 'center',
				width : 280,
				editor : 'textarea'
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '选择协办人',
			handler : function(){
				myselectAjdjXgry("ajxbr");
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_ajxbr_table);
				}
			}]
	});	
	
	//案件其他相关人员
	var v_ajqtry_table=$("#ajqtry_table");
	v_ajqtry_table.datagrid({
		title :'案件其他相关人员',
		//iconCls : 'icon-tip',
		url : basePath+'/zfba/ajdj/queryAjdjCbr',
		queryParams: {
			ajdjid:'<%=v_ajdjid%>',
			zfrysflx:'3'
		},
		striped : true, //奇偶行使用不同的颜色
		singleSelect : false, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : false, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'ajcbrid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '案件承办人ID',
				field : 'ajcbrid',
				width : 50,
				hidden : true
			},{
				title : '案件登记id',
				field : 'ajdjid',
				width : 50,
				hidden:true
			},{
				title : '对应sysuser表ID',
				field : 'userid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '姓名',
				field : 'zfryxm',
				align : 'center',
				width : 130,
				editor : 'textarea'
			},{
				title : '所属部门',
				field : 'zfrybmmc',
				align : 'center',
				width : 280,
				editor : 'textarea'
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '选择其他相关人员',
			handler : function(){
				myselectAjdjXgry("ajqtry");
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_ajqtry_table);
				}
			}]
	});		
});

//从单位信息表中读取

function myselectAjdjXgry(prm_rykind){
		if (prm_rykind=="ajqtry"){
			singleSelect="false";
		}else{
			singleSelect="true";	//
		}
		var url = basePath + "jsp/pub/pub/selectuser.jsp"; 
		var dialog = parent.sy.modalDialog({
			title : '文书管理', 
			param : {
				singleSelect : singleSelect 
			},
			width : 950,
			height : 600,
			url : url  
		} ,function(dialogID){
				var v_retStr = sy.getWinRet(dialogID); 
				if (v_retStr!=null && v_retStr.length>0){
				    for (var k=0;k<=v_retStr.length-1;k++){
				    	var myrow = v_retStr[k];
				    	mydatagrid_selectman_addRow(prm_rykind, myrow);      
				    };
		    	};
				sy.removeWinRet(dialogID);
		}); 
}
function closeModalDialogCallback(dialogID,prm_rykind){
    var v_retStr = sy.getWinRet(dialogID);
	if (v_retStr!=null && v_retStr.length>0){
	    for (var k=0;k<=v_retStr.length-1;k++){
	    	var myrow = v_retStr[k];
	    	mydatagrid_selectman_addRow(prm_rykind, myrow);      
	    };
    };
	sy.removeWinRet(dialogID);
}
function mydatagrid_selectman_addRow(v_tablekind, v_manrow) {
    var v_table;
    var v_rowindex;

    var v_userid = v_manrow.userid; //人员ID
    var v_orgname = v_manrow.orgname; //机构名称
    var v_description = v_manrow.description; //人员姓名
    var v_username = v_manrow.username; //用户登录账号
    
    if (v_tablekind!=null && v_tablekind=="ajcbr") {  //承办人
        v_table = $("#ajcbr_table");
        v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(v_userid);//人员ID
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfryxm'})).target).val(v_description);//姓名
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfrybmmc'})).target).val(v_orgname);//证件号码
    } else if (v_tablekind == "ajxbr") {//负责人
        v_table = $("#ajxbr_table");
        v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(v_userid);//人员ID
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfryxm'})).target).val(v_description);//姓名
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfrybmmc'})).target).val(v_orgname);//证件号码
    } 
    else if (v_tablekind == "ajqtry") {//负责人
        v_table = $("#ajqtry_table");
        v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(v_userid);//人员ID
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfryxm'})).target).val(v_description);//姓名
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'zfrybmmc'})).target).val(v_orgname);//证件号码
    }    
    mydatagrid_endEditing(v_table);
}

//添加一行
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

//编辑状态
function mydatagrid_endEditing(v_datagrid){
	//var editIndex = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	var editIndex = editIndex=v_datagrid.datagrid('getRows').length-1;
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
	if(index == -1){
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('cancelEdit',index)
			.datagrid('deleteRow',index);
	if(index-1>=0){
		v_datagrid.datagrid('selectRow',index-1);
	}
}

/**
 * 保存
 */
function mysave(){
		var url= basePath+'/zfba/ajdj/saveAjdjCbr';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
          mydatagrid_endEditing($('#ajcbr_table'));
          var v_ajcbr_table_rows = $('#ajcbr_table').datagrid('getRows');
          $('#ajcbr_table_rows').val($.toJSON(v_ajcbr_table_rows));
          mydatagrid_endEditing($('#ajxbr_table'));
          var v_ajxbr_table_rows = $('#ajxbr_table').datagrid('getRows');
          $('#ajxbr_table_rows').val($.toJSON(v_ajxbr_table_rows));
          
          mydatagrid_endEditing($('#ajqtry_table'));
          var v_ajqtry_table_rows = $('#ajqtry_table').datagrid('getRows');
          $('#ajqtry_table_rows').val($.toJSON(v_ajqtry_table_rows));          
		
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
			 		$.messager.alert('提示','保存成功！','info',function(){
						$("#saveBtn").linkbutton('disable');  
						var obj = new Object();
						obj.a = v_ajcbr_table_rows;
						obj.b = v_ajxbr_table_rows;
						sy.setWinRet(s);
						closeWindow();
	        		});
			 				 		
              	} else {
              		alert("保存失败：" + result.msg);
                }
	        }    
		});
}

function closeWindow(){ 
	parent.$("#"+sy.getDialogId()).dialog("close");//有入参$dialog的关闭方法
}
</script>
</head>
<body>
<form id="myform" method="post">
	<div id="cc" class="easyui-layout" style="width:600px;height: 600px;">
	<form id="myform" method="post">
		<div region="center" style="overflow: true;" border="false" >
		  <div id="ajcbr_table" style="height:150px;width:600px;"></div>
		  <div id="ajxbr_table" style="height:150px;width:600px;"></div>
		  <div id="ajqtry_table" style="height:200px;width:600px;"></div>
		  
		  <input type="hidden" id="ajcbr_table_rows" name="ajcbr_table_rows" value="承办人"/>
		  <input type="hidden" id="ajxbr_table_rows" name="ajxbr_table_rows" value="协办人"/>
		  <input type="hidden" id="ajqtry_table_rows" name="ajqtry_table_rows" value="其他相关人员"/>
		  <input type="hidden" id="ajdjid" name="ajdjid" value="<%=v_ajdjid%>"/>
		  </br>
		  <div style="height:30px;float:right;" >
	           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
	             onclick="mysave()"data-options="iconCls:'icon-save'">保存</a>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" 
	              onclick="closeWindow();"
	              data-options="iconCls:'icon-back'">关闭</a>		    
		  </div>
		</div>  
	</form>
	</div>
</body>
</html>