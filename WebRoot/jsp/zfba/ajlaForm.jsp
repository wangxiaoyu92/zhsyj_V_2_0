<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>

<!DOCTYPE html>
<html>
<head>
<title>案件</title>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

//选择案件
function myselectaj(){
	var url = basePath + 'pub/pub/selectajIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择',
			param : {
				singleSelect : "true",
				ajzt : "0",
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
		      	$("#commc1").val(myrow.commc); //公司名称   
			    $("#anid").val(myrow.ajdjid);//案件登记的id
			    $("#ajdjay").val(myrow.ajdjay);//案由
			    $("#ajdjafsj").val(myrow.ajdjafsj);//案发时间        
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});
}
	
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
		var v_retStr = sy.getWinRet(dialogID);
		var v_cbrmc="";
		var v_cbrid = 0;
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
		    	var myrow=v_retStr[k];
		      	if (v_cbrmc=="") {
		    		v_cbrmc=myrow.username;
		    	  	v_cbrid=myrow.userid;
		      	}else{
		    		v_cbrmc+=","+myrow.username;
		    	  	v_cbrid+=","+myrow.userid;	    	  
		      	}
	    	}
	    }  
	    $("#zfryzy").val(v_cbrmc); //组员
	    $("#zfryzyid").val(v_cbrid);
	    sy.removeWinRet(dialogID);//不可缺少
	}); 
} 
	 // 保存chgengbanren
	function saveAjcbr() {
			$('#ajdjAddDlgfm').form('submit',{
			url: basePath + '/zfba/ajla/saveUpdateAjla',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#ajdjAddDlg').dialog('close');
						$('#mygrid').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	} 
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
 
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		$pjq.messager.progress();			
		$('#ajdjAddDlgfm').form('submit',{
			url:  basePath + '/zfba/ajla/saveUpdateAjla',
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
</script>
</head>
<body>
	<div id="ajdjAddDlg" style="width:800px;height:450px;padding:10px 10px;" >
		<form id="ajdjAddDlgfm" method="post">
			<sicp3:groupbox title="案件立案">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>案件:</nobr></td>
						<td colspan="3"><input id="commc1" name="commc"  class="easyui-validatebox" 
							data-options="required:true"  readonly="readonly" style="width: 300px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectaj()">选择案件 </a>
							<input id="anid" name="ajdjid" type="hidden"
								style="width: 300px"/>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>案由:</nobr></td>
						<td colspan="3"><input id="ajdjay" name="ajdjay" style="width: 300px"/>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>案发时间:</nobr></td>
						<td colspan="3"><input id="ajdjafsj" name="ajdjafsj" readonly="readonly"
							style="width: 300px"/>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>选择承办人(组长):</nobr></td>
						<td colspan="3"><input id="zfryzz" name="zfryzz"  class="easyui-validatebox" 
							data-options="required:true"   readonly="readonly"
							style="width: 300px"/>
							<input id="zfryzzid" name="zfryzzid" type="hidden"
							style="width: 300px"/> 
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="choose2()"> 选择 </a>
							</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>选择承办人(组员):</nobr></td>
						<td colspan="3"><input id="zfryzy" name="zfryzy"  class="easyui-validatebox" 
							data-options="required:true"    readonly="readonly" style="width: 300px"/>
							<input id="zfryzyid" name="zfryzyid" type="hidden"
								style="width: 300px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="choose()"> 选择 </a>
						</td>
					</tr>
			</sicp3:groupbox>
		</form>
	</div>
</body>
</html>