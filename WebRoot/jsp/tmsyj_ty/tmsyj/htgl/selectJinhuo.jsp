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

	// 资质证明
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	var v_spjldw= <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	var v_jcfs= <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	var v_jhhgzmlx=<%=SysmanageUtil.getAa10toJsonArray("JHHGZMLX")%>;
	var v_jhscjyjl=<%=SysmanageUtil.getAa10toJsonArray("JHSCJYJL")%>;
	var v_jhqycyjl=<%=SysmanageUtil.getAa10toJsonArray("JHQYCYJL")%>;

	var cb_comzzzm; // 资质证明
	var mygrid;
	$(function() {
		   mygrid = $('#mygrid').datagrid({
			//title: '进货主表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + '/lhfj/queryLhfjcx',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hjhbid', //该列是一个唯一列
		    nowrap:false,	
		    onLoadSuccess:function(data){
		    	mygrid.datagrid("unselectAll"); 
		    },
			columns : [ [
	        {
				width : '100',
				title : '进货表id',
				field : 'hjhbid',
				hidden : true
			},{
				width : '100',
				title : '商品id',
				field : 'jcypid',
				hidden : true
			},{
				width : '130',
				title : '商品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '80',
				title : '进货数量',
				field : 'jhsl',
				hidden : false
			},{
				width : '120',
				title : '进货计量单位',
				field : 'jhspjldw',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_spjldw,value);
				}				
			},{
				width : '120',
				title : '进货库存量',
				field : 'jhkcl',
				hidden : false
			},{
				width : '100',
				title : '生产地',
				field : 'jhscd',
				hidden : false
			},{
				width : '100',
				title : '上级分销id',
				field : 'jhsjfxid',
				hidden : true
			},{
				width : '70',
				title : '检测方式',
				field : 'jcfs',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jcfs,value);
				}					
			},{
				width : '60',
				title : '单价',
				field : 'jhprice',
				hidden : false
			},{
				width : '100',
				title : '生产日期',
				field : 'jhscrq',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false
			},{
				width : '100',
				title : '生产批次码',
				field : 'jhscpcm',
				hidden : false
			},{
				width : '100',
				title : '合格证明类型',
				field : 'jhhgzmlx',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhhgzmlx,value);
				}					
			},{
				width : '100',
				title : '生产检验结论',
				field : 'jhscjyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhscjyjl,value);
				}						
			},{
				width : '100',
				title : '企业查验结论',
				field : 'jhqycyjl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jhqycyjl,value);
				}					
			},{
				width : '100',
				title : '供应商id',
				field : 'jhgysid',
				hidden : true
			},{
				width : '100',
				title : '供应商',
				field : 'jhgysmc',
				hidden : false
			},{
				width : '100',
				title : '生产商id',
				field : 'jhscsid',
				hidden : true
			},{
				width : '100',
				title : '生产商',
				field : 'jhscsmc',
				hidden : false
			},{
				width : '100',
				title : '商品条码',
				field : 'jhsptm',
				hidden : false
			},{
				width : '100',
				title : '监管主体表id',
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '100',
				title : '进出货类型',
				field : 'jhlx',
				hidden : true
			},{
				width : '100',
				title : 'e票通编号',
				field : 'eptbh',
				hidden : false
			},{
				width : '160',
				title : '操作员',
				field : 'aae011',
				hidden : false
			},{
				width : '110',
				title : '操作时间',
				field : 'aae036',
				hidden : false
			}						
			]]
		});
		
	});/////////////////////////////////////////
	
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
	
	// 查询企业信息
	function myquery() {
		var param = {
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/tmsyjhtgl/queryJinhuo',			
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
	
	</script>
</head>

<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>入库起始时间</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" 
						   class="easyui-datebox"/></td>	
						<td style="text-align:right;"><nobr>入库结束时间</nobr></td>
						<td><input id="aae036end" name="aae036end" style="width: 200px" 
						   class="easyui-datebox"/></td>		
						
						<td colspan="2" style="text-align: right">						  
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myquery()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
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