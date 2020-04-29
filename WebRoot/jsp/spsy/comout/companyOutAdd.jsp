<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>添加外部企业</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link href="../images/style.css" rel="stylesheet" type="text/css" />
<style>
#checkMessage {
   display:none;
}
</style>
<script type="text/javascript">
// 企业大类
var v_comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
// 企业供销商关系
var v_comghsorxhs=<%=SysmanageUtil.getAa10toJsonArray("COMGHSORXHS")%>;

var s = new Object();
s.type="ok";//设为空不刷新父页面
sy.setWinRet(s);

$(function(){
	   $('#comdalei').combobox({
	    	data : v_comdalei,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '150'
	    });
	   
	   $('#comghsorxhs').combobox({
	    	data : v_comghsorxhs,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });	   
	   
	//检验表单
	$("#myform").validationEngine({
		validationEventTriggers:"keyup blur", //will validate on keyup and blur
		promptPosition:"centerRight",//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
		prettySelect:true//,是否使用美化过的select
	 });
	
	if ($('#comid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + 'spsy/comout/queryQcompanyoutDTO', {
			comid : $('#comid').val()
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

//关闭并刷新父窗口
function closeAndRefreshWindow(){
	var s = new Object();
	s.type="ok";//设置返回值为ok就可以。//这里返回刷新父页面。
	sy.setWinRet(s);
	closeWindow();
} 
  
//关闭并刷新父窗口
function closeWindow(){      
	parent.$("#"+sy.getDialogId()).dialog("close");
} 


// 保存 
var submitForm = function() {
	var status=$("#myform").validationEngine("validate");
	if(status){//表单验证通过
		var url = basePath + 'spsy/comout/comoutAddSave';
	
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#myform').form('submit',{
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
	}
};

</script>
</head>
  
<body>
<h3 style="text-align:center">添加外部企业</h3>
<div class="content_wrap" >
	<form id="myform" method="post">
		<input id="comid" name="comid" type="hidden" value="<%=v_comid%>"/>
		<table width="100%" class="table" valign="top" align="center" border="1" >
			<tr>
         		<td style="text-align: right;">许可证号<span style="color:red"></span></td>
        		<td align="left">
					<input type="text" id="comxkzbh" name="comxkzbh" style="width:200px;"
						   class="validate[required] input-text"/>
         			<span style="color:red;font-size:12px">（营业执照号/生产许可证号/食品流通许可证/餐饮服务许可证号）</span>
         		</td>
    		</tr>
    		<tr id="checkMessage" >
    			<td></td>
    			<td><span style="color:red;">该许可证号已被使用！</span></td>
    		</tr>
			<tr>
         		<td class="title" width="20%" style="text-align: right;">企业名称</td>
         		<td align="left">
					<input type="text" id="commc" name="commc" style="width:200px;"/>
         		</td>
    		</tr>
    		<tr>
         		<td class="title" style="text-align: right;">法定代表人/负责人</td>
         		<td align="left">
					<input type="text" id="comfrhyz" name="comfrhyz" style="width:200px;"/>
         		</td>
    		</tr>
    		<tr>
         		<td class="title" style="text-align: right;">联系电话</td>
         		<td align="left">
    				<input type="text" id="comyddh" name="comyddh" style="width:200px;"
    					 class="easyui-validatebox" validtype="phoneAndMobile"/>
         		</td>
    		</tr>
    		<tr>
         		<td class="title" style="text-align: right;">厂家地址</td>
         		<td align="left">
         			<input type="text" id="comdz" name="comdz" style="width:200px;"
						   class="validate[required]  input-text"/>
         		</td>
    		</tr>
    		<tr>
         		<td class="title" style="text-align: right;">企业类型</td>
         		<td align="left">
         			<select name="comdalei" id="comdalei" style="width:200px;"></select>
         		</td>
    		</tr>
     		<tr>
         		<td class="title" style="text-align: right;">合作关系</td>
         		<td align="left">
		 			<select name="comghsorxhs" id="comghsorxhs" style="width:200px;"></select>
         		</td>
    		</tr>
 		</table>
        <p style="text-align:center">
        	<a href="#" id="saveBtn" class="easyui-linkbutton" onclick="submitForm();">保存数据</a>
          	&nbsp;&nbsp;
          	<a href="#" onClick="closeAndRefreshWindow()" class="easyui-linkbutton">关闭返回</a>
        </p>
	</form>
</div>
</body>
</html>