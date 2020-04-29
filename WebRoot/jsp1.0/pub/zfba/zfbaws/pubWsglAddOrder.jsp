<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	//String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var editIndex = undefined;
$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/wsgldy/queryAjwsParamlistOrder',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 100,
			pageList : [ 100, 200, 300 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'fjcsid', //该列是一个唯一列  
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '附件参数表ID',
				field : 'fjcsid',
				hidden : true
			},{
				width : '300',
				title : '执法文书名称',
				field : 'fjcsdmmc',
				hidden : false
			},{
				width : '200',
				title : '排序值（越小越靠前）',
				field : 'fjcspx',
				hidden : false,
				editor : 'textarea'
			}  
			]],
			onClickRow:function(rowIndex,rowData){
				myonClickRow(rowIndex);
			}
			
		});
		

		
		
});////////////////

   function queding(){
	var url= basePath+'/pub/wsgldy/saveZfwsOrder';
    parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
	endEditing();
    var v_mygrid_rows = $('#mygrid').datagrid('getRows');
     $('#ajzfwsorderlist').val($.toJSON(v_mygrid_rows));
	$('#myqueryfm').form('submit',{
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
		 		parent.$("#"+sy.getDialogId()).dialog("close");
	       	});     	
         	} else { 
		 		$.messager.alert('提示', "保存失败!!!" + result.msg, 'error');   
           }
       }    
	});
}
	

	function endEditing(){
		if (editIndex == undefined){return true}
		if (mygrid.datagrid('validateRow', editIndex)){
			mygrid.datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function myonClickRow(index){
		if (editIndex != index){
			if (endEditing()){
				mygrid.datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				mygrid.datagrid('selectRow', editIndex);
			}
		}
	}
	function append(){
		if (endEditing()){
			mygrid.datagrid('appendRow',{status:'P'});
			editIndex = v_mygrid.datagrid('getRows').length-1;
			mygrid.datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	}
	function removeit(){
		if (editIndex == undefined){return}
		mygrid.datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function accept(){
		if (endEditing()){
			mygrid.datagrid('acceptChanges');
		}
	}
	function reject(){
		mygrid.datagrid('rejectChanges');
		editIndex = undefined;
	}
	function getChanges(){
		var rows = v_mygrid.datagrid('getChanges');
		alert(rows.length+' rows are changed!');
	}
	
</script>
	
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
	    <input type="hidden" id="ajzfwsorderlist" name="ajzfwsorderlist" value="选择的数据"/>
	    
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="">
        		<table class="table" style="width: 99%;">
					<tr>
					  	<td >
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 保存</a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
	                
        	<sicp3:groupbox title="执法办案文书列表">
				<div id="mygrid" style="height:500px;width: 750px;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
		    

</body>
</html>