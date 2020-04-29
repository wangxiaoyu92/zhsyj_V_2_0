<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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
<title>选择法律法规</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>

<script type="text/javascript">
	var singleSelect = sy.getUrlParam("singleSelect");
	var v_singleSelect = (singleSelect=="true");

	var setting = {
		async: {
			enable: true, //启用异步加载
			url: basePath + 'omlaw/queryItemZTreeAsync',  //调用后台的方法
			autoParam: ["itemid"], //向后台传递的参数
			otherParam: {}, //额外的参数
			dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
		},
		view: {
			showLine: true
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "itemid",
				pIdKey: "itempid",
				rootPId: 0
			},
			key: {
				name: "itemname"
			}
		},
		callback: {
			onClick: onClick
		}
	};

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.treeData);//获取后台传递的数据
		if (!responseData) {
			for(var i =0; i < responseData.length; i++) {
				//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
				array[i] = {
					id: responseData[i].itemid,
					name: responseData[i].itemname,
					isParent: false,
					itemdesc:itemdesc
				};
			}
		}
		return zNodes;
	}

	//单击节点事件
	function onClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = zTree.getSelectedNodes();
		$("#itempid").val(nodes[0].itempid);
		$("#itemid").val(nodes[0].itemid);
		$("#parentname").val(nodes[0].itemname);
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
		initItemCombotree();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent"
				|| $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	function initItemCombotree() { // 初始化项目树下拉框
		$.fn.zTree.init($("#treeDemo"), setting);
	}

	var grid;
	$(function() {
		grid = $('#grid').datagrid({
			toolbar: '#toolbar',
			url: basePath + 'omlaw/queryContent',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : v_singleSelect,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'contentid', //该列是一个唯一列
			sortOrder: 'asc',
			columns :[[
				{
					width : '150',
					title : '内容ID',
					field : 'contentid',
					hidden : true
				},
				{
					width : '100',
					title : '编号',
					field : 'contentcode',
					hidden : false
				},
				{
					width : '550',
					title : '内容',
					field : 'content',
					hidden : false
				},{
					width : '100',
					title : '排序号',
					field : 'contentsortid',
					hidden : false
				}] ]
		});
		initItemCombotree();
	});

	// 查询
	function query() {
		var itemid = $("#itemid").val();
		var itemname = $("#itemname").val();
		var param = {
			'itemid' : itemid,
			'itemname' : itemname
		};
		$('#grid').datagrid({
			url : basePath + 'omlaw/queryContent',
			queryParams : param
		});
		$('#grid').datagrid('clearSelections');
	}

	//重置
	var reset = function() {
		$('#fm').form('clear');
		grid.datagrid('load', {}); 			
	};

	//选择数据返回
	var getDataInfo = function(){
		var row = grid.datagrid('getSelections');   
	    if(row){
			sy.setWinRet(row);
			parent.$("#" + sy.getDialogId()).dialog("close");
	    }else{
	        $.messager.alert('提示','请先选择数据!','info');
	    }
	};
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: hidden;" border="false">
			<sicp3:groupbox title="法律法规项目信息">
				<form id="fm" name="fm" method="post">
					<table class="table" style="width: 100%;">
						<tr>
							<td style="text-align:right;"><nobr>父项目名称</nobr></td>
							<td>
								<input name="parentname" id="parentname" style="width: 200px; "
									   onclick="showMenu();" readonly="readonly" class="input_readonly"/>
								<input type="hidden" name="itempid" id="itempid"  style="width: 200px; "/>
								<input type="hidden" id="itemid" name="itemid" style="width: 200px;"
									   readonly="readonly" class="input_readonly" />
							</td>
							<td colspan="2" style="text-align: center;">
								<a href="javascript:void(0)" class="easyui-linkbutton"
								   iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
								   iconCls="icon-reload" onclick="reset()"> 重 置 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0)" class="easyui-linkbutton"
								   iconCls="icon-ok" onclick="getDataInfo()">确 定</a>
							</td>
						</tr>
					</table>
				</form>
			</sicp3:groupbox>
			<sicp3:groupbox title="法律法规内容管理">
				<div id="grid" style="height:350px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
		<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>
	</div>
</body>
</html>