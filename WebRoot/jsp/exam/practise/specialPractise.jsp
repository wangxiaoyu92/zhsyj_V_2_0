<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>专项练习</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var grid;
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArray("QSNLX")%>; // 试题类型
	$(function() {				  		
		/* // 'center'面板被缩放后触发
		$('#mainLayout').layout('panel', 'center').panel({
			onResize : function(width, height) {
				sy.setIframeHeight('centerIframe', $('#mainLayout').layout('panel', 'center').panel('options').height - 5);
			}
		}); */
		// 试题类型
		$('#qsnInfoType').combobox({
			data : v_qsnInfoType,
			valueField : 'id',
			textField : 'text',
			required : false,
			edittable : false,
			panelHeight : 'auto'
		});
		grid = $('#grid').datagrid({
			title: '试题知识点',
			url: basePath + 'exam/practise/queryQsnNumOfSpecial',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 20,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    sortOrder: 'desc',
			columns : [ [ {
				width : '150',
				title : '知识点代码',
				field : 'qsnTrade',
				hidden : true
			},{
				width : '150',
				title : '知识点',
				field : 'name',
				hidden : false
			},{
				width : '100',
				title : '试题数量',
				field : 'num',
				hidden : false
			}] ],
			onClickRow : function(rowIndex, rowData){
				$("#special").attr("src", basePath + "exam/practise/orderPractiseIndex?qsnTrade=" + rowData.qsnTrade);
			}
		});
	});
	function query() {
		var qsnInfoType = $('#qsnInfoType').combobox('getValue');
		var param = {
			"qsnInfoType" : qsnInfoType
		};
		grid.datagrid("reload", param);
		grid.datagrid('clearSelections');
	}
</script>
</head>
<body id="mainLayout" class="easyui-layout">
	<div data-options="region:'west',split:true" title="导航" style="width: 260px; ">	
		<div region="center" style="width:250px;overflow: auto;" border="false">  
			<table class="table" style="width: 99%;">
				<tr>						
					<td style="text-align:right;"><nobr>试题类型：</nobr></td>
					<td><input id="qsnInfoType" name="qsnInfoType" style="width: 100px" /></td>								
				</tr>
				<tr>	
					<td colspan="2">
					   <div align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
					    </div>		
					</td>
	 
				</tr>
			</table>   	
			<div id="grid" style="width: 250px;height: 500px"></div>
	    </div>
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div style="width: 100%; height: 99%;">
			<iframe	id="special" src="<%=basePath%>exam/practise/orderPractiseIndex" allowTransparency="true" 
				style="border: 0;width: 100%; height: 99%;" frameBorder="0"></iframe>
		</div>
	</div>
</body>
</html>
