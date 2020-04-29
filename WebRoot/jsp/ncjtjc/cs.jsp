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
	String lscph = StringHelper.showNull2Empty(request.getParameter("lscph"));
%>
<!DOCTYPE html>
<html>
<head>
<title>老师查询</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var lssfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var lsxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var lssf = <%=SysmanageUtil.getAa10toJsonArray("SJSF")%>;	
	var grid;
	
	$(function() {		
		grid = $('#grid').datagrid({
			//title : '老师车辆列表',
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
		    idField: 'lsid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '老师ID',
				field : 'lsid',
				hidden : true
			},{
				width : '200',
				title : '老师编号',
				field : 'lsbh',
				hidden : true
			},{
				width : '100',
				title : '姓名',
				field : 'lsname',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'lslsh',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '姓名拼音码',
				field : 'lspym',
				hidden : true
			},{
				width : '100',
				title : '性别',
				field : 'lsxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lsxb,value);
				}
			},{
				width : '100',
				title : '出生日期',
				field : 'lscsrq',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'lssfzjlx',
				hidden : true,
				formatter : function(value, row) {
					return sy.formatGridCode(lssfzjlx,value);
				}
			},{
				width : '200',
				title : '身份证号',
				field : 'lssfzh',
				hidden : false
			},{
				width : '100',
				title : '老师身份',
				field : 'lssf',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(lssf,value);
				}
			} ] ],
			onDblClickRow : function(rowIndex, rowData){
				//$.messager.alert('提示','暂不支持双击选择!','info');	
			} 
		});
	});

	// 查询
	function query() {
		var lscph = $('#lscph').val();
		var lsname = $('#lsname').val();
		var param = {
			'lscph': lscph,
			'lsname': lsname
		};
		grid.datagrid({
			url : basePath + '/common/lsb/querySj',
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
							<td><input id="lscph" name="lscph" style="width: 200px" value="<%=lscph%>"/></td>			
							<td style="text-align:right;"><nobr>老师姓名</nobr></td>
							<td><input id="lsname" name="lsname" style="width: 200px"/></td>						
						</tr>
						<tr>				
							<td colspan="4" style="text-align:right;">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-search" onclick="query()"> 查 询 </a>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-reload" onclick="reset2()"> 重 置 </a>
							</td>
						</tr>
					</table>
		        </sicp3:groupbox>
	        	<sicp3:groupbox title="老师列表">	        	
					<div id="grid"></div>
		        </sicp3:groupbox>
			</form>
        </div>        
    </div>    
</body>
</html>