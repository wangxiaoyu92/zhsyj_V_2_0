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
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
//显示当前日期
formatterDate = function (date,kind) {
var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
+ (date.getMonth() + 1);
var hor = date.getHours();
var min = date.getMinutes();
var sec = date.getSeconds();
if (kind==1) {
	hor="00";
	min="00";
	sec="00";
	}
return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
};

	var grid;
	var v_gridmain;
	$(function() {
		$('#startimpczsj').datetimebox('setValue', formatterDate(new Date(),1));
		$('#endimpczsj').datetimebox('setValue', formatterDate(new Date()),2);
		
		v_gridmain = $('#gridmain').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			nowrap : true,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,		
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'impbatchno', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '200',
				title : '操作员',
				field : 'impczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'impczsj',
				hidden : false
			},{
				width : '200',
				title : '批次号',
				field : 'impbatchno',
				hidden : false
			}] ],
			onDblClickRow: function(rowIndex, rowData){
				myquerydetail(rowData.impbatchno);
			}
		});			
		
		grid = $('#grid').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			nowrap : true,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,		
			pagination : true,// 底部显示分页栏
			pageSize : 100,
			pageList : [ 100, 200, 300 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'jcjgid', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [{
				width : '100',
				title : '仪器类别',
				field : 'impyqlb',
				hidden : false
			},{
				width : '60',
				title : '编号',
				field : 'impbh',
				hidden : false
			},{
				width : '100',
				title : '样品种类',
				field : 'impypzl',
				hidden : false
			},{
				width : '100',
				title : '样品名称',
				field : 'impypmc',
				hidden : false
			},{
				width : '100',
				title : '检测项目',
				field : 'impjcxm',
				hidden : false
			},{
				width : '80',
				title : '含量',
				field : 'imphl',
				hidden : false
			},{
				width : '70',
				title : '检测结果',
				field : 'impjcjg',
				hidden : false
			},{
				width : '70',
				title : '所属区域',
				field : 'impssqy',
				hidden : false
			},{
				width : '100',
				title : '用户名称',
				field : 'impyhmc',
				hidden : false
			},{
				width : '120',
				title : '被检企业',
				field : 'impbjqy',
				hidden : false
			},{
				width : '80',
				title : '产品商标',
				field : 'impcpsb',
				hidden : false
			},{
				width : '100',
				title : '产品批次',
				field : 'impcppc',
				hidden : false
			},{
				width : '80',
				title : '产品规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '100',
				title : '生产厂家',
				field : 'impsccj',
				hidden : false
			},{
				width : '100',
				title : '抽样时间',
				field : 'impcysj',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'impjcsj',
				hidden : false
			},{
				width : '100',
				title : '检测人员',
				field : 'impjcry',
				hidden : false
			},{
				width : '100',
				title : '备注',
				field : 'impbz',
				hidden : false
			},{
				width : '70',
				title : '补充1',
				field : 'impbc1',
				hidden : false
			},{
				width : '70',
				title : '补充2',
				field : 'impbc2',
				hidden : false
			},{
				width : '130',
				title : '入库日期',
				field : 'imprkrq',
				hidden : false
			}] ]
		});		
	});////////////////////////////////////////////
	// 查询主要信息
	function query() {
		var mygrid=$("#gridmain");
		var param = {
			'startimpczsj': $('#startimpczsj').datetimebox('getValue'),
			'endimpczsj': $('#endimpczsj').datetimebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/jyjc/queryJyjcUploadDataMain',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
	}
	
	// 查询明细信息
	function myquerydetail(v_impbatchno) {
		var mygriddetail=$("#grid");
		var param = {
			'impbatchno': v_impbatchno
		};
		mygriddetail.datagrid({
			url : basePath + '/jyjc/queryJyjcUploadData',			
			queryParams : param
		});
		mygriddetail.datagrid('clearSelections');
	}	
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 	

</script>
</head>
<body >
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>开始时间:</nobr></td>
						<td><input id="startimpczsj" name="startimpczsj" style="width: 150px" 
						class="easyui-datetimebox"  /></td>					
						<td style="text-align:right;"><nobr>结束时间:</nobr></td>
						<td><input id="endimpczsj" name="endimpczsj" style="width: 150px" 
						class="easyui-datetimebox" /></td>								
					</tr>
					<tr>	
						<td colspan="4">
						   <div align="right">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						    </div>		
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="上传记录(双击可以查看明细)">
				<div id="gridmain" style="height:150px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        	<sicp3:groupbox title="上传明细">
				<div id="grid" style="height:300px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>