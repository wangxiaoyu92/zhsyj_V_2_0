<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				 + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String itemid = StringHelper.showNull2Empty(request.getParameter("itemid"));
	String contentid = StringHelper.showNull2Empty(request.getParameter("contentid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>项目内容</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var form;
	var layer;
	$(function() {
		layui.use(['form','layer'], function () {
			form = layui.form;
			layer = layui.layer;
			form.render();
            var lock = true;// 锁住表单   这里定义一把锁
			form.on('submit(saveContent)', function(data){
				var formData = data.field;
				var url= basePath + 'omlaw/saveContent';
                if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                    return false;
                }
                lock = false;  //进来后，立马把锁锁住
				$.post(url, formData, function (result) {
					result = $.parseJSON(result);
					if (result.code == "0"){
						layer.msg('保存成功！', {time : 500},function(){
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
							title : "提示",
							content: "保存失败：" + result.msg //这里content是一个普通的String
						});
                        lock = true;//业务逻辑执行失败了，打开锁
					}
				});
				return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
			if ($('#contentid').val().length > 0) {
				$.post(basePath + 'omlaw/queryContentByContent',{
							contentid : $('#contentid').val()
						},
						function(result) {
							if (result.code=='0') {
								var mydata = result.data;
								$('#fm').form('load', mydata);
								form.render();
							} else {
								layer.open({
									title : "提示",
									content: "查询失败：" + result.msg //这里content是一个普通的String
								});
							}
						}, 'json');

				if('<%=op%>' == 'view'){
					$('form :input').addClass('input_readonly');
					$('form :input').attr('readonly','readonly');
					$('.Wdate').attr('disabled',true);
				}
			}
		});
	});
	// 保存检查项目内容信息
	var saveContent = function() {
		$("#saveContentBtn").click();
	};

	// 关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}

</script>
</head>

<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" action="">
			<input id="contentid" name="contentid" hidden="true" value='<%=contentid%>'/>
			<div class="layui-form-item">
				<label class="layui-form-label">项目ID:</label>
				<div class="layui-input-inline">
					<input type="text" id="itemid" name="itemid" readonly style="width: 300px" value='<%=itemid%>'
						   class="layui-input layui-bg-gray">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>编号:</label>

				<div class="layui-input-inline">
					<input type="text" id="contentcode" name="contentcode"  lay-verify="required"
						   class="layui-input" style="width: 300px">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>排序号:</label>
				<div class="layui-input-inline">
					<input type="text" id="contentsortid" name="contentsortid"  lay-verify="number"
						   class="layui-input" style="width: 300px">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>项目内容:</label>
				<div height="100px" class="layui-input-inline" style="width: 650px">
					<textarea class="layui-textarea" id="content" name="content" cols="20" lay-verify="required"
									  rows="10"></textarea>
				</div>
			</div>
			<div class="layui-form-item" style="display: none">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="saveContent"
							id="saveContentBtn">保存</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>