<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>工作流管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var table; // 数据表格
	var form; // form表单（查询条件）
	var layer; // 弹出层
	var selectTableDataId = '';
	
	$(function() {
		layui.use(['form', 'table', 'layer'], function(){
			form = layui.form;
			table = layui.table;
			layer = layui.layer;
			table.render({
				elem : '#wfTable'
				,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
				,url : basePath + '/workflow/queryWfprocess'
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
					{ field : 'psid', title: '工作流流程ID', event: 'trclick',hidden : true },
					{ field : 'psbh', title: '流程编号', event: 'trclick',hidden : false },
					{ field : 'psmc', title: '流程名称', event: 'trclick',hidden : false },
					{ field : 'aae011', title: '添加人姓名', event: 'trclick',hidden : false },
					{ field : 'aae036', title: '添加时间', event: 'trclick',hidden : false }
				]]
			});
			// 监听工具条
			table.on('tool(wfTable)', function (obj) {
				var data = obj.data;
				if (obj.event === 'trclick') { // 选中行
					if (selectTableDataId != data.psid) {
						// 清除所有行的样式
						$(".layui-table-body tr").each(function(k, v){
							$(v).removeAttr("style");
						});
						$(obj.tr.selector).css("background","#90E2DA");
						table.singleData = data;
						selectTableDataId = data.psid;
					} else { // 再次选中清除样式
						$(obj.tr.selector).attr("style","");
						table.singleData = '';
						selectTableDataId = '';
					}
				}
			});

			var $ = layui.$, active = {
				addWfprocess: function(){ // 添加
					addWfprocess();
				}
				,updateWfprocess: function(){ // 修改
					if (!table.singleData) {
						layer.alert('请选择要修改的流程！');
					} else {
						updateWfprocess(table.singleData.psid);
					}
				}
				,getWfprocess: function(){ // 查看
					if (!table.singleData) {
						layer.alert('请选择要查看的流程！');
					} else {
						getWfprocess(table.singleData.psid);
					}
				}
				,delWfprocess: function(){ // 删除
					if (!table.singleData) {
						layer.alert('请选择要查看的流程！');
					} else {
						delWfprocess(table.singleData);
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
		var psbh = $('#psbh').val();
		var param = {
			'psbh': psbh
		};
		table.reload('wfTable', {
			url : basePath + '/workflow/queryWfprocess'
			,where: param //设定异步数据接口的额外参数
		});
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addWfprocess = function() {
		var url = basePath + 'jsp/workflow/addprocess.jsp';
		var v_option='dialogWidth=1000px;dialogHeight=600px;status=no;resizable=yes;minimize:yes;maximize:yes;';
		var obj = window.showModalDialog(url,null,v_option);
		if('ok'==obj){
			query();
		}
	};
	// 修改
	var updateWfprocess = function(psid) {

		$.post(basePath + '/workflow/checkProcessIsUse', {
			psbh: psid
		},
		function(result) {
			console.log(result)
			if (result.code == '0') {
				var url = basePath + 'jsp/workflow/updateprocess.jsp';
                var v_option='dialogWidth=1000px;dialogHeight=600px;status=no;resizable=yes;minimize:yes;maximize:yes;';
				window.showModalDialog(basePath + 'jsp/workflow/updateprocess.jsp?name='+psid,null,v_option);
				return;
			}else{
				layer.alert("操作失败：" + result.msg, 'error');
				return;
			}
		},'json');
	};
	// 查看
	var getWfprocess = function(psid) {
        var v_option='dialogWidth=1000px;dialogHeight=600px;status=no;resizable=yes;minimize:yes;maximize:yes;';
		window.showModalDialog(basePath + 'jsp/workflow/viewprocess.jsp?name='+psid,null,v_option);
	};

	// 删除
	var delWfprocess = function(ps) {
		var index = layer.confirm('您确定要删除这条记录吗，这将删除对应的工作流相关信息，且不可恢复！',function(r) {
			if (r) {
				$.post(basePath + '/workflow/delWfprocess', {
					psbh: ps.psbh,
					psmc: ps.psmc,
					psid: ps.psid
				},
				function(result) {
					if (result.code == '0') {
						query();
						layer.close(index);
					} else {
						layer.alert("操作失败：" + result.msg, 'error');
					}
				},
				'json');
			}
		});
	};

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
							<label class="layui-form-label" >工作流编号</label>
							<div class="layui-input-inline">
								<input type="text" id="psbh" name="psbh" placeholder="工作流编号"
									   autocomplete="off" class="layui-input" >
							</div>

							<label class="layui-form-label" style="width: 300px;"></label>
							<div class="layui-input-inline">
								<fieldset class="layui-elem-field site-demo-button" style="border: none;">
									<div>
										<ck:permission biz="queryWfworkday" >
											<button id="btn_queryWfworkday" class="layui-btn layui-btn-sm layui-btn-normal"
													lay-submit="" data="btn_queryWfworkday">
												<i class="layui-icon">&#xe615;</i>查询
											</button>
										</ck:permission>
										<button class="layui-btn layui-btn-sm layui-btn-normal"
												id="btn_reset" >
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
				<ck:permission biz="addWfprocess" >
					<button class="layui-btn" data-type="addWfprocess" data="btn_addWfprocess">新增</button>
				</ck:permission>
				<ck:permission biz="updateWfprocess" >
					<button class="layui-btn" data-type="updateWfprocess" data="btn_updateWfprocess">修改</button>
				</ck:permission>
				<ck:permission biz="getWfprocess" >
					<button class="layui-btn" data-type="getWfprocess" data="btn_getWfprocess">查看</button>
				</ck:permission>
				<ck:permission biz="delWfprocess" >
					<button class="layui-btn layui-btn-danger" data-type="delWfprocess" data="btn_delWfprocess">删除</button>
				</ck:permission>
			</div>
		</fieldset>
		<table class="layui-hide" id="wfTable" lay-filter="wfTable"></table>
	</div>
</body>
</html>