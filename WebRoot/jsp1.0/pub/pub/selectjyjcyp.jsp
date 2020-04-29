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
<title>检测检验样品</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
//var obj = window.dialogArguments;
//var v_singleSelect=(obj.singleSelect=="true");
	//检测检验类别
	var v_jcjylb= <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
	$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/querySelectjyjcyp',
			striped : true,// 奇偶行使用不同背景色
			//singleSelect:v_singleSelect,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcypid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '样品ID',
				field : 'jcypid',
				hidden : true
			},{
				width : '100',
				title : '检查样品类别',
				field : 'jcyplb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_jcjylb,value);
				}
			},{
				width : '100',
				title : '检查样品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '150',
				title : '操作员',
				field : 'jcypczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'jcypczsj',
				hidden : false
			} 
			] ]
		});
})

	
	function query() {
		var param = {
			'jcypmc': $('#jcypmc').val()
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectjyjcyp',			
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
		$('#jcypmc').val(''); 
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
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>检验检测名称</nobr></td>
						<td><input id="jcypmc" name="jcypmc" style="width: 200px"/></td>						
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
        	<sicp3:groupbox title="检验检测样品">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>