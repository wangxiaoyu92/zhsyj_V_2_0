<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_procomid = StringHelper.showNull2Empty(request.getParameter("procomid"));
	String v_proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	String v_cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>添加产品耗材</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var editIndex = undefined;
$(function() { 
	$('#mygrid').datagrid({
	    title:'产品批次',
	    iconCls:'icon-ok',
	    width:900,
	    height:460,
	    pageSize:10,
	    pageList:[10,20,30],
	    nowrap:true,//True 就会把数据显示在一行里
	    striped:true,//奇偶行使用不同背景色
	    collapsible:true,
	    selectOnCheck:true,
	    //checkOnSelect:false,
	    singleSelect:false,//True 就会只允许选中一行
	    fitColumns: true,
	    fit:false,//让DATAGRID自适应其父容器
	    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
	    pagination:true,//底部显示分页栏
	    rownumbers:true,//是否显示行号
	    url:'<%=basePath%>spsy/cphc/queryCphcSycl',
	    queryParams:{
	    	procomid:'<%=v_procomid%>',
	    	proid:'<%=v_proid%>'
	    },
	    loadMsg:'数据加载中,请稍后...',   
	    //sortName:'code',
	    sortOrder:'desc',
	    remoteSort:false,
	    onClickRow:function(rowIndex,rowData){
	    	onmyClickRow(rowIndex);
	    },
	    columns:[[
             {title:'产品材料id',field:'qledgerstockid',align:'center',width:100,hidden:'true'},
            {title:'供应商id',field:'lgfromcomid',align:'center',width:100,checkbox:'true'},
			{title:'供应商名称',field:'commc',align:'center',width:100,hidden:'true'},
			{title:'材料ID',field:'lgproid',align:'center',width:100},	
			{title:'材料名称',field:'lgproname',align:'left',width:120},
			{title:'进货量',field:'lgprojysl',align:'left',width:120},
			{title:'剩余量',field:'lgprosysl',align:'left',width:80},
			{title:'货物单位',field:'lgprojydwmc',align:'left'	,width:80},
			{title:'使用量',field:'probcxhl',align:'left',width:80,			
				editor:{type:'numberbox',options:{precision:2}} }
		]]
	   }); 	
}); 

function endEditing(){
	if (editIndex == undefined){return true;}
	if ($('#mygrid').datagrid('validateRow', editIndex)){
		$('#mygrid').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}

function onmyClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			$('#mygrid').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#mygrid').datagrid('selectRow', editIndex);
		}
	}
}

//编辑状态
function mydatagrid_endEditing(v_datagrid){
	var editIndex = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	//如果某一行处于校验状态，那么这一行处于编辑状态
	if(v_datagrid.datagrid('validateRow',editIndex)){
		var ed = v_datagrid.datagrid('getEditor',{index:editIndex});  //根据行索引得到编辑器
		v_datagrid.datagrid('endEdit',editIndex);
		return true;
	}else{
		return false;
	}
}

/**
 * 保存
 */
function mysave(){
	var url= basePath+'/spsy/cphc/cphcAddSave';
	parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
		
	mydatagrid_endEditing($('#mygrid'));
    var v_wpqdmx_rows = $('#mygrid').datagrid('getChecked');
    $('#probcxhlGridStr').val($.toJSON(v_wpqdmx_rows));
	$('#cphcAddfm').form('submit',{
		url: url,
		onSubmit: function(){ 
			// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			var isValid = $(this).form('validate'); 
			if(!isValid){
				// 如果表单是无效的则隐藏进度条
				parent.$.messager.progress('close');	 
			}					
			return isValid;
        }, success: function(result){
        	parent.$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
				$.messager.alert('提示','保存成功！','info');
				window.returnValue="ok";
			 	closeWindow();			 		
           	} else {
				$.messager.alert('提示','保存失败:'+ result.msg,'error');
            }
        }    
	});
}
// 关闭窗口
function closeWindow() {
	parent.$("#"+sy.getDialogId()).dialog("close");
}
</script>

</head>
<body>
	<form id="cphcAddfm" name="cphcAddfm" method="post">
		<input type="hidden" id="procomid" name="procomid" value="<%=v_procomid%>"/>
		<input type="hidden" id="proid" name="proid" value="<%=v_proid%>"/>
		<input type="hidden" id="cppcid" name="cppcid" value="<%=v_cppcid%>"/>
		<input type="hidden" id="probcxhlGridStr" name="probcxhlGridStr"/>
	   	<div id="mygrid" style="height:350px;overflow:auto;"></div>
	</form>
	<table>
		<tr>
			<td style="width: 300px;"></td>
		  	<td>
		    	<div align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-save" onclick="mysave();"> 保存 </a>	
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-back" onclick="closeWindow()"> 取消 </a>
						&nbsp;&nbsp;&nbsp;		
				</div>														     
		  	</td>
		</tr>									
	</table>
</body>
</html>