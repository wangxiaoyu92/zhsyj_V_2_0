<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 应急小组id
	String v_groupid = StringHelper.showNull2Empty(request.getParameter("groupid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>应急小组成员管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
    var mask;//进度条
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
        mask = layer.load(1, {shade: [0.1, '#393D49']});
		var param={'orgid':treeNode.orgid};
		table.reload('table1',{
			url:basePath + '/sysmanager/sysuser/querySysuser',
			where:param
            ,done:function (res, curr, count) {
                layer.close(mask);
            }
		});
	}
</script>
<script type="text/javascript">
	//下拉框列表
	var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
	var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>;
	var cb_userkind; // 用户类别
	var cb_lockstate; // 用户锁定状态
	var selectTableDataId = '';
	var table; // 数据表格
	var form; // form表单（查询条件）
	var layer; // 弹出层
	$(function() {
		layui.use(['table','form','layer','element'],function(){
			table=layui.table;
			form=layui.form;
			layer = layui.layer;
			var element=layui.element;
			table.render({
				elem : '#table1'
				,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				/*,url : basePath + 'sysmanager/sysuser/querySysuser'*/
				,page : true // 展示分页
				,limit : 10 // 每页展示条数
				,limits : [ 10, 20, 30 ] // 每页条数选择项
				,request: {
					pageName: 'page' //页码的参数名称，默认：page
					,limitName: 'rows' //每页数据量的参数名，默认：limit
				}
				,response : {
					countName : 'total' //数据总数的字段名称，默认：count
					,dataName : 'rows' //数据列表的字段名称，默认：data
				}
				,cols:[[
					{type:'checkbox'}
					,{ field : 'username', width : 100, title: '用户' ,event: 'trclick'}
					,{ field : 'description', width : 150, title: '用户描述' ,event: 'trclick'}
					,{ field : 'userkind', width : 150, title: '用户类别'
						,templet:function(d){
							return sy.formatGridCode(userkind, d.userkind);
						}
					,event: 'trclick'}
					,{ field : 'mobile', width : 120, title: '手机号' ,event: 'trclick'}
					,{ field : 'lockstate', width : 150, title: '账户锁定状态'
						,templet:function(d){
							if (d.lockstate == "1"){
								return '<span style="color:red;">' + sy.formatGridCode(lockstate, d.lockstate) + '</span>';
							}else{
								return sy.formatGridCode(lockstate,d.lockstate);
							}
						}
						,event: 'trclick'}
				]]
			});
			//监听表格复选框选择
			table.on('checkbox(UserFilter1)', function(obj){
				/*console.log(obj)*/
			});
			//监听工具条
			table.on('tool(UserFilter1)', function(obj){
				var data = obj.data
			});
			table.render({
				elem : '#table2'
				,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				,url : basePath + '/emergency/queryEmergencyGroupPerson'
				,where:{groupid:'<%=v_groupid%>'}
				,page : true // 展示分页
				,limit : 10 // 每页展示条数
				,limits : [ 10, 20, 30 ] // 每页条数选择项
				,request: {
					pageName: 'page' //页码的参数名称，默认：page
					,limitName: 'rows' //每页数据量的参数名，默认：limit
				}
				,response : {
					countName : 'total' //数据总数的字段名称，默认：count
					,dataName : 'rows' //数据列表的字段名称，默认：data
				}
				,cols:[[
					{type:'checkbox'}
					,{field: 'username',width:100,title: '用户名', event: 'trclick'}
					, {field: 'description',width:150, title: '用户描述', event: 'trclick'}
					, {field: 'mobile',width:150,title: '手机号', event: 'trclick'}
					, {field: 'orgname',width:150,title: '部门名称', event: 'trclick'}
					, {field: 'userkind',width:100,title: '用户类别'
						,templet:function(d){
							return sy.formatGridCode(userkind, d.userkind);
						}
						, event: 'trclick'}
					, {field: 'etptype',width:100,title: '成员类型', event: 'trclick'}
					, {field: 'etpremark',width:100,title: '备注', event: 'trclick'}
				]]
			});
			var $ = layui.$, active = {
				addUserToGroup: function () { //获取选中数据
					var checkStatus = table.checkStatus('table1')
							,data = checkStatus.data;
					/*alert(JSON.stringify(data));*/
					if(data!=""){
						addUserToGroup(data);
					}else {
						layer.alert("您未选择任何数据");
					}

				}
				,updateGroupUser: function () { //获取选中数据
					var checkStatus = table.checkStatus('table2')
							,data = checkStatus.data;
					if(data!=""){
						if(data.length>1){
							layer.alert('请选中一条记录进行修改！');
						}else{
							updateGroupUser(data[0].etpid);
						}
					}else {
						layer.alert("您未选择任何数据");
					}
				}
				,delUserOutOfGroup: function () { //获取选中数据
					var checkStatus = table.checkStatus('table2')
							,data = checkStatus.data;
					if(data!=""){
						delUserOutOfGroup(data);
					}else {
						layer.alert("您未选择任何数据");
					}
				}
			};
			$('.demoTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
		});
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 添加用户到应急小组(多选)
	function addUserToGroup(data) {
		/*alert(111);*/
		var JsonStr=JSON.stringify(data);
		var param = {
			'JsonStr' : JsonStr,
			'groupid' : '<%=v_groupid%>'
		};  
		$.post(basePath + '/emergency/addUserToEmergencyGroup', param, function(result) {
			if (result.code=='0'){
				layer.msg('操作成功', {time: 500}, function () {
					table.reload('table2',{
						url:basePath + '/emergency/queryEmergencyGroupPerson',
						where:{groupid:'<%=v_groupid%>'}
					});
					closeWindow();
				});
             	} else {
				layer.open({
					title: '提示'
					, content: '操作失败' + result.msg
				});
             		/*$.messager.alert('提示','操作失败：'+result.msg,'error');*/
               }
		}, 'json');
		
	} 
	// 编辑成员信息
	function updateGroupUser(etpid) {
		parent.sy.modalDialog({
			title : '编辑成员信息'
			,area : ['100%', '100%']
			,content :basePath + 'emergency/emergencyGroupPersonFromIndex?etpid='+etpid
			,btn:['保存','关闭']
			,btn1: function(index, layero){
				parent.window[layero.find('iframe')[0]['name']].submitForm();
			}
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if(obj == null || obj ==''){
				return
			}
			if(obj.type == "ok"){
				table.reload('table2',{
					url:basePath + '/emergency/queryEmergencyGroupPerson',
					where:{groupid:'<%=v_groupid%>'}
				});
			}
		});
	}
	
	// 将用户从小组中移除
	function delUserOutOfGroup(data) {
		var JsonStr=JSON.stringify(data);
		var param = {
			'JsonStr' : JsonStr,
			'groupid' : '<%=v_groupid%>'
		};
		$.post(basePath + '/emergency/delUserOutOfEmergencyGroup', param, function(result) {
			if (result.code=='0'){
				layer.msg('操作成功', {time: 500}, function () {
					table.reload('table2',{
						url:basePath + '/emergency/queryEmergencyGroupPerson',
						where:{groupid:'<%=v_groupid%>'}
					});
					table.singleData = '';
					selectTableDataId = '';
					closeWindow();
				});
			} else {
				layer.open({
					title: '提示'
					, content: '操作失败' + result.msg
				});
				/*$.messager.alert('提示','操作失败：'+result.msg,'error');*/
			}
		}, 'json');
	}  	
</script>
</head>
<body>
<div class="layui-layout-body" style="width: 100%">
	<input id="groupid" name="groupid" type="hidden" value="<%=v_groupid%>"/>
	<div class="layui-side layui-bg-gray" style="width: 250px;">
		<div class="layui-side-scroll" style="width:250px;">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
	</div>
	<div class="layui-body" style="margin-left: 55px; ">
		<div class="layui-collapse">
			<div class="layui-colla-item">
				<h2 class="layui-colla-title">用户列表</h2>
				<div class="layui-colla-content layui-show">
					<div class="layui-btn-group demoTable">
						<ck:permission biz="addUserToGroup">
							<button class="layui-btn" data-type="addUserToGroup"
									data="btn_addUserToGroup">加入到应急小组</button>
						</ck:permission>
					</div>
					<table class="layui-hide" id="table1" lay-filter="UserFilter1"></table>
				</div>
			</div>
			<div class="layui-colla-item">
				<h2 class="layui-colla-title">应急小组成员关系列表</h2>
				<div class="layui-colla-content layui-show">
					<div class="layui-btn-group demoTable">
						<ck:permission biz="updateGroupUser">
							<button class="layui-btn" data-type="updateGroupUser"
									data="btn_updateGroupUser">编辑成员信息</button>
						</ck:permission>
						<ck:permission biz="delUserOutOfGroup">
							<button class="layui-btn" data-type="delUserOutOfGroup"
									data="btn_delUserOutOfGroup">从小组中移除</button>
						</ck:permission>
					</div>
					<table class="layui-hide" id="table2" lay-filter="UserFilter2"></table>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>