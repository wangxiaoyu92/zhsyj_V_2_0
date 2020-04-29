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
<script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" 
		width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript"> 
  var LODOP; //声明为全局变量  
	var grid;
	$(function() { 
		grid = $('#grid').datagrid({
			//title: '操作日志列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/sysmanager/sysuser/queryversion',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			//pagination : true,// 底部显示分页栏
			//pageSize : 10,
			//pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'logonlogid', //该列是一个唯一列
		    sortOrder: 'desc',
		    columns : [[
		     { width : '200',
				title : '登陆id',
				field : 'logonlogid'
			},{  
				width : '100',
				title : '登录名称',
				field : 'userid'  
			},{  
				width : '100',
				title : '用户名称',
				field : 'logfailedreason'  
			},{
				width : '150',
				title : '登陆时间',
				field : 'logontime',
				hidden : false
			},{
				width : '150',
				title : '版本号',
				field : 'logonappvision',
				hidden : false
			} 
			] ]
		});
	});
	
	function query() { 
		var param = {
			'userid': $('#username').val(), 
			'logontime': $('#logontime').val()  
		};
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');	
	}
	function printHtml(){ 
        var url= basePath + '/common/sjb/queryloghtml?'+
                 'logontime='+$('#logontime').val() +
                 '&userid='+$('#username').val(); 					
	    var dialog = parent.sy.modalDialog({
			title : '检查结果',
			width : 820,
			height : 570,
			url : url,
			buttons : [ {
				text : '打印',
				handler : function() {  
					var strID=url;
			 		print(strID);
				}
			},{
				text : '取消',
				handler : function() { 			
					dialog.dialog('destroy');  
				}
			} ]
	   },function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});  
	} 
	function print(strID){ 
		LODOP = getLodop();  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_按网址打印");
		LODOP.ADD_PRINT_URL(30,20,746,"95%", strID);
		LODOP.SET_PRINT_STYLEA(0,"HOrient", 3);
		LODOP.SET_PRINT_STYLEA(0,"VOrient", 3);
		LODOP.SET_SHOW_MODE("MESSAGE_GETING_URL", ""); //该语句隐藏进度条或修改提示信息
 		LODOP.SET_SHOW_MODE("MESSAGE_PARSING_URL","");//该语句隐藏进度条或修改提示信息
		LODOP.PREVIEW(); 
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
						<td style="text-align:right;"><nobr>登录名称</nobr></td>
						<td><input id="username" name="username" style="width: 200px"/></td>						 											
						<td style="text-align:right;"><nobr>日期</nobr></td>
						<td><input id="logontime" name="logontime" style="width: 200px" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'logontime\')}'})" class="Wdate bbinput" readonly="readonly" /></td>						 											
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-print" onclick="printHtml()"> 打印 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="版本列表">	        	
				<div id="grid"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>