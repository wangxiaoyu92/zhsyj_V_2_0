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
<title>主体客户关系</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var singleSelect = sy.getUrlParam("singleSelect");
var v_singleSelect=(singleSelect=="true");
var v_comjyjcbz=sy.getUrlParam("comjyjcbz");

$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/queryHviewjgzt',     
			queryParams: {
				comjyjcbz:v_comjyjcbz
				},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:v_singleSelect,//True 就会只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,	
			onLoadSuccess:function(data){
					$(this).datagrid('clearSelections');
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hviewjgztid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
            {
				width : '100',
				title : '企业ID', 
				field : 'hviewjgztid',
				hidden : true
			},{
				width : '100',
				title : '统筹区', 
				field : 'aaa027',
				hidden : true
			},{
				width : '100',
				title : '主体客户代码',
				field : 'jgztbh',
				hidden : false
			},{
				width : '200',
				title : '主体客户名称',
				field : 'jgztmc',
				hidden : false
			},{
				width : '150',
				title : '主体客户简称',
				field : 'jgztmcjc',
				hidden : true
			},{
				width : '150',
				title : '联系人',
				field : 'jgztlxr',
				hidden : false
			},{
				width : '150',
				title : '监管范围',
				field : 'jgztfwnfww',
				hidden : false,
				formatter :function (value, rec){
		          	if(value==1){
		          	return rec.jgztfwnfww="范围内"; 
		          	}else{
		          	return rec.jgztfwnfww="范围外"; 
		          	}
		          }
			},{
				width : '100',
				title : '资质证明',
				field : 'jgztzzzmmc',
				hidden : false
			},{
				width : '100',
				title : '资质证明编号',
				field : 'jgztzzzmbh',
				hidden : false 
			} ,{
				width : '120',
				title : '固定电话',
				field : 'jgztlxrgddh',
				hidden : false
			},{
				width : '120',
				title : '移动电话',
				field : 'jgztlxryddh',
				hidden : false
			},{
				width : '120',
				title : '企业地址',
				field : 'jgzttxdz',
				hidden : false
			}
			] ]
		});
})

	
	function query() {
		var param = {
			'jgztbh': $('#jgztbh').val(),
			'jgztmc': $('#jgztmc').val() 
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/queryHviewjgzt',			
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
	        $pjq.messager.alert('提示','请选择客户数据!','info');
	    }
	}; 
	
	function refresh(){
		//parent.window.refresh();
		$('#jgztbh').val('');
		$('#jgztmc').val('');
	} 
	
   function queding(){
     var rows=mygrid.datagrid('getSelections'); 
	   if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择客户信息！', 'info');
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
						<td style="text-align:right;"><nobr>主体客户编号</nobr></td>
						<td><input id="jgztbh" name="jgztbh" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>主体客户名称</nobr></td>
						<td><input id="jgztmc" name="jgztmc" style="width: 200px" /></td>												
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
        	<sicp3:groupbox title="企业列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>