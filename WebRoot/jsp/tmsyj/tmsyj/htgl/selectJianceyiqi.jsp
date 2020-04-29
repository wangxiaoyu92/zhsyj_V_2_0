<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String hviewjgztid = StringHelper.showNull2Empty(request.getParameter("hviewjgztid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>选择进货信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var mygrid;
	var selectTableDataId = '';
	var table; // 数据表格
	var form; // form表单（查询条件）
	var layer; // 弹出层
	var mask;
	$(function() {
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
				, where: {
					'hviewjgztid': '<%=hviewjgztid%>'
				}
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
		});
	});/////////////////////////////////////////

   // 保存
	function queding(){
		if (table.singleData != null && table.singleData != '') {
			var obj = new Object();
			obj.data = table.singleData;
			obj.type = "ok";
			sy.setWinRet(obj);
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		} else {
			layer.alert('请选择一条信息！');
		}
	};

	// 关闭窗口
	var closeWindow = function($dialog){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	};

</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-margin-top-15">
		<table class="layui-hide" id="jcyqTable" lay-filter="tableFilter"></table>
	</div>
</div>
</body>
</html>