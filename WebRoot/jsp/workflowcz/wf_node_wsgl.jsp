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
<title>工作流节点关联文书</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var psbh = "";
	var nodeid = "";
	
	var setting = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "psbh",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "psmc"
			}
		},
		callback: {
			onClick: onClick
		}		
	};

	//刷新zTree
	function queryWfprocessZTree(){
		$.post(basePath + '/workflow/queryWfprocessZTree', {}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}

	//单击工作流列表
	function onClick(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		
		psbh = nodes[0].psbh;
		nodeid = ""; 
		grid.datagrid('loadData',{"total":0,"rows":[]});
		queryWfnodeZTree(); 
	}
	
	var setting2 = {
		view: {
			showLine: true
		},	
		data: {
			simpleData: {						
				enable: true,
				idKey: "nodeid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "nodename"
			}
		},
		callback: {
			onClick: onClick2
		}
		
	};
	
	//刷新zTree
	function queryWfnodeZTree(){
		$.post(basePath + '/workflow/queryWfnodeZTree', {
			'psbh' : psbh
		}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}			
		}, 'json');		
	}

	//单击节点列表
	function onClick2(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = zTree.getSelectedNodes();		
		nodeid = nodes[0].nodeid; 			
		queryWfnodeWsgl();	 
	}

	//查询节点已关联文书 
	function queryWfnodeWsgl() {		
		var param = {
			'nodeid': nodeid,
			'psbh' : psbh
		};
		grid.datagrid({
			url : basePath + '/workflow/queryWfnodeWsgl',
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}		
</script>
<script type="text/javascript">
	var grid;
	
	$(function() {
		grid = $('#grid').datagrid({
			//title: '节点关联文书',
			//iconCls: 'icon-tip',
			toolbar : '#toolbar',
			url : '',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'zfajafwsnodeid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '节点文书关联表ID',
				field : 'zfajafwsnodeid',
				hidden : true
			},{
				width : '200',
				title : '文书编号',
				field : 'zfwsdmz',
				hidden : false
			}]],					
			columns : [ [ {
				width : '300',
				title : '文书名称',
				field : 'zfwsdmmc',
				hidden : false
			} ] ]
		});

		queryWfprocessZTree();
	});

	
	// 新增
	var addWfnodeWsgl = function() {
		if(nodeid == "" || nodeid == null){
			$.messager.alert('提示','请先选择节点！','info',function(){
				return; 
    		}); 
		}else{
			var dialog = parent.sy.modalDialog({
				title : '新增节点关联文书',
				width : 700,
				height : 500,
				maximizable : false,
				url : basePath + '/workflow/wf_node_wsglAddIndex?psbh=' + psbh + '&nodeid=' + nodeid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}
	};
	// 删除
	var delWfnodeWsgl = function() {
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要解除该文书绑定吗？',function(r) {
				if (r) {
					$.post(basePath + '/workflow/delWfnodeWsgl', {
						zfajzfwsnodeid : row.zfajzfwsnodeid
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','操作成功！','info',function(){
								queryWfnodeWsgl(); 
			        		}); 
						} else {
							$.messager.alert('提示', '操作失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	};

</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
		<div region="center" style="overflow: hidden;" border="false"> 
        	<ul id="treeDemo2" class="ztree" ></ul>       
        </div>    
        <div region="east" style="width:600px;overflow: true;" border="false">
        	<sicp3:groupbox title="节点关联文书列表">
        		<div id="toolbar">
	        		<table>
						<tr>	        									
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_addWfnodeWsgl"
								iconCls="icon-add" plain="true" onclick="addWfnodeWsgl()">新增关联文书</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  							
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delWfnodeWsgl"
								iconCls="icon-remove" plain="true" onclick="delWfnodeWsgl()">删除关联文书</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>  																				
						</tr>
					</table>
				</div>    
	        	<div id="grid" style="height: 400px">></div>
	        </sicp3:groupbox>        	
        </div>        
    </div>    
</body>
</html>