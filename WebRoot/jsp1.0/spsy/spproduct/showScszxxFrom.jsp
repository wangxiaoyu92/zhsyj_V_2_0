<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次号
	String cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品生产生长信息列表</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);
var mygrid;

$(function() {					
		mygrid = $('#mygrid').datagrid({
			url: basePath + '/spsy/spproduct/queryProductScszxx?proid=<%=proid%>&cppcpch=<%=cppcpch%>',     
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'szgcid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '生产生长信息id',
				field : 'szgcid',
				hidden : true
			},{
				width : '100',
				title : '产品id',
				field : 'proid',
				hidden : true
			},{
				width : '80',
				title : '操作人',
				field : 'szgcczr',
				hidden : false
			},{
				width : '150',
				title : '操作内容',
				field : 'szgccznr',
				hidden : false
			},{
				width : '100',
				title : '操作日期',
				field : 'szgcczrq',
				hidden : false
			},{
				width : '120',
				title : '备注',
				field : 'szgcbz',
				hidden : false
			},{
				width : '100',
				title : '批次号',
				field : 'cppcpch',
				hidden : false
			},{
				width:100,
				title:'操作',
				field:'opt',
				align:'center',
	            formatter:function(value,rec){ 
					  var v_ret = '<a href="javascript:updataScszxx(\''+rec.szgcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/edit.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'
					  	+'<a href="javascript:deleteScszxx(\''+rec.szgcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/cancel.png" align="absmiddle">删除</a>'	;
	                  return  v_ret; 
	             }   
	        }
			] ]
		});
});

// 修改生产生长信息
function updataScszxx(id) {		
	var url = basePath + 'spsy/spproduct/scszxxFromIndex';
	var dialog = parent.sy.modalDialog({
			title : '修改',
			param : {
				szgcid : id
			},
			width : 600,
			height : 300,
			url : url
	},closeModalDialogCallback);
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var obj = sy.getWinRet(dialogID);
	if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
		$("#mygrid").datagrid("reload"); 
	}
	sy.removeWinRet(dialogID);//不可缺少		
}

// 删除生产生长信息
function deleteScszxx(id) {
	$.post(basePath + '/spsy/spproduct/deleteScszxx', {
		szgcid: id
	},
	function(result) {
		if (result.code == '0') {
			$.messager.alert('提示','删除成功！','info',function(){
				$('#mygrid').datagrid('reload'); 
    		});    	
		} else {
			$.messager.alert('提示', "删除失败：" + result.msg, 'error');
		}
	},
	'json');
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="产品生产生长信息">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>