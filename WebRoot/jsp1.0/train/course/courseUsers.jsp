<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	//课程ID
	String v_courseId = StringHelper.showNull2Empty(request.getParameter("courseId"));
%>

<!DOCTYPE HTML>
<html>
<head>
<title>课程人员管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
    var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
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
			onClick: onClick
		}
	};
	$(function() { 
		refreshZTree();	
	}); 
	//初始化zTree树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);
	}
	// 数据过滤
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}
	//单击节点事件
	function onClick(event, treeId, treeNode) {         
		grid.datagrid({
			url : basePath + '/sysmanager/sysuser/querySysuser',			
			queryParams : {'orgid':treeNode.orgid}
		});
		grid.datagrid('unselectAll'); 		  
	}
    </script>
<script type="text/javascript">
	var v_userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var v_lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>;
	var grid; // 用户信息表
	var courseUserGrid; // 课程用户表
	$(function() {
		// 初始化用户表
		grid = $('#grid').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : false,// True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField : 'userid', //该列是一个唯一列
			sortOrder : 'asc',
			columns : [ [ {
				field : "ck",
				checkbox : true
			},{
				width : '100',
				title : '用户ID',
				field : 'userid',
				hidden : true
			},{
				width : '80',
				title : '用户',
				field : 'username',
				hidden : false
			},{
				width : '80',
				title : '用户描述',
				field : 'description',
				hidden : false
			},{
				width : '100',
				title : '用户类别',
				field : 'userkind',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_userkind,value);
				}
			},{
				width : '100',
				title : '手机号',
				field : 'mobile',
				hidden : false
			},{
				width : '80',
				title : '账户锁定状态',
				field : 'lockstate',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_lockstate,value);
				}
			},{
				width : '200',
				title : '统筹区',
				field : 'aaa027',
				hidden : true
			} ] ]
		});
		
		// 初始化应急小组成员表
		courseUserGrid= $('#courseUserGrid').datagrid({
			url : basePath + 'train/course/queryCourseUsers',
			queryParams : { courseId : <%=v_courseId%> },// 请求参数
			striped : true, // 奇偶行使用不同背景色
			singleSelect : false, // True只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,			
			pagination : true, // 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : false,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
			idField: 'courseUserId', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [ {
					field: "ck",
					checkbox: true
				},{
					title: '课程用户中间表id',
					field: 'courseUserId',
					width : '100',
					hidden : true
				},{
					title: '课程信息id',
					field: 'courseId',
					width : '200',
					hidden : true
				},{
					title: '用户id',
					field: 'userId',
					width: '100',
					hidden: true
				},{
					title: '用户名',
					field: 'username',
					width: '100',
					hidden: false
				},{
					title: '用户描述',
					field: 'description',
					width: '100',
					hidden: false
				},{
					title: '手机号',
					field: 'mobile',
					width: '100',
					hidden: false
				},{
					title: '部门名称',
					field: 'orgname',
					width: '100',
					hidden: false
				},{
					width : '100',
					title : '用户类别',
					field : 'userkind',
					hidden : false,
					formatter : function(value, row) {
						return sy.formatGridCode(v_userkind,value);
					}
				} ] ]
		});
	});
	
	//刷新
	function refresh(){
		parent.window.refresh();	
	} 
		
	// 添加用户到课程关系表(多选)
	function addUserToCourse(){
		var rows1 = grid.datagrid("getSelections");
		var data = $.array.clone(rows1);
		if (data.length == 0) {
			$.messager.alert('操作提醒', '您未选择任何数据!', 'info',function(){
				return;
			});
		} else {
			var rows = grid.datagrid("getSelections");
			var JsonStr = $.toJSON(rows);
			var param = {
				'JsonStr' : JsonStr,
				'courseId' : <%=v_courseId%>
			};
			$.post(basePath + 'train/course/addUserToCourse', param, function(result){
				if(result.code=='0'){
					$.messager.alert('提示', '操作成功！', 'info', function(){
						$('#courseUserGrid').datagrid('reload'); 
					});
				} else {
		             $.messager.alert('提示', '操作失败：' + result.msg,'error');
              	}
			},'json');
		}
	
	}
		
	// 将用户从小组中移除
	function delUserOutOfCourse(){
		var rows1 = courseUserGrid.datagrid("getSelections");
	 	var data = $.array.clone(rows1);
	 	if(!data.length){
	 		$.messager.alert('操作提醒', '您未选择任何数据!', 'info');
			return;
	 	}else{
		var rows = courseUserGrid.datagrid("getSelections");
		var JsonStr = $.toJSON(rows);
		var param = {
			'JsonStr' : JsonStr,
			'courseId' :<%=v_courseId%>
	    };
		$.post(basePath + 'train/course/delUserOutOfCourse', param,function(result) {
			if (result.code == '0') {
				$.messager.alert('提示', '操作成功！', 'info', function() {
				$('#courseUserGrid').datagrid('reload');
				});
			} else {
				$.messager.alert('提示', '操作失败：' + result.msg,'error');
			}
		}, 'json');
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<input id="courseId" name="courseId" type="hidden" value="<%=v_courseId%>"/>
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
    	</div>
    	<div region="center" style="overflow: true;" border="false">
     		<sicp3:groupbox title="用户列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_addUserToCourse" iconCls="ext-icon-user_add"
								plain="true" onclick="addUserToCourse()">加入到课程</a></td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:250px;overflow:auto;"></div>
			</sicp3:groupbox>
	 		<br><br>
	 		<sicp3:groupbox title="课程用户关系列表">
	 	    	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delUserOutOfCourse"
								iconCls="ext-icon-user_delete" plain="true" onclick="delUserOutOfCourse()">从课程中移除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
						</tr>
					</table>
				</div>
				<div id="courseUserGrid" style="height:250px;overflow:auto;"></div>
	 		</sicp3:groupbox>
    	</div>
	</div>
</body>
</html>
