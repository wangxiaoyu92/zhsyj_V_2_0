<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_pdbsxjsrid = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("pdbsxjsrid")),"utf-8");
	String v_jsclyj= URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("jsclyj")),"utf-8");
	String v_dokind = StringHelper.showNull2Empty(request.getParameter("dokind"));
	String v_yiyueOrHuifu="已阅意见";
	String v_saveBtn="已阅";
	
	if (v_dokind!=null && "huifu".equalsIgnoreCase(v_dokind)){
		v_yiyueOrHuifu="回复";
		v_saveBtn="回复";
	}
%>
<!DOCTYPE html>
<html>
<head>

<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	$("#textarea").val("<%=v_jsclyj%>");
});///////////////////////////////////

/**
 * 保存
 */
function mysave(){
		var url= basePath+'/pub/pub/saveBaoqingchulido?dokind=<%=v_dokind%>';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条

          $('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				var isValid = $(this).form('validate'); 
				if(!isValid){
					// 如果表单是无效的则隐藏进度条
					parent.$.messager.progress('close');	 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$("#saveBtn").linkbutton('disable');			 		
			 		alert("保存成功！");
			 		window.close();
              	} else {
              		alert("保存失败：" + result.msg);
                }
	        }    
		});
}

</script>
</head>
<body>
<form id="myform" method="post">
	<div id="cc" class="easyui-layout" style="width:790px;height: 590px;" fit="true">
	<form id="myform" method="post">
		<div region="center" style="overflow: false;" border="false" >
		  <input type="hidden" id="pdbsxjsrid" name="pdbsxjsrid" value="<%=v_pdbsxjsrid%>"/>
		  
		  </br>
		  <table>
		    <tr>
		      <td><%=v_yiyueOrHuifu%></td>
		      <td colspan="3">
				<textarea  id="jsclyj" 
				 name="jsclyj" style="width: 620px;vetical-align:top;float:left;" 
				 rows="10" data-options="required:false">				 
				 </textarea>		      
		      </td>	      
		    </tr>	
		  </table>

		  </br>
		  <div style="height:30px;float:right;" >
	           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
	             onclick="mysave()"data-options="iconCls:'icon-save'"><%=v_saveBtn %></a>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" 
	              onclick="javascript:window.close();"
	              data-options="iconCls:'icon-back'">关闭</a>	
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   	    
		  </div>
		</div>  
	</form>
	</div>
</body>
</html>