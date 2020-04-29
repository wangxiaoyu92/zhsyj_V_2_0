<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_userid = StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>工作流节点权限管理</title>
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
			onClick: myonClick
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
	function myonClick(event, treeId, treeNode) {          
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		
		psbh = nodes[0].psbh;
		nodeid = ""; 
		queryWfnodeZTree(psbh); 
		
	}
	
	var setting2 = {
		view: {
			showLine: true
		},	
		check: {
			enable: true,
			chkboxType: { "Y" : "s", "N" : "s" }
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
	
	// 初始化原来权限节点的选中状态
	function initUserHavedNode(v_psbh) {
		var v_b_userid="<%=v_userid%>";
		
	    //var userdata={userid:v_b_userid,psbh:v_psbh};
		var treeDemo2Obj = $.fn.zTree.getZTreeObj("treeDemo2");
		treeDemo2Obj.checkAllNodes(false);	
		$.ajax({
			url: basePath + '/workflow/queryUserHavedNode',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: 'userid='+v_b_userid+'&psbh='+v_psbh,
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');		
			},
			success: function(result) {
				if (null != result && "[]" != result) {
					$.each(result,function(i, item) { //得到节点，并选中
						var node = treeDemo2Obj.getNodeByParam("nodeid", item.nodeid, null);
						if (null != node) {
							treeDemo2Obj.checkNode(node, true, false, true);
						}
					});
				}
			}
		});			
	};	
	
	//刷新zTree
	function queryWfnodeZTree(v_psbh){
		$.post(basePath + '/workflow/queryWfnodeZTree', {
			'psbh' : psbh
		}, function(result) {
			if (result.code == '0') {
				//准备zTree数据
				var zNodes = eval(result.mydata);
				$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
				initUserHavedNode(v_psbh);
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
	}

	// 关闭窗口
	var closeWindow = function closeWindow($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	//保存行政区划授权
	function saveUserHavedNode($dialog, $pjq) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		
		psbh = nodes[0].psbh;
		
		mygetcheckedNodeid();
		
		var v_b_userid = "<%=v_userid%>";			
		var param = $('#treeDemo2checkednode').val();
		param = param + "userid=" + v_b_userid+"&psbh="+psbh;
		$.post(basePath + '/workflow/saveUserHavedNode', param, function(result) {
			if (result.code=='0'){
				$.messager.alert('提示','保存成功！','info',function(){
				closeWindow($dialog, $pjq);
	       		}); 	                        	                     
	           } else {
	         		$.messager.alert('提示','保存失败：'+result.msg,'error');
	           }
		}, 'json');	
	};		
	
	//勾选或不勾选事件	
	function mygetcheckedNodeid() { 
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");         
		var nodes = treeObj.getCheckedNodes(true);
		var param = "";
		for(var i=0;i<nodes.length;i++){
			param = param + "nodeid=" + nodes[i].nodeid + "&";
		}
		$('#treeDemo2checkednode').val(param);		     		  
	}	
</script>
<script type="text/javascript">
	
	$(function() {
		queryWfprocessZTree();
	});
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>    
		<div region="center" style="overflow: hidden;" border="false"> 
        	<ul id="treeDemo2" class="ztree" ></ul>  
        	<input type="hidden" id="treeDemo2checkednode">     
        </div>          
    </div>    

</body>
</html>