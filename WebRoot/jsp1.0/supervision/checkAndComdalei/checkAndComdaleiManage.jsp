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
<title>检查项和企业关系管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	
	var grid;
	$(function() { 
		showcomList("comdalei");
		 grid = $('#grid').datagrid({
				//title: '法律法规条款条款',
				//iconCls: 'icon-tip',
				toolbar: '#toolbar',
				 url: basePath + '/supervision/checkinfo/getcheckAndTypeList',  //调用后台的方法
				striped : true,// 奇偶行使用不同背景色
				singleSelect : true,// True只允许选中一行
				checkOnSelect : false,
				selectOnCheck : false,			
				pagination : true,// 底部显示分页栏
				pageSize : 10,
				pageList : [ 10, 20, 30 ],
				rownumbers : true,// 是否显示行号
				fitColumns : false,// 列自适应宽度			
			    idField: 'basetype', //该列是一个唯一列
			    sortOrder: 'asc',
			    columns :[[
			    {
					width : '150',
					title : '类别',
					field : 'basetype',
					hidden : true
				},{
					width : '220',
					title : '计划id',
					field : 'itemtype',
					hidden : true
				},
				{
					width : '100',
					title : '编码',
					field : 'aaa100',
					hidden : false
				},
			    {
					width : '200',
					title : '编号',
					field : 'aaa103',
					hidden : false
				},
				{
					width : '220',
					title : '内容',
					field : 'itemname',
					hidden : false
				}
				] ]
			});
		
	}); 
</script>
	
<script type="text/javascript">
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 查询
	function query() {
		var itemid = $("#itemid").val();
		var aaa100 = $("#aaa100").val();
		var aaa102 = $("#aaa102").combobox("getValue");
		var param = {
			'itemid': itemid,
			'aaa102':aaa102,
			'aaa100':aaa100
		};
		$('#grid').datagrid({
			url:basePath + '/supervision/checkinfo/getcheckAndTypeList',
			queryParams : param
		});
		$('#grid').datagrid('clearSelections'); 				
	}
	
	// 新增项目内容
	var saveCheckAndtype = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增项目内容',
			width : 800,
			height : 300,
			url : basePath + '/supervision/checkinfo/addCheckAndTypejsp?op=add',
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
	var editCheckAndtype = function(){
		var row = $("#grid").datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				 title : '编辑项目内容',    
				 width : 900,    
				 height : 300,      
				 url :  basePath+'/supervision/checkinfo/addCheckAndTypejsp?op=edit&basetype='
				 	+row.basetype+'&itemtype='+row.itemtype.trim(),     
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
					$.post(basePath+'/supervision/checkinfo/delCheckAndType',{
						basetype : row.basetype,
						itemtype : row.itemtype.trim()
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
	
	
	//获取类别列表
	function showcomList(val){
	//下拉框列表
	var type;
	$('#aaa100').val(val);
	if("comdalei"==val.toLowerCase()){
	 type = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>
	}else if("comxiaolei"==val.toLowerCase()){
	 type = <%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>
	}
	var basetypeCommbox = $('#aaa102').combobox({
	    	data : type,      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 'auto'
	    });
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
		$("#itemid").val(nodes[0].itemid);
		$("#itemname").val(nodes[0].itemname);
		hideMenu();		  
	}

	function showMenu() {
		var cityObj = $("#itemname");
		var cityOffset = $("#itemname").offset();
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
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
        <div region="center" style="overflow: hidden;" border="false">
        	<sicp3:groupbox title="检查项目信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
					<td style="text-align:right;"><nobr></nobr></td>
						<td>
						<input type="radio" name="comdalei" onclick="showcomList(this.value)" 
							checked="checked" value="comdalei" />企业大类	
						<input type="radio" name="comdalei"  onclick="showcomList(this.value)" value="comxiaolei" />企业小类
						<input type="hidden" name="aaa100" id="aaa100"/>
						</td>			
						<td style="text-align:right;"><nobr>类别</nobr></td>
						<td><input id="aaa102" name="aaa102" style="width: 200px;" /></td>	
					</tr>
					<tr>
					
						<td style="text-align:right;"><nobr>计划项</nobr></td>										
						<td>
							<input name="itemname" id="itemname"  style="width: 260px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="itemid" id="itemid" hidden="true" style="width: 200px; " />							
						</td>
						<td colspan="6">
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
	        <sicp3:groupbox title="检查内容管理">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveCheckAndtype"
								iconCls="icon-add" plain="true" onclick="saveCheckAndtype()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editCheckAndtype"
								iconCls="icon-edit" plain="true" onclick="editCheckAndtype()">编辑</a>
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