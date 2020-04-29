<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
%>
<!DOCTYPE html>
<html>
<head>
<title>文书模板</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

function ajaxMc(){
	var v_zfwsmbmc=$('#zfwsmbmc').val();
	if(v_zfwsmbmc!=null || v_zfwsmbmc !='' || v_zfwsmbmc.length!=0 ){
		$.post(basePath + 'pub/wsgldy/queryZfwsmobanmclist',{
				zfwsmbmc:$('#zfwsmbmc').val() 
				},
				function(result) { 
					if ('ok'==result) {	
						$('#saveBtn').linkbutton('enable');
						$('#msg').html('模板名称可用').css({'color':'black'}); 
						return true;
					} else {
						$('#saveBtn').linkbutton('disable');
						$('#msg').html('名称不可用，请重新命名').css({'color':'red'});
						$('#zfwsmbmc').focus();
						return false;
					}
				},'json');
	}
}

function mysave(){
	var v_zfwsmbmc=$('#zfwsmbmc').val();
	if (v_zfwsmbmc==null || v_zfwsmbmc=="" || v_zfwsmbmc.length== 0){
		parent.$.messager.alert('提示','执法文书模板名称 不能为空');
		return false;
	}
	
	var url= basePath+'pub/wsgldy/saveZfwsmoban';

	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
     parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
	
	$('#myform').form('submit',{
		url: url,
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
        },
        success: function(result){
        	parent.$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$('#saveBtn').linkbutton('disable');
		 		alert('保存为文书模板成功！'); 	                        	                     
             	} else {
             	alert('保存为文书模板失败！'); 
             	//	parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
               }
        }    
	});
}

var closeWindow = function($dialog){
	parent.$("#"+sy.getDialogId()).dialog("close"); 
};
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myform" method="post" >
		  <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		  <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>	    
	        <div region="center" style="overflow: false;" border="false">
	        	<sicp3:groupbox title="">
	        	    <div align="right" style="height: 200px;">
		        		<table class="table" style="width: 98%;">
		        		    <tr>
								<td style="text-align:right;"><nobr>执法文书模板名称:</nobr></td>
								<td colspan="3"><input id="zfwsmbmc" name="zfwsmbmc" style="width: 350px" 
								class="easyui-validatebox" data-options="required:true,validType:'length[0,100]'" onmousemove="ajaxMc()"/>
								<span id="msg"></span>
								</td>		
		        		    </tr>        		
						</table>
					</div>
					
			  	  <div align="right">
			           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
			              data-options="iconCls:'icon-save'">保存为文书模板</a>
				  	      &nbsp;&nbsp;&nbsp;&nbsp;
			           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeWindow();"
			              data-options="iconCls:'icon-back'">关闭</a>	
			              &nbsp;&nbsp;&nbsp;&nbsp;				  	  
			  	  </div>						
		        </sicp3:groupbox>
		        
	        </div>
        </form>         
    </div>   
		    

</body>
</html>