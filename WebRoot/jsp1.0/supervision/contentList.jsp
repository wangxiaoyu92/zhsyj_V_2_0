<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
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
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法		     
		    autoParam: ["itemid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
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
			onClick: onClick,
			beforeAsync: beforeAsync,
			onAsyncError: onAsyncError,
			onAsyncSuccess: onAsyncSuccess
		}
	};

	var contentImpt = <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>;
    var  vSysUser = <%=SysmanageUtil.getSysuser().getUserid()%>;
	var contentimptCommbox;
	var grid;
	$(function() { 
		contentimptCommbox = $('#contentimpt').combobox({
		    	data : contentImpt,      
		        valueField : 'id',   
		        textField : 'text',
		        required : true,
		        editable : false,
		        panelHeight : 'auto'
		    });
		 grid = $('#grid').datagrid({
				//title: '法律法规条款条款',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				url: '',
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,			
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度			
			    idField: 'contentid', //该列是一个唯一列
			    sortOrder: 'asc',
			    columns :[[
			    {
					width : '150',
					title : '内容ID',
					field : 'contentid',
					hidden : true
				},
			    {
					width : '150',
					title : '编号',
					field : 'contentcode',
					hidden : false
				},
				{
					width : '150',
					title : '内容',
					field : 'content',
					hidden : false
				},
				{
					width : '150',
					title : '重要性',
					field : 'contentimpt',
					hidden : false,
					formatter : function(value, row) {
						return sy.formatGridCode(contentImpt,value);
					}
				},{
					width : '250',
					title : '评级分值',
					field : 'contentscore',
					hidden : false
				},
				{
					width : '550',
					title : '排序号',
					field : 'contentsortid',
					hidden : false
				}] ]
			});
		refreshZTree();	
		//导入功能（admin 才有）
		if(vSysUser=="0"){
		$('.impdoc').css('display','');
		}
		
	}); 
	
	//初始化检查项目树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    if (!responseData) {
	    	for(var i =0; i < responseData.length; i++) {
	    		//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	    		array[i] = {
					id: responseData[i].itemid,
					name: responseData[i].itemname,
					isParent: false,
					itemdesc:itemdesc
				}; 
	      	}
	    }
	    return zNodes;
	}

	//根据返回值确定是否允许进行异步加载
	function beforeAsync(treeId, treeNode) {
		//
	}
	function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
		//
	}
	function onAsyncSuccess(event, treeId, treeNode, msg) {
		//
	}
		
	function onClick(e, treeId, treeNode) {
		$('#fm').form('load',treeNode);	
	}
</script>
<script type="text/javascript">
	var setting2 = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法		     
		    autoParam: ["itemid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
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
			onClick: onClick2
		}
	};

	//单击节点事件
	function onClick2(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = zTree.getSelectedNodes();		
		$("#itempid").val(nodes[0].itemid);
		$("#parentname").val(nodes[0].itemname);
		hideMenu();		  
	}

	function showMenu() {
		var cityObj = $("#parentname");
		var cityOffset = $("#parentname").offset();
		$("#menuContent").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
		queryItemCombotree();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent" 
			|| $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	function queryItemCombotree() { //初始化项目树下拉框
		$.fn.zTree.init($("#treeDemo2"), setting2);
	}
</script>
<script type="text/javascript">
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 查询
	function query() {
		var itemid = $("#itemid").val();
		var itemname = $("#itemname").val();
		var childnum = $("#childnum").val();
		if(itemid==null||itemid==''||itemname==null||itemname==''||childnum==null||childnum>0){
			$.messager.alert('提示','请选择左侧项目树叶子节点！','info');
			return;
		}
		var param = {
			'itemid': itemid
		};
		$('#grid').datagrid({
			url:basePath + '/supervision/checkinfo/queryContent',
			queryParams : param
		});
		$('#grid').datagrid('clearSelections');	
		
		
	}
	
	// 新增项目内容
	var addContent = function() {
		var itemid = $("#itemid").val();
		var itemname = $("#itemname").val();
		var childnum = $("#childnum").val();
		var dialog = parent.sy.modalDialog({
			title : '新增项目内容',
			width : 900,
			height : 600,
			url : basePath + '/supervision/checkinfo/contentForm?op=add&itemid='+itemid,
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveContent(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	//编辑项目内容
	var editContent = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				 title : '编辑项目内容',    
				 width : 900,    
				 height : 600,      
				 url :  basePath+'/supervision/checkinfo/contentForm?op=edit&contentid='+row.contentid,     
				 buttons:[{
						text:'确定',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.saveContent(dialog,grid,parent.$);
						}
					},{
						text:'取消',
						handler:function(){
							dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
						}
					}]

			});
		}else{
			$.messager.alert('提示','请先选择要修改的项目内容信息！','info');
		}
	};
	
	
	//删除项目内容
	var delContent = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			$.messager.confirm('警告', '您确定要删除该条信息吗?', function(r){
				if (r){
					//异步删除
					$.post(basePath+'/supervision/checkinfo/delContent',{
						contentid : row.contentid
					},function(result){
						if(result.code=='0'){
							$.messager.alert('提示','删除成功！','info',function(){
								$("#grid").datagrid('reload');
							});
						}else{
							$.messager.alert('提示','删除失败：'+result.msg,'error');
						}
					},'json');
				}
			});
		}else{
			$.messager.alert('提示','请先选择要删除的项目内容信息！','info');
		}
	};
	
	//查看法律法规条款
	var viewContent = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看项目内容',
				width :900,
				height :600,
				url : basePath+'/supervision/checkinfo/contentForm?op=view&contentid='+row.contentid,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的信息！','info');
		}
	}
	
	
	// 新增项目内容
	var importDoc = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增项目内容',
			width : 900,
			height : 300,
			url : basePath + '/supervision/checkinfo/toImportWordInfo',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.saveContent(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="检查项目信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>项目名称</nobr></td>
						<td><input id="itemname" name="itemname" style="width: 200px;" 
							class="easyui-validatebox" data-options="required:false" /></td>	
						<td style="text-align:right;"><nobr>父项目名称</nobr></td>										
						<td>
							<input name="parentname" id="parentname"  style="width: 200px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input type="hidden" name="itempid" id="itempid"  style="width: 200px; "/>	
							<input type="hidden" id="itemid" name="itemid" style="width: 200px;" readonly="readonly" class="input_readonly" />
							<input type="hidden" id="childnum" name="childnum" style="width: 200px;" readonly="readonly" class="input_readonly"/>						
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query();"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</form>
			
	        </sicp3:groupbox>
	        <sicp3:groupbox title="检查内容管理">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addContent"
								iconCls="icon-add" plain="true" onclick="addContent()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editContent"
								iconCls="icon-edit" plain="true" onclick="editContent()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delContent"
								iconCls="icon-remove" plain="true" onclick="delContent()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_viewContent"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewContent()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td class="impdoc" style="display: none">
								<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_importDoc"
								iconCls="ext-icon-report_magnify" plain="true" onclick="importDoc()">模板导入</a>
							</td>
							<td  class="impdoc"  style="display: none">  
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
	        <div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>        
    </div>    	
</body>
</html>