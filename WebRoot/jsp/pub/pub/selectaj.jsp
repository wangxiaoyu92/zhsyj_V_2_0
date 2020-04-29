<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>


<title>选择案件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_ajzt2=obj.ajzt;
var v_ajzt2 = sy.getUrlParam("ajzt");


var ajlagrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
$(function() {					
		ajlagrid = $('#ajlagrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/pub/querySelectaj',
		    queryParams:{
			    ajzt:v_ajzt2
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ajdjid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '案件登记ID',
				field : 'ajdjid',
				hidden : true
			},{
				width : '100',
				title : '案件状态',
				field : 'ajzt',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_ajzt,value);
				}
			},{
				width : '100',
				title : '企业代码',
				field : 'comdm',
				hidden : false
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '80',
				title : '企业法人',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '100',
				title : '企业法人身份证号',
				field : 'comfrsfzh',
				hidden : false
			} ,{
				width : '80',
				title : '联系电话',
				field : 'comyddh',
				hidden : false
			} ,{
				width : '120',
				title : '案发时间',
				field : 'ajdjafsj',
				hidden : false
			},{
				width : '120',
				title : '案由',
				field : 'ajdjay',
				hidden : false
			},{
				width : '120',
				title : '案件来源',
				field : 'ajdjajly',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_AJDJAJLY,value);
				}
			}
			] ]  
		});
		
});

	//查询
	function query() {
		var param = {
			'comfrhyz': $('#comfrhyz').val(),
			'commc': $('#commc1').val(),
			'ajzt':v_ajzt2
		};
		ajlagrid.datagrid({
			url : basePath + '/pub/querySelectaj',			
			queryParams : param
		}); 
		ajlagrid.datagrid('clearSelections');
	}
	//重置
	function refresh(){
		//parent.window.refresh();
		$('#comdm').val('');
		$('#commc').val('');
	} 
	
	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = ajlagrid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	
	 
	
	
   function queding(){
     var rows=ajlagrid.datagrid('getSelections');
      if (rows!="") {
		  sy.setWinRet(rows);
		  parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择案件登记记录！', 'info');
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
						<td style="text-align:right;"><nobr>企业法人</nobr></td>
						<td><input id="comfrhyz" name="comfrhyz" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc1" name="commc" style="width: 200px" /></td>												
					</tr>
					<tr>
					  <td colspan="2"></td>
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
			<sicp3:groupbox title="案件列表">
				<div id="ajlagrid" style="height:350px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
	</div>
</body>
</html>
