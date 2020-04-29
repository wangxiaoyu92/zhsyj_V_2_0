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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	System.out.println("op"+op);
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	if ($('#ajdjid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/zfba/ajdj/queryAjcbr', {
			ajdjid : $('#ajdjid').val()
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

	//选择承办人
function choose2(){
    var url = basePath + 'zfba/ajla/zfPubIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
		    	var myrow = v_retStr[k];
		      	$("#zfryzz").val(myrow.username);
	      		$("#zfryzzid").val(myrow.userid);        
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});   
}

//选择承办人
function choose(){
	var url = basePath + 'zfba/ajla/zfPubIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_cbrmc = "";
		var v_cbrid = 0;
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
	    for (var k = 0;k <= v_retStr.length - 1; k++){
	      var myrow = v_retStr[k];
	      if (v_cbrmc == "") {
	    	  v_cbrmc = myrow.username;
	    	  v_cbrid = myrow.userid;
	      }else{
	    	  v_cbrmc += ","+myrow.username;
	    	  v_cbrid += ","+myrow.userid;	    	  
	      }
	    }}  
	    $("#zfryzy").val(v_cbrmc); //组员
	    $("#zfryzyid").val(v_cbrid);
	    sy.removeWinRet(dialogID);//不可缺少
	});   
} 
// 保存 
var submitForm = function($dialog, $grid, $pjq) {
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$pjq.messager.progress();	// 显示进度条
	$('#ajdjAddDlgfm').form('submit',{
		url: basePath + '/zfba/ajdj/saveAjcbr',
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

//从单位信息表中读取
function myselectcom(){
    var url = basePath + 'pub/selectcom/selectcomIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
		    	var myrow = v_retStr[k];
		      	$("#commc").val(myrow.commc); //公司名称   
      			$("#comdm").val(myrow.comdm); //公司代码          
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});   
}

// 关闭窗口
var closeWindow = function($dialog, $pjq){
   	$dialog.dialog('destroy');
};

</script>
</head>
<body>
	<form id="ajdjAddDlgfm" name="ajdjAddDlgfm" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
   		<table class="table" style="width: 99%;">
	   		<tr>
				<td style="text-align:right;"><nobr>选择承办人(组长):</nobr></td>
				<td colspan="3">
					<input id="zfryzz" name="zfryzz"  class="easyui-validatebox"
						data-options="required:true" readonly="readonly" style="width: 300px"/>
					<input id="zfryzzid" name="zfryzzid" type="hidden" style="width: 300px"/> 
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="choose2()"> 选择 </a>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>选择承办人(组员):</nobr></td>
				<td colspan="3"><input id="zfryzy" name="zfryzy"  class="easyui-validatebox" 
					data-options="required:true"    readonly="readonly" style="width: 300px"/>
					<input id="zfryzyid" name="zfryzyid" type="hidden" style="width: 300px"/>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="choose()"> 选择 </a>
				</td>
			</tr>			
		</table>
	</form>
</body>
</html>