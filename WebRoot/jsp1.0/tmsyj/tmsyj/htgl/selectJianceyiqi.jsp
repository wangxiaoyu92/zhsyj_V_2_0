<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
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
<title>选择进货信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryJianceyiqi',	
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 30,
			pageList : [ 30, 60, 90 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjcjgjcyqbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '检测机构检测仪器表id',
				field : 'hjcjgjcyqbid',
				hidden : true
			},{
				width : '100',
				title : '监管主体id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '130',
				title : '检测仪器名称',
				field : 'jcyqmc',
				hidden : false
			},{
				width : '110',
				title : '检测仪器型号',
				field : 'jcyqxh',
				hidden : false
			},{
				width : '120',
				title : '检测仪器序列号',
				field : 'jcyqxlh',
				hidden : false			
			},{
				width : '150',
				title : '检测仪器购买日期',
				field : 'jcyqgmrq',
				hidden : false
			},{
				width : '150',
				title : '检测仪器生产日期',
				field : 'jcyqscrq',
				hidden : false
			},{
				width : '150',
				title : '检测仪器生产厂家',
				field : 'jcyqsccj',
				hidden : false
			},{
				width : '150',
				title : '检测仪器检测项目',
				field : 'jcyqjcxm',
				hidden : false
			},{
				width : '150',
				title : '检测仪器产品用途',
				field : 'jcyqcpyt',
				hidden : false
			},{
				width : '120',
				title : '操作员',
				field : 'aae011',
				hidden : false
			},{
				width : '130',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			}			
			]]
		});
		
	});/////////////////////////////////////////
	
	// 查询企业信息
	function myquery() {
		mygrid.datagrid('reload');
	}	
	
/*    function queding(){
	     var rows=mygrid.datagrid('getSelections'); 
		   if (rows!="") {
				 window.returnValue=rows;
				 window.close(); 
			}else{
				$.messager.alert('提示', '请先选择记录！', 'info');
			} 
   } */	
   
   
   // 保存 
	var queding = function($dialog) {
	    var rows = mygrid.datagrid('getSelections'); 
		if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close"); 			 
		}else{
			$.messager.alert('提示', '请先选择记录！', 'info');
		} 
	}; 

	// 关闭窗口
	var closeWindow = function($dialog){
    	$dialog.dialog('close');
	};
	    	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>  
</body>
</html>