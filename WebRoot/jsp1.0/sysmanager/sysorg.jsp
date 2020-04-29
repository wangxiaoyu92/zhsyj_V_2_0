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
<title>机构管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "orgname"
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
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
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
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "orgname"
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
		$("#parent").val(nodes[0].orgid);
		$("#parentname").val(nodes[0].orgname);
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

	function refreshZTree2() { //初始化父机构下拉框
		$.fn.zTree.init($("#treeDemo2"), setting2);
	}
</script>
<script type="text/javascript">
	function refresh(){
		parent.window.refresh();	
	} 

	//新增
	var addSysorg = function() { 
	    $('#fm').form('clear');
	    $('#orgkind').val('0');
	    $('#orderno').val('1'); 
	};

	//删除
	var delSysorg = function() {		
		var orgid = $('#orgid').val();
		if(orgid != null && orgid != ''){
			var childnum = $('#childnum').val();
			var msg;
			if(childnum > 1){
				msg = "此机构为父级机构,如果删除，其所属的子机构也将被删除，确定要删除此机构吗？";
			}else{
				msg = "确定要删除此机构吗？";
			} 
			$.messager.confirm('警告',msg,function(r){
				 if (r) {
						$.post(basePath + '/sysmanager/sysorg/delSysorg', {orgid : orgid}, 
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
	var saveSysorg = function(){
		$.messager.progress();	// 显示进度条 
	    $('#fm').form('submit',{  
	    	url : basePath + '/sysmanager/sysorg/saveSysorg',  
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
        	<sicp3:groupbox title="机构信息">    
	        <form id="fm" name="fm" method="post">		
				<table class="table" style="width: 80%;">
					<tr>
						<td style="text-align:right;"><nobr>机构ID</nobr></td>
						<td><input id="orgid" name="orgid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>机构编码</nobr></td>
						<td><input id="orgcode" name="orgcode" style="width: 200px;"  readonly="readonly" class="input_readonly"/></td>
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>机构名称</nobr></td>
						<td><input id="orgname" name="orgname" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>										
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>机构描述</nobr></td>
						<td><input id="orgdesc"  name="orgdesc" style="width: 200px;"/></td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>父机构</nobr></td>										
						<td>
							<input name="parentname" id="parentname"  style="width: 200px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="parent" id="parent" type="hidden"/>							
						</td>			
					<tr>
						<td style="text-align:right;"><nobr>机构地址</nobr></td>
						<td><input id="address" name="address" style="width: 200px;"/></td>					
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>机构负责人</nobr></td>
						<td><input id="principal" name="principal" style="width: 200px;" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>联系人</nobr></td>
						<td><input id="linkman" name="linkman" style="width: 200px;" /></td>				
					</tr>
					<tr>					
						<td style="text-align:right;"><nobr>联系电话</nobr></td>
						<td><input id="tel" name="tel" style="width: 200px;" /></td>
					</tr>					
					<tr>					
						<td style="text-align:right;"><nobr>分组</nobr></td>
						<td><input id="fz" name="fz" style="width: 200px;" /></td>
					</tr>				
					<tr>
						<td style="text-align:right;"><nobr>子机构个数</nobr></td>
						<td><input name="childnum" id="childnum" type="text" style="width: 200px;" readonly="readonly" class="input_readonly"/></td>
					</tr>
					<input id="shortname" name="shortname" type="hidden" style="width: 200px;" />
					<input id="orgkind" name="orgkind" type="hidden" style="width: 200px;" value="0"/>
					<input id="orderno" name="orderno" type="hidden" style="width: 200px;" value="1"/>
				</table>
			</form>
			<br/>
	        <div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveSysorg"
					iconCls="icon-add" onclick="addSysorg()">新增</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysorg"
					iconCls="icon-cancel" onclick="delSysorg()">删除</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveSysorg"
					iconCls="icon-save" onclick="saveSysorg()">保存 </a>
	        </div>
	        </sicp3:groupbox>
        </div>
        <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
		</div>        
    </div>    	
</body>
</html>