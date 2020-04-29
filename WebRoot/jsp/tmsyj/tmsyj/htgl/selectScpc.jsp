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
<title>选择生产批次</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

//食品计量单位
var v_spjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
//食品生产检验结论
var v_cpscjyjl = <%=SysmanageUtil.getAa10toJsonArray("CPSCJYJL")%>;
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url : basePath + '/tmsyjhtgl/queryScpc',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hscpcbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '生产批次表id',
				field : 'hscpcbid',
				hidden : true
			},{
				width : '100',
				title : '监管主体表id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '100',
				title : '产品id',
				field : 'jcypid',
				hidden : true
			},{
				width : '100',
				title : '产品名称',
				field : 'jcypmc'
			},{
				width : '100',
				title : '生产批次号',
				field : 'scpch'
			},{
				width : '100',
				title : '商品条码',
				field : 'sptm'
			},{
				width : '100',
				title : '生产日期',
				field : 'scrq'
			},{
				width : '100',
				title : '保质日期',
				field : 'bzrq'
			},{
				width : '150',
				title : '产品检验报告编号',
				field : 'spjybgbh'
			},{
				width : '130',
				title : '检验执行标准号',
				field : 'jyzxbzh'
			},{
				width : '90',
				title : '检验日期',
				field : 'jyrq'
			},{
				width : '120',
				title : '产品生产检验结论',
				field : 'cpscjyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_cpscjyjl,value);
				}				
			},{
				width : '70',
				title : '生产数量',
				field : 'scsl',
				hidden : false				
			},{
				width : '70',
				title : '剩余数量',
				field : 'sysl',
				hidden : false				
			},{
				width : '70',
				title : '计量单位',
				field : 'scspjldw',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_spjldw,value);
				}				
			},{
				width : '70',
				title : '计量单位',
				field : 'scspjldwmc',
				hidden : false				
			},{
				width : '70',
				title : '操作员',
				field : 'aae011',
				hidden : false				
			},{
				width : '70',
				title : '操作时间',
				field : 'aae036',
				hidden : false				
			}					
			]],
			toolbar: '#toolbar'
		});
	});/////////////////////////////////////////
	
	// 查询企业信息
	function myquery() {
		var param = {
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryScpc',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
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
 			 closeWindow($dialog); 				 
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
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>生产起始时间</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" 
						   class="easyui-datebox"/></td>	
						<td style="text-align:right;"><nobr>生产结束时间</nobr></td>
						<td><input id="aae036end" name="aae036end" style="width: 200px" 
						   class="easyui-datebox"/></td>		
						
						<td colspan="2" style="text-align: right">						  
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myquery()"> 查 询 </a>
						</td>						
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="进货列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>  
</body>
</html>