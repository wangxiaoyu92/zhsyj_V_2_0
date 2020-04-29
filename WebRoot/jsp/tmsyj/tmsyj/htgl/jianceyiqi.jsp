<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
	<title>检测仪器管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<%--<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>--%>
	<script type="text/javascript">
		var selectTableDataId = '';
		var table; // 数据表格
		var form; // form表单（查询条件）
		var layer; // 弹出层
		var mask;
		$(function () {
			layui.use(['form', 'table', 'layer', 'element'], function () {
				form = layui.form;
				table = layui.table;
				layer = layui.layer;
				var element = layui.element;
				mask = layer.load(1, {shade: [0.1, '#393D49']});
				form.render();
				table.render({
					elem: '#jcyqTable'
					, method: 'post' // 如果无需自定义HTTP类型，可不加该参数
					, url: basePath + '/tmsyjhtgl/queryJianceyiqi'
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
					, cols: [[
						{field: 'jgztmc', width: 180, title: '检测机构名称', event: 'trclick'}
						,{field: 'jcyqmc', width: 180, title: '检测仪器名称', event: 'trclick'}
						, {field: 'jcyqxh', width: 200, title: '检测仪器型号', event: 'trclick'}
						, {field: 'jcyqxlh', width: 140, title: '检测仪器序列号', event: 'trclick'}
						, {field: 'jcyqgmrq', width: 140, title: '检测仪器购买日期', event: 'trclick'}
						,{field: 'jcyqscrq', width: 180, title: '检测仪器生产日期', event: 'trclick'}
						, {field: 'jcyqsccj', width: 150, title: '检测仪器生产厂家', event: 'trclick'}
						, {field: 'jcyqjcxm', width: 200, title: '检测仪器检测项目', event: 'trclick'}
						, {field: 'jcyqcpyt', width: 150, title: '检测仪器产品用途', event: 'trclick'}
						, {field: 'aae011', width: 100, title: '操作员', event: 'trclick'}
						, {field: 'aae036', width: 140, title: '操作时间', event: 'trclick'}
					]]
					, done: function (res, curr, count) {
						table.singleData = '';
						selectTableDataId = '';
						layer.close(mask);
					}
				});
				// 监听工具条
				table.on('tool(tableFilter)', function (obj) {
					var data = obj.data;
					if (obj.event === 'trclick') { // 选中行
						if (selectTableDataId != data.hjcjgjcyqbid) {
							// 清除所有行的样式
							$(".layui-table-body tr").each(function (k, v) {
								$(v).removeAttr("style");
							});
							$(obj.tr.selector).css("background", selectTableBackGroundColor);
							table.singleData = data;
							selectTableDataId = data.hjcjgjcyqbid;
						} else { // 再次选中清除样式
							$(obj.tr.selector).attr("style", "");
							table.singleData = '';
							selectTableDataId = '';
						}
					}
				});

				var $ = layui.$, active = {
					addJianceyiqi: function () { // 添加
						addJianceyiqi();
					}
					, editJianceyiqi: function () { // 修改
						if (!table.singleData) {
							layer.alert('请选择要修改的仪器信息！');
						} else {
							editJianceyiqi(table.singleData.hjcjgjcyqbid);
						}
					}
					, delJianceyiqi: function () { // 删除
						if (!table.singleData) {
							layer.alert('请选择要删除的仪器信息！');
						} else {
							delJianceyiqi(table.singleData.hjcjgjcyqbid);
						}
					}
					, viewJianceyiqi: function () { // 查看
						if (!table.singleData) {
							layer.alert('请选择要查看的仪器信息！');
						} else {
							viewJianceyiqi(table.singleData.hjcjgjcyqbid);
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
			var jcyqmc = $('#jcyqmc').val();
			var param = {
				'jcyqmc': jcyqmc
			};
			refresh(param, '');
		}

		// 刷新
		function refresh(param, cur) {
			mask = layer.load(1, {shade: [0.1, '#393D49']});
			//删除时 在本页面刷新
			if (cur == "") {
				curr = 1;
			} else {
				curr = cur;
			}
			table.reload('jcyqTable', {
				url: basePath + '/tmsyjhtgl/queryJianceyiqi'
				, page: {
					curr: curr //重新从第 1 页开始
				}
				, where: param //设定异步数据接口的额外参数
				, done: function () {
					table.singleData = '';
					selectTableDataId = '';
					layer.close(mask);
				}
			});
		}

		// 新增抽检任务
		function addJianceyiqi() {
			sy.modalDialog({
				title: '添加检测仪器'
				, area: ['100%', '100%']
				, content: basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=add'
				, btn: ['保存', '取消']
				, btn1: function (index, layero) {
					window[layero.find('iframe')[0]['name']].submitForm();
				}
			}, closeModalDialogCallback);
		}
		function closeModalDialogCallback(dialogID) {
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj == null || obj == '') {
				return;
			}
			if (obj.type == "ok") {
				//其他在本页刷新
				var curent = $(".layui-laypage-skip input[class='layui-input']").val();
				refresh('', curent);
			} else {
				//saveOk 在第一页刷新
				refresh('', '');
			}
		}
		//编辑抽检任务
		function editJianceyiqi(hjcjgjcyqbid) {
			sy.modalDialog({
				title: '编辑检测仪器'
				, area: ['100%', '100%']
				, content: basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=edit&hjcjgjcyqbid=' + hjcjgjcyqbid
				, btn: ['保存', '取消']
				, btn1: function (index, layero) {
					window[layero.find('iframe')[0]['name']].submitForm();
				}
			}, closeModalDialogCallback);
		}
		;

		// 删除抽检任务
		function delJianceyiqi(hjcjgjcyqbid) {
			layer.open({
				title: '警告'
				, content: '你确定要删除该项仪器信息么？'
				, icon: 3
				, btn: ['确定', '取消'] //可以无限个按钮
				, btn1: function (index, layero) {
					$.post(basePath + 'tmsyjhtgl/delJianceyiqi', {
								hjcjgjcyqbid: hjcjgjcyqbid
							},
							function (result) {
								if (result.code == '0') {
									//保证不会重复删除
									table.singleData = '';
									selectTableDataId = '';
									//本页的值
									var curent = $(".layui-laypage-skip input[class='layui-input']").val();
									layer.msg('删除成功', {time: 1000}, function () {
										var param = {
											querytype: "jyjc"
										}
										//如果是本页最后一条数据 则返回上一页
										if (table.cache.jcyqTable.length == 1) {
											curent = curent - 1;
										}
										refresh(param, curent);
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

		//查看抽检任务
		function viewJianceyiqi(hjcjgjcyqbid) {
			sy.modalDialog({
				title: '查看检测仪器'
				, area: ['100%', '100%']
				, content: basePath + 'tmsyjhtgl/jianceyiqiFormIndex?op=view&hjcjgjcyqbid=' + hjcjgjcyqbid
				, btn: ['关闭']
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
				<form class="layui-form" id="myqueryform" style="height: auto">
					<table style="border: none">
						<tr>
							<td style="width: 120px;text-align: right">检测仪器名称:</td>
							<td style="width: 150px">
								<input type="text" id="jcyqmc" name="jcyqmc" autocomplete="off" class="layui-input">
							</td>
							<td style="width: 200px;text-align: center">
								<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
									<i class="layui-icon">&#xe615;</i>搜索
								</button>
								<button class="layui-btn layui-btn-sm layui-btn-normal"
										id="btn_reset">
									<i class="layui-icon">&#xe621;</i>重置
								</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div class="layui-margin-top-15">
		<div class="layui-btn-group demoTable">
			<ck:permission biz="addJianceyiqi">
				<button class="layui-btn " data-type="addJianceyiqi" data="btn_addJianceyiqi">增加</button>
			</ck:permission>
			<ck:permission biz="editJianceyiqi">
				<button class="layui-btn " data-type="editJianceyiqi" data="btn_editJianceyiqi">编辑</button>
			</ck:permission>
			<ck:permission biz="delJianceyiqi">
				<button class="layui-btn layui-btn-danger" data-type="delJianceyiqi" data="btn_delJianceyiqi">删除</button>
			</ck:permission>
			<ck:permission biz="viewJianceyiqi">
				<button class="layui-btn" data-type="viewJianceyiqi" data="btn_viewJianceyiqi">查看</button>
			</ck:permission>
		</div>
		<table class="layui-hide" id="jcyqTable" lay-filter="tableFilter"></table>
	</div>
</div>
</body>
</html>