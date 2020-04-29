<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	
%>
<!DOCTYPE html>
<html>
<head>
<title>案件办理日志</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
var mygrid;

$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			height:520,
			toolbar: '#toolbar',
			url: basePath + '/workflow/queryYwlclog',
		    queryParams:{
			    ywbh:'<%=v_ywbh%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 15,
			pageList : [ 15, 30, 45 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ywlclogid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [[ {
				width : '100',
				title : '工作流名称',
				field : 'psmc',
				hidden : true
			},{
				width : '150',
				title : '企业名称(当事人)',
				field : 'commc',
				hidden : false
			},{
				width : '120',
				title : '环节名称',
				field : 'nodename',
				hidden : false
			},{
				width : '120',
				title : '选择流向',
				field : 'transname',
				hidden : false
			},{
				width : '150',
				title : '审核意见',
				field : 'transyy',
				hidden : false
			},{
				width : '70',
				title : '经办人',
				field : 'aae011',
				hidden : false
			} ,{
				width : '125',
				title : '经办时间',
				field : 'aae036',
				hidden : false
			} ,{
				width : '120',
				title : '节点时限开始时间',
				field : 'nodesxbegin',
				hidden : false
			},{
				width : '120',
				title : '节点时限结束时间',
				field : 'nodesxend',
				hidden : false
			},{
				width : '175',
				title : '业务编号',
				field : 'ywbh',
				hidden : false
			}
			]]
		}); 
})////////////////
//关闭窗口
	var closeWindow = function($dialog){
		$dialog.dialog('close');
	}; 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >

        	<sicp3:groupbox title="案件办理日志列表">
				<table id="mygrid" style="height:98%;overflow:auto;" ></table>
	        </sicp3:groupbox>

        </form>         
    </div>   
		    

</body>
</html>