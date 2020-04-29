<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
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
%>
<!DOCTYPE html>
<html>
<head>
<title>企业溯源监管</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var comgrid; // 企业列表
	var progrid; // 产品表
	var propcgrid; // 产品批次表
	var v_scdwdm = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>; // 产品批次生产单位代码
	// 产品表自定义视图
	var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
		renderRow: function(target, fields, frozen, rowIndex, rowData){
			var cc = [];
			cc.push('<td colspan=' + fields.length + ' style="padding:1px 5px;border:0;">');
			if (!frozen){
				cc.push('<img src="' + basePath + rowData.fjpath + '" style="width:100px;height:80px;">');
				cc.push('<div style="padding:0px 0px; border:0;margin: 0px 0px;">');
                cc.push('<p>' + rowData[fields[2]] + '</p>');  
				cc.push('</div>');
			}
			cc.push('</td>');
			return cc.join('');
		}
	});

	$(function() {
		$("#propcgridtd").hide();
	    // 商品表
		comgrid = $('#comgrid').datagrid({
			title: '企业信息列表',
			url: basePath + 'supervision/comsyxx/queryCompany',
			queryParams: {
				'comfwnfww': '0' // 0:范围内	1范围外
			},
			width:350,
			height:380,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
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
				title : '企业代码',
				field : 'comdm',
				hidden : true
			},{
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '企业法人/业主',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '100',
				title : '溯源企业类型',
				field : 'comsyqylx',
				hidden : true
			} ] ],
			onClickRow : function(rowIndex, rowData){
				$("#comsyqylx").val(rowData.comsyqylx);
				var v_comid = rowData.comid;	
				if (rowData.comsyqylx == 1) {
					$("#propcgridtd").show();
				} else {
					$("#propcgridtd").hide();
				}
				$("#comid").val(v_comid);
				queryComProduct(v_comid);
				propcgrid.datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 
			}
		});
		// 企业对应商品表
		progrid = $('#progrid').datagrid({
			title: '企业产品表',
			width:200,
			height:380,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'proid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '商品ID',
				field : 'proid',
				hidden : true
			},{
				width : '100',
				title : '商品图片路径',
				field : 'fjpath',
				hidden : true
			},{
				width : '150',
				title : '商品名称',
				field : 'proname',
				hidden : false
			} ] ],
			view: cardview,
			onClickRow : function(rowIndex, rowData){
				var comsyqylx = $("#comsyqylx").val(); // 企业溯源类型
				var v_proid = rowData.proid; // 产品id
				if (comsyqylx == 1) {
					queryProductPc(v_proid);
				} else {
					showProductSalesAndStock(v_proid);
				}
			}
		});
		// 产品对应批次表
		propcgrid = $('#propcgrid').datagrid({
			title: '产品批次信息',
			width:500,
			height:380,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'cppcid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '产品批次ID',
				field : 'cppcid',
				hidden : true
			},{
				width : '150',
				title : '产品批次',
				field : 'cppcpch',
				hidden : false
			},{
				width : '100',
				title : '产品id',
				field : 'proid',
				hidden : true
			},{
				width : '150',
				title : '生产日期',
				field : 'cppcscrq',
				hidden : false
			},{
				width : '100',
				title : '生产数量',
				field : 'cppcscsl',
				hidden : false
			},{
				width : '100',
				title : '单位名称',
				field : 'cppcscdwdm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_scdwdm,value);
				}
			}] ],
			onClickRow : function(rowIndex, rowData){
				showProductHcAndStock();
			}
		});
	});
	// 查询企业
	function queryCompany(){
		var param = {
			'commc' : $("#commc").val(),
			'comfwnfww' : '0' // 0:范围内	1范围外
		};
		comgrid.datagrid({
			url: basePath + 'supervision/comsyxx/queryCompany',		
			queryParams : param
		});
		comgrid.datagrid('clearSelections');
	}
	// 查询企业产品
	function queryComProduct(v_comid){
		var param = {
			'procomid' : v_comid,
			'cphyclbz' : '1' // 1 ： 产品  2 ： 原材料 
		};
		progrid.datagrid({
			url : basePath + '/spsy/productin/queryProductin',			
			queryParams : param
		});
		progrid.datagrid('clearSelections');
	}
	// 查询产品批次信息
	function queryProductPc(v_proid){
		var param = {
			'procomid' : $("#comid").val(), // 公司id
			'proid': v_proid
		};
		propcgrid.datagrid({
			url : basePath + '/spsy/spproduct/queryComProductsPc',			
			queryParams : param
		});
		propcgrid.datagrid('clearSelections');
	}
	// 展示产品耗材和进货台账页面
	function showProductHcAndStock(){
		var row = $('#propcgrid').datagrid('getSelected');
		if (row) {
			var procomid = $("#comid").val(); // 产品所属公司id
			var url = basePath + 'supervision/comsyxx/showProductHcAndStockIndex';
			var dialog = parent.sy.modalDialog({
				title : '产品耗材和进货台账',
				param : {
					procomid : procomid,
					proid : row.proid,
					cppcid : row.cppcid,
					cppcpch : row.cppcpch
				},
				width :900,
				height :700,
				url : url
			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要查看的产品批次信息！', 'info');
		}
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		sy.removeWinRet(dialogID);//不可缺少		
	}
	// 展示产品销货进货台账
	function showProductSalesAndStock(v_proid){
		var comid = $("#comid").val(); // 公司id
		var url=basePath + 'supervision/comsyxx/showProductSalesAndStockIndex';
		var dialog = parent.sy.modalDialog({
			title : '产品销货和进货台账',
			param : {
				pcomid : comid,
				proid : v_proid
			},
			width :950,
			height :700,
			url : url
		}, closeModalDialogCallback);
	}	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        <input id="comid" name="comid" type="hidden"/>
        <input id="comsyqylx" name="comsyqylx" type="hidden"/>
        	<sicp3:groupbox title="企业信息">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px;"/></td>						
						<td style="text-align:center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queryCompany()"> 查 询 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="企业溯源">
				<table>
					<tr>
						<td>
							<div style="width: 350px;height: 380px;">
								<table id="comgrid"  style="overflow:auto;"></table>
							</div>
						</td>
						<td>
							<div style="width: 200px;height: 380px;">
								<table id="progrid"  style="overflow:auto;"></table>
							</div>
						</td>
						<td>
							<div id='propcgridtd' style="width: 500px;height: 380px;">
								<table id="propcgrid" style="overflow:auto;"></table>
							</div>
						</td>
					</tr>
				</table>
			</sicp3:groupbox> 
        </div>        
    </div>    
</body>
</html>