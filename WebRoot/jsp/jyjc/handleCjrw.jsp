<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_jyjccjrwbid = StringHelper.showNull2Empty(request.getParameter("jyjccjrwbid"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>抽检任务管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
		var v_cjjgrwjsbz = <%=SysmanageUtil.getAa10toJsonArray("CJJGRWJSBZ")%>;
		var v_jcrwzxzt = <%=SysmanageUtil.getAa10toJsonArray("JCRWZXZT")%>;
		var form; // form表单（查询条件）
		var layer; // 弹出层
		var table;
		var laydate;
//		var select;
		$(function () {
			$('#cjjgrwjsbz').attr('disabled', true);
			layui.use(['form', 'layer', 'table'], function () {
				form = layui.form;
				layer = layui.layer;
				table = layui.table;
//				select = layui.select;
				intSelectData("cjjgrwjsbz", v_cjjgrwjsbz);
				intSelectData("jcrwzxzt", v_jcrwzxzt);
				form.render();
				// 主体业态
				var lock = true;// 锁住表单   这里定义一把锁
				var url = basePath + 'jyjc/handleCjrw';
				form.on('submit(save)', function (data) {
					var formData = data.field;
					if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
						return false;
					}
					lock = false  //进来后，立马把锁锁住
					$.post(url, formData, function (result) {
						result = $.parseJSON(result);
						if (result.code == '0') {
							layer.msg('保存成功', {time: 1000}, function () {
								var obj = new Object();
								if(''==('<%=op%>')){
									obj.type = "saveOk";
								}else {
									obj.type="ok";
								}
								sy.setWinRet(obj);
								closeWindow();
							});
						} else {
							layer.open({
								title: '提示'
								, content: '保存失败' + result.msg
							});
							lock = true;
						}
					});
					return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
				});
				if ($('#jyjccjrwbid').val().length > 0) {
					$.post(basePath + 'jyjc/queryCjrwDTO', {
								jyjccjrwbid: $('#jyjccjrwbid').val()
							},
							function (result) {
								if (result.code == '0') {
									var mydata = result.data;
									$('form').form('load', mydata);
									form.render();
								} else {
									layer.open({
										title: "提示",
										content: "查询失败：" + result.msg //这里content是一个普通的String
									});
								}
							}, 'json');
				}
				form.on('select(jcrwzxzt)', function(data){
					var jcrwzxzt=data.value;
					if(jcrwzxzt == '0'){
						$('#cjjgrwjsbz').val('0');
						$('#yy').hide();
					}else if(jcrwzxzt == '20'){
						$('#cjjgrwjsbz').val('2');
						$('#yy').show();
					}else{
						$('#cjjgrwjsbz').val('1');
						$('#yy').hide();
					}
					form.render();
				});
			});
		});
		// 刷新
		function refresh() {
			window.location.reload();
		}

		// 保存企业人员信息
		var saveRwcl = function () {
			if ($('#jcrwzxzt').val() == "20") {
				$('#jcrwzxzt').attr('lay-verify', 'required');
			} else {
				$('#jcrwzxzt').removeAttr('lay-verify', 'required');
			}
			$("#saveRwclBtn").click();
		};
		// 关闭窗口
		var closeWindow = function () {
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		};
	</script>
</head>

<body>
<form class="layui-form" id="fm" method="post">
	<input id="jyjccjrwbid" name="jyjccjrwbid" hidden="true" value="<%=v_jyjccjrwbid%>"/>
	<table class="layui-table" style="width: 99%;" lay-skin="nob">
		<tr hidden="true">
			<td style="text-align:right;width: 120px"><font class="myred">*</font>抽检单位名称:</td>
			<td><input id="commc" name="commc" class="layui-input" lay-verify="required" readonly="readonly"/>
				<input id="comid" name="comid" hidden="true"/>
			</td>
			<td>
				<a id="btnselectcom" href="javascript:void(0)"
				   class="layui-btn" iconCls="icon-search"
				   onclick="myselectcom()">选择抽检单位</a>
			</td>
			<td style="text-align:right;width: 120px"><font class="myred">*</font>承检机构名称:</td>
			<td><input id="cjcommc" name="cjcommc" class="layui-input" lay-verify="required" readonly="readonly"/>
				<input id="cjjgcomid" name="cjjgcomid" hidden="true"/>
			</td>
			<td>
				<a id="btnselectcjcom" href="javascript:void(0)"
				   class="layui-btn" iconCls="icon-search"
				   onclick="myselectcjcom()">选择承检机构</a>
			</td>
		</tr>
		<tr hidden="true">
			<td style="text-align:right;">
				<nobr><font class="myred">*</font>抽检任务名称:</nobr>
			</td>
			<td colspan="3"><input id="jcrwmc" name="jcrwmc" class="layui-input" /></td>
		</tr>
		<tr hidden="true">
			<td style="text-align:right;">
				<nobr>抽检任务描述:</nobr>
			</td>
			<td colspan="4">
				<textarea class="layui-textarea" id="jcrwms" name="jcrwms"
						  rows="10"></textarea>
			</td>
		</tr>
		<tr hidden="true">
			<td style="text-align:right;">
				<nobr>抽检任务开始时间:</nobr>
			</td>
			<td colspan="1"><input id="jcrwkssj" name="jcrwkssj" class="layui-input" lay-verify="required"/></td>
			<td></td>
			<td style="text-align:right;">
				<nobr>抽检任务结束时间:</nobr>
			</td>
			<td colspan="1"><input id="jcrwjssj" name="jcrwjssj" class="layui-input" lay-verify="required"/></td>
		</tr>
		<tr>
			<td style="text-align:right;width: 120px"><nobr>任务执行状态:</nobr>
			</td>
			<td>
				<select id="jcrwzxzt" name="jcrwzxzt" lay-filter="jcrwzxzt"></select>
			</td>
			<td style="text-align:right;">
				<nobr>承检机构任务接受标志:</nobr>
			</td>
			<td>
				<select id="cjjgrwjsbz" name="cjjgrwjsbz"></select>
			</td>
		</tr>
		<tr id="yy" hidden="true">
			<td style="text-align:right;">
				<nobr>承检机构任务不接受原因说明:</nobr>
			</td>
			<td colspan="4">
				<textarea class="layui-textarea" id="cjjgrwbjsyy" name="cjjgrwbjsyy"
						  rows="10"></textarea>
			</td>
		</tr>
	</table>
	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save" id="saveRwclBtn">保存
			</button>
		</div>
	</div>
</form>
</body>
</html>