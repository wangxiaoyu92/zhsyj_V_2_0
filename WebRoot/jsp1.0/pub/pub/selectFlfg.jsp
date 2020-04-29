<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
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
<title>选择法律法规</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var singleSelect = sy.getUrlParam("singleSelect");
	var v_singleSelect = (singleSelect=="true");
	//下拉框列表（案件大类）
	var ajdjajdl = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
	var v_ajdjajdl;
	var grid;
	
	$(function() {	
		v_ajdjajdl = $('#ajdjajdl').combobox({
			data : ajdjajdl,
			valueField : 'id',
			textField : 'text',
			required : false,
			editable : false,
			panelHeight : 'auto'
		});
		
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url: basePath + 'zfba/wfxw/queryWfxw',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : v_singleSelect,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pwfxwcsid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [
	        {
				width : '100',
				title : '违法行为参数ID',
				field : 'pwfxwcsid',
				hidden : true
			},{
				width : '100',
				title : '违法行为编号',
				field : 'wfxwbh',
				hidden : false
			},{
				width : '300',
				title : '违法行为描述',
				field : 'wfxwms',
				hidden : false
			},{
				width: '150',
				title: '违反法规',
				field: 'wfxwwffg',
				hidden:false
			},{
				width: '100',
				title: '触犯法规',
				field: 'wfxwcffg',
				hidden:false
			},{
				width: '200',
				title: '触犯法规条款',
				field: 'wfxwcffgtk',
				hidden:false
			},{
				width: '150',
				title: '备注',
				field: 'wfxwbz',
				hidden:false
			}
			] ]
		});
	});

	// 查询
	function query() {
		var param = {
			'wfxwbh' : $('#wfxwbh').val(),
			'ajdjajdl' : $('#ajdjajdl').combobox('getValue') 
		};
		grid.datagrid({
			url : basePath + 'zfba/wfxw/queryWfxw',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections');
	}	

	//重置
	var reset2 = function() {
		$('#fm').form('clear');
		grid.datagrid('load', {}); 			
	};

	//选择数据返回
	var getDataInfo = function(){
		var row = grid.datagrid('getSelections');   
	    if(row){
			sy.setWinRet(row);
			parent.$("#"+sy.getDialogId()).dialog("close");
	    }else{
	        $.messager.alert('提示','请先选择数据!','info');
	    }
	}; 

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<form id="fm"  method="post" >
	        	<sicp3:groupbox title="查询条件">
	        		<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>违法编号：</nobr></td>
							<td><input id="wfxwbh" name="wfxwbh" style="width:200px" /></td>
							<td style="text-align:right;"><nobr>案件大类：</nobr></td>
							<td><input id="ajdjajdl" name="ajdjajdl" style="width: 200px"/>
						</tr>
						<tr>
							<td colspan="4" style="text-align:center;">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-search" onclick="query()"> 查 询 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-reload" onclick="reset2()"> 重 置 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton" 
									iconCls="icon-ok" onclick="getDataInfo()">确 定</a>
							</td>
						</tr>
					</table>
		        </sicp3:groupbox>
	        	<sicp3:groupbox title="法律法规列表">	        	
					<div id="grid"></div>
		        </sicp3:groupbox>	
			</form>
        </div>        
    </div>    
</body>
</html>