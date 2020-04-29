<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String v_proid = StringHelper.showNull2Empty(request.getParameter("proid"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>添加材料</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
var mygrid;	 
	$(function() {  	
		mygrid = $('#mygrid').datagrid({
			url : '<%=basePath%>spsy/productin/queryComCl?proid=<%=v_proid%>',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'proid', //该列是一个唯一列
		    sortOrder: 'asc',
		    loadMsg:'数据加载中,请稍后...',   
		    columns:[[{
				field: "ck",
				checkbox: true
			},{
				title:'产品id',
				field:'proid',
				width:100,
				hidden:'true'
			},{
				title:'材料名称',
				field:'proname',
				width:200
			}]] 
		}); 
	}); 
	// 查询材料
	function query() {
		var param = {
			'proname' : $('#proname').val(),
			'proid' : '<%=v_proid%>'
		};
		mygrid.datagrid({
			url : basePath + '/spsy/productin/queryComCl',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');   
	}
	
	// 提交保存
	function addProductCls() { 
		var rows = mygrid.datagrid("getSelections");
		var data = $.array.clone(rows);
		if (!data.length) {
			$.messager.alert('操作提醒', '您未选择任何材料!', 'info',function(){
				return;
			});
		}
		var JsonStr = $.toJSON(rows);
		var param = {
			'clStr' : JsonStr,
			'proid' : $("#proid").val()
		};  
		$.post(basePath + '/spsy/productin/addProductCls', param, function(result) {
			if (result.code=='0'){
	        		$.messager.alert('提示','操作成功！','info',function(){
	        			sy.setWinRet(s);
	        			closeWindow();
	        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','操作失败：'+result.msg,'error');
               }
		}, 'json');
	} 
	// 关闭窗口
	function closeWindow() {
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        	<input id="proid" name="proid" type="hidden" value="<%=v_proid%>">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>材料名称</nobr></td>
						<td><input id="proname" name="proname" style="width: 200px"/></td>	
						<td style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
						</td>					
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="产品列表">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
	        <div style="text-align:right">
		        	<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-ok" onclick="addProductCls()">提交保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
		        	<a href="javascript:void(0)" class="easyui-linkbutton" 
						iconCls="icon-cancel" onclick="closeWindow()">取消关闭</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
	        </div>	 
	        <div style="text-align: center; color: blue; font-size: 14px;">
        		该表格中不包含已作为产品材料的材料信息，如果没有合适的材料，请首先在企业产品和材料管理中添加材料！
        	</div>        
        </div>  
    </div>
</body>
</html>