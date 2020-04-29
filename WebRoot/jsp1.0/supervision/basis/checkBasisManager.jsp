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
<title>检查内容管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	// 初始化异步加载树url
	var assyncUrl = basePath + 'supervision/checkinfo/queryItemZTreeAsync'; 
	var setting = { 
		async: {    
		    enable : true, //启用异步加载   
		    url : getAsyncUrl,  //调用后台的方法		     
		    autoParam : ["itemid"], //向后台传递的参数
		    otherParam : {}, //额外的参数
		    dataFilter : ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "itemid",
				pIdKey: "itempid",
				rootPId: 0		
			},
			key: {
				name: "itemname"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	// 获取异步加载树url
	function getAsyncUrl(treeId, treeNode) {
		if (treeNode && treeNode.level == 3) {
			assyncUrl = basePath + '/supervision/checkbasis/queryBasisZTreeAsync?contentid='+ treeNode.itemid;
		} else {
			assyncUrl = basePath + '/supervision/checkinfo/queryItemZTreeAsync';
		}
	    return assyncUrl;
	};
	// 检查方式
	var checkType = <%=SysmanageUtil.getAa10toJsonArray("FLFGLX")%>; // 检查方式
	var grid; // 检查依据表格
	var v_checkType; // 检查方式
	$(function() { 
		v_checkType = $('#checkType').combobox({
			data : checkType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 'auto'
	    });
		grid = $('#grid').datagrid({
			striped : true, // 奇偶行使用不同背景色
			singleSelect : true, // True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false, // 底部显示分页栏
			// pageSize : 10,
			// pageList : [ 10, 20, 30 ],
			rownumbers : true, // 是否显示行号
			fitColumns : false, // 列自适应宽度			
		    idField : 'basisid', //该列是一个唯一列
		    sortOrder : 'desc',
			columns : [ [ {
				width : '150',
				title : 'ID',
				field : 'basisid',
				hidden : false
			},{
				width : '200',
				title : '检查方式',
				field : 'type',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(checkType, value);
				}
			},{
				width : '250',
				title : '检查方式描述',
				field : 'typedesc',
				hidden : false
			},{
				width : '100',
				title : '检查指南',
				field : 'guide',
				hidden : false
			},{
				width : '100',
				title : '处罚措施',
				field : 'punishmeasures',
				hidden : false
			},{
				width : '100',
				title : '检查依据描述',
				field : 'basisdesc',
				hidden : false
			},{
				width : '100',
				title : '经办人',
				field : 'operatorname',
				hidden : false
			},{
				width : '100',
				title : '经办时间',
				field : 'operatedate',
				hidden : false
			} ] ]
		});
		loadCheckItemZTree();	
		
	}); 
	
	// 初始化检查项目树
	function loadCheckItemZTree(){
		$.fn.zTree.init($("#basisTree"), setting);
	}
	// 用于对 Ajax 返回数据进行预处理的函数
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData); // 获取树节点数据
		var isLastNode = eval(responseData.isLastNode);
	    if (responseData) {
	    	for(var i = 0; i < zNodes.length; i++) {
	    		//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	    		array[i] = {
					itemid : zNodes[i].itemid,
					itemname : zNodes[i].itemname,
					itempid : zNodes[i].itempid,
					isParent : !isLastNode
				}; 
	      	}
	    }
	    return array;
	}
	// 树节点点击事件	
	function onClick(e, treeId, treeNode) {
		var treeObj = $.fn.zTree.getZTreeObj("basisTree");
		var sNodes = treeObj.getSelectedNodes();
		if (sNodes.length > 0) {
			var level = sNodes[0].level;
			if (level == 4) {
				$("#contentid").val(sNodes[0].itemid);
				grid.datagrid({
					url : basePath + 'supervision/checkbasis/queryCheckBasis',			
					queryParams : { 'contentid' : sNodes[0].itemid }
				});
			} 
		}	
		
	}
	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 查询
	function query() {
		var contentid = $("#contentid").val();
		var checkType = $("#checkType").combobox('getValue');
		var basisdesc = $("#basisdesc").val();
		var param = {
			'contentid' : contentid,
			'type' : checkType,
			'basisdesc' : basisdesc
			
		};
		$('#grid').datagrid({
			url:basePath + 'supervision/checkbasis/queryCheckBasis',
			queryParams : param
		});
		$('#grid').datagrid('clearSelections');	
	}
	
	// 新增检查依据
	function addCheckBasis() {
		var contentid = $("#contentid").val();
		var dialog = parent.sy.modalDialog({
			title : '新增依据',
			width : 900,
			height : 700,
			url : basePath + 'supervision/checkbasis/checkBasisFormIndex',
			param : {
				contentid : contentid
			},
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveCheckBasis(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		}, closeModalDialogCallback);
	}

	//编辑项目内容
	function editCheckBasis(){
		var contentid = $("#contentid").val();
		var row = $("#grid").datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				 title : '编辑依据',    
				 width : 900,    
				 height : 700,      
				 url :  basePath + 'supervision/checkbasis/checkBasisFormIndex',
				 param : {
					contentid : contentid,
					basisid : row.basisid
				 },     
				 buttons:[{
						text:'确定',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.saveCheckBasis(dialog, grid, parent.$);
						}
					},{
						text:'取消',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
						}
					}]

			}, closeModalDialogCallback);
		}else{
			$.messager.alert('提示', '请先选择要修改的信息！', 'info');
		}
	}
	
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		sy.removeWinRet(dialogID);//不可缺少		
	}
	//删除依据
	function delCheckBasis(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			$.messager.confirm('警告', '您确定要删除该条信息吗?', function(r){
				if (r){
					//异步删除
					$.post(basePath + 'supervision/checkbasis/delCheckBasis',{
						basisid : row.basisid
					},function(result){
						if(result.code=='0'){
							$.messager.alert('提示','删除成功！','info', function(){
								$("#grid").datagrid('reload');
							});
						}else{
							$.messager.alert('提示','删除失败：'+result.msg,'error');
						}
					},'json');
				}
			});
		}else{
			$.messager.alert('提示','请先选择要删除的信息！','info');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="basisTree" class="ztree" ></ul>       
        </div>    
        <input id="contentid" name="contentid" type="hidden">
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="检查依据信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>检查方式</nobr></td>
						<td><input id="checkType" name="checkType" style="width: 200px;"/></td>	
						<td style="text-align:right;"><nobr>检查依据</nobr></td>
						<td><input id="basisdesc" name="basisdesc" style="width: 200px;" 
							class="easyui-validatebox" data-options="required:false" /></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</form>
	        </sicp3:groupbox>
	        <sicp3:groupbox title="检查依据管理">
	        <div id="toolbar">
        		<table>
					<tr>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addCheckBasis"
							iconCls="icon-add" plain="true" onclick="addCheckBasis()">增加</a> 
						</td>
						<td>  
							<div class="datagrid-btn-separator"></div>
						</td> 
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editCheckBasis"
							iconCls="icon-edit" plain="true" onclick="editCheckBasis()">编辑</a>
						</td>
						<td>  
							<div class="datagrid-btn-separator"></div>
						</td> 
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delCheckBasis"
							iconCls="icon-remove" plain="true" onclick="delCheckBasis()">删除</a>
						</td>
						<td>  
							<div class="datagrid-btn-separator"></div>
						</td> 
					</tr>
				</table>
			</div>
	        <div id="grid" style="height:350px;overflow:auto;"></div>
        	</sicp3:groupbox>
        </div>
    </div>    	
</body>
</html>