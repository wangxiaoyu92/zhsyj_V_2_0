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
	<title>工作台账管理</title>
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
		$(function () {
			layui.use(['form', 'table', 'layer', 'element'], function () {
				form = layui.form;
				table = layui.table;
				layer = layui.layer;
				var element = layui.element;
				var months = [
					{text:'一月份'},
					{text:'二月份'},
					{text:'三月份'},
					{text:'四月份'},
					{text:'五月份'},
					{text:'六月份'},
					{text:'七月份'},
					{text:'八月份'},
					{text:'九月份'},
					{text:'十月份'},
					{text:'十一月份'},
					{text:'十二月份'}];
				var curMonth = ${curTime};
				var th1 = [
						//fixed:"left"
					{field: 'orgname', width: 100, title: '科室',align: 'center',rowspan:3, event: 'trclick'}
					, {field: 'workTaskNo', width: 50, title: '序号',align: 'center',rowspan:3, event: 'trclick'}
					, {field: 'workTaskContent', width: 250, title: '工作任务',align: 'center',rowspan:3, event: 'trclick'}
					, {
						field: 'workTaskStep', width: 150, title: '工作措施',align: 'center',rowspan:3, event: 'trclick'
					}
					, {field: 'workTaskWeight', width: 50, title: '权重',align: 'center',rowspan:3, event: 'trclick'}
					, {  width: 200, title: '完成时限',align: 'center',colspan:2, event: 'trclick'}
					, {field: 'workTaskDutyPerson', width: 80, title: '责任人',align: 'center',rowspan:3, event: 'trclick'}
					, {field: 'workTaskDutyLeader',width: 100, title: '责任领导',align: 'center',rowspan:3, event: 'trclick'}

				];

				var th2 = [
					{field: 'workTaskStDate', width: 90, title: '开始时间',align: 'center',rowspan:2,event: 'trclick'}
					, {field: 'workTaskEdDate', width: 90, title: '结束时间',align: 'center',rowspan:2,event: 'trclick'}
				];

				th1.splice(6,0,{ title: '工作进度',width: 70,align: 'center',colspan:curMonth*2, event: 'trclick'});
				for(var i=0;i<curMonth;i++){
					th2.splice((2+i),0,{ width: 150, title: months[i].text,align: 'center',colspan:2, event: 'trclick'});

				}


				var th3 = [];
				for(var i=0;i<curMonth;i++){
					th3.splice(2*i,0,{field: 'ms'+(i+1), width: 150, title: '工作描述',align: 'center',event: 'trclick'},
							{field: 'jd'+(i+1), width: 80, title: '进度',align: 'center',event: 'trclick'});

				}


				table.render({
					elem: '#workTable'


					, method: 'post' // 如果无需自定义HTTP类型，可不加该参数
					, url: basePath + 'work/task/queryYearWorkTask'
					, page: false // 展示分页
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
					, cols: [th1,th2,th3]
					,done:function(data,curr,count){
						console.log("res"+res);
						console.log("curr"+curr);
						var res = data.rows;

						//处理需要跨行的行
						var cur_orgid = "";
						var rowspan = [];
						var currow = null;
						for(var i=0;i<count;i++){
							if(res[i].orgid == cur_orgid){
								rowspan[currow]=rowspan[currow]+1;
							}else{
								rowspan[i]=1;
								currow = i;
								cur_orgid = res[i].orgid;
							}

						}

						//添加rowspan属性
						for(var i=0;i<count;i++){
							if(rowspan[i]!=undefined){
								$($(".layui-table-main [data-field='orgname']")[i]).attr("rowspan",rowspan[i]);
							}
						}

						//移除多余的td
						$(".layui-table-main [data-field='orgname']").each(function(k,v){
							if($(v).attr("rowspan")==undefined){
								v.remove();
							}
						});



					}
				});

//				// 监听工具条
//				table.on('tool(tableFilter)', function (obj) {
//					var data = obj.data;
//					if (obj.event === 'trclick') { // 选中行
//						if (selectTableDataId != data.workTaskId) {
//							// 清除所有行的样式
//							$(".layui-table-body tr").each(function (k, v) {
//								$(v).removeAttr("style");
//							});
//							$(obj.tr.selector).css("background", selectTableBackGroundColor);
//							table.singleData = data;
//							selectTableDataId = data.workTaskId;
//						} else { // 再次选中清除样式
//							$(obj.tr.selector).attr("style", "");
//							table.singleData = '';
//							selectTableDataId = '';
//						}
//					}
//				});

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
			var param = {
				'orgname': orgname
			};
			table.reload('workTable', {
				url: basePath + 'work/task/queryYearWorkTask'
				, page: {
					curr: 1 //重新从第 1 页开始
				}
				, where: param //设定异步数据接口的额外参数
			});
		}


		//从单位信息表中读取
		function myselectcom() {
			sy.modalDialog({
				title: '选择企业'
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
					<div class="layui-form-item" style="text-align:left ">
						<label class="layui-form-label">科室:</label>
						<div class="layui-input-inline">
							<input type="text" id="orgname" name="orgname" readonly
								   autocomplete="off" class="layui-input">
							<input id="orgid" name="orgid" type="hidden">
						</div>
						<div class="layui-input-inline" style="width: 110px">
							<a href="javascript:void(0)" class="layui-btn"
							   iconCls="icon-search" onclick="myselectcom()">选择科室 </a>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 190px"></label>
						<div class="layui-input-inline" style="margin-top: -45px;margin-left: 260px">
							<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe615;</i>搜索
							</button>
							<button class="layui-btn layui-btn-sm layui-btn-normal"
									id="btn_reset">
								<i class="layui-icon">&#xe621;</i>重置
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

		<table class="layui-hide" id="workTable" lay-filter="tableFilter"></table>
	</div>
</div>
</body>
</html>
