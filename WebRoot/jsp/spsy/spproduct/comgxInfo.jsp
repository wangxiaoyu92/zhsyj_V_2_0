<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 客户企业id
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	// 关系id
	String v_gxid = StringHelper.showNull2Empty(request.getParameter("gxid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>客户关系页面</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);
	//下拉框列表
	var mygrid;
	$(function() {
	    if ($('#gxid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/spsy/spproduct/queryComDto', {
				gxid : $('#gxid').val()
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

			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
		}
	});
// 关闭窗口
function close(){
	parent.$("#"+sy.getDialogId()).dialog("close");
};
</script>
</head>
<body>
<div class="easyui-layout" fit="true">
<div region="center" style="overflow: true;" border="false">
	<input id="gxid" name="gxid" type="hidden" value="<%=v_gxid%>"/>
	<form id="comgxfm" name="comgxfm" method="post">
		<input id="comid" name="comid" type="hidden" value="<%=comid%>"/>
   		<table class="table" style="width: 900px;">
			<tr>
		    	<td width="15%"></td>
		     	<td width="35%"></td>
		     	<td width="15%"></td>
		     	<td width="35%"></td>
		   	</tr>
			<tr>
				<td style="text-align:right;"><nobr>企业名称:</nobr></td>
				<td><input id="commc" name="commc" style="width: 200px;"/></td>						
				<td style="text-align:right;"><nobr>企业法人或业主:</nobr></td>
				<td><input id="comfrhyz" name="comfrhyz" style="width: 200px"/></td>						
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>产品名称:</nobr></td>
				<td><input id="proname" name="proname" style="width: 200px;"/></td>						
				<td style="text-align:right;"><nobr>产品种类:</nobr></td>
				<td><input id="prozlstr" name="prozlstr" style="width: 200px"/></td>						
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>包装规格:</nobr></td>
				<td><input id="probzgg" name="probzgg" style="width: 200px;"/></td>						
				<td style="text-align:right;"><nobr>规格型号:</nobr></td>
				<td><input id="progg" name="progg" style="width: 200px"/></td>						
			</tr>
			<tr>		
				<td style="text-align:right;"><nobr>联系电话:</nobr></td>
				<td><input id="comyddh" name="comyddh" style="width: 200px"/></td>						
				<td style="text-align:right;"><nobr>企业类别:</nobr></td>
				<td><input id="comdaleistr" name="comdaleistr" style="width: 200px"/></td>			
			</tr>
			<tr>						
				<td style="text-align:right;"><nobr>供销关系:</nobr></td>
				<td><input id="comgxlxstr" name="comgxlxstr" style="width: 200px"/></td>									
				<td style="text-align:right;"><nobr>关系建立时间:</nobr></td>
				<td><input id="comgxtime" name="comgxtime" style="width: 200px"/></td>			
			</tr>
			<tr>
				<td style="text-align:right;" ><nobr>企业地址:</nobr></td>
				<td colspan="3"><input id="comdz" name="comdz" style="width: 650px"/></td>		
			</tr>
			<tr>
				<td colspan="4" style="height: 50px;" >
			    	<div align="right">
						<a href="javascript:close()" class="easyui-linkbutton"
							iconCls="icon-back"> 关闭 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					</div>														     
			  	</td>
			</tr>
		</table>
   </form>
</div>
</div>
</body>
</html>