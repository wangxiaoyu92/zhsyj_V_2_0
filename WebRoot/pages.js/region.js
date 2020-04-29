	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/syscommonfun/queryRegionZTreeAsync?aaa027flag=1&aaa027lev=5',  //调用后台的方法		     
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
		var aaa027 = nodes[0].aab301;
		var aaa027Name = nodes[0].aaa146;

		grid.datagrid('loadData',{"total":0,"rows":[]});
		grid2.datagrid('loadData',{"total":0,"rows":[]});
		queryJkqy(aaa027);
	}