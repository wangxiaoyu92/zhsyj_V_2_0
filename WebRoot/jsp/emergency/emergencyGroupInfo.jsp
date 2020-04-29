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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	// 应急小组id
	String v_groupid = StringHelper.showNull2Empty(request.getParameter("groupid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>应急小组信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var table; // 数据表格
var form; // form表单（查询条件）
var layer; // 弹出层
var selectTableDataId = '';
$(function() {
	layui.use(['table','form','layer'],function(){
		table=layui.table;
		form=layui.form;
		layer = layui.layer;
        var lock = true;// 锁住表单   这里定义一把锁
		form.on('submit(save)', function(data){
			var formData = data.field;
			var url= basePath + '/emergency/saveEmergencyGroup';
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
	});
		if ($('#groupid').val().length > 0) {
			$.post(basePath + '/emergency/queryEmergencyGroupDto', {
				groupid : $('#groupid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;	
					$('form').form('load', mydata);		
				} else {
					layer.open({
						title : "提示",
						content: "查询失败：" + result.msg //这里content是一个普通的String
					});
                }
			}, 'json');
			if('<%=op%>' == 'view'){	
				$('form :input').addClass('layui-input layui-bg-gray');
				$('form :input').attr('readonly','readonly');	
			}
		}
});

	// 保存 
	var submitForm = function() {
		$("#emergencyAddDlgfm").click();
	};

// 关闭窗口
var closeWindow = function(){
	parent.layer.close(parent.layer.getFrameIndex(window.name));
};

</script>
</head>
<body>
<form class="layui-form" action="" id="fm">
	<input id="groupid" name="groupid" type="hidden" value="<%=v_groupid%>"/>
	<table class="layui-table" lay-skin="nob">
		<tr>
			<td style="width:150px;text-align:right;"><nobr><span style="color: red;">*</span>应急小组名:</nobr></td>
			<td colspan="3"><input id="groupname" name="groupname" class="layui-input" lay-verify="required"/></td>
		</tr>
		<tr>
			<td style="text-align:right;">备注:</td>
			<td colspan="3">
						<textarea id="remark" name="remark" class="layui-textarea"
								  rows="5"></textarea>
			</td>
		</tr>
	</table>
	<div class="layui-form-item" style="display: none">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="save" id="emergencyAddDlgfm">保存
			</button>
		</div>
	</div>
</form>
</body>
</html>