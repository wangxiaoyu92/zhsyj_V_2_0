<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_jyjcjcbzbid = StringHelper.showNull2Empty(request.getParameter("jyjcjcbzbid"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>检验检测检测标准</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
		var grid;
		var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
		var v_BZSTATE=<%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
		$(function() {
			CKEDITOR.replace('bzcontent', { height: '200px', width: '620px' });
			$('#jyjcbzfenlei').combotree({
				url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjcbzfenlei',
				required: true
			});
			$('#jyjczbfenlei').combotree({
				url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjczbfenlei',
				required: true
			});
			$('#jyjcicsfenlei').combotree({
				url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjcicsfenlei',
				required: true
			});
			$('#jyjcbzstate').combobox({
				data : v_BZSTATE,
				valueField : 'id',
				textField : 'text',
				required : false,
				editable : false,
				panelHeight : 'auto'
			});
			$('#sfyx').combobox({
				data : v_SFYX,
				valueField : 'id',
				textField : 'text',
				required : false,
				editable : false,
				panelHeight : 'auto'
			});
			if ($('#jyjcjcbzbid').val().length > 0) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
				$.post(basePath + 'jyjc/queryJyjcjcbzbDTO',{
							jyjcjcbzbid : $('#jyjcjcbzbid').val()
						},
						function(result) {
							if (result.code=='0') {
								var mydata = result.data;
								$('form').form('load', mydata);
							} else {
								parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
							}
							parent.$.messager.progress('close');
						}, 'json');

				if('<%=op%>' == 'view'){
					$('form :input').addClass('input_readonly');
					$('form :input').attr('readonly','readonly');
					$('.Wdate').attr('disabled',true);
					$('.easyui-combotree').combotree({ disabled: true });
					$('.easyui-datebox').datebox({ disabled: true });
					$('#sfyx').combobox({ disabled: true });
					$('#jyjcbzstate').combobox({ disabled: true });
				}
			}
		});
		// 刷新
		function refresh(){
			parent.window.refresh();
		}

		// 保存检验检测项目
		var saveJyjcbz = function($dialog, $grid, $pjq) {
			var url = basePath + 'jyjc/saveJyjcbz';

			//提交一个有效并且避免重复提交的表单
			$pjq.messager.progress();	// 显示进度条
			$('#fm').form('submit',{
				url: url,
				onSubmit: function(){
					var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
					if(!isValid){
						$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条
					}
					return isValid;
				},
				success: function(result){
					$pjq.messager.progress('close');// 隐藏进度条
					result = $.parseJSON(result);
					if (result.code=='0'){
						$pjq.messager.alert('提示','保存成功！','info',function(){
							$grid.datagrid('load');
							$dialog.dialog('destroy');
						});
					} else {
						$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
					}
				}
			});
		};

		// 关闭窗口
		var closeWindow = function($dialog, $pjq){
			$dialog.dialog('destroy');
		};

	</script>
</head>

<body>
<div class="easyui-layout" fit="true">
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
		<sicp3:groupbox title="检验检测项目">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>检验检测检测标准id:</nobr></td>
					<td><input id="jyjcjcbzbid" name="jyjcjcbzbid" style="width: 200px" value="<%=v_jyjcjcbzbid%>" readonly="readonly" class="input_readonly"/></td>
					<td style="text-align:right;"><nobr>kk标准分类:</nobr></td>
					<td><input id="jyjcbzfenlei" name="jyjcbzfenlei" style="width: 200px" class="easyui-combotree"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>标准编号:</nobr></td>
					<td><input id="bzbh" name="bzbh" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>标准状态:</nobr></td>
					<td><input id="jyjcbzstate" name="jyjcbzstate" style="width: 200px" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>英文名称:</nobr></td>
					<td><input id="engname" name="engname" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>中文名称:</nobr></td>
					<td><input id="chinaname" name="chinaname" style="width: 200px" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>替代情况:</nobr></td>
					<td><input id="tdqk" name="tdqk" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>中标分类:</nobr></td>
					<td><input id="jyjczbfenlei" name="jyjczbfenlei" style="width: 200px" class="easyui-combotree"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>ICS分类:</nobr></td>
					<td><input id="jyjcicsfenlei" name="jyjcicsfenlei" style="width: 200px" class="easyui-combotree"/></td>
					<td style="text-align:right;"><nobr>UDC分类:</nobr></td>
					<td><input id="jyjcudcfenlei" name="jyjcudcfenlei" style="width: 200px" class="easyui-combotree"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>发布部门:</nobr></td>
					<td><input id="fbbm" name="fbbm" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>发布日期:</nobr></td>
					<td><input id="fbrq" name="fbrq" style="width: 200px" class="easyui-datebox" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>实施日期:</nobr></td>
					<td><input id="ssrq" name="ssrq" style="width: 200px" class="easyui-datebox" data-options="required:true"/></td>
					<td style="text-align:right;"><nobr>作废日期:</nobr></td>
					<td><input id="zfrq" name="zfrq" style="width: 200px" class="easyui-datebox" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>首发日期:</nobr></td>
					<td><input id="sfrq" name="sfrq" style="width: 200px" class="easyui-datebox" data-options="required:true"/></td>
					<td style="text-align:right;"><nobr>复审日期:</nobr></td>
					<td><input id="fsrq" name="fsrq" style="width: 200px" class="easyui-datebox" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>提出单位:</nobr></td>
					<td><input id="tcdw" name="tcdw" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>出口单位:</nobr></td>
					<td><input id="gkdw" name="gkdw" style="width: 200px" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>主管部门:</nobr></td>
					<td><input id="zgbm" name="zgbm" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>起草单位:</nobr></td>
					<td><input id="qcdw" name="qcdw" style="width: 200px" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>起草人:</nobr></td>
					<td><input id="rcr" name="rcr" style="width: 200px" class="easyui-validatebox"/></td>
					<td style="text-align:right;"><nobr>是否有效:</nobr></td>
					<td><input id="sfyx" name="sfyx" style="width: 200px"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>操作员:</nobr></td>
					<td><input id="aae011" name="aae011" style="width: 200px" readonly="readonly" class="input_readonly"/></td>
					<td style="text-align:right;"><nobr>操作时间:</nobr></td>
					<td><input id="aae036" name="aae036" style="width: 200px" readonly="readonly" class="input_readonly"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>标准内容:</nobr></td>
					<td colspan="3">
						<div style="height: 10px">
							<textarea class="ckeditor" id="bzcontent" name="bzcontent" style="height: 20px"></textarea>
						</div>
					</td>
				</tr>
			</table>
		</sicp3:groupbox>
	</form>
</div>
</body>
</html>