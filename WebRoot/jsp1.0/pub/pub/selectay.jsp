<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var singleSelect = sy.getUrlParam("singleSelect");
var v_singleSelect = (singleSelect=="true");
// 案件登记案件大类
var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
$(function() {			

	   // 案件登记案件大类
	   $('#aae140').combobox({
	    	data : v_aae140,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });		
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/querySelectay',
			striped : true,// 奇偶行使用不同背景色
			singleSelect: v_singleSelect,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pwfxwcsid', //该列是一个唯一列
		    sortOrder: 'asc',
		    nowrap:false,			
			columns : [ [ {
				width : '80',
				title : '违法行为参数ID',
				field : 'pwfxwcsid',
				hidden : true
			},{
				width : '80',
				title : '案件大类',
				field : 'ajdjajdl',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_aae140,value);
				}
			},{
				width : '80',
				title : '违法行为编号',
				field : 'wfxwbh',
				hidden : true
			},{
				width : '300',
				title : '违法行为描述',
				field : 'wfxwms',
				hidden : false,
				nowrap:false
			},{
				width : '100',
				title : '违反法规',
				field : 'wfxwwffg',
				hidden : false
			},{
				width : '150',
				title : '违反条款',
				field : 'wfxwwftk',
				hidden : false
			},{
				width : '300',
				title : '违反条款内容',
				field : 'wfxwwftknr',
				hidden : false
			},{
				width : '100',
				title : '处罚法规',
				field : 'wfxwcffg',
				hidden : false
			} ,{
				width : '150',
				title : '处罚法规条款',
				field : 'wfxwcffgtk',
				hidden : false
			} ,{
				width : '120',
				title : '处罚法规条款内容',
				field : 'wfxwcffgtknr',
				hidden : false
			},{
				width : '750',
				title : '处罚内容',
				field : 'wfxwcfnr',
				hidden : false
			},{
				width : '240',
				title : '备注',
				field : 'wfxwbz',
				hidden : false
			}
			] ]
		});
});

	// 查询
	function query() { 
		var param = {
			'wfxwbh': $('#wfxwbh').val(),
			'wfxwms': $('#wfxwms').val(),
			'wfxwwftk': $('#wfxwwftk').val(),
			'ajdjajdl': $('#aae140').combobox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectay',			
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
	        $pjq.messager.alert('提示','请选择数据!','info');
	    }
	}; 
	// 刷新
	function refresh(){
		$('#wfxwbh').val('');
		$('#wfxwms').val('');
		$('#aae140').combobox('setValue','');
	} 
	
   function queding(){
     var rows = mygrid.datagrid('getSelections'); 
	   if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择违法行为信息！', 'info');
		} 
   }
   
   

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
        		<!-- 违法行为编号隐藏了 -->
        		    <!-- <tr style="display: none;">
						<td style="text-align:right;"><nobr>违法行为编号</nobr></td>
						<td><input id="wfxwbh" name="wfxwbh" style="width: 200px"/></td>						
        		    </tr> -->
					<tr>
						<td style="text-align:right;"><nobr>违法行为描述</nobr></td>
						<td><input id="wfxwms" name="wfxwms" style="width: 200px" /></td>												
					  <td style="text-align:right;"><nobr>案件大类</nobr></td>
					  <td><input id="aae140" name="aae140" style="width: 200px" /></td>
					</tr>
					<tr> 
					  <td style="text-align:right;"><nobr>违反条款</nobr></td>
						<td><input id="wfxwwftk" name="wfxwwftk" style="width: 200px" /></td>	
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
        	<sicp3:groupbox title="违法行为参数列表">
				<div id="mygrid" style="height:450px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>