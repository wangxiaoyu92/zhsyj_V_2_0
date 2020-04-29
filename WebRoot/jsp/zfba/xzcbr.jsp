<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
	//String v_singleSelect = StringHelper.showNull2Empty(request.getParameter("singleSelect"));
%>
<!DOCTYPE html>
<html>
<head>
<title>执法人员管理</title>
	<jsp:include page="${contextPath}/inc_easyui.jsp"></jsp:include>

<script type="text/javascript">
//	var obj = window.dialogArguments;
	//var v_singleSelect = obj.singleSelect;
var v_singleSelect = true;
	var zfryxb = '<%=SysmanageUtil.getAa10toJsonArray("AAC004")%>';
	var grid; 
	$(function() {
		grid = $('#grid').datagrid({
			url:  '<%=basePath%>zfba/ajdj/queryViewzfry',
			singleSelect :v_singleSelect,// True只允许选中一行
			striped : true,// 奇偶行使用不同背景色
			checkOnSelect : true,
			selectOnCheck : true,
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度		
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			columns : [[
			{
				width : '100',
				field:'ck', 
				checkbox:'true',
				hidden : false
			}, 
		    {
				width : '100',
				title : '人员描述',
				field : 'description',
				hidden : false
			},{
				width : '150',
				title : '手机号',
				field : 'mobile',
				hidden : false
			},{
				width : '80',
				title : '机构名称',
				field : 'orgname',
				hidden : false
			},{
				width : '100',
				title : '性别',
				field : 'zfryxb',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(zfryxb,value);
				}
			},{
				width : '80',
				title : '身份证',
				field : 'zfrysfzh',
				hidden : false
			},{
				width : '120',
				title : '证件号',
				field : 'zfryzjhm',
				hidden : false
			},{
				width : '120',
				title : '职务',
				field : 'zfryzw',
				hidden : false
			},{
				width : '120',
				title : '备注',
				field : 'zfrybz',
				hidden : false
			}
			] ]
		});
	
	}); 
 function query() {
		var param = {
			'username': $('#username').val(),
			'mobile': $('#mobile').val()
		};
		grid.datagrid({
			url : basePath + '/zfba/ajdj/queryViewzfry',			
			queryParams : param
		}); 
		grid.datagrid('clearSelections');
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = grid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	
   function queding(){
     var rows=grid.datagrid('getSelections'); 
	  window.returnValue=rows;
	  window.close(); 
	  closeWindow();
   }
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>用户名称</nobr>
						</td>
						<td><input id="username" name="username" style="width: 200px" />
						</td>
						<td style="text-align:right;"><nobr>联系电话</nobr>
						</td>
						<td><input id="mobile" name="mobile" style="width: 200px" />
						</td>
					</tr>
					<tr>
						<td colspan="2"></td>
						<td colspan="2">
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
			<sicp3:groupbox title="用户列表">
				<div id="grid" style="height:350px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
	</div>


</body>
</html>