<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
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
<title>工作日管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var table; // 数据表格
	var form; // form表单（查询条件）
	var layer; // 弹出层
	var selectTableDataId = '';
	var element;
	
	$(function() {	    

		layui.use(['form', 'table', 'layer','element'], function(){
			form = layui.form;
			table = layui.table;
			layer = layui.layer;
			element=layui.element;
			table.render({
				elem : '#wfworkdayTable'
				,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				,url : basePath + '/workflow/queryWfworkday'
				,page : true // 展示分页
				,limit : 10 // 每页展示条数
				,limits : [ 10, 20, 30 ] // 每页条数选择项
				,cellMinWidth: 80 //全局定义常规单元格的最小宽度
				,request: {
					pageName: 'page' //页码的参数名称，默认：page
					,limitName: 'rows' //每页数据量的参数名，默认：limit
				}
				,response : {
					countName : 'total' //数据总数的字段名称，默认：count
					,dataName : 'rows' //数据列表的字段名称，默认：data
				}
				,cols: [[
					{ field : 'wdyear', title: '工作年度', event: 'trclick' }
				]]
			});
			// 监听工具条
			table.on('tool(wfworkdayTable)', function (obj) {
				var data = obj.data;
				if (obj.event === 'trclick') { // 选中行
					if (selectTableDataId != data.wdyear) {
						// 清除所有行的样式
						$(".layui-table-body tr").each(function(k, v){
							$(v).removeAttr("style");
						});
						$(obj.tr.selector).css("background","#90E2DA");
						table.singleData = data;
						selectTableDataId = data.wdyear;
					} else { // 再次选中清除样式
						$(obj.tr.selector).attr("style","");
						table.singleData = '';
						selectTableDataId = '';
					}
				}
			});

			var $ = layui.$, active = {
				addWfworkday: function(){ // 添加
					addWfworkday();
				}
				,updateWfworkday: function(){ // 修改
					if (!table.singleData) {
						layer.alert('请选择要修改的年度！');
					} else {
						updateWfworkday(table.singleData.wdyear);
					}
				}
				,queryWfworkday: function(){ // 查看
					if (!table.singleData) {
						layer.alert('请选择要查看的年度！');
					} else {
						queryWfworkday(table.singleData.wdyear);
					}
				}
			};
			$('.demoTable .layui-btn').on('click', function(){
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
			//监听提交
			$("#btn_query").bind("click", function(){
				query();
				return false;
			});
		});
	});

	// 查询
	function query() {
		var wdyear = $('#wdyear').val();
		var param = {
			'wdyear': wdyear
		};
		table.singleData = '';
		selectTableDataId = '';
		table.reload('wfworkdayTable', {
			url : basePath + '/workflow/queryWfworkday'
			,where: param //设定异步数据接口的额外参数
		});
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addWfworkday = function() {
		var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
		var dialog = sy.modalDialog({
				title : '添加',
				param : {
					op : "add"
				},
				area : ['950px','600px'],
				content : url
		}, closeModalDialogCallback);
	};
	// 修改
	var updateWfworkday = function(_id) {
			var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
			var dialog = sy.modalDialog({
					title : '修改',
					param : {
						op : "update",
						getCurYear : _id
					},
					area : ['950px','600px'],
					content : url

			}, closeModalDialogCallback);
	};
	// 查看
	var queryWfworkday = function(_id) {
			var url = basePath + 'jsp/workflowcz/wf_workdayForm.jsp';
			var dialog = sy.modalDialog({
					title : '查看',
					param : {
						op : "view",
						getCurYear : _id
					},
					area : ['950px','600px'],
					content : url
			}, closeModalDialogCallback);
	};

	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var obj = sy.getWinRet(dialogID);
		if(obj.type=='ok'){
			query();
//			grid.datagrid('load');
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
</script>
</head>
<body>
	<div class="layui-fluid">
		<div class="layui-collapse">
			<div class="layui-colla-item">
				<h2 class="layui-colla-title">查询条件</h2>
				<div class="layui-colla-content layui-show">
					<form class="layui-form" id="myqueryform" style="height: 80px">
						<div class="layui-form-item" style="text-align:left ">
							<label class="layui-form-label" >工作年度</label>
							<div class="layui-input-inline">
								<input type="text" id="wdyear" name="wdyear" placeholder="请输入工作年度"
									   autocomplete="off" class="layui-input" >
							</div>

							<label class="layui-form-label" style="width: 300px;"></label>
							<div class="layui-input-inline">
								<fieldset class="layui-elem-field site-demo-button" style="border: none;">
									<div>
										<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
											<i class="layui-icon">&#xe615;</i>查询
										</button>
										<button class="layui-btn layui-btn-sm layui-btn-normal"id="btn_reset" >
											<i class="layui-icon">&#xe621;</i>重置
										</button>

									</div>
								</fieldset>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
			<div class="layui-btn-group demoTable">
				<ck:permission biz="addWfworkday" >
					<button class="layui-btn" data-type="addWfworkday" data="btn_addWfworkday">增加年度工作日</button>
				</ck:permission>
				<ck:permission biz="updateWfworkday" >
					<button class="layui-btn" data-type="updateWfworkday" data="btn_updateWfworkday">修改年度工作日</button>
				</ck:permission>
				<ck:permission biz="queryWfworkday" >
					<button class="layui-btn" data-type="queryWfworkday" data="btn_queryWfworkday">查看年度工作日</button>
				</ck:permission>
			</div>
		</fieldset>
		<table class="layui-hide" id="wfworkdayTable" lay-filter="wfworkdayTable"></table>
	</div>
</body>
</html>