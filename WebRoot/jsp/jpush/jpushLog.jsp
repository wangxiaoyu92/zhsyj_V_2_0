<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() 
		 	+ ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>极光推送日志</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var msgType = [{"id":"0","text":"系统消息"},{"id":"1","text":"个人消息"}
		,{"id":"1001","text":"日程"},{"id":"1002","text":"任务"},{"id":"1003","text":"会议"},{"id":"1004","text":"流程待办"}];
	var v_msgType;
	var grid;
	$(function() {
		v_msgType = $('#type').combobox({
			data : msgType,
			valueField : 'id',
			textField : 'text',
			required : false,
			edittable : false,
			panelHeight : 'auto'
		});
		grid = $('#grid').datagrid({
			url: basePath + 'jpush/queryJpushLog',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'logid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '日志ID',
				field : 'logid',
				hidden : true
			},{
				width : '100',
				title : '接收人id',
				field : 'accertuserid',
				hidden : true
			},{
				width : '100',
				title : '接收人姓名',
				field : 'accertusername',
				hidden : false
			},{
				width : '80',
				title : '消息类型',
				field : 'type',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(msgType,value);
				}
			},{
				width : '200',
				title : '消息标题',
				field : 'title',
				hidden : false
			},{
				width : '250',
				title : '消息内容',
				field : 'message',
				hidden : false
			},{
				width : '100',
				title : '发送时间',
				field : 'sendtime',
				hidden : false
			},{
				width : '100',
				title : '发送人id',
				field : 'senduserid',
				hidden : true
			},{
				width : '100',
				title : '发送人姓名',
				field : 'sendusername',
				hidden : false
			} ] ]
		});
	});
	
	function query() {
		var param = {
			'type': $('#type').combobox('getValue')
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');	
	}
	
	function refresh(){
		parent.window.refresh();	
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>消息类别</nobr></td>
						<td><input id="type" name="type" style="width: 200px" /></td>												
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="推送消息日志列表">	        	
				<div id="grid" style="width: 900px; height: 400px;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>