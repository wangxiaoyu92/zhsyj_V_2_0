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
<title>机构树</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<!-- ztree插件 -->
<link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/demo.css" type="text/css">
<link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.core-3.4.js"></script>
<script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.excheck-3.4.js"></script>
<script type="text/javascript">
	var obj = new Object();
	obj.type = ''; 
	sy.setWinRet(obj);
	
	var setting_sysorg = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter_sysorg //用于对 Ajax返回数据进行预处理		                  		      		    
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
			onClick: onClick_sysorg
		}
	};
	
	$(function() { 
		refreshZTree_sysorg();	
	}); 
	
	//初始化zTree树
	function refreshZTree_sysorg(){
		$.fn.zTree.init($("#treeDemo_sysorg"), setting_sysorg);
	}

	function ajaxDataFilter_sysorg(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}

	//单击节点事件
	function onClick_sysorg(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo_sysorg");
		var nodes = zTree.getSelectedNodes();		
		if (nodes.length > 0) {
			obj.type = 'ok';
			obj.orgid = nodes[0].orgid;
			obj.orgname = nodes[0].orgname;
			sy.setWinRet(obj);
			parent.$("#"+sy.getDialogId()).dialog("close");
		} else {
			$.messager.alert('提示', '请先选择机构！', 'info');
		}  	
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div style="overflow: true;">
        	<sicp3:groupbox title="机构树">
				<div style="overflow: hidden;" border="false">     	
					<ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:300px;height:400px;"></ul>         
    			</div> 
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>