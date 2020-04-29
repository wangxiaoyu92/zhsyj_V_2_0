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
<title>产品材料</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript"> 
	var grid;
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/spsy/productin/queryproductZTreeAsync',  //调用后台的方法		     
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

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.proData);//获取后台传递的数据	
		var length = zNodes.length;
		if (length == 1) {
			zNodes[0].isParent = false;
		}
	    return zNodes;
	}

	//单击节点事件
	function onClick(event, treeId, treeNode) {  
		$("#proid").val(treeNode.proid);
		       
		grid.datagrid({
			url : basePath + '/spsy/productin/queryProductcl',			
			queryParams : {'proid':treeNode.proid} 
		});
		//grid.datagrid('unselectAll'); 		  
	} 
 $(function() { 
 	$.fn.zTree.init($("#treeDemo"), setting);
		 grid  = $('#grid').datagrid({
			toolbar: '#toolbar',
			//url: basePath + '/spsy/productin/queryProductcl',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			height:450,
			pageSize : 50,
			pageList : [ 50, 100, 150 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'proid', //该列是一个唯一列
		    sortOrder: 'desc',			
			columns : [ [ {
				width : '200',
				title : '产品材料ID',
				field : 'proid',
				hidden : true
			},{
				width : '200',
				title : '企业ID',
				field : 'procomid',
				hidden : true
			},{
				width : '200',
				title : '材料名称',
				field : 'proname',
				hidden : false
			} ] ]
		});
	}); 
	
	// 新增材料
	function productinaddIndex() {		
		var v_proid = $('#proid').val();
		if (v_proid) {
			var url = basePath + 'spsy/productin/procladdIndex';
			var dialog = parent.sy.modalDialog({
					title : '添加材料',
					param : {
						proid : v_proid
					},
					width : 450,
					height : 500,
					url : url
			},closeModalDialogCallback); 
		} else {
			$.messager.alert('提示', '请先选择需要添加材料的产品！', 'info');
		}
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$('#grid').datagrid('reload'); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 删除产品材料
	function delprocl() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这个材料么！',function(r) {
				if (r) {
					$.post(basePath + '/spsy/productin/delprocl', {
						 cpclid : row.proid,
						 proid : $("#proid").val()
						 
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info');
			        		$("#grid").datagrid('reload'); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的材料！', 'info');
		}
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
    	<input type="hidden" id="proid" name="proid"> 
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>                   
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="材料列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_productinaddIndex"
								iconCls="icon-add" plain="true" onclick="productinaddIndex()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delprocl"
								iconCls="icon-remove" plain="true" onclick="delprocl()">删除</a>
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