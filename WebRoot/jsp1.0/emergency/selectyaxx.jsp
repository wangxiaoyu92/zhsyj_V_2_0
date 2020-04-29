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
<title>预案信息登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var singleSelect = sy.getUrlParam("singleSelect");
var v_singleSelect = (singleSelect=="true");
var v_newcate;
var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;
$(function() {			
	
		v_newcate =$('#cateid').combobox({
	    	data:newscate,      
	        valueField:'id',   
	        textField:'text',
	        required:false,
	        editable:false,
	        panelHeight:'auto' 
	    });
	    		
		mygrid = $('#mygrid').datagrid({
			url : basePath + '/emergency/queryEmergencysList',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'newsid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				title: '预案编号',
				field: 'newsid',
				width : '100',
				hidden : false
			},{
				title: '预案标题',
				field: 'newstitle',
				width : '300',
				hidden : false
			}]],			
			columns : [ [ {
				title: '预案内容',
				field: 'newscontent',
				width: '400',
				hidden: true
			},{
				title: '预案来源',
				field: 'newsfrom',
				width: '150',
				hidden : false
			},{
				title: '是否图片预案',
				field: 'newsispicture',
				width: '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "0") {
						return '<span style="color:red">否</span>';
					}else{
						return '<span style="color:blue">是</span>';
					}
				}
			},{
				title: '所属分类',
				field: 'cateid',
				width: '120',
				hidden : false,
				formatter : function(value,row,index){
					return sy.formatGridCode(newscate,value);
				}
			},{
				title: '添加人',
				field: 'newsauthor',
				width: '100',
				hidden : true
			},{
				title: '添加时间',
				field: 'newstjsj',
				width: '150',
				hidden : false
			},{
				title: '是否有效',
				field: 'sfyx',
				width: '100',
				hidden : false,
				formatter: function(value,row,index) {
					if (value == "0") {
						return '<span style="color:red">无效</span>';
					}else{
						return '<span style="color:blue">有效</span>';
					}
				}
			}] ],
		});
});

	
	function query() {
		var param = {
			'cateid': $('#cateid').val(),
			'newstitle': $('#newstitle').val()
		};
		mygrid.datagrid({
			url : basePath + '/emergency/queryEmergencysList',			
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
	        $pjq.messager.alert('提示','请选择预案数据!','info');
	    }
	}; 
	
	function refresh(){
		$('#cateid').val('');
		$('#newstitle').val('');
	} 
	
   function queding(){
     var rows = mygrid.datagrid('getSelections'); 
	   if (rows!="") {
		     sy.setWinRet(rows);
		     parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择预案信息！', 'info');
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
						<td style="text-align:right;"><nobr>预案分类</nobr></td>
						<td><input id="cateid" name="cateid" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>预案标题</nobr></td>
						<td><input id="newstitle" name="newstitle" style="width: 200px" /></td>												
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
        	<sicp3:groupbox title="预案信息列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>