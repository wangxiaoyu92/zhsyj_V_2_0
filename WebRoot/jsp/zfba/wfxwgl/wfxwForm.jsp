<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
	String pwfxwcsid = StringHelper.showNull2Empty(request.getParameter("pwfxwcsid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>违法行为信息</title>
<jsp:include page="${contextPath}/inc.jsp">
	<jsp:param name="isLayUI" value="true"/>
</jsp:include>
<script type="text/javascript">
var mygrid;
var v_ajdjajdl = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
var form; // form表单（查询条件）
var layer; // 弹出层
var wfxwbhOld='';
$(function(){
	layui.use(['form', 'layer'], function(){
		form = layui.form;
		layer = layui.layer;
		intSelectData('ajdjajdl',v_ajdjajdl);
		form.render();
		if ($('#pwfxwcsid').val().length > 0) {
			$.post(basePath + '/zfba/wfxw/findWfxw', {
				pwfxwcsid : $('#pwfxwcsid').val()
			}, function(result) {
				if (result.code == '0') {
					var mydata = result.data;
					for (var attr in mydata) {
						$("#" + attr).val(mydata[attr]);
					}
					wfxwbhOld=mydata.wfxwbh;
					form.render();
				}
			}, 'json');
			if ('<%=op%>' == 'view') {
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly', 'readonly');
				$('#ajdjajdl').attr("disabled", true);
				$("#btn_query").addClass('layui-btn-disabled');
			}
		}
        var lock = true;// 锁住表单   这里定义一把锁
		form.on('submit(saveWfxw)', function(data){
			var formData = data.field;
			var url=basePath + '/zfba/wfxw/saveWfxw';
            if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                return false;
            }
            lock = false;  //进来后，立马把锁锁住
			$.post(url, formData, function (result) {
				result = $.parseJSON(result);
				if (result.code == "0"){
					layer.msg('保存成功！', {time : 1000},function(){
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
	$('#wfxwbh').blur(function () {
		var wfxwbh = $('#wfxwbh').val();
		if (wfxwbh == null || wfxwbh == '') {
			return false;
		}
		if (wfxwbh != wfxwbhOld) {
			checkUniqueness();
		}
	})
/*		$("#btn_query").click(function () {//验证
			checkUniqueness();
			return false;
		})*/
	});
//验证违法行为标号唯一性
function checkUniqueness() {
	var wfxwbh = $('#wfxwbh').val().toUpperCase();
	if (wfxwbh != null && wfxwbh != "") {
		$.post(basePath + '/zfba/wfxw/checkCode', {
					wfxwbh: wfxwbh
				},
				function (result) {
					if (result.code == '0') {
						var mydata = result.total;
						//存在
						if (mydata > 0) {
							layer.msg("编号重复请重新填写");
							$('#wfxwbh').val("");
							$('#greentext').html("<font color='red' id='greentext'>保证编码唯一</font>");
						} else {
							$('#wfxwbh').val(wfxwbh);
							$('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
						}
					}
				}, 'json');
	}
}
	function submitForm() {
		$("#saveWfxwBtn").click();
	}
	//关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<body>
	<form id="fm" class="layui-form" action="">
		<input name="filepath" id="filepath"  type="hidden" />
		<table class="layui-table" style="width: 99%;" lay-skin="nob">
			<tr>
				<td style="text-align:right;"><nobr>违法行为参数ID:</nobr></td>
				<td><input name="pwfxwcsid" id="pwfxwcsid"  class="layui-input layui-bg-gray" readonly="readonly" value="<%=pwfxwcsid%>"/></td>
				<td style="text-align:right;"><font class="myred">*</font>案件登记案件大类:</td>
				<td>
					<select name="ajdjajdl" id="ajdjajdl" lay-verify="required"></select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><font class="myred">*</font>违法行为编号:</td>
				<td><input name="wfxwbh" id="wfxwbh"  class="layui-input" lay-verify="required"/></td>
				<td>
				<%--	<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
						<i class="layui-icon">&#xe6b2;</i>验证
					</button>--%>
					<font color="red" id="greentext">保证编码唯一</font>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>违法行为描述:</nobr></td>
				<td colspan="3"><textarea class="layui-textarea" id="wfxwms" name="wfxwms"
				rows="5"  data-options="required:false,validType:'length[0,2000]'"></textarea></td>
			</tr>


			<tr>
				<td style="text-align:right;"><nobr>违反法规:</nobr></td>
				<td><input name="wfxwwffg" id="wfxwwffg" class="layui-input"/></td>
				<td style="text-align:right;"><nobr>违反条款:</nobr></td>
				<td><input id="wfxwwftk" name="wfxwwftk" class="layui-input"/></td>
			</tr>

			<tr>
				<td style="text-align:right;"><nobr>违反条款内容:</nobr></td>
				<td><input name="wfxwwftknr" id="wfxwwftknr"  class="layui-input"/></td>
				<td style="text-align:right;"><nobr>处罚法规:</nobr></td>
				<td><input id="wfxwcffg" name="wfxwcffg" class="layui-input"/></td>
			</tr>

			<tr>
				<td style="text-align:right;"><nobr>处罚法规条款:</nobr></td>
				<td colspan="3"><input id="wfxwcffgtk" name="wfxwcffgtk" class="layui-input"/></td>
			</tr>

			<tr>
				<td style="text-align:right;"><nobr>处罚法规条款内容:</nobr></td>
				<td colspan="3"><textarea class="layui-textarea" id="wfxwcffgtknr" name="wfxwcffgtknr"
				rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea></td>

			</tr>

			<tr>
				<td style="text-align:right;"><nobr>处罚内容:</nobr></td>
				<td colspan="3"><textarea class="layui-textarea" id="wfxwcfnr" name="wfxwcfnr"
				rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea></td>

			</tr>
			<tr>
				<td style="text-align:right;"><nobr>备注:</nobr></td>
				<td colspan="3"><textarea class="layui-textarea" id="wfxwbz" name="wfxwbz"
				rows="5"  data-options="required:false,validType:'length[0,200]'"></textarea>
				</td>
			</tr>
		</table>
		<div class="layui-form-item" style="display: none">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="saveWfxw"
						id="saveWfxwBtn">保存</button>
			</div>
		</div>
	</form>
</body>
</html>