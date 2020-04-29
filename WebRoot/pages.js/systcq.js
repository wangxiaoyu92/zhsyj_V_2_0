	var setting_aaa027 = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySystcqZTreeAsync',  //调用后台的方法		     
		    autoParam: ["aaa027"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter_aaa027 //用于对 Ajax返回数据进行预处理		                  		      		    
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
			onClick: onClick_aaa027
		}
	};

	$(function() { 
		refreshZTree_aaa027();	
	}); 
	
	//初始化zTree树
	function refreshZTree_aaa027(){
		$.fn.zTree.init($("#treeDemo_aaa027"), setting_aaa027);
	}

	function ajaxDataFilter_aaa027(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.aaa027Data);//获取后台传递的数据
	    return zNodes;
	}
	
	//单击节点事件
	function onClick_aaa027(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo_aaa027");
		var nodes = zTree.getSelectedNodes();		
		$("#aaa027").val(nodes[0].aaa027);
		$("#aaa027name").val(nodes[0].aaa027name);
		var aab301 = '';
		var checkNode = nodes[0];		
		while (checkNode.aaa148 > 0) {
			if (checkNode.aaa148 != 0) {
				checkNode = checkNode.getParentNode();
				aab301 = checkNode.aaa129 + aab301;
			} else {
				break;
			}
		}
		//alert(aab301 + nodes[0].aaa027name);
		$('#aab301').val(aab301 + nodes[0].aaa027name);
		hideMenu_aaa027();
	}

	function showMenu_aaa027() {
		var cityObj = $("#aaa027name");
		var cityOffset = $("#aaa027name").offset();
		$("#menuContent_aaa027").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		
		$("#menuContent_aaa027").attr("z-index",999);
		
		$("body").bind("mousedown", onBodyDown_aaa027);
	}
	function hideMenu_aaa027() {
		$("#menuContent_aaa027").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown_aaa027);
	}
	function onBodyDown_aaa027(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent_aaa027" || $(event.target).parents("#menuContent_aaa027").length > 0)) {
			hideMenu_aaa027();
		}
	}