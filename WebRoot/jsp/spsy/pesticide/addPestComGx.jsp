<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 企业id
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));

	String curr_aaa027 = StringHelper.showNull2Empty(SysmanageUtil.getAa01("SYSAAA027").getAaa005());
	if (!"".equals(curr_aaa027)) {
		curr_aaa027 = curr_aaa027.replaceAll("0*$", "");
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>添加供销商</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var s = new Object();
	s.type = "ok";   // 设为刷新父页面
	var grid1; // 本企业产品材料表
	var grid2; // 供销公司表
	// 产品种类 1药物  2肥料 3针剂
	var v_pesticidezl = <%=SysmanageUtil.getAa10toJsonArray("PESTICIDEZL")%>;
	$(function() {
	    // 商品表
		grid1 = $('#grid1').datagrid({
			title: '采购物品表',
			url : basePath + '/spsy/pesticide/queryPesticide',
			queryParams : { pesticidecomid : '<%=comid%>' },
			iconCls: 'icon-tip',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'proid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '商品ID',
				field : 'pesticideid',
				hidden : true
			},{
				title:'类型',
				field:'pesticidezl',
				align:'center',
				width:100, 
			 	formatter: function(value,row,index){
					return sy.formatGridCode(v_pesticidezl, value);
				}
			},{
				width : '190',
				title : '名称',
				field : 'pesticidename',
				hidden : false
			},{
				title:'商品条码',
				field:'pesticidesptm',
				width:110
			}, {
				title:'品名',
				field:'pesticidepm',
				width:100
			}, {
				title:'规格型号',
				field:'pesticidegg',
				width:80
			}, {
				title:'包装规格',
				field:'pesticidebzgg',
				width:80,
				hidden:'true'
			}, {
				title:'产品标准号',
				field:'pesticidecpbzh',
				width:80
			}] ]
		});
		// 企业表
		grid2 = $('#grid2').datagrid({
			title: '供货商企业信息表',
			iconCls: 'icon-tip',
			url : basePath + '/pcompany/queryCompany',
			queryParams : {comfwnfww : '1', queryall : '1', aaa027 : '<%=curr_aaa027%>'},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'comid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '企业ID',
				field : 'comid',
				hidden : true
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '企业类别',
				field : 'comdaleistr',
				hidden : false
			}, {
				title:'法定代表人/负责人',
				field:'comfrhyz',
				width:100
			}, {
				title:'联系电话',
				field:'comyddh',
				width:100
			}, {
				title:'厂家地址',
				field:'comdz',
				width:200
			}] ],
			onClickRow : function(rowIndex, rowData){
				$("#comname").val(rowData.commc);
				$("#csid").val(rowData.comid);
			}
		});
	});
	// 查询企业
	function queryCompany(){
	    var v_comfwnfww=$('input:radio[name="comfwnfww"]:checked').val();
		var param = {
			'commc': $("#comname").val(),
			'comfwnfww': v_comfwnfww,
			aaa027 : '<%=curr_aaa027%>'
		};
		grid2.datagrid({
			url : basePath + '/pcompany/queryCompany?queryall=1',			
			queryParams : param
		});
		grid2.datagrid('clearSelections'); 
	}

	// 提交保存
	function addComGx() {
		var row = grid1.datagrid("getSelected");
		if (!row) {
			$.messager.alert('操作提醒', '请选择要采购的物品!', 'info',function(){
				return;
			});
		} else {
			var v_comfwnfww=$('input:radio[name="comfwnfww"]:checked').val();
			var v_csid = $("#csid").val();
			var param = {
				'comid' : $("#comid").val(),
				'comfwnfww': v_comfwnfww,
				'csid': v_csid,
				'cphyclid' : row.pesticideid // 产品或原材料id
			};
			$.post(basePath + '/spsy/pesticide/addPestComGx', param, function(result) {
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
	} 
	// 关闭窗口
	function closeWindow() {
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: scroll;" border="false">
        	<input id="comid" name="comid" type="hidden" value="<%=comid%>">
        	<input id="csid" name="csid" type="hidden">
	        <sicp3:groupbox title="采购物品表">
				<table id="grid1"  style="width:680px;height:200px;overflow:auto;"></table>
			</sicp3:groupbox>
			<sicp3:groupbox title="供货商企业信息列表">
				<table>
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="comname" name="comname" style="width: 200px"/></td>
						<td style="text-align:left">
							<input type="radio" value="0" name="comfwnfww" />范围内&nbsp;
							<input type="radio" value="1" name="comfwnfww" checked='checked' />范围外</td>
						<td style="text-align:left;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
							   iconCls="icon-search" onclick="queryCompany()"> 查 询 </a>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<table id="grid2"  style="width:680px;height:240px;overflow:auto;"></table>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
			<table align="right">
				<tr>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-ok" onclick="addComGx()">提交保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-cancel" onclick="closeWindow()">取消关闭</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</div>
    </div>    
</body>
</html>