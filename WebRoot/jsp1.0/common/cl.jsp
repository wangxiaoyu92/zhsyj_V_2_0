<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String clcph = StringHelper.showNull2Empty(request.getParameter("clcph"));
%>
<!DOCTYPE html>
<html>
<head>
<title>车辆查询</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表	
	var clcd = <%=SysmanageUtil.getAa10toJsonArray("CLCD")%>;
	var cllx = <%=SysmanageUtil.getAa10toJsonArray("CLLX")%>;
	var clrllx = <%=SysmanageUtil.getAa10toJsonArray("CLRLLX")%>;
	var clsf = <%=SysmanageUtil.getAa10toJsonArray("CLSF")%>;
	var grid;
	
	$(function() {		
		grid = $('#grid').datagrid({
			//title : '司机车辆列表',
			//iconCls : 'icon-tip',
			url : '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'clid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '车辆ID',
				field : 'clid',
				hidden : false
			},{
				width : '100',
				title : '车牌号',
				field : 'clcph',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '车辆长度（米）',
				field : 'clcd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(clcd,value);
				}
			},{
				width : '100',
				title : '车辆载重（吨）',
				field : 'clzz',
				hidden : false
			},{
				width : '150',
				title : '车辆最大载重（吨）',
				field : 'clzdzz',
				hidden : false
			},{
				width : '100',
				title : '车辆类型',
				field : 'cllx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cllx,value);
				}
			},{
				width : '100',
				title : '燃料类型',
				field : 'clrllx',
				hidden : false,
				formatter : function(value,row,index){
					return sy.formatGridCode(clrllx,value);
				}
			},{
				width : '100',
				title : '车辆身份',
				field : 'clsf',
				hidden : false,
				formatter : function(value,row,index){
					return sy.formatGridCode(clsf,value);
				}
			} ] ],
			onDblClickRow : function(rowIndex, rowData){
				//$.messager.alert('提示','暂不支持双击选择!','info');	
			} 
		});
	});

	// 查询
	function query() {
		var clcph = $('#clcph').val();
		var param = {
			'clcph': clcph
		};
		grid.datagrid({
			url : basePath + '/common/sjb/queryCl',
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}	

	//重置
	var reset2 = function() {
		$('#fm').form('clear');
		grid.datagrid('loadData',{total:0,rows:[]}); 			
	};

	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = grid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
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
							<td style="text-align:right;"><nobr>车牌号</nobr></td>
							<td><input id="clcph" name="clcph" style="width: 200px" value="<%=clcph%>"/></td>							
							<td>
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-search" onclick="query()"> 查 询 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-reload" onclick="reset2()"> 重 置 </a>
							</td>
						</tr>
					</table>
		        </sicp3:groupbox>
	        	<sicp3:groupbox title="车辆列表">	        	
					<div id="grid"></div>
		        </sicp3:groupbox>
			</form>
        </div>        
    </div>    
</body>
</html>