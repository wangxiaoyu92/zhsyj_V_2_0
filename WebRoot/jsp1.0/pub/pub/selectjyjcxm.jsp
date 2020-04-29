<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测项目</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
//var obj = window.dialogArguments;
//var v_singleSelect=(obj.singleSelect=="true"); 
$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/querySelectjyjcxm',
			striped : true,// 奇偶行使用不同背景色
			//singleSelect:v_singleSelect,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcxmid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '项目ID',
				field : 'jcxmid',
				hidden : true
			},{
				width : '100',
				title : '检查项目编号',
				field : 'jcxmbh',
				hidden : true 
			},{
				width : '100',
				title : '检查项目名称',
				field : 'jcxmmc',
				hidden : false
			},{
				width : '150',
				title : '标准值',
				field : 'jcxmbzz',
				hidden : false
			},{
				width : '150',
				title : '操作员',
				field : 'jcxmczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'jcxmczsj',
				hidden : false
			} 
			] ]
		});
})

	
	function query() {
		var param = {
			'jcxmmc': $('#jcxmmc').val()
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectjyjcxm',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');  
	}

	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = mygrid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	function refresh(){ 
		$('#jcxmmc').val(''); 
	} 
	
   function queding(){
     var rows=mygrid.datagrid('getSelections'); 
	   if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择样品信息！', 'info');
		} 
   }
   
   

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false" style="height:350px;width:800px;">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>检查项目名称</nobr></td>
						<td><input id="jcxmmc" name="jcxmmc" style="width: 200px"/></td>						
						<td colspan="2">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
								&nbsp;&nbsp;&nbsp;&nbsp;								
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>												
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检验检测项目">
				<div id="mygrid" style="height:350px;width:800px;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>