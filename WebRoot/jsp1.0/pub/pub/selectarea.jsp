<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
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
<title>地区下拉树</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var singleSelect = sy.getUrlParam("singleSelect");
	var v_singleSelect = (singleSelect=="true");
var checkNodeInfo = {};
var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/syscommonfun/queryRegionZTreeAsync?aaa027lev=5',  //调用后台的方法		     
		    autoParam: ["aab301"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "aab301",
				pIdKey: "aaa148",
				rootPId: 0
			},
			key: {
				name: "aaa146"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	$(function() { 
		refreshZTree();	
	}); 
	
	//初始化行政区划树
	function refreshZTree(){
		$.fn.zTree.init($("#areaTree"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.regionData);//获取后台传递的数据
	    if (!responseData) {
	    	for(var i =0; i < responseData.length; i++) {
	    		//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	    		array[i] = {
					id: responseData[i].aab301,
					name: responseData[i].aaa146,
					isParent: false
				}; 
	      	}
	    }
	    return zNodes;
	}
	// 树节点单击事件		
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("areaTree");
		var nodes = zTree.getSelectedNodes();
		var checkNode = nodes[0];		
		while (checkNode.aae383 > 0) {
			if (checkNode.aae383 == 5) {
				checkNodeInfo.comcunmc = checkNode.aaa146; // 村名称
				checkNodeInfo.comcundm = checkNode.aab301; // 村代码值
			} else if (checkNode.aae383 == 4) {
				checkNodeInfo.comxiangmc = checkNode.aaa146; // 乡名称
				checkNodeInfo.comxiangdm = checkNode.aab301; // 乡代码值
			} else if (checkNode.aae383 == 3) {
				checkNodeInfo.comxianmc = checkNode.aaa146; // 县名称
				checkNodeInfo.comxiandm = checkNode.aab301; // 县代码值
			} else if (checkNode.aae383 == 2) {
				checkNodeInfo.comshimc = checkNode.aaa146; // 市名称
				checkNodeInfo.comshidm = checkNode.aab301; // 市代码值
			} else if (checkNode.aae383 == 1) {
				checkNodeInfo.comshengmc = checkNode.aaa146; // 省名称
				checkNodeInfo.comshengdm = checkNode.aab301; // 省代码值
			} 
			if (checkNode.aae383 != 1) {
				checkNode = checkNode.getParentNode();
			} else {
				break;
			}
		}
	}

	function refresh(){
		refreshZTree();
		checkNodeInfo = {};
	} 
	
	function queding(){
	 	var zTree = $.fn.zTree.getZTreeObj("areaTree");
		var nodes = zTree.getSelectedNodes();
	    if (nodes.length > 0) {
			sy.setWinRet(checkNodeInfo);
			parent.$("#"+sy.getDialogId()).dialog("close");
		} else {
			$.messager.alert('提示', '请先选择地区节点！', 'info');
		} 
	 }
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div style="overflow: true;">
        	<sicp3:groupbox title="地区树">
				<div style="width:780px;height:530px; overflow: hidden;" border="false">     	
					<ul id="areaTree" class="ztree" ></ul>	      
    			</div> 
    			<table class="table" style="width: 99%;">
					<tr>
					  	<td colspan="2">
					  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
								&nbsp;&nbsp;&nbsp;&nbsp;								
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>