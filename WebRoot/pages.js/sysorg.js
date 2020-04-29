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
		$("#orgid").val(nodes[0].orgid);
		$("#orgname").val(nodes[0].orgname);
		hideMenu_sysorg();
	}

	function showMenu_sysorg() {
		var cityObj = $("#orgname");
		var cityOffset = $("#orgname").offset();
		$("#menuContent_sysorg").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown_sysorg);
	}
	function hideMenu_sysorg() {
		$("#menuContent_sysorg").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown_sysorg);
	}
	function onBodyDown_sysorg(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent_sysorg" || $(event.target).parents("#menuContent_sysorg").length > 0)) {
			hideMenu_sysorg();
		}
	}
