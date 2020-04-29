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
<title>菜单管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysfunction/querySysfunctionZTreeAsync',  //调用后台的方法		     
		    autoParam: ["functionid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "functionid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "title"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	$(function() { 
		refreshZTree();	
	}); 
	
	//初始化zTree树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.menuData);//获取后台传递的数据
	    return zNodes;
	}
		
	function onClick(e, treeId, treeNode) {
		$('#fm').form('load',treeNode);//用节点数据填充form
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		
		$("#parent").val(nodes[0].parent);
		$("#parentname").val(nodes[0].parentname); 	
	}
</script>
<script type="text/javascript">
	var setting2 = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysfunction/querySysfunctionZTreeAsync',  //调用后台的方法		     
		    autoParam: ["functionid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "functionid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "title"
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
		$("#parent").val(nodes[0].functionid);
		$("#parentname").val(nodes[0].title);
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
		refreshZTree2();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	function refreshZTree2() { //初始化父菜单下拉框
		$.fn.zTree.init($("#treeDemo2"), setting2);
	}
</script>
<script type="text/javascript">
    //下拉框列表
	var type = <%=SysmanageUtil.getAa10toJsonArray("TYPE")%>;	
	var systemcode = <%=SysmanageUtil.getAa10toJsonArray("SYSTEMCODE")%>;		
	var cb_type;
	var cb_systemcode;

	$(function() {
		cb_type = $('#type').combobox({
	    	data:type,      
	        valueField:'id',   
	        textField:'text',
	        required:true,
	        editable:false,
	        panelHeight:'auto' 
	    });
		cb_systemcode = $('#systemcode').combobox({
	    	data:systemcode,      
	        valueField:'id',   
	        textField:'text',
	        required:false,
	        editable:false,
	        panelHeight:120 
	    });	
	});

	//新增
	var addSysfunction = function() { 
	    $('#fm').form('clear');
	    $('#orderno').val('1');
	    $('#visible').combobox('setValue','1');  
	};

	//删除
	var delSysfunction = function() {		
		var functionid = $('#functionid').val();
		if(functionid > 0){
			var childnum = $('#childnum').val();
			var msg;
			if(childnum > 1){
				msg = "此菜单为父级菜单,如果删除，其所属的子菜单也将被删除，确定要删除此菜单吗？";
			}else{
				msg = "确定要删除此菜单吗？";
			} 
			$.messager.confirm('警告',msg,function(r){
				 if (r) {
						$.post(basePath + '/sysmanager/sysfunction/delSysfunction', {functionid : functionid}, 
							function(result){
							 	if (result.code=='0'){
							 		$.messager.alert('提示','删除成功','info',function(){
							 			//刷新左侧的树
							 			refreshZTree();   
					        		});    
		                      	} else {
		                      		$.messager.alert('提示','删除失败:'+result.msg,'error');
		                        }
		                   }, 'json');
				}
			 });
		}else{
			$.messager.alert('提示','没有选择菜单数据，无法删除！','info');
		}
	};

	//保存
	var saveSysfunction = function(){ 
	    $('#fm').form('submit',{  
	    	url : basePath + '/sysmanager/sysfunction/saveSysfunction',  
	        onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },  
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功','info',function(){
	                	//刷新左侧的树
		                refreshZTree(); 
		                addSysfunction();  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败:'+result.msg,'error');
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
        	<sicp3:groupbox title="菜单信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>菜单编号</nobr></td>
						<td><input name="functionid"  id="functionid" style="width: 200px;" readonly="readonly" class="input_readonly"/></td>
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>菜单类型</nobr></td>
						<td><input name="type" id="type"  style="width: 200px;" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>菜单名称</nobr></td>
						<td colspan="3"><input name="title" id="title" class="easyui-validatebox" data-options="required:true" style="width: 450px;" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>菜单路径</nobr></td>
						<td colspan="3"><input name="location" id="location" style="width: 450px;"/></td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>业务标识</nobr></td>
						<td><input name="bizid" id="bizid" style="width: 200px;"/></td>					
					</tr>
					<tr>					
						<td style="text-align:right;"><nobr>菜单父节点</nobr></td>
						<td>
							<input name="parentname" id="parentname"  style="width: 200px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="parent" id="parent" type="hidden"/>							
						</td>	
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>菜单序号（菜单显示顺序）</nobr></td>
						<td><input name="orderno" id="orderno" type="text" style="width: 200px;" value="1" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>是否可见</nobr></td>
						<td><select name="visible" id="visible" class="easyui-combobox" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 200px;">
								<option value="0">隐藏</option>
								<option value="1">可见</option>
							</select>
						</td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>菜单打开方式</nobr></td>
						<td><input name="target" id="target" type="text" style="width: 200px;" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>菜单所属系统</nobr></td>
						<td><input name="systemcode" id="systemcode" type="text" style="width: 200px;" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>子菜单个数</nobr></td>
						<td><input name="childnum" id="childnum" type="text" style="width: 200px;" readonly="readonly" class="input_readonly"/></td>
					</tr>
				</table>
			</form>
			<br/>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysfunction"
					iconCls="icon-add" onclick="addSysfunction()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysfunction"
					iconCls="icon-cancel" onclick="delSysfunction()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveSysfunction"
					iconCls="icon-save" onclick="saveSysfunction()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>
        <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>          
    </div>    
</body>
</html>
