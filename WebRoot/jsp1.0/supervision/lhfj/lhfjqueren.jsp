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
	// 操作类型  0自动生成1手动生成
	String v_caozuokind = StringHelper.showNull2Empty(request.getParameter("caozuokind"));
	
%>
<!DOCTYPE html>
<html>
<head>

<title>量化分级统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">

//量化分级年度评定等级
var v_LHFJNDPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;
	

$(function() {
		//年度是否评定等级
		$('#lhfjndpddj').combobox({
			data:v_LHFJNDPDDJ,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});		
	
});////////////////////////////////////////	
	
	function refresh(){
		parent.window.refresh();	
	} 	
	
   function queding(){
	   var v_lhfjndpddj="";
	   var v_b_caozuokind="<%=v_caozuokind%>";
	   if ("1"==v_b_caozuokind){
		   v_lhfjndpddj=$("#lhfjndpddj").combobox("getValue");
		   if (v_lhfjndpddj==null){
			   alert("请选择 量化分级年度评定等级 ");
			   return false;
		   }
	   }
	   var v_sfcxsc='0';
	   if ($('#sfcxsc').attr('checked')) {
	   //if (document.getElementById("sfcxsc").checked){
		   v_sfcxsc='1';
	   };
	   //var v_ret=[{"lhfjndpddj":"\""+v_lhfjndpddj+"\"","sfcxsc":"\""+v_sfcxsc+"\""}];
	   //var retjson=[{"\"lhfjndpddj\"":"1","\"sfcxsc\"":"2"}];
	   var v_retvalue = new Object(); 
	   v_retvalue.lhfjndpddj=v_lhfjndpddj;
	   v_retvalue.sfcxsc=v_sfcxsc;
	   
	   //var retjson = JSON.stringify(v_retvalue);//
		   
	   sy.setWinRet(v_retvalue);
	   parent.$("#"+sy.getDialogId()).dialog("close");
	   }
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true" style="border: none">  
        <div region="center" style="overflow: false;border: none">
       		<table style="border: none;">
       		    <tr>
       		      <td colspan="2">&nbsp;</td>
       		    </tr>
       		 <% if ("1".equals(v_caozuokind)){ %>  
       		    <tr>
       		       <td>量化分级年度评定等级</td>
       		       <td><input id="lhfjndpddj" name="lhfjndpddj" style="width: 100px" /></td>
       		    </tr>
       		 <%} %>   
       		    <tr>
       		       <td colspan="2" style="text-align: center;" ><label><input name="sfcxsc" id="sfcxsc" type="checkbox" value="" />如果存在是否重新生成，选中会先删除再生成 </label> </td>
       		    </tr>
       		    <tr><td colspan="2">&nbsp;</td></tr>	
       		    <tr><td colspan="2" style="text-align: center;" >
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="queding()"> 确定</a>       		    
       		    </td></tr>     		    
			</table>
        </div>
                
    </div>   
</body>
</html>