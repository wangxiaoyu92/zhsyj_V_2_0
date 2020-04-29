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
<title>检查计划管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var singleSelect = sy.getUrlParam("singleSelect");
	var v_singleSelect = (singleSelect=="true");
	//下拉框列表
	var grid;
	var url ="<%=basePath%>/supervision/queryPlan";
	$(function() {
		grid = $('#grid').datagrid({
			url :url,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'planid', //该列是一个唯一列
		    sortOrder: 'desc',
		    singleSelect:v_singleSelect,//True 就会只允许选中一行
		    frozenColumns : [[ {
				title: '计划id',
				field: 'planid',
				width : '100',
				checkbox:'true',
				hidden : false
			}]],			
			columns : [ [ {
				title: '名称',
				field: 'plantitle',
				width : '150',
				hidden : false
			},{
				title: '编号',
				field: 'plancode',
				width: '150'
			},{
				title: '检查类别',
				field: 'planchecktype',
				width: '150',
				formatter: function(value,row,index) { 
					if (value == "0") {
						return '<span style="color:blue">量化</span>';
					} else if (value == "1"){
						return '<span style="color:blue">日常</span>';
					}else if (value == "2"){
						return '<span style="color:blue">专项</span>';
					} else {
						return '<span style="color:blue">量化</span>';
					}
				}
			},{
				title: '计划类型',
				field: 'plantype',
				width: '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "1") {
						return '<span style="color:blue">按类别</span>';
					}else if (value == "2"){
						return '<span style="color:blue">按区域</span>';
					} else {
						return '<span style="color:blue">按特定对象</span>';
					}
				}
			},{
				title: '开始时间',
				field: 'planstdate',
				width: '120',
				hidden : false
			},{
				title: '结束时间',
				field: 'planeddate',
				width: '100',
				hidden : false
			},{
				title: '经办时间',
				field: 'planoperatedate',
				width: '100',
				hidden : false
			},{
				title: '经办人',
				field: 'planoperator',
				width: '150',
				hidden : true
			}
			] ]
		});
	});
	
	function query() {
		var plantype = $("#plantype").val(); 
		var planstdate = $('#planstdate').val();
	    var planeddate = $('#planeddate').val();
		var plantitle = $('#plantitle').val();
		var param = {
			'plantype': plantype,
			'planstdate': planstdate,
			'planeddate': planeddate,
			'plantitle': plantitle
		};
		$('#grid').datagrid('load', param);
		$('#grid').datagrid('clearSelections');	
	}
	
	function refresh(){
		parent.window.refresh();	
	} 

	
	//查看信息
	var showPlan = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看计划信息',
				width :1040,
				height :560,
				url : basePath +'/supervision/updatePlansIndex?op=view&planid='+row.planid,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		} else {
			$.messager.alert('提示','请先选择要查看的计划信息！','info');
		}
	};
	
	
	//获取计划列表（itemid 为企业类型）
	function getPlan(){
		var row = $('#grid').datagrid('getSelected');
			$.post(basePath + '/common/sjb/updateResultByid', {
					resultid: '2016061501195689126103926'
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata =result.data;
				} 
			}, 'json');
	}

	//审核窗口打开
	function checkPlan() {
		var row = $('#grid').datagrid('getSelected');
		if(row){
	 		$('#ReceiveFeedBackDialog').dialog('open');
		} else {
			$.messager.alert('提示','请先选择要审核的计划！','info');
		}
   
	}    
    //审核窗口关闭
	function closeDialog() {
    	$('#ReceiveFeedBackDialog').dialog('close');
	}	
	function formSubmit(){
		var row = $('#grid').datagrid('getSelected');
		var checkitem =$('#checkitem').val();
		//后台提交
		$.post(basePath + 'supervision/saveCheckPlan', {
				planid : row.planid,
				checkid : checkitem
		}, 
		function(result) {
			if (result.code=='0') {
				//刷新列表
			} 
		}, 'json');
	}
	
	   function queding(){
		     var rows=grid.datagrid('getSelections'); 
			   if (rows!="") {
				   sy.setWinRet(rows);
				   parent.$("#"+sy.getDialogId()).dialog("close");
				}else{
					$.messager.alert('提示', '请先选择企业信息！', 'info');
				} 
		   }
	   
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>计划名称</nobr></td>
						<td><input id="plantitle" name="plantitle" style="width: 200px"/></td>						
						<td style="text-align:left;"><nobr>类型&nbsp;&nbsp;</nobr>
						<select name="plantype" id="plantype">
						<option value="">--请选择--</option>
						<option value="1">按类别</option>
						<option value="2" >按区域</option>
						<option value="3">按特定对象</option>
						</select></td>							
						
					</tr>
					
					<tr>
						<td style="text-align:right;">
						<nobr>执法时间</nobr>
				</td>
				<td>
					<input type="text" id="planstdate" name="planstdate"    onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'planeddate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 					
						&nbsp;-&nbsp; <input type="text" id="planeddate" name="planeddate"    onFocus="WdatePicker({minDate:'#F{$dp.$D(\'planstdate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 
					</td>
						<td>
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
        	<sicp3:groupbox title="检查计划列表">
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
    
    <!-- 审核弹出框 -->
	<div id="ReceiveFeedBackDialog" class="easyui-dialog" closed="true" buttons="#dlg-buttons" title="审核信息" style="width:400px;height:30px;">
      <div align="center" style="width:350px;height:30px;">
      <input type="radio"  name="checkitem"  id="checkitem"  value="1" checked="checked" />通过
       <input type="radio" name="checkitem"  id="checkitem" value="0" />不通过
<!--       <select id="checktext" style="width:80px;" class="easyui-combobox" data-options="panelHeight:'auto' ,required:true" name="checktext" >             -->
<!--         <option value="">请选择</option>   -->
<!--         <option value="1">通过</option>   -->
<!--         <option value="2">不通过</option>   -->
<!--    </select> -->

 </div> 
</div> 
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" onclick="formSubmit();">确定</a> 
        <a href="#" class="easyui-linkbutton" onclick="closeDialog();">关闭</a>
    </div>	
</body>
</html>