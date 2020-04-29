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
	String lqledgersalesid = StringHelper.showNull2Empty(request.getParameter("lqledgersalesid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>台账信息录入</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
$(function(){  
 if ($('#lqledgersalesid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post( basePath+'spsy/productin/salestzglDTO', {
				lqledgersalesid : $('#lqledgersalesid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;	
					$('#fm').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
				parent.$.messager.progress('close');
			}, 'json'); 
		} 
}) ; 
// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
}

</script>
</head>
<body>
	<form id="fm" name="fm" method="post">
	  <input id="lqledgersalesid" name="lqledgersalesid" value="<%=lqledgersalesid%>" type="hidden" />
       		<table class="table" style="width: 600px;"> 
				<tr>
					<td style="text-align:right;" ><nobr>商品名称:</nobr></td>
					<td><input id="lgsproname" name="lgsproname" style="width: 250px" 
						class="input_readonly" readonly="readonly"/>
					<input id="lgsproid" name="lgsproid" type="hidden" style="width: 250px"/></td>
					<td> 					
					</td>		
				</tr>	
				<tr>
					<td style="text-align:right;" ><nobr>商品条码:</nobr></td>
					<td><input id="lgsprosptm" name="lgsprosptm" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>	
					<td></td>		
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>生产日期:</nobr></td>
					<td><input name="lgsproscrq" id="lgsproscrq"
						class="input_readonly" readonly="readonly"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						style="width: 250px;"></td>		
					<td></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>保质期:</nobr></td>
					<td><input name="lgsprobzq" id="lgsprobzq" style="width: 250px;"
						class="input_readonly" readonly="readonly">
						<input id="lgsprobzqdwcode" name="lgsprobzqdwcode" type="hidden" /></td>
					<td><input id="lgprobzqdwmc" name="lgsprobzqdwmc" style="border-style:none"/></td>			
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>规格:</nobr></td>
					<td><input name="lgsprogg" id="lgsprogg" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td><nobr>如260g</nobr></td>		
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>包装规格:</nobr></td>
					<td><input name="lgsprobzgg" id="lgsprobzgg" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>	
					<td><nobr>如1*20</nobr></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>生产厂家:</nobr></td>
					<td><input name="lgsprosccj" id="lgsprosccj" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td></td>			
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>产地/厂家地址:</nobr></td>
					<td><input name="lgsprocjdz" id="lgsprocjdz" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>	
					<td></td>		
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>商品批号批次:</nobr></td>
					<td><input name="lgspropc" id="lgspropc" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td></td>			
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>库存数量:</nobr></td>
					<td><input name=lgsprosysl id="lgsprosysl" style="width: 250px;"
						class="input_readonly" readonly="readonly"></td>
					<td><input id="lgsprojydwmc2" name="lgsprojydwmc2" style="border-style:none"/></td>		
				</tr> 
				<tr>
					<td width="25%" style="text-align:right;"><nobr>企业名称:</nobr></td>
					<td width="50%"><input id="lgstocommc" name="lgstocommc" style="width: 250px;" 
						class="input_readonly" readonly="readonly"/>
						<input id="lgstocomid" name="lgstocomid"  type="hidden"  /> </td>
					<td width="25%"> 				
					</td>						
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>企业资质证明编号:</nobr></td>
					<td><input id="lgstocomzjhm" name="lgstocomzjhm" style="width: 250px"
						 class="input_readonly" readonly="readonly"/></td>	
					 <td></td>						
				</tr>
				<!-- <tr>
					<td style="text-align:right;"><nobr>企业法定代表人:</nobr></td>
					<td><input id="comfrhyz" name="comfrhyz" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>企业电话:</nobr></td>
					<td><input id="comyddh" name="comyddh" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr> -->
				<tr>
					<td style="text-align:right;"><nobr>企业地址:</nobr></td>
					<td><input id="lgsprosccj" name="comdz" style="width: 250px"
						class="input_readonly" readonly="readonly"/></td>
					<td></td>							
				</tr> 
				<tr>
					<td style="text-align:right;" ><nobr>销货日期:</nobr></td>
					<td><input name="lgsprojyrq" id="lgsprojyrq"  class="Wdate easyui-validatebox"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						style="width: 250px;"  disabled="disabled" ></td>	
					<td></td>	
				</tr>
				<tr>
					<td style="text-align:right;" ><nobr>销货数量:</nobr></td>
					<td><input name="lgsprojysl" id="lgsprojysl" style="width: 250px;" 
						class="easyui-validatebox" data-options="required:true" disabled="disabled">
						<input id="lgsprojydwcode" name="lgsprojydwcode" type="hidden"/></td>	
					<td><input id="lgsprojydwmc" name="lgsprojydwmc" style="border-style:none"/></td>	
				</tr>
				<tr>						
					<td style="text-align:right;">商品溯源码:</td>
					<td>
						<textarea id="lgsprocode" name="lgsprocode" style="width: 250px;" 
						 rows="5" disabled="disabled"></textarea>
					</td>
					<td style="text-align:left;">如有多个，请以逗号隔开</td>			
				</tr> 								
			</table>
   </form>
</body>
</html>