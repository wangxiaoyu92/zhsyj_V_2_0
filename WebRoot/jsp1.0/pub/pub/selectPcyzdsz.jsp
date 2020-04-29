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
var v_tabname=sy.getUrlParam("tabname");
var v_colname=sy.getUrlParam("colname");

$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/queryPcyzdsz',     
			queryParams: {
				tabname:v_tabname,
				colname:v_colname
				},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			onLoadSuccess:function(data){
					$(this).datagrid('clearSelections');
			},
			onDblClickRow:function(rowIndex, rowData){
				queding();
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 20, 40, 60 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'pcyzdszdetailid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : 'ID',
				field : 'pcyzdszdetailid',
				hidden : true
			},{
				width : '100',
				title : '大类',
				field : 'aae140',
				hidden : true
			},{
				width : '450',
				title : '值',
				field : 'avalue',
				hidden : false
			}
			] ]
		});
});
	
	function queding(){
    	var rows=mygrid.datagrid('getSelections'); 
	   	if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close");
		}else{
			$.messager.alert('提示', '请先选择企业信息！', 'info');
		} 
   	}
   
	function addLiebiaozhi(){
		var url = basePath + "jsp/pub/pub/pcyzdszmain.jsp";
	    var dialog = parent.sy.modalDialog({ 
			title : '添加列表值',
			param : {
				singleSelect : "true",
				tabname : "",
				colname : "",
				time : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
		},function(dialogID){
			var v_retStr = sy.getWinRet(dialogID); 
		    if (v_retStr.type!=null && "ok"==v_retStr.type){
		    	$("#mygrid").datagrid("reload");
		    }
			sy.removeWinRet(dialogID);
		});
	}   
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="">
        		<table class="table" style="width: 99%;">
					<tr>
					  	<td >
							<div align="center">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-search" onclick="queding()"> 确定</a>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
									iconCls="icon-add" onclick="addLiebiaozhi()"> 新增列表值</a>																
							</div>					  	
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="数据列表">
				<div id="mygrid" style="height:500px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>