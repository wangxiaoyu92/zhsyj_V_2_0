<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>稽查工作汇报</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style>


		.layui-table-cell {
			height: auto;
			line-height: 28px;
			padding: 0 15px;
			position: relative;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: normal;
			box-sizing: border-box;
		}
	</style>
	<script type="text/javascript">
		var selectTableDataId = '';
		var grid;
		var table; // 数据表格
		var form; // form表单（查询条件）
		var layer; // 弹出层
		var laydate;
		$(function () {
			layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
				form = layui.form;
				table = layui.table;
				layer = layui.layer;
				var element = layui.element;
				laydate = layui.laydate;

				laydate.render({
					elem: '#plandate'
					,type: 'month'
					, range: '~'
					, done: function (value, date, endDate) {
						var val = value.split('~');
						$('#start').val(val[0]);
						$('#end').val(val[1]);
					}
				});
				var th1 = [
						//fixed:"left"
					{field: 'orgname', width: 140, title: '单位',align: 'center',rowspan:3, event: 'trclick'}
					, {  width: 130, title: '立案',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 130, title: '结案',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 130, title: '移送司法',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 130, title: '执行罚款(元）',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 200, title: '案件信息公示',align: 'center',colspan:3, event: 'trclick'}
					, {  width: 200, title: '抽样检验',align: 'center',colspan:3, event: 'trclick'}
					, {  width: 200, title: '抽检信息公示',align: 'center',colspan:3, event: 'trclick'}
					, {  width: 200, title: '本单位受理投诉举报',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 200, title: '省局交办投诉举报',align: 'center',colspan:2, event: 'trclick'}
					, {  width: 200, title: '省局交办问题核查处置(含国抽）',align: 'center',colspan:3, event: 'trclick'}
					, {  width: 200, title: '协查办理',align: 'center',colspan:3, event: 'trclick'}

				];
				var th2 = [
					{field: 'laby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'lalj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'jaby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'jalj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'yssfby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'yssflj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'zxfkby', width: 90, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'zxfklj', width: 90, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'ajxxgsrw', width: 60, title: '任务',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'ajxxgsby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'ajxxgslj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cyjjrw', width: 60, title: '任务',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cyjjby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cyjjlj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cjxxgsrw', width: 60, title: '任务',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cjxxgsby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'cjxxgslj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'bdwsltsjbby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'bdwsltsjblj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'sjjbtsjbby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'sjjbtsjblj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'sjjbwthcczrw', width: 60, title: '任务',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'sjjbwthcczby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'sjjbwthcczlj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'xcblrw', width: 60, title: '任务',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'xcblby', width: 60, title: '本月',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'xcbllj', width: 60, title: '累计',align: 'center',rowspan:2,event: 'trclick'}

				];

				table.render({
					elem: '#workTable'
					, method: 'post' // 如果无需自定义HTTP类型，可不加该参数
					, url: basePath + 'jcgzhb/queryJcgzhb'
					, page: true // 展示分页
					, limit: 10 // 每页展示条数
					, limits: [10, 20, 30] // 每页条数选择项
					, request: {
						pageName: 'page' //页码的参数名称，默认：page
						, limitName: 'rows' //每页数据量的参数名，默认：limit
					}
					, response: {
						countName: 'total' //数据总数的字段名称，默认：count
						, dataName: 'rows' //数据列表的字段名称，默认：data
					}
					, cols: [th1,th2]
					,done:function(data,curr,count){
						console.log("res"+res);
						console.log("curr"+curr);
						var res = data.rows;





					}
				});

//				// 监听工具条
			table.on('tool(tableFilter)', function (obj) {
					var data = obj.data;
				if (obj.event === 'trclick'&&data.jcgzhbid!='heji') { // 选中行
						if (selectTableDataId != data.jcgzhbid) {
							// 清除所有行的样式
							$(".layui-table-body tr").each(function (k, v) {
							$(v).removeAttr("style");
						});
						$(obj.tr.selector).css("background", selectTableBackGroundColor);
						table.singleData = data;
							selectTableDataId = data.jcgzhbid;
					} else { // 再次选中清除样式
						$(obj.tr.selector).attr("style", "");
							table.singleData = '';
						selectTableDataId = '';
						}
				}
				});

				var $ = layui.$, active = {
					addJcgzhb: function () { // 增
						addJcgzhb();
					},
					daoJcgzhb: function () { // 导出
						daoJcgzhb();
					},
					editJcgzhb: function () { // 改
						if (!table.singleData) {
							layer.alert('请选择要修改的稽查工作汇报信息！');
						} else {
							editJcgzhb(table.singleData.jcgzhbid);
						}
					},
					showJcgzhb: function () { // 查
						if (!table.singleData) {
							layer.alert('请选择要查看的稽查工作汇报信息！');
						} else {
							showJcgzhb(table.singleData.jcgzhbid);
						}
					},
					delJcgzhb: function () { // 删
						if (!table.singleData) {
							layer.alert('请选择要删除的稽查工作汇报信息！');
						} else {
							delJcgzhb(table.singleData.jcgzhbid);
						}
					}
				};
				$('.demoTable .layui-btn').on('click', function () {
					var type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
				//监听提交
				$("#btn_query").bind("click", function () {
					query();
					return false;
				});

			});


		});
		function query() {
			table.singleData = '';
			selectTableDataId = '';
			var orgname = $('#orgname').val();
			var start = $('#start').val();
			var end = $('#end').val();
			var param = {
				'orgname': orgname,
				'end': end,
				'start': start
			};
			table.reload('workTable', {
				url: basePath + 'jcgzhb/queryJcgzhb'
				, page: {
					curr: 1 //重新从第 1 页开始
				}
				, where: param //设定异步数据接口的额外参数
			});
		}
		function daoJcgzhb() {
			var myDate = new Date();
			var a=myDate.getMonth()+1;
			var start = $('#start').val();
			var end = $('#end').val();
			layer.msg('正在导出请稍候', {time: 1000
			});
			$.ajax({
				type:'POST',
				url:basePath + '/jcgzhb/exportToExcel',
				dataType:'json',
				data:{orgname:$("#orgname").val()
				,start:start
					,end:end
				},
				async:false,
				success:function(result){
					window.open(basePath+'/jsp/oa/moban/'+'新稽查'+ a+'月报汇总.xls');
				}
			});


		}
		function addJcgzhb() {
			$.post(basePath + '/jcgzhb/queryJcgzhbORG', {
					},
					function (result) {
						if (result.code == '0') {
							var mydata = result.data;
							var jcgzhb = result.jcgzhb;
							if(jcgzhb=='new'){
								sy.modalDialog({
								 title: '新增稽查工作汇报'
								 , area: ['100%', '100%']
								 , content: basePath + '/jcgzhb/jcgzhbFormIndex?op=add'
								 , btn: ['保存', '取消'] //可以无限个按钮
								 , btn1: function (index, layero) {
								 window[layero.find('iframe')[0]['name']].submitForm();
								 }
								 }, closeModalDialogCallback);
							}else{
								var jcgzhbid=mydata.jcgzhbid;
								sy.modalDialog({
									title: '修改稽查工作汇报'
									, area: ['100%', '100%']
									, content: basePath + '/jcgzhb/jcgzhbFormIndex?jcgzhbid=' + jcgzhbid
									, btn: ['保存', '取消'] //可以无限个按钮
									, btn1: function (index, layero) {
										window[layero.find('iframe')[0]['name']].submitForm();
									}
								}, closeModalDialogCallback);
							}
						} else {
							layer.open({
								title: "提示",
								content: "查询失败：" + result.msg //这里content是一个普通的String
							});
						}
					}, 'json');
		}

		function editJcgzhb(jcgzhbid) {
			sy.modalDialog({
				title: '修改稽查工作汇报'
				, area: ['100%', '100%']
				, content: basePath + '/jcgzhb/jcgzhbFormIndex?jcgzhbid=' + jcgzhbid
				, btn: ['保存', '取消'] //可以无限个按钮
				, btn1: function (index, layero) {
					window[layero.find('iframe')[0]['name']].submitForm();
				}
			}, closeModalDialogCallback);
		}

		function showJcgzhb(jcgzhbid) {
			sy.modalDialog({
				title: '查看稽查工作汇报'
				, area: ['100%', '100%']
				, content: basePath + '/jcgzhb/jcgzhbFormIndex?op=view&jcgzhbid=' + jcgzhbid
				, btn: [ '关闭'] //可以无限个按钮
			});
		};

		function delJcgzhb(jcgzhbid) {
			layer.open({
				title: '警告'
				, content: '你确定要删除该项记录么？'
				, btn: ['确定', '取消'] //可以无限个按钮
				, btn1: function (index, layero) {
					$.post(basePath + '/jcgzhb/delJcgzhb', {
								jcgzhbid: jcgzhbid
							},
							function (result) {
								if (result.code == '0') {
									layer.msg('删除成功', {time: 1000
									}, function () {
										/*table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});*/
										query();
										table.singleData = '';
										selectTableDataId = '';
									});
								} else {
									layer.open({
										title: "提示",
										content: "删除失败：" + result.msg //这里content是一个普通的String
									});
								}
							},
							'json');
				}
			});
		}
		function closeModalDialogCallback(dialogID) {
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj == null || obj == '') {
				return;
			}
			if (obj.type == "ok") {
				table.reload('workTable', {url: basePath + 'jcgzhb/queryJcgzhb'});
				table.singleData = '';
				selectTableDataId = '';
			}
		}
		//从单位信息表中读取
		function myselectcom() {
			sy.modalDialog({
				title: '选择单位'
				, area: ['900px', '470px']
				, param: {
					a: new Date().getMilliseconds(),
					singleSelect: "true",
					comjyjcbz: ""
				}
				, content: basePath + 'work/task/departmentIndex'
				, btn: ['确定', '取消'] //可以无限个按钮
				, btn1: function (index, layero) {
					window[layero.find('iframe')[0]['name']].queding();
				}
			}, function (dialogID) {
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);
				if(obj==null||obj==''){
					return false;
				}
				if (obj.type == "ok") {
					var myrow = obj.data;
					$("#orgname").val(myrow.orgname); //科室名称
					$("#orgid").val(myrow.orgid); //科室代码
				}
			});
		}


	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">搜索条件</h2>
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myqueryform" style="height: 90px">


					<div class="layui-form-item">
						<div class="layui-inline" style="width: auto">
							<label class="layui-form-label">月份</label>

							<div class="layui-input-inline">
								<input type="text" id="plandate"
									   class="layui-input">
							</div>
							<input type="text" name="start" id="start"
								   hidden="hidden">
							<input type="text" name="end" id="end"
								   hidden="hidden">
						</div>
						<div class="layui-inline" style="width: auto">
						<label class="layui-form-label">科室:</label>
						<div class="layui-input-inline" >
							<input type="text" id="orgname" name="orgname" readonly
								   autocomplete="off" class="layui-input">
							<input id="orgid" name="orgid" type="hidden">
						</div>
						<div class="layui-input-inline" style="width: 110px">
							<a href="javascript:void(0)" class="layui-btn"
							   iconCls="icon-search" onclick="myselectcom()">选择科室 </a>
						</div>
							</div>
					</div>

					<div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 190px"></label>
						<div class="layui-input-inline" style="margin-top: -15px;margin-left: -160px">
							<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe615;</i>搜索
							</button>
							<button class="layui-btn layui-btn-sm layui-btn-normal"
									id="btn_reset">
								<i class="layui-icon">&#xe621;</i>重置
							</button>
						</div>
					</div>
</div>
				</form>
			</div>
		</div>
	</div>
	<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 15px;">
		<div class="layui-btn-group demoTable">
                <ck:permission biz="addJcgzhb">
				<button class="layui-btn" data-type="addJcgzhb" data="btn_addJcgzhb">增加</button>
				</ck:permission>
                <ck:permission biz="editJcgzhb">
			    <button class="layui-btn" data-type="editJcgzhb" data="btn_editJcgzhb">修改</button>
				</ck:permission>
                <ck:permission biz="showJcgzhb">
			    <button class="layui-btn" data-type="showJcgzhb" data="btn_showJcgzhb">查看</button>
				</ck:permission>
                <ck:permission biz="delJcgzhb">
			    <button class="layui-btn layui-btn-danger" data-type="delJcgzhb" data="btn_delJcgzhb">删除</button>
				</ck:permission>
                <ck:permission biz="daoJcgzhb">
			    <button class="layui-btn" data-type="daoJcgzhb" data="btn_daoJcgzhb">导出报表</button>
				</ck:permission>
		</div>
	</fieldset>
		<table class="layui-hide" id="workTable" lay-filter="tableFilter"></table>
	</div>
</div>
</body>
</html>
