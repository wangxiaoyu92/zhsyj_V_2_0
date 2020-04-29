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
<title>检查项目管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

	var itemtypeData = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
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
	
	$(function() { 
		itemtype = $('#itemtype').combobox({
	    	data : itemtypeData,      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		refreshZTree();	
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

	//新增
	var addItem = function() { 
	    $('#fm').form('clear');
	};

	//删除
	var delItem = function() {		
		var itemid = $('#itemid').val();
		if(itemid != null && itemid != ''){
			var childnum = $('#childnum').val();
			var msg;
			if(childnum > 1){
				msg = "此机构为父级项目,如果删除，其所属的子项目也将被删除，确定要删除此项目吗？";
			}else{
				msg = "确定要删除此项目吗？";
			} 
			$.messager.confirm('警告',msg,function(r){
				 if (r) {
						$.post(basePath + '/supervision/checkinfo/delCheckGroup', {itemid : itemid}, 
							function(result){
							 	if (result.code=='0'){
							 		$.messager.alert('提示','删除成功！','info',function(){
							 			//刷新左侧的树
							 			refreshZTree();   
					        		});    
		                      	} else {
		                      		$.messager.alert('提示','删除失败：'+result.msg,'error');
		                        }
		                   }, 'json');
				}
			 });
		}else{
			$.messager.alert('提示','没有选择机构数据，无法删除！','info');
		}
	};

	//保存
	var saveItem = function(){
		$.messager.progress();	// 显示进度条 
	    $('#fm').form('submit',{  
	    	url : basePath + '/supervision/checkinfo/saveCheckGroup',  
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		    	if(!isValid){
					$.messager.progress('close');
				}
				return isValid;
	        },  
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.progress('close');
	        		$.messager.alert('提示','保存成功！','info',function(){
	                	//刷新左侧的树
		                refreshZTree();   
	        		}); 	                        	                     
              	} else {
              		$.messager.progress('close');
              		$.messager.alert('提示','保存失败！'+result.msg,'error');
                }
	        }  
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
						<td style="text-align:right;"><nobr>项目ID</nobr></td>
						<td><input id="itemid" name="itemid" style="width: 200px;" 
							readonly="readonly" class="input_readonly" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>项目类别</nobr></td>
						<td>
						<input id="itemtype" name="itemtype" style="width: 200px" 
							class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" />
						</td>
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>项目名称</nobr></td>
						<td><input id="itemname" name="itemname" style="width: 200px;" 
							class="easyui-validatebox" data-options="required:true" /></td>				
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>项目描述</nobr></td>
						<td><input id="itemdesc"  name="itemdesc" style="width: 200px;"/></td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>父项目ID</nobr></td>										
						<td>
							<input name="parentname" id="parentname"  style="width: 200px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="itempid" id="itempid"  style="width: 200px; " />							
						</td>
					</tr>			
					<tr>
						<td style="text-align:right;"><nobr>备注</nobr></td>
						<td><input id="itemremark" name="itemremark" style="width: 200px;"/></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>排序号</nobr></td>
						<td><input id="itemsortid" name="itemsortid" style="width: 200px;" /></td>
					</tr>
				</table>
			</form>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addItem"
					iconCls="icon-add" onclick="addItem()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delItem"
					iconCls="icon-cancel" onclick="delItem()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveItem"
					iconCls="icon-save" onclick="saveItem()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>
        <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>        
    </div>    	
</body>
</html>