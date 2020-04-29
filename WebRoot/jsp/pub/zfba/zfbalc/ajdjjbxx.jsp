<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>案件受理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
$(function() {
	   v_ajdjajly= $('#ajdjajly').combobox({
	    	data : v_ajdjajly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		if ($('#ajdjid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zfba/ajdj/queryAjdjDTO', {
				ajdjid : "<%=v_ajdjid%>"
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

</script>
</head>
<body style="overflow-x:hidden;">
	<form id="ajDetail">
	  <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>">
		<sicp3:groupbox title="案件详细内容">	
        	<table class="table" style="width: 98%;background-color:#ededed;">
        		<tr>
       		    	<td width="15%"></td>
       		     	<td width="35%"></td>
       		     	<td width="15%"></td>
       		     	<td width="35%"></td>
       		   	</tr>
				<tr>
					<td style="text-align:right;"><nobr>案件登记编号:</nobr></td>
					<td><input id="ajdjbh" name="ajdjbh" style="width: 200px;"  class="input_readonly" readonly="readonly"/></td>						
					<td style="text-align:right;"><nobr>企业代码:</nobr></td>
					<td><input id="comdm" name="comdm" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>						
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>企业名称:</nobr></td>
					<td colspan="3"><input id="commc" name="commc" style="width: 790px"  class="input_readonly" readonly="readonly"/></td>		
				</tr>					
				<tr>
					<td style="text-align:right;"><nobr>企业地址:</nobr></td>
					<td colspan="3"><input id="comdz" name="comdz" style="width: 790px"  class="input_readonly" readonly="readonly"/></td>		
				</tr>
				<tr>		
					<td style="text-align:right;"><nobr>企业法人/业主:</nobr></td>
					<td><input id="comfrhyz" name="comfrhyz" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>						
					<td style="text-align:right;"><nobr>企业法人/业主身份证号:</nobr></td>
					<td><input id="comfrsfzh" name="comfrsfzh" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>			
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>联系电话:</nobr></td>
					<td><input id="comyddh" name="comyddh" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>									
					<td style="text-align:right;"><nobr>企业邮政编码:</nobr></td>
					<td><input id="comyzbm" name="comyzbm" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>			
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>案发时间:</nobr></td>
					<td><input id="ajdjafsj" name="ajdjafsj" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>									
					<td style="text-align:right;"><nobr>案由:</nobr></td>
					<td><input id="ajdjay" name="ajdjay" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>			
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr> 案件来源:</nobr></td>
					<td colspan="3"><input id="ajdjajly" name="ajdjajly" style="width: 200px"  class="input_readonly" readonly="readonly"/></td>									
				</tr>
				<tr>						
					<td style="text-align:right;">案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等):</td>
					<td colspan="3">
						<textarea class="easyui-validatebox" id="ajdjjbqk" name="ajdjjbqk" style="width: 790px;" 
						 rows="5"  class="input_readonly" readonly="readonly"></textarea>
					</td>			
				</tr>					
			</table>
        </sicp3:groupbox>
	</form>
</body>
</html>