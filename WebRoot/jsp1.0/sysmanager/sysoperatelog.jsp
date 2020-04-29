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
<title>操作日志管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_gridreport.jsp"></jsp:include>
<script type="text/javascript">
    CreateReport("Report");
  //在网页初始加载时向报表提供数据
    function window_onload() 
    {
      Report.LoadFromURL("<%=basePath%>jsp/gridreport/operatelog.grf");
    }

  
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var cb_userkind;
	var grid;
	$(function() {
		cb_userkind = $('#userkind').combobox({
	    	data : userkind,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		grid = $('#grid').datagrid({
			//title: '操作日志列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/sysmanager/sysoperatelog/querySysoperatelog',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'operatelogid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '用户ID',
				field : 'userid',
				hidden : false
			},{
				width : '100',
				title : '用户名称',
				field : 'username',
				hidden : false
			},{
				width : '80',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(userkind,value);
				}
			}]],			
			columns : [ [ {
				width : '100',
				title : '用户IP',
				field : 'userip',
				hidden : false
			},{
				width : '150',
				title : '操作模块',
				field : 'parent',
				hidden : false
			},{
				width : '200',
				title : '操作功能',
				field : 'title',
				hidden : false
			},{
				width : '150',
				title : '开始时间',
				field : 'starttime',
				hidden : false
			},{
				width : '150',
				title : '结束时间',
				field : 'endtime',
				hidden : false
			},{
                width : '150',
                title : '简述',
                field : 'module',
                hidden : false
            },{
                width : '150',
                title : '详述',
                field : 'description',
                hidden : false
            } ] ]
		});
	});
	
	function query() {
		var param = {
			'username': $('#username').val(),
			'userkind': $('#userkind').combobox('getValue')
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');	
	}
	function myprint(){
		var v_username=$('#username').val();
		var v_userkind=$('#userkind').combobox('getValue');
		
		var v_url=encodeURI(encodeURI("<%=basePath%>sysmanager/sysoperatelog/querySysoperatelogPrint?username="
				  	+v_username+"&userkind="+v_userkind+"&time="+new Date().getMilliseconds()));
		  	
		Report.LoadDataFromURL(v_url);
		Report.PrintPreview(true);
	}	
	function refresh(){
		parent.window.refresh();	
	}

	function print(){	 
		sy.doPrint('siweb/sysuser.cpt','')
	}  	
</script>
</head>
<body onload="window_onload()">
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>用户名称</nobr></td>
						<td><input id="username" name="username" style="width: 200px"/></td>						
						<td style="text-align:right;"><nobr>用户类别</nobr></td>
						<td><input id="userkind" name="userkind" style="width: 200px" /></td>												
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-print" onclick="myprint()"> 打 印 </a>								
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="操作日志列表">	        	
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>