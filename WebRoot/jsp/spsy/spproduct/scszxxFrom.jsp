<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次号
	String cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch"));
	// 产品生产生长信息id
	String szgcid = StringHelper.showNull2Empty(request.getParameter("szgcid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>添加产品生产生长信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);
$(function() {
	    
    if ($('#szgcid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/spsy/spproduct/queryProductScszxxDto', {
			szgcid : $('#szgcid').val()
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
	}
});
// 保存 
var submitForm = function() {
	
	var url = basePath + '/spsy/spproduct/saveProductScszxx';

	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#productscszfm').form('submit',{
		url: url,
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
        },
        success: function(result){
        	$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$.messager.alert('提示','保存成功！','info',function(){
					 sy.setWinRet(s);
					 closeWindow(); 
        		}); 	                        	                     
             	} else {
             		$.messager.alert('提示','保存失败：'+result.msg,'error');
               }
        }    
	});
};

// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
}

</script>
</head>
<body>
	<form id="productscszfm" name="productscszfm" method="post">
		<input id="szgcid" name="szgcid" type="hidden" value="<%=szgcid%>"/>
	  	<input id="proid" name="proid" type="hidden" value="<%=proid%>"/>
	  	<input id="cppcpch" name="cppcpch" type="hidden" value="<%=cppcpch%>"/>
		<table class="table" style="width: 600px;">
			<tr>
				<td width="29%"></td>
				<td width="69%"></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>操作人:</nobr></td>
				<td><input id="szgcczr" name="szgcczr" style="width: 300px;"
					class="easyui-validatebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>操作内容:</nobr></td>
				<td><textarea class="easyui-validatebox bbtextarea" id="szgccznr"
						name="szgccznr" style="width: 300px;height: 60px;"
						data-options="required:true"></textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>操作日期:</nobr></td>
				<td><input name="szgcczrq" id="szgcczrq" class="easyui-validatebox"
					data-options="required:true" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 300px;"></td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>备注:</nobr></td>
				<td><textarea class="easyui-validatebox bbtextarea" id="szgcbz"
						name="szgcbz" style="width: 300px;height: 40px;"
						data-options="required:true"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 50px;" >
					<div align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-save" onclick="submitForm()"> 保存 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-back" onclick="closeWindow()"> 取消 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>