<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<script type="text/javascript">
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySystcqZTreeAsync?aaa027lev=5',  //调用后台的方法		     
		    autoParam: ["aaa027"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "aaa027",
				pIdKey: "aaa148",
				rootPId: 0
			},
			key: {
				name: "aaa129"
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
		refreshZTree();	
	}); 
	
	//初始化行政区划树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);	
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.aaa027Data);//获取后台传递的数据
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
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();		

		var aaa027 = nodes[0].aaa027;
		var aaa027Name = nodes[0].aaa027name;
		showJk(aaa027);
	}

	// 监控
	var showJk = function(aaa027) {		
		var tabTitle = "农村聚餐地图监控";
		var url = encodeURI("/jk/jkgl/jcjkmonitorIndex?aaa027="+aaa027);
		addTab(tabTitle,url,'ext-icon-monitor');		
	};

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		var dialog = parent.sy.modalDialog({ 
				width : 980,
				height : 500, 
				url : url
			},function(dialogID){
				var obj = sy.getWinRet(dialogID); 
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$('#aaa027').val(k.aaa027);
						$('#aaa027name').val(k.aaa027name);
					}
				sy.removeWinRet(dialogID);
			});
			
	}
</script>
<div class="easyui-layout" fit="true">       		        
	<div region="center" style="width:250px;overflow: hidden;" border="false">     	
		<ul id="treeDemo" class="ztree" ></ul>	      
    </div> 
</div>  			
          