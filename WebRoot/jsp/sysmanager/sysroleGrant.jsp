<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				 + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String roleid = StringHelper.showNull2Empty(request.getParameter("roleid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>角色绑定菜单权限</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var setting = {
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
				idKey: "functionid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "title"
			}
		},
		callback: {
			onCheck: onCheck
		}
	};

	//勾选或不勾选事件	
	function onCheck(event, treeId, treeNode) { 
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");         
		var nodes = treeObj.getCheckedNodes(true);
		var param = "";
		for(var i=0;i<nodes.length;i++){
			param = param + "functionid=" + nodes[i].functionid + "&";
		}
		$('#treeCheckedNodes').val(param);		     		  
	}

	var roleid = '<%=roleid %>';
	var layer;
	var element;
	$(function() {
		initRolefuncZTree(roleid);
		layui.use(['element','layer'], function(){
			layer = layui.layer;
			element = layui.element;
		});
	});

	// 初始化权限树zTree
	function initRolefuncZTree(roleid){
		$.ajax({
			url: basePath + '/sysmanager/sysrole/querySysfunctionZTree',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: '',
			dataType: 'json',
			error: function() {
				layer.msg('服务器繁忙，请稍后再试！');
			},
			success: function(result) {
				if (result.code == '0') {
					//准备zTree数据
					var zNodes = eval(result.menuData);
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					initCheckedZTreeNodes(roleid);    	
				} else {
					layer.msg(result.msg);
				}				
			}
		});
	}
	
	// 初始化原来权限节点的选中状态
	function initCheckedZTreeNodes(roleid) {
		$.ajax({
			url: basePath + '/sysmanager/sysrole/querySysroleGrant',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: 'roleid=' + roleid,
			dataType: 'json',
			error: function() {
				layer.msg('服务器繁忙，请稍后再试！');
			},
			success: function(result) {
				if (null != result && "[]" != result) {
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
					$.each(result,function(i, item) { //得到节点，并选中
						var node = treeObj.getNodeByParam("functionid", item.functionid, null);
						if (null != node) {
							treeObj.checkNode(node, true, false, true);
						}
					});
				}
			}
		});
	}

	//保存授权
	function saveSysroleGrant($dialog) {
		var param = $('#treeCheckedNodes').val();
		param = param + "roleid=" + roleid;
		$.post(basePath + '/sysmanager/sysrole/saveSysroleGrant', param, function(result) {
			if (result.code=='0'){
				layer.msg('授权成功！', {time : 1000},function(){
					closeWindow();
				});
            } else {
				layer.open({
					type: 4,
					content: "保存失败：" + result.msg //这里content是一个普通的String
				});
            }
		}, 'json');
	}

	// 关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<body>

			<ul id="treeDemo" class="ztree" ></ul>
			<input type="hidden" id="treeCheckedNodes">

</body>
</html>