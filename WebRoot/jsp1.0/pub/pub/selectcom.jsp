<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
	 String aaa102 = StringHelper.showNull2Empty(request.getParameter("aaa102"));
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
var v_comjyjcbz=sy.IsNull(sy.getUrlParam("comjyjcbz"));
$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/querySelectcom',     
			queryParams: {
				comjyjcbz:v_comjyjcbz,
				comdalei:'<%=aaa102%>'
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
		    idField: 'comid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
            {
				width : '100',
				//title : '企业ID',
				checkbox:'true',
				field : 'comid',
				hidden : false
			},{
				width : '100',
				title : '企业代码',
				field : 'comdm',
				hidden : true
			},{
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '150',
				title : '企业大类',
				field : 'comdalei',
				hidden : true
			},{
				width : '150',
				title : '企业大类',
				field : 'comdaleistr',
				hidden : false
			},{
				width : '100',
				title : '许可证编号',
				field : 'comxkzbh',
				hidden : false
			},{
				width : '80',
				title : '企业法人/业主',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '100',
				title : '企业法人/业主身份证号',
				field : 'comfrsfzh',
				hidden : false
			} ,{
				width : '80',
				title : '企业负责人',
				field : 'comfzr',
				hidden : false
			} ,{
				width : '120',
				title : '固定电话',
				field : 'comgddh',
				hidden : false
			},{
				width : '120',
				title : '移动电话',
				field : 'comyddh',
				hidden : false
			},{
				width : '120',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			}
			] ]
		});
})

	
	function query() {
		var param = {
			'comdm': $('#comdm').val(),
			'commc': $('#commc').val(),
			'comjyjcbz':v_comjyjcbz
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectcom',			
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
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	function refresh(){
		//parent.window.refresh();
		$('#comdm').val('');
		$('#commc').val('');
	} 
	
   function queding(){
     var rows=mygrid.datagrid('getSelections'); 
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
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" /></td>												
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