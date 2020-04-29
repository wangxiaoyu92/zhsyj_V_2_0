<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	//String jcypid = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("jcypid")),"UTF-8");
	String v_jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测结果</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
	var mygrid; 
	//检测检验类别
	var v_jcjylb= <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
	// 检验检测结论
	var v_jyjcjl= <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
	//检测检验审核标志
	var v_shbz= <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
	//检验检测名称
	$(function() {					
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'jyjc/queryJyjcjg',
		    queryParams :{
		    	jcypid:<%=v_jcypid%>
			},	
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcjgid', //该列是一个唯一列
		    sortOrder: 'asc',
		    columns :[[ {
				width : '100',
				title : '检测结果ID',
				field : 'jcjgid',
				hidden : true
			},{
				width : '150',
				title : '检测检验类别',
				field : 'jcjylb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_jcjylb,value);
				}
			},{
				width : '150',
				title : '检测样品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '230',
				title : '受检单位名称',
				field : 'commc',
				hidden : false
			},{
				width : '150',
				title : '检测项目名称',
				field : 'jcxmmc',
				hidden : false
			},{
				width : '150',
				title : '标准值',
				field : 'jcxmbzz',
				hidden : false
			},{
				width : '150',
				title : '结果值',
				field : 'imphl',
				hidden : false
			},{
				width : '150',
				title : '复检结果',
				field : 'fjjg',
				hidden : false
			},{
				width : '150',
				title : '结论',
				field : 'impjcjg',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_jyjcjl,value);
				}
			},{
				width : '150',
				title : '检测日期',
				field : 'impjcsj',
				hidden : false
			},{
				width : '150',
				title : '检验员',
				field : 'impjcry',
				hidden : false
			},{
				width : '150',
				title : '处理结果',
				field : 'jcjycljg',
				hidden : false
			},{
				width : '150',
				title : '审核标志',
				field : 'jcjyshbz',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_shbz,value);
				}
			}
			] ]
		});
}) 
	
// 关闭窗口
var closeWindow = function($dialog, $pjq){
	$dialog.dialog('destroy');
};
</script>
</head>
<body>
<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="检验检测品种">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>    
</body>
</html>