<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
<title>产品检测检验信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree2.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
// 产品种类
var v_prozl = <%=SysmanageUtil.getAa10toJsonArray("PROZL")%>;
// 生产单位代码
var v_scdwdm = <%=SysmanageUtil.getAa10toJsonArray("CPPCSCDWDM")%>;
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/spsy/spproduct/queryComProductsListAsync',  //调用后台的方法		     
		    autoParam: [], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "proid",
				pIdKey: "parentid",
				rootPId: 0		
			},
			key: {
				name: "proname"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	$(function() { 
		$.fn.zTree.init($("#comProductTree"), setting);
		mygrid = $('#mygrid').datagrid({
			
			toolbar: '#toolbar',
			//url : basePath + '/spsy/spproduct/queryComProductsPc',	
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'cppcid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : '产品批次ID',
				field : 'cppcid',
				hidden : true
			},{
				width : '150',
				title : '产品名',
				align:'center',
				field : 'proname',
				hidden : false
			},{
				width : '100',
				title : '产品种类',
				field : 'prozl',
				align:'center',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_prozl,value);
				}
			},{
				width : '100',
				title : '产品批次',
				field : 'cppcpch',
				align:'center',
				hidden : false
			},{
				width : '150',
				title : '生产日期',
				field : 'cppcscrq',
				align:'center',
				hidden : false
			},{
				width : '80',
				title : '生产数量',
				field : 'cppcscsl',
				align:'center',
				hidden : false
			},{
				width : '80',
				title : '单位名称',
				field : 'cppcscdwdm',
				align:'center',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_scdwdm,value);
				}
			},{
				width : '100',
				title : '溯源码是否已生成',
				field : 'cppcsymscbz',
				hidden : false,
				formatter : function(value, row) {
					if (value == '1'){
						return "<span style='color:blue;'>已生成</span>";
					} else if (value == '0') {
						return "<span style='color:red;'>未生成</span>";
					}
				}
			},{
				width:350,
				title:'操作',
				field:'opt',
				align:'center',
	            formatter:function(value,rec){ 
					  var v_ret =
					  	'<a href="javascript:addJcjyxx(\''+rec.cppcpch+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/edit_add.png" align="absmiddle">添加检测检疫信息</a>&nbsp;'
					  	+'<a href="javascript:showJcjyxx(\''+rec.cppcpch+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/doc2.png" align="absmiddle">查看检测检疫信息</a>';					  	
	                  return  v_ret; 
	             }   
	        }
			] ]
		});
	}); 

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var zNodes = eval(responseData.ComProducts);//获取后台传递的数据
		var length = zNodes.length;
		if (length == 1) {
			zNodes[0].isParent = false;
		}
	    return zNodes;
	}
	
	//单击节点事件
	function onClick(event, treeId, treeNode) { 
		var param;
		if (!treeNode.isParent) {
			$("#productid").val(treeNode.proid);
			param = {
				'proid': treeNode.proid
			};
		} else {
			param = {};
		}
		$("#mygrid").datagrid({
			url : basePath + '/spsy/spproduct/queryComProductsPc',			
			queryParams : param
		});
		$("#mygrid").datagrid('clearSelections'); 		  
	}
	
	// 添加检测检疫信息
	function addJcjyxx(cppcpch) {		
		var v_productid = $("#productid").val();
		var url = basePath + 'spsy/spproduct/jcjyxxFromIndex';
		parent.sy.modalDialog({
				title : '添加检测检疫信息',
				param : {
					proid : v_productid,
					jcpc : cppcpch
				},
				width : 650,
				height : 300,
				url : url
		}, closeModalDialogCallback);
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$("#mygrid").datagrid("reload"); 
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
	
	// 查看检测检疫信息
	function showJcjyxx(cppcpch) {
		var v_productid = $("#productid").val();
		var url = basePath + 'spsy/spproduct/showJcjyxxFromIndex';
		parent.sy.modalDialog({
				title : '查看检测检疫信息',
				param : {
					proid : v_productid,
					jcpc : cppcpch
				},
				width : 950,
				height : 450,
				url : url
		}, closeModalDialogCallback);
	}
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="comProductTree" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: auto;" border="false">
        	<sicp3:groupbox title="产品批次信息">
				<input type="hidden" name="productid" id="productid">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>   
        </div>       
	</div> 
</body>
</html>