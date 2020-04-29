<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
<title>产品批次管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var A_prozl; // 产品种类
// 产品种类
var v_prozl = <%=SysmanageUtil.getAa10toJsonArray("PROZL")%>;
// 生产单位代码
var v_scdwdm = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>;
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/spsy/spproduct/queryComProductsListAsync',  //调用后台的方法		     
		    autoParam: [], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "proid",
				pIdKey: "parentid",
				rootPId: 0		
			},
			key: {
				name: "proname"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	$(function() { 
		$.fn.zTree.init($("#comProductTree"), setting);
		// 产品种类
	    A_prozl = $('#prozl').combobox({
	    	data : v_prozl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		mygrid = $('#mygrid').datagrid({
			
			toolbar: '#toolbar',
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
				title : '产品名',
				field : 'proname',
				hidden : false
			},{
				width : '100',
				title : '产品种类',
				field : 'prozl',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_prozl,value);
				}
			},{
				width : '150',
				title : '产品批次',
				field : 'cppcpch',
				hidden : false
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
			},{
				width : '100',
				title : '溯源码是否已生成',
				field : 'cppcsymscbz',
				hidden : false,
				formatter : function(value, row) {
					if (value == '1'){
						return "<span style='color:blue;'>已生成</span>";
					} else if (value == '0') {
						return "<span style='color:red;'>未生成</span>";
					}
				}
			}
			] ]
		});
	}); 

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.ComProducts);//获取后台传递的数据
		var length = zNodes.length;
		if (length == 1) {
			zNodes[0].isParent = false;
		}
	    return zNodes;
	}
	
	//单击节点事件
	function onClick(event, treeId, treeNode) { 
		var param;
		if (!treeNode.isParent) {
			$("#productid").val(treeNode.proid);
			param = {
				'proid': treeNode.proid
			};
		} else {
			param = {};
		}
		$("#mygrid").datagrid({
			url : basePath + '/spsy/spproduct/queryComProductsPc',			
			queryParams : param
		});
		$("#mygrid").datagrid('clearSelections');  		  
	}
	
	// 添加产品批次
	function addProductPc() {		
		var v_productid = $("#productid").val();
		if (v_productid == null || v_productid == "" || v_productid.length == 0) {
			alert("请先选择产品！");
			return;
		} 
		var url = basePath + 'spsy/spproduct/productpcFromIndex';
		var dialog = parent.sy.modalDialog({
				title : '添加产品批次',
				param : {
					proid : v_productid
				},
				width : 450,
				height : 300,
				url : url
		},closeModalDialogCallback);
	}
	
	// 编辑产品批次信息
	function updataProductPc() {
		var v_productid = $("#productid").val();
		if (v_productid == null || v_productid == "" || v_productid.length == 0) {
			alert("请先选择产品！");
			return;
		}
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'spsy/spproduct/productpcFromIndex';
			var dialog = parent.sy.modalDialog({
					title : '编辑产品批次',
					param : {
						proid : v_productid,
						cppcid : row.cppcid
					},
					width : 450,
					height : 300,
					url : url
			},closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要修改的产品批次信息！', 'info');
		}
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		//if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#grid').datagrid('reload'); 
		//}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 删除
	function delProductPc() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该批次吗?',function(r) {
				if (r) {
					$.post(basePath + '/spsy/spproduct/delProductPc', {
						cppcid: row.cppcid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的产品批次记录！', 'info');
		}
	} 
	// 查询材料
	function query() {
		var param = {
			'proname' : $('#proname').val(),
			'cppcpch' : $('#cppcpch').val(),
			'proid' : $('#productid').val()
		};
		mygrid.datagrid({
			url : basePath + '/spsy/spproduct/queryComProductsPc',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections');  
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="comProductTree" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: auto;" border="false">
        <sicp3:groupbox title="查询条件">
       		<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>产品名称</nobr></td>
					<td><input id="proname" name="proname" style="width: 200px"/></td>	
					<td style="text-align:right;"><nobr>批次号</nobr></td>
					<td><input id="cppcpch" name="cppcpch" style="width: 200px"/></td>	
					<td style="text-align: center;"> 
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
					</td>				
				</tr>
			</table>
        </sicp3:groupbox>
        <sicp3:groupbox title="产品批次信息">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addProductPc"
								iconCls="icon-add" plain="true" onclick="addProductPc()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updataProductPc"
								iconCls="icon-edit" plain="true" onclick="updataProductPc()">修改</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delProductPc"
								iconCls="icon-remove" plain="true" onclick="delProductPc()">删除</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 																																													
						</tr>
					</table>
				</div>
				<input type="hidden" name="productid" id="productid">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>   
        </div>       
	</div> 
</body>
</html>