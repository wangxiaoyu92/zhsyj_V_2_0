<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>
<%
	String comid = StringHelper.showNull2Empty(request
			.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>征信评估明细</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//征信评估明细 
	/*
	 $(function(){ 
	 $("#aaa").datagrid({
	 title:'企业诚信评估明细',
	 url:  basePath + '/zx/integritypub/queryzxbusinesscode ', 
	 iconCls:'icon-ok',
	 height:450,
	 pageSize:10,
	 pageList:[10,20,30],
	 nowrap:true,//True 就会把数据显示在一行里
	 striped:true,//奇偶行使用不同背景色
	 collapsible:true,
	 singleSelect:true,//True 就会只允许选中一行
	 fit:false,//让DATAGRID自适应其父容器
	 fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
	 pagination:true,//底部显示分页栏
	 rownumbers:true,//是否显示行号
	 loadMsg:'数据加载中,请稍后...',
	 columns:[[
	 {title:'id',field:'bpid',align:'left',width:100} ,
	 {title:'年度',field:'bpyear',align:'left',width:100} ,
	 {title:'项目类别',field:'bcparentcode',align:'left',width:100},
	 {title:'项目',field:'bccode',align:'left',width:100},
	 {title:'级别',field:'bcname',align:'left',width:100 },
	 {title:'指标',field:'bpratio',align:'left',width:100 } ,
	 {title:'得分',field:'bpscore',align:'left',width:100 } 
	 ]]
	 });
	 });
	
	
	 */

	$(function() {
		var comid = $('#comid').val();
		if ($('#comid').val().length > 0) {
			parent.$.messager.progress('close');

			$("#aaa").datagrid(
					{
						title : '企业诚信评估明细',
						url : basePath
								+ '/zx/integritypub/queryzxbusinesscode?comid='
								+ comid,
						iconCls : 'icon-ok',
						height : 450,
						pageSize : 10,
						pageList : [ 10, 20, 30 ],
						nowrap : true,//True 就会把数据显示在一行里
						striped : true,//奇偶行使用不同背景色
						collapsible : true,
						singleSelect : true,//True 就会只允许选中一行
						fit : false,//让DATAGRID自适应其父容器
						fitColumns : false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
						pagination : true,//底部显示分页栏
						rownumbers : true,//是否显示行号
						loadMsg : '数据加载中,请稍后...',
						columns : [ [
						//  {title:'id',field:'bpid',align:'left',width:100,hidden:true} ,
						{
							title : '年度',
							field : 'bpyear',
							align : 'left',
							width : 100
						}, {
							title : '项目类别',
							field : 'bcparentcode',
							align : 'left',
							width : 100
						}, {
							title : '项目',
							field : 'bccode',
							align : 'left',
							width : 100
						}, {
							title : '级别',
							field : 'bcname',
							align : 'left',
							width : 100
						}, {
							title : '指标',
							field : 'bpratio',
							align : 'left',
							width : 100
						}, {
							title : '得分',
							field : 'bpscore',
							align : 'left',
							width : 100
						} ] ]
					});
		}
	});

	/* 
	 $(function (){
		 var comid =$('#comid').val();
		 alert($('#comid').val())
		$.ajax({
			url:"/syjzhpt/zx/integritypub/queryzxbusinesscode",
			type:"post",
			data:{comid:"comid"},
			datatype:"json",
			success:function(result){
				 
			},
			error:function(){
				alert("++++")
			}
		})
	}) 
	 
	 */
	var closeWindow = function($dialog, $pjq) {
		$dialog.dialog('destroy');
	};
</script>

</head>

<body>
	<form id="fm" method="post" hidden="true">
		<sicp3:groupbox title="企业评估明细">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>企业ID:</nobr></td>
					<td><input id="comid" name="comid" style="width: 200px;"
						readonly="readonly" class="input_readonly" value="<%=comid%>" /></td>

				</tr>
				<!--  	<td style="text-align:right;"><nobr>企业名称:</nobr></td>
					<td><input id="" name="" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
				<tr>						
					<td style="text-align:right;"><nobr>年度:</nobr></td>
					<td><input id="bpyear" name="bpyear" style="width: 200px" /></td>					
					<td style="text-align:right;"><nobr>项目类别:</nobr></td>
					<td><input id="bcparentcode" name="bcparentcode" style="width: 200px" /></td>
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>项目:</nobr></td>
					<td><input id="bccode" name="bccode" style="width: 200px" /></td>					
					<td style="text-align:right;"><nobr>级别:</nobr></td>
					<td><input id="bcname" name="bcname" style="width: 200px" /></td>
				</tr>
				<tr>
				    <td style="text-align:right;"><nobr>指标:</nobr></td>
					<td><input id="bpratio" name="bpratio" style="width: 200px" /></td>						
					<td style="text-align:right;"><nobr>得分:</nobr></td>
					<td><input id="bpscore" name="bpscore" style="width: 200px" /></td>	
					
				</tr>
				-->
			</table>
		</sicp3:groupbox>
	</form>
	<sicp3:groupbox title="企业诚信评估明细">
		<div id="aaa" style="height:350px;overflow:auto;"></div>
	</sicp3:groupbox>
</body>
</html>
